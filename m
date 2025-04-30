Return-Path: <bpf+bounces-57048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D0EAA4EEE
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 16:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBF153B2297
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 14:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986B525F7B1;
	Wed, 30 Apr 2025 14:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCRYfeJi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA9525B670
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 14:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746024255; cv=none; b=QNizJ5XDqEhhc1OP6cT10xHxoH/Ukkl7zq4IJjivoZOUmynHdzfHFvVIYU6UEoLMSQieT4BDGVOLTo2T8sTKpwrB3+lIfJ+o8b/6gbGDfbG4fDLg2yg3UWbq9BEVIRXBY3adM6V2Xwnwb+IxM0vXJLLVu0fBjb9HeZZjIzj6a54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746024255; c=relaxed/simple;
	bh=Jfbf3gnL71W5WlXIVx61pFX3nJsTcCfMH9twz8ykwpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bel0Xu2ukkZ+2XAeqbDBAkjuIDblZnBZ3sOzz0t/G2hff2o+iJX3u956DUA58ZnOvIP+gRMGfpYIu+nV6DQWSJCYODaynUUoo11HXmUnPqSrOMTD7f/cLPCGkxwBW8SVnVZuOmityGnTJJc2zr/UXY/B1CPJ7izqw9KaRZDLmKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCRYfeJi; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6f0c30a1cf8so110203636d6.2
        for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 07:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746024252; x=1746629052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jfbf3gnL71W5WlXIVx61pFX3nJsTcCfMH9twz8ykwpM=;
        b=VCRYfeJiy6d9oae2mfDYRdx9Fk8bc9XLueiBJiOfl8ljDxKjB0aoAx73Wbu/B2tMLU
         cWilyuNeNUbVhO9RlcKt97VDrJovTnupT/KfSvUbDEncE/VC6vq+VR5XevLvUQOpu95I
         gVud9PD5O6fr5mmmn5p9thP4elrkF9/7GX5k3aj/RWiCs2dNrZKg0ICDc9EFTyYqY350
         jneY6CMNtDL/2Z1qFLMtt4kD78PyP0jXMFHyJZyS/QoB1hTigXnX8E7KkWgrZRDS5DLO
         l8xF4ZIg4I1s+mU0A+xky4ZUqIuQ+fImXt8hCcFlnowwu/vxt2VJMWVzqAPCw4pKcvL8
         6ogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746024252; x=1746629052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jfbf3gnL71W5WlXIVx61pFX3nJsTcCfMH9twz8ykwpM=;
        b=i4U9tpIYy2sStWQULJHEUV1QeysRlf4u52n5j82YNqiMl54eYbDyTOiVerY3nzm132
         /fbtfq/DRmG6AL/rmoY14kKxoMOeJfzgdJ84wryQgQCkj2991IlYWO0m0EnDvnFLzBe3
         y1wPeD06pU4hjKKuFPH2GKeMTAAJmewkEpwmto9aAk0b769aCKskdtsaOOUN3WayQ0PL
         0dfqq8uoMGxMRzrUBx6zuI80dZ0SU780Aln9iRiE47LG+ZaFYUV9KSTiO3Z9RhbqWPOz
         ghjpKDtsOx1R+ih1HUW37TbeO5CSHbdytf/GHVXAMFCdG6Su/QSWjmQ87tqfe3VJs0xf
         mYvQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5hPVJ9WB0pb+s9pcDcXyTmzu/W5p+/Womz8rvZCuwalWZc5kknfFzbLllRQem8RLjEJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbYBzK6C5X2MrpQCvUsemIo0vp01SSus4U6cja8zH1iDamvL0t
	cwzxz3bAahY7hUCfZwpyTvNA6HQVmS3SmFky6svo0zaT5B4Up5q+ILCFuVPglP149Dk+4AV1Y2v
	q2rIjhIs42zVx1pG6qQ9Sntiglpx6LnL/QiEeDw==
X-Gm-Gg: ASbGncsfXZKT4Wl/Ez6P9tZdrbeZSO5sQJoGgGZu0zLHRwuCCRwNj09Z+xdlMAryhom
	1a8BDxi0fSlkoXgTbExsqtxFSRWFWpXehOEwJw1nFe+i37QINjKWAXLlCqqnI3y/SQ5noXbgxXm
	k7ilWRyrPnd1CnS4WcUdeurMY=
X-Google-Smtp-Source: AGHT+IHMBG+e+8gfs6zmS5oVXtWgORoJUNe+eqgfIm0EY+F7PgAw/2uFHb4W2gTJdcaLfS2aX0CrcIKt/QTa6i1J5HA=
X-Received: by 2002:a05:6214:2a4a:b0:6f4:f621:bc with SMTP id
 6a1803df08f44-6f4fcf90929mr60632856d6.33.1746024252600; Wed, 30 Apr 2025
 07:44:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429024139.34365-1-laoar.shao@gmail.com> <20250429024139.34365-2-laoar.shao@gmail.com>
 <D9J7Y3DKHQJI.2MBF33WKN1BH5@nvidia.com> <CALOAHbCXSmTMwUNSR=6CBtFRUipFbm-58zX1FDKff55Bv4QbNg@mail.gmail.com>
 <23D129C3-0E55-4056-A0C7-5713D71FA42B@nvidia.com>
In-Reply-To: <23D129C3-0E55-4056-A0C7-5713D71FA42B@nvidia.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 30 Apr 2025 22:43:36 +0800
X-Gm-Features: ATxdqUE79DbpT9dtlZVenyBNjlAGP7Ph3zreGWYL6pZcUBaM3XEwD41E5-6xmW0
Message-ID: <CALOAHbCkj3+RSyh5qJEorfC6nkoCFH71jFzy=LFgo-pfsJZGVg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] mm: move hugepage_global_{enabled,always}() to internal.h
To: Zi Yan <ziy@nvidia.com>
Cc: akpm@linux-foundation.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 8:11=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> On 29 Apr 2025, at 22:40, Yafang Shao wrote:
>
> > On Tue, Apr 29, 2025 at 11:13=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
> >>
> >> On Mon Apr 28, 2025 at 10:41 PM EDT, Yafang Shao wrote:
> >>> The functions hugepage_global_{enabled,always}() are currently only u=
sed in
> >>> mm/huge_memory.c, so we can move them to mm/internal.h. They will als=
o be
> >>> exposed for BPF hooking in a future change.
> >>
> >> Why cannot BPF include huge_mm.h instead?
> >
> > To maintain better code organization, it would be better to separate
> > the BPF-related logic into dedicated files. It will prevent overlap
> > with other components and improve long-term maintainability.
>
> But at the cost of mm code maintainability? It sets a precedent that one
> could grow mm/internal.h very large by moving code to it. I do not think
> it is the right way to go.

I believe the helpers used exclusively by mm/ should be moved to
mm/internal.h. If the size of mm/internal.h is a concern, we could
consider introducing a separate mm/huge_internal.h.

That said, I won=E2=80=99t proceed with moving them to mm/internal.h if you
strongly believe it=E2=80=99s not appropriate=E2=80=94though personally, I =
don't think
avoiding it is the right direction.

--=20
Regards
Yafang

