Return-Path: <bpf+bounces-62700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD13EAFD5B5
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 19:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D84AF4A83D1
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 17:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E984D2E6D30;
	Tue,  8 Jul 2025 17:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfVturJ8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CC62E5B12;
	Tue,  8 Jul 2025 17:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751996980; cv=none; b=ScK5/jxmrduvQDEzssPMcdjEyN21j2sQ8plUWllftDZf7c9lIHLK9bNjWPzheGDZeN59x65oEBn52XRrFvXjFeME5Rz4skdbO+/G4C/UReKnvULn23I3JZ/5EM1VRvAl7nAv45n1wVUbI8/jIVIopkfkmQgRaL3SdNO0xfrAInI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751996980; c=relaxed/simple;
	bh=mHw1y+UP8/AtOMHF8e3q6xPzlTeUZ9k27IU1C11V/tA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bz2FxPZ0fFHlKRBF1iU4ZE5N6dVb1q7wPU9gLYhDfzjPuNgqnsc+E6UnA+FKLWn0AyrhUoEzs6zyc1evp6SF19brQ6wYaoGyTKsskbqZ+pv3SXWXpHIa5GZluyqCGz5nO/QaB5traHIHNfhvg6EnU7n7yuJLGZpQcMZ8JllbpBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfVturJ8; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-742c3d06de3so5454759b3a.0;
        Tue, 08 Jul 2025 10:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751996978; x=1752601778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TfGHCpKiATO/car9fxGjjpC/yJtP9kbddUriJfKtC+Y=;
        b=HfVturJ8mMYZ9Pg8FXHryidf/SNr+HE0NVkRpkr/64wmZ3Qy16SJtML8aYgiHxtPFg
         7v4m5VY2ic9S82rvsJPu24m7MohUDYVavL+oSOliCC1CWvCTOhFv3Ip4TKkjGyWxJoMT
         SUp/kZlrEwUI5cyelhNEjwK6yLbv9i2RZb0yNQoCPgwy8KhV6QATxbA07wrzJbnuMcXV
         Y8Nv59b1XBVncH8EOHT0g4LKPujV3ZwMjb3PoNoGxsVt8Oht+pFywDgizoT+40HFoAF7
         Lrjlfa412B4bdJclPZ/eHL5DZROX37ESXsN0S61yYPCT3VDkpPtdrxIWhn7jFWQGC9il
         Cx1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751996978; x=1752601778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfGHCpKiATO/car9fxGjjpC/yJtP9kbddUriJfKtC+Y=;
        b=F/YyU/txEc+TILQjzXYfCwirFF6u+SmZrX3Ha4Lq3xZCyuNJ1gRyagGx/qet5Dr2F5
         PEY/jKGAYCop2lYR9CPYDPEWZTRdNbsOouNPxesPW8Srb7Eu6LQB/hGQVlqXn948KP6S
         ZIdsqYQCrySLrlkJpdQbolyECJK6JJcuLD9oJQxoL3YP1iKjh8aR6KcuwJUQ58dRWsMA
         3igR8NS9nYCrmqOGSlGxL8shXh2Nunrs9QWcza+GBhsD/09J7HIRjrf2MKpdN7porb0r
         Xf8Zrt2IUMANLNh7AarwbrHuvBXfKKulgrDtuQIoU4d5/GS+cIzmbC29qF5fVTDvBxee
         BI0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdZZeoLV5TRtwyjMuLHPB19heMKhpGrwBl+mP5D553ipxWKDunhoW0Bfzs23GPPvZMCOk=@vger.kernel.org, AJvYcCW7XQHJ2PGzbELyTB+fJHoTLalTu3hRwY2Z0Jq6Hlkcc2b6j7zblSJsrhh3G1qla7xYeOQ1o42D@vger.kernel.org
X-Gm-Message-State: AOJu0YyCBfMcEuDB/TeZlIjGzolk7Aby1cY1VWRbVot7hB7u4ZEQSILg
	nz7RigG0jQ4i7vdQ5pU5PrTgrVjnAU+aU+OBQwX/oFd4R3BYHoaSnD0=
X-Gm-Gg: ASbGncuR+3RNlryYcBdjrS1d/aqUQEoZAfBle4uAcwMo9hQ2IlH7+qwHpxuOnN5ODQV
	bFwUTZsPU1Pb5JDzW0j0WbN/eZqwNfp0diTbH3cr+5LcTYAx5tyoxdU/7Td4Ok0xcdcnBYUuuoL
	qRdAeTV1xjfFmmelCBjLhLyljZM6YG3MCYxyKQTjAeqKNNQrALiYrfKLV0lscdSVICDbrwNW5ey
	05F+AlDDB79Kafc7aJRTToDFkyMJmh4wnFYMLoujeaHtJ0R7h9eLNkL9D9PDKyvOGdm0VOsX/kv
	BXLNM/Yh9AeC378Tf1huhZpAuqME6oNiqzOpYVWZhE/dZcqCEz1qyHw/TO0N3u8WdA+NQTrxD9Z
	IuUyxrCDuillfjRFyMGIZ9j4=
X-Google-Smtp-Source: AGHT+IHhBghnmKtGt4Ho8pyJxCqgQvss53AVS3Dstn95HlGvLtDNrezX/IgPnci/8V18srjoBnfeYQ==
X-Received: by 2002:a05:6a00:3d01:b0:748:eedb:902a with SMTP id d2e1a72fcca58-74ce6688e28mr24171410b3a.17.1751996978138;
        Tue, 08 Jul 2025 10:49:38 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74ce429a0b1sm12572208b3a.115.2025.07.08.10.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 10:49:37 -0700 (PDT)
Date: Tue, 8 Jul 2025 10:49:36 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	netdev@vger.kernel.org, magnus.karlsson@intel.com,
	Eryk Kubanski <e.kubanski@partner.samsung.com>
Subject: Re: [PATCH v2 bpf] xsk: fix immature cq descriptor production
Message-ID: <aG1aMOmnb-6K7syY@mini-arch>
References: <20250705135512.1963216-1-maciej.fijalkowski@intel.com>
 <d0e7fe46-1b9d-4228-bb0f-358e8360ee7b@intel.com>
 <aGvibV5TkUBEmdWV@mini-arch>
 <a113fe79-fa76-4952-81e4-f011147de8a3@intel.com>
 <aGwUsDK0u3vegaYq@mini-arch>
 <aG0nz2W/rBIbB7Bl@boxer>
 <beaab8ec-d11a-4147-b7f4-487a4c3fe45b@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <beaab8ec-d11a-4147-b7f4-487a4c3fe45b@intel.com>

On 07/08, Alexander Lobakin wrote:
> From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Date: Tue, 8 Jul 2025 16:14:39 +0200
> 
> > On Mon, Jul 07, 2025 at 11:40:48AM -0700, Stanislav Fomichev wrote:
> >> On 07/07, Alexander Lobakin wrote:
> 
> [...]
> 
> >>> BTW isn't num_descs from that new structure would be the same as
> >>> shinfo->nr_frags + 1 (or just nr_frags for xsk_build_skb_zerocopy())?
> >>
> >> So you're saying we don't need to store it? Agreed. But storing the rest
> >> in cb still might be problematic with kconfig-configurable MAX_SKB_FRAGS?
> 
> For sure skb->cb is too small for 17+ u64s.
> 
> > 
> > Hi Stan & Olek,
> > 
> > no, as said in v1 drivers might linearize the skb and all frags will be
> > lost. This storage is needed unfortunately.
> 
> Aaah sorry. In this case yeah, you need this separate frag count.
> 
> > 
> >>
> >>>> Can we pre-allocate an array of xsk_addrs during xsk_bind (the number of
> >>>> xsk_addrs is bound by the tx ring size)? Then we can remove the alloc on tx
> >>>> and replace it with some code to manage that pool of xsk_addrs..
> > 
> > That would be pool-bound which makes it a shared resource so I believe
> > that we would repeat the problem being fixed here ;)
> 
> Except the system Page Pool idea right below maybe :>
 
 It doesn't have to be a shared resource, the pool (in whatever form) can be
 per xsk. (unless I'm missing something)

> >>> Nice idea BTW.
> >>>
> >>> We could even use system per-cpu Page Pools to allocate these structs*
> >>> :D It wouldn't waste 1 page per one struct as PP is frag-aware and has
> >>> API for allocating only a small frag.
> >>>
> >>> Headroom stuff was also ok to me: we either way allocate a new skb, so
> >>> we could allocate it with a bit bigger headroom and put that table there
> >>> being sure that nobody will overwrite it (some drivers insert special
> >>> headers or descriptors in front of the actual skb->data).
> > 
> > headroom approach was causing one of bpf selftests to fail, but I didn't
> > check in-depth the reason. I didn't really like the check in destructor if
> > addr array was corrupted in v1 and I came up with v2 which seems to me a
> > cleaner fix.
> > 
> >>>
> >>> [*] Offtop: we could also use system PP to allocate skbs in
> >>> xsk_build_skb() just like it's done in xdp_build_skb_from_zc() +
> >>> xdp_copy_frags_from_zc() -- no way to avoid memcpy(), but the payload
> >>> buffers would be recycled then.
> >>
> >> Or maybe kmem_cache_alloc_node with a custom cache is good enough?
> >> Headroom also feels ok if we store the whole xsk_addrs struct in it.
> > 
> > Yep both of these approaches was something I considered, but keep in mind
> > it's a bugfix so I didn't want to go with something flashy. I have not
> > observed big performance impact but I checked only MAX_SKB_FRAGS being set
> > to standard value.
> > 
> > Would you guys be ok if I do the follow-up with possible optimization
> > after my vacation which would be a -next candidate?
> 
> As a fix, it's totally fine for me to go in the current form, sure.

+1

