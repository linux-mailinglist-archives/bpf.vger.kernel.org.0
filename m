Return-Path: <bpf+bounces-47997-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78771A03025
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 20:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F2D73A4C61
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 19:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3848413775E;
	Mon,  6 Jan 2025 19:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3Eacng5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12ACEFBF6
	for <bpf@vger.kernel.org>; Mon,  6 Jan 2025 19:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736190496; cv=none; b=F7N6qhNG3shk+UB3AU969iemBL6ibk+OCE6p4VQzt81m5yGKFRN7Ly+LDsNcchTW1PeqbcLZXAVbTYbPNSK8q58QY74SPzlQnr3bW38lh0bjuKFnVQhktB/YmgZ1Y0v3EgSGYVP+isIX7M/LXvSsgk2VjnzDeM459eLJB3afkFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736190496; c=relaxed/simple;
	bh=NmwggQ84UwHOrKdDlF/Fb5HgLYWScGSxh2iyNKrIY80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b+K+Afr055O3nokrPC+yiO32jRCcIuJkKEDstHhOLEJkpabxFXIWo9HwEF0pAmjIyxiqTNc16t6Fxz2jKQpwZGQGQ9jFmc+G1b+w+ijGOK0DGE2lc1Xvksad7aDF8VaBehl7lhy7JxsdP2db2IfDG4QFhn4RZLI9EqS2ym0yzDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3Eacng5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4362f61757fso146484975e9.2
        for <bpf@vger.kernel.org>; Mon, 06 Jan 2025 11:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736190493; x=1736795293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h99wRYveKWQPb68pToStX/w8H0QWO52x44JcW6YI/7U=;
        b=P3Eacng5A0yDbyo8yCDNJWPirgAKTdF07kGniQ8mUY3WEbeL2s4foRhoWuBf6jCZg6
         9uy1Hd/xoL13fezXcnq85diuQeHMdw8VHzj8wmHQgz5QiQwpVGg815fY6Q1o5Zt2xiMs
         SNFP7cAnFJWLqH2newNXIjFeEzfTM7liWxFm7dcnm4dgapuOeCBkBRo0sMOYkicyreP0
         8ehsNd71e2D6JEgIaGnlTE9I5jwn7hO88cL4dJ3VWanV+TfxKqyemLvrH+VPpIqSSmfa
         iVDcs3mDZDPqHQNt6g/HXj9DStMEh5VBbyKFOYpYH9OTLmjQSOgANKGkaFmEjLmgBU8a
         9DdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736190493; x=1736795293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h99wRYveKWQPb68pToStX/w8H0QWO52x44JcW6YI/7U=;
        b=niaEJM7x8YYMKL2M+q3uDh6eDLR9Aj8QN8YlbldbjZ3ir0ig3rxcwExK1xr6Bi3Y/s
         EVA5lrn4XL9Qn+/g5jbFIqkjNHtR37kr/Vt9WDgXtT+BIa+2c4JiERtq2iNcoB31CMG4
         2e+7nuHOmPLgjRjeb2Y9eH/wNt0a9PdhVdMnvmLMjYDl1U8Q/bb+V7EOv4+fctKqgEfB
         FRnXTQ2rCSLcikh7yAIoZfFu/G423uhNNx1rs3OqcBVXw3Gd4NmSkZFrRfCaR4Lqnspd
         zqiXeYzQG18BxqDcyAOmGc2RrzO3UQ8S2Vqztr9JGV9DUBOW9y8NW0ZdDTlvDMcHUbHS
         GlcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdDPS2iHuOsPjTWmZ5Qp1LqGPLDoPFGpqLZPYoj4Xlg0kfSWEH3nyXpkqaokIljDm4TII=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1PKTEarA1O8KUi5bFt7U0TZnA6DkhXf11cygJxY3X38F0QBxF
	+7ik4werU//Fy2Qq/A539btB5ko/6axmFI4rA1lrDlvgTEtMP0CeBKs700sUvI3IWGz6y6AFbXJ
	MQrmNkICzTkk/tMJqk95mDqCy1fw=
X-Gm-Gg: ASbGncsFwjPFuP8zA/n8SzhtDlW3k/RoanWhlo7BBUe6L4ucyMxwRrgC7ONQKAQAGNL
	f20vmtCFsWZ2A/HmeQRIVwT8pRv4zXw9voiE8Vaw6
X-Google-Smtp-Source: AGHT+IEAa8YIqCbEHgXxz/THuVEm22BcIzKi77Jj01kO6MeSWDAcQRpHPvjcgcOJuRntfVarTYXdTWalp8KaNhHOkoY=
X-Received: by 2002:a5d:5e09:0:b0:386:3e3c:efd with SMTP id
 ffacd0b85a97d-38a223ffb0dmr63005412f8f.44.1736190493290; Mon, 06 Jan 2025
 11:08:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106185447.951609-1-ihor.solodrai@pm.me> <4b01f799f25062513fcdb5b64c5d791247b1ee48.camel@gmail.com>
In-Reply-To: <4b01f799f25062513fcdb5b64c5d791247b1ee48.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 6 Jan 2025 11:08:02 -0800
X-Gm-Features: AbW1kvYokk3wd1E9yM-Rftq8se-wkFAmpIEtLVgfVqyFUxHKhC3nZO30xMLic1s
Message-ID: <CAADnVQJbNHY4nXQCac+w-tcTOM7q+s77pp4a3dSZv1LE2D96Hw@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/bpf: workarounds for GCC BPF build
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Ihor Solodrai <ihor.solodrai@pm.me>, bpf <bpf@vger.kernel.org>, 
	"Jose E. Marchesi" <jose.marchesi@oracle.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Mykola Lysenko <mykolal@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 10:59=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2025-01-06 at 18:54 +0000, Ihor Solodrai wrote:
> > Various compilation errors happen when BPF programs in selftests/bpf
> > are built with GCC BPF. For more details see the discussion at [1].
> >
> > The changes only affect test_progs-bpf_gcc, which is built only if
> > BPF_GCC is set:
> >   * Pass -std=3Dgnu17 to gcc in order to avoid errors on bool types
> >     declarations in vmlinux.h
> >   * Pass -fno-strict-aliasing for tests that trigger uninitialized
> >     variable warning on BPF_RAW_INSNS [2]
> >
> > [1] https://lore.kernel.org/bpf/EYcXjcKDCJY7Yb0GGtAAb7nLKPEvrgWdvWpuNzX=
m2qi6rYMZDixKv5KwfVVMBq17V55xyC-A1wIjrqG3aw-Imqudo9q9X7D7nLU2gWgbN0w=3D@pm.=
me/
> > [2] https://lore.kernel.org/bpf/87pll3c8bt.fsf@oracle.com/
> >
> > CC: Jose E. Marchesi <jose.marchesi@oracle.com>
> > Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
> >
> > ---
> >
> > v1: https://lore.kernel.org/bpf/20250104001751.1869849-1-ihor.solodrai@=
pm.me/
> >
> >  tools/testing/selftests/bpf/Makefile | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selft=
ests/bpf/Makefile
> > index eb4d21651aa7..b043791fe6db 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -69,6 +69,10 @@ progs/timer_crash.c-CFLAGS :=3D -fno-strict-aliasing
> >  progs/test_global_func9.c-CFLAGS :=3D -fno-strict-aliasing
> >  progs/verifier_nocsr.c-CFLAGS :=3D -fno-strict-aliasing
> >
> > +# Uninitialized variable warning on BPF_RAW_INSN
> > +progs/verifier_bpf_fastcall.c-CFLAGS :=3D -fno-strict-aliasing
> > +progs/verifier_search_pruning.c-CFLAGS :=3D -fno-strict-aliasing
>
> Specifying -fno-strict-aliasing for a sub-set of tests is not convenient,
> as this list would have to be extended each time __imm_insn macro is used=
.
> Either this flag should be used for test_progs compilation as a whole,
> or the macro should be updated to use union as it was suggested previousl=
y.
> Personally, I don't like the aliasing rules and would prefer -fno-strict-=
aliasing,
> but changing macro is a simple and non-intrusive update, so I think it's =
a better option.

The whole kernel is compiled with -fno-strict-aliasing,
so I would do the same for bpf selftests and remove per-.c flags.

