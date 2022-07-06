Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B38056928C
	for <lists+bpf@lfdr.de>; Wed,  6 Jul 2022 21:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbiGFTWI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 15:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbiGFTWH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 15:22:07 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402FD2714C
        for <bpf@vger.kernel.org>; Wed,  6 Jul 2022 12:22:06 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id z12-20020a17090a7b8c00b001ef84000b8bso11029628pjc.1
        for <bpf@vger.kernel.org>; Wed, 06 Jul 2022 12:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QcQNmxkcI9EMj9hDweGbBfdiQd3ftldVUVn7l/FWeis=;
        b=ozmUmZvjqvaUi/YAeIbLodZo9wc+NkYmZUCBnYCDuUBpK9ZWTpa0bnOJBcmZzByt4N
         GMu92xoUCYT6/GCBu8vjctbunGjSWOBLpYNXcn55I1o7YR3rZfc5Rlpt4NbYpcuo78qD
         mIPHurMSCmh9HlpjcfiD4RaS10UKV5WAgjgf8UuaPknl9Fm+NxFzT+/lTOOO9tNtEr5z
         2R9upVndQU98y4J0ZMvvEJhikxDcgSmKWB942euqIL5BC5MPXnuyQ5hv8eSOLg/ak+0F
         ym45M7fsMpPZiF76IfxtwOSRQrvYjRnT/Rtc3HDGZLrWXc5vHq+bt/d+Wtc3blMZ0+KM
         6fNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QcQNmxkcI9EMj9hDweGbBfdiQd3ftldVUVn7l/FWeis=;
        b=NACipiaQooMqXefIspI2UWcSU31f9VSACbOOFjlr+eceUNUKrcsg+iGf9Xzkg2p/2C
         GeOzxmJGEM+Zk7GVQbxRlJGyIs807LK3CGgwVwGxrrypFnZH3uDgtpXf+wPiwmB+pKup
         mU/emWdH0sdo3mHYtBOt1qJY7o7CnMU9JkW3bjvoJxF4TTEoqNKDeIhWTVWkXAvsu8o2
         KJXzTzKb55mC3moeiMW5PRrTQeQ3lhhwqNVHEEI7QIyzET8uOu7BDYmZWVI0wYjdg5j0
         DUy3+u88IvRbsUgB+fbl0BDdqx0ba9F556JtFz3LvPxxOQzQH8/9QeqPLYVdpvMFdINX
         X8WA==
X-Gm-Message-State: AJIora/qssTD3O/0mCgkosIuAS5H/5jk1+QmwidmGT9CrK48JOnoQTD5
        Q13OnFJ7KmiZeBjJ6+qGe5R+0sKq5DKeBX/jMFVHCA==
X-Google-Smtp-Source: AGRyM1trSSGwgPSF1qm9ggo7uWlV8REZMLB2y6jeouLzyWdyF1975nw/yN1u2E5yphcwydUcGBecMN+svPwJewxix4c=
X-Received: by 2002:a17:902:cecc:b0:16a:416c:3d14 with SMTP id
 d12-20020a170902cecc00b0016a416c3d14mr47664313plg.73.1657135325554; Wed, 06
 Jul 2022 12:22:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220706174857.3799351-1-sdf@google.com> <20220706191143.n42gembkotglgzu4@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220706191143.n42gembkotglgzu4@kafai-mbp.dhcp.thefacebook.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 6 Jul 2022 12:21:54 -0700
Message-ID: <CAKH8qBswvo4aovSXNgkJokwyFcU2jZ3i=OYtTGp4nb62V7uF_w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: check attach_func_proto return type more carefully
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org,
        syzbot+5cc0730bd4b4d2c5f152@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 6, 2022 at 12:11 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Wed, Jul 06, 2022 at 10:48:57AM -0700, Stanislav Fomichev wrote:
> > Syzkaller reports the following crash:
> > RIP: 0010:check_return_code kernel/bpf/verifier.c:10575 [inline]
> > RIP: 0010:do_check kernel/bpf/verifier.c:12346 [inline]
> > RIP: 0010:do_check_common+0xb3d2/0xd250 kernel/bpf/verifier.c:14610
> >
> > With the following reproducer:
> > bpf$PROG_LOAD_XDP(0x5, &(0x7f00000004c0)={0xd, 0x3, &(0x7f0000000000)=ANY=[@ANYBLOB="1800000000000019000000000000000095"], &(0x7f0000000300)='GPL\x00', 0x0, 0x0, 0x0, 0x0, 0x0, '\x00', 0x0, 0x2b, 0xffffffffffffffff, 0x8, 0x0, 0x0, 0x10, 0x0}, 0x80)
> >
> > Because we don't enforce expected_attach_type for XDP programs,
> > we end up in hitting 'if (prog->expected_attach_type == BPF_LSM_CGROUP'
> > part in check_return_code and follow up with testing
> > `prog->aux->attach_func_proto->type`, but `prog->aux->attach_func_proto`
> > is NULL.
> >
> > Let's add a new btf_func_returns_void() wrapper which is more defensive
> > and use it in the places where we currently do '!->type' check.
> >
> > Fixes: 69fd337a975c ("bpf: per-cgroup lsm flavor")
> > Reported-by: syzbot+5cc0730bd4b4d2c5f152@syzkaller.appspotmail.com
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  include/linux/btf.h     | 5 +++++
> >  kernel/bpf/trampoline.c | 2 +-
> >  kernel/bpf/verifier.c   | 8 ++++----
> >  3 files changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/btf.h b/include/linux/btf.h
> > index 1bfed7fa0428..17ba7d27a8ad 100644
> > --- a/include/linux/btf.h
> > +++ b/include/linux/btf.h
> > @@ -302,6 +302,11 @@ static inline u16 btf_func_linkage(const struct btf_type *t)
> >       return BTF_INFO_VLEN(t->info);
> >  }
> >
> > +static inline bool btf_func_returns_void(const struct btf_type *t)
> > +{
> > +     return t && !t->type;
> > +}
> > +
> >  static inline bool btf_type_kflag(const struct btf_type *t)
> >  {
> >       return BTF_INFO_KFLAG(t->info);
> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > index 6cd226584c33..9c4cb4c8a5fa 100644
> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
> > @@ -400,7 +400,7 @@ static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(struct bpf_prog *prog)
> >       case BPF_TRACE_FEXIT:
> >               return BPF_TRAMP_FEXIT;
> >       case BPF_LSM_MAC:
> > -             if (!prog->aux->attach_func_proto->type)
> > +             if (btf_func_returns_void(prog->aux->attach_func_proto))
> >                       /* The function returns void, we cannot modify its
> >                        * return value.
> >                        */
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index df3ec6b05f05..e3ee6f70939b 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -7325,7 +7325,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> >               break;
> >       case BPF_FUNC_set_retval:
> >               if (env->prog->expected_attach_type == BPF_LSM_CGROUP) {
> > -                     if (!env->prog->aux->attach_func_proto->type) {
> > +                     if (btf_func_returns_void(env->prog->aux->attach_func_proto)) {
> >                               /* Make sure programs that attach to void
> >                                * hooks don't try to modify return value.
> >                                */
> > @@ -10447,7 +10447,7 @@ static int check_return_code(struct bpf_verifier_env *env)
> >       if (!is_subprog &&
> >           (prog_type == BPF_PROG_TYPE_STRUCT_OPS ||
> >            prog_type == BPF_PROG_TYPE_LSM) &&
> > -         !prog->aux->attach_func_proto->type)
> > +         btf_func_returns_void(prog->aux->attach_func_proto))
> >               return 0;
> It seems there is another problem here.
> It returns early here for prog_type == BPF_PROG_TYPE_LSM.
> It should only do that for expected_attach_type != BPF_LSM_CGROUP.
>
> Otherwise, the later verbose(env, "Note, BPF_LSM_CGROUP...") will
> not get a chance.

Ah, true, will add expected_attach_type check here as well, thanks!

> >
> >       /* eBPF calling convention is such that R0 is used
> > @@ -10547,7 +10547,7 @@ static int check_return_code(struct bpf_verifier_env *env)
> >                        */
> >                       return 0;
> >               }
> > -             if (!env->prog->aux->attach_func_proto->type) {
> > +             if (btf_func_returns_void(env->prog->aux->attach_func_proto)) {
> >                       /* Make sure programs that attach to void
> >                        * hooks don't try to modify return value.
> >                        */
> > @@ -10572,7 +10572,7 @@ static int check_return_code(struct bpf_verifier_env *env)
> >       if (!tnum_in(range, reg->var_off)) {
> >               verbose_invalid_scalar(env, reg, &range, "program exit", "R0");
> >               if (prog->expected_attach_type == BPF_LSM_CGROUP &&
> I think the problem is more like missing
> prog_type == BPF_PROG_TYPE_LSM [&& expected_attach_type == BPF_LSM_CGROUP] here
> instead of testing !attach_func_proto in all places.

SG!

> > -                 !prog->aux->attach_func_proto->type)
> > +                 btf_func_returns_void(prog->aux->attach_func_proto))
> >                       verbose(env, "Note, BPF_LSM_CGROUP that attach to void LSM hooks can't modify return value!\n");
> >               return -EINVAL;
> >       }
> > --
> > 2.37.0.rc0.161.g10f37bed90-goog
> >
