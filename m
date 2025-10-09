Return-Path: <bpf+bounces-70689-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46550BCA927
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 20:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0FC0B4FC51F
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 18:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F8724466C;
	Thu,  9 Oct 2025 18:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W38tNWLq"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3D6253944
	for <bpf@vger.kernel.org>; Thu,  9 Oct 2025 18:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760034504; cv=none; b=M/bKL1Geqn98iGviXl+CgDKJEFJaDg+/LkdrkwZxfAdYYIDaHHUoupmzfm8Cc+LIO0nbS7LPQtaOkkst06V/LYnNRbH6xRmNQ9xc+oYpnb4Yd5Lvv7bYvT7IOPix+o8FK9vqa2dCCv86h21YyNhC2KDTe5MT4wLTVajwkPbk7/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760034504; c=relaxed/simple;
	bh=bWbtqSIaWdeFqrm0s+5Tdn/grYIGN8++unPksIZxMJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oHtLrJNjr9fX+u8InHgUl83+wufLYiv3KpZ8/881CXI6XlUBcDK9aaUN36izesNeDImSr9e/Khrem7rpZWHxxODLR7+4iXjB2AlqK8yLWRJOYAVzMBWrMoS20DzoIA08VG27bpFStefsvMRDQe38N+az/cCVgHjDdqBobDqpqu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W38tNWLq; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <49b4dd53-68bd-4773-8c5c-10048f970f4a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760034495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xT1tN7ELc8/0VN9VetHGmbx6E+eoJqJGnl/5MX3YFj0=;
	b=W38tNWLqrqELsNlzn9btdyy5YQYbBL9hl4IGzxNZB+RUdJ361ofzQ1eNX/IMufX4mseOG6
	Ehdwdk4R5bYUKdbepZuS4+vpXxRzbO3dIJBoHsYM+PBw0xJQMrWohQlW+zM8m+4VS3XrEZ
	qvvvWRvtHIX9lsnSMks07wpzzYAy8tY=
Date: Thu, 9 Oct 2025 11:28:05 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next/net 0/6] bpf: Allow opt-out from
 sk->sk_prot->memory_allocated.
To: Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>,
 Mina Almasry <almasrymina@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org,
 Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>
References: <20251007001120.2661442-1-kuniyu@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20251007001120.2661442-1-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/6/25 5:07 PM, Kuniyuki Iwashima wrote:
> This series allows opting out of the global per-protocol memory
> accounting if socket is configured as such by sysctl or BPF prog.
> 
> This series is v11 of the series below [0], but I start as a new series
> because the changes now fall in net and bpf subsystems only.

netdev reviewers, please take a look and ack if it looks good.

Shakeel, you have reviewed the earlier revision, please take a look.

Johannes, please comment if there is concern on the changes.

> 
> I discussed with Roman Gushchin offlist, and he suggested not mixing
> two independent subsystems and it would be cleaner not to depend on
> memcg.
> 
> So, sk->sk_memcg and memcg code are no longer touched, and instead we
> use another hole near sk->sk_prot to store a flag for the net feature.

