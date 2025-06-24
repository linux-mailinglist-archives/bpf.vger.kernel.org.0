Return-Path: <bpf+bounces-61417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 878DBAE6E11
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 20:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4301D4A0D7D
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 18:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1612E2F05;
	Tue, 24 Jun 2025 18:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2hvNbzt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A1017A2F8
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 18:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750788375; cv=none; b=SGhf9pBJVwAdHJ74i0jq+N1naVWp6zRHIHOGrxMIiv6GIC/pYpA+nmg+f2y1JpD28DCKAxDAxNCRE7630IlH8zS5BYKiwUtmd4LDju3hw/sWR/oIW3hSA0VnSDYWWkF9BGcxXqmLaueRrP8Ukhek2OZS/+pZDu8GBGrOrudcSlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750788375; c=relaxed/simple;
	bh=5FACDlNya2VzbN2VDdRLKrDYn8MgiN6flzW3kWepPeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BjQTv/V8+brOWsCTestxVEqu24A5uBwNwSM90dY9N6X+N4U6nJG3i19Nn1yZ9lc4JKmZ/XrMCU1+3WsHi1PvnTc6ID/ewX59b6+wWZgymHIexqzTrBU02ejyWkzEBsUGJ/ppY8by3LTuz380httKFkw0QtiFblyvC/7TfFTi93Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2hvNbzt; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a50fc7ac4dso532334f8f.0
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 11:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750788372; x=1751393172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJ+TkY2LUAXWLcBaPJu29Lv0b04JVvKQkHAourfTiRo=;
        b=A2hvNbztIpbmMzmwN8+raMcm8pW82VnAUBdVqFR+lkjtJInPH7InWOFP1pA48Z12jq
         McOwQAw+FJ0OLPnxZ82NAzHY7ZVnP+eHxoPfVYUjcxwhoQQC+iK3N0ZSEViC+zjhbfYP
         ww4ooYR4Q6SqEBtZ50+XpFz1RHZuXfxtd7f5YZnyFwHidWrtQKwNu0LIdAPBH0/iT56p
         4g6UUI/CzC67SaIbjhAROoURxieUihrEUNqsB04xPdfG+HN+fvsNqyc6KlzrlqJN3+1M
         5NuDvNmOLc5prtf6mYhI+AN0uFPZe+bfkOYZ6ogBes8KfqoPo5nlEALrWyJp5Q1KKybd
         pPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750788372; x=1751393172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dJ+TkY2LUAXWLcBaPJu29Lv0b04JVvKQkHAourfTiRo=;
        b=gDfooVRHe89pEXzwtDtTT95dZlbqqfwqrrJk1wTWG75GjzbOmkzI3PPPBftwW2w3Qe
         mT/pMCu0CHeJ+6rLA/VobnmMiOmyM9NfMmxQ6ckmSlZuB/34nAq6Qz/qYiyMxZeuClZm
         8llcHHsnwMjzGhFFCon+BYH3ZyyGZWbVEtQPemRm9KEv7k+ws/Zrdoxgh/hei93Rue3E
         EXm/9jKBU4lPCUsxwXye5VtTGOfw5iwqXQXrmq0xP/0YHokN2h+Cg5QVpYl2wcLFDziO
         /t1SuvjzsSWX6kXeCm2gFKklzFw8zaPuq5F9tZfCeRGvpaRYDepfEwvdrRLZvgmN00Bd
         Je7g==
X-Gm-Message-State: AOJu0Yx2M2ypegRh8QINFZzqSDyNxP8pavi8sVzUJAqrySFC8Kr5Amcc
	hrkzrHkkOkBEt0kGfSYJ7VhhojuloHoe3uetQtLQpQGV+AMOFI0yHE+P9b1t2M/1MihvboQsEP4
	CBOtv9P5EqRI+SqiiYsjgZRZMP6ZyUk4=
X-Gm-Gg: ASbGnctc/9L0tatn0aMJ+P1YT/tZxpLcGzKdqytxM3ArjYvtI/sHKURTqt/c8GFTGQU
	r+8f2rMq6kIgmiTs1JN8sBvQ2sMvtOkWix7UpZE36bSAcfzEz8oM7meKTWD/r/LvExYWWoOByD7
	6SyLyBBKxx1SYn8mFSPJnw8nUO12pj0WEgWnRMfzAP1fUTN48xaAHko+GspaA=
X-Google-Smtp-Source: AGHT+IEYQVIewXDKhsWe4tooetC7TfPQq44PS3fUQIQ5Auv/tBJ8n5mlxX7Fm5JuNIhRdGHVqU99lQoNvEBskni7ZqY=
X-Received: by 2002:a05:6000:2010:b0:3a4:dcfb:3118 with SMTP id
 ffacd0b85a97d-3a6d12fc1f2mr15419004f8f.10.1750788371922; Tue, 24 Jun 2025
 11:06:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624031252.2966759-1-memxor@gmail.com> <20250624031252.2966759-3-memxor@gmail.com>
In-Reply-To: <20250624031252.2966759-3-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Jun 2025 11:06:00 -0700
X-Gm-Features: Ac12FXxnjHtob_n4M3-DDf_ka7WDgKE9Ol-KLwOv27eYO7LO-HiAP_jX8DNNKGk
Message-ID: <CAADnVQLXU-1TPrLLnRzTRgfmu-GTyQ5D3=xieMgC0yqXY1FmHw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 02/12] bpf: Introduce BPF standard streams
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 8:13=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> +
> +static struct bpf_stream_page *bpf_stream_page_replace(void)
> +{
> +       struct bpf_stream_page *stream_page, *old_stream_page;
> +       struct page *page;
> +
> +       page =3D __bpf_alloc_page(NUMA_NO_NODE);
> +       if (!page)
> +               return NULL;

__bpf_alloc_page() is using GFP_ACCOUNT in both nolock and normal cases,
but active_memcg is random at this point, so the page accounting
is incorrect.
I think we need to remember objcg in prog_aux similar to what
we do with maps, and then store that in bpf_stream and stream_stage
objects in corresponding init() functions.
Then do set_active_memcg() here the way we do in bpf_mem_alloc
and in map_*alloc()s.

Or use alloc_page_nolock() directly here without GFP_ACCOUNT.

Also I think it's strange to limit kernel messages to 4M,
since the kernel messages are essential debug info.
While it makes sense to limit kfunc's spam.
I suspect the idea here is to avoid OOM if the kernel is spammy
due to malicious bpf prog that forces the kernel to warn so much?
But dmesg doesn't do it.
And 4M * 2 * number_of_progs can be many gigabytes.

Maybe let's drop stream->capacity and rely on memcg to limit
the spam for both kernel and kfunc?
Accounting a page at a time seems sufficient.

> +       ret =3D bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt__str, data.bin=
_args);
> +       /* If the string was truncated, we only wrote until the size of b=
uffer. */
> +       ret =3D min_t(u32, ret + 1, MAX_BPRINTF_BUF);
> +       ret =3D bpf_stream_push_str(stream, data.buf, ret);

We discussed it offline, so mentioning here for the list.
Let's not emit \0 into the stream. Looks unnecessary.

