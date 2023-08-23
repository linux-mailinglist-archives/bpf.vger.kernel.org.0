Return-Path: <bpf+bounces-8334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0916784E68
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 03:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0F591C20BCF
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 01:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F8815AE;
	Wed, 23 Aug 2023 01:49:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858B810E9
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 01:49:23 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE46E4A
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 18:49:22 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3a7d7e5fb03so3809301b6e.3
        for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 18:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692755361; x=1693360161;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PFjBWXc5tEiko6dBAVxG34VqpCO7h9/tnBwKfk0Qjys=;
        b=D2hMvkD9C4nfy+Ez7a4Fq6sOu0/gtOp4I/w/edDuGpfo+xGKzHmoASfjCxhgkcMftB
         6ObBLBvyHOK5pBPylR1h/55z2wbKtBeAQMboE8JBcjumEbjBW2co2qeYMrZkoGs5guyb
         7pz9FuSugvSozTBA9ZLh3jwb6l/v7+lXT1yMMON104bsTXk6BdPVNMG+xPduawFEmXHe
         xPBZSSW0SZwMuO9ow81BixASYEn5zhFS+BbTgTJINTPkuK1ITibKfkq/i3jusZcra4a5
         iPtUK+UEtUjlQcBvsgsJpY38L4dUhgkTvIa5GM0L3wQpOxy4kK3ZZLA+BhL30y9gCD9r
         KVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692755361; x=1693360161;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PFjBWXc5tEiko6dBAVxG34VqpCO7h9/tnBwKfk0Qjys=;
        b=IfEl715nYhgR6chOn40lq0EdvGBNOy0JKTMUuIGZXOK729dLlqjM0lDIWjCLVMk9cB
         dOahh4avEIJ+xOYcRLeM+KiS/LNEa/rg1lv4oyOThNbfSrTfLVNExgjXjg3DvglP4jKv
         pEG7a8O+z1xFxvSXUXCgut3AiRdUBPh78ueKDir+RpkwDq9rHE1/tGME4Iu7WbiOXnmR
         Gai8y1tYg8Q2i87NGSFa6rHb2yvtCkExSpO/YxnXiTd+E8ER/MnLE3HL10l96DFSXds4
         Mo7R2sf6oacHcEecE9SU9pqjVxmqYYtO51uO/62r8nHkQ+hK0APtiyLvbeTh/5DE0mRU
         coeA==
X-Gm-Message-State: AOJu0YwiQiHyvTwp3WD/SAOkZrX/mQ1SRegSb4bEFgFvhMdpTAj3Lj2f
	/lek1LfN0fc0T6qLNoS1BUE=
X-Google-Smtp-Source: AGHT+IEUndEWUaXch4blLtAsvtbI3f8rJ1WMrxSPjqLe1qCJB0XfyO9ekxJKJg2LgXde4MXpF6MN5w==
X-Received: by 2002:aca:674d:0:b0:3a4:67b6:454e with SMTP id b13-20020aca674d000000b003a467b6454emr12609490oiy.6.1692755361241;
        Tue, 22 Aug 2023 18:49:21 -0700 (PDT)
Received: from [10.22.68.146] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id i188-20020a639dc5000000b005657495b03bsm8504948pgd.38.2023.08.22.18.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 18:49:20 -0700 (PDT)
Message-ID: <cf022625-7c99-4595-0dd5-46d1f6b73ad9@gmail.com>
Date: Wed, 23 Aug 2023 09:49:17 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [RFC PATCH bpf-next v2 1/2] bpf, x64: Fix tailcall infinite loop
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
 Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>
References: <20230818151216.7686-1-hffilwlqm@gmail.com>
 <20230818151216.7686-2-hffilwlqm@gmail.com>
 <CAADnVQJQqp0WwGoWdsao8hrmmgyc0Me=Mi3gA=FG-i1GFwOozg@mail.gmail.com>
 <3778408b-8f79-5139-0662-55b5d7ca463c@gmail.com>
 <CAADnVQ+znCeeCw+fJizb2Kg-+2Zj8ETR5Bpw4kwZw+MrCq9k3w@mail.gmail.com>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <CAADnVQ+znCeeCw+fJizb2Kg-+2Zj8ETR5Bpw4kwZw+MrCq9k3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 23/8/23 05:29, Alexei Starovoitov wrote:
> On Mon, Aug 21, 2023 at 8:17 PM Leon Hwang <hffilwlqm@gmail.com> wrote:
>>
>>
>>
>> On 22/8/23 06:33, Alexei Starovoitov wrote:
>>> On Fri, Aug 18, 2023 at 8:12 AM Leon Hwang <hffilwlqm@gmail.com> wrote:
>>>>

[SNIP]

>>>>   * sub rsp, 16                     // space for skb and dev
>>>> - * push rbx                        // temp regs to pass start time
>>>> + * mov qword ptr [rbp - 40], rbx   // temp regs to pass start time
>>>> + * mov rax, 2                      // cache number of argument to rax
>>>
>>> What does it mean?
>>
>> I think it's the corresponding instruction to the following code snippet
>> in arch_prepare_bpf_trampoline().
>>
>>         /* Store number of argument registers of the traced function:
>>          *   mov rax, nr_regs
>>          *   mov QWORD PTR [rbp - nregs_off], rax
>>          */
>>         emit_mov_imm64(&prog, BPF_REG_0, 0, (u32) nr_regs);
>>         emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -nregs_off);
> 
> Ahh. I see.
> The comment on top of arch_prepare_bpf_trampoline() is hopelessly obsolete.
> Don't touch it in this patch set. We probably should delete it at some point
> or take an effort to update it thoroughly.

Got it.

> Earlier recommendation to you was to update this comment:
> /* Generated trampoline stack layout:
> 
>>>
>>>> + * mov qword ptr [rbp - 32], rax   // save number of argument to stack
>>>
>>> Here // is ok since it's inside /* */
>>
>> Got it.
>>
>>>
>>>>   * mov qword ptr [rbp - 16], rdi   // save skb pointer to stack
>>>>   * mov qword ptr [rbp - 8], rsi    // save dev pointer to stack
>>>>   * call __bpf_prog_enter           // rcu_read_lock and preempt_disable
>>>> @@ -2323,7 +2331,9 @@ static int invoke_bpf_mod_ret(const struct btf_func_model *m, u8 **pprog,
>>>>   * push rbp
>>>>   * mov rbp, rsp
>>>>   * sub rsp, 24                     // space for skb, dev, return value
>>>> - * push rbx                        // temp regs to pass start time
>>>> + * mov qword ptr [rbp - 40], rbx   // temp regs to pass start time
>>>> + * mov rax, 2                      // cache number of argument to rax
>>>> + * mov qword ptr [rbp - 32], rax   // save number of argument to stack
>>>>   * mov qword ptr [rbp - 24], rdi   // save skb pointer to stack
>>>>   * mov qword ptr [rbp - 16], rsi   // save dev pointer to stack
>>>>   * call __bpf_prog_enter           // rcu_read_lock and preempt_disable
>>>> @@ -2400,6 +2410,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>>>>          *                     [ ...        ]
>>>>          *                     [ stack_arg2 ]
>>>>          * RBP - arg_stack_off [ stack_arg1 ]
>>>> +        * RSP                 [ tail_call_cnt ] BPF_TRAMP_F_TAIL_CALL_CTX
>>>>          */
>>>>
>>>>         /* room for return value of orig_call or fentry prog */
>>>> @@ -2464,6 +2475,8 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>>>>         else
>>>>                 /* sub rsp, stack_size */
>>>>                 EMIT4(0x48, 0x83, 0xEC, stack_size);
>>>> +       if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
>>>> +               EMIT1(0x50);            /* push rax */
>>>>         /* mov QWORD PTR [rbp - rbx_off], rbx */
>>>>         emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_6, -rbx_off);
>>>>
>>>> @@ -2516,9 +2529,15 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>>>>                 restore_regs(m, &prog, regs_off);
>>>>                 save_args(m, &prog, arg_stack_off, true);
>>>>
>>>> +               if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
>>>> +                       /* Before calling the original function, restore the
>>>> +                        * tail_call_cnt from stack to rax.
>>>> +                        */
>>>> +                       RESTORE_TAIL_CALL_CNT(stack_size);
>>>> +
>>>>                 if (flags & BPF_TRAMP_F_ORIG_STACK) {
>>>> -                       emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, 8);
>>>> -                       EMIT2(0xff, 0xd0); /* call *rax */
>>>> +                       emit_ldx(&prog, BPF_DW, BPF_REG_6, BPF_REG_FP, 8);
>>>> +                       EMIT2(0xff, 0xd3); /* call *rbx */ // FIXME: Confirm 0xd3?
>>>
>>> please no FIXME like comments.
>>> You have to be confident in the code you're submitting.
>>> llvm-mc -triple=x86_64 -show-encoding -x86-asm-syntax=intel
>>> -output-asm-variant=1 <<< 'call rbx'
>>
>> Got it. Thanks for the guide.
>>
>>>
>>>>                 } else {
>>>>                         /* call original function */
>>>>                         if (emit_rsb_call(&prog, orig_call, prog)) {

[SNIP]

>>>>
>>>>         if (prog->type == BPF_PROG_TYPE_SYSCALL) {
>>>> @@ -19629,6 +19640,12 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
>>>>         if (!tr)
>>>>                 return -ENOMEM;
>>>>
>>>> +       if (tgt_prog && tgt_prog->aux->tail_call_reachable) {
>>>> +               subprog = find_subprog_index(tgt_prog, btf_id);
>>>> +               tr->flags = subprog > 0 && tgt_prog->aux->func[subprog]->is_func ?
>>>> +                           BPF_TRAMP_F_TAIL_CALL_CTX : 0;
>>>
>>> If prog has subprogs all of them will 'is_func', no?
>>> What's the point of the search ?
>>> Just tgt_prog->aux->tail_call_reachable and func_cnt > 0 would be enough?
>>
>> tgt_prog->aux->tail_call_reachable and subprog > 0 would be enough?
>> It has to confirm that the attaching target is a subprog of tgt_prog instead of
>> tgt_prog itself.
>>
>> In tail call context, when 'call' a func, tail_call_cnt will be restored to rax.
>>
>> static int do_jit() {
>>                         /* call */
>>                 case BPF_JMP | BPF_CALL: {
>>                         int offs;
>>
>>                         func = (u8 *) __bpf_call_base + imm32;
>>                         if (tail_call_reachable) {
>>                                 /* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
>>                                 EMIT3_off32(0x48, 0x8B, 0x85,
>>                                             -round_up(bpf_prog->aux->stack_depth, 8) - 8);
>>                                 /* ... */
>>                         }
>> }
>>
>> As a result, when 'call' a subprog, tail_call_cnt will be transferred by rax.
>> Do all of subprogs run by 'call', including not-'is_func' subprogs?
> 
> Let me ask again. Do you see a subprog that has is_func==0 ?

Oh, I get it.

In jit_subprogs(), all of subprogs are 'is_func'.

So, it's unnecessary to check tgt_prog->aux->func[subprog]->is_func.

I'll submit a new RFC PATCH later.

Thanks,
Leon

