Return-Path: <bpf+bounces-19396-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C090B82B94F
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 03:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4C52B22B3C
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 02:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35951110;
	Fri, 12 Jan 2024 02:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePTnIUH7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE06EA6
	for <bpf@vger.kernel.org>; Fri, 12 Jan 2024 02:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3375a236525so4609948f8f.0
        for <bpf@vger.kernel.org>; Thu, 11 Jan 2024 18:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705025152; x=1705629952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOZhN8MYCPGSKvY1UKbGvpBlt+ivNVXuBhQf95SxzJs=;
        b=ePTnIUH72RwqFJIwgIu90X8cGGniPND8xxxExA2NPwkUDDr+Jwwmb/A+7Zq5lnbba2
         S3S3Th9QvxUixC/47Gs/JNEOtigZ6Vlv0esjUWqbiNArvlWEbH91wnyCm32gSs7bZtgs
         okDhq8Tv9Bo/mh972t1hBuwmIiOxxUgOCT0j1OEAzGkidTemtgh4A7daqQ5ba0KsEAUC
         6fnQPruSZO75YpwzbWfhUs0hxN0l+RY+N6gdZ5fkSibrBtyW4bhghaZ0/yGS8pcoD9K6
         HSYH24oBbk7pfavNOco6eyF6zmrOVUaX29fTho20S10weFI5FpYb8Br6JwkH2DKoo4uJ
         5qgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705025152; x=1705629952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOZhN8MYCPGSKvY1UKbGvpBlt+ivNVXuBhQf95SxzJs=;
        b=w7yPEGJRJuVU5rGUgmo3jTFG3L10/mjb1NokaTsI9/KV0Zl+wBfwj1OHauAKPGQFqd
         /eMoEqZ+EwOi1HCrWuvAb4plwHEehri4RCf9fhOjwMgNja3j31AumDuPzJok29MbuBdn
         J60hWPLUuZlUnRrfIGH893p8EGU2B++/3eiWOZd5c1W4g9rxKD2yItNzk9CZ+DLvoc29
         xrkkUHK3upPhYYqwbcxJkUaAGRlKhTAMraWPwJW9wSd4NMm1KElaQ6oJ1Dr1fTCFVobX
         bu+RR2a2/ggl77glnA1D8LsekTCt4JagVMsKAmXRVJR1V0jlBWfQjqnU1tPFbv3wbTKv
         PoxQ==
X-Gm-Message-State: AOJu0YygXg6AzsaUQP5P6VDKtW911Kj+I7a9/XzFWQ0I6QGro766CTKy
	O+r0meIQGzXDG1aQ/SZfpnjyapMzx9yaLHZcTMw=
X-Google-Smtp-Source: AGHT+IFeasOwml/Ek9K5fpClP57cPH5+X4inpFhmw1JWr43q29C0yQeo1ZgW0DzI8GCgqyWX1PFKguxk726tu1R0rHI=
X-Received: by 2002:a5d:4b4c:0:b0:337:8a0c:e21a with SMTP id
 w12-20020a5d4b4c000000b003378a0ce21amr325737wrs.41.1705025151398; Thu, 11 Jan
 2024 18:05:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105000909.2818934-1-andrii@kernel.org> <20240105000909.2818934-6-andrii@kernel.org>
In-Reply-To: <20240105000909.2818934-6-andrii@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 11 Jan 2024 18:05:39 -0800
Message-ID: <CAADnVQ+z52nCk6jC2erq99S=E=+1AAHsVp+bkc-7BP7PBO8B5Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/8] bpf: add __arg_trusted and __arg_untrusted
 global func tags
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Dave Marchevsky <davemarchevsky@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 4:09=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org> =
wrote:
>
> Add support for passing PTR_TO_BTF_ID registers to global subprogs.
> Currently two flavors are supported: trusted and untrusted. In both
> cases we assume _OR_NULL variants, so user would be forced to do a NULL
> check. __arg_nonnull can be used in conjunction with
> __arg_{trusted,untrusted} annotation to avoid unnecessary NULL checks,
> and subprog caller will be forced to provided known non-NULL pointers.
>
> Alternatively, we can add __arg_nullable and change default to be
> non-_OR_NULL, and __arg_nullable will allow to force NULL checks, if
> necessary. This probably would be a better usability overall, so let's
> discuss this.

Let's make __arg_trusted to be non-null by default.
I think it better matches existing kfuncs with KF_TRUSTED_ARGS.

Also pls use __arg_maybe_null name. "nullable" is difficult
to read and understand. maybe_null matches our internal names too.

Another thought..
may be add __arg_trusted_or_null alias that
will emit two decl tags "arg:trusted", "arg:maybe_null" ?

More below.

> Note, we disallow global subprogs to destroy passed in PTR_TO_BTF_ID
> arguments, even the trusted one. We achieve that by not setting
> ref_obj_id when validating subprog code. This basically enforces (in
> Rust terms) borrowing semantics vs move semantics. Borrowing semantics
> seems to be a better fit for isolated global subprog validation
> approach.
>
> Implementation-wise, we utilize existing logic for matching
> user-provided BTF type to kernel-side BTF type, used by BPF CO-RE logic
> and following same matching rules. We enforce a unique match for types.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/bpf_verifier.h                  |   1 +
>  kernel/bpf/btf.c                              | 103 +++++++++++++++---
>  kernel/bpf/verifier.c                         |  31 ++++++
>  .../bpf/progs/nested_trust_failure.c          |   2 +-
>  4 files changed, 123 insertions(+), 14 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index d07d857ca67f..eaea129c38ff 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -610,6 +610,7 @@ struct bpf_subprog_arg_info {
>         enum bpf_arg_type arg_type;
>         union {
>                 u32 mem_size;
> +               u32 btf_id;
>         };
>  };
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 368d8fe19d35..287a0581516e 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6802,9 +6802,78 @@ static bool btf_is_dynptr_ptr(const struct btf *bt=
f, const struct btf_type *t)
>         return false;
>  }
>
> +struct bpf_cand_cache {
> +       const char *name;
> +       u32 name_len;
> +       u16 kind;
> +       u16 cnt;
> +       struct {
> +               const struct btf *btf;
> +               u32 id;
> +       } cands[];
> +};
> +
> +static DEFINE_MUTEX(cand_cache_mutex);
> +
> +static struct bpf_cand_cache *
> +bpf_core_find_cands(struct bpf_core_ctx *ctx, u32 local_type_id);
> +
> +static int btf_get_ptr_to_btf_id(struct bpf_verifier_log *log, int arg_i=
dx,
> +                                const struct btf *btf, const struct btf_=
type *t)
> +{
> +       struct bpf_cand_cache *cc;
> +       struct bpf_core_ctx ctx =3D {
> +               .btf =3D btf,
> +               .log =3D log,
> +       };
> +       u32 kern_type_id, type_id;
> +       int err =3D 0;
> +
> +       /* skip PTR and modifiers */
> +       type_id =3D t->type;
> +       t =3D btf_type_by_id(btf, t->type);
> +       while (btf_type_is_modifier(t)) {
> +               type_id =3D t->type;
> +               t =3D btf_type_by_id(btf, t->type);
> +       }
> +
> +       mutex_lock(&cand_cache_mutex);
> +       cc =3D bpf_core_find_cands(&ctx, type_id);

heh. core-in-the-kernel got another use case :)

This allows flavors as well, so
bpf_prog(struct task_struct___v1 *tsk __arg_trusted)
will find the match.
I think it's fine to do. But let's add a test too.
I don't think patch 8 checks that.

> +       if (IS_ERR(cc)) {
> +               err =3D PTR_ERR(cc);
> +               bpf_log(log, "arg#%d reference type('%s %s') candidate ma=
tching error: %d\n",
> +                       arg_idx, btf_type_str(t), __btf_name_by_offset(bt=
f, t->name_off),
> +                       err);
> +               goto cand_cache_unlock;
> +       }
> +       if (cc->cnt !=3D 1) {
> +               bpf_log(log, "arg#%d reference type('%s %s') %s\n",
> +                       arg_idx, btf_type_str(t), __btf_name_by_offset(bt=
f, t->name_off),
> +                       cc->cnt =3D=3D 0 ? "has no matches" : "is ambiguo=
us");
> +               err =3D cc->cnt =3D=3D 0 ? -ENOENT : -ESRCH;
> +               goto cand_cache_unlock;
> +       }
> +       if (strcmp(cc->cands[0].btf->name, "vmlinux") !=3D 0) {

use btf_is_module() ?

> +               bpf_log(log, "arg#%d reference type('%s %s') points to ke=
rnel module type (unsupported)\n",
> +                       arg_idx, btf_type_str(t), __btf_name_by_offset(bt=
f, t->name_off));
> +               err =3D -EOPNOTSUPP;
> +               goto cand_cache_unlock;
> +       }
> +       kern_type_id =3D cc->cands[0].id;
> +
> +cand_cache_unlock:
> +       mutex_unlock(&cand_cache_mutex);
> +       if (err)
> +               return err;
> +
> +       return kern_type_id;
> +}
> +
>  enum btf_arg_tag {
>         ARG_TAG_CTX =3D 0x1,
>         ARG_TAG_NONNULL =3D 0x2,
> +       ARG_TAG_TRUSTED =3D 0x4,
> +       ARG_TAG_UNTRUSTED =3D 0x8,
>  };
>
>  /* Process BTF of a function to produce high-level expectation of functi=
on
> @@ -6906,6 +6975,10 @@ int btf_prepare_func_args(struct bpf_verifier_env =
*env, int subprog)
>
>                         if (strcmp(tag, "ctx") =3D=3D 0) {
>                                 tags |=3D ARG_TAG_CTX;
> +                       } else if (strcmp(tag, "trusted") =3D=3D 0) {
> +                               tags |=3D ARG_TAG_TRUSTED;
> +                       } else if (strcmp(tag, "untrusted") =3D=3D 0) {
> +                               tags |=3D ARG_TAG_UNTRUSTED;
>                         } else if (strcmp(tag, "nonnull") =3D=3D 0) {
>                                 tags |=3D ARG_TAG_NONNULL;
>                         } else {
> @@ -6940,6 +7013,23 @@ int btf_prepare_func_args(struct bpf_verifier_env =
*env, int subprog)
>                         sub->args[i].arg_type =3D ARG_PTR_TO_DYNPTR | MEM=
_RDONLY;
>                         continue;
>                 }
> +               if (tags & (ARG_TAG_TRUSTED | ARG_TAG_UNTRUSTED)) {
> +                       int kern_type_id;
> +
> +                       kern_type_id =3D btf_get_ptr_to_btf_id(log, i, bt=
f, t);
> +                       if (kern_type_id < 0)
> +                               return kern_type_id;
> +
> +                       sub->args[i].arg_type =3D ARG_PTR_TO_BTF_ID | PTR=
_UNTRUSTED | PTR_MAYBE_NULL;

PTR_MAYBE_NULL doesn't make sense for untrusted.
It may be zero or -1 or 0xffff the bpf prog may or may not
compare that with NULL or any other value.
It doesn't affect safety and the verifier shouldn't be tracking
null-ness of untrusted pointers. Just to avoid extra code and run-time.

But more importantly...
ARG_PTR_TO_BTF_ID with PTR_UNTRUSTED looks scary to me.
base_type() trims flags and in many places we check
base_type(arg) =3D=3D ARG_PTR_TO_BTF_ID
the rhs can come from helper defs in .arg1_type too.
A lot of code need to be carefully audited to make sure
we don't accidently introduce a safety issue because
PTR_TO_BTF_ID | PTR_UNTRUSTED was added to btf_ptr_types[].
The handling of it in check_reg_type() looks ok though...

> @@ -8262,6 +8263,12 @@ static int check_reg_type(struct bpf_verifier_env =
*env, u32 regno,
>         case PTR_TO_BTF_ID | MEM_PERCPU | PTR_TRUSTED:
>                 /* Handled by helper specific checks */
>                 break;
> +       case PTR_TO_BTF_ID | PTR_UNTRUSTED:
> +               if (!(arg_type & PTR_UNTRUSTED)) {
> +                       verbose(env, "Passing unexpected untrusted pointe=
r as arg#%d\n", regno);
> +                       return -EACCES;
> +               }

both type and arg_type are untrusted, but I need to spend
a ton more time thinking it through.
Maybe avoid adding __arg_untrusted for now?
The patch will be easier to understand. At least for me.

