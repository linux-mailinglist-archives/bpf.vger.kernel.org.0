Return-Path: <bpf+bounces-45190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1709D2964
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 16:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 713981F225CD
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 15:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AA91D14E0;
	Tue, 19 Nov 2024 15:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7eFK/j7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1268C1D079C;
	Tue, 19 Nov 2024 15:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732029272; cv=none; b=kIb9IV77WOWaCyT0HA7iNYV4vpf512DRfTP7W/gnhInYWCE9eifqLWHhsxxUFCVDeObeQ7slb4gEKbpG64jbiXvnv0VXcPAvnEDQ55OVnP6JBRnVDBYP37aPuJ/9IKyykU68EbQcLhUVna+1DQpyJwuWaF100mG/FzaoNS6AC6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732029272; c=relaxed/simple;
	bh=C5GRLROYZ4nayOiEJAlz8BN2uZv15qhIMr9SsUrQPKU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=g1tSD/nZxqvTVqiJ1RBxHmvuI7ytDH5K9Wr+EPqoAlIYQ2sZzUtrcA0oi0cfkB6gmWW0hbgNchrwcT3gbg1NCrkVPByekH5aOCFBDtbIyyp+X1JLfikAMe7pLIYBGWz00tZE7QaeuOUwjroxEpID5k+QF+fma3vnU5O8R/LEICY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U7eFK/j7; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6d40ae72d35so26599896d6.1;
        Tue, 19 Nov 2024 07:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732029270; x=1732634070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dcqnz80MpP4iXfsrndcMxetFW6SC6yVqvqpZqY7cMgQ=;
        b=U7eFK/j7ND0X0amQFlw/YWS0mGyguAHyuZ/d8UCnE2JnCbr5mc56/ITyRv01paH89k
         rVzit2/bzTcOYoH13fEj1m9im2isMEjxcbgDaPbRGyCDwd4gBo7jvNI+T3mqFPQ8A5hA
         SDfJtlJ+ap0o6rtIdIDUvGcaKwBPxgEtIPYs2/ujEZsWJI0GAQNUkvhjLDO7Y+ZEIGEB
         vhUhAlcTG7I9uEGGQXYLBDFMIQv49ueK9ZOBXAN9ISEWmYsS/xQ7pEHu8Mlwg2PY91LO
         26RF9rLAwKjj7ELnDTQ3Os3lXT6lSJjU3nsubb4ckcwt1KtNPVVIFg1gS5jqA3hsFKw0
         GJKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732029270; x=1732634070;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dcqnz80MpP4iXfsrndcMxetFW6SC6yVqvqpZqY7cMgQ=;
        b=wB80KhZlPMgPya/QYuSsT4xG6lcNN5ibgAGzI2r9tVGyJ26vDFfMGPhRBY9tyJR+dR
         9y9Ohi+bJTmVjpnmTS3kdcBsCgoMljh8R/G9O4HOW55wRQj7hnDWw/z3Eo7/6cP7tuTv
         /ffJowSsHPLdbKQNJBLL9H88KlgEfG3+UjzQ53k61KJoz9USzopKyEzJNo9n4akJ/k6I
         zs4gYBO011Mr57uJuYMjj8ztBR+LuqxhQKSqFYzt6FaUXfYcL4wUJFuG6PkTrwu9cLhg
         Cy41Ecx5hphz8kv1MZvx+VSicL5pOT6ZDOn7N8bhSJQc9xzgH+gzJnFMI+FMuYtFSoXi
         GtlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJt95WOk3V9mCHNNwMCOA164GrYFkydQErLmSrAevliv8XY+MMdyb8rLRW1X96TJyRJfYMQQSVY8gm1WY8@vger.kernel.org, AJvYcCVG3Qloqj8L0eIcHsCO2CkQTU6v3LQa0gV7TJayqHUOkq4RDEBTWVDiUtT4jdryVahplyRZVQ2d@vger.kernel.org, AJvYcCW7+x5fAr/6wgnjHbiUezjYIHGmg2olvt3IKDzpSe83/iWeviutmUITIOBBdOHpw3ZHyWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKoaPmXJTjLJI0ZWRuM3h9FPTfR4/vHYFA0yRqhPXC03VvUBbV
	+1ZArMBU9OJHDGFTsPAoODiCnE1I7nW2amD5LMqFwCZPAp2RUxBM
X-Google-Smtp-Source: AGHT+IE0bGSVqDFUeRoLXzkS8wWS4ocwNWKCXjefV75pM9MI5oZn7C3M9x7trdzzWOgZjQ7bE4UGpg==
X-Received: by 2002:a05:6214:20a8:b0:6d4:1ea3:9829 with SMTP id 6a1803df08f44-6d41ea39bb7mr122723636d6.30.1732029269883;
        Tue, 19 Nov 2024 07:14:29 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d40dc47834sm48976676d6.62.2024.11.19.07.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 07:14:29 -0800 (PST)
Date: Tue, 19 Nov 2024 10:14:28 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <673cab54db1c1_2a097e2948c@willemb.c.googlers.com.notmuch>
In-Reply-To: <52650a34-f9f9-4769-8d16-01f549954ddf@intel.com>
References: <20241113152442.4000468-1-aleksander.lobakin@intel.com>
 <20241115184301.16396cfe@kernel.org>
 <6738babc4165e_747ce29446@willemb.c.googlers.com.notmuch>
 <52650a34-f9f9-4769-8d16-01f549954ddf@intel.com>
Subject: Re: [PATCH net-next v5 00/19] xdp: a fistful of generic changes
 (+libeth_xdp)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Alexander Lobakin wrote:
> From: Willem De Bruijn <willemdebruijn.kernel@gmail.com>
> Date: Sat, 16 Nov 2024 10:31:08 -0500
> 
> > Jakub Kicinski wrote:
> >> On Wed, 13 Nov 2024 16:24:23 +0100 Alexander Lobakin wrote:
> >>> Part III does the following:
> >>> * does some cleanups with marking read-only bpf_prog and xdp_buff
> >>>   arguments const for some generic functions;
> >>> * allows attaching already registered XDP memory model to Rxq info;
> >>> * allows mixing pages from several Page Pools within one XDP frame;
> >>> * optimizes &xdp_frame structure and removes no-more-used field;
> >>> * adds generic functions to build skbs from xdp_buffs (regular and
> >>>   XSk) and attach frags to xdp_buffs (regular and XSk);
> >>> * adds helper to optimize XSk xmit in drivers;
> >>> * extends libeth Rx to support XDP requirements (headroom etc.) on Rx;
> >>> * adds libeth_xdp -- libeth module with common XDP and XSk routines.
> >>
> >> This clearly could be multiple series, please don't go over the limit.
> > 
> > Targeting different subsystems and thus reviewers. The XDP, page_pool
> > and AF_XDP changes might move faster on their own.
> 
> Reviewers for page_pool, XDP and XSk (no idea why everyone name it
> AF_XDP) are 90% time the same people.
> Often times, you can't avoid cross-subsystem patches. These three are
> closely tied to each other.
> 
> > 
> > If pulling those out into separate series, that also allows splitting
> > up the last patch. That weighs in at 3481 LoC, out of 4400 for the
> > series.
> 
> 1500 of which is kdoc if you read the cover letter.
> 
> libeth_xdp depends on every patch from the series. I don't know why you
> believe this might anyhow move faster. Almost the whole series got
> reviewed relatively quickly, except drivers/intel folder which people
> often tend to avoid.

Smaller focused series might have been merged already.
 
> I remind you that the initial libeth + iavf series (11 patches) was
> baking on LKML for one year. Here 2 Chapters went into the kernel within
> 2 windows and only this one (clearly much bigger than the previous ones
> and containing only generic changes in contrary to the previous which
> had only /intel code) didn't follow this rule, which doesn't
> unnecessarily mean it will stuck for too long.
> 
> (+ I clearly mentioned several times that Chapter III will take longer
>  than the rest and each time you had no issues with that)

This is a misunderstanding. I need a working feature, on a predictable
timeline, in distro kernels.

> > 
> > The first 3 patches are not essential to IDFP XDP + AF_XDP either.
> 
> You don't seem to read the code. libeth_xdp won't even build without them.

Not as written, no, obviously.

> I don't believe the model taken by some developers (not spelling names
> loud) "let's submit minimal changes and almost draft code, I promise
> I'll create a todo list and will be polishing it within next x years"
> works at all, not speaking that it may work better than sending polished
> mature code (I hope it is).
> 
> > The IDPF feature does not have to not depend on them.
> > 
> > Does not matter for upstream, but for the purpose of backporting this
> > to distro kernels, it helps if the driver feature minimizes dependency
> > on core kernel API changes. If patch 19 can be made to work without
> 
> OOT style of thinking.
> Minimizing core changes == artificial self-limiting optimization and
> functionality potential.
> New kernels > LTSes and especially custom kernels which receive
> non-upstream (== not officially supported by the community) feature
> backports. Upstream shouldn't sacrifice anything in favor of those, this
> way we end up one day sacrificing stuff for out-of-tree drivers (which I
> know some people already try to do).

Opinionated positions. Nice if you have unlimited time.

> > some of the changes in 1..18, that makes it more robust from that PoV.
> 
> No it can't, I thought people first read the code and only then comment,
> otherwise it's just wasting time.
>
> Thanks,
> Olek



