Return-Path: <bpf+bounces-44309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC699C138D
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 02:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1CD41C223F4
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 01:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2765B3D6D;
	Fri,  8 Nov 2024 01:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmRlcWQX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110597464
	for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 01:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731028861; cv=none; b=WZj3T8yqLJvAGe2zHg2ae3skzrlBCBi1tir9nNQTeYAbN42AM8OQ78bs5tsyq6zi7rfA4V2UYFB8N8OUM6nvHTTNfIIioG51Yth5OfNtENL33aqCIb+H31D9R2KqaHwcLbyhnrrJptIjTsZmXFNAsinI1moMPY0o0VITYkL2uyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731028861; c=relaxed/simple;
	bh=y2Z6rDXqtVhYy+az9EA6lxeENtS7gCrnC+61nB1PU3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lks4lopWS388eS0c8zNUzYtj86Oi7tbDn8g9/+PYtBMZNVgdSevibSWlPsEaiDVXMPlG1Uh5GDer7r+iZEY9PFYTqCRBzbVoEPOxO62gFpuyq7QQ94KB+ZbPykeT1Clbyfwj0OwnAXRtXZdQXZBf0y3PFNY5AHPc/mSKha7x+gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmRlcWQX; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d518f9abcso1001901f8f.2
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2024 17:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731028858; x=1731633658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csXEQJ0hOWDqTcb5yESFfn1ne2rBnPQKOjpHE+1KT3o=;
        b=kmRlcWQXXtou7DD7L7Jc+lsC14E/WYm2naD9SqFXJcgyTvB0JQrRZWRCe3HLW1PKsg
         zBCENWpRrAw9GcLKjaGRyN6b/UDv4C60bU1o5DuvABKRFeSH9ciCjLhEBvBrE6m9S4MB
         UhBQQ1uvQ7Q/PZ8BK8uKoyzc56nhRznKgH/DxbK5ymbGV5Jz/DFnDoRlqB3rmCZpaS+N
         H4VCjXDR/9ZH+KWX5KDrGZv51t9TOMpPoei4nKano+8RE2WFQ2p0sZlugMQHTrb8GMg1
         VMBtkoNggAihgFbTB8/hcRVRX85FTD7MPK2aTNozrLQXFBklJWfa/DMp+izwfX0cK5nQ
         6DLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731028858; x=1731633658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=csXEQJ0hOWDqTcb5yESFfn1ne2rBnPQKOjpHE+1KT3o=;
        b=t4peM9aZUbSTWQX/msIvdgwXAXlf9QPUTYpU+yJkr4mv+ykP3rlu6Ig+zERCLyQ8WE
         p16N5xAxwMMnkITOnahxNgloM43JwTk0QYLQKYn7aEVOdr15KavmcdIuG/5knps+R0Hi
         eULKNHnllViP9hf1ryg84Sodwt5/v+U6d7yZ0iRJwNSSf04x2Gun7L9zpgsHeCO4UYNk
         pltbfwzfKG3V2jMIwhQ4Gk12k7vQZFFP/cG+h6RzrhjP8DD14BLxwQVeMltdykAJJ3ml
         AKDyMUd7P3TL9RT0I2DHkgLjNNVwOOOK2ZQIhvcgg3fF2wj+PgxUKzLd3CPpzxptsGAe
         odWA==
X-Gm-Message-State: AOJu0YykSRhtnjBALl2LD5ymxcuKsqgz5HWaWY+Xf/1+kwF1jVsrkvuT
	D/gmKlmueriLDTT4hbIPVpv6h1ka19wHBAHPmrCYhL4N3+rYFoeyXpnM90TvWJxEmfyo8PfcGgs
	AAZh0Lo7zU0QgZKT96MJZ4pitMSllJw==
X-Google-Smtp-Source: AGHT+IGv+N35bYAXi2ED91kiigdt2gFXgegiInZyRgIz29V/KnLU08Z7EGRSjBE/pUniNsL6oH5bCieF8fIFO/nhyIo=
X-Received: by 2002:a05:6000:1f81:b0:37d:398f:44f9 with SMTP id
 ffacd0b85a97d-381f1872f2dmr700190f8f.32.1731028858034; Thu, 07 Nov 2024
 17:20:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105212001.38980-1-alexei.starovoitov@gmail.com> <20241105212001.38980-2-alexei.starovoitov@gmail.com>
In-Reply-To: <20241105212001.38980-2-alexei.starovoitov@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 7 Nov 2024 17:20:46 -0800
Message-ID: <CAADnVQLMwA1fgApP=H8_jeTeF8JRUXDtMt13qcwUGezvcAQg_Q@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] drm, bpf: Move drm_mm.c to lib to be used
 by bpf arena
To: bpf <bpf@vger.kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	dri-devel@lists.freedesktop.org, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 1:20=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Move drm_mm.c to lib:
> - The next commit will use drm_mm to manage memory regions
>   in bpf arena.
> - Move drm_mm_print to drivers/gpu/drm/drm_print.c, since
>   it's not a core functionality of drm_mm and it depeneds
>   on drm_printer while drm_mm is generic and usuable as-is
>   by other subsystems.
> - Replace DRM_ERROR with pr_err to fix build.
>   DRM_ERROR is deprecated in favor of pr_err anyway.
> - Also add __maybe_unused to suppress compiler warnings.
> - Update MAINTAINERS file as well.
>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  MAINTAINERS                       |  1 +
>  drivers/gpu/drm/Makefile          |  1 -
>  drivers/gpu/drm/drm_print.c       | 39 +++++++++++++++++++++++++
>  lib/Makefile                      |  1 +
>  {drivers/gpu/drm =3D> lib}/drm_mm.c | 48 ++++---------------------------
>  5 files changed, 46 insertions(+), 44 deletions(-)
>  rename {drivers/gpu/drm =3D> lib}/drm_mm.c (95%)

DRM folks seem unresponsive :(
A simple move of the file shouldn't take a week to acknowledge.
I had plans to tailor drm_mm to bpf needs, but at this pace
it will take too long, so I'm abandoning this approach
and going a different route. It was worth a try. Fail fast.

pw-bot: cr

