Return-Path: <bpf+bounces-52580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE797A44F80
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 23:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD7F71693FB
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 22:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FED820B80B;
	Tue, 25 Feb 2025 22:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncw+Wnw7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAD419B5B4
	for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 22:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740520981; cv=none; b=XuhpKyiNyuyrL6BXP5M7bKKmDepk/Vzwveczf/HTBxGD/tF7HxTWvos+jEGb6gFCQkdBM2LoplEzqvIh+tuFm4tNg3pk3KDP0/KPI5zpQVinwQJFEwQj1eMP4Lfbjy/GV0GwOqSYm9gixO0OggsGmd00FBvixBJ8mglWyxffzT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740520981; c=relaxed/simple;
	bh=agtclDOcNlnzZCo9/VGYkiW3+t03/cnaHFc+H7Outfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HGUpni3mcGBiIUJDSM3HzrbC6nOVpBdeMXvfZnh6HfSFMaxxuDA0U2Ihvc2r3xmpk0kqN1OE+VrqfWrJ4xrZN+y6x5st8G0e7TtojPqW8fZogMNvo4cbNfGJtkwYPY7SSlMGgJj2/Qh4PU9P7Eaa29oklTkS+i7Lj4VAC41KZWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncw+Wnw7; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e549b0f8d57so5347456276.3
        for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 14:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740520978; x=1741125778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhVrcMO6QMzTsNrK87QwWRgitSYbUVF4imIemawcnzg=;
        b=ncw+Wnw70VPrO4JNabdinWEnwCJPSs9Ib3fuvCo14vWceRSPT9jhoqj1Q7hoa2A70L
         fU0eMo3HJZwKJtqjVnKyPLIuHXvXrFU60X/kqmwLLmaYPoZ/sP3B1CRyjccKHe4Nj/oD
         49Tp1wBxiMwdHf3P0XFs9jBWVp+BsXJMvyYQyisbXEqOhgVtyAfQuIUbXajEyauv1AFw
         gB6zn506mQ8HixLagxe0osuC8QDIoJ/ZlB6UMa4Xm1fEFPoQveWUcwFIJjgxRIJZjw1D
         KuUErUexlx/S5ssGXvTuGL/ePov81jK2tdog1XgC7ar4HLvNMmAgTWkg9VxxJFdmT8l5
         QhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740520978; x=1741125778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AhVrcMO6QMzTsNrK87QwWRgitSYbUVF4imIemawcnzg=;
        b=DyEEgDY5+wgc+UlNJ+sjN+lkSI53USxrA9pDQj4IC46PEMyfWg66yii+vyqEsLuv0K
         kkvSRzfYVXCNAdTzj0ikkxQL1M4n5qp86v4dn6isQ+wcNf2RYl2vtndEVVvaqgB/HZVf
         UUEdfEdW7g2yvcmDXvOXMAOyA7vJRPRsUlXF/XT0OtqYGE3nGy9/iCmYeNm6k+H/cYI+
         f79mniGfvOk+79nuBU+BBP5UP634YfCgpa0oF3qWssS5XYW8mXzBjzHJTCBahZmmY55k
         DvYRMl6fQ3h78cYMF1kG9+2+QOaUarLqlNgW3B+hx1dqFY4LNi0m3M1teIeG/Du0axtV
         Oweg==
X-Forwarded-Encrypted: i=1; AJvYcCUbfhcpowgic/W47HI13sE9k30vdiZ58GIgal6BHsLLsJKYt1e0A9TjdzkLTBm74jly56s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5rm/PBrLEfQ2+D8Fb67Xkvh1GjHxTjDgw0EwjnlivA8qGO/rS
	RT8AjywfZ64pWuwzpV8SSSzYOMYRqZOxX+ywmYZCvT5XwYwS6yN2/1v20YPUIs3/xQBxd7N+Vhb
	rslHuN/zgGEtiXgtDBgv9rVSfZiA=
X-Gm-Gg: ASbGncuoV+LxHGRVyg3bIHPnv3Zm09Bz7/iMAT4+nPhVi4pZdQ4UubH7/PNyemoWEgR
	F8OejtZ09EBNlVDv1UfvITV7L0O6ObWCCI+jtK3U1zkoCrcAlUxEkBON5gXI8upB85dl2xLk0ss
	D4aUT44Zc=
X-Google-Smtp-Source: AGHT+IFigzBpWGaZIezc6wmfk6NlSVK0tZEUcEkEu8H93EtbSkZUjKuXUqN5E06e9Wm+tLcnL5B0eO3WBvAVtUxKK4s=
X-Received: by 2002:a05:6902:2282:b0:e60:8d10:8698 with SMTP id
 3f1490d57ef6-e608d1088a6mr280489276.27.1740520978562; Tue, 25 Feb 2025
 14:02:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225212915.145949-1-ameryhung@gmail.com> <20250225212915.145949-2-ameryhung@gmail.com>
 <313aff82-75c0-4575-ab3d-9a4037f47307@linux.dev>
In-Reply-To: <313aff82-75c0-4575-ab3d-9a4037f47307@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 25 Feb 2025 14:02:47 -0800
X-Gm-Features: AQ5f1Jr5xu3Qmf6Gxevb2CIQDlN2XUBdkkzOs8EGohrA7x2cEZ8D2jwgglJt-KA
Message-ID: <CAMB2axPtWQeGh_UYVn9SsT+y5bPh2Z6pNq380-vJ=JQ_ONA34A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Test gen_pro/epilogue that
 generate kfuncs
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: daniel@iogearbox.net, andrii@kernel.org, alexei.starovoitov@gmail.com, 
	martin.lau@kernel.org, eddyz87@gmail.com, kernel-team@meta.com, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 1:58=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 2/25/25 1:29 PM, Amery Hung wrote:
> > @@ -1411,6 +1496,13 @@ static void st_ops_unreg(void *kdata, struct bpf=
_link *link)
> >
> >   static int st_ops_init(struct btf *btf)
> >   {
> > +     struct btf *kfunc_btf;
> > +
> > +     bpf_cgroup_from_id_id =3D bpf_find_btf_id("bpf_cgroup_from_id", B=
TF_KIND_FUNC, &kfunc_btf);
> > +     bpf_cgroup_release_id =3D bpf_find_btf_id("bpf_cgroup_release", B=
TF_KIND_FUNC, &kfunc_btf);
> > +     if (!bpf_cgroup_from_id_id || !bpf_cgroup_release_id)
>
> Just noticed this. This should be "< 0" check. No need for "=3D=3D 0" che=
ck because
> "id =3D=3D 0" is reserved for "void" which is not BTF_KIND_FUNC.
>

I should be more careful about this. I will send another version.

Thank you,
Amery

> With that,
>
> Acked-by: Martin KaFai Lau <martin.lau@kernel.org>

