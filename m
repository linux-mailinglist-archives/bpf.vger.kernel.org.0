Return-Path: <bpf+bounces-66752-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45475B38F9F
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 02:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCC21686F34
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 00:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977BF1CA81;
	Thu, 28 Aug 2025 00:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hJvFvBW5"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3774723CB
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 00:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756340048; cv=none; b=cXB5XcYm51OFBTYkRiJQz2gmMJl5zVIIpxZ69DzXE/hIBhSILbVlqbsYUOirkMnv3gGlp/om3I3FSqz4dPymOaZEM6Qsg8eWVixCMd+4N1D7ZOhwbS8izE6znYYx1q8Njc2Zj58WKvVyGub3R7yFqBC5lMrtyep7tSJ/FeqHRTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756340048; c=relaxed/simple;
	bh=wwxJdyzi/OPxE3jLAJgSAI7KEudj/m+iNjD472rVvLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UAj0hP1EhBVqFnJeWyIFXJr0l25J+NSGQ3KLy8p4zesf72VUThCqZToiRrnU2XwoJUkDk0F/jnN33s29ffthXu3vLN36H9qmKaGo03vlKXwcfbzdidJ3g+uSnu32ZEX+sfq76djfj/IhnVNXs6lJYYuxkLMnzJ46AfL0bxoXCKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hJvFvBW5; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ab07a893-d27d-447e-931a-6014f55132d2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756340044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Nioa5Xk16+HQdcRt9MGwBFxVkEF38M/TDMpMffC87Q=;
	b=hJvFvBW55g5b6OCq3J2rTOLvZVHKbP1Vx7g8GPR53S3wuLoPiwEig8mw+nNlGNm6LQgG7D
	dy/WLXmMFERNduUHu2OdXRi0BFlGbWZyX9dbJOjNcbLrLj7A1joH1LLJplEqv7hY9K8FMu
	leEnGshUT0zN0MJ60KPFgBiBdRQNre0=
Date: Wed, 27 Aug 2025 17:13:57 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 bpf-next/net 5/5] selftest: bpf: Add test for
 SK_BPF_MEMCG_SOCK_ISOLATED.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>,
 Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250826183940.3310118-1-kuniyu@google.com>
 <20250826183940.3310118-6-kuniyu@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250826183940.3310118-6-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/26/25 11:38 AM, Kuniyuki Iwashima wrote:
> The test does the following for IPv4/IPv6 x TCP/UDP sockets
> with/without BPF prog.
> 
>    1. Create socket pairs
>    2. Send a bunch of data that require more than 1000 pages
>    3. Read memory_allocated from the 3rd column in /proc/net/protocols
>    4. Check if unread data is charged to memory_allocated
> 
> If BPF prog is attached, memory_allocated should not be changed,
> but we allow a small error (up to 10 pages) in case the test is ran
> concurrently with other tests using TCP/UDP sockets.

hmm... there is a "./test_progs -j" that multiple tests can run in parallel. 
Will it be reliable enough or it needs the "serial_" prefix in the test 
function? Beside, the test took ~20s in my qemu. Is it feasible to shorten the test?

