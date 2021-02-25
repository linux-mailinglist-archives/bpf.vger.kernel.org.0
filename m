Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9DA73259B3
	for <lists+bpf@lfdr.de>; Thu, 25 Feb 2021 23:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbhBYWcq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Feb 2021 17:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbhBYWcj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Feb 2021 17:32:39 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFB7C061574
        for <bpf@vger.kernel.org>; Thu, 25 Feb 2021 14:31:59 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 133so7021650ybd.5
        for <bpf@vger.kernel.org>; Thu, 25 Feb 2021 14:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kwODEfmgEIRSbmgM2rUpP0Nfeza1Pz1KmcHSWa8q8tc=;
        b=mdl3ZHBJ1jU//iQ1Lmk1JVKg/McAdw38jat8/YKObtu2mKW97sDYJuhd7AFRJJ4x3+
         CemO9n0YQnvuDXhg4H71hTFh5CuNM0PzqOjXCURw+9GnqbKoPi6CTWaU7GoeVTQMipIQ
         Yf/+fAluGbofA0hzZBs3AEMxSzP1dBH1EsE9Vv/gs1fHmsEY5wJfR3FoXoY4frtGpfC2
         VfvEZsijHU40DabQu1NvMAPWBYdOMRtIsNK/0rUPAM/UaqdBxqeUcMKzvmEbDY8FuMTz
         VzUw1HX940F2P0QKBC3khzv3ck/bLQ4wo3Cd5uTCt0lH5rBdzR1TlScurqmLXcl3QZRt
         qZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kwODEfmgEIRSbmgM2rUpP0Nfeza1Pz1KmcHSWa8q8tc=;
        b=fzABwuMLcqfepW7TYpL/u1oq7LN7JfyMjroHaROMVP3xrRCpEI+TVy7KmtSMSQ48h6
         47H0UJlMwmrRJx3xM9fIOVVFe1sMxVavvVuaaCls//E3Nv7p/Zu5YkFgJV0wjoYslion
         b2ykEdcymLALuUEPbWKPnKZTqwo8sE6eex0WuDyY0EhBluqYYe51z+xbPNE4H9sYn/Hp
         s/riTApoKz7rc/PjmoPKZ3joODdPeCV2vqsD95hylPipeaFuDP7gK5A3InPIo3a6DBRv
         /kMc3TfxDM/BHMwrAuPpWvLrG9XABHWDVhz62OW+k6A6CMp3Pj2CjT67y5bY3wAifRkM
         2eNw==
X-Gm-Message-State: AOAM531Bf946F456pI3/BhfLy9pChFOAtoQX2mkkrBdbVoqVWl9mEuRk
        ukCgoyosmGSFkZ7IP7262mnO2LIhUkiwIqxrKRo=
X-Google-Smtp-Source: ABdhPJxlckTaDqDotqLiPnHifs2V7JmoM6zfD8cpC2THxnovfcricF+nIY4alXEXMMGbNyDzLFtw/gVwcNSWEg6iWT4=
X-Received: by 2002:a25:3d46:: with SMTP id k67mr138136yba.510.1614292318139;
 Thu, 25 Feb 2021 14:31:58 -0800 (PST)
MIME-Version: 1.0
References: <20210225073309.4119708-1-yhs@fb.com> <20210225073312.4120415-1-yhs@fb.com>
 <CAEf4BzZn125xN0p=mUvAfFzq+Pbequm9Yp0rSN0B=ru4X8X8Jg@mail.gmail.com>
In-Reply-To: <CAEf4BzZn125xN0p=mUvAfFzq+Pbequm9Yp0rSN0B=ru4X8X8Jg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 25 Feb 2021 14:31:47 -0800
Message-ID: <CAEf4BzbdNTc4wqnhPPhfQeO0rARMHNocZ28xgR6cY1OVDAti1w@mail.gmail.com>
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

On Thu, Feb 25, 2021 at 2:05 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Feb 25, 2021 at 1:35 AM Yonghong Song <yhs@fb.com> wrote:
> >
> > Later proposed bpf_for_each_map_elem() helper has callback
> > function as one of its arguments. This patch refactored
> > check_func_call() to permit callback function which sets
> > callee state. Different callback functions may have
> > different callee states.
> >
> > There is no functionality change for this patch except
> > it added a case to handle where subprog number is known
> > and there is no need to do find_subprog(). This case
> > is used later by implementing bpf_for_each_map() helper.
> >
> > Signed-off-by: Yonghong Song <yhs@fb.com>
> > ---
> >  kernel/bpf/verifier.c | 54 ++++++++++++++++++++++++++++++++-----------
> >  1 file changed, 41 insertions(+), 13 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index a657860ecba5..092d2c734dd8 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -5250,13 +5250,19 @@ static void clear_caller_saved_regs(struct bpf_verifier_env *env,
> >         }
> >  }
> >
> > -static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> > -                          int *insn_idx)
> > +typedef int (*set_callee_state_fn)(struct bpf_verifier_env *env,
> > +                                  struct bpf_func_state *caller,
> > +                                  struct bpf_func_state *callee,
> > +                                  int insn_idx);
> > +
> > +static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> > +                            int *insn_idx, int subprog,

ok, patch #4 confused me because of this `int *insn_idx`. You don't
seem to be ever updating it, so why pass it by pointer?... What did I
miss?

> > +                            set_callee_state_fn set_callee_st)
>
> nit: s/set_callee_st/set_callee_state_cb|set_calle_state_fn/
>
> _st is quite an unusual suffix
>
> >  {
> >         struct bpf_verifier_state *state = env->cur_state;
> >         struct bpf_func_info_aux *func_info_aux;
> >         struct bpf_func_state *caller, *callee;
> > -       int i, err, subprog, target_insn;
> > +       int err, target_insn;
> >         bool is_global = false;
> >
> >         if (state->curframe + 1 >= MAX_CALL_FRAMES) {
> > @@ -5265,12 +5271,16 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> >                 return -E2BIG;
> >         }
> >
> > -       target_insn = *insn_idx + insn->imm;
> > -       subprog = find_subprog(env, target_insn + 1);
> >         if (subprog < 0) {
> > -               verbose(env, "verifier bug. No program starts at insn %d\n",
> > -                       target_insn + 1);
> > -               return -EFAULT;
> > +               target_insn = *insn_idx + insn->imm;
> > +               subprog = find_subprog(env, target_insn + 1);
> > +               if (subprog < 0) {
> > +                       verbose(env, "verifier bug. No program starts at insn %d\n",
> > +                               target_insn + 1);
> > +                       return -EFAULT;
> > +               }
> > +       } else {
> > +               target_insn = env->subprog_info[subprog].start - 1;
> >         }
> >
> >         caller = state->frame[state->curframe];
> > @@ -5327,11 +5337,9 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> >         if (err)
> >                 return err;
> >
> > -       /* copy r1 - r5 args that callee can access.  The copy includes parent
> > -        * pointers, which connects us up to the liveness chain
> > -        */
> > -       for (i = BPF_REG_1; i <= BPF_REG_5; i++)
> > -               callee->regs[i] = caller->regs[i];
> > +       err = set_callee_st(env, caller, callee, *insn_idx);
> > +       if (err)
> > +               return err;
> >
> >         clear_caller_saved_regs(env, caller->regs);
> >
> > @@ -5350,6 +5358,26 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> >         return 0;
> >  }
> >
> > +static int set_callee_state(struct bpf_verifier_env *env,
> > +                           struct bpf_func_state *caller,
> > +                           struct bpf_func_state *callee, int insn_idx)
> > +{
> > +       int i;
> > +
> > +       /* copy r1 - r5 args that callee can access.  The copy includes parent
> > +        * pointers, which connects us up to the liveness chain
> > +        */
> > +       for (i = BPF_REG_1; i <= BPF_REG_5; i++)
> > +               callee->regs[i] = caller->regs[i];
> > +       return 0;
> > +}
> > +
> > +static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> > +                          int *insn_idx)
> > +{
> > +       return __check_func_call(env, insn, insn_idx, -1, set_callee_state);
>
> I think it would be much cleaner to not have this -1 special case in
> __check_func_call and instead search for the right subprog right here
> in check_func_call(). Related question, is meta.subprogno (in patch
> #4) expected to sometimes be < 0? If not, then I think
> __check_func_call() definitely shouldn't support -1 case at all.
>
>
> > +}
> > +
> >  static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
> >  {
> >         struct bpf_verifier_state *state = env->cur_state;
> > --
> > 2.24.1
> >
