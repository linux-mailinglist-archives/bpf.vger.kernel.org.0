Return-Path: <bpf+bounces-70331-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBE2BB7E8E
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 20:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FF1D3C0C71
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 18:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137C927C864;
	Fri,  3 Oct 2025 18:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzjXZxbF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D74727456
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 18:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759517160; cv=none; b=Rssz/m7U7tdIRhDCbS+B0JFv0fwE34hFEFEcYEaNL2dJgfjACaR5fBL6CflDhkAS2mSHmSilb7b+6pPdSEYB/t5aSJlrcAzAGJ5sehHqEOICWufx4uzEiUjU0NTgCTQIeNQeqqQEfLCyPwLjBlIRVYwlCTfAGyRatjH/WYQCKck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759517160; c=relaxed/simple;
	bh=/lVx/2yovW/YtsUKKVN09nO0NvFnXhfLINOoJTnZQDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IifKv5vG/4QrkjZoSb8f1kkmsxeRCsA3xR+3WUzpcrfcu8luSelEdNSHREcPStBbK/C4PpR2DW6s5v61KHPnITpm1RyDVC/n8QIzSUfoC6FkQOvmv1JIbNWSe5KaF1P4YSdDR2ABnLZ2Ufcn/K29im+5vNX2CaSY00Ls2plp/Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YzjXZxbF; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b55640a2e33so1956009a12.2
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 11:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759517158; x=1760121958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfJflTNRNvD4vMPLcnvBsThHYOO95XFoALbkWDA8QMs=;
        b=YzjXZxbFqS0BzFu6VJkc2pdGylEnIN56QskFHP0LpFZzXhZYSCViIDnsV8EfDefM70
         5EnnwubRWSFBn1pUvxzi6La+C5j23Pn7JMdZQiD5d7hL3o7fzuWn6QoVFEZypT3nUL5F
         fzQTQers3/oQMOwWePsJ2pzbsplwJR/PQysCpsuhHfCqmLsaQNtbuPvZWT8FQTq01CUW
         aykhG72CAiYZrgJOt0DQ0uz2NXVxxGAU75qgF0A5sR5vRCuqJGUZyxhciPAbZPfDWc18
         yVp4A+wCJZwhuBSsp5JpV7hELky1VdsNSVIXfkCxyYMmnuNQDFQSq04jq4UBi0wf9fNu
         kyTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759517158; x=1760121958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kfJflTNRNvD4vMPLcnvBsThHYOO95XFoALbkWDA8QMs=;
        b=fxgLCycPq3KPBjM7pDNAlax6CgWpr4mZbi8tZPvGBP9MQ+tQNzKI5kdAzckLxi3y/9
         LPDYvjIwSeddTF8YfiIN4tMr77AAfaHcQupR31ppFgBco6lAD3TvQwJXX3bYT/6uvivS
         bxQZkS/YFp1qnLA58Fqs8G43Mn6GVFyQqVZ7xY6epl2qkWGSXe2wq4Rv+lAbkpClTUEV
         tNxVZ92vaQOykC16pjD3ZwLPsNo9YWj81uBxqQ2ku87qIqeGd5eMrylZBCkfDUnLvrgv
         CKEzqdoeBLKPzOrcGS9rRW8p1/ZXNjLtda6I41hNHqaDerzhY1oK2sfK1vftb/L2SHNu
         vbSA==
X-Gm-Message-State: AOJu0YzaVHhAgXa12lW5yQxEY6pA6VPri6qa291nvySFJ2mx6SxXCzPf
	cDFIT+MaSKBqKFD12WYHl8Y5+5Fk+DFTDNKSxOoAz/ngjSXihkl6C82l8+nsF8c3AQA51I6D4rR
	l46uQuh0Sn36oJORHPZ+CLBl2+EXiUTM=
X-Gm-Gg: ASbGnctZdykyu1D155EmiGeZRKQjxasBt7b/oLvI+AuKdTrIS2aCE6L1Cg6WzK+jT0b
	ogaUDKl8duAh5H4Mos8aCD+tsD6h5ZO2S9cJje/sDYRcsUEqRDPTwN4vgsIVwOHTfjmAPd7nS7G
	TJPf+VzOefadhfq3LoqKQhxcMko8UPAIx7d3MpdRWkULE/uTPvLPDJOaDjo8FdS6Qed3HWamwDL
	MvYOqaMJK1Fp9uXqF/9y738jwpcmo26xgbVFsvZcnzhiaw=
X-Google-Smtp-Source: AGHT+IG/oHwAJexJD/7YppQ1CcJ48acQTPtwezWT/s0XIP9yU7V0mjNfLvT9VHad7qvIRQBm7taLd62al+HxUGK1V3M=
X-Received: by 2002:a17:903:2284:b0:27e:ee83:fc80 with SMTP id
 d9443c01a7336-28e9a6ab31bmr50169675ad.57.1759517158309; Fri, 03 Oct 2025
 11:45:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003160416.585080-1-mykyta.yatsenko5@gmail.com> <20251003160416.585080-10-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20251003160416.585080-10-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 3 Oct 2025 11:45:44 -0700
X-Gm-Features: AS18NWBX0IX3uyxgSE694nhXPyINUan7U9aNfGnVHU6V804vlR3JYpEDotEjODc
Message-ID: <CAEf4BzaAOsCYSOa7yW-Z7qTirAKi4MUN6xLqW9OjOpS7Lj1NBg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 09/10] bpf: dispatch to sleepable file dynptr
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 9:04=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> File dynptr reads may sleep when the requested folios are not in
> the page cache. To avoid sleeping in non-sleepable contexts while still
> supporting valid sleepable use, given that dynptrs are non-sleepable by
> default, enable sleeping only when bpf_dynptr_from_file() is invoked
> from a sleepable context.
>
> This change:
>   * Introduces a sleepable constructor: bpf_dynptr_from_file_sleepable()
>   * Detects whether the kfunc is called in a sleepable context and
>   stores the result in bpf_insn_aux_data (kfunc_in_sleepable_ctx)
>   * Rewrites bpf_dynptr_from_file() calls to the sleepable variant when
>   kfunc_in_sleepable_ctx is set
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  include/linux/bpf.h          |  3 +++
>  include/linux/bpf_verifier.h |  2 ++
>  kernel/bpf/helpers.c         |  5 +++++
>  kernel/bpf/verifier.c        | 12 +++++++++---
>  4 files changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index bd70117b8e84..9da7460e078c 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -663,6 +663,9 @@ int map_check_no_btf(const struct bpf_map *map,
>  bool bpf_map_meta_equal(const struct bpf_map *meta0,
>                         const struct bpf_map *meta1);
>
> +int bpf_dynptr_from_file_sleepable(struct file *file, u32 flags,
> +                                  struct bpf_dynptr *ptr__uninit);
> +
>  extern const struct bpf_map_ops bpf_map_offload_ops;
>
>  /* bpf_type_flag contains a set of flags that are applicable to the valu=
es of
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 4c497e839526..6078d5e9b535 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -581,6 +581,8 @@ struct bpf_insn_aux_data {
>         u32 scc;
>         /* registers alive before this instruction. */
>         u16 live_regs_before;
> +       /* kfunc is called in sleepable context */
> +       bool kfunc_in_sleepable_ctx;

there is one byte left after call_with_percpu_alloc_ptr, please move this t=
here

>  };
>
>  #define MAX_USED_MAPS 64 /* max number of maps accessed by one eBPF prog=
ram */
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 4bba516599c7..f452e22333fe 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -4288,6 +4288,11 @@ __bpf_kfunc int bpf_dynptr_from_file(struct file *=
file, u32 flags, struct bpf_dy
>         return make_file_dynptr(file, flags, MAY_NOT_SLEEP, (struct bpf_d=
ynptr_kern *)ptr__uninit);
>  }
>
> +int bpf_dynptr_from_file_sleepable(struct file *file, u32 flags, struct =
bpf_dynptr *ptr__uninit)
> +{
> +       return make_file_dynptr(file, flags, MAY_SLEEP, (struct bpf_dynpt=
r_kern *)ptr__uninit);
> +}
> +
>  __bpf_kfunc int bpf_dynptr_file_discard(struct bpf_dynptr *dynptr)
>  {
>         struct bpf_dynptr_kern *ptr =3D (struct bpf_dynptr_kern *)dynptr;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index aacefa3d0544..82762eab3f17 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3105,7 +3105,8 @@ struct bpf_kfunc_btf_tab {
>
>  static unsigned long kfunc_call_imm(unsigned long func_addr, u32 func_id=
);
>
> -static void specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kf=
unc_desc *desc);
> +static void specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kf=
unc_desc *desc,
> +                            int insn_idx);
>
>  static int kfunc_desc_cmp_by_id_off(const void *a, const void *b)
>  {
> @@ -13833,6 +13834,7 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
>         insn_aux =3D &env->insn_aux_data[insn_idx];
>
>         insn_aux->is_iter_next =3D is_iter_next_kfunc(&meta);
> +       insn_aux->kfunc_in_sleepable_ctx =3D in_sleepable(env);

can it happen that same instruction will be called both from sleepable
and non-sleepable contexts? E.g., if async callback calls into subprog
that is also called from main non-sleepable program? We should detect
this (and have a test)

(and then maybe generalize this field to mean "does this instruction
always run in sleepable/non-sleepable/mixed context"?


>
>         if (!insn->off &&
>             (insn->imm =3D=3D special_kfunc_list[KF_bpf_res_spin_lock] ||
> @@ -21832,7 +21834,8 @@ static unsigned long kfunc_call_imm(unsigned long=
 func_addr, u32 func_id)
>  }
>
>  /* replace a generic kfunc with a specialized version if necessary */
> -static void specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kf=
unc_desc *desc)
> +static void specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kf=
unc_desc *desc,
> +                            int insn_idx)
>  {
>         struct bpf_prog_aux *prog_aux =3D env->prog->aux;
>         struct bpf_kfunc_desc_tab *tab =3D prog_aux->kfunc_tab;
> @@ -21872,6 +21875,9 @@ static void specialize_kfunc(struct bpf_verifier_=
env *env, struct bpf_kfunc_desc
>         } else if (func_id =3D=3D special_kfunc_list[KF_bpf_remove_dentry=
_xattr]) {
>                 if (bpf_lsm_has_d_inode_locked(prog))
>                         addr =3D (unsigned long)bpf_remove_dentry_xattr_l=
ocked;
> +       } else if (func_id =3D=3D special_kfunc_list[KF_bpf_dynptr_from_f=
ile]) {
> +               if (env->insn_aux_data[insn_idx].kfunc_in_sleepable_ctx)
> +                       addr =3D (unsigned long)bpf_dynptr_from_file_slee=
pable;
>         }
>
>         if (!addr) /* Nothing to patch with */
> @@ -21924,7 +21930,7 @@ static int fixup_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
>                 return -EFAULT;
>         }
>
> -       specialize_kfunc(env, desc);
> +       specialize_kfunc(env, desc, insn_idx);
>
>         if (!bpf_jit_supports_far_kfunc_call())
>                 insn->imm =3D BPF_CALL_IMM(desc->addr);
> --
> 2.51.0
>

