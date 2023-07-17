Return-Path: <bpf+bounces-5127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F06F756A38
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 19:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16DAD1C20B37
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 17:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0CBAD5A;
	Mon, 17 Jul 2023 17:25:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708311FD7
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 17:25:41 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF7A170A
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 10:25:16 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b70404a5a0so76441981fa.2
        for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 10:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689614709; x=1692206709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5YF+nlCOe3O1kBGIFVaMKzFvIcHGZB8RvnMAPyaULs=;
        b=isOF0N3yymp+nS1nB6OB7d7829jnt3PD9Sht3wCZ3/iv9U8LiIJSUnZ349Hg/sw9CM
         Y3XUYkBqc//2iD2/CbVWv83eEUr0Re0ghKtbYSrZQVJ6m8rEMgq1emiv+9OS9urL31st
         d4V1afysMtX8CL21hGN/CRSo5FxlQY4nys7ImeREEy+Z+WLbGidA9w00vRfPu1Bt46oM
         w5qSrkkRCzQEEW29DpCasdZ9MrtwxfQB5EJwiHu8VgWuyC7IFTITCmnksjAHZ+GzMRd0
         HShnpOLLREfRJl3Vrc0nsEPKVPKN1Ueiv1Tglhs/NCm7PBPLdL6Qy8FDPUG5r7NMALWk
         d6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689614709; x=1692206709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S5YF+nlCOe3O1kBGIFVaMKzFvIcHGZB8RvnMAPyaULs=;
        b=f83CBTXLXyAsJUSCnFU6t6ZyqWQlBclzumgWgdkAFU9AReOA92r6/kh/QBSME+WAIP
         Ow+OvAw+XMmRQkMn0YhCGvPbddZ1PVruxY1x4yBe96zpfEdF+7+ZfwkcRBoRc3K2fglu
         7Xn0D2Isv6anlzsZJg835Mm2uLFP9v+fgg0xLU7lSWeavwiK5Ic9+zxv1p1VlsERyEuy
         ne5K1i17u4gR48KE6JjuEcW2JW9NpluW/8kY8cWjzOg/2TDCWOX61k8sZvRZhe+SFaMC
         VrKBIkyve/MfeUAyHU4d1NOfu1bhHS+eRqJ1DGAvUtQn98KDJfiQvJf7jcb8ve7QxiXj
         GPSA==
X-Gm-Message-State: ABy/qLb4BZ1jLR1So2eXhpMAchqClvL5C2vy3DBtCQNXJmyeE+GqqAkb
	MHajtz6V+zrAH2956dU8vUbncqI7fONl2nhmofk=
X-Google-Smtp-Source: APBJJlHudR+r+uwgC5kUy4C99ZW2LrZWnNJH9Pj6ySylSbTX1ELPMJ/3wmLJobkt4OEoud8mLjOnzuWRa9gTnsbfq8w=
X-Received: by 2002:a2e:3309:0:b0:2b7:3656:c594 with SMTP id
 d9-20020a2e3309000000b002b73656c594mr12705874ljc.3.1689614708703; Mon, 17 Jul
 2023 10:25:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230713023232.1411523-1-memxor@gmail.com> <20230713023232.1411523-5-memxor@gmail.com>
 <20230714215814.fqv5aypobicomszr@MacBook-Pro-8.local> <CAP01T74c7qcjDeAvav064ZTixCCznnyC4SMRB0YK=iN=hkwA8A@mail.gmail.com>
In-Reply-To: <CAP01T74c7qcjDeAvav064ZTixCCznnyC4SMRB0YK=iN=hkwA8A@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 17 Jul 2023 10:24:57 -0700
Message-ID: <CAADnVQLz5VtDSXwiK-gL4WFuHHJo7m41DAks8Y79ZaQc242iqg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 04/10] bpf: Add support for inserting new subprogs
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 17, 2023 at 9:22=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Sat, 15 Jul 2023 at 03:28, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Jul 13, 2023 at 08:02:26AM +0530, Kumar Kartikeya Dwivedi wrote=
:
> > > Introduce support in the verifier for generating a subprogram and
> > > include it as part of a BPF program dynamically after the do_check
> > > phase is complete. The appropriate place of invocation would be
> > > do_misc_fixups.
> > >
> > > Since they are always appended to the end of the instruction sequence=
 of
> > > the program, it becomes relatively inexpensive to do the related
> > > adjustments to the subprog_info of the program. Only the fake exit
> > > subprogram is shifted forward by 1, making room for our invented subp=
rog.
> > >
> > > This is useful to insert a new subprogram and obtain its function
> > > pointer. The next patch will use this functionality to insert a defau=
lt
> > > exception callback which will be invoked after unwinding the stack.
> > >
> > > Note that these invented subprograms are invisible to userspace, and
> > > never reported in BPF_OBJ_GET_INFO_BY_ID etc. For now, only a single
> > > invented program is supported, but more can be easily supported in th=
e
> > > future.
> > >
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> > >  include/linux/bpf.h          |  1 +
> > >  include/linux/bpf_verifier.h |  4 +++-
> > >  kernel/bpf/core.c            |  4 ++--
> > >  kernel/bpf/syscall.c         | 19 ++++++++++++++++++-
> > >  kernel/bpf/verifier.c        | 29 ++++++++++++++++++++++++++++-
> > >  5 files changed, 52 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index 360433f14496..70f212dddfbf 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -1385,6 +1385,7 @@ struct bpf_prog_aux {
> > >       bool sleepable;
> > >       bool tail_call_reachable;
> > >       bool xdp_has_frags;
> > > +     bool invented_prog;
> > >       /* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
> > >       const struct btf_type *attach_func_proto;
> > >       /* function name for valid attach_btf_id */
> > > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifie=
r.h
> > > index f70f9ac884d2..360aa304ec09 100644
> > > --- a/include/linux/bpf_verifier.h
> > > +++ b/include/linux/bpf_verifier.h
> > > @@ -540,6 +540,7 @@ struct bpf_subprog_info {
> > >       bool has_tail_call;
> > >       bool tail_call_reachable;
> > >       bool has_ld_abs;
> > > +     bool invented_prog;
> > >       bool is_async_cb;
> > >  };
> > >
> > > @@ -594,10 +595,11 @@ struct bpf_verifier_env {
> > >       bool bypass_spec_v1;
> > >       bool bypass_spec_v4;
> > >       bool seen_direct_write;
> > > +     bool invented_prog;
> >
> > Instead of a flag in two places how about adding aux->func_cnt_real
> > and use it in JITing and free-ing while get_info*() keep using aux->fun=
c_cnt.
> >
>
> That does seem better, thanks. I'll make the change in v2.
>
> > > +/* The function requires that first instruction in 'patch' is insnsi=
[prog->len - 1] */
> > > +static int invent_subprog(struct bpf_verifier_env *env, struct bpf_i=
nsn *patch, int len)
> > > +{
> > > +     struct bpf_subprog_info *info =3D env->subprog_info;
> > > +     int cnt =3D env->subprog_cnt;
> > > +     struct bpf_prog *prog;
> > > +
> > > +     if (env->invented_prog) {
> > > +             verbose(env, "verifier internal error: only one invente=
d prog supported\n");
> > > +             return -EFAULT;
> > > +     }
> > > +     prog =3D bpf_patch_insn_data(env, env->prog->len - 1, patch, le=
n);
> >
> > The actual patching is not necessary.
> > bpf_prog_realloc() and memcpy would be enough, no?
> >
>
> Yes, it should be fine. But I didn't want to special case things here
> just to make sure assumptions elsewhere don't break.
> E.g. code readily assumes every insn has its own insn_aux_data which
> might be broken if we don't expand it.
> I think bpf_patch_insn_single is already doing a realloc (and reusing
> trailing space in current allocation if available), so it didn't seem
> worth it to me.
>
> If you still feel it's better I can analyze if anything might break
> and make the change.

bpf_patch_insn_data() is a known performance bottleneck.
Folks have been trying to optimize it in the past.
It's certainly delicate code.
I guess since this extra subprog will only be added once
we can live with unnecessary overhead of bpf_patch_insn_data().
Just add the comment that we're not patching existing insn and
all of adjust* ops are nop.

