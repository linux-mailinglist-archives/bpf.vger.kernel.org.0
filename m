Return-Path: <bpf+bounces-9066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC17B78EFBC
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 16:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4F562815CE
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 14:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B8311730;
	Thu, 31 Aug 2023 14:44:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BD5257D
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 14:44:12 +0000 (UTC)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC681B1
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 07:44:09 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-26b44247123so642395a91.2
        for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 07:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693493049; x=1694097849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bVBoZo3DKr9GHpFELDyjgEYOJi+ZjPYs7y1CWrUvKz0=;
        b=GlSJISfTU4E0xx9qs4ygPD9qZc07HxC4w/93EtvSnYZl167YJYb2rxde2J5Tu/qCRs
         YA8DbWsuiR4J+gRrCVjCp6r89P5hUGHpeHGFfDiKSwzbmsREqy4Yyfb3+7q61mEtPL2O
         OXF+5C++ANGYTVlRT0xuIpQyvES7PYei6utwyGSZ0eXqDv0Wh/KHN5aJGk+Y7a+01kZO
         jAc0rGuAFKL7Vf+qEpqgAnhTf2uF5VyN7eHy+Y5DHL34OckmZd8+Cy7inH0ziI6dsWi3
         AyaSb8ZAa/vV9MnttvOTYxkJqoeL3JNB2TtFC4f/B4AxBKLN1Bw+Un+yZi1uq7NTcZp5
         kpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693493049; x=1694097849;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bVBoZo3DKr9GHpFELDyjgEYOJi+ZjPYs7y1CWrUvKz0=;
        b=b14DtygzEtzmliFqQCz9jGLKksXGt0E9gJHUAzA8YsabvwGYHWbCRjFRVyhMK+YKKm
         45+14ImeJI47FQeDtvJ2Xcb22e4oVNGwYWYhor7OOguNg1Vlq/xdNDhWCcphruepYc14
         4evVuc6ANf6i9+Fth8//5u6MBa2l5Y480gbxnD4zauiN7lEuS/rzRd/PioJtZCbVWINC
         mLBBSygjaCS6dzbGRCViYa/3Tqz4vu0ixDINHwFVvOAruLWhSZh2fyIzPzQgcWsfqjEE
         g1oED2LKXcYd/ztuV3mrBENUU5+tknD+kYICMMrIJqO2SJKo8l6Nctt0Kww9sVY4LowE
         85dQ==
X-Gm-Message-State: AOJu0YxjxbHhXWYDxiZ28tnWongDWCfvtozEv/aOcraox9LUKC7ltaC7
	KNW5I7cC3XqB3iJ9AeN++CD8jkmcXfo=
X-Google-Smtp-Source: AGHT+IHQiwLMi93Z7hB/uurvC9LDVSTQVHI4ktXgn3/nfHmKGEmds68DOmkGBlo/0zMMD85Ij2BsLA==
X-Received: by 2002:a17:90a:6945:b0:269:154b:6290 with SMTP id j5-20020a17090a694500b00269154b6290mr5071345pjm.24.1693493048848;
        Thu, 31 Aug 2023 07:44:08 -0700 (PDT)
Received: from [192.168.1.12] (bb116-14-95-136.singnet.com.sg. [116.14.95.136])
        by smtp.gmail.com with ESMTPSA id gq18-20020a17090b105200b0026f4bb8b2casm3089384pjb.6.2023.08.31.07.44.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 07:44:08 -0700 (PDT)
Message-ID: <a4cb884b-a619-bb42-9d0d-b5af65708ed9@gmail.com>
Date: Thu, 31 Aug 2023 22:44:04 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [RFC PATCH bpf-next v3 1/2] bpf, x64: Fix tailcall infinite loop
Content-Language: en-US
From: Leon Hwang <hffilwlqm@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
 bpf@vger.kernel.org
References: <20230825145216.56660-1-hffilwlqm@gmail.com>
 <20230825145216.56660-2-hffilwlqm@gmail.com> <ZOjrviql/e/14X4a@boxer>
 <238be72c-2a19-f675-83cb-18051937d8fd@gmail.com> <ZO/HjKo+x6SU4vXa@boxer>
 <e573b963-891f-0c7e-42d7-c876fa416a8a@gmail.com>
In-Reply-To: <e573b963-891f-0c7e-42d7-c876fa416a8a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/8/31 21:12, Leon Hwang wrote:
> 
> 
> On 2023/8/31 06:49, Maciej Fijalkowski wrote:
>> On Sat, Aug 26, 2023 at 12:03:12PM +0800, Leon Hwang wrote:
>>>
>>>
>>> On 2023/8/26 01:58, Maciej Fijalkowski wrote:
>>>> On Fri, Aug 25, 2023 at 10:52:15PM +0800, Leon Hwang wrote:
>>>>> From commit ebf7d1f508a73871 ("bpf, x64: rework pro/epilogue and tailcall
>>>>> handling in JIT"), the tailcall on x64 works better than before.
>>>>>
>>>>> From commit e411901c0b775a3a ("bpf: allow for tailcalls in BPF subprograms
>>>>> for x64 JIT"), tailcall is able to run in BPF subprograms on x64.
>>>>>
>>>>> From commit 5b92a28aae4dd0f8 ("bpf: Support attaching tracing BPF program
>>>>> to other BPF programs"), BPF program is able to trace other BPF programs.
>>>>>
>>>>> How about combining them all together?
>>>>>
>>>>> 1. FENTRY/FEXIT on a BPF subprogram.
>>>>> 2. A tailcall runs in the BPF subprogram.
>>>>> 3. The tailcall calls itself.
>>>>
>>>> I would be interested in seeing broken asm code TBH :)
>>>>
>>>>>
>>>>> As a result, a tailcall infinite loop comes up. And the loop would halt
>>>>> the machine.
>>>>>
>>>>> As we know, in tail call context, the tail_call_cnt propagates by stack
>>>>> and rax register between BPF subprograms. So do it in trampolines.
>>>>>
>>>>> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
>>>>> ---
>>>>>  arch/x86/net/bpf_jit_comp.c | 32 ++++++++++++++++++++++++++------
>>>>>  include/linux/bpf.h         |  5 +++++
>>>>>  kernel/bpf/trampoline.c     |  4 ++--
>>>>>  kernel/bpf/verifier.c       | 30 +++++++++++++++++++++++-------
>>>>>  4 files changed, 56 insertions(+), 15 deletions(-)
>>>>>
> 
> [SNIP]
> 
>>>>>  
>>>>> +	if (tgt_prog && tgt_prog->aux->tail_call_reachable) {
>>>>> +		subprog = find_subprog_index(tgt_prog, btf_id);
>>>>> +		tr->flags = subprog > 0 ? BPF_TRAMP_F_TAIL_CALL_CTX : 0;
>>>>> +	}
>>>>
>>>> I kinda forgot trampoline internals so please bear with me.
>>>> Here you are checking actually...what? That current program is a subprog
>>>> of tgt prog? My knee jerk reaction would be to propagate the
>>>> BPF_TRAMP_F_TAIL_CALL_CTX based on just tail_call_reachable, but I need
>>>> some more time to get my head around it again, sorry :<
>>>
>>> Yeah, that current program must be a subprog of tgt prog.
>>>
>>> For example:
>>>
>>> tailcall_subprog() {
>>>   bpf_tail_call_static(&jmp_table, 0);
>>> }
>>>
>>> tailcall_prog() {
>>>   tailcall_subprog();
>>> }
>>>
>>> prog() {
>>>   bpf_tail_call_static(&jmp_table, 0);
>>> }
>>>
>>> jmp_table populates with tailcall_prog().
>>>
>>> When do fentry on prog(), there's no tail_call_cnt for fentry to
>>> propagate. As we can see in emit_prologue(), fentry runs before
>>> initialising tail_call_cnt.
>>>
>>> When do fentry on tailcall_prog()? NO, it's impossible to do fentry on
>>> tailcall_prog(). Because the tailcall 'jmp' skips the fentry on
>>> tailcall_prog().
>>>
>>> And, when do fentry on tailcall_subprog(), fentry has to propagate
>>> tail_call_cnt properly.
>>>
>>> In conclusion, that current program must be a subprog of tgt prog.
>>
>> Verifier propagates the info about tail call usage through whole call
>> chain on a given prog so this doesn't really matter to me where do we
>> attach fentry progs. All I'm saying is:
>>
>> 	if (tgt_prog && tgt_prog->aux->tail_call_reachable)
>> 		tr->flags = BPF_TRAMP_F_TAIL_CALL_CTX;
>>
>> should be just fine. I might be missing something but with above your
>> selftest does not hang my system.
> 
> I think it's unnecessary to propagate tail call usage info when do
> fentry on prog(), which is the entry of the whole tail call context. If
> do propagate in this case, it's meaningless to execute two extra
> instructions.

Because it's harmless, I agree with you. I'll change it to

 	if (tgt_prog && tgt_prog->aux->tail_call_reachable)
 		tr->flags = BPF_TRAMP_F_TAIL_CALL_CTX;

With this update, it's easier to understand BPF_TRAMP_F_TAIL_CALL_CTX.

> 
> I confirm that the above selftest is able to hang VM. I copy test_progs
> along with tailcall*.bpf.o to another VM, which is Ubuntu 22.04.3 with
> kernel 5.15.0-82-generic, then run ./test_progs -t tailcalls. And then
> the VM hangs.
> 
> Here's the Ubuntu 22.04.3 VM info:
> # uname -a
> Linux hwang 5.15.0-82-generic #91-Ubuntu SMP Mon Aug 14 14:14:14 UTC
> 2023 x86_64 x86_64 x86_64 GNU/Linux

What I suggest here is to run the selftest in the second patch, not the
above example.

Thanks,
Leon

