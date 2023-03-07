Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223596AF815
	for <lists+bpf@lfdr.de>; Tue,  7 Mar 2023 22:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjCGVy7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 16:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbjCGVyp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 16:54:45 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C013999D77
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 13:54:43 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id u9so58311167edd.2
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 13:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678226082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03XeUlTroOiO4vDR39RQIaZPgtxIxzJt1mj7gaHFC5U=;
        b=iBrex2cWks6uw6I2JvYxiaXge8AUzu5X8Zwwoq4MliYqSBx2AOxHd0lTNr7GHPP04O
         7wt0jPKmIZ1a7pfCeiAToyjOW49xhWvsWeOOJ2EJwb0kzPVNTFB1Iva6tJXgRgJimKTe
         +SUmRf+FF/SS33k+gqVrP1RAUOH7ucRBrYTbAcap/XD9rMHY9WclEd2ju+ovm5R7Qs8I
         XrXlfv4Kg3kp/aU58/m2d3BMXORawdFid1wzfjMIzt8soDxEoJ5uYDC/35fJs0RaSIqu
         bcrcyiS+SR5KtfqTbKuevqdM4m8HWkdlIp9cJlofSzbQTK5ccqmACNx5xgkySaiidlXg
         6ZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678226082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03XeUlTroOiO4vDR39RQIaZPgtxIxzJt1mj7gaHFC5U=;
        b=DpfNpyJsAIGyqqIIqxFa1jvyy3MgrqKwCGaaGWdyWy+V7X9j8NHecnt3qkpaoL52l7
         K88jeatAWVaqw+PDFPrCYpU/6gLPO5x606FXhPGTfvBU+Qu1KMCYDZmtZDsN7H1qD13D
         NyZro0nTvzEJkviivHD7bwKPrpVwAKYu38uXdGuNdcnIyfXa7sc+OsmrgjMbvrThzszM
         3aIeH4gcZ8Ulp01FNWqPmXztfhAJtQolE2BaAjFrk6sfvosPUzH1kT31MKS3JALPVbvT
         eXIsNKzqX7/1PKw4thQS3xT5IRZ9EcYEvTmr8CAPfZOC7gnG84ikfeZf3vxQRORo+27q
         l+Iw==
X-Gm-Message-State: AO0yUKV/p7V2D/RGvYcCQltupOp4AXKx852p0+Xhhi8esDCqv/JGXTpD
        dQzXR3DoDZPKrPm1rEFaRajqEkjoOMKoP4dcUVGaJvTC
X-Google-Smtp-Source: AK7set8TSO5alX1iZodq3rBsW98ZGOvaCYIL7QKIH+TW1b1ZWREosq89YeYdMRkjoJM9M7Tbvt7lP+baKv7kqwjXeNc=
X-Received: by 2002:a50:cd15:0:b0:4c1:1555:152f with SMTP id
 z21-20020a50cd15000000b004c11555152fmr8818659edi.5.1678226082085; Tue, 07 Mar
 2023 13:54:42 -0800 (PST)
MIME-Version: 1.0
References: <20230302235015.2044271-1-andrii@kernel.org> <20230302235015.2044271-14-andrii@kernel.org>
 <20230304200232.ueac44amyhpptpay@MacBook-Pro-6.local> <CAEf4BzY70w2g5giMu+qWOE0YSGWKvy1hq-pKCvHHKLcez+R2Tg@mail.gmail.com>
 <20230305234605.q2aszlad5ow3ylkl@MacBook-Pro-6.local>
In-Reply-To: <20230305234605.q2aszlad5ow3ylkl@MacBook-Pro-6.local>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 7 Mar 2023 13:54:30 -0800
Message-ID: <CAEf4BzYMbgfSjhKFzsa8rb9zOZYrzjm1bYKWJgWO7o-vZi9pdQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 13/17] bpf: add support for open-coded iterator loops
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Mar 5, 2023 at 3:46=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Mar 04, 2023 at 03:27:46PM -0800, Andrii Nakryiko wrote:
> > particular type. This will automatically work better for kfuncs as
> > new/next/destroy trios will have the same `struct bpf_iter_<type> *`
> > and it won't be possible to accidentally pass wrong bpf_iter_<type> to
> > wrong new/next/destroy method.
>
> Exactly.
>

cool, I'll change this to `struct bpf_iter_<type>`

[...]

>
> > > > +static bool is_iter_next_insn(struct bpf_verifier_env *env, int in=
sn_idx, int *reg_idx)
> > > > +{
> > > > +     struct bpf_insn *insn =3D &env->prog->insnsi[insn_idx];
> > > > +     const struct btf_param *args;
> > > > +     const struct btf_type *t;
> > > > +     const struct btf *btf;
> > > > +     int nargs, i;
> > > > +
> > > > +     if (!bpf_pseudo_kfunc_call(insn))
> > > > +             return false;
> > > > +     if (!is_iter_next_kfunc(insn->imm))
> > > > +             return false;
> > > > +
> > > > +     btf =3D find_kfunc_desc_btf(env, insn->off);
> > > > +     if (IS_ERR(btf))
> > > > +             return false;
> > > > +
> > > > +     t =3D btf_type_by_id(btf, insn->imm);     /* FUNC */
> > > > +     t =3D btf_type_by_id(btf, t->type);       /* FUNC_PROTO */
> > > > +
> > > > +     args =3D btf_params(t);
> > > > +     nargs =3D btf_vlen(t);
> > > > +     for (i =3D 0; i < nargs; i++) {
> > > > +             if (is_kfunc_arg_iter(btf, &args[i])) {
> > > > +                     *reg_idx =3D BPF_REG_1 + i;
> > > > +                     return true;
> > > > +             }
> > > > +     }
> > >
> > > This is some future-proofing ?
> > > The commit log says that all iterators has to in the form:
> > > bpf_iter_<kind>_next(struct bpf_iter* it)
> > > Should we check for one and only arg here instead?
> >
> > Yeah, a bit of generality. For a long time I had an assumption
> > hardcoded about first argument being struct bpf_iter *, but that felt
> > unclean, so I generalized that before submission.
> >
> > But I can't think why we wouldn't just dictate (and enforce) that
> > `struct bpf_iter *` is first. It makes sense, it's clean, and we lose
> > nothing. This is another thing that differs between dynptr and iter,
> > for dynptr such restriction wouldn't make sense.
> >
> > Where would be a good place to enforce this for iter kfuncs?
>
> I would probably just remove is_iter_next_insn() completely, hard code BP=
F_REG_1
> and add a big comment for now.
>
> In the follow up we can figure out how to:
> BUILD_BUG_ON(!__same_type(bpf_iter_num_next, some canonical proto for ite=
r_next));
>
> Like we do:
>   BUILD_BUG_ON(!__same_type(ops->map_lookup_elem,
>                (void *(*)(struct bpf_map *map, void *key))NULL));
>

I ended up adding proper enforcement of iter kfunc prototypes and
generalizing everything with new KF_ITER_xxx flags. It's a pretty
major change that allows implementing new iterators even easier,
please see v2. It's now possible to define iterators in kernel modules
as well, thanks to not having to update core verifier logic for each
new set of iter functions.

> > >
> > > 'depth' part of bpf_reg_state will be checked for equality in regsafe=
(), right?
> >
> > no, it is explicitly skipped (and it's actually stacksafe(), not
> > regsafe()). I can add explicit comment that we *ignore* depth
>
> Ahh. That's stacksafe() indeed.
> Would be great to add a comment to:
> +                       if (old_reg->iter.type !=3D cur_reg->iter.type ||
> +                           old_reg->iter.state !=3D cur_reg->iter.state =
||
> +                           !check_ids(old_reg->ref_obj_id, cur_reg->ref_=
obj_id, idmap))
> +                               return false;
>
> that depth is explicitly not compared.

ok, added

>
> > I was considering adding a flag to states_equal() whether to check
> > depth or not (that would make iter_active_depths_differ unnecessary),
> > but it doesn't feel right. Any preferences one way or the other?
>
> probably overkill. just comment should be enough.
>

[...]

>
> > >
> > > > +                     }
> > > > +                     /* attempt to detect infinite loop to avoid u=
nnecessary doomed work */
> > > > +                     if (states_maybe_looping(&sl->state, cur) &&
> > >
> > > Maybe cleaner is to remove above 'goto' and do '} else if (states_may=
be_looping' here ?
> >
> > I can undo this, it felt cleaner with explicit "skip infinite loop
> > check" both for new code and for that async_entry_cnt check above. But
> > I can revert to if/else if/else if pattern, though I find it harder to
> > follow, given all this code (plus comments) is pretty long, so it's
> > easy to lose track when reading
>
> I'm fine whichever way. I just remembered that you typically try to avoid=
 goto-s
> and seeing goto here that could have easily been 'else' raised my interna=
l alarm
> that I could be missing something subtle in the code here.

Well, it depends, as usual. I certainly don't like something like
"goto process_bpf_exit" in do_check(), which jumps into the middle of
a completely unrelated if/else branch, so there's that. But these
"skip a bunch of checks" gotos are cleaner, IMO, if we are talking
about a bunch of complicated if/else if/else checks. Let's go with
explicit goto for now, we can always revert.



>
> >
> > >
> > > > +                         states_equal(env, &sl->state, cur) &&
> > > > +                         !iter_active_depths_differ(&sl->state, cu=
r)) {
> > > >                               verbose_linfo(env, insn_idx, "; ");
> > > >                               verbose(env, "infinite loop detected =
at insn %d\n", insn_idx);
> > > >                               return -EINVAL;
