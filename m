Return-Path: <bpf+bounces-70167-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02551BB2022
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 00:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81943189243C
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 22:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347103115BD;
	Wed,  1 Oct 2025 22:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xguj0tq5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F54D2566F7
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 22:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759358398; cv=none; b=mhzyIXr5aB620Oc4NHYgC9O+gNalIPUrzs8y6SYJWkLBIvel6CJHFGyHJZ8deJEMPFPE2MbTdVKB8Xjs+JOdExiblzLzb4qTkTM9cJh3NYTQxm1IvFcvfgceLCpRhuNMXlVFtiNSqBgPptqEJS7UJAzG0oocv+pRuub3DJQiCrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759358398; c=relaxed/simple;
	bh=xTxvzRoUUj2XJnwbnltPmLdp4p8sKze8llKtphGU/eE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=acRCQOAtRr6u6MOoEwB9DVUXp1Yhw8PAs4suY5jS34eQYr/qvd5kriecUbuGZ53P/OushqmfArCGUel6fNgZFzsF6CCrV061Etf/g4mDvrQgmj6WafzCqQcz6ZZr6GKWDb0cfvOTYs/dYYMUCnsu5Fth+jryMExliNamJ/+Z9NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xguj0tq5; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3f1aff41e7eso261664f8f.0
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 15:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759358395; x=1759963195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTxvzRoUUj2XJnwbnltPmLdp4p8sKze8llKtphGU/eE=;
        b=Xguj0tq5Xn6+rwWg1qXJYG5A5xbil82zCq8VH1VrN0opGTg7Nwn3O+y5XjxsRFfKJ1
         LdihEy6c/6hvN9LeLLPMaKVu5oQzpwJrsN9cFNCc0qFG/bJAkSnz4ZzO3DI0pAwnZlWq
         EIY6CRlKaajEjkwgCg+odWyscvNhhNgCsIay+HPWu3NowMMPoep7i4NVp9p0VjrKGCUa
         Yky9yQzKAZ9kuUtOV9chW4eTkxVo445fTbO2C1vu82iRHU5DHNHN2GbUF4aOCiGIjsjX
         oTFr9mkzm04aMO3avpJgIn8wYAP3v4BK4LmhitgsncH2UugQ8ygXMQSnMlJ1n++aDMbS
         9vWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759358395; x=1759963195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xTxvzRoUUj2XJnwbnltPmLdp4p8sKze8llKtphGU/eE=;
        b=PU/RlZDvRwz8o0T8V0G9x6x/TYodPNIyPSAkaHoUdLbz8KnUhO/TiWKMkQhkMfO5YO
         llmYTGlb57LwghV2F3vMETA1JhuM8Dr/gb1akh2SK4Ljzu1ig9CCJ+irH+eUSA1n/WXh
         5CsNxVjOPUltqh/fpAhz4V7C0UcZpKsNAaSEi83w6/tpBvJGyenOuYS8ItD83xQdgzDu
         uWyoyz6EFXOoEAQM232y3PRKaFsmWdQARxJAKGnwEFuaEzPhii4xxXeYdvxo4dSqS6mj
         VdmYMNl0g/8/veS8WpHZUqq7UR0Z/f5SUfx9JneV3uSNSY6HfduRKREoz0KdREbPHyMZ
         hEpg==
X-Gm-Message-State: AOJu0YyEX1z1U4xtPyiZPQz7SN4PmWWXmfxkLKbcKVrQtD2FzmkVAwVq
	Xc6Yj/t7RmBxR9bFa9wprd5uh2lrb9ODH3C+IZN7SGAGP70N7Pe75wT/c+VioB6etvcSR3M/vzA
	8nKi9wsL70jPGQ5uyndf5WVcGxJEhlTc=
X-Gm-Gg: ASbGncsTAoVr179mlE7taKxd+M7A1z2GfHP6Jb5y6pTCjPH9X96oE55Oab5TG4d0Ocq
	85Wo6be+tBQLcAi3pAfyjFY692uZZIBO3A1Jnr1vR9+1bF+yeRQ6ad9jZijQsCmF2GCvko3zNY4
	zKNRGrxRw22OhO+rKoqJTbV1SN/pu8ggnOb+wEivXfCJqQGmy5D8nKOtz03i6tfzcwMhuMLTKm5
	3CicmweAVzb+WQnN3c0sjUpEr5TwIuYwspzjqw4ivibdtT/dhhUfXEwdoBm
X-Google-Smtp-Source: AGHT+IHobjh4T1jnQ9pjO89Ovl6NWKogVtQ7J2KcJmT9YTgG1kzmTufg2TSIlfe+PaQwHCwlC/gvupH3EH3E+IJ94uw=
X-Received: by 2002:a05:6000:200d:b0:3ec:e152:e31c with SMTP id
 ffacd0b85a97d-425577edcf1mr3154199f8f.1.1759358395319; Wed, 01 Oct 2025
 15:39:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001171326.3883055-1-andrii@kernel.org>
In-Reply-To: <20251001171326.3883055-1-andrii@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 1 Oct 2025 15:39:44 -0700
X-Gm-Features: AS18NWDZ3DJSPGgzfip9qjYESrHkudCgYm8fDeAHyDVl33mMJi5utQAgXtg9uSs
Message-ID: <CAADnVQKC8z_2jhqLju0mNPBr9+YdLe9wLuRRwSbXm+3gfOHV1g@mail.gmail.com>
Subject: Re: [PATCH v2 bpf 0/5] libbpf: fix libbp_sha256() for Github compatibility
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 10:13=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> Recent reimplementation of libbpf_sha256() introduced issues for libbpf's

Fixed typo in subj: "fix libbp_sha256" while applying.

