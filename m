Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E603E4BC0E7
	for <lists+bpf@lfdr.de>; Fri, 18 Feb 2022 20:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239268AbiBRT7M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Feb 2022 14:59:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239004AbiBRT7D (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Feb 2022 14:59:03 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD7A2AE09
        for <bpf@vger.kernel.org>; Fri, 18 Feb 2022 11:58:19 -0800 (PST)
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1nL9OS-0000LD-OV; Fri, 18 Feb 2022 20:58:16 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1nL9OS-000Ccj-Hf; Fri, 18 Feb 2022 20:58:16 +0100
Subject: Re: [PATCH] bpftool: Allow building statically
To:     Quentin Monnet <quentin@isovalent.com>,
        Nikolay Borisov <nborisov@suse.com>, andrii@kernel.org
Cc:     ast@kernel.org, bpf@vger.kernel.org
References: <20220217120435.2245447-1-nborisov@suse.com>
 <8c890e30-d701-0da4-c6f9-f5ca7d80d7ee@isovalent.com>
 <dee15742-da4b-1622-8c0a-cc95a6c7ee91@suse.com>
 <8bc2a0fd-2e54-471f-d908-a0144e0588fe@isovalent.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <3bf83a18-6107-ebbc-bb5d-d61fcfb25fcd@iogearbox.net>
Date:   Fri, 18 Feb 2022 20:58:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <8bc2a0fd-2e54-471f-d908-a0144e0588fe@isovalent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.5/26457/Fri Feb 18 10:25:22 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/18/22 5:33 PM, Quentin Monnet wrote:
> 2022-02-18 18:14 UTC+0200 ~ Nikolay Borisov <nborisov@suse.com>
>> On 18.02.22 г. 18:08 ч., Quentin Monnet wrote:
>>> 2022-02-17 14:04 UTC+0200 ~ Nikolay Borisov <nborisov@suse.com>
>>>> Sometime it can be useful to haul around a statically built version of
>>>> bpftool. Simply add support for passing STATIC=1 while building to build
>>>> the tool statically.
>>>>
>>>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>>>> ---
>>>>
>>>> Currently the bpftool being distributed as part of libbpf-tools under
>>>> bcc project
>>>> is dynamically built on a system using GLIBC 2.28, this makes the
>>>> tool unusable on
>>>> ubuntu 18.04 for example. Perhaps after this patch has landed the
>>>> bpftool in bcc
>>>> can be turned into a static binary.
>>>>
>>>>    tools/bpf/bpftool/Makefile | 4 ++++
>>>>    1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
>>>> index 83369f55df61..835621e215e4 100644
>>>> --- a/tools/bpf/bpftool/Makefile
>>>> +++ b/tools/bpf/bpftool/Makefile
>>>> @@ -13,6 +13,10 @@ else
>>>>      Q = @
>>>>    endif
>>>>
>>>> +ifeq ($(STATIC),1)
>>>> +    CFLAGS += --static
>>>> +endif
>>>> +
>>>>    BPF_DIR = $(srctree)/tools/lib/bpf
>>>>
>>>>    ifneq ($(OUTPUT),)
>>>
>>> Why not just pass the flag on the command line? I don't think the
>>> Makefile overwrites it:
>>>
>>>       $ CFLAGS=--static make
>>
>> Yeah, this also works, I initially thought that overriding a variable on
>> the command line would require having the override directive in the
>> makefile but apparently is not the case. I guess this patch can be
>> scratched.
> 
> You'd need something if the Makefile was initialising the variable, with
> something like "CFLAGS = -O2" or "CFLAGS := -O2". But bpftool's Makefile
> always uses "CFLAGS += ...", meaning it appends to the current value, so
> you can pass whatever you want from the command line, as long as it
> doesn't get overwritten by another flag (for example, passing "-O0"
> would not work I think, since we add "-O2" in the Makefile).

We don't have an in-tree readme, but the `CFLAGS=--static make` use case
could probably be documented in [0] at minimum.

Cheers,
Daniel

   [0] https://github.com/libbpf/bpftool
