Return-Path: <bpf+bounces-68701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D496DB818E0
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 21:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2FD87A6F59
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 19:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687943009E9;
	Wed, 17 Sep 2025 19:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d91kQnYQ"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B748285043;
	Wed, 17 Sep 2025 19:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758136724; cv=none; b=PgsHefE9d4xWPLTU7zqKkeDYjYmz25awZ8AYWFZMRv3lv+KWLj5+/TSV0jywRnRENCv94DRDgTaVwl6WibiM+pR8btJb9YELDw3U3DXSyVwWyYZdc0gINKc5yxRN4vijxh8kCuV53ttBXlWWRf4qrQrYAs6W6dkpjc5Af81pfvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758136724; c=relaxed/simple;
	bh=aN0+n4Ztzpr7l/SBefoWq4quPXDb5bZeOzNF0FM7Nok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AvhpKAbf/rKonMqEhs+GmdJJ78j3R0K4M9PmI1kgdLiGbC6J7DVsY7551MNRAZgdXkmWM2yjf9TfurOVHk3iIfkzxI85qCahWQ3vYJZBLw3s7YGyeAac8CdcyMA3oxUoIyGn3m47x+g3BQmAA5F/Ohfhezp4BfyM8u7XKjhQ2CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d91kQnYQ; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dcc22c04-94fb-4e1c-a69f-b033078867c7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758136720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PEL5wMtTupMYXXZzTJ9NE4Vo0e904rmNlavHVz+gIbw=;
	b=d91kQnYQPMawJuf5rZQXc54HNE2Iztf5qrI5HvrSNtStf+ECpKTB0UmWraLqTfXdAGLsBw
	pKaumtB9IJfsW7H2w5NYL2VlRvpDH10Nh8Ura8VK8p4Jsac3nSiJnh4ufjXKXzZUfx/oKd
	YWfJ6F4sHeXTCbZ0BnPwv6wGE9B/1do=
Date: Wed, 17 Sep 2025 12:18:28 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v8 bpf-next/net 2/6] net-memcg: Allow decoupling memcg
 from global protocol memory accounting.
To: Kuniyuki Iwashima <kuniyu@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>,
 Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250910192057.1045711-1-kuniyu@google.com>
 <20250910192057.1045711-3-kuniyu@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250910192057.1045711-3-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/10/25 12:19 PM, Kuniyuki Iwashima wrote:
> Some protocols (e.g., TCP, UDP) implement memory accounting for socket
> buffers and charge memory to per-protocol global counters pointed to by
> sk->sk_proto->memory_allocated.
> 
> If a socket has sk->sk_memcg, this memory is also charged to memcg as
> "sock" in memory.stat.
> 
> We do not need to pay costs for two orthogonal memory accounting
> mechanisms.  A microbenchmark result is in the subsequent bpf patch.
> 
> Let's decouple sockets under memcg from the global per-protocol memory
> accounting if mem_cgroup_sk_exclusive() returns true.
> 
> Note that this does NOT disable memcg, but rather the per-protocol one.

The bpf side changes look reasonable. I believe the commit message in v8 has 
clarified the reason and its behavior. memcg reviewers, please take a look.


