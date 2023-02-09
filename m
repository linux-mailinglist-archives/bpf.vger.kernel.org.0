Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28AC68FE54
	for <lists+bpf@lfdr.de>; Thu,  9 Feb 2023 05:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjBIERu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 23:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBIERt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 23:17:49 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8180EC17B
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 20:16:50 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id j6-20020a9d7686000000b0068d4ba9d141so218721otl.6
        for <bpf@vger.kernel.org>; Wed, 08 Feb 2023 20:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kIYuQlL0b+1UWZxfzgSTYgkUPg5xtNdv7gdQ4CEZyyk=;
        b=C4WnWbFMTIDzI6S4+iXb05xdKS1IyXewwDyBAFyVRSNLTwNJqBDKMcBLd3A/r5LNPK
         v/N9iclVolyvQ4btP0yIdaRaPUI04tf3FbwImfyvCjowmBjeaaFClFbB4k3IYF8X50N7
         BGrZBHoKhdf+DMutXyPy1yhxHJWZtrptAr90Wf6kbouvLLy/5bOvWf+wuuoXfZvBUiZE
         9qN48BsQB+oIrncuwOQ4bF2VW9l12/lRWf+ZTrUx5jcIMiuzhKWK/dRMNXEKYEFDhMjs
         /2zFgdrPu3oSLFNqRFd103+Tqt6jwv1fWjyFEhico9FzGm0BqWwhG8RrNKGDghzAxPFY
         BsyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kIYuQlL0b+1UWZxfzgSTYgkUPg5xtNdv7gdQ4CEZyyk=;
        b=bdK2fQ2vTw2WqJ+UFJ7Q7A88CxELMrClqmu66oLUOhhLrzG5QFPpKoBmGIpFTK6Ko6
         g3IZC7T25N1YdgNq2F98cSPdbkDQEWRc0LjJQH8Ax6Tbug89sjU2umae3Qw6N8Gprz+a
         tuFoBxiAePTMky472pGDsmXZ0JZZME/z7XSaulqk5w8b+xOOL/1jUej2mUaei/2/VNpn
         Wn/xeTaVM4bAcE9Hw0BEi8sDDAoWvYKNi8cDbeB86yflZNhHq2XSDyljc8pFSdmSptvI
         lWEt8pCcSHksQbJgHjEdrA6uUSu73yX9LT62VeqsQGjIoUyQXGEpCls2f2RwRdHXeu93
         GNrA==
X-Gm-Message-State: AO0yUKUv/q1YrRjz+BEyoL79AfytfTd31X85TFnICAdRZ/Yzqumc8M6w
        joAn6VJzk5r8o217mzhXhzzKQg8wAk4=
X-Google-Smtp-Source: AK7set/xvaJ81XRuC+G9Qi6FXguSruZFo2bHJLwOvNbYLQI7HZn2hCbhoSo4nxtKWoIv2twE53+Ddg==
X-Received: by 2002:a05:6830:4784:b0:68b:cdc3:78d7 with SMTP id df4-20020a056830478400b0068bcdc378d7mr4791454otb.8.1675916112346;
        Wed, 08 Feb 2023 20:15:12 -0800 (PST)
Received: from ?IPV6:2603:8080:2800:f9bf:eb7:f10d:ceda:48f6? (2603-8080-2800-f9bf-0eb7-f10d-ceda-48f6.res6.spectrum.com. [2603:8080:2800:f9bf:eb7:f10d:ceda:48f6])
        by smtp.gmail.com with ESMTPSA id f17-20020a9d7b51000000b0068bdfa56717sm148587oto.36.2023.02.08.20.15.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 20:15:11 -0800 (PST)
Message-ID: <d880b3b3-d6fb-c891-bfc2-9c05c321ddac@gmail.com>
Date:   Wed, 8 Feb 2023 22:15:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: Kernel build fail with 'btf_encoder__encode: btf__dedup failed!'
Content-Language: en-US
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Daniel Xu <dxu@dxuuu.xyz>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <57830c30-cd77-40cf-9cd1-3bb608aa602e@app.fastmail.com>
 <Y85AHdWw/l8d1Gsp@krava>
 <0fbad67e-c359-47c3-8c10-faa003e6519f@app.fastmail.com>
 <bb569967-d33a-7252-964b-a36501b3366a@gmail.com> <Y9RlpyV5JPz/hk1K@krava>
 <883a3b03-a596-8279-1278-bc622114aab5@gmail.com> <Y9kxUzyfpEQpnN7w@krava>
From:   Alexandre Peixoto Ferreira <alexandref75@gmail.com>
In-Reply-To: <Y9kxUzyfpEQpnN7w@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jiri,

On 1/31/23 09:18, Jiri Olsa wrote:
> On Sat, Jan 28, 2023 at 01:23:25PM -0600, Alexandre Peixoto Ferreira wrote:
>> Jirka and Daniel,
>>
>> On 1/27/23 18:00, Jiri Olsa wrote:
>>> On Fri, Jan 27, 2023 at 04:28:54PM -0600, Alexandre Peixoto Ferreira wrote:
>>>> On 1/24/23 00:13, Daniel Xu wrote:
>>>>> Hi Jiri,
>>>>>
>>>>> On Mon, Jan 23, 2023, at 1:06 AM, Jiri Olsa wrote:
>>>>>> On Sun, Jan 22, 2023 at 10:48:44AM -0700, Daniel Xu wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> I'm getting the following error during build:
>>>>>>>
>>>>>>>            $ ./tools/testing/selftests/bpf/vmtest.sh -j30
>>>>>>>            [...]
>>>>>>>              BTF     .btf.vmlinux.bin.o
>>>>>>>            btf_encoder__encode: btf__dedup failed!
>>>>>>>            Failed to encode BTF
>>>>>>>              LD      .tmp_vmlinux.kallsyms1
>>>>>>>              NM      .tmp_vmlinux.kallsyms1.syms
>>>>>>>              KSYMS   .tmp_vmlinux.kallsyms1.S
>>>>>>>              AS      .tmp_vmlinux.kallsyms1.S
>>>>>>>              LD      .tmp_vmlinux.kallsyms2
>>>>>>>              NM      .tmp_vmlinux.kallsyms2.syms
>>>>>>>              KSYMS   .tmp_vmlinux.kallsyms2.S
>>>>>>>              AS      .tmp_vmlinux.kallsyms2.S
>>>>>>>              LD      .tmp_vmlinux.kallsyms3
>>>>>>>              NM      .tmp_vmlinux.kallsyms3.syms
>>>>>>>              KSYMS   .tmp_vmlinux.kallsyms3.S
>>>>>>>              AS      .tmp_vmlinux.kallsyms3.S
>>>>>>>              LD      vmlinux
>>>>>>>              BTFIDS  vmlinux
>>>>>>>            FAILED: load BTF from vmlinux: No such file or directory
>>>>>>>            make[1]: *** [scripts/Makefile.vmlinux:35: vmlinux] Error 255
>>>>>>>            make[1]: *** Deleting file 'vmlinux'
>>>>>>>            make: *** [Makefile:1264: vmlinux] Error 2
>>>>>>>
>>>>>>> This happens on both bpf-next/master (84150795a49) and 6.2-rc5
>>>>>>> (2241ab53cb).
>>>>>>>
>>>>>>> I've also tried arch linux pahole 1:1.24+r29+g02d67c5-1 as well as
>>>>>>> upstream pahole on master (02d67c5176) and upstream pahole on
>>>>>>> next (2ca56f4c6f659).
>>>>>>>
>>>>>>> Of the above 6 combinations, I think I've tried all of them (maybe
>>>>>>> missing 1 or 2).
>>>>>>>
>>>>>>> Looks like GCC got updated recently on my machine, so perhaps
>>>>>>> it's related?
>>>>>>>
>>>>>>>            CONFIG_CC_VERSION_TEXT="gcc (GCC) 12.2.1 20230111"
>>>>>>>
>>>>>>> I'll try some debugging, but just wanted to report it first.
>>>>>> hi,
>>>>>> I can't reproduce that.. can you reproduce it outside vmtest.sh?
>>>>>>
>>>>>> there will be lot of output with patch below, but could contain
>>>>>> some more error output
>>>>> Thanks for the hints. Doing a regular build outside of vmtest.sh
>>>>> seems to work ok. So maybe it's a difference in the build config.
>>>>>
>>>>> I'll put a little more time into debugging to see if it goes anywhere.
>>>>> But I'll have to get back to the regularly scheduled programming
>>>>> soon.
>>>> 6.2-rc5 compiles correctly when CONFIG_X86_KERNEL_IBT is commented but fails
>>>> in pahole when CONFIG_X86_KERNEL_IBT is set.
>>> could you plese attach your config and the build error?
>>> I can't reproduce that
>>>
>>> thanks,
>>> jirka
>> My working .config is available at https://pastebin.pl/view/bef3765c
>> change CONFIG_X86_KERNEL_IBT to y to get the error.
>>
>> The error is similar to Daniel's and is shown below:
>>
>>    LD      .tmp_vmlinux.btf
>>    BTF     .btf.vmlinux.bin.o
>> btf_encoder__encode: btf__dedup failed!
>> Failed to encode BTF
>>    LD      .tmp_vmlinux.kallsyms1
>>    NM      .tmp_vmlinux.kallsyms1.syms
>>    KSYMS   .tmp_vmlinux.kallsyms1.S
>>    AS      .tmp_vmlinux.kallsyms1.S
>>    LD      .tmp_vmlinux.kallsyms2
>>    NM      .tmp_vmlinux.kallsyms2.syms
>>    KSYMS   .tmp_vmlinux.kallsyms2.S
>>    AS      .tmp_vmlinux.kallsyms2.S
>>    LD      .tmp_vmlinux.kallsyms3
>>    NM      .tmp_vmlinux.kallsyms3.syms
>>    KSYMS   .tmp_vmlinux.kallsyms3.S
>>    AS      .tmp_vmlinux.kallsyms3.S
>>    LD      vmlinux
>>    BTFIDS  vmlinux
>> FAILED: load BTF from vmlinux: No such file or directory
>> make[1]: *** [scripts/Makefile.vmlinux:35: vmlinux] Error 255
>> make[1]: *** Deleting file 'vmlinux'
>> make: *** [Makefile:1264: vmlinux] Error 2
> I can't reproduce that.. I tried with gcc versions:
>
>    gcc (GCC) 13.0.1 20230117 (Red Hat 13.0.1-0)
>    gcc (GCC) 12.2.1 20221121 (Red Hat 12.2.1-4)
>
> I haven't found fedora setup with 12.2.1 20230111 yet
>
> I tried alsa with latest pahole master branch
>
> were you guys able to get any more verbose output
> that I suggested earlier?
>
> jirka

I compiled with and without IBT using the -V on pahole 
(LLVM_OBJCOPY=objcopy pahole -V -J --btf_gen_floats -j .tmp_vmlinux.btf) 
and the outfiles are a little too big (540MB). The error happens with 
this CONST type pointing to itself. That does not happen with the IBT 
option removed.

$ grep  -n "CONST (anon) type_id" /tmp/with_IBT  | more
346:[2] CONST (anon) type_id=2
349:[5] CONST (anon) type_id=5
351:[7] CONST (anon) type_id=7
356:[12] CONST (anon) type_id=12
363:[19] CONST (anon) type_id=19
373:[29] CONST (anon) type_id=29
375:[31] CONST (anon) type_id=31
409:[63] CONST (anon) type_id=63
444:[89] CONST (anon) type_id=0
472:[97] CONST (anon) type_id=97
616:[129] CONST (anon) type_id=129
652:[131] CONST (anon) type_id=131
1319:[234] CONST (anon) type_id=234
1372:[246] CONST (anon) type_id=246
....

$diff -ru with_IBT without_IBT
--- with_IBT 2023-01-31 09:39:24.915912735 -0600
+++ without_IBT 2023-01-31 09:46:23.456005278 -0600
@@ -340,346 +340,14800 @@
  Found per-CPU symbol 'cpu_tlbstate_shared' at address 0x2c040
  Found per-CPU symbol 'mce_poll_banks' at address 0x1ad20
  Found 341 per-CPU variables!
-Found 61470 functions!
+Found 61462 functions!
+File .tmp_vmlinux.btf:
+[1] FUNC_PROTO (anon) return=0 args=(void)
+[2] FUNC verify_cpu type_id=1
+[3] FUNC_PROTO (anon) return=0 args=(void)
+[4] FUNC sev_verify_cbit type_id=3
+search cu 'arch/x86/kernel/head_64.S' for percpu global variables.
+Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
+Found per-CPU symbol 'perf_nmi_tstamp' at address 0x19f70
+Found per-CPU symbol 'kvm_running_vcpu' at address 0x19f80
+Found per-CPU symbol 'cpu_kick_mask' at address 0x19f78
+Found per-CPU symbol 'cpu_tsc_khz' at address 0x19f88
+Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
+Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
+Found per-CPU symbol 'perf_nmi_tstamp' at address 0x19f70
+Found per-CPU symbol 'perf_nmi_tstamp' at address 0x19f70
+Found per-CPU symbol 'current_tsc_ratio' at address 0x19fa0
+Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
+Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
+Found per-CPU symbol 'kvm_running_vcpu' at address 0x19f80
+Found per-CPU symbol 'kvm_running_vcpu' at address 0x19f80
+Found per-CPU symbol 'cpu_kick_mask' at address 0x19f78
+Found per-CPU symbol 'cpu_kick_mask' at address 0x19f78
+Found per-CPU symbol 'perf_nmi_tstamp' at address 0x19f70
+Found per-CPU symbol 'perf_nmi_tstamp' at address 0x19f70
+Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
+Found per-CPU symbol 'perf_nmi_tstamp' at address 0x19f70
+Found per-CPU symbol 'cpu_tsc_khz' at address 0x19f88
+Found per-CPU symbol 'last_nmi_rip' at address 0x1a018
+Found per-CPU symbol 'nmi_stats' at address 0x1a030
+Found per-CPU symbol 'swallow_nmi' at address 0x1a020
+Found per-CPU symbol 'nmi_state' at address 0x1a010
+Found per-CPU symbol 'kvm_running_vcpu' at address 0x19f80
+Found per-CPU symbol 'nmi_cr2' at address 0x1a008
+Found per-CPU symbol 'kvm_running_vcpu' at address 0x19f80
+Found per-CPU symbol 'cpu_tsc_khz' at address 0x19f88
+Found per-CPU symbol 'cpu_kick_mask' at address 0x19f78
+Found per-CPU symbol 'cpu_kick_mask' at address 0x19f78
+Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
...

And the lines 342-365 of the with_IBT result:
      342 Found 341 per-CPU variables!
      343 Found 61470 functions!
      344 File .tmp_vmlinux.btf:
      345 [1] INT long unsigned int size=8 nr_bits=64 encoding=(none)
      346 [2] CONST (anon) type_id=2
      347 [3] PTR (anon) type_id=6
      348 [4] INT char size=1 nr_bits=8 encoding=(none)
      349 [5] CONST (anon) type_id=5
      350 [6] INT unsigned int size=4 nr_bits=32 encoding=(none)
      351 [7] CONST (anon) type_id=7
      352 [8] TYPEDEF __s8 type_id=10
      353 [9] INT signed char size=1 nr_bits=8 encoding=SIGNED
      354 [10] TYPEDEF __u8 type_id=12
      355 [11] INT unsigned char size=1 nr_bits=8 encoding=(none)
      356 [12] CONST (anon) type_id=12
      357 [13] TYPEDEF __s16 type_id=15
      358 [14] INT short int size=2 nr_bits=16 encoding=SIGNED
      359 [15] TYPEDEF __u16 type_id=17
      360 [16] INT short unsigned int size=2 nr_bits=16 encoding=(none)
      361 [17] TYPEDEF __s32 type_id=19
      362 [18] INT int size=4 nr_bits=32 encoding=SIGNED
      363 [19] CONST (anon) type_id=19
      364 [20] TYPEDEF __u32 type_id=7
      365 [21] TYPEDEF __s64 type_id=23

lines 342-362 of without_IBT

      342 Found 341 per-CPU variables!
      343 Found 61462 functions!
      344 File .tmp_vmlinux.btf:
      345 [1] FUNC_PROTO (anon) return=0 args=(void)
      346 [2] FUNC verify_cpu type_id=1
      347 [3] FUNC_PROTO (anon) return=0 args=(void)
      348 [4] FUNC sev_verify_cbit type_id=3
      349 search cu 'arch/x86/kernel/head_64.S' for percpu global variables.
      350 Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
      351 Found per-CPU symbol 'perf_nmi_tstamp' at address 0x19f70
      352 Found per-CPU symbol 'kvm_running_vcpu' at address 0x19f80
      353 Found per-CPU symbol 'cpu_kick_mask' at address 0x19f78
      354 Found per-CPU symbol 'cpu_tsc_khz' at address 0x19f88
      355 Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
      356 Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
      357 Found per-CPU symbol 'perf_nmi_tstamp' at address 0x19f70
      358 Found per-CPU symbol 'perf_nmi_tstamp' at address 0x19f70
      359 Found per-CPU symbol 'current_tsc_ratio' at address 0x19fa0
      360 Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
      361 Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
      362 Found per-CPU symbol 'kvm_running_vcpu' at address 0x19f80

If the full debug files are useful or a target grep or diff is better 
let me know.

Thanks,

-- 
Alexandre Peixoto Ferreira

