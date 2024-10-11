Return-Path: <bpf+bounces-41749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E1699A802
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 17:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B02E91C230B3
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 15:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4179A195803;
	Fri, 11 Oct 2024 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nn6jWEqw"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70B5194AD7
	for <bpf@vger.kernel.org>; Fri, 11 Oct 2024 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728661149; cv=none; b=ZUYgOH1gQITo2BD6wBOaU1SUznMkgux55lCGfemAqrQ0z/CUgEHy/cD8Objkl17Ljwvoe456DXLl4H4xOef1jRQg3Fe3oFRpIM8kXCwrRKl+oOQrZtvRCWP6fwC/4PlWIjRTtEkSCxfZbl7/GfN6yfqQa8O6MyfhvuIYhBEJNs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728661149; c=relaxed/simple;
	bh=fipySiECgu6YqzaXN1/RXeZbAcD0oc1qyEKj2ZdFAG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y8MDfAOSepA9imN0pJAFQbwh6/8F8ro40tDHtinQiSinvXr1yS/CP1gTuHbTWl3f6RkvOXOsNXfJIrPdXQuuJ603TfC4H7Z2DyeTMp/YhtOSR3+XzOD8kAY5c+G9X4pZaozbe1b/cOCpk9Bnoyc3WUVd4Pmi6UBw6Any7n13Yw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nn6jWEqw; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1ce7840f-aede-457b-aefd-463499fb94b2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728661145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HZ3X0o0TSZdQxvQna+QNgynO+eSYlmJDMyWhi8+2W4M=;
	b=nn6jWEqwNZsxj2dAM4BbQ4wjkBmvadJmjp1RK+eEFTbi4T5xitrGK8EY6hGrE3hyNQ2YC1
	WkxjRgGufTXzuHhemZ50wFZQAesQmgbHQ1/AWtLXcEvk7KY0+NVf5IzOeu6ddE1KGSMG7a
	Kn5Vr13TzYZIevjat+k9gP0Q9/eIJS8=
Date: Fri, 11 Oct 2024 08:38:56 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 09/10] bpf, x86: Jit support for nested
 bpf_prog_call
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 Tejun Heo <tj@kernel.org>
References: <20241010175552.1895980-1-yonghong.song@linux.dev>
 <20241010175638.1899406-1-yonghong.song@linux.dev>
 <CAADnVQJmEkQvAhPs3q1oYGpdO48n2JE3MnMxXgYCMoUup=UOBg@mail.gmail.com>
 <64da4fb8-7e13-41fc-891e-c0f79bf778d1@linux.dev>
 <CAADnVQKyDT+W8-Vgr0GcCmffeKqKjkNrkSa7=GaggcK83vbvYg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQKyDT+W8-Vgr0GcCmffeKqKjkNrkSa7=GaggcK83vbvYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 10/10/24 9:29 PM, Alexei Starovoitov wrote:
> On Thu, Oct 10, 2024 at 9:21 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> On 10/10/24 1:53 PM, Alexei Starovoitov wrote:
>>> On Thu, Oct 10, 2024 at 10:59 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>>>    static void emit_priv_frame_ptr(u8 **pprog, struct bpf_prog *bpf_prog,
>>>> -                               enum bpf_priv_stack_mode priv_stack_mode)
>>>> +                               enum bpf_priv_stack_mode priv_stack_mode,
>>>> +                               bool is_subprog, u8 *image, u8 *temp)
>>>>    {
>>>>           u32 orig_stack_depth = round_up(bpf_prog->aux->stack_depth, 8);
>>>>           u8 *prog = *pprog;
>>>>
>>>> -       if (priv_stack_mode == PRIV_STACK_ROOT_PROG)
>>>> -               emit_root_priv_frame_ptr(&prog, bpf_prog, orig_stack_depth);
>>>> -       else if (priv_stack_mode == PRIV_STACK_SUB_PROG && orig_stack_depth)
>>>> +       if (priv_stack_mode == PRIV_STACK_ROOT_PROG) {
>>>> +               int offs;
>>>> +               u8 *func;
>>>> +
>>>> +               if (!bpf_prog->aux->has_prog_call) {
>>>> +                       emit_root_priv_frame_ptr(&prog, bpf_prog, orig_stack_depth);
>>>> +               } else {
>>>> +                       EMIT1(0x57);            /* push rdi */
>>>> +                       if (is_subprog) {
>>>> +                               /* subprog may have up to 5 arguments */
>>>> +                               EMIT1(0x56);            /* push rsi */
>>>> +                               EMIT1(0x52);            /* push rdx */
>>>> +                               EMIT1(0x51);            /* push rcx */
>>>> +                               EMIT2(0x41, 0x50);      /* push r8 */
>>>> +                       }
>>>> +                       emit_mov_imm64(&prog, BPF_REG_1, (long) bpf_prog >> 32,
>>>> +                                      (u32) (long) bpf_prog);
>>>> +                       func = (u8 *)__bpf_prog_enter_recur_limited;
>>>> +                       offs = prog - temp;
>>>> +                       offs += x86_call_depth_emit_accounting(&prog, func, image + offs);
>>>> +                       emit_call(&prog, func, image + offs);
>>>> +                       if (is_subprog) {
>>>> +                               EMIT2(0x41, 0x58);      /* pop r8 */
>>>> +                               EMIT1(0x59);            /* pop rcx */
>>>> +                               EMIT1(0x5a);            /* pop rdx */
>>>> +                               EMIT1(0x5e);            /* pop rsi */
>>>> +                       }
>>>> +                       EMIT1(0x5f);            /* pop rdi */
>>>> +
>>>> +                       EMIT4(0x48, 0x83, 0xf8, 0x0);   /* cmp rax,0x0 */
>>>> +                       EMIT2(X86_JNE, num_bytes_of_emit_return() + 1);
>>>> +
>>>> +                       /* return if stack recursion has been reached */
>>>> +                       EMIT1(0xC9);    /* leave */
>>>> +                       emit_return(&prog, image + (prog - temp));
>>>> +
>>>> +                       /* cnt -= 1 */
>>>> +                       emit_alu_helper_1(&prog, BPF_ALU64 | BPF_SUB | BPF_K,
>>>> +                                         BPF_REG_0, 1);
>>>> +
>>>> +                       /* accum_stack_depth = cnt * subtree_stack_depth */
>>>> +                       emit_alu_helper_3(&prog, BPF_ALU64 | BPF_MUL | BPF_K, BPF_REG_0,
>>>> +                                         bpf_prog->aux->subtree_stack_depth);
>>>> +
>>>> +                       emit_root_priv_frame_ptr(&prog, bpf_prog, orig_stack_depth);
>>>> +
>>>> +                       /* r9 += accum_stack_depth */
>>>> +                       emit_alu_helper_2(&prog, BPF_ALU64 | BPF_ADD | BPF_X, X86_REG_R9,
>>>> +                                         BPF_REG_0);
>>> That's way too much asm for logic that can stay in C.
>>>
>>> bpf_trampoline_enter() should select __bpf_prog_enter_recur_limited()
>>> for appropriate prog_type/attach_type/etc.
>> The above jit code not just for the main prog, but also for callback fn's
>> since callback fn could call bpf prog as well. So putting in bpf trampoline
>> not enough.
> callback can call the prog only if bpf_call_prog() kfunc exists
> and that's one more reason to avoid going that direction.

Okay, I will add verifier check to prevent bpf_call_prog() in callback functions.


