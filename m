Return-Path: <bpf+bounces-70264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC4FBB5A73
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 02:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 78D0A4E69E5
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 00:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338AD23CB;
	Fri,  3 Oct 2025 00:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVJdcnPD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D650A48
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 00:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759450014; cv=none; b=cKYy0YduH46dbFEFyny8umBhXX39Y0OSjuQ2SJe7d7tBMWXfFM5ktLBRs73l4W790O15nt3oXuava/CqmDazLbOj2WDX7HSSQ0evhgQFwMaFulVKalxuwKq9UckqE/w2ejJC50QuLRS4r1zlppEv9kJC2eTkbPEHUmaFvljJU1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759450014; c=relaxed/simple;
	bh=sVQ8NBoOgQlRfKdO/qHjufcz5+GcyX8r4WQTPF+zKuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bVZi01TlZ6q2QYciJGdOh3+tfnl66p9DFHKr12hOmPYbQJyLbRwam5ya69mDXg1GTRdBtVqMDqjXW/2PkKHznUGbmv/Ql+SaX3DR1wAxpHFM9HXSn+7EaEgyWyhJq0uppEdMorK94QcRzCAeGyptHQWBjn9Z3vdFMzWpxG39qTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVJdcnPD; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e491a5b96so10141375e9.2
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 17:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759450011; x=1760054811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tObBeJz1IHsGs3a2wPnhO5JRG3NZYFahZ+SzXb0BLFw=;
        b=aVJdcnPDFulmhHCGpsEyhwuTS+9ysNWah2cIOFp0djzLR2fjGlrRAabriiCqeoD3RS
         ivqAkeQKObQ5qetxmipGY7Y78FaS0vpulvKNPbL9KqEw5Jkqi+bLwGlt27WAffc69vEz
         kV15xo/1SJnBerc1zsp5/6yVwCj1zwwmNNtgAnvzt7vG2Unqc0VMuoX8NjTHBDaC/TsX
         KqG8fKHvBCZO68KY/O9KXK35WCzTyUmrj0okbVRfIbPrVsUkg488bfvQnP5QvotwVzcZ
         UPXESGMa/0ahE14J2sEG918Z42CCxAaKRimkVBpcEox1dm9ogm4qBLG9N7YxDB4nc7d3
         wHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759450011; x=1760054811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tObBeJz1IHsGs3a2wPnhO5JRG3NZYFahZ+SzXb0BLFw=;
        b=s0RK1I25vTTuBaLXs6X0/FWKyWddgkBq1KrJJHmQMgZqensWf0DUubGwXopjI7/FBx
         ITOoBs/d09Z+1T0xNG98En6BG686ha8HqNbeApSP9HsshtA2+LgjDksopaxZFyut1eEJ
         MoHMuJFmCU1DOzbm9pS1THWdlek3/J9JuanLd9uqjDCk5SVKxSnd9IHxoxO+H6q8mNxJ
         JYVoVM+3MUdfg7duBbNjUuouGNMF9aHP6X+YD6fWz3zpD6Mwu5gxX7DNNI7nCBG4j/mk
         qsZqDcWmEvOI/5+6CjCg60/oXWGopurUDHek80C7HSffjKXAfpDSqkPPLg5DTRPu8HIj
         5H1Q==
X-Gm-Message-State: AOJu0YwTSIbi2dH6xiF+DBdC8iG+wmRV1FfW0zggMZE8g6NUIVKlhIAE
	tXvOjy97XfvCDVPI98FBLU03TlctSJAv2Nq9JBm6184SvTi52d1cJJfUKjNScSzf+O93bjq7RVQ
	R4mGQGAIexB2IHSGJcJyJJ6gwFSRSEho=
X-Gm-Gg: ASbGncsTXxc8CuvssCth28MA1tGUgfhQYBS4c8AAhc/fKXquPpAkuZTERHsyy8LzYqi
	ek92lsLrI8r+Otu85MKFzFiKh3QYfFfMIx4Whbv9cbpoDfKd5+iAvsCAdur2PiWuNjLA8Og9V9A
	gWKw6m9TaIDoToLmQv9WmEJ6m/1db+BM4II9739F9OlODTChGF7wchuVx9d7ZbzAquMgjfTduQk
	Ij7G4AKkCCEfpmJooAIo9j2Yui66Z2+TtfuwM/Yy7RLBOWdlN6iHDnNJbGq
X-Google-Smtp-Source: AGHT+IEOKzi9gcz/oOTKJiLsk1ST6g1sT9kbQ6fYTRMpHxpS1iOsP6z5SNkeCAXdju7nGjkpvQ6b+mP9/U1sDi7R9sM=
X-Received: by 2002:a05:6000:4305:b0:3eb:f3de:1a87 with SMTP id
 ffacd0b85a97d-425671c2042mr698882f8f.56.1759450011475; Thu, 02 Oct 2025
 17:06:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002154841.99348-1-leon.hwang@linux.dev> <20251002154841.99348-8-leon.hwang@linux.dev>
In-Reply-To: <20251002154841.99348-8-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 2 Oct 2025 17:06:40 -0700
X-Gm-Features: AS18NWC88A6iYodvxV9CyxGEFrGa5ztVWECTh-xocF3PBKCqeN0Qf_BVdTZtD8U
Message-ID: <CAADnVQLY9iEkWXKqS+DLn7jNU5weoqOsoSVRPiuS2pv8MgbRJg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v3 07/10] bpf: Add warnings for internal bugs
 in map_create
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 8:49=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
> In next commit, it will report users the reason of -EINVAL in
> map_create.
>
> However, as for the check of '!ops' and '!ops->map_mem_usage', it
> shouldn't report the reason as they would be internal bugs.
>
> Instead, add WARN_ON_ONCE to them. Then, it is able to check dmesg to get
> the error details.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  kernel/bpf/syscall.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index fc1b5c8c5e82f..49db250a2f5da 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1406,7 +1406,7 @@ static int map_create(union bpf_attr *attr, bpfptr_=
t uattr)
>                 return -EINVAL;
>         map_type =3D array_index_nospec(map_type, ARRAY_SIZE(bpf_map_type=
s));
>         ops =3D bpf_map_types[map_type];
> -       if (!ops)
> +       if (WARN_ON_ONCE(!ops))
>                 return -EINVAL;

It was a strong recommendation for a long time to avoid WARN*() at all cost=
.
In the verifier we removed majority of them and replaced with verifier_bug(=
)
which WARNS only when DEBUG_KERNEL.

Here there is no reason to warn at all. Keep it as-is.

