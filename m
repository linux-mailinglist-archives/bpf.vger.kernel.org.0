Return-Path: <bpf+bounces-21787-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDE3852169
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 23:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 544B8B24BF6
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 22:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087A54DA19;
	Mon, 12 Feb 2024 22:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvDK9/5o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994E447A53
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 22:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707776930; cv=none; b=GeZ3PgrfUAQlht2uKz8H/DPaZd3YcFie0lAJ51UqYKreC0Ekt5C+gUbjnG1qbn60Qm6OsszGK7cMD07Bm62mEdQ+enxw7BwrQjumyn2HnMwVCxOJlqJYq4h6nEgf0ogdWHaxTMlBGmZQsjr7rpTNeQCZV7oKqCGdTrGhJvD9Bic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707776930; c=relaxed/simple;
	bh=fuNF5p7C3n9kLUvb/rOEOHU8gXCvURk+3rNB3nl4Jhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DigCf+5uMwciMU+ER1XU0k9wnrHLV+wOiIWQajHQFpgvnWJatkBmXPcHTxrZV6s0DXpxhKp1W8hzblR8frZn98URsJVKLxOcXDGBWd+37UfJ01msgaFMS9oQfi7MBEUZQ4YQ7Kr6GlDOdb+brlFFpx1tzceTRkXwjQxEYY/hBVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PvDK9/5o; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-a3ce44c5ac0so79695166b.1
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 14:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707776927; x=1708381727; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E86ds0/tGSS87+vPdak/q9no1DqALHEjVnejstSDDIw=;
        b=PvDK9/5oeHL1Y9U38+U1upOw7MP2Y3wW9jn6YEJmP1EScKK6YH/lzlXsqlU/Gri9uf
         tz7Ph0uSooIMljMOATEfs3yJqxmzGI4wdU/OA1mIQcwnpogKZLh4jDnNwEY4MKWxSvbq
         venmdo07vr5I+LSK22F/rRv2VV2zh0c3X8OfIllKdBcssbRhtq/ZsHLrijoFx3G8uYwj
         wOlF2jmj60WvOXQyYnqwvwJfXwMQ8hlepbkGHZusL8vdYKWy9zJdu4LEffAVJ1N4xwJU
         vJDYx6uMoxVov4X0h9eLr3wzLqT3JU7yfQv0GRnJe+mBCX8hYOrutaDZVXdfCVCeaE8L
         vNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707776927; x=1708381727;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E86ds0/tGSS87+vPdak/q9no1DqALHEjVnejstSDDIw=;
        b=IvrXuYbaEshzxuYZjuAOkzBZUtcDJff4fC3d/wZYmfShMB4s3yjW+9icxr19tZSJKz
         oPn0w+Ro6O08yMyr5Ge4YC2gD6L30WRF/fyzDARrZ/iL7jxJyMXE+b3JjayCy8gU+t3L
         S36Gttzb/JKVNztSF82cfNkZjtQ+xbcigKxQFI1/YWX0uOx0oYWkrVD1YgVqXQcowCF3
         QXX+H9aAuOzIrU3v5JY40JhD2zH0BkcY1RozuHUwENT+lwW7y/8nbxZHsiNhncLnCK22
         F6YPlHHjvv6ooYusOItmAa3J26iwkFR1VWIAudMMV80+2NIZ0wTDiRSNxLmFsAio/ZoQ
         BLOA==
X-Gm-Message-State: AOJu0YwX1ecSUKc6tccO2Ko/AwzCTjNUHSrRMM04xVyCzlGI3RHul2Ac
	cYf/w9uBl4aZHiFnWB4i6P1+5mygtK1sOv+/1d5h7QvPVKK+zVkV1Fg4fLQNZEK3IPLk2RaWLw1
	0tBk6kt2o1PCOfsq2I1glg2bSIZs=
X-Google-Smtp-Source: AGHT+IHRrsBPPqwOsN7+2sXhhm/tNDe74jR9Qvl/DZnF9lII1qFPIgaFWFihI77jTrmIMpP/kWg2YUQBFmzd0jxJNvs=
X-Received: by 2002:a17:906:7f12:b0:a3c:b9b7:8067 with SMTP id
 d18-20020a1709067f1200b00a3cb9b78067mr2593930ejr.58.1707776926625; Mon, 12
 Feb 2024 14:28:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201042109.1150490-1-memxor@gmail.com> <20240201042109.1150490-2-memxor@gmail.com>
 <20240212193547.GB2200361@maniforge.lan>
In-Reply-To: <20240212193547.GB2200361@maniforge.lan>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 12 Feb 2024 23:28:10 +0100
Message-ID: <CAP01T76dLSoEuaOSe0NGm+ainmJF1XNBpJazY0w+aB3R0KdMbw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 01/14] bpf: Mark subprogs as throw reachable before
 do_check pass
To: David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>, Raj Sahu <rjsu26@vt.edu>, 
	Dan Williams <djwillia@vt.edu>, Rishabh Iyer <rishabh.iyer@epfl.ch>, 
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Feb 2024 at 20:35, David Vernet <void@manifault.com> wrote:
>
> On Thu, Feb 01, 2024 at 04:20:56AM +0000, Kumar Kartikeya Dwivedi wrote:
> > The motivation of this patch is to figure out which subprogs participate
> > in exception propagation. In other words, whichever subprog's execution
> > can lead to an exception being thrown either directly or indirectly (by
> > way of calling other subprogs).
> >
> > With the current exceptions support, the runtime performs stack
> > unwinding when bpf_throw is called. For now, any resources acquired by
> > the program cannot be released, therefore bpf_throw calls made with
> > non-zero acquired references must be rejected during verification.
> >
> > However, there currently exists a loophole in this restriction due to
> > the way the verification procedure is structured. The verifier will
> > first walk over the main subprog's instructions, but not descend into
> > subprog calls to ones with global linkage. These global subprogs will
> > then be independently verified instead. Therefore, in a situation where
> > a global subprog ends up throwing an exception (either directly by
> > calling bpf_throw, or indirectly by way of calling another subprog that
> > does so), the verifier will fail to notice this fact and may permit
> > throwing BPF exceptions with non-zero acquired references.
> >
> > Therefore, to fix this, we add a summarization pass before the do_check
> > stage which walks all call chains of the program and marks all of the
> > subprogs that are reachable from a bpf_throw call which unwinds the
> > program stack.
> >
> > We only do so if we actually see a bpf_throw call in the program though,
> > since we do not want to walk all instructions unless we need to.  One we
>
> s/Once/once
>

Ack, will fix.

> > analyze all possible call chains of the program, we will be able to mark
> > them as 'is_throw_reachable' in their subprog_info.
> >
> > After performing this step, we need to make another change as to how
> > subprog call verification occurs. In case of global subprog, we will
> > need to explore an alternate program path where the call instruction
> > processing of a global subprog's call will immediately throw an
> > exception. We will thus simulate a normal path without any exceptions,
> > and one where the exception is thrown and the program proceeds no
> > further. In this way, the verifier will be able to detect the whether
> > any acquired references or locks exist in the verifier state and thus
> > reject the program if needed.
> >
> > Fixes: f18b03fabaa9 ("bpf: Implement BPF exceptions")
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> Just had a few nits and one question. Looks reasonable to me overall.
>
> > ---
> >  include/linux/bpf_verifier.h |  2 +
> >  kernel/bpf/verifier.c        | 86 ++++++++++++++++++++++++++++++++++++
> >  2 files changed, 88 insertions(+)
> >
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > index 0dcde339dc7e..1d666b6c21e6 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -626,6 +626,7 @@ struct bpf_subprog_info {
> >       bool is_async_cb: 1;
> >       bool is_exception_cb: 1;
> >       bool args_cached: 1;
> > +     bool is_throw_reachable: 1;
> >
> >       u8 arg_cnt;
> >       struct bpf_subprog_arg_info args[MAX_BPF_FUNC_REG_ARGS];
> > @@ -691,6 +692,7 @@ struct bpf_verifier_env {
> >       bool bypass_spec_v4;
> >       bool seen_direct_write;
> >       bool seen_exception;
> > +     bool seen_throw_insn;
> >       struct bpf_insn_aux_data *insn_aux_data; /* array of per-insn state */
> >       const struct bpf_line_info *prev_linfo;
> >       struct bpf_verifier_log log;
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index cd4d780e5400..bba53c4e3a0c 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -2941,6 +2941,8 @@ static int check_subprogs(struct bpf_verifier_env *env)
> >                   insn[i].src_reg == 0 &&
> >                   insn[i].imm == BPF_FUNC_tail_call)
> >                       subprog[cur_subprog].has_tail_call = true;
> > +             if (!env->seen_throw_insn && is_bpf_throw_kfunc(&insn[i]))
> > +                     env->seen_throw_insn = true;
> >               if (BPF_CLASS(code) == BPF_LD &&
> >                   (BPF_MODE(code) == BPF_ABS || BPF_MODE(code) == BPF_IND))
> >                       subprog[cur_subprog].has_ld_abs = true;
> > @@ -5866,6 +5868,9 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx)
> >
> >                       if (!is_bpf_throw_kfunc(insn + i))
> >                               continue;
> > +                     /* When this is allowed, don't forget to update logic for sync and
> > +                      * async callbacks in mark_exception_reachable_subprogs.
> > +                      */
> >                       if (subprog[idx].is_cb)
> >                               err = true;
> >                       for (int c = 0; c < frame && !err; c++) {
> > @@ -16205,6 +16210,83 @@ static int check_btf_info(struct bpf_verifier_env *env,
> >       return 0;
> >  }
> >
> > +/* We walk the call graph of the program in this function, and mark everything in
> > + * the call chain as 'is_throw_reachable'. This allows us to know which subprog
> > + * calls may propagate an exception and generate exception frame descriptors for
> > + * those call instructions. We already do that for bpf_throw calls made directly,
> > + * but we need to mark the subprogs as we won't be able to see the call chains
> > + * during symbolic execution in do_check_common due to global subprogs.
> > + *
> > + * Note that unlike check_max_stack_depth, we don't explore the async callbacks
> > + * apart from main subprogs, as we don't support throwing from them for now, but
>
> Comment ending prematurely
>

Ack.

> > + */
> > +static int mark_exception_reachable_subprogs(struct bpf_verifier_env *env)
> > +{
> > +     struct bpf_subprog_info *subprog = env->subprog_info;
> > +     struct bpf_insn *insn = env->prog->insnsi;
> > +     int idx = 0, frame = 0, i, subprog_end;
> > +     int ret_insn[MAX_CALL_FRAMES];
> > +     int ret_prog[MAX_CALL_FRAMES];
> > +
> > +     /* No need if we never saw any bpf_throw() call in the program. */
> > +     if (!env->seen_throw_insn)
> > +             return 0;
> > +
> > +     i = subprog[idx].start;
> > +restart:
> > +     subprog_end = subprog[idx + 1].start;
> > +     for (; i < subprog_end; i++) {
> > +             int next_insn, sidx;
> > +
> > +             if (bpf_pseudo_kfunc_call(insn + i) && !insn[i].off) {
>
> When should a kfunc call ever have a nonzero offset? We use the
> immediate for the BTF ID, don't we?
>

So in kfuncs, insn.off is used to indicate a vmlinux vs module kfunc.
If off is non-zero, it points to the index in the bpf_attr::fd_array
of the module BTF from which this kfunc comes.
But I think it might be easier to just remove this extra test and do
is_bpf_throw_kfunc directly.

> > +                     if (!is_bpf_throw_kfunc(insn + i))
> > +                             continue;
> > +                     subprog[idx].is_throw_reachable = true;
> > +                     for (int j = 0; j < frame; j++)
> > +                             subprog[ret_prog[j]].is_throw_reachable = true;
> > +             }
> > +
> > +             if (!bpf_pseudo_call(insn + i) && !bpf_pseudo_func(insn + i))
> > +                     continue;
> > +             /* remember insn and function to return to */
> > +             ret_insn[frame] = i + 1;
> > +             ret_prog[frame] = idx;
> > +
> > +             /* find the callee */
> > +             next_insn = i + insn[i].imm + 1;
> > +             sidx = find_subprog(env, next_insn);
> > +             if (sidx < 0) {
> > +                     WARN_ONCE(1, "verifier bug. No program starts at insn %d\n", next_insn);
> > +                     return -EFAULT;
> > +             }
> > +             /* We cannot distinguish between sync or async cb, so we need to follow
> > +              * both.  Async callbacks don't really propagate exceptions but calling
> > +              * bpf_throw from them is not allowed anyway, so there is no harm in
> > +              * exploring them.
> > +              * TODO: To address this properly, we will have to move is_cb,
> > +              * is_async_cb markings to the stage before do_check.
> > +              */
> > +             i = next_insn;
> > +             idx = sidx;
> > +
> > +             frame++;
> > +             if (frame >= MAX_CALL_FRAMES) {
> > +                     verbose(env, "the call stack of %d frames is too deep !\n", frame);
> > +                     return -E2BIG;
> > +             }
> > +             goto restart;
> > +     }
> > +     /* end of for() loop means the last insn of the 'subprog'
> > +      * was reached. Doesn't matter whether it was JA or EXIT
> > +      */
> > +     if (frame == 0)
> > +             return 0;
> > +     frame--;
> > +     i = ret_insn[frame];
> > +     idx = ret_prog[frame];
> > +     goto restart;
> > +}
>
> If you squint youre eyes there's a non-trivial amount of duplicated
> intent / logic here compared to check_max_stack_depth_subprog(). Do you
> think it would be possible to combine them somehow?
>

I agree, this function is mostly a copy-paste of that function with
some modifications.
I will take a stab at unifying both in the next version, though I
think they will end up calling some common logic from different points
as we need to do this marking before verification, and stack depth
checking after verification. Also, stack depth checks have some other
exception_cb and async_cb related checks as well, so this would
probably be a good opportunity to refactor that code as well.

Basically, just have a common way to iterate over all instructions and
call chains starting from some instruction in a subprog.

> > [...]
> >

