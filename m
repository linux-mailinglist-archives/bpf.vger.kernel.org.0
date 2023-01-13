Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B639669D06
	for <lists+bpf@lfdr.de>; Fri, 13 Jan 2023 16:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjAMP7H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Jan 2023 10:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjAMP5p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Jan 2023 10:57:45 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4644814D27
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 07:49:10 -0800 (PST)
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pGMIl-0002B4-8B; Fri, 13 Jan 2023 16:49:07 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1pGMIl-000SwQ-2c; Fri, 13 Jan 2023 16:49:07 +0100
Subject: Re: [PATCH] bpftool: Always disable stack protection for clang
To:     Quentin Monnet <quentin@isovalent.com>,
        =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>,
        bpf@vger.kernel.org
Cc:     Sam James <sam@gentoo.org>
References: <74cd9d2e-6052-312a-241e-2b514a75c92c@applied-asynchrony.com>
 <6bd4e7e8-451f-b5f3-3828-d7db84c0ee15@isovalent.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <c12a019f-457c-51ce-4ce4-5e73bbb0cfa7@iogearbox.net>
Date:   Fri, 13 Jan 2023 16:49:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <6bd4e7e8-451f-b5f3-3828-d7db84c0ee15@isovalent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.7/26780/Fri Jan 13 09:37:02 2023)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/13/23 3:13 PM, Quentin Monnet wrote:
> 2023-01-13 14:49 UTC+0100 ~ Holger Hoffstätte
> <holger@applied-asynchrony.com>
>>
>> When the clang toolchain has stack protection enabled in order to be
>> consistent
>> with gcc - which just happens to be the case on Gentoo - the bpftool build
>> fails:
>>
>> clang \
>>      -I. \
>>      -I/tmp/portage/dev-util/bpftool-6.0.12/work/linux-6.0/tools/include/uapi/ \
>>      -I/tmp/portage/dev-util/bpftool-6.0.12/work/linux-6.0/tools/bpf/bpftool/bootstrap/libbpf/include \
>>      -g -O2 -Wall -target bpf -c skeleton/pid_iter.bpf.c -o pid_iter.bpf.o
>> clang \
>>      -I. \
>>      -I/tmp/portage/dev-util/bpftool-6.0.12/work/linux-6.0/tools/include/uapi/ \
>>      -I/tmp/portage/dev-util/bpftool-6.0.12/work/linux-6.0/tools/bpf/bpftool/bootstrap/libbpf/include \
>>      -g -O2 -Wall -target bpf -c skeleton/profiler.bpf.c -o profiler.bpf.o
>> skeleton/profiler.bpf.c:40:14: error: A call to built-in function
>> '__stack_chk_fail' is not supported.
>> int BPF_PROG(fentry_XXX)
>>               ^
>> skeleton/profiler.bpf.c:94:14: error: A call to built-in function
>> '__stack_chk_fail' is not supported.
>> int BPF_PROG(fexit_XXX)
>>               ^
>> 2 errors generated.
>>
>> Since stack-protector makes no sense for the BPF bits just unconditionally
>> disable it.
>>
>> Bug: https://bugs.gentoo.org/890638
>> Signed-off-by: Holger Hoffstätte <holger@applied-asynchrony.com>
>>
>> --snip--
>>
>> diff a/src/Makefile b/src/Makefile
>> --- a/src/Makefile
>> +++ b/src/Makefile
>> @@ -205,7 +205,7 @@ $(OUTPUT)%.bpf.o: skeleton/%.bpf.c
>> $(OUTPUT)vmlinux.h $(LIBBPF_BOOTSTRAP)
>>           -I$(or $(OUTPUT),.) \
>>           -I$(srctree)/include/uapi/ \
>>           -I$(LIBBPF_BOOTSTRAP_INCLUDE) \
>> -        -g -O2 -Wall -target bpf -c $< -o $@
>> +        -g -O2 -Wall -fno-stack-protector -target bpf -c $< -o $@
>>       $(Q)$(LLVM_STRIP) -g $@
>>   
>>   $(OUTPUT)%.skel.h: $(OUTPUT)%.bpf.o $(BPFTOOL_BOOTSTRAP)
> 
> Right, I understand we don't want it when compiling the BPF program from
> the skeleton. Looks good, thank you!
> 
> Acked-by: Quentin Monnet <quentin@isovalent.com>

LGTM, thanks Holger! Looks like this patch is against GH mirror (https://github.com/libbpf/bpftool).
Manually applied it to the upstream tree:
https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=878625e1c7a10dfbb1fdaaaae2c4d2a58fbce627

Thanks,
Daniel
