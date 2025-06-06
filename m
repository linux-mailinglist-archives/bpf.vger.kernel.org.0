Return-Path: <bpf+bounces-59841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0340AACFC64
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 08:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFA2C175440
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 06:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C191E412A;
	Fri,  6 Jun 2025 06:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jaP5yzMw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048101E1A3B
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 06:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749190103; cv=none; b=YOoFb4C7ChZYSDkWHXVBrELg7DUbMB/82omD35yWox0KDGGWhtSzhKWmK9uRM97CJebG3sOO2JEc5RXJeVzhhwfdQhhiVmKk2w52E7DxEgmPgW9Kd1DIHK4z3SOBZNeHupI8/jKTTv6aEm1EzgvJKtijzVx2QB6SjnFOahwpLdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749190103; c=relaxed/simple;
	bh=0bQVlQAkZiktNGRrwzVnwFpZbIiq3nNzG/ksOecik/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hW425l5heJsMNeqzhRCI7bUTnJN+Vos8WhLo+BEeefVh5cWqB1okEARfK3sZiVv7eey0uG2jp9RrlaaLNi5nck3z1p2nB9vFFzSF4uPHSzMAGLqUs+05UHQXWYwu5DAzqUDySir148mL9g+JC8JiKSzwq9UXarcInlltYWqKnjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jaP5yzMw; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4a3db0666f2so37470511cf.1
        for <bpf@vger.kernel.org>; Thu, 05 Jun 2025 23:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749190101; x=1749794901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKvStmYDfkAOPdQAkmQVzm7vE8Ux/xTu/Lq8EZxk5pg=;
        b=jaP5yzMwsdqxvLfHrGOMnelVMDp/VcUaAyRpHNipSFt3sowjhpFQV5MnlIVze+lyx5
         v3g7tI6ZorPkEUgl7ioy9l/Cucy55UmiHF8QlbIw0zegtaody6MTlidhYLWLlFKTNS0o
         pevIVG76bKpj/b0UBFy7ZKP8SkRo/E+kKulyupxV13ZV/rzN1CO6WT6dwiCWq3sVAwrB
         qBdqvkvjuPQGKjqCJldVA9j/XHgVgPPPxwB66E2kd2YWmA1p2HZ+3DQ/AbDUoRLfN6tR
         NlU0h6uIishE7QXqz3FX42ZTfm/BkHXm6yWTPj0Mq3pJHemEgU8UGpFJiaiZBZJeblee
         qvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749190101; x=1749794901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kKvStmYDfkAOPdQAkmQVzm7vE8Ux/xTu/Lq8EZxk5pg=;
        b=GtyMAbHKrP9MHKGCK1/wLRyPfRLNbLo+LYIBKr8pPY1hXZnqyW8BRPe5zyVL4V2FIQ
         T14XNeX4BwrUR4zSa8nIow9hTD4PTcNFigS84aCE8Wl+rXKod1x80GewvWYyj+YsX7rd
         0ozm8ei4kTw0BL5YinyXBf9aMOGza1SwzjoN7iGCZdSAbBub8IC1nk3boMYd6cRtKk6s
         2hs1iOj1rG930QdI2E2qjM/TBTdP8/AO/205BMfHRFHiG7WHJYA8izEfJF51iKnKxGjD
         U7nTFlpvNsvQ7kLz/b3q6xNAOnkmPfsRNbqTycVg14JUqBSO07egVCo2VGQ3VXXiUr8R
         s8UQ==
X-Forwarded-Encrypted: i=1; AJvYcCWq1OyQn2Gel+eXYwx8w56YYOON2D2iYQaIblfOJiB4AK2rCsYz0bF2ut03TfykvjMQbuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrFzq9bHEOlZTJtFSqXOD48QR3nXKQ/BAzs/tTug91GJJK62sw
	ty/mpEgS6qfCMVWw9n/YLOPExbGFxlJaozSFaxVVhVJhm5Ni8RcbPAYgBrZeo4IohM+Z1xC45dz
	5HlBsZXF+uBmP55dvDhVtoDlV5MYe4ADvKMsZ9mNP
X-Gm-Gg: ASbGncsKbWmsZeBoAQlMPD+YS8ZflsjLwA6cAKlHxlg9u44yKMxje6xAV63yPiXDWGh
	xWYtCYSu9eA4WYJQnWrEUz49bOHOENZ/S21E0qdjlbV7ACNBICovhU4PbkubpAuMdy5WMiOCQQc
	Uw9ttwx7rmDGvlysGiRoKVqo0koj2WNCNPFNpxBT3MyczFV/JPH625clrFb/7YGpAN8/SE5nGv
X-Google-Smtp-Source: AGHT+IFNLf8kiaoxiVhlcZHxWQipk57Pwx1NjDf59/NaBKuvZ9xKQtErzz+1d8bwORt3x1wf4IaR5TD3NK/vee4duoU=
X-Received: by 2002:ac8:6f08:0:b0:4a1:511a:b99f with SMTP id
 d75a77b69052e-4a5b9a00f7fmr43119931cf.3.1749190100655; Thu, 05 Jun 2025
 23:08:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606052301.810338-1-suleiman@google.com> <20250606053650.863215-1-suleiman@google.com>
 <2025060650-detached-boozy-8716@gregkh>
In-Reply-To: <2025060650-detached-boozy-8716@gregkh>
From: Suleiman Souhlal <suleiman@google.com>
Date: Fri, 6 Jun 2025 15:08:09 +0900
X-Gm-Features: AX0GCFsRvL-wnGhd79Wc0undNc8c43NKvrHNdqcadxOFKESr_qPXBVorv1nNUwA
Message-ID: <CABCjUKA-ghX8MHPai5mfC4dZgS8pxi3LAvh3Wnm0VCt4QmU2Hw@mail.gmail.com>
Subject: Re: [RESEND][PATCH] tools/resolve_btfids: Fix build when cross
 compiling kernel with clang.
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Ian Rogers <irogers@google.com>, 
	ssouhlal@freebsd.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 3:05=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Fri, Jun 06, 2025 at 02:36:50PM +0900, Suleiman Souhlal wrote:
> > When cross compiling the kernel with clang, we need to override
> > CLANG_CROSS_FLAGS when preparing the step libraries for
> > resolve_btfids.
> >
> > Prior to commit d1d096312176 ("tools: fix annoying "mkdir -p ..." logs
> > when building tools in parallel"), MAKEFLAGS would have been set to a
> > value that wouldn't set a value for CLANG_CROSS_FLAGS, hiding the
> > fact that we weren't properly overriding it.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 56a2df7615fa ("tools/resolve_btfids: Compile resolve_btfids as h=
ost program")
> > Signed-off-by: Suleiman Souhlal <suleiman@google.com>
> > ---
> >  tools/bpf/resolve_btfids/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> You forgot to say why this is a resend :(

I wasn't sure how to say it. It didn't occur to me that I could have
replied to it with the reason.

It was because I had "Signed-of-by:" instead of "Signed-off-by:".

-- Suleiman

