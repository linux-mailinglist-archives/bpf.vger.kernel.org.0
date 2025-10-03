Return-Path: <bpf+bounces-70347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D81BBB8070
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 22:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F2BE1882204
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 20:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5E3221264;
	Fri,  3 Oct 2025 20:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S933iWS3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF08817A2E1
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 20:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759522256; cv=none; b=u/pSxdYkzwaD9bwvvxg8JASzevDkZV+k6qNPA/a1oO0P/L8/LKX6A+vFbsgiiVeoZlGHmILuBN4IeHek3GW/Z9uh6mFotSwfhRzV61KqyF5/iDJ8vjMum+La/4hhFXpcBR6+Z6nGDAMTFEuo9xC9gEFMuUwB0yVc/dl6WWw5ViQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759522256; c=relaxed/simple;
	bh=urObtDD5oH34ww8s6lXaMMX/VbZQ/LzWAl2P1pfnF88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b6Hom1Z5/1028Eg30nqqkbJvtpkNJemb9S1TvxTarQ4gPvsL25HLftrnKWw8Y1KOkBdpV6zkA6z79GG2AellBjgTWz78DXZ/qk2fhwOBuTFsNtDZ7g0cKTFgBaU5Y92wp43b/Ljqm28TRVztGRhX4NVTJgTJs1Lf2OxndUBnetk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S933iWS3; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e4f2696bdso33519355e9.0
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 13:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759522253; x=1760127053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6mkwrJIdW6D/cUTCAA5qQestljE8ufXYwuKYNfHl5E=;
        b=S933iWS31CMk8NO/h9qRRDxYDDdAQK+JQ1rhkfgHyO6+50o/N+BrLa2ZY4a3ph7s1a
         oB8JDh5qNZGt+SuYxS9qoq8c8hIZYmdR1Qt7j2zBwzR2dbMx/j2Xz/edCH0mhLXGmAjU
         9OvyIdGGXAlfFcNjRxN/dv5DNAkHYLW6MoXXI7g6CMXJYqEKOyUT9Y59IAVd+jhtAju+
         +690G4YBSLUchqBsz8c1RNdxYbJf0cR4IyH3fiM/OEYHv6jWjxULzQACdN8QVyKnGqEB
         J9GBwMLkjfYcG0j1dAFkaQvdh/cVRutaebfvzvzqcvASwozezsuM8LH6cHLPHxOCB74q
         /J6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759522253; x=1760127053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b6mkwrJIdW6D/cUTCAA5qQestljE8ufXYwuKYNfHl5E=;
        b=slkLlhXSaoNh0ipru/cbPGCe4PeK5iartOpI0s/o8gsV84xdLmvxFUVp043OVKvlMV
         lqeaXMVHpSnSKOmoHjF0JsKM2Tt1xV79LzduDe8b4STsUShIOvbCJhREE0PLU8KMqVcL
         4Zo0X1GXNoVC6LTS/MzsI0JCGcJIXzvZk8RBxYvn/z9GGW809WYybkwoNJ7fTJSQhxNw
         7ZywcN9uQE6ME+0fIlcombMvC3gLIZ/opQxGQ9bNvb9oeU5Hw8Q35c3XICYG3bvnDNlX
         7vr7GhHQCSlT2Y7vN6xqmuVaiKcLo6DUVtVP+5Xre3ikCqxz/ZN4R1gCzdea70EUHJJM
         gP9A==
X-Gm-Message-State: AOJu0YwVmWt82eykX+oXx+hy8dA1PoGSdD4dolMwlAyh6ku32PUmxR9Q
	rI6xQegqON141/LHWX8K2TeyWpAE4FwCEwJqRgH+Dm6wNC8r6Dnd8EPahYDzUKfGrXGZqcquyGZ
	lavEswAu3zo/s1shSBYqrRngCJB1KPMs=
X-Gm-Gg: ASbGncvV/CTv/0U733BXQTq21hG+fUo696tb7V6HkhFFUwWtTrTlRH1Yeytrt1TYxi/
	SMiQqbzd7UqE/PuMGKY+i2KUezbnT60kfOhNuxBi+gtFXGbaoxKpGKZVIVYvmUbcjQXu6dR3fLq
	9DK+ZSKkSim+ITdJpWkiIlQYcDQ/agX0Ml9VqDPUZkvUHIMkMWywO7y1jPK91snx8i8nC1fRuMJ
	yga/RNMTPXNX7tZegnOZ+q9PmUBHK9cTiAbdDsW/OCX1R7SmID05IBJtw==
X-Google-Smtp-Source: AGHT+IFqDuZ+vWbfoEIhaxC0rWSP/qcvvNTse4FyV6tA+cGlHyZd2dZtm/+8TV4zBQJ02wR5I6pDl2ioewubLELOmWk=
X-Received: by 2002:a05:600c:3d90:b0:46e:3d5a:d15d with SMTP id
 5b1f17b1804b1-46e7114dea1mr29139365e9.26.1759522253048; Fri, 03 Oct 2025
 13:10:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003160416.585080-1-mykyta.yatsenko5@gmail.com> <20251003160416.585080-10-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20251003160416.585080-10-mykyta.yatsenko5@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 3 Oct 2025 13:10:38 -0700
X-Gm-Features: AS18NWBc_izJinUXPM9B5glQMsco_vARhL0YCAL3URrfnMcpBXtPJLiu97zuo88
Message-ID: <CAADnVQ+o8Q3Xiq2K=UPXEqBy0snkHEhTDuhg3J1u_nnRCHk5Uw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 09/10] bpf: dispatch to sleepable file dynptr
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>
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

Let's use u8:1 bit instead of bool and combine with storage_get_func_atomic
which seems to be the same intent.

