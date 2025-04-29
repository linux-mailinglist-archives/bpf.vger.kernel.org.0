Return-Path: <bpf+bounces-56972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72271AA1AC0
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 20:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE4B83BEBE4
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 18:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7804425333E;
	Tue, 29 Apr 2025 18:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAUOHmxn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F9E1A5BBB;
	Tue, 29 Apr 2025 18:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745951733; cv=none; b=RUkLdY0Gu5EPGbg4axpr34doISFpjZoKdLrpokqgunTWcxfYkce+bxrTHJ4beULoh39pmj8K6fSwtRPi8ssdvlxdvkrTApmAxwyjx1cHcJyGAJ1dPnzSioxM71DAybSZcEIGxWMtYAP7bJRaixtaJOS3fRqQe1R16zsX5ViXGBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745951733; c=relaxed/simple;
	bh=bma2mrCBJadUfoacSwbsrwaBqpGxBRvT/IydFhfBDF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dG63pZGz464xYtAYNCp9lN6GS/XFailhExj4sQLJRh79pDMcVUdqPBNzz/9RHvOPcYZpk90RUhiCvNvDiuvhnolFR41JGcr9381TxIapiKkl/NEMJymWb9CwEjh635CF6oLdXtQdVNb/lKaw8hh6BUx8tHzcleoqy/GX6or7D6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAUOHmxn; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-73c17c770a7so8629958b3a.2;
        Tue, 29 Apr 2025 11:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745951731; x=1746556531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zv4As3VK1NwjRwOh2W9L3w8lxVIKg/fLHrcBkJn1/RI=;
        b=gAUOHmxnIIAleirYmUiLzVe9PpJgskAYdN8tMezTIzok5e+ALlYlPMKQ5/rXLpcAQ6
         Wdl78YtWqBnb5e3v4MXd0DojVFaELePwapiscq7/mDgOXQOHAQEILSEQncLYLmgNGyiP
         lrC6b7Odmw5CRFOSXiq/fIwbFpDwO4ZASBKVAiBUnOuZz6PfVKdMPQccvNSH9y6f3FoA
         xX8EJ2W6RXwFPbxZ8NEk7U8zB1yLQl7DGnXWuj7cyfgF3zUFppFBRya1c6LkZ2bPmmzv
         66obRLDDmnEEjUKSIs3NxEtU8pLfTcx2FA3KH5GG+Kph6gPU3C0+q1TgnMyUPmlXCIoE
         Z+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745951731; x=1746556531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zv4As3VK1NwjRwOh2W9L3w8lxVIKg/fLHrcBkJn1/RI=;
        b=giM88cSUeeShLfDWgy6Qm6Ig8daaCm6zMiXW99HRZPPSaYKFc7ISgvFv4qyH5At5DJ
         Id+Bp/D7ZdPHl76+n/mx6gD2l3myVWO6Z7eydrlCgyZSsNsza9bpLasx1C3MDftksfr+
         M9ZESvzpQhw21U5MKXdpGytcvPZcLvcNLev2jabbzblPjVHyZi219CIdfWzMM9saZiGC
         y7dzmwBth976huWPkepzkdD8ZZxzshxqOANHR0zlVjW8PUc4f1XiUlWiHEbpUk3tgrqj
         8BgpLNdprnos3QFGT35lrIuulNDIkXSZN4lcQMHg8qk0LJdRWqrO0tfW5bsQYtnPt1hx
         n5SA==
X-Forwarded-Encrypted: i=1; AJvYcCW0tNLYpKYvjxRx9sYAV/316hpxYC6VdBzXakhMYPzT6w4OxuYsyHjR5HukLqBtgXGFWimVUUfKvg==@vger.kernel.org, AJvYcCX7/1N1aHbnhyhEqBuG5FlEz2d3H8CKaGrrCejkEusaTtSow2E3WOyLLJ0qgYLLotsTvIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBMhyr4Mg7aFrJXGjXH8U5kHAyl7Wb3J7G5GJwD1LiX31p4VZt
	mBiLq0KcjqAOLVSHQbKzu5Jef/0e6Z/p3JaEkYrRrEwl0o5u9Rz/Yeo0EfRLWFJlrMT0Mzt8DBI
	uaTKst/26LOYryqgMelz85CMUYPU=
X-Gm-Gg: ASbGnct0m+jDWubOiwtQmFLc4Ob/XQ9HwRIe80UNY6woljbJKWu+O0OR8ekNEiUZBNA
	0PpYU+JpHlaFFWKnWKs7C30qMxaBSk4GNO5g3dVB3D4u1BcTW/EWPw/ujnavlxMIOqSzTmT0JRt
	G/BUonQU5E4BeGBFmsX0gTfGkbEhbWhXnhEd0Miw==
X-Google-Smtp-Source: AGHT+IEOrsaO42+v4rxyTr424yKySCZHUk3X1mDAqGIwhsB7jfR5GhtzDlRLZBoibBzmhGzHTbVuqvvsiTm+acz+0Is=
X-Received: by 2002:a05:6a00:22c9:b0:736:692e:129 with SMTP id
 d2e1a72fcca58-74038ac9a7cmr448552b3a.24.1745951730622; Tue, 29 Apr 2025
 11:35:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429161042.2069678-1-alan.maguire@oracle.com>
In-Reply-To: <20250429161042.2069678-1-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 29 Apr 2025 11:35:18 -0700
X-Gm-Features: ATxdqUETfTA5ncHrFLIrxXVCSDVe30vhQReAb9uVtliTQU3ONhslKuwvRcGSHuo
Message-ID: <CAEf4BzYjTaKJzE8yBe-gnh1jXhLDknxun587t3-HOM7cHF_tNw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: add identical pointer detection to btf_dedup_is_equiv()
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, ast@kernel.org, acme@kernel.org, eddyz87@gmail.com, 
	bpf@vger.kernel.org, dwarves@vger.kernel.org, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 9:10=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> Recently as a side-effect of
>
> commit ac053946f5c4 ("compiler.h: introduce TYPEOF_UNQUAL() macro")
>
> issues were observed in deduplication between modules and kernel BTF
> such that a large number of kernel types were not deduplicated so
> were found in module BTF (task_struct, bpf_prog etc).  The root cause
> appeared to be a failure to dedup struct types, specifically those
> with members that were pointers with __percpu annotations.
>
> The issue in dedup is at the point that we are deduplicating structures,
> we have not yet deduplicated reference types like pointers.  If multiple
> copies of a pointer point at the same (deduplicated) integer as in this
> case, we do not see them as identical.  Special handling already exists
> to deal with structures and arrays, so add pointer handling here too.
>
> Reported-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/btf.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 24fc71ce5631..eea7fc10d19c 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -4396,6 +4396,19 @@ static bool btf_dedup_identical_structs(struct btf=
_dedup *d, __u32 id1, __u32 id
>         return true;
>  }
>
> +static bool btf_dedup_identical_ptrs(struct btf_dedup *d, __u32 id1,
> +__u32 id2)

fixed up this unintended line wrap, applied to bpf-next, and I've
already synced all the pending libbpf changes to Github ([0]). Alan,
feel free to pull all that into pahole master, so it propagates to BPF
CI (and we can start testing GCC 14)

  [0] https://github.com/libbpf/libbpf/pull/899

> +{
> +       struct btf_type *t1, *t2;
> +
> +       t1 =3D btf_type_by_id(d->btf, id1);
> +       t2 =3D btf_type_by_id(d->btf, id2);
> +
> +       if (!btf_is_ptr(t1) || !btf_is_ptr(t2))
> +               return false;
> +       return t1->type =3D=3D t2->type;
> +}
> +
>  /*
>   * Check equivalence of BTF type graph formed by candidate struct/union =
(we'll
>   * call it "candidate graph" in this description for brevity) to a type =
graph
> @@ -4528,6 +4541,9 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, =
__u32 cand_id,
>                  */
>                 if (btf_dedup_identical_structs(d, hypot_type_id, cand_id=
))
>                         return 1;
> +               /* A similar case is again observed for PTRs. */
> +               if (btf_dedup_identical_ptrs(d, hypot_type_id, cand_id))
> +                       return 1;
>                 return 0;
>         }
>
> --
> 2.43.5
>

