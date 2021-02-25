Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCEA032593E
	for <lists+bpf@lfdr.de>; Thu, 25 Feb 2021 23:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbhBYWGw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Feb 2021 17:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhBYWGv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Feb 2021 17:06:51 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3994BC06174A
        for <bpf@vger.kernel.org>; Thu, 25 Feb 2021 14:06:11 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id p193so6979111yba.4
        for <bpf@vger.kernel.org>; Thu, 25 Feb 2021 14:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=abjFEsVw1GdBmzM87jn4ApDC9tzZDcPuU9c0s6HISpI=;
        b=Q9iaDNgAK+nhE5xS8RPVBnW/l6vX+vbwwf3dQZ2D8G/+YXYTLeJkyObBnSM2IBr5W8
         sDugp4LgTUNPVtVZM6zjDrLWrdZZ4PebzwNyuFvpb811DOMCYLI3mDksoAcrLhyDnH+P
         5m9xlqGVnG8e+8rBvaGwRBmUoVqRlCXWIZTsr6oiM6Cx9NOwzIzR6qNltd1kyBHgB8KI
         MhJXCFulkgi97U8A2DDPmIS2L1/5Yiz8+1lc+E9fPkm99xgEbqxNDhD0h9u4RNEBoVJv
         XZfmNjQrC5w3lT/bZFRczVxqjMkO92+mXCDMK/SJA4Bj0M0CVWM1Hjox3Xn9TlwKhAHH
         RKfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=abjFEsVw1GdBmzM87jn4ApDC9tzZDcPuU9c0s6HISpI=;
        b=Q40TJHY3ffrm/KCNAO8AYq53Ehz43JpuDLrYvwKHdy3kINTwFN6cuwUKl1gVSOIoM1
         QwTEEr50Gpj6Jl9ehPomgv7uHO9QoihFbEHOWdEaf7vUcAAKGxROLoOdwJxsBvMGe9Hh
         zuUV781abWcyhA60S9onSae+m3Io2XSZ/nbjIL9IeidMcKHJKYmC2jSIn0pWdG06xMMR
         7+e+YHH20RGpJYje2WvU10+3C3LRvR24MAJmv/MVu4+nXuIbv0Ply275i57QCJHa5H7M
         BFvkaSo5Y+p6sYL+mjIL58kwFlk3z8EzwZLZ593HazsDsl8P7CM+BxKWUTBVkwy5e87L
         relQ==
X-Gm-Message-State: AOAM530ZFzdg6XWaJnJbUyuaVJywgy253G0nv1L7i7Bs6iwOVrHu/VoM
        S45xCcQJiPwBH17xwoIdl9UgUO2Eq7iYp0JmkZSoBVeR
X-Google-Smtp-Source: ABdhPJwYmgojPQiromxPbwifi/pPDOXGmCk1oCMO9SX3fXEpkIlrnjDbnbJ76fRZ0m6PAWavXA4qfVQ5jDC4lwmGj+c=
X-Received: by 2002:a25:3d46:: with SMTP id k67mr1256yba.510.1614290770398;
 Thu, 25 Feb 2021 14:06:10 -0800 (PST)
MIME-Version: 1.0
References: <20210225073309.4119708-1-yhs@fb.com> <20210225073312.4120415-1-yhs@fb.com>
In-Reply-To: <20210225073312.4120415-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 25 Feb 2021 14:05:59 -0800
Message-ID: <CAEf4BzZn125xN0p=mUvAfFzq+Pbequm9Yp0rSN0B=ru4X8X8Jg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 03/11] bpf: refactor check_func_call() to
 allow callback function
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 25, 2021 at 1:35 AM Yonghong Song <yhs@fb.com> wrote:
>
> Later proposed bpf_for_each_map_elem() helper has callback
> function as one of its arguments. This patch refactored
> check_func_call() to permit callback function which sets
> callee state. Different callback functions may have
> different callee states.
>
> There is no functionality change for this patch except
> it added a case to handle where subprog number is known
> and there is no need to do find_subprog(). This case
> is used later by implementing bpf_for_each_map() helper.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  kernel/bpf/verifier.c | 54 ++++++++++++++++++++++++++++++++-----------
>  1 file changed, 41 insertions(+), 13 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a657860ecba5..092d2c734dd8 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5250,13 +5250,19 @@ static void clear_caller_saved_regs(struct bpf_verifier_env *env,
>         }
>  }
>
> -static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> -                          int *insn_idx)
> +typedef int (*set_callee_state_fn)(struct bpf_verifier_env *env,
> +                                  struct bpf_func_state *caller,
> +                                  struct bpf_func_state *callee,
> +                                  int insn_idx);
> +
> +static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> +                            int *insn_idx, int subprog,
> +                            set_callee_state_fn set_callee_st)

nit: s/set_callee_st/set_callee_state_cb|set_calle_state_fn/

_st is quite an unusual suffix

>  {
>         struct bpf_verifier_state *state = env->cur_state;
>         struct bpf_func_info_aux *func_info_aux;
>         struct bpf_func_state *caller, *callee;
> -       int i, err, subprog, target_insn;
> +       int err, target_insn;
>         bool is_global = false;
>
>         if (state->curframe + 1 >= MAX_CALL_FRAMES) {
> @@ -5265,12 +5271,16 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>                 return -E2BIG;
>         }
>
> -       target_insn = *insn_idx + insn->imm;
> -       subprog = find_subprog(env, target_insn + 1);
>         if (subprog < 0) {
> -               verbose(env, "verifier bug. No program starts at insn %d\n",
> -                       target_insn + 1);
> -               return -EFAULT;
> +               target_insn = *insn_idx + insn->imm;
> +               subprog = find_subprog(env, target_insn + 1);
> +               if (subprog < 0) {
> +                       verbose(env, "verifier bug. No program starts at insn %d\n",
> +                               target_insn + 1);
> +                       return -EFAULT;
> +               }
> +       } else {
> +               target_insn = env->subprog_info[subprog].start - 1;
>         }
>
>         caller = state->frame[state->curframe];
> @@ -5327,11 +5337,9 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>         if (err)
>                 return err;
>
> -       /* copy r1 - r5 args that callee can access.  The copy includes parent
> -        * pointers, which connects us up to the liveness chain
> -        */
> -       for (i = BPF_REG_1; i <= BPF_REG_5; i++)
> -               callee->regs[i] = caller->regs[i];
> +       err = set_callee_st(env, caller, callee, *insn_idx);
> +       if (err)
> +               return err;
>
>         clear_caller_saved_regs(env, caller->regs);
>
> @@ -5350,6 +5358,26 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>         return 0;
>  }
>
> +static int set_callee_state(struct bpf_verifier_env *env,
> +                           struct bpf_func_state *caller,
> +                           struct bpf_func_state *callee, int insn_idx)
> +{
> +       int i;
> +
> +       /* copy r1 - r5 args that callee can access.  The copy includes parent
> +        * pointers, which connects us up to the liveness chain
> +        */
> +       for (i = BPF_REG_1; i <= BPF_REG_5; i++)
> +               callee->regs[i] = caller->regs[i];
> +       return 0;
> +}
> +
> +static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> +                          int *insn_idx)
> +{
> +       return __check_func_call(env, insn, insn_idx, -1, set_callee_state);

I think it would be much cleaner to not have this -1 special case in
__check_func_call and instead search for the right subprog right here
in check_func_call(). Related question, is meta.subprogno (in patch
#4) expected to sometimes be < 0? If not, then I think
__check_func_call() definitely shouldn't support -1 case at all.


> +}
> +
>  static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
>  {
>         struct bpf_verifier_state *state = env->cur_state;
> --
> 2.24.1
>
