Return-Path: <bpf+bounces-67824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D03B49E70
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 03:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3A617AC095
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 00:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F164223DE7;
	Tue,  9 Sep 2025 01:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FfAFYMSP"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE082223337
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 01:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757379624; cv=none; b=Z2PBQX8esyBMPT4uBNevGcXhoBotFQTOIQuNBstRp+zc8eA9XELjzEHbF9eucE7oYkyGN98UWqnGmnPVvobjSrB4IYzeRqom3OR+EL5GMo08IQ18Rx6Hl1DFCaG1NjOtvNqqjT1Hn84uSeri1/6h0VfqxsSatbbg/0TdRCRF/CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757379624; c=relaxed/simple;
	bh=N55aMnkplfXqNiODJZgRgz4gVnP2qM6tJQcGwsCXi+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWxPX1sE5XS4lgUO6KOL0aODo0ZTP6hQ31+kWTULYxREl4/4sPS9DVc2N4yrTEi6vYbaDDaNTvejn4DzA8AN2qCn52rszic3unZfCrcnKG9mbeJAtT1sQWqgImXX37qpyAeD5UM+khkEp+J0TX//RVRS1x970KQ4dkRo9By09EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FfAFYMSP; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 8 Sep 2025 17:59:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757379616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fbVVaAOUJ40iam4w0jOVYBsTb3Pkyp33aIkriVY47M4=;
	b=FfAFYMSP3E/sB3/4YOEPOASZx0Ig5m8YLZMD9KCABVR6aNZqbF/93T3NQVzASOEwNFnCRq
	8aXEJIOYMzt1tTeCu+I6jZihYmkzaKWqi7pgu6HawEketr1w5r56bjMdMDH8yfL4v/Z3s0
	X3bKIc7fgz7uzFJGPBe3e/prKjPZuss=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v6 bpf-next/net 0/5] bpf: Allow decoupling memcg from
 sk->sk_prot->memory_allocated.
Message-ID: <r2lh33nhc5pyx7crfahdeijd5vdq74abcmrbqkls2zwnih76fk@opua7takczmc>
References: <20250908223750.3375376-1-kuniyu@google.com>
 <hlxtpscuxjjzgsiom4yh6r7zj4vpiuibqod7mkvceqzabhqeba@zsybr6aadn3c>
 <CAAVpQUC1tm+rYE07_5ur+x8eh0x7RZ2sR1PGHG9oRhdeAGBdrQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAVpQUC1tm+rYE07_5ur+x8eh0x7RZ2sR1PGHG9oRhdeAGBdrQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Sep 08, 2025 at 05:55:37PM -0700, Kuniyuki Iwashima wrote:
> Maybe _EXCLUSIVE would be a bit clearer ?
> 
> net.core.memcg_exclusive (sysctl)
> SK_BPF_MEMCG_EXCLUSIVE

Let's go with the exclusive one.


