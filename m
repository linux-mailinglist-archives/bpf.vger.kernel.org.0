Return-Path: <bpf+bounces-66743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97591B38EDE
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 00:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F05716D66A
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 22:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CADE217709;
	Wed, 27 Aug 2025 22:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Iz/LHZg7"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D061030FC3E
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 22:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756335425; cv=none; b=W0eESlSg6nR+CedhBIKrIbRYIG3U/3VYQ1W+U1KhoXfKiEvOLyXr0v7HrCqFaq9behAanJPyOQrKdTO3YnGrMozQ2J3OyoU/UNLkXtuH1vh896lRwLwRstM+Ob2cumn0yq/HMEyW3gQRBwqr9coQ5GF4MQ7zpUceLQ22Hbgvr60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756335425; c=relaxed/simple;
	bh=xiJ9t1YTeu5ZrEO3m5CG16pNsyQ7nchDIi6+OGCjuqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3GiNjwGwud50jMeTSo9coh5M2r3LkR92VxB1hSEzye29Bla0khQPv7DeHKxOIDDdK1/YxaHtD7VOcwFMgP7jQFTF1NRICo7EIAa1OFW5EIrKkZrDJesFrTMexlfstkXOYFOnCHJmvMSOBkmsVJHZg1zXZDB/i7yBTWllXPCo9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Iz/LHZg7; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 27 Aug 2025 15:56:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756335411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L+DB8on87O7/Jsub/24/qL1zUQyKqLuPxag6cDd5BO4=;
	b=Iz/LHZg7Q4XSIsFkoIrvlTZJKlwZ9Xm6asORzo1uuzODBgehuKkE226OXe6v0fH10l55Ie
	DGis3u12eVrYufEBdsHRkBdACjgTig4uJPsonCnwsN6Gzscdt9ZQxQHlCF2Pb8FQ6QX7aZ
	ULxsFkygqKb3msoUTo+oq+dnkrPmGDI=
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
Subject: Re: [PATCH v3 bpf-next/net 1/5] tcp: Save lock_sock() for memcg in
 inet_csk_accept().
Message-ID: <f6bop5lyqhzmmtbca7kyw2vxhmeji6kgntcjjrsl345c5napwu@utckuhl3pnt5>
References: <20250826183940.3310118-1-kuniyu@google.com>
 <20250826183940.3310118-2-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826183940.3310118-2-kuniyu@google.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Aug 26, 2025 at 06:38:07PM +0000, Kuniyuki Iwashima wrote:
> If memcg is enabled, accept() acquires lock_sock() twice for each new
> TCP/MPTCP socket in inet_csk_accept() and __inet_accept().
> 
> Let's move memcg operations from inet_csk_accept() to __inet_accept().
> 
> Note that SCTP somehow allocates a new socket by sk_alloc() in
> sk->sk_prot->accept() and clones fields manually, instead of using
> sk_clone_lock().
> 
> mem_cgroup_sk_alloc() is called for SCTP before __inet_accept(),
> so I added the protocol check in __inet_accept(), but this can be
> removed once SCTP uses sk_clone_lock().
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

