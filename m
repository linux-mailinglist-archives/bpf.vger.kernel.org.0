Return-Path: <bpf+bounces-61778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB45FAEC21F
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 23:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 585747AD71D
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 21:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F7128A1CB;
	Fri, 27 Jun 2025 21:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qjf61VgC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C22D25D906
	for <bpf@vger.kernel.org>; Fri, 27 Jun 2025 21:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751060104; cv=none; b=s6a6wibIDGU9JAPk6r9MdpntbE8Hiovtd1Vd+XgUMmkgaodDG0wjFr1UqcVWi5liuVJI9GKVNo0T9QjgcpZcqb2fhFBr4WAY1MGFHH3E+ypUqGtQvaHTsdmzuWMu6g4g5AUShWkdKvRdpzJs1CvQwPGh5V7ymvbm8/sOG612H8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751060104; c=relaxed/simple;
	bh=QHEnnG8b6SRxmSTNHQGX6Jz/3apnaFIvuK8nok+0g+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JHGhgV5yZkTg0+iuYlqE+9xEGDbE5Kw9coy26rOfPPSJir2gT7ni6slcBzljm1T3PmLkiCOqiYIqOL7jPz+OyjZzaF+QkziGEZy/CQULOYeJ67937MtmEvxVedE2GE1jnh2t/LdKP5dvfGh0WD8RS2aiz7RHTyk78F8jAw0T1po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qjf61VgC; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-450cf0120cdso2393995e9.2
        for <bpf@vger.kernel.org>; Fri, 27 Jun 2025 14:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751060101; x=1751664901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHsYyc8j72etmQ6l8nu7nVlRn18y36tKnimcwX5mpmk=;
        b=Qjf61VgC6fXFhofupVuCOiNV9mW3HdlBNsCaWN9eryyvsKYaRf8DIhd0H/tTfM4juN
         IvOO51QmuRG5kTPYPw6tFsb8AIoJQVtKQ3ri5cr1aMfyXRsQ6Qdn/YZ404RigH3zdtfq
         ZwDsbgusnBbbymIyXovj0h2a/l8EjkcWb7CCXLYXFjr24C1+EgEhNbf/m2XcKvxezx6r
         fCwqaSBhMP49kzG43+y2hjvpUsXAj4PEiJR433J0wMSCItJI7i3c0gycpSU+eikVks6D
         gUCwmvCD9QYw5sSqn5EdFcJ8fSv1TQUUvoHSIi5UxLgkgdsO89XxlPfFY7atyyeLxN95
         qzqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751060101; x=1751664901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EHsYyc8j72etmQ6l8nu7nVlRn18y36tKnimcwX5mpmk=;
        b=nzNfRgThOSFwsrv3MHrexx9Tvk1CoA78o3e3GPeKj0609I03jxebOD1B0blXMxbOIs
         B7DqZeed24aXzHwvRSND8ZxxyrVR5x6Kn3GZvxBIpxtcjoQEo2R74t/cvVB21ixJGHAG
         Alt+zoVniLjHlYonSHWgRbA4JwLBqIG3eLWp0DifVesv8/b1w1aYGC0uSLZjLBr9E0+N
         h3nUcvt/3D+3R1I1RDs1N/97g0yqXjF1E/8oLrdJTM4gnTOKzMYC2KvfudUB9pBmXnqr
         /pej6YNckV0vY176cqbXhob2PG/ynvN0hvPnPQgCX0zb6wWpSv6Jt2Jn3CUoppgowsKm
         zYQA==
X-Forwarded-Encrypted: i=1; AJvYcCXUQkR6JAtthHa+ourRK4SoHD07vpw57s0BtwbIMPORzVrr7K4oQSM+/PhYZ1EuBt2+3lk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx9eMErWB+FPb5wQAmPzbbxLeOmsMNl0+cvqv9AN8hnMmruJ9x
	Fgnwklffx7RGkB0NCqRBuOcyZk5XTslWtbeqa3/KV8wNjR7O5IHjFL7IdXsvsrDaZlOQPDvsz63
	PPpTMQrFbGBuhZeR++1BRCcb9KE3Vebk=
X-Gm-Gg: ASbGncstEnGXuKssQnow9Rq0Qis2A3K+oHwR+HRKsxhqa1JJA5Y6P3PZf29oaoBy+KA
	c+d4ROhAbcgFToKBdghjtkOtz2+TZLQfCJMw3BBDGE7qD5P/tvoBadlbbUV0MrGR0Oyc8XCoaiG
	exRFmqOiD7mWfYQcP4LhsYbBOAN2OlLqySTrL4jUAxqVwxWKJsF4xhS3jZv84TcgMuBo2Lhv6t
X-Google-Smtp-Source: AGHT+IFyQxD6FG5hEpsxxYwEahKKZoq7mw5DOEjX42JzLMmH8MAm2d4dA+nrFMUgP/mY2/kn9aVmP1sXT8vd8wKRfgc=
X-Received: by 2002:a05:600c:3b0a:b0:453:9bf:6f7c with SMTP id
 5b1f17b1804b1-4538ee5d0b8mr56595885e9.9.1751060100378; Fri, 27 Jun 2025
 14:35:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627191221.765921-1-song@kernel.org> <839d4696-fad6-499b-a156-994951ea75c7@linux.dev>
In-Reply-To: <839d4696-fad6-499b-a156-994951ea75c7@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 27 Jun 2025 14:34:49 -0700
X-Gm-Features: Ac12FXxMI9n4fKB0DmR-PRVywcbJ-symJsBwXiDXJXPsjlxkXyygktO6yeFuccg
Message-ID: <CAADnVQL5vQ9e5TMYfUafkzEUU+akgVME=OFtbATeTkL-G8aKLQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: Fix cgroup_xattr/read_cgroupfs_xattr
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 2:19=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> On 6/27/25 12:12 PM, Song Liu wrote:
> > cgroup_xattr/read_cgroupfs_xattr has two issues:
> >
> > 1. cgroup_xattr/read_cgroupfs_xattr messes up lo without creating a net=
ns
> >     first. This causes issue with other tests.
> >
> >     Fix this by using a different hook (lsm.s/file_open) and not messin=
g
> >     with lo.
> >
> > 2. cgroup_xattr/read_cgroupfs_xattr sets up cgroups without proper
> >     mount namespaces.
> >
> >     Fix this by using the existing cgroup helpers. A new helper
> >     set_cgroup_xattr() is added to set xattr on cgroup files.
> >
> > Fixes: f4fba2d6d282 ("selftests/bpf: Add tests for bpf_cgroup_read_xatt=
r")
> > Reported-by: Alexei Starovoitov <ast@kernel.org>
> > Closes: https://lore.kernel.org/bpf/CAADnVQ+iqMi2HEj_iH7hsx+XJAsqaMWqSD=
e4tzcGAnehFWA9Sw@mail.gmail.com/
> > Signed-off-by: Song Liu <song@kernel.org>
> >
> > ---
> > Changes v1 =3D> v2:
> > 1. Add the second fix above.
> >
> > v1: https://lore.kernel.org/bpf/20250627165831.2979022-1-song@kernel.or=
g/
> > ---
> >   tools/testing/selftests/bpf/cgroup_helpers.c  |  21 ++++
> >   tools/testing/selftests/bpf/cgroup_helpers.h  |   4 +
> >   .../selftests/bpf/prog_tests/cgroup_xattr.c   | 117 ++++-------------=
-
> >   .../selftests/bpf/progs/read_cgroupfs_xattr.c |   4 +-
> >   4 files changed, 49 insertions(+), 97 deletions(-)
>
> Hi Song.
>
> I tried this patch on BPF CI, and it appears it fixes the hanging
> failure we've been seeing today on bpf-next and netdev.
> I am going to add it to ci/diffs.

Applied to bpf-next already.

