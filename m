Return-Path: <bpf+bounces-34594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8C492F064
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 22:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A15E283867
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 20:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187FC19EEBB;
	Thu, 11 Jul 2024 20:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="loHycgZj"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D196F13D626
	for <bpf@vger.kernel.org>; Thu, 11 Jul 2024 20:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720730076; cv=none; b=MA9nPghxzcRzfKAod5OI2F4C6kY/FPfovqLd7LXR7Unb30eS83sknoOMWjTFXgBhyk8UC7kpEilC5W4LwOlw1mz4uuuEUsDtJ1TSMnSRKPtpNR9/6BrqCv/awt37oNnjSDcOeHgfcgOYlfG14cfkRfW4mrdA71507eK2pKBzL2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720730076; c=relaxed/simple;
	bh=a4EWMLxLYU7dgopG4xNfVc7BeMmhgH7egitiGwSDCbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KxTZTAVlG3ZSs0qecX+KCDV839oepyIj41ORAX1eZnQmzSitDFHA03HsE/JgPlbvr9aIyr1CPbNebJNtplW3djn2N3VfiLTwZ75juw/sek/O3HNEpeyeqeJVHaEVQ4Pl2aye22yWzAZQPQxVQEzLDYC/c8FzQdhIs77xNxPQgQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=loHycgZj; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sS0Um-007vuy-T7; Thu, 11 Jul 2024 22:34:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=OTKv62FwC3C1sZ9zlpBXXUgzF/vKZCRAIfql+rOy4bE=; b=loHycgZjIoV2mv69bmpKCE1QaN
	D7YizgcQMowu096XZqiKbgFMHMksP67wzCUDbYRYH4Iesbh++iMkYV5mZJa13bMMqvzgQfxCWCLFM
	bhCM4YrVwDDI59zq6wVVNDwLlo4P3zR3pY1bRiGzeNVM/azsW2rOxjfesrH+kHD7Dg2/xODkSoO0k
	aeywDW+cE62aN0An6z9eh9UhB4zieuccBo4zOpWx336mBUhuQ0wG3KsYed6CpquNg51yasadDb4H2
	gjshhaI4T8EIngk6NUxPuItE5VNdH4M6jnO2G7gH1mSfX4hWheaElqZ3O/HeydKxuUvaFCPIGCVLD
	fxIuoTrw==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sS0Ul-0004vw-O3; Thu, 11 Jul 2024 22:34:27 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sS0Uk-002Cgw-4c; Thu, 11 Jul 2024 22:34:26 +0200
Message-ID: <b902cd1c-cd13-4bc2-b892-8f1174fdeed0@rbox.co>
Date: Thu, 11 Jul 2024 22:34:24 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3 3/4] selftest/bpf: Parametrize AF_UNIX redir
 functions to accept send() flags
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 john.fastabend@gmail.com, kuniyu@amazon.com, Rao.Shoaib@oracle.com,
 cong.wang@bytedance.com
References: <20240707222842.4119416-1-mhal@rbox.co>
 <20240707222842.4119416-4-mhal@rbox.co> <87v81enawc.fsf@cloudflare.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <87v81enawc.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/9/24 11:59, Jakub Sitnicki wrote:
> I've got some cosmetic suggestions.
> 
> Instead of having two helper variants - with and without send_flags - we
> could stick to just one and always pass send_flags. For readability I'd
> use a constant for "no flags".
> 
> This way we keep the path open to convert
> unix_inet_skb_redir_to_connected() to to a loop over a parameter
> combination matrix, instead of open-coding multiple calls to
> unix_inet_redir_to_connected() for each argument combination.

All right, I think I was aiming for a (short term) churn reduction.

> It seems doing it the current way, it is way too easy to miss
> typos. Pretty sure we have another typo at [1], looks like should be
> s/SOCK_DGRAM/SOCK_STREAM/.
> 
> [1]
> https://elixir.bootlin.com/linux/v6.10-rc7/source/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c#L1863

Yeah, looks like. I'll add a fix to this series.

> See below for what I have in mind.

Thanks, got it.

