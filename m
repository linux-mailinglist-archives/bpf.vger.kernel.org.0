Return-Path: <bpf+bounces-68876-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B96B87917
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 03:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208653A6FFF
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 01:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEF41C860F;
	Fri, 19 Sep 2025 01:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLB1IXS5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB3C139D
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 01:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758243826; cv=none; b=P8IyEaWAYszZ3glxePHXnTiQh1FoWvBUg9I/RtmAtHKvy+99PQmRbmBcgFzTcWOBvwA3JNCnHS/drs4kdBNxVENDP/arU7AU8EBntbooX5+7tQYn+kk5AWvK5YxROwhtt3L3/3OgJXbHpZudSuHygeZNQDvlOr0zKLXrWK7ETTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758243826; c=relaxed/simple;
	bh=WJfvvn2usuMa6X+s8hugGEziFUpQMUhmWrts1D7e2GE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OhhpkvqK9C5Cb5FEP+Itv+q7qm0t9YFOgRdqMMDbjG+tky2DOD1Fi8vNCmKLxhO7ld0OF7mOnCD9moHF60rXEoR4KBRf7NMZ2z5vGa1pE4Bfs8h1gx301sQUeu5a4uc1+PJl+Xy6rkqOb7TQLCyYH6/uM3io5RwGbphRvjHitUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lLB1IXS5; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45f29dd8490so13860175e9.1
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 18:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758243823; x=1758848623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2c4gfa1k32FmgkNnZFQ698WIJ7U2GnJnhZizIW8O44=;
        b=lLB1IXS5PPjNR6IzwWA2sQfspUXCONmU4/2ul6O9T/medo44UN8HuNTOPxLeWKE904
         mHJaaorzWBMgY13t7rt+2t3LbUpCOmM2E5fAg09Tyl4WJpHhBUgP+3r/VF8YhA/tNH4n
         s4iA98PesJOpwxcNXa26Zc2at+LfX6rE3Ppgsgj5dGyJDi6olBkpGHJbyzWSjAwM0BPp
         vMhxUz7Kam6QaSncHqUgQopkYy4CmyEEyb0YHe1UWDbH5ErkrtgYU2e/tyS91yNXjkHc
         xqioe7pRhko7HDikVlSA5QMhUwExYxgiKNnz3Gzyx+cxYpW/x4lDkUBrYChNdy84Fbxv
         N1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758243823; x=1758848623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b2c4gfa1k32FmgkNnZFQ698WIJ7U2GnJnhZizIW8O44=;
        b=PDXmFsXdpYw+vvY5sjpiZika/zG3MsG/HyAZD2617PvdBtlmI0AqUyC5TBXlYb0sIz
         uIMFwc78tmfDOYjHbCNrN9H0GgFwt4t5coybOlRG4P4VdExoGSwE8IRmdROO3BNOFIpr
         sgpzSDfCvc6ebF5f25VSQUtrxHeSk6tSGszFsxHSFm3IcpMpejjumIPgcDuRxhuXDtiH
         QeuKVA5G6s/gdVQWp14qmyWxXhOpK+H8rpoZFDA4NUmOISTXXylkHQu8VdCENNUXmJX2
         pFSwialLD0RAqafe41Ax9gLWAgezLv/qWl+zswJn53UN+B+Z/gB+i0++NW6hVczb+4Vn
         3fMw==
X-Gm-Message-State: AOJu0YyxSGDaQYjGylG+0stBvLTwt8oy41j5CHirao+3AMxcZQaI8rZn
	JEDPWoWpxXY88VkKnqKd+44YMCIISme9vAsSOJFYDNiE1w1naq/j8uthTjluWoatsxbHf5vWtK4
	2DwihThl5XlDIT2ifHEj+LImXAiKHvS0=
X-Gm-Gg: ASbGncuVL/nBadS/34l5dpUN6q1qkv/HbotzZkLg+e8kqDDs6qBaCCSCQmG6Yt8ULlD
	gz8Z6nv9uiBeDLbjWd+VxwWh187oXo9DWIjyL+l75D5a9y04NtifBBsnfK9NZhmBRsO9oPDTmlB
	w6kE3zwUzMPATHYSMevSixEfTvUtZhBpVD84F5uQ+mE78wea+HGOeRrBzhhYyplupBk69MHD31b
	icKLJIFWuuakw+aAyEO6qMwMosmqlkWOPJZg6oYz355/F6WNX0Ipjg=
X-Google-Smtp-Source: AGHT+IGPT55b3Atg5sjh3eSbExk3yzXAPnzFJVaJHiUkwDfdLLd85oNkOMMu3CByeGInE8FL7eJyf/w2osZbgil/P9w=
X-Received: by 2002:a05:6000:2404:b0:3d5:d5ea:38d5 with SMTP id
 ffacd0b85a97d-3ee7e10616fmr830546f8f.25.1758243822593; Thu, 18 Sep 2025
 18:03:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918-callchain-sensitive-liveness-v2-0-214ed2653eee@gmail.com>
 <20250918-callchain-sensitive-liveness-v2-10-214ed2653eee@gmail.com>
In-Reply-To: <20250918-callchain-sensitive-liveness-v2-10-214ed2653eee@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 18 Sep 2025 18:03:31 -0700
X-Gm-Features: AS18NWCmk_tXMA2tzPiiv78u4vXHWL8GKDc-tIIyJYU78nAQErlT1bzdMgp3Go4
Message-ID: <CAADnVQKQVqTJeZ5zNLLPN6zDHQzxsrJGBqFBUnWXAnyu4szDLA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 10/12] bpf: table based bpf_insn_successors()
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 11:48=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> +inline int bpf_insn_successors(struct bpf_prog *prog, u32 idx, u32 succ[=
2])
> +{
> +       static const struct opcode_info {
> +               bool can_jump;
> +               bool can_fallthrough;
> +       } opcode_info_tbl[256] =3D {
> +               [0 ... 255] =3D {.can_jump =3D false, .can_fallthrough =
=3D true},
> +       #define _J(code, ...) \
> +               [BPF_JMP   | code] =3D __VA_ARGS__, \
> +               [BPF_JMP32 | code] =3D __VA_ARGS__
> +
> +               _J(BPF_EXIT,  {.can_jump =3D false, .can_fallthrough =3D =
false}),
> +               _J(BPF_JA,    {.can_jump =3D true,  .can_fallthrough =3D =
false}),
> +               _J(BPF_JEQ,   {.can_jump =3D true,  .can_fallthrough =3D =
true}),
> +               _J(BPF_JNE,   {.can_jump =3D true,  .can_fallthrough =3D =
true}),
> +               _J(BPF_JLT,   {.can_jump =3D true,  .can_fallthrough =3D =
true}),
> +               _J(BPF_JLE,   {.can_jump =3D true,  .can_fallthrough =3D =
true}),
> +               _J(BPF_JGT,   {.can_jump =3D true,  .can_fallthrough =3D =
true}),
> +               _J(BPF_JGE,   {.can_jump =3D true,  .can_fallthrough =3D =
true}),
> +               _J(BPF_JSGT,  {.can_jump =3D true,  .can_fallthrough =3D =
true}),
> +               _J(BPF_JSGE,  {.can_jump =3D true,  .can_fallthrough =3D =
true}),
> +               _J(BPF_JSLT,  {.can_jump =3D true,  .can_fallthrough =3D =
true}),
> +               _J(BPF_JSLE,  {.can_jump =3D true,  .can_fallthrough =3D =
true}),
> +               _J(BPF_JCOND, {.can_jump =3D true,  .can_fallthrough =3D =
true}),
> +               _J(BPF_JSET,  {.can_jump =3D true,  .can_fallthrough =3D =
true}),
> +       #undef _J
> +       };

Don't understand why, but 32-bit build and clang build with W=3D1
print a bunch of warnings here.
Please fix or add __diag_ignore_all("-Woverride-init

