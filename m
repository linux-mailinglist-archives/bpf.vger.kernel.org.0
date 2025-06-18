Return-Path: <bpf+bounces-60920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C28AADECAA
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 14:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F25D1889A8E
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 12:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D36F27FD62;
	Wed, 18 Jun 2025 12:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="j4k3kesd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28562DF3D9
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 12:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750249755; cv=none; b=kUX1WB0oXnJr26n9VvuT2NLRvNHGp0wk/FMCLQGCuoCGYOzW+cUPBNQh9f+9Xlesn3Qez1Dgc49/VoCA6ZZBJhqjBHrvkOymFqp06dVVzzTzrGnRLlAckmH+JfqMpxxDVcSov+ewuqKCcyhT67GEB5lYZf7IitKq4UZVSvT+KJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750249755; c=relaxed/simple;
	bh=k1ToMvPhb2nfK3xpZ0YNG/kZh4jrPc+viBe0YLqGLi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dVG1/CKmXodMd1PQ3b/z4mXw0oBuSwQEau+Nhfk28dLWeiXlREuVTxpFJquREl+ooKxVHftKHWyLVWBWRBitTIdTmy6NpOSTgtRU9MEbcCnry+xEQtdb9WISR7Ohw0vdylo5cc5yaiBoGVWS8Vv+IUX6SW+Lcb74LHKcAQGHtDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=j4k3kesd; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2360ff7ac1bso48132105ad.3
        for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 05:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1750249753; x=1750854553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1ToMvPhb2nfK3xpZ0YNG/kZh4jrPc+viBe0YLqGLi0=;
        b=j4k3kesdSClYAEDTF1DrfW8oVmVSSlyKRkPBDTOiPzZRDdv4rsIPaBWMj9aVtH0qtZ
         r5EnU1CiQ9RwrgOkarxNc/XWtmmJqpdOzIkJThdpTZuIRVjGqMfey+REZ62EcKmxIohM
         cd0QDbhS/ijuqIpDfF92OFED10MjaBKO8cqDGbtyCR0sh22lrqi0g8lunxTKMZvpaGRX
         z6B0SxbF8A0y+ErPfT5FygfD93EfIYQcGLZ3mWaCQCMvVjKKVnelS79ri2Yeas85/J/B
         21THAQEYjvCmo5WDbEWow+KQx7g7QoUOpmNcUMoyMN5hl0x/XhsbTmoHhjwfXYM2+NDP
         Jzxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750249753; x=1750854553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1ToMvPhb2nfK3xpZ0YNG/kZh4jrPc+viBe0YLqGLi0=;
        b=n1+chzAvL2Bf8YhzqUG1bckVA0HOum4EsGL2gZXZkMDpkAd+ekh5BMbvLK4Nvrj5R2
         GpuwHovsYi/VFolLAwprcROuxCRPkrK6WDt2/wNE32NEF8ktEmUuqEsFIHDGecBN/s4q
         RoDNor4KIptO4JnvE4XELc2LcEVGMdz0S4D6ManoGXsLiP7pKV4f5ZHRICiiOMWnDZxc
         bP5dp9owqEIpClJDYExgzqAc/I+rIWgLYqGD+LnpPYMARwF/N5z476wO47CUlo9dsMk2
         UDxw31qCyJ53H4AHm6IsANkr7u5230IdmzKfm3lDkMOASjdtbSapiLx9poFN23FjSMrz
         re7g==
X-Forwarded-Encrypted: i=1; AJvYcCXY5xP1LHzUVhVa2AUawigU2m3L+NAFHXC1XcImmRkg+HSgeh4RMECwhu3Lnh6bsRPojhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKxVwqVS/FbAsX1v581R0VkB6geoAlF7J0/HyunqkNl9aGomaE
	IOYiT5gvQZsvG5GZTlozHmW//TAnkvZGgKdYjntfXhPgLfmGow3RxyIaC9BSqfm+RQhf2MzYl2k
	lQsxA7asEc13Zi++kukqBAJeQsgXI+XjR9BBiNRBqrA==
X-Gm-Gg: ASbGncsux4imA3XogJJGJ3LrcSTEYoOPf1zqEDYzErXAdvtJ+WVcHeVljfyWYOCnHl1
	Pa+ZJfTUP/tjs6rK2H75lWqmX2UJYegvEPxRmOyaeEKOVNFqPP2foebwOfgHF7oZD8o/XGQfgkM
	dZdhF6qL1H2U0BNqsirN5hAZRGFmPuUBPsCaT65fiM6sOJ3db9qQ10xLKVh2hg
X-Google-Smtp-Source: AGHT+IGORnWPn6X8jkI2B9VRfShbK7BW0yz2jVJzmG/TWFTGuZgHTvmgv5OkoiBfEfZxZHJS/HUcsPVug4C43uBDSvY=
X-Received: by 2002:a17:90b:2dd2:b0:312:f88d:25f9 with SMTP id
 98e67ed59e1d1-313f1c7dacfmr27688759a91.7.1750249752875; Wed, 18 Jun 2025
 05:29:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616095532.47020-1-matt@readmodwrite.com> <CAPhsuW4ie=vvDSc97pk5qH+faoKjz+b51MDYGA3shaJwNd677Q@mail.gmail.com>
 <CAENh_SQPLHC8pswTRoqh0bQR84HHQmnO3bM07UQa1Xu9uY_3WA@mail.gmail.com> <CAADnVQ+QyPqi7XJ2p=S9FVDbOxMXvVPU859n+2ApuRQv5T2S5w@mail.gmail.com>
In-Reply-To: <CAADnVQ+QyPqi7XJ2p=S9FVDbOxMXvVPU859n+2ApuRQv5T2S5w@mail.gmail.com>
From: Matt Fleming <matt@readmodwrite.com>
Date: Wed, 18 Jun 2025 13:29:01 +0100
X-Gm-Features: Ac12FXwDEAhDzTRAN0K4xbEQuq2S3-I5MeDpvbC5scQ0X-LXzuvGn8MnFsuiUhA
Message-ID: <CAENh_SQgZ5yVpshKRhiezhGMDAMvgV7SmwD_8u++mACE33oNrg@mail.gmail.com>
Subject: Re: [PATCH] bpf: Call cond_resched() to avoid soft lockup in trie_free()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>, 
	Matt Fleming <mfleming@cloudflare.com>, hawk@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 4:55=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Jun 17, 2025 at 2:43=E2=80=AFAM Matt Fleming <matt@readmodwrite.c=
om> wrote:
> >
>
> > soft lockup - CPU#41 stuck for 76s
>
> How many elements are in the trie that it takes 76 seconds??

We run our maps with potentially millions of entries, so it's the size
of the map plus the fact that kfree() does more work with KASAN that
triggers this for us.

> I feel the issue is different.
> It seems the trie_free() algorithm doesn't scale.
> Pls share a full reproducer.

Yes, the scalability of the algorithm is also an issue. Jesper (CC'd)
had some thoughts on this.

But regardless, it seems like a bad idea to have an unbounded loop
inside the kernel that processes user-controlled data.

Thanks,
Matt

