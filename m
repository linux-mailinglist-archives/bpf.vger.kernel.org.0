Return-Path: <bpf+bounces-18233-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE9E817A99
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 20:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 511341C21FBB
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 19:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D4C5D74F;
	Mon, 18 Dec 2023 19:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5YqmWcH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D0B53BF;
	Mon, 18 Dec 2023 19:06:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2AB9C433CA;
	Mon, 18 Dec 2023 19:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702926406;
	bh=Oj7Gm/7pBuv1oprC+a4gyIhGSXnfXjSzl+Q2UzH9PfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r5YqmWcHA0EErYG+wdUrVMo+G3NRUlAHHAaq8OYyMC+0aX3HzBieTQD+saJYkuXz8
	 8tVeyb80ImB6jhtI/nCc/Z9kQn/N2mRN7e1vDE5LoljMmYoR69+vqAXN1l42F15tJv
	 a8k2+RplvA3gsK98gcp0wfob+x0GP2P5SzBFh9Z+IYLdNg9RRtq2wmqwaOSQBPQXr0
	 6aWyqySgDEBIot96WJUo8TFNS+PW1e7qTruMg+rlru7oGH0qU8CsY51PH95b3w4QJA
	 md8wKk/oWSDg770HWrBq6f79Fd0ArFWxcevlh1fKJbMVseMl2yto9fneZ6aWJD194T
	 SIuvC5hdmrtMA==
Date: Mon, 18 Dec 2023 19:06:40 +0000
From: Simon Horman <horms@kernel.org>
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, coreteam@netfilter.org,
	netfilter-devel@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	ast@kernel.org
Subject: Re: [RFC nf-next v2 1/2] netfilter: bpf: support prog update
Message-ID: <20231218190640.GJ6288@kernel.org>
References: <1702873101-77522-1-git-send-email-alibuda@linux.alibaba.com>
 <1702873101-77522-2-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1702873101-77522-2-git-send-email-alibuda@linux.alibaba.com>

On Mon, Dec 18, 2023 at 12:18:20PM +0800, D. Wythe wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> To support the prog update, we need to ensure that the prog seen
> within the hook is always valid. Considering that hooks are always
> protected by rcu_read_lock(), which provide us the ability to
> access the prog under rcu.
> 
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>

...

> @@ -26,8 +17,20 @@ struct bpf_nf_link {
>  	struct net *net;
>  	u32 dead;
>  	const struct nf_defrag_hook *defrag_hook;
> +	struct rcu_head head;
>  };
>  
> +static unsigned int nf_hook_run_bpf(void *bpf_link, struct sk_buff *skb,
> +				    const struct nf_hook_state *s)
> +{
> +	const struct bpf_nf_link *nf_link = bpf_link;
> +	struct bpf_nf_ctx ctx = {
> +		.state = s,
> +		.skb = skb,
> +	};
> +	return bpf_prog_run(rcu_dereference(nf_link->link.prog), &ctx);

Hi,

AFAICT nf_link->link.prog isn't annotated as __rcu,
so perhaps rcu_dereference() is not correct here?

In any case, sparse seems a bit unhappy:

  .../nf_bpf_link.c:31:29: error: incompatible types in comparison expression (different address spaces):
  .../nf_bpf_link.c:31:29:    struct bpf_prog [noderef] __rcu *
  .../nf_bpf_link.c:31:29:    struct bpf_prog *

> +}
> +
>  #if IS_ENABLED(CONFIG_NF_DEFRAG_IPV4) || IS_ENABLED(CONFIG_NF_DEFRAG_IPV6)
>  static const struct nf_defrag_hook *
>  get_proto_defrag_hook(struct bpf_nf_link *link,

...

