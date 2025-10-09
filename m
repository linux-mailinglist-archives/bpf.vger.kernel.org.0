Return-Path: <bpf+bounces-70706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A782BCB2CA
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 01:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77A2C4257AE
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 23:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04364285CBC;
	Thu,  9 Oct 2025 23:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S78UxCbs"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579B972625
	for <bpf@vger.kernel.org>; Thu,  9 Oct 2025 23:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760051506; cv=none; b=Qv3wqPJfMn6efpGmnc0W+YsApzmQn4NhlUvNzAf6SXdvkqvRFkfh2fmMQwRWhZTmnyxtNu84YhS+yBb27UgDQNaBll1Tq+nrzzVicI+AWusW1vuAKv3igZbzg8hFqai+TVsX91uIvhAkK2nuls4X4rPh+LRzCvebP/sx8ByOC7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760051506; c=relaxed/simple;
	bh=qRzFJiBKd1i6/Bq+yUhx5ijKeoY1BejnZfIlGYN05aM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfgtxuWKrvkgeczcqTO9rEbJg1wKXEgnw6CNBwVa6QREplGRXVcMh+r1HOW/aK4btyZHwxEUHSOucYU/X9eikq4ww8ef0Io5hgVPz9T8Dq+A/VG3qXIlY14b3I5Gd73/VthUoLbCmrAFjduczbwQH1tNV5uISwwPGxX8ChK0XHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S78UxCbs; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 9 Oct 2025 16:11:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760051492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=llralkTgPwhfJAuFmat258iRIRj3a5VJ7susO8Cvbv8=;
	b=S78UxCbsa6Ny4XUSoa3koj30HGvcxzQ3TFLNeBYSW7hNyEzVkbkzkVhaKLxKoXVK7T23SK
	MDxegkF7S200tfdVNixxQhohhacX+Tw+YAJCAgAqAfcPFBTKQyIn+A3C+ayd59PbWK9/AN
	c5YlgHPahpjtlHF96ETAVSoIN5mpWFw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Mina Almasry <almasrymina@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next/net 2/6] net: Allow opt-out from global protocol
 memory accounting.
Message-ID: <o2m3gexuta2xbf6a62y22lzqhejw4xbs7diu2bu2rfvrf7xqvx@lkdymq576v5a>
References: <20251007001120.2661442-1-kuniyu@google.com>
 <20251007001120.2661442-3-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007001120.2661442-3-kuniyu@google.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Oct 07, 2025 at 12:07:27AM +0000, Kuniyuki Iwashima wrote:
> Some protocols (e.g., TCP, UDP) implement memory accounting for socket
> buffers and charge memory to per-protocol global counters pointed to by
> sk->sk_proto->memory_allocated.
> 
> Sometimes, system processes do not want that limitation.  For a similar
> purpose, there is SO_RESERVE_MEM for sockets under memcg.
> 
> Also, by opting out of the per-protocol accounting, sockets under memcg
> can avoid paying costs for two orthogonal memory accounting mechanisms.
> A microbenchmark result is in the subsequent bpf patch.
> 
> Let's allow opt-out from the per-protocol memory accounting if
> sk->sk_bypass_prot_mem is true.
> 
> sk->sk_bypass_prot_mem and sk->sk_prot are placed in the same cache
> line, and sk_has_account() always fetches sk->sk_prot before accessing
> sk->sk_bypass_prot_mem, so there is no extra cache miss for this patch.
> 
> The following patches will set sk->sk_bypass_prot_mem to true, and
> then, the per-protocol memory accounting will be skipped.
> 
> Note that this does NOT disable memcg, but rather the per-protocol one.
> 
> Another option not to use the hole in struct sock_common is create
> sk_prot variants like tcp_prot_bypass, but this would complicate
> SOCKMAP logic, tcp_bpf_prots etc.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

