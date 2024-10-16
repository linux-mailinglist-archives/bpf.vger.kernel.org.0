Return-Path: <bpf+bounces-42229-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FB59A1292
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 21:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A08A1C20CC5
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 19:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DCA2144C5;
	Wed, 16 Oct 2024 19:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHMNNeOI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1291885BB;
	Wed, 16 Oct 2024 19:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729107153; cv=none; b=naSrDiPWOnxsGD6Ih/u/vNszpmd1G1+cvMSV6meYYkhmLfcYHd6aYWR9iaw784lMcJpr0U8GXjr9ODVk3BuGvCB9t8G5aIkQZ9d8fU7q7pTi7iPvZdujYfHAD+jX9LuP0dGTvaE3IX0Abw3BdiOt67aS0ED5ZXEaIa2ynh4sklY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729107153; c=relaxed/simple;
	bh=DCiowFr9Pu71dlJI3fY1tp1MwHO28XH9VSc6g+FaQw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B/hD8L5T0w8D9aLmOo82AeHX5X6REvCz92Cd0GaOYAkNNJOYw7LwoJJY+Hsjy1FDxYEua5NeO7nDmQto1CI1jd1jWuxPeNz5iu8Eu6HnoVs0z2wH4NXUghg+vyeiBXIEr1HAkft57w1540yAJYdbxNMvqYCfB4uQG9DhpdCuJCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHMNNeOI; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42f6bec84b5so1986755e9.1;
        Wed, 16 Oct 2024 12:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729107150; x=1729711950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4rl0B3DN7zWi36BodccOQQbkpQljW1anHrXwo5pjFI=;
        b=VHMNNeOIDd596EWfUn+4m84HYfQ0Ti01xEnxaB3yjukheZm+DtMQqrhBhIMOLfobpI
         +IFvou7KIRwaQsBCZrhLKgQrwmtGCkwgESpV/K2S9SNPiAe+A+uUluKfjBcTFCJVCFPY
         JfMaLNC02PkQci0oVkCt+30oHneK0H/ez5ZC8dhlyBiUO3HhBIXSqGOS+cm+pPUU5ZcK
         y2dZqhJw/E1V7aJFY94+NFkZ+uD8bh5wHhrwjWQCwoHZFXi2el8kV3hnCPtDKbUSPZxb
         uAaCV5LcBbeOquZyH+Y/HQSLGVEkthjfOqSYjT5mF4Q9d2r3PHiAx07nbwIfLcU83fvw
         LIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729107150; x=1729711950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i4rl0B3DN7zWi36BodccOQQbkpQljW1anHrXwo5pjFI=;
        b=MpWkRtaRWd5JM4mNQePrPZaMhpvQAw5OcnfYmmbOgiJzfEHkDuh1ecDEHE6a7qgU60
         pek14ohtNWiHkUchktYy363qoTiwWB5wOEJSXOxoAEOzZttZG8ID4EoPMBe5vXTh1MLJ
         simvGXS6eMrvcpP/js1KUvBtDpya2w9TtNzR3bsX7R+saY03HAudlTjgiyos0LpkbrY1
         U6ovfon00hALLcNiGb16epX3pfxUij1bSxwrFJiL/KxMRqpBJL7O2meMhcSlnS5c3MTV
         /8JKMyCHGSnwU+Z0R5zwMsnw2WyoTeohKNGVHeYFvbMCuB2yF8wUtiC1ImG+qOrKVHL/
         y0uA==
X-Forwarded-Encrypted: i=1; AJvYcCUAPT7Tf+jEop/nrcozTit+thWy8ETxqwum+zRxoXY/Lzx5Ej5Mj+hXgfT/djOVfN1wGOeOCAyGGhyhD0DN@vger.kernel.org, AJvYcCUYB98P9EpemNYWOp9YjoMRUruFDPoSh3GI3KrDvq9jmRSp8lU5ezUiN+9RLeH1MkM2KCM=@vger.kernel.org, AJvYcCVpV2mcv1hwH4idZ67GWWNdRuJ7e4wPQGG8ap77eheoR7TLLAqk9SlRrU4I320z/a51RV0K8hqHxznrnA==@vger.kernel.org, AJvYcCVrgwHwevFAgmfVU8lt67rs8aI0SVOQShqZjZ+KILP9M0OPDwLX7b/obNnwqfyCMbFkI5iX0H2s@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjkxe5n0JcKuB5UHvK2QY7YXsw/d6HUTueCR9W4PJsip0KruZu
	/5YOUFxxSn4n+Yw8eV6iHn0xPAgAAIDsTaWaBSdK/Iv3vJJ+NUxukC1uVkTwht4mnafX2EC+1cp
	Midi9klCUuRTY60+JUauza3dTfh+CDAcQ
X-Google-Smtp-Source: AGHT+IF7c2QXjgydXkv+1KGDqbxKGaOuyA03qWTWeiTtkOuAqHwKxV2uYSiiYHoCvtn1g7OFJLr0iNzp8cEzepZNy0E=
X-Received: by 2002:adf:cd03:0:b0:37d:4ab2:9cdc with SMTP id
 ffacd0b85a97d-37d86bb47aemr3273075f8f.13.1729107149760; Wed, 16 Oct 2024
 12:32:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016170542.7e22b03c@canb.auug.org.au> <CAADnVQJ=Woq=82EDvMT1YRLLTvNgFVSbnZDiR5HUgEhcyBLW4Q@mail.gmail.com>
 <ZxAHZt8pFjxeOx-U@google.com>
In-Reply-To: <ZxAHZt8pFjxeOx-U@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 16 Oct 2024 12:32:18 -0700
Message-ID: <CAADnVQLpFZsRbMndY6nHqSWiAh3SfmN8S6KbJ9p9T_WC3x0i_g@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
To: Namhyung Kim <namhyung@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 11:35=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Wed, Oct 16, 2024 at 09:25:41AM -0700, Alexei Starovoitov wrote:
> > On Tue, Oct 15, 2024 at 11:05=E2=80=AFPM Stephen Rothwell <sfr@canb.auu=
g.org.au> wrote:
> > >
> > > Hi all,
> > >
> > > After merging the bpf-next tree, today's linux-next build (arm64
> > > defconfig) failed like this:
> > >
> > > Building: arm64 defconfig
> > > In file included from arch/arm64/include/asm/thread_info.h:17,
> > >                  from include/linux/thread_info.h:60,
> > >                  from arch/arm64/include/asm/preempt.h:6,
> > >                  from include/linux/preempt.h:79,
> > >                  from include/linux/spinlock.h:56,
> > >                  from include/linux/mmzone.h:8,
> > >                  from include/linux/gfp.h:7,
> > >                  from include/linux/slab.h:16,
> > >                  from mm/slab_common.c:7:
> > > mm/slab_common.c: In function 'bpf_get_kmem_cache':
> > > arch/arm64/include/asm/memory.h:427:66: error: passing argument 1 of =
'virt_to_pfn' makes pointer from integer without a cast [-Wint-conversion]
> > >   427 |         __is_lm_address(__addr) && pfn_is_map_memory(virt_to_=
pfn(__addr));      \
> > >       |                                                              =
    ^~~~~~
> > >       |                                                              =
    |
> > >       |                                                              =
    u64 {aka long long unsigned int}
> > > mm/slab_common.c:1260:14: note: in expansion of macro 'virt_addr_vali=
d'
> > >  1260 |         if (!virt_addr_valid(addr))
> > >       |              ^~~~~~~~~~~~~~~
> > > arch/arm64/include/asm/memory.h:382:53: note: expected 'const void *'=
 but argument is of type 'u64' {aka 'long long unsigned int'}
> > >   382 | static inline unsigned long virt_to_pfn(const void *kaddr)
> > >       |                                         ~~~~~~~~~~~~^~~~~
> > >
> > > Caused by commit
> > >
> > >   04b069ff0181 ("mm/bpf: Add bpf_get_kmem_cache() kfunc")
> > >
> > > I have reverted commit
> > >
> > >   08c837461891 ("Merge branch 'bpf-add-kmem_cache-iterator-and-kfunc'=
")
> > >
> > > for today.
> >
> > Thanks for flagging.
> > Fixed and force pushed.
>
> Oops, thanks for fixing this.  The virt_addr_valid() was confusing
> whether it takes unsigned long or a pointer.  It seems each arch has
> different expectation.

        if (!virt_addr_valid((void *)(long)addr))

did the trick for me and that's what I pushed.
Odd that our bpf CI on arm64 didn't catch it.

