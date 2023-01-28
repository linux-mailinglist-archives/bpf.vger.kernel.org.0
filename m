Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F1267FA6A
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 20:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjA1TXa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 28 Jan 2023 14:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjA1TX3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 28 Jan 2023 14:23:29 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943DB2885A
        for <bpf@vger.kernel.org>; Sat, 28 Jan 2023 11:23:27 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id z138-20020a4a4990000000b005175b8ae66cso107912ooa.6
        for <bpf@vger.kernel.org>; Sat, 28 Jan 2023 11:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=87Z7hi5D3eZZr3czbnLE6Ib76WMzxMDlRYTTz9PzzHk=;
        b=Z/5OE9zcPMdaASg0ZpQMboyurM26QydSA2pkcn+p8+mEJcUq9E2KNL+ru4B95bIWWL
         idwE5djDfsu2fL0bhSPcQdp/UtByR6c3zf2xbozKUzLN+hcr//tLPmqSFjph77Td/tX3
         Xl4davlZqrcA4L7Uo2CUnFgsBpESnxmcUl0qBjSA0ve6XppeasLsIgCWkEVauAZanTx6
         8XD6GjK8C8frC4XySE925+SwVdbJvza1Zkl15FRreb01Kw+yRweuWWEteKGZWItWS6tZ
         Kc0TdIawlg3N+lddZMBMZ7RL6y9wQp1MHebjIvblcM4oBZv7Qm8u7DQC3gXFutO6IFN3
         ULxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=87Z7hi5D3eZZr3czbnLE6Ib76WMzxMDlRYTTz9PzzHk=;
        b=uDRnJMLupIIvmkvJK9kwOHU53ukU8Xxvw5XNVrEV/F1JuaiA/BNzYTd5GusrbTt785
         TaAAzLaBRFprpK6eJtqqWjBeixIw9JXeAh4RFG6TzMFZwy+iMIOjo2EnIpjfy2wf1WIf
         jRk6VIVXQqaEv5ZxriqATdUoc/Y/APfBX09vdtmmOcht1ZGrcub1CuBZXetwmZf/PNDE
         H7CIdtdn5JIaDVyMm1xPRYsL15S11solKT6I18fRlCtn/rY5Wj7C/Y7EERGWNcrUbgVi
         RuQRtCOEEFjGS61uJhwVKtFOgJS/m2VfRt92Zf1mPrf88BKce72dyIsZogqkUS5BVdXt
         Ez8g==
X-Gm-Message-State: AFqh2kqUDjjSa+iVjzWr1zCHQ+GPJx8SLZ1Ti/L93i72oG/q4ofx87VY
        YuSm4CEOZqbnjZMrmWjMDxrR3P8anZy2yg==
X-Google-Smtp-Source: AMrXdXu3VVBtG/fSfaPlzkWhWg9IyCpTFIaOunhEW3V70RJ/HEKxLmoFfZfpcNx0WsH0P6JM/5tUyg==
X-Received: by 2002:a4a:c20a:0:b0:4f3:6e99:e6d2 with SMTP id z10-20020a4ac20a000000b004f36e99e6d2mr18235002oop.3.1674933806675;
        Sat, 28 Jan 2023 11:23:26 -0800 (PST)
Received: from ?IPV6:2603:8080:2800:f9bf:eb7:f10d:ceda:48f6? (2603-8080-2800-f9bf-0eb7-f10d-ceda-48f6.res6.spectrum.com. [2603:8080:2800:f9bf:eb7:f10d:ceda:48f6])
        by smtp.gmail.com with ESMTPSA id c22-20020a4a2856000000b004fb2935d0e7sm3039411oof.36.2023.01.28.11.23.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Jan 2023 11:23:26 -0800 (PST)
Message-ID: <883a3b03-a596-8279-1278-bc622114aab5@gmail.com>
Date:   Sat, 28 Jan 2023 13:23:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
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
From:   Alexandre Peixoto Ferreira <alexandref75@gmail.com>
In-Reply-To: <Y9RlpyV5JPz/hk1K@krava>
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

Jirka and Daniel,

On 1/27/23 18:00, Jiri Olsa wrote:
> On Fri, Jan 27, 2023 at 04:28:54PM -0600, Alexandre Peixoto Ferreira wrote:
>>
>> On 1/24/23 00:13, Daniel Xu wrote:
>>> Hi Jiri,
>>>
>>> On Mon, Jan 23, 2023, at 1:06 AM, Jiri Olsa wrote:
>>>> On Sun, Jan 22, 2023 at 10:48:44AM -0700, Daniel Xu wrote:
>>>>> Hi,
>>>>>
>>>>> I'm getting the following error during build:
>>>>>
>>>>>           $ ./tools/testing/selftests/bpf/vmtest.sh -j30
>>>>>           [...]
>>>>>             BTF     .btf.vmlinux.bin.o
>>>>>           btf_encoder__encode: btf__dedup failed!
>>>>>           Failed to encode BTF
>>>>>             LD      .tmp_vmlinux.kallsyms1
>>>>>             NM      .tmp_vmlinux.kallsyms1.syms
>>>>>             KSYMS   .tmp_vmlinux.kallsyms1.S
>>>>>             AS      .tmp_vmlinux.kallsyms1.S
>>>>>             LD      .tmp_vmlinux.kallsyms2
>>>>>             NM      .tmp_vmlinux.kallsyms2.syms
>>>>>             KSYMS   .tmp_vmlinux.kallsyms2.S
>>>>>             AS      .tmp_vmlinux.kallsyms2.S
>>>>>             LD      .tmp_vmlinux.kallsyms3
>>>>>             NM      .tmp_vmlinux.kallsyms3.syms
>>>>>             KSYMS   .tmp_vmlinux.kallsyms3.S
>>>>>             AS      .tmp_vmlinux.kallsyms3.S
>>>>>             LD      vmlinux
>>>>>             BTFIDS  vmlinux
>>>>>           FAILED: load BTF from vmlinux: No such file or directory
>>>>>           make[1]: *** [scripts/Makefile.vmlinux:35: vmlinux] Error 255
>>>>>           make[1]: *** Deleting file 'vmlinux'
>>>>>           make: *** [Makefile:1264: vmlinux] Error 2
>>>>>
>>>>> This happens on both bpf-next/master (84150795a49) and 6.2-rc5
>>>>> (2241ab53cb).
>>>>>
>>>>> I've also tried arch linux pahole 1:1.24+r29+g02d67c5-1 as well as
>>>>> upstream pahole on master (02d67c5176) and upstream pahole on
>>>>> next (2ca56f4c6f659).
>>>>>
>>>>> Of the above 6 combinations, I think I've tried all of them (maybe
>>>>> missing 1 or 2).
>>>>>
>>>>> Looks like GCC got updated recently on my machine, so perhaps
>>>>> it's related?
>>>>>
>>>>>           CONFIG_CC_VERSION_TEXT="gcc (GCC) 12.2.1 20230111"
>>>>>
>>>>> I'll try some debugging, but just wanted to report it first.
>>>> hi,
>>>> I can't reproduce that.. can you reproduce it outside vmtest.sh?
>>>>
>>>> there will be lot of output with patch below, but could contain
>>>> some more error output
>>> Thanks for the hints. Doing a regular build outside of vmtest.sh
>>> seems to work ok. So maybe it's a difference in the build config.
>>>
>>> I'll put a little more time into debugging to see if it goes anywhere.
>>> But I'll have to get back to the regularly scheduled programming
>>> soon.
>> 6.2-rc5 compiles correctly when CONFIG_X86_KERNEL_IBT is commented but fails
>> in pahole when CONFIG_X86_KERNEL_IBT is set.
> could you plese attach your config and the build error?
> I can't reproduce that
>
> thanks,
> jirka

My working .config is available at https://pastebin.pl/view/bef3765c
change CONFIG_X86_KERNEL_IBT to y to get the error.

The error is similar to Daniel's and is shown below:

   LD      .tmp_vmlinux.btf
   BTF     .btf.vmlinux.bin.o
btf_encoder__encode: btf__dedup failed!
Failed to encode BTF
   LD      .tmp_vmlinux.kallsyms1
   NM      .tmp_vmlinux.kallsyms1.syms
   KSYMS   .tmp_vmlinux.kallsyms1.S
   AS      .tmp_vmlinux.kallsyms1.S
   LD      .tmp_vmlinux.kallsyms2
   NM      .tmp_vmlinux.kallsyms2.syms
   KSYMS   .tmp_vmlinux.kallsyms2.S
   AS      .tmp_vmlinux.kallsyms2.S
   LD      .tmp_vmlinux.kallsyms3
   NM      .tmp_vmlinux.kallsyms3.syms
   KSYMS   .tmp_vmlinux.kallsyms3.S
   AS      .tmp_vmlinux.kallsyms3.S
   LD      vmlinux
   BTFIDS  vmlinux
FAILED: load BTF from vmlinux: No such file or directory
make[1]: *** [scripts/Makefile.vmlinux:35: vmlinux] Error 255
make[1]: *** Deleting file 'vmlinux'
make: *** [Makefile:1264: vmlinux] Error 2


Thanks,

-- 
Alexandre Peixoto Ferreira

