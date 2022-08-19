Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3ACC5991EB
	for <lists+bpf@lfdr.de>; Fri, 19 Aug 2022 02:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiHSAvS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Aug 2022 20:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiHSAvR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Aug 2022 20:51:17 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1051DD779
        for <bpf@vger.kernel.org>; Thu, 18 Aug 2022 17:51:15 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id a22so3871308edj.5
        for <bpf@vger.kernel.org>; Thu, 18 Aug 2022 17:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=5iGC7KbvF51aYxjxPqI2Jpgd6wG3GJ6blFOEnqTKGQA=;
        b=d9X1gDDxOUYPF6Hmp3V/p++jCY0ebDWeIAcjvG8l6tIlxS12i5SLStgQAKE2ivUyEZ
         CZd0cHBy14c0wDXFVkV1m4obj8fAmlA+b3epad6Z0ILOu0Egk+t8GTSaffuhLHL+YHkK
         Kf7XmtMwRAyllouBaGRhy/T3yQx/ze0CCalj0yAHFj3aHz01WxMX8BjarczqAi/OFWuq
         qLvziW1WZTVKJPBWwxF46742JAyNnBcRbUvA7S+pHPLcGfchAoBxev5cy4774AE0F2ib
         a6NSLwbRNaBZmUyd+noz7mQI3Nf2GXwGYdWa4hY0vOk95oN67hB8xvYj7iiko5+DF2OZ
         /8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=5iGC7KbvF51aYxjxPqI2Jpgd6wG3GJ6blFOEnqTKGQA=;
        b=ekROo3kHuptxIrGNvWy0frwI8SkVYktf3w5fxRQ1Q9Nv4tE61fkaGxhYMX2vwhLU2P
         N+bingWcBmlnDApgAZVdCHRF45GtwVu95KkdkQMAoJp0BJHhFprwIYfClfGkx3OgXGps
         fy6oNNjloFzwrzt6IV2HqeMgpOhzSZb+J9IUiJ5xQYWPvtm2d2DcGpMpgmDDITkjVHYk
         Jzh4eBoYmlX2jHit8OQk9cHzP6APoDbKhqUfNObQpf0eh9U58eEUcKIZNDmaab3nzqJB
         Lb4Pnp6+/QPFyuWSP2InPcGE3p9cl2PziYbc/2JW92i9krvm001gj/oQSkoDU283SYva
         YT3A==
X-Gm-Message-State: ACgBeo2FljFzq0QCxxEvgiMXtUUe6FACmubW4yrxzx7ug2ZAuSPi2rYU
        GRwNV0vGoOk1duX8OoZJ7WcIJ9CXbbg9vGHooaw=
X-Google-Smtp-Source: AA6agR45Fi7qKYlyVYUFJMJ93YXJFhG+o1w0BEiXtcTA1n6zKKJR0cyZ7/ZqcsMxERQvf9AHViaOw1hbrNV3XV/+Fsg=
X-Received: by 2002:a05:6402:270d:b0:43a:67b9:6eea with SMTP id
 y13-20020a056402270d00b0043a67b96eeamr4097320edd.94.1660870274292; Thu, 18
 Aug 2022 17:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220815051540.18791-1-memxor@gmail.com> <20220815051540.18791-3-memxor@gmail.com>
In-Reply-To: <20220815051540.18791-3-memxor@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 18 Aug 2022 17:51:02 -0700
Message-ID: <CAADnVQ+Y161JHT2sN-r-g3CHevtwiS2WLW=VW+mx5bekaewGGQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf v1 2/3] bpf: Fix reference state management for
 synchronous callbacks
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Aug 14, 2022 at 10:15 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Currently, verifier verifies callback functions (sync and async) as if
> they will be executed once, (i.e. it explores execution state as if the
> function was being called once). The next insn to explore is set to
> start of subprog and the exit from nested frame is handled using
> curframe > 0 and prepare_func_exit. In case of async callback it uses a
> customized variant of push_stack simulating a kind of branch to set up
> custom state and execution context for the async callback.
>
> While this approach is simple and works when callback really will be
> executed only once, it is unsafe for all of our current helpers which
> are for_each style, i.e. they execute the callback multiple times.
>
> A callback releasing acquired references of the caller may do so
> multiple times, but currently verifier sees it as one call inside the
> frame, which then returns to caller. Hence, it thinks it released some
> reference that the cb e.g. got access through callback_ctx (register
> filled inside cb from spilled typed register on stack).
>
> Similarly, it may see that an acquire call is unpaired inside the
> callback, so the caller will copy the reference state of callback and
> then will have to release the register with new ref_obj_ids. But again,
> the callback may execute multiple times, but the verifier will only
> account for acquired references for a single symbolic execution of the
> callback.
>
> Note that for async callback case, things are different. While currently
> we have bpf_timer_set_callback which only executes it once, even for
> multiple executions it would be safe, as reference state is NULL and
> check_reference_leak would force program to release state before
> BPF_EXIT. The state is also unaffected by analysis for the caller frame.
> Hence async callback is safe.
>
> To fix this, we disallow callbacks to transfer acquired references back
> to caller. They must be released before callback hits BPF_EXIT, since
> the number of times callback is invoked is not known to the verifier, it
> cannot reliably track how many references will be created. Likewise, it
> is not allowed to release caller reference state, since we don't know
> how many times the callback will be invoked.
>
> Lastly, now that callback function cannot change reference state it
> copied from its parent, there is no need to copy reference state back to
> the parent, since it won't change. It may be changed for the callee
> frame but that state must match parent reference state by the time
> callee exits, and it is going to be discarded anyway. So skip this copy
> too. To be clear, it won't be incorrect if the copy was done, but it
> would be inefficient and may be confusing to people reading the code.
>
> Fixes: 69c87ba6225 ("bpf: Add bpf_for_each_map_elem() helper")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf_verifier.h | 11 ++++++++++
>  kernel/bpf/verifier.c        | 42 ++++++++++++++++++++++++++++--------
>  2 files changed, 44 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 2e3bad8640dc..1fdddbf3546b 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -212,6 +212,17 @@ struct bpf_reference_state {
>          * is used purely to inform the user of a reference leak.
>          */
>         int insn_idx;
> +       /* There can be a case like:
> +        * main (frame 0)
> +        *  cb (frame 1)
> +        *   func (frame 3)
> +        *    cb (frame 4)
> +        * Hence for frame 4, if callback_ref just stored boolean, it would be
> +        * impossible to distinguish nested callback refs. Hence store the
> +        * frameno and compare that to callback_ref in check_reference_leak when
> +        * exiting a callback function.
> +        */
> +       int callback_ref;
>  };
>
>  /* state of the program:
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 096fdac70165..3e885ba88b02 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1086,6 +1086,7 @@ static int acquire_reference_state(struct bpf_verifier_env *env, int insn_idx)
>         id = ++env->id_gen;
>         state->refs[new_ofs].id = id;
>         state->refs[new_ofs].insn_idx = insn_idx;
> +       state->refs[new_ofs].callback_ref = state->in_callback_fn ? state->frameno : 0;
>
>         return id;
>  }
> @@ -1098,6 +1099,9 @@ static int release_reference_state(struct bpf_func_state *state, int ptr_id)
>         last_idx = state->acquired_refs - 1;
>         for (i = 0; i < state->acquired_refs; i++) {
>                 if (state->refs[i].id == ptr_id) {
> +                       /* Cannot release caller references in callbacks */
> +                       if (state->in_callback_fn && state->refs[i].callback_ref != state->frameno)
> +                               return -EINVAL;
>                         if (last_idx && i != last_idx)
>                                 memcpy(&state->refs[i], &state->refs[last_idx],
>                                        sizeof(*state->refs));
> @@ -6938,10 +6942,17 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
>                 caller->regs[BPF_REG_0] = *r0;
>         }
>
> -       /* Transfer references to the caller */
> -       err = copy_reference_state(caller, callee);
> -       if (err)
> -               return err;
> +       /* callback_fn frame should have released its own additions to parent's
> +        * reference state at this point, or check_reference_leak would
> +        * complain, hence it must be the same as the caller. There is no need
> +        * to copy it back.
> +        */
> +       if (!callee->in_callback_fn) {
> +               /* Transfer references to the caller */
> +               err = copy_reference_state(caller, callee);
> +               if (err)
> +                       return err;
> +       }

This part makes sense.

>
>         *insn_idx = callee->callsite + 1;
>         if (env->log.level & BPF_LOG_LEVEL) {
> @@ -7065,13 +7076,20 @@ record_func_key(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
>  static int check_reference_leak(struct bpf_verifier_env *env)
>  {
>         struct bpf_func_state *state = cur_func(env);
> +       bool refs_lingering = false;
>         int i;
>
> +       if (state->frameno && !state->in_callback_fn)
> +               return 0;
> +
>         for (i = 0; i < state->acquired_refs; i++) {
> +               if (state->in_callback_fn && state->refs[i].callback_ref != state->frameno)
> +                       continue;

This part I don't understand.
Why remember callback_ref at all?
if (state->in_callback_fn)
and there is something in acquired_refs it means
that callback acquired refs and since we're not transferring
them then we can error right away.

>                 verbose(env, "Unreleased reference id=%d alloc_insn=%d\n",
>                         state->refs[i].id, state->refs[i].insn_idx);
> +               refs_lingering = true;
>         }
> -       return state->acquired_refs ? -EINVAL : 0;
> +       return refs_lingering ? -EINVAL : 0;
>  }
>
>  static int check_bpf_snprintf_call(struct bpf_verifier_env *env,
> @@ -12332,6 +12350,16 @@ static int do_check(struct bpf_verifier_env *env)
>                                         return -EINVAL;
>                                 }
>
> +                               /* We must do check_reference_leak here before
> +                                * prepare_func_exit to handle the case when
> +                                * state->curframe > 0, it may be a callback
> +                                * function, for which reference_state must
> +                                * match caller reference state when it exits.
> +                                */
> +                               err = check_reference_leak(env);
> +                               if (err)
> +                                       return err;
> +
>                                 if (state->curframe) {
>                                         /* exit from nested function */
>                                         err = prepare_func_exit(env, &env->insn_idx);
> @@ -12341,10 +12369,6 @@ static int do_check(struct bpf_verifier_env *env)
>                                         continue;
>                                 }
>
> -                               err = check_reference_leak(env);
> -                               if (err)
> -                                       return err;
> -
>                                 err = check_return_code(env);
>                                 if (err)
>                                         return err;
> --
> 2.34.1
>
