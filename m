Return-Path: <bpf+bounces-45090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6C29D1200
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 14:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D460E286823
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 13:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCA053A7;
	Mon, 18 Nov 2024 13:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M/ngxECh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a95sVnsn"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0564019AA63
	for <bpf@vger.kernel.org>; Mon, 18 Nov 2024 13:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731936606; cv=none; b=D5MOcCiPxy6GIuw70REKVyDVHZ6jNzj/MNtI0UKFWGv4E6ZTTDyF/6hZgls7QT3XrjloREOPQfU1bxEtg0crnVrNz9s8gWeXxRb+7mrSGgeSi9RXpYSsXIRsTIObOylDr43v0uCzVEfjoUGbxKHVwVCQIgX/147P38i8ojMm5eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731936606; c=relaxed/simple;
	bh=h8E3XGwGf8Uv12+a5xl7Q4v+BS4bfiH6JeqoQuMihDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7id4Yl25jSngdIPkP2N/FqcBbd3sXkHvQmLWQ64+D1Vn6gr+N7WWk9JcI0a63EOOskVZRwYje+yz4gMq9pQ1XV6T7h7cbsKezbd0GLvcMc5LVGDkA7uMQSn/TsWfsKo3iJ07MTtX0ItodFCDEyAyMOUINgh7XyMBS3UtvZEQAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M/ngxECh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a95sVnsn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Nov 2024 14:30:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731936603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gdp1Rtxc9PEUP5heedus1j1hdEvisZN8YoWM7EXyiJE=;
	b=M/ngxEChDmJTiuDkjTKzwhfU8vnHdJZVMfxrDHIbDhJZ8BwrEb5oEI2BybcfLaS3hfCCa6
	ZbGV987+j7zoW3hZTy2sVi79FnaYMCBEshtxI/Ppb+yNPWrJjKQ4y8Jn2Ec3CoExp0XJN9
	Kf85amQcDXcKiD8kgVbP0MlnJpRBNWWJLnVEvF2PinOvs/Elw9nnYUqZybHEKcjEjey0DE
	VrPVUBdFaiDK7dk96P4fS2IN4g3bAEJczISf/dYH78eqdk3sSEXRe4rGi2dnzsGqQbUiJz
	KlziQ2uUcUjHPyJpiicvnw9ZjTV6i0dZnyJBoSSh/SyyYj6wP9R4w1j2x9yFkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731936603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gdp1Rtxc9PEUP5heedus1j1hdEvisZN8YoWM7EXyiJE=;
	b=a95sVnsn9qDrlijQhulsf1xxr/x5izxxy2UaH0oq1rGw6xW7HxTIsCtsrNssdRNLo/BVC9
	g+lRLCpIHZZi+RCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	houtao1@huawei.com, xukuohai@huawei.com
Subject: Re: [PATCH bpf-next 07/10] bpf: Switch to bpf mem allocator for LPM
 trie
Message-ID: <20241118133002.Ev7Lo3kN@linutronix.de>
References: <20241118010808.2243555-1-houtao@huaweicloud.com>
 <20241118010808.2243555-8-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241118010808.2243555-8-houtao@huaweicloud.com>

On 2024-11-18 09:08:05 [+0800], Hou Tao wrote:
> diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
> index d447a6dab83b..d8995acecedf 100644
> --- a/kernel/bpf/lpm_trie.c
> +++ b/kernel/bpf/lpm_trie.c
> @@ -319,6 +326,25 @@ static int trie_check_noreplace_update(const struct lpm_trie *trie, u64 flags)
>  	return 0;
>  }
>  
> +static void lpm_trie_node_free(struct lpm_trie *trie,
> +			       struct lpm_trie_node *node, bool defer)
> +{
> +	struct bpf_mem_alloc *ma;
> +
> +	if (!node)
> +		return;
> +
> +	ma = (node->flags & LPM_TREE_NODE_FLAG_ALLOC_LEAF) ? trie->leaf_ma :
> +							     trie->im_ma;
> +
> +	migrate_disable();
> +	if (defer)
> +		bpf_mem_cache_free_rcu(ma, node);
> +	else
> +		bpf_mem_cache_free(ma, node);
> +	migrate_enable();

I guess a preempt_disable() here instead wouldn't hurt much. The inner
pieces of the allocator (unit_free()) does local_irq_save() for the
entire function so we don't win much with migrate_disable().

> +}
> +

Sebastian

