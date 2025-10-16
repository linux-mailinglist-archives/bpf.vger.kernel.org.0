Return-Path: <bpf+bounces-71150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B64CBE567B
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 22:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7DE9E4EAA87
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 20:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF4C1A9F93;
	Thu, 16 Oct 2025 20:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUeV8xAs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60AC2641C6
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 20:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760646548; cv=none; b=fExos2Gy+MGRdRJggcZLya3iH8DPw7RQFvMSUwbvVemnTGMwuKItbHbvqhmJ/wyJft/ixpGrDYW1XST6EIXHHsf3XwkuUNGaxdoNROqAoWgXIJiBTBwSLGSB31HxY/avTsiv5Y5Q26PcF+CoDemVBHkcKC2CoIilal6QIcIU9Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760646548; c=relaxed/simple;
	bh=s42gRDSS1AHQhpajXq/hT4tCUJe0h7sFdMuSEGi/WFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fFTqL2uck11DV2BmUoAfXPgQQbynBxrpFqpYblG/N8s+dnNHf6UHzKFMg0AnqJ7CC+l5f0Dg6cXhcBbV1q8xlaxil+daFeFdGt57DNWKNXCfMPvUbhJbOFqZ+MnlP5epeWMt/O7Ej7fKqUmCMjlnDOUnVSks4d9w64WMdxVdcXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUeV8xAs; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2909448641eso11330875ad.1
        for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 13:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760646544; x=1761251344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bz/E7D6smIxHWgBRM5rMEkJi2bJI3GlkSmO1rEJ3GQk=;
        b=lUeV8xAsWwH0Ft2lZWV0pp6lZnwLUhtuK7ctzp9eBVM7TqzEQx97kBeuc7bzjRVDxo
         CglA5pW4FAu2YSDCCBoKvG+jJKMzdUz58svANLfNznvnmY4w2P7vz6VDv7jej8JngsgF
         qMpizXh0UkgYSboWeHYaOJKUzDlkOe8bjQsmFYx65n3w1fTXgzv6+pLsiOeQm9Nzuwgu
         hjBLiymMP7BnsuL6gnVe9XVPAz5xYn+aR3bO9rXvEO8mojUPxTmTD0eBSNwy+7AgrS6g
         o3PozBlo4bmLyEcQa2NzhJYXVsHjDm+zSxH0G75QOxrcZsXbxrG0zwBtwuduqdQvbZCF
         fVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760646544; x=1761251344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bz/E7D6smIxHWgBRM5rMEkJi2bJI3GlkSmO1rEJ3GQk=;
        b=VSpyZH3RnyANaQ544dHKozaSWGblqlCLbmd4tuvNU3pMyTInH6Cs23GEdoJJ+7bzgE
         uKy1UQFgw+WFIeEsPGy+Xy9dNbyFFcBrG/Y312HYn3Dd2F+n9n3NjzupIw0mndooTA7k
         t2gUZD6PVxXIRFVZ2BiBciRMRFuuMZepxht8Txj6S0BvoCQnJsP3aoF6voOLDAPakb2h
         tmWI67JWSkwp6FzHTaNR9djAPRXZ8muII3jsM4ok1K+RGi80gko2a03XR+Iv3FnF+Wlj
         +n+SSpUapcUW37CsKB7cm+j5vmTnEsmqDZt+g0hErnCX1nNcjMJknbHga1N9eHHJKMiX
         XrkA==
X-Gm-Message-State: AOJu0YwAwdIPmt06sDwY9gkcbX4mJ+gsoCYayeAZcKpwa+xB6GiWVb6q
	LM/bstua6Z8Hy6XcPfbNrS0OCc3b3tGspZU7fTnGcsMpIk+yfysHShno0vMKjSGol8hynIHPUk2
	4MjlbE1TKfRrnlmFDgjXtPUfPFFTBC9I=
X-Gm-Gg: ASbGncs58D8u/JOh2Le9DBpkG4mcUCjNgEzNgv7qtDGLjzDhSlQ51ADw2JtAsQmXd+l
	RQ7sRAjl7+cQ8DKQabyLFeYpq82wfu6kfW5F69H3sc1Owy67w0UnJIOz18yjXAYl8Bgl+cBB6PN
	I0Z8E17A+9O3TajgFqIJZ2NliPvUvtF74ocYMeIzqHnP1zDFESXQls9Vz3VzeBouvtkVGst67zq
	RA1JZbD/AdhMoTm+rHtZB4m6ymswMxTnAuVBkCj5EZRJDuft/5yrI11qwztrKaaRZlZwGWlvl61
	e7szhiK6DIM=
X-Google-Smtp-Source: AGHT+IFOEPsineS2STfpzMvDXew7DNDDB3ollw0aTnkx328MoQ/l6Njs7fpx+NLJ6VOzOPcYcXKUhytnNihmXA3A6Gw=
X-Received: by 2002:a17:903:3205:b0:267:8b4f:df36 with SMTP id
 d9443c01a7336-29091be7fb3mr64028605ad.29.1760646543934; Thu, 16 Oct 2025
 13:29:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015161155.120148-1-mykyta.yatsenko5@gmail.com> <20251015161155.120148-8-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20251015161155.120148-8-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 16 Oct 2025 13:28:46 -0700
X-Gm-Features: AS18NWAjeCjQ4mpiaa2BW1WUyEAn-8RHvAA2UlqMAm0Pqd_SugUFkWwbcxBlZyY
Message-ID: <CAEf4BzYFKDsrRWGoj4+_dj_nQ_U9MFDCwaUOLbyYfUq0POPOyA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 07/11] bpf: add plumbing for file-backed dynptr
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 9:12=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Add the necessary verifier plumbing for the new file-backed dynptr type.
> Introduce two kfuncs for its lifecycle management:
>  * bpf_dynptr_from_file() for initialization
>  * bpf_dynptr_file_discard() for destruction
>
> Currently there is no mechanism for kfunc to release dynptr, this patch
> add one:
>  * Dynptr release function sets meta->release_regno
>  * Call unmark_stack_slots_dynptr() if meta->release_regno is set and
>  dynptr ref_obj_id is set as well.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  include/linux/bpf.h   |  7 ++++++-
>  kernel/bpf/helpers.c  | 12 ++++++++++++
>  kernel/bpf/log.c      |  2 ++
>  kernel/bpf/verifier.c | 25 +++++++++++++++++++++++--
>  4 files changed, 43 insertions(+), 3 deletions(-)

[...]

>  static void bpf_task_work_cancel_scheduled(struct irq_work *irq_work)
> @@ -4430,6 +4440,8 @@ BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
>  BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_TRUSTED_ARGS)
>  BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_TRUSTED_ARGS)
>  BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_dynptr_from_file, KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_dynptr_file_discard, KF_TRUSTED_ARGS)

do we need KF_TRUSTED_ARGS for this one? dynptr passed into kfunc
always has to be correct, so KF_TRUSTED_ARGS serves no purpose?

>  BTF_KFUNCS_END(common_btf_ids)
>
>  static const struct btf_kfunc_id_set common_kfunc_set =3D {

[...]

> @@ -13323,6 +13331,11 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_kfunc_call_
>                                 dynptr_arg_type |=3D DYNPTR_TYPE_XDP;
>                         } else if (meta->func_id =3D=3D special_kfunc_lis=
t[KF_bpf_dynptr_from_skb_meta]) {
>                                 dynptr_arg_type |=3D DYNPTR_TYPE_SKB_META=
;
> +                       } else if (meta->func_id =3D=3D special_kfunc_lis=
t[KF_bpf_dynptr_from_file]) {
> +                               dynptr_arg_type |=3D DYNPTR_TYPE_FILE;
> +                       } else if (meta->func_id =3D=3D special_kfunc_lis=
t[KF_bpf_dynptr_file_discard]) {
> +                               dynptr_arg_type |=3D DYNPTR_TYPE_FILE;
> +                               meta->release_regno =3D regno;
>                         } else if (meta->func_id =3D=3D special_kfunc_lis=
t[KF_bpf_dynptr_clone] &&
>                                    (dynptr_arg_type & MEM_UNINIT)) {
>                                 enum bpf_dynptr_type parent_type =3D meta=
->initialized_dynptr.type;
> @@ -14003,7 +14016,15 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>          * PTR_TO_BTF_ID in bpf_kfunc_arg_meta, do the release now.
>          */
>         if (meta.release_regno) {
> -               err =3D release_reference(env, regs[meta.release_regno].r=
ef_obj_id);
> +               struct bpf_reg_state *reg =3D &regs[meta.release_regno];
> +
> +               if (meta.initialized_dynptr.ref_obj_id) {
> +                       err =3D unmark_stack_slots_dynptr(env, reg);
> +                       if (err)
> +                               return err;
> +               } else {
> +                       err =3D release_reference(env, reg->ref_obj_id);
> +               }

um... error handling is asymmetrical for no good reason. Move below if
(err) verbose inside the else branch above, as it's
release_reference-specific?


>                 if (err) {
>                         verbose(env, "kfunc %s#%d reference has not been =
acquired before\n",
>                                 func_name, meta.func_id);
> --
> 2.51.0
>

