Return-Path: <bpf+bounces-19476-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE7A82C594
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 19:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC3332850B1
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 18:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9420A154BA;
	Fri, 12 Jan 2024 18:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwqVayqq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B8B14F8C
	for <bpf@vger.kernel.org>; Fri, 12 Jan 2024 18:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-555bd21f9fdso7605518a12.0
        for <bpf@vger.kernel.org>; Fri, 12 Jan 2024 10:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705085029; x=1705689829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltm18RRyApF51sU2y/ohVIsBbXcYvIt7ENEu2fdxoZY=;
        b=FwqVayqq6PBpdXxTaFmUpfuYNZ+m5GnOtf+yrywggGMvsTObvt4V4ZlehaTwkfqoDj
         gwTSNNZO6s8bBAn8xwN22YpgcoNLxOmsLd68UR8vLIZDeBBXYYOVrZ5dvIoj9qiirsln
         0b0+Wzba0x6lx1EITq6HXZ/vbuHMDldIItmLRqHr85H1tyQlM/Qisy/3xKzPyUIYXtCM
         dTq3AaUX0bq4oajmPAiq9BjTGzk5ZqS0DdXe8XFiXMBvdMrNuFCU6roGCr5KtbyO4VWp
         N/26Bcztb51PKZurW+BPJYrBrcWZu15hVhK53QqExHoRAhTtwjlBPzdMPnkK0U7zbCzj
         5DiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705085029; x=1705689829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ltm18RRyApF51sU2y/ohVIsBbXcYvIt7ENEu2fdxoZY=;
        b=gssDko8Kuee81QdpRI01cakyGxJFcXMwZQnSE6dEIv4C2rflxPjNsc1PvjSvmEo5it
         G+2rwWgv96exWGvn8EWYqVjmxAo/KvpVRV6L1U/GONohugAo4jvCNxS95ofNt7Nng4qC
         Ue3e2uloP5Ic4Z2WdiE5aUNireg+BDzNKPSygZ5nZtG6Cu/e98EBqoPOQ2DLrA88KTvH
         HKeqDFwKrLzypQmI5Wgoj7HmDrlMqi11uiB8Z3JLRalD4yLiqoybnPFutV3I6KoHnPQC
         pfYPaBK7rRrYkmN/9cFQj+5/YVZBxaV9lJxKeWlGf3JsiB2hb+INKrB0KgXmvirX9Nmn
         Y3cw==
X-Gm-Message-State: AOJu0YyLvAXi++3oJ9/k6ly060qJJdRAXyTcQmifTSlRX8kJ0fwaLzfm
	oX4ovMvqdHmQd6fBC9xW0MS6rPKalerNh4DeS6Dve0mhtsE=
X-Google-Smtp-Source: AGHT+IGmjoXhwno1VIyZmeEnxASWhId+1OXf6TpYubPoLlcKVl0uvz7/vhf6pJBE26chNQFENuxTd6/eRHuWtyqR2D4=
X-Received: by 2002:a05:6402:290d:b0:558:c105:5ea6 with SMTP id
 ee13-20020a056402290d00b00558c1055ea6mr813641edb.50.1705085029405; Fri, 12
 Jan 2024 10:43:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105000909.2818934-1-andrii@kernel.org> <20240105000909.2818934-6-andrii@kernel.org>
 <CAADnVQ+z52nCk6jC2erq99S=E=+1AAHsVp+bkc-7BP7PBO8B5Q@mail.gmail.com>
In-Reply-To: <CAADnVQ+z52nCk6jC2erq99S=E=+1AAHsVp+bkc-7BP7PBO8B5Q@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 12 Jan 2024 10:43:37 -0800
Message-ID: <CAEf4BzZZyVuzs1s9Fm_bMx4VdVmOKd-biEjeL9pfO_jcYrVUVQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/8] bpf: add __arg_trusted and __arg_untrusted
 global func tags
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Dave Marchevsky <davemarchevsky@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 6:05=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jan 4, 2024 at 4:09=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org=
> wrote:
> >
> > Add support for passing PTR_TO_BTF_ID registers to global subprogs.
> > Currently two flavors are supported: trusted and untrusted. In both
> > cases we assume _OR_NULL variants, so user would be forced to do a NULL
> > check. __arg_nonnull can be used in conjunction with
> > __arg_{trusted,untrusted} annotation to avoid unnecessary NULL checks,
> > and subprog caller will be forced to provided known non-NULL pointers.
> >
> > Alternatively, we can add __arg_nullable and change default to be
> > non-_OR_NULL, and __arg_nullable will allow to force NULL checks, if
> > necessary. This probably would be a better usability overall, so let's
> > discuss this.
>
> Let's make __arg_trusted to be non-null by default.
> I think it better matches existing kfuncs with KF_TRUSTED_ARGS.

yep, agreed, already did locally

>
> Also pls use __arg_maybe_null name. "nullable" is difficult
> to read and understand. maybe_null matches our internal names too.

not happy about verbose "maybe_null" naming, tbh, but I don't want to
bikeshed. I like "nullable" because it's a well-known concept across
many languages, so it doesn't seem to be that alien. And it nicely
complements __arg_nonnull.

But I'll rename it because I don't want bikeshedding.

>
> Another thought..
> may be add __arg_trusted_or_null alias that
> will emit two decl tags "arg:trusted", "arg:maybe_null" ?

no, I want to keep them separate. In the future this maybe_null can be
combined with some other tags, I don't want to create all combinations
as macros. I think __arg_trusted __arg_maybe_null is totally fine as
an annotation and doesn't save much in terms of typing if it's
combined into a single macro.

>
> More below.
>
> > Note, we disallow global subprogs to destroy passed in PTR_TO_BTF_ID
> > arguments, even the trusted one. We achieve that by not setting
> > ref_obj_id when validating subprog code. This basically enforces (in
> > Rust terms) borrowing semantics vs move semantics. Borrowing semantics
> > seems to be a better fit for isolated global subprog validation
> > approach.
> >
> > Implementation-wise, we utilize existing logic for matching
> > user-provided BTF type to kernel-side BTF type, used by BPF CO-RE logic
> > and following same matching rules. We enforce a unique match for types.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  include/linux/bpf_verifier.h                  |   1 +
> >  kernel/bpf/btf.c                              | 103 +++++++++++++++---
> >  kernel/bpf/verifier.c                         |  31 ++++++
> >  .../bpf/progs/nested_trust_failure.c          |   2 +-
> >  4 files changed, 123 insertions(+), 14 deletions(-)
> >
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
> > index d07d857ca67f..eaea129c38ff 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -610,6 +610,7 @@ struct bpf_subprog_arg_info {
> >         enum bpf_arg_type arg_type;
> >         union {
> >                 u32 mem_size;
> > +               u32 btf_id;
> >         };
> >  };
> >
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 368d8fe19d35..287a0581516e 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -6802,9 +6802,78 @@ static bool btf_is_dynptr_ptr(const struct btf *=
btf, const struct btf_type *t)
> >         return false;
> >  }
> >
> > +struct bpf_cand_cache {
> > +       const char *name;
> > +       u32 name_len;
> > +       u16 kind;
> > +       u16 cnt;
> > +       struct {
> > +               const struct btf *btf;
> > +               u32 id;
> > +       } cands[];
> > +};
> > +
> > +static DEFINE_MUTEX(cand_cache_mutex);
> > +
> > +static struct bpf_cand_cache *
> > +bpf_core_find_cands(struct bpf_core_ctx *ctx, u32 local_type_id);
> > +
> > +static int btf_get_ptr_to_btf_id(struct bpf_verifier_log *log, int arg=
_idx,
> > +                                const struct btf *btf, const struct bt=
f_type *t)
> > +{
> > +       struct bpf_cand_cache *cc;
> > +       struct bpf_core_ctx ctx =3D {
> > +               .btf =3D btf,
> > +               .log =3D log,
> > +       };
> > +       u32 kern_type_id, type_id;
> > +       int err =3D 0;
> > +
> > +       /* skip PTR and modifiers */
> > +       type_id =3D t->type;
> > +       t =3D btf_type_by_id(btf, t->type);
> > +       while (btf_type_is_modifier(t)) {
> > +               type_id =3D t->type;
> > +               t =3D btf_type_by_id(btf, t->type);
> > +       }
> > +
> > +       mutex_lock(&cand_cache_mutex);
> > +       cc =3D bpf_core_find_cands(&ctx, type_id);
>
> heh. core-in-the-kernel got another use case :)

it's probably also what we should use in btf_translate_to_vmlinux(),
btw, and is the reason we got into this sk_buff vs __sk_buff confusion
in the first place. But that's not part of my upcoming changes.

>
> This allows flavors as well, so
> bpf_prog(struct task_struct___v1 *tsk __arg_trusted)
> will find the match.
> I think it's fine to do. But let's add a test too.
> I don't think patch 8 checks that.

Good point, will add.

>
> > +       if (IS_ERR(cc)) {
> > +               err =3D PTR_ERR(cc);
> > +               bpf_log(log, "arg#%d reference type('%s %s') candidate =
matching error: %d\n",
> > +                       arg_idx, btf_type_str(t), __btf_name_by_offset(=
btf, t->name_off),
> > +                       err);
> > +               goto cand_cache_unlock;
> > +       }
> > +       if (cc->cnt !=3D 1) {
> > +               bpf_log(log, "arg#%d reference type('%s %s') %s\n",
> > +                       arg_idx, btf_type_str(t), __btf_name_by_offset(=
btf, t->name_off),
> > +                       cc->cnt =3D=3D 0 ? "has no matches" : "is ambig=
uous");
> > +               err =3D cc->cnt =3D=3D 0 ? -ENOENT : -ESRCH;
> > +               goto cand_cache_unlock;
> > +       }
> > +       if (strcmp(cc->cands[0].btf->name, "vmlinux") !=3D 0) {
>
> use btf_is_module() ?

oh, I was trying to find it and couldn't. Great, will use btf_is_module().

>
> > +               bpf_log(log, "arg#%d reference type('%s %s') points to =
kernel module type (unsupported)\n",
> > +                       arg_idx, btf_type_str(t), __btf_name_by_offset(=
btf, t->name_off));
> > +               err =3D -EOPNOTSUPP;
> > +               goto cand_cache_unlock;
> > +       }
> > +       kern_type_id =3D cc->cands[0].id;
> > +
> > +cand_cache_unlock:
> > +       mutex_unlock(&cand_cache_mutex);
> > +       if (err)
> > +               return err;
> > +
> > +       return kern_type_id;
> > +}
> > +
> >  enum btf_arg_tag {
> >         ARG_TAG_CTX =3D 0x1,
> >         ARG_TAG_NONNULL =3D 0x2,
> > +       ARG_TAG_TRUSTED =3D 0x4,
> > +       ARG_TAG_UNTRUSTED =3D 0x8,
> >  };
> >
> >  /* Process BTF of a function to produce high-level expectation of func=
tion
> > @@ -6906,6 +6975,10 @@ int btf_prepare_func_args(struct bpf_verifier_en=
v *env, int subprog)
> >
> >                         if (strcmp(tag, "ctx") =3D=3D 0) {
> >                                 tags |=3D ARG_TAG_CTX;
> > +                       } else if (strcmp(tag, "trusted") =3D=3D 0) {
> > +                               tags |=3D ARG_TAG_TRUSTED;
> > +                       } else if (strcmp(tag, "untrusted") =3D=3D 0) {
> > +                               tags |=3D ARG_TAG_UNTRUSTED;
> >                         } else if (strcmp(tag, "nonnull") =3D=3D 0) {
> >                                 tags |=3D ARG_TAG_NONNULL;
> >                         } else {
> > @@ -6940,6 +7013,23 @@ int btf_prepare_func_args(struct bpf_verifier_en=
v *env, int subprog)
> >                         sub->args[i].arg_type =3D ARG_PTR_TO_DYNPTR | M=
EM_RDONLY;
> >                         continue;
> >                 }
> > +               if (tags & (ARG_TAG_TRUSTED | ARG_TAG_UNTRUSTED)) {
> > +                       int kern_type_id;
> > +
> > +                       kern_type_id =3D btf_get_ptr_to_btf_id(log, i, =
btf, t);
> > +                       if (kern_type_id < 0)
> > +                               return kern_type_id;
> > +
> > +                       sub->args[i].arg_type =3D ARG_PTR_TO_BTF_ID | P=
TR_UNTRUSTED | PTR_MAYBE_NULL;
>
> PTR_MAYBE_NULL doesn't make sense for untrusted.
> It may be zero or -1 or 0xffff the bpf prog may or may not
> compare that with NULL or any other value.
> It doesn't affect safety and the verifier shouldn't be tracking
> null-ness of untrusted pointers. Just to avoid extra code and run-time.

The idea was to allow the caller to pass explicit NULL for such an
argument to say "no parameter", basically. I understand that at
runtime you can have non-zero actual value and exception handling code
will handle that.

>
> But more importantly...
> ARG_PTR_TO_BTF_ID with PTR_UNTRUSTED looks scary to me.
> base_type() trims flags and in many places we check
> base_type(arg) =3D=3D ARG_PTR_TO_BTF_ID
> the rhs can come from helper defs in .arg1_type too.
> A lot of code need to be carefully audited to make sure
> we don't accidently introduce a safety issue because
> PTR_TO_BTF_ID | PTR_UNTRUSTED was added to btf_ptr_types[].
> The handling of it in check_reg_type() looks ok though...
>
> > @@ -8262,6 +8263,12 @@ static int check_reg_type(struct bpf_verifier_en=
v *env, u32 regno,
> >         case PTR_TO_BTF_ID | MEM_PERCPU | PTR_TRUSTED:
> >                 /* Handled by helper specific checks */
> >                 break;
> > +       case PTR_TO_BTF_ID | PTR_UNTRUSTED:
> > +               if (!(arg_type & PTR_UNTRUSTED)) {
> > +                       verbose(env, "Passing unexpected untrusted poin=
ter as arg#%d\n", regno);
> > +                       return -EACCES;
> > +               }
>
> both type and arg_type are untrusted, but I need to spend
> a ton more time thinking it through.
> Maybe avoid adding __arg_untrusted for now?
> The patch will be easier to understand. At least for me.
>

Ok, no problem. I added __arg_untrusted for completeness and I can see
people wanting to pass PTR_TO_BTF_ID they got from tracepoint or
whatnot. But __arg_trusted is more critical and can't be worked
around, while you can get effectively __arg_untrusted with passing
uintptr_t argument and then doing bpf_rdonly_cast(). Will drop
__arg_untrusted for now.

