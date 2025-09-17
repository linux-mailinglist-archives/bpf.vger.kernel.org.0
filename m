Return-Path: <bpf+bounces-68683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C131B8150D
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 20:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45B863B48DB
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 18:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CF02FF663;
	Wed, 17 Sep 2025 18:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OssPrcXN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0324225A3D
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 18:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758132818; cv=none; b=SdYECdsHASN5uJONI5RUB0hCKhxHdGDJNLBXlBAy1Wc4QZsWkm95SD1y7fWcGCY8At969g+zJulqw4gV/uokEeQkUJwUGFTZRF+6QnJ7zCpmg4Wnp3btjexeN67h/ejuwBJcdTpjaZdPLp2mSHHToZaWsGQIHp+MaC0KVBj4H1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758132818; c=relaxed/simple;
	bh=DC9iYbgmzpTp93j246BZcn+S1U80M/PFOyehHY2xvV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=esMPcWw3qJHNWwQOOIATag/eoRXuH4cZM0FB8BFKYkEVDUPDzqJmBUmoDCpj8gKXpI6UQCZcLBG3OCCcYvkoyzAhEBqJ/1YzDl05y+HORi2zY849wu2qguTqIMHb6FYDFimvmnWpzyq9vwiLibkzWLgB6ggg3TeAV3fthr4sGiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OssPrcXN; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45decc9e83eso871045e9.3
        for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 11:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758132815; x=1758737615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmNcOrp8Wk7G4IjmKZU+dvVsAAJ4/BhJ91AycL3mee0=;
        b=OssPrcXNL08wLMt3Ciol8Y/QjB1efVXu/Z0yUq4aeqtJpLZTEFtlEtxiZlf0QY0ykr
         Bepe/0tvbbCdM14b94f5351QPu9CaF+kXyl3q/LJtUx9vSwa3d7cnupGe8zz7zExPy/E
         qzyX2gMpu7Ek60fel+wU5NLMgraPx8phlUwB30sgTQYzVumVGaUw0Dlu7e98WSYw9fjc
         IWQvTQn1X5/kmguaTfJou4LW6l45x47CYT3RIC3XTQ5mRcUaVh89ZZeQbqwwn8XtXXvi
         7FgWzkpYArjjBe4tkeoaXyblditjuiieC4yS/wLJ9ePw1+NMHNobUlyJTCeqm0nVciw0
         lnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758132815; x=1758737615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fmNcOrp8Wk7G4IjmKZU+dvVsAAJ4/BhJ91AycL3mee0=;
        b=Mo716Vw7/6ySvscQ+yekL/CGuUaeFTYkNXGPbf1MsC9uBYlFeWqalYzYVn+5gXVYSP
         +qN9btn/bI6/tjt+VxUG3xk7lOdd5G2furqH0qS1lEGuH0qnwa4HurA3sSGbqK2OX+zH
         6iEb+ct/A0xgAxUpkJCVygLbG5ECU/X4uPpTqAo6Y0W57Gx89rq1lskS62vQER89wA4Q
         Q0+MPRG7QPulAYB2FPmBPKrVxPwm/QlrwxEkRO14FJznL+AVyg5dNDeQ7g9BMtX32Jb0
         iLaG+LnHzgb2Htu8J2bqOinkINQBmVBgbuErHhdnqYsgta5/Q0vOxeY6n9/61ChFxvQG
         2EYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyi50/EhgRNvI1F5pMbqJL/UH+/gJ5yskKtNIIcbNpvILJNdlZRWS/Ulo4PN66PcFpq5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWJvr+SOIWtuqvkfPtNuFprsu1iEd9cmBgTtHtmbgiVz7ZzuDx
	UctBK9j8SXk/UA5tyZjE/eOjEUHeDrbJI370igFwwvV8zdi7+kQaDkTCvC5LyV1KNGfqTOWRj6R
	tmfDX8Z+bHDilKPy6CWRY1AZ3TWkpIU4=
X-Gm-Gg: ASbGncv9yi1W8onw/RK9+ReQFxl/HPGXw2PQ65sGRqbta7h4JhAkat1QbUER5Hsrzx2
	zf/EsuwImmV57VGEVeZbdpDEtLbGTPTv67lYYRofRThqiAJ+AQ6qHy3YXkErK0Y++DY9eERxmmE
	mj4M4XLB2yIBKOclHj9tb5QbUMerLN/SLNGyf5ZSUQxD33xOXAf9JZQ2KE7aUlJD1cMAvUdkDfE
	1rXG5QRvAipKgLVJLjNTJrhOTY4nwOo2pAPdaJ2zKdcClQ=
X-Google-Smtp-Source: AGHT+IH1gxu5scRmCV0vkGIIWKnuYwluj+gx00I+JRnZKqh3hsxWlhOVQcAvNeqW6vCiZlKwzruAAOHB/0NJ2TZaXb0=
X-Received: by 2002:a05:600c:45d1:b0:45d:d50e:20be with SMTP id
 5b1f17b1804b1-46206842cfamr23228285e9.26.1758132814960; Wed, 17 Sep 2025
 11:13:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916155211.61083-1-leon.hwang@linux.dev> <20250916155211.61083-2-leon.hwang@linux.dev>
 <CAMB2axM2o+tr0hUJYWgPRO7sGg5rE5RSa_tW_sHY_oegi1_bbg@mail.gmail.com> <DCV2ZG5KIFEO.R8HEGONFWBLP@linux.dev>
In-Reply-To: <DCV2ZG5KIFEO.R8HEGONFWBLP@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 17 Sep 2025 11:13:23 -0700
X-Gm-Features: AS18NWCC6eb9rFOt7Qzjyr5dQJbd0JWWY07ZAbmLImPsxnT_Wz_7hB_Ptu1t7Qg
Message-ID: <CAADnVQ+bAvzjbB+u-_skndu8bNKFUzrNZT7erc-nmayOyEN5+Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Allow union argument in trampoline
 based programs
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Amery Hung <ameryhung@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Mykyta Yatsenko <yatsenko@meta.com>, Puranjay Mohan <puranjay@kernel.org>, davidzalman.101@gmail.com, 
	cheick.traore@foss.st.com, Tao Chen <chen.dylane@linux.dev>, 
	mika.westerberg@linux.intel.com, Menglong Dong <menglong8.dong@gmail.com>, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 5:40=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> On Wed Sep 17, 2025 at 5:35 AM +08, Amery Hung wrote:
> > On Tue, Sep 16, 2025 at 8:52=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>
> >> Currently, functions with 'union' arguments cannot be traced with
> >> fentry/fexit:
> >>
> >> bpftrace -e 'fentry:release_pages { exit(); }' -v
> >> AST node count: 6
> >> Attaching 1 probe...
> >> ERROR: Error loading BPF program for fentry_vmlinux_release_pages_1.
> >> Kernel error log:
> >> The function release_pages arg0 type UNION is unsupported.
> >> processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0=
 peak_states 0 mark_read 0
> >>
> >> ERROR: Loading BPF object(s) failed.
> >>
> >> The type of the 'release_pages' argument is defined as:
> >>
> >> typedef union {
> >>         struct page **pages;
> >>         struct folio **folios;
> >>         struct encoded_page **encoded_pages;
> >> } release_pages_arg __attribute__ ((__transparent_union__));
> >>
> >> This patch relaxes the restriction by allowing function arguments of t=
ype
> >> 'union' to be traced in verifier.
> >>
> >> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> >> ---
> >>  include/linux/bpf.h | 3 +++
> >>  include/linux/btf.h | 5 +++++
> >>  kernel/bpf/btf.c    | 8 +++++---
> >>  3 files changed, 13 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> >> index 41f776071ff51..010ecbb798c60 100644
> >> --- a/include/linux/bpf.h
> >> +++ b/include/linux/bpf.h
> >> @@ -1119,6 +1119,9 @@ struct bpf_prog_offload {
> >>  /* The argument is signed. */
> >>  #define BTF_FMODEL_SIGNED_ARG          BIT(1)
> >>
> >> +/* The argument is a union. */
> >> +#define BTF_FMODEL_UNION_ARG           BIT(2)
> >> +
> >
> > [...]
> >
> >>  struct btf_func_model {
> >>         u8 ret_size;
> >>         u8 ret_flags;
> >> diff --git a/include/linux/btf.h b/include/linux/btf.h
> >> index 9eda6b113f9b4..255f8c6bd2438 100644
> >> --- a/include/linux/btf.h
> >> +++ b/include/linux/btf.h
> >> @@ -404,6 +404,11 @@ static inline bool btf_type_is_struct(const struc=
t btf_type *t)
> >>         return kind =3D=3D BTF_KIND_STRUCT || kind =3D=3D BTF_KIND_UNI=
ON;
> >>  }
> >>
> >> +static inline bool __btf_type_is_union(const struct btf_type *t)
> >> +{
> >> +       return BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_UNION;
> >> +}
> >> +
> >>  static inline bool __btf_type_is_struct(const struct btf_type *t)
> >>  {
> >>         return BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_STRUCT;
> >> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> >> index 64739308902f7..2a85c51412bea 100644
> >> --- a/kernel/bpf/btf.c
> >> +++ b/kernel/bpf/btf.c
> >> @@ -6762,7 +6762,7 @@ bool btf_ctx_access(int off, int size, enum bpf_=
access_type type,
> >>         /* skip modifiers */
> >>         while (btf_type_is_modifier(t))
> >>                 t =3D btf_type_by_id(btf, t->type);
> >> -       if (btf_type_is_small_int(t) || btf_is_any_enum(t) || __btf_ty=
pe_is_struct(t))
> >> +       if (btf_type_is_small_int(t) || btf_is_any_enum(t) || btf_type=
_is_struct(t))
> >>                 /* accessing a scalar */
> >>                 return true;
> >>         if (!btf_type_is_ptr(t)) {
> >> @@ -7334,7 +7334,7 @@ static int __get_type_size(struct btf *btf, u32 =
btf_id,
> >>         if (btf_type_is_ptr(t))
> >>                 /* kernel size of pointer. Not BPF's size of pointer*/
> >>                 return sizeof(void *);
> >> -       if (btf_type_is_int(t) || btf_is_any_enum(t) || __btf_type_is_=
struct(t))
> >> +       if (btf_type_is_int(t) || btf_is_any_enum(t) || btf_type_is_st=
ruct(t))
> >>                 return t->size;
> >>         return -EINVAL;
> >>  }
> >> @@ -7347,6 +7347,8 @@ static u8 __get_type_fmodel_flags(const struct b=
tf_type *t)
> >>                 flags |=3D BTF_FMODEL_STRUCT_ARG;
> >
> > Might be nit-picking but the handling of union arguments is identical
> > to struct, so maybe we don't need to introduce a new flag
> > BTF_FMODEL_UNION_ARG just for this. Changing __btf_type_is_struct() to
> > btf_type_is_struct() here should also work.
>
> Correct. It should work with such changing.
>
> However, it would be more readable to introduce the new flag as the flag
> indicates the argument is a 'union' instead of a 'struct'.

Why? How is that more readable?
Does it make a difference in calling convention?
If so, then yes they should be treated differently by JITs
that process func model, but if current JITs that support small structs
as an argument treat small union exact same way, then extra flag
is redundant and an existing flag should be renamed,
or a comment added
-/* The argument is a structure. */
+/* The argument is a structure or a union. */
 #define BTF_FMODEL_STRUCT_ARG          BIT(0)


pw-bot: cr

