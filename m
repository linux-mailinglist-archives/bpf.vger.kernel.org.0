Return-Path: <bpf+bounces-3405-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B9873D195
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 16:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C959F1C208F1
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 14:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDAF63B5;
	Sun, 25 Jun 2023 14:56:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8D33D71
	for <bpf@vger.kernel.org>; Sun, 25 Jun 2023 14:56:58 +0000 (UTC)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C76719F
	for <bpf@vger.kernel.org>; Sun, 25 Jun 2023 07:56:57 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-262ec7b261bso252061a91.3
        for <bpf@vger.kernel.org>; Sun, 25 Jun 2023 07:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687705017; x=1690297017;
        h=subject:autocrypt:from:to:content-language:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=66I7FfgUGjgnuBgFM4U8BDQpWG8rTAp0J2q7WqNjVow=;
        b=Iz8tmDST3hN9jpXB8CPBwG0O/BQsncqyCqIGkYpllGu240t1QVxoE+WSGSwidbPyEY
         ljeWPtro3oRkm7SrvrvjKDnJDTSJdYIn9qlNrM6CT8qmRPK6UNm3CPxjeDoNhBUHTMUm
         qApyEYHG8LGRGK3JHa7KFjsEtODO6qr+vEwH6HQNxoSnydvARDfZDMiVZYYq5Fu4KNtU
         Gfu6h8D90hKFtyxaPbwbjQZ+R72mwl+c5MJX26/Vy+hbyfXYNhiKwOXK+439apJclqKL
         aUOHn+MNeyVtPmbvH3A0jF6wPgobBn2KUcAYb2sp3gxF/pHOyMbKj59KirLvD9f54HiF
         MMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687705017; x=1690297017;
        h=subject:autocrypt:from:to:content-language:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66I7FfgUGjgnuBgFM4U8BDQpWG8rTAp0J2q7WqNjVow=;
        b=MfyaD8BIJgqvEPaAZo18AHNWsa1e4NlUko0AVAwoUajM/aL+gxd7d0NbgPiV1meRHy
         Qlt2c25TqpCbOe0uee+KeUvsuV8AhLRVncjZLzrMKVyQYAlN+tekQvCfzHU86mnvKboL
         3ZIHT7bpyb4hAc8iYkj5qHhQ2EjNRPq9RtP3fSGajhS/TRHh0AuzhsD7vr1nl9lgxcBE
         m2Z4S78Jd+ryHNmxV92UfizCkiwj7qmiOYE60qQoo+FgP00xIdRklhsb5sBGVJqAxSXm
         FqBTh6KryWRLuYg9e8LCfGGCUdH5SDDsHMl/S0FPtHvxFs8M6Fzl7ggGRLJMUrP6gSxh
         5xxg==
X-Gm-Message-State: AC+VfDyp7OB3pj98GQVuUGdNtdCuXA6GPHRndGGOovJvNlULMk2BZoe1
	HqNgb2WF8iVnDSHWbmW9J+WpX2n5pBM=
X-Google-Smtp-Source: ACHHUZ4rXYHjxubo1FSQlwdfI1hKSBCY8eNUx03vvsL5wDj3Dgp1/C/hy+jUZhbslkwqE82y+O6lrA==
X-Received: by 2002:a17:90a:9910:b0:262:d1b5:3390 with SMTP id b16-20020a17090a991000b00262d1b53390mr3656753pjp.3.1687705016579;
        Sun, 25 Jun 2023 07:56:56 -0700 (PDT)
Received: from ?IPV6:2600:8800:7280:a54d::813? ([2600:8800:7280:a54d::813])
        by smtp.gmail.com with ESMTPSA id v8-20020a17090ad58800b00256a4d59bfasm4510323pju.23.2023.06.25.07.56.55
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 07:56:56 -0700 (PDT)
Message-ID: <5fac42d2-f62e-0652-8d49-c348affbd432@gmail.com>
Date: Sun, 25 Jun 2023 07:56:54 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: bpf@vger.kernel.org
From: Carlos Rodriguez-Fernandez <carlosrodrifernandez@gmail.com>
Autocrypt: addr=carlosrodrifernandez@gmail.com; keydata=
 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
Subject: Possible vs present number of cpus and propose for a new API function
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------9nt31RIcNs47u4yngZGQwYC0"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------9nt31RIcNs47u4yngZGQwYC0
Content-Type: multipart/mixed; boundary="------------3yVMgZjRO0wVuvQAanqrB07j";
 protected-headers="v1"
From: Carlos Rodriguez-Fernandez <carlosrodrifernandez@gmail.com>
To: bpf@vger.kernel.org
Message-ID: <5fac42d2-f62e-0652-8d49-c348affbd432@gmail.com>
Subject: Possible vs present number of cpus and propose for a new API function

--------------3yVMgZjRO0wVuvQAanqrB07j
Content-Type: multipart/mixed; boundary="------------qoKTcFio6MHc06mekOzKBOmM"

--------------qoKTcFio6MHc06mekOzKBOmM
Content-Type: multipart/alternative;
 boundary="------------3bCwoW7Gn0az8vWINP0tW3j8"

--------------3bCwoW7Gn0az8vWINP0tW3j8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgYWxsLA0KDQpUaGUgbGliYnBmIHRvb2wgY3B1ZnJlcSB1c2VzIHRoZSBBUEkgZnVuY3Rp
b24gbGliYnBmX251bV9wb3NzaWJsZV9jcHVzIA0KdG8gZ2V0IHRoZSBudW1iZXIgb2YgQ1BV
cyBhbmQgdGhlbiBpdGVyYXRlIG92ZXIgdGhlbSB0byBydW4gaXRzIA0KZnVuY3Rpb25hbGl0
eSwgZ2V0dGluZyB0aGUgaW5mb3JtYXRpb24gaXQgbmVlZHMgZnJvbSBzeXNmcy4gVGhlIHBy
b2JsZW0gDQppcyB0aGF0IHRoZSBjcHUgaW5mb3JtYXRpb24gaW4gc3lzZnMgDQp8L3N5cy9k
ZXZpY2VzL3N5c3RlbS9jcHUvY3B1IyN8YXBwZWFycyBvbmx5IGZvciB0aGUgInByZXNlbnQi
IGNwdXMsIG5vdCANCnRoZSAicG9zc2libGUiIGluIG15IHN5c3RlbS4NCg0KVGhpcyBpcyB0
aGUgZXJyb3I6DQoNCnxmYWlsZWQgdG8gb3BlbiANCicvc3lzL2RldmljZXMvc3lzdGVtL2Nw
dS9jcHUxMi9jcHVmcmVxL3NjYWxpbmdfY3VyX2ZyZXEnOiBObyBzdWNoIGZpbGUgDQpvciBk
aXJlY3RvcnkgZmFpbGVkIHRvIGluaXQgZnJlcXMgTXkgcG9zc2libGUgbnVtIG9mIGNwdXM6
IHx8Y2F0IC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L3Bvc3NpYmxlIDAtMzEgTXkgcHJlc2Vu
dCBudW0gb2YgY3B1czogY2F0IA0KL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvcHJlc2VudCAw
LTExIEZvciB3aGF0IEkgdW5kZXJzdGFuZCBpbiB0aGUgDQpkb2N1bWVudGF0aW9uIGhlcmUg
fGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwvbGF0ZXN0L2FkbWluLWd1aWRlL2Nw
dXRvcG9sb2d5Lmh0bWwsIGl0IA0Kc2hvdWxkIGJlIHVzaW5nIHRoZSAicHJlc2VudCIgZmls
ZS4gSSBzdWJtaXR0ZWQgdGhlIGJ1ZyBoZXJlOiANCmh0dHBzOi8vYnVnemlsbGEucmVkaGF0
LmNvbS9zaG93X2J1Zy5jZ2k/aWQ9MjIxNzE3OSBhbmQgaGVyZSANCmh0dHBzOi8vZ2l0aHVi
LmNvbS9pb3Zpc29yL2JjYy9pc3N1ZXMvNDY1MQ0KDQpZZXN0ZXJkYXksIEkgYWxzbyBlbmRl
ZCB1cCBzdWJtaXR0aW5nIGEgUFIgaGVyZTpodHRwczovL2dpdGh1Yi5jb20vbGliYnBmL2xp
YmJwZi9wdWxsLzcwMQ0KDQpUaGUgUFIgYWRkcyBhIG5ldyBmdW5jdGlvbiBjYWxsZWRsaWJi
cGZfbnVtX3ByZXNlbnRfY3B1c3x8fHx8fCAgYW5kIHJlZmFjdG9ycyB0aGUgZXhpc3Rpbmcg
b25lIHRvIHJlZHVjZSByZXBlYXRlZCBjb2RlLiBNeSBnb2FsIGlzIHRvIHRoZW4gcHJvdmlk
ZSBhIGZpeCB0byBjcHVmcmVxIHRvIHVzZSB0aGlzIG5ldyBBUEkgZnVuY3Rpb24gaW5zdGVh
ZC4NCg0KVGhpcyBtb3JuaW5nIEkgcmVhbGl6ZWQgdGhhdCBJIHNob3VsZCBoYXZlIGRvbmUg
aXQgb24gdGhpcyBtYWlsaW5nIGxpc3QuIEF0dGFjaGVkIHlvdSBjYW4gZmluZCB0aGUgcGF0
Y2ggd2l0aCB0aGlzIHByb3Bvc2FsLiBJIGNhbiB3b3JrIHRvd2FyZHMgYSBkaWZmZXJlbnQg
cHJvcG9zYWwgaWYgcHJlZmVycmVkLg0KDQpUaGFuayB5b3UsDQpDYXJsb3MgUi5GLg0KDQo=

--------------3bCwoW7Gn0az8vWINP0tW3j8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>

    <meta http-equiv=3D"content-type" content=3D"text/html; charset=3DUTF=
-8">
  </head>
  <body>
    <p><font face=3D"monospace">Hi all,</font></p>
    <p><font face=3D"monospace">The libbpf tool cpufreq uses the API
        function libbpf_num_possible_cpus to get the number of CPUs and
        then iterate over them to run its functionality, getting the
        information it needs from sysfs. The problem is that the cpu
        information in sysfs </font><code class=3D"notranslate">/sys/devi=
ces/system/cpu/cpu##</code><font
        face=3D"monospace"> appears only for the "present" cpus, not the
        "possible" in my system.</font></p>
    <p><font face=3D"monospace">This is the error:</font></p>
    <pre class=3D"notranslate"><code class=3D"notranslate">failed to open=
 '/sys/devices/system/cpu/cpu12/cpufreq/scaling_cur_freq': No such file o=
r directory
failed to init freqs

My possible num of cpus:

</code><code class=3D"notranslate">cat /sys/devices/system/cpu/possible
0-31

My present num of cpus:
cat /sys/devices/system/cpu/present
0-11

For what I understand in the documentation here </code><span class=3D"blo=
b-code-inner blob-code-marker js-code-nav-pass " data-code-marker=3D"+"><=
span class=3D"pl-c"><a class=3D"moz-txt-link-freetext" href=3D"https://ww=
w.kernel.org/doc/html/latest/admin-guide/cputopology.html">https://www.ke=
rnel.org/doc/html/latest/admin-guide/cputopology.html</a>, it should be u=
sing the "present" file.
I submitted the bug here:
<a class=3D"moz-txt-link-freetext" href=3D"https://bugzilla.redhat.com/sh=
ow_bug.cgi?id=3D2217179">https://bugzilla.redhat.com/show_bug.cgi?id=3D22=
17179</a>
and here
</span></span><span class=3D"blob-code-inner blob-code-marker js-code-nav=
-pass " data-code-marker=3D"+"><span class=3D"pl-c"><a class=3D"moz-txt-l=
ink-freetext" href=3D"https://github.com/iovisor/bcc/issues/4651">https:/=
/github.com/iovisor/bcc/issues/4651</a></span></span>

Yesterday, I also ended up submitting a PR here: <a class=3D"moz-txt-link=
-freetext" href=3D"https://github.com/libbpf/libbpf/pull/701">https://git=
hub.com/libbpf/libbpf/pull/701</a>

The PR adds a new function called <font face=3D"monospace">libbpf_num_pre=
sent_cpus</font><span class=3D"blob-code-inner blob-code-marker js-code-n=
av-pass " data-code-marker=3D"+"><span class=3D"pl-c"></span></span><code=
 class=3D"notranslate"></code><code class=3D"notranslate"></code><code cl=
ass=3D"notranslate"></code> and refactors the existing one to reduce repe=
ated code. My goal is to then provide a fix to cpufreq to use this new AP=
I function instead.

This morning I realized that I should have done it on this mailing list. =
Attached you can find the patch with this proposal. I can work towards a =
different proposal if preferred.

Thank you,
Carlos R.F.
</pre>
    <p></p>
  </body>
</html>

--------------3bCwoW7Gn0az8vWINP0tW3j8--
--------------qoKTcFio6MHc06mekOzKBOmM
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-libbpf-provide-num-present-cpus.patch"
Content-Disposition: attachment;
 filename="0001-libbpf-provide-num-present-cpus.patch"
Content-Transfer-Encoding: base64

RnJvbSBmZDIyNDNiYjA5NmMwNWNhMmM2NTljMTk1MjJhZGFkYzg4YWYzNDhhIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDYXJsb3MgUm9kcmlndWV6LUZlcm5hbmRleiA8Y2Fy
bG9zcm9kcmlmZXJuYW5kZXpAZ21haWwuY29tPgpEYXRlOiBTYXQsIDI0IEp1biAyMDIzIDIy
OjQxOjM0IC0wNzAwClN1YmplY3Q6IFtQQVRDSF0gbGliYnBmOiBwcm92aWRlIG51bSBwcmVz
ZW50IGNwdXMKCkl0IGFsbG93cyB0b29scyB0byBpdGVyYXRlIG92ZXIgQ1BVcyBwcmVzZW50
CmluIHRoZSBzeXN0ZW0gdGhhdCBhcmUgYWN0dWFsbHkgcnVubmluZyBwcm9jZXNzZXMsCndo
aWNoIGNhbiBiZSBsZXNzIHRoYW4gdGhlIG51bWJlciBvZiBwb3NzaWJsZSBDUFVzLgoKU2ln
bmVkLW9mZi1ieTogQ2FybG9zIFJvZHJpZ3Vlei1GZXJuYW5kZXogPGNhcmxvc3JvZHJpZmVy
bmFuZGV6QGdtYWlsLmNvbT4KLS0tCiBzcmMvbGliYnBmLmMgfCAzMiArKysrKysrKysrKysr
KysrKysrKysrKysrKystLS0tLQogc3JjL2xpYmJwZi5oIHwgIDggKysrKystLS0KIDIgZmls
ZXMgY2hhbmdlZCwgMzIgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9zcmMvbGliYnBmLmMgYi9zcmMvbGliYnBmLmMKaW5kZXggMjE0ZjgyOC4uZTQyZDI1
MiAxMDA2NDQKLS0tIGEvc3JjL2xpYmJwZi5jCisrKyBiL3NyYy9saWJicGYuYwpAQCAtMTI2
MTUsMTQgKzEyNjE1LDI2IEBAIGludCBwYXJzZV9jcHVfbWFza19maWxlKGNvbnN0IGNoYXIg
KmZjcHUsIGJvb2wgKiptYXNrLCBpbnQgKm1hc2tfc3opCiAJcmV0dXJuIHBhcnNlX2NwdV9t
YXNrX3N0cihidWYsIG1hc2ssIG1hc2tfc3opOwogfQogCi1pbnQgbGliYnBmX251bV9wb3Nz
aWJsZV9jcHVzKHZvaWQpCit0eXBlZGVmIGVudW0ge1BPU1NJQkxFPTAsIFBSRVNFTlQsIE5V
TV9UWVBFUyB9IENQVV9UT1BPTE9HWV9TWVNGU19UWVBFOworCitzdGF0aWMgY29uc3QgY2hh
ciAqY3B1X3RvcG9sb2d5X3N5c2ZzX3BhdGhfYnlfdHlwZShjb25zdCBDUFVfVE9QT0xPR1lf
U1lTRlNfVFlQRSB0eXBlKSB7CisJY29uc3Qgc3RhdGljIGNoYXIgKnBvc3NpYmxlX3N5c2Zz
X3BhdGggPSAiL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvcG9zc2libGUiOworCWNvbnN0IHN0
YXRpYyBjaGFyICpwcmVzZW50X3N5c2ZzX3BhdGggPSAiL3N5cy9kZXZpY2VzL3N5c3RlbS9j
cHUvcHJlc2VudCI7CisJc3dpdGNoKHR5cGUpIHsKKwkJY2FzZSBQT1NTSUJMRTogcmV0dXJu
IHBvc3NpYmxlX3N5c2ZzX3BhdGg7CisJCWNhc2UgUFJFU0VOVDogcmV0dXJuIHByZXNlbnRf
c3lzZnNfcGF0aDsKKwkJZGVmYXVsdDogcmV0dXJuIHBvc3NpYmxlX3N5c2ZzX3BhdGg7CisJ
fQorfQorCitpbnQgbGliYnBmX251bV9jcHVzX2J5X3RvcG9sb2d5X3N5c2ZzX3R5cGUoY29u
c3QgQ1BVX1RPUE9MT0dZX1NZU0ZTX1RZUEUgdHlwZSkKIHsKLQlzdGF0aWMgY29uc3QgY2hh
ciAqZmNwdSA9ICIvc3lzL2RldmljZXMvc3lzdGVtL2NwdS9wb3NzaWJsZSI7Ci0Jc3RhdGlj
IGludCBjcHVzOworCWNvbnN0IGNoYXIgKmZjcHUgPSBjcHVfdG9wb2xvZ3lfc3lzZnNfcGF0
aF9ieV90eXBlKHR5cGUpOworCXN0YXRpYyBpbnQgY3B1c1tOVU1fVFlQRVNdOwogCWludCBl
cnIsIG4sIGksIHRtcF9jcHVzOwogCWJvb2wgKm1hc2s7CiAKLQl0bXBfY3B1cyA9IFJFQURf
T05DRShjcHVzKTsKKwl0bXBfY3B1cyA9IFJFQURfT05DRShjcHVzW3R5cGVdKTsKIAlpZiAo
dG1wX2NwdXMgPiAwKQogCQlyZXR1cm4gdG1wX2NwdXM7CiAKQEAgLTEyNjM3LDEwICsxMjY0
OSwyMCBAQCBpbnQgbGliYnBmX251bV9wb3NzaWJsZV9jcHVzKHZvaWQpCiAJfQogCWZyZWUo
bWFzayk7CiAKLQlXUklURV9PTkNFKGNwdXMsIHRtcF9jcHVzKTsKKwlXUklURV9PTkNFKGNw
dXNbdHlwZV0sIHRtcF9jcHVzKTsKIAlyZXR1cm4gdG1wX2NwdXM7CiB9CiAKK2ludCBsaWJi
cGZfbnVtX3Bvc3NpYmxlX2NwdXModm9pZCkKK3sKKwlyZXR1cm4gbGliYnBmX251bV9jcHVz
X2J5X3RvcG9sb2d5X3N5c2ZzX3R5cGUoUE9TU0lCTEUpOworfQorCitpbnQgbGliYnBmX251
bV9wcmVzZW50X2NwdXModm9pZCkKK3sKKwlyZXR1cm4gbGliYnBmX251bV9jcHVzX2J5X3Rv
cG9sb2d5X3N5c2ZzX3R5cGUoUFJFU0VOVCk7Cit9CisKIHN0YXRpYyBpbnQgcG9wdWxhdGVf
c2tlbGV0b25fbWFwcyhjb25zdCBzdHJ1Y3QgYnBmX29iamVjdCAqb2JqLAogCQkJCSAgc3Ry
dWN0IGJwZl9tYXBfc2tlbGV0b24gKm1hcHMsCiAJCQkJICBzaXplX3QgbWFwX2NudCkKZGlm
ZiAtLWdpdCBhL3NyYy9saWJicGYuaCBiL3NyYy9saWJicGYuaAppbmRleCA3NTRkYTczLi5h
MzQxNTJjIDEwMDY0NAotLS0gYS9zcmMvbGliYnBmLmgKKysrIGIvc3JjL2xpYmJwZi5oCkBA
IC0xNDMzLDkgKzE0MzMsMTAgQEAgTElCQlBGX0FQSSBpbnQgbGliYnBmX3Byb2JlX2JwZl9o
ZWxwZXIoZW51bSBicGZfcHJvZ190eXBlIHByb2dfdHlwZSwKIAkJCQkgICAgICAgZW51bSBi
cGZfZnVuY19pZCBoZWxwZXJfaWQsIGNvbnN0IHZvaWQgKm9wdHMpOwogCiAvKioKLSAqIEBi
cmllZiAqKmxpYmJwZl9udW1fcG9zc2libGVfY3B1cygpKiogaXMgYSBoZWxwZXIgZnVuY3Rp
b24gdG8gZ2V0IHRoZQotICogbnVtYmVyIG9mIHBvc3NpYmxlIENQVXMgdGhhdCB0aGUgaG9z
dCBrZXJuZWwgc3VwcG9ydHMgYW5kIGV4cGVjdHMuCi0gKiBAcmV0dXJuIG51bWJlciBvZiBw
b3NzaWJsZSBDUFVzOyBvciBlcnJvciBjb2RlIG9uIGZhaWx1cmUKKyAqIEBicmllZiAqKmxp
YmJwZl9udW1fcG9zc2libGVfY3B1cygpKiosIGFuZCAqKmxpYmJwZl9udW1fcHJlc2VudF9j
cHVzKCkqKgorICogYXJlIGhlbHBlciBmdW5jdGlvbnMgdG8gZ2V0IHRoZSBudW1iZXIgb2Yg
cG9zc2libGUsIGFuZCBwcmVzZW50IENQVXMgcmVzcGVjdGl2ZWxseS4KKyAqIFNlZSBmb3Ig
bW9yZSBpbmZvcm1hdGlvbjogaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC9sYXRl
c3QvYWRtaW4tZ3VpZGUvY3B1dG9wb2xvZ3kuaHRtbAorICogQHJldHVybiBudW1iZXIgb2Yg
Q1BVczsgb3IgZXJyb3IgY29kZSBvbiBmYWlsdXJlCiAgKgogICogRXhhbXBsZSB1c2FnZToK
ICAqCkBAIC0xNDQ3LDYgKzE0NDgsNyBAQCBMSUJCUEZfQVBJIGludCBsaWJicGZfcHJvYmVf
YnBmX2hlbHBlcihlbnVtIGJwZl9wcm9nX3R5cGUgcHJvZ190eXBlLAogICogICAgIGJwZl9t
YXBfbG9va3VwX2VsZW0ocGVyX2NwdV9tYXBfZmQsIGtleSwgdmFsdWVzKTsKICAqLwogTElC
QlBGX0FQSSBpbnQgbGliYnBmX251bV9wb3NzaWJsZV9jcHVzKHZvaWQpOworTElCQlBGX0FQ
SSBpbnQgbGliYnBmX251bV9wcmVzZW50X2NwdXModm9pZCk7CiAKIHN0cnVjdCBicGZfbWFw
X3NrZWxldG9uIHsKIAljb25zdCBjaGFyICpuYW1lOwotLSAKMi40MS4wCgo=
--------------qoKTcFio6MHc06mekOzKBOmM
Content-Type: application/pgp-keys; name="OpenPGP_0x47EBED05C3375B1F.asc"
Content-Disposition: attachment; filename="OpenPGP_0x47EBED05C3375B1F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsDNBGIukY0BDADiM1V4dy8JclUIJXvJmSqvMJ/OqPVCdldKLlO5gutTguVbmFD8
4XlrbPXoHLNlVH28FaljHRvQvoZpytxZgIeIMe7xgEdpnfwUFjpVaxuAZMwCcjuQ
TX9N0IqZZ5Wl5r2ch+yo335kDw3rDk0aRqwfdDIdTQEmNMlGHMtaUjQstY5u+jEP
rrJzfSDjiwAirNmofhgYCrvnqNgA80z554XIrV8jB3WXiF24WHi2GqcWSMYSdvgd
4WtxzjRhm3PiQ8NhoMz8e1Js73OPdus3l86TPAfUcJ3T6wPhjQHK9OVBiOWVXk7a
IXhBSRVybgwXRM3YjCEuWROw5Fe4BI086Cihlf1i2xHsrcbU/od+iOG/SGR3BWeQ
McvZ/Ko1KcAn0kgBPwFkrjv2HltGqP/86OjfPxQJiUzu5KUbbjslTFOhMfZTc6BN
inC073uZSkzySXkcAmGFednKkK0A7nThwrdY8TP3LepBa3VRldNZ19dykbSPlwKs
r9cbs1eA/0PnN9sAEQEAAc07Q2FybG9zIFJvZHJpZ3Vlei1GZXJuYW5kZXogPGNh
cmxvc3JvZHJpZmVybmFuZGV6QGdtYWlsLmNvbT7CwQ8EEwEIADkWIQQsxXXcbM+a
qXApjutH6+0FwzdbHwUCYi6RjgUJBaOagAIbAwULCQgHAgYVCAkKCwIFFgIDAQAA
CgkQR+vtBcM3Wx9cjwwAqJ+k2wsEaO1ZJTP69aqzom0ylwvHu7nQ4JEDiHgrl0CQ
jI30dFphAMKpL0ZKDf63SLZidGSyr3jb+OtOBmZioW0pyqftvbmNKPIJh4Gxzu+O
gKwCyGkaPSRgnFvCeVEZZRk48LJKfM7vOOhXWyZR5xdauP+5kjMSUIZlZhrvqXLT
oYEgcl+gRjteqlh1Zmqc9kkFABWZUbPF0K+MdZL+hXh63NrRe7BC1AtRLAQxtZtx
F+6JVpV+MOE8rg6Af4OL8c2p5ZSlAqVkq37KdUA7jjZua/QZvYFCZXR7lQYR49h2
ThXIc0KUk08G25sdU5x/p/MTgUX+xxS9RJ5ARsWiYoyn4YKMOpEsshtyxvtZ8jI0
4lOrrXDfS5ZRiVh+rknCbdXuJR0H+rQMBH9TVgM7PMxvpOIV1zd33JJficmwVgst
s9rIT1vtisj2fcHyS8cl8JXQE1sPEp2Ekc+x6ZnSxs2iwYm+lgf8UI/rhAsyKJIE
+tyJAUoTJh5sjMoYqA95zsDNBGIukY4BDACsqaWK0e5NGn14R7F1tt10X1/6hOvb
YW2Dl8Dr79c/uZ8sGr1Ib1vPc3oCc6AuKrLgY+Z/t5LNF3Gk+2dxI1FTpfgR4wAu
QcHKxA1h9VvKsI4WtiGkWZ5yhRowtestE+9tiPTwmvz3Dc+6j5K52dGbg2BWFvm9
xkMtZK2t98dnHr3vzMb8ZqS+CCBO7APyvjf/0eJaVl5JQLDu9n1kDqosrkOK0JxC
zYztfp4Z5+fq2l/qMxnX00jseLWzD2cy+1JbdXe0JRbuXXb0ZQZMevbxo+wYxcbg
Mvi5CoqrDzwBgNRHHHcRjMuNpziYM5fDGMtG5pe/ehtvojDjhTJeUByobAAxLbyB
zACNzr8Wbi+rdMMWFfxnbIR01L9NO2WC6UDXLFd28tIH31ewPTkvBKucvH5BIWRU
lTqcjh8UNSZflUrmVzx5IgfLw5eOCgK6g8na3o9m4gLz23uOVuKzk45P8wTUNroF
eQe+qZtnqr+duFdHAnyshC616+lHMBmtv9UAEQEAAcLA/AQYAQgAJhYhBCzFddxs
z5qpcCmO60fr7QXDN1sfBQJiLpGPBQkFo5qAAhsMAAoJEEfr7QXDN1sflzIMAI5L
n3VmXH2kQGYOWAi5CAlYFmmT6enUTLfOUbp0g3/i+9LedLRuoSg5aIW1fULWOOIL
Cu05oaong107styikIQN3vV8tZdm3ne6NzowWAlULKmd/nzyD9LNCi7Z7IfOBH/T
E56tOY9uLNvSxXMDH8pPKyGf1MScxHFb4djc0eFt8GfCcLz2DxK5aaAKukh1LDrf
+nDqW3aO4xSZCmrCUmDnnGV46ngAYp7+nw+r7J9EmEeQFX0J+3toNLLCzPHaQaSB
OIK02X1DHjotw5Wf2W4TYjvewfORqj9MrFLwvq5lVxj00u/5qPRfuX9mDJ6ta3uN
BoOJrpbg/ShtjG/IrNZS/0OZhyvkjaXjkUqUD9vgLvhzonhlEMWwmukIMB5816Ua
Secd/qZ+iGwnOnc+ZYXit8le8yHXSef5xC5i+E0WUEfZ8LNjo0GKZcelW9CSYKYr
mgUj/Gs0NjcFM0FG/WL6L+6Ii+thcSyi1FE2tKhu38skR9OFIE2ZHT24K2FotQ=3D=3D
=3Dn5Jn
-----END PGP PUBLIC KEY BLOCK-----

--------------qoKTcFio6MHc06mekOzKBOmM--

--------------3yVMgZjRO0wVuvQAanqrB07j--

--------------9nt31RIcNs47u4yngZGQwYC0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsD5BAABCAAjFiEELMV13GzPmqlwKY7rR+vtBcM3Wx8FAmSYVbYFAwAAAAAACgkQR+vtBcM3Wx/D
fQwAsd2CeW/9GURj48fEZNI1vh0JD1V5mJ45lNk1q5yhbODk5Xz/owWi1MNWvYZubgJGbFg3h69x
AX7/HSzzB1a4bNbiaFCE1uFYX8iqVxNJedHvH9eQHRAnD7Jqv0imyteB5215QHJGob79uwfcNY4g
VYsbG/JaY2lFlv2C6ah65buOOxZVHxitV4aJjVBOBdrwVjyh19UsPdB1mB9Q41NAJCnrNMZAo0rL
F3k6py8/Qc42wj5aFu3cczY9IOWG9fDLdGFHdmdVvVxyxY2iVYCOG3rvBdvo7s6kxtghUEA3h2S4
ilKHgA7A+TMXMZwgiW0mOJ/c5CBqncy3b2h50OHEbZPIMck3SPzbIxCijTiDWw2JzvLL5YkbV7yp
MY4CNg9fEaMJFHMEogqiMhXH0CrLqKriQ844ApbjTWy1HJxshI5RhUzuOMG+Px5qdJF9kLno7bLv
qcc+8DrLOEbL+JEf3rB/PFyI9FcUCwUEsxNu/3ml4+kX3EOpOR4HhHXJSR57
=z+5d
-----END PGP SIGNATURE-----

--------------9nt31RIcNs47u4yngZGQwYC0--

