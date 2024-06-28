Return-Path: <bpf+bounces-33378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AD191C895
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 23:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9990E1F2220C
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 21:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BD680624;
	Fri, 28 Jun 2024 21:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="HOrgHLqA"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013FD7FBB7;
	Fri, 28 Jun 2024 21:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719611496; cv=none; b=QoNB7CpD1fFSzj4YA1Yha3UpdshnvFH2CUHok0VLv2zEIkP4Zk3QQTX8WkNYntBv0j3wURhnRskx6DFPwxtAeRoXQBkwrQZYHEqU3rBzDgfyUcfKK9vD1uWpUG4+6KkV0kP/feIe0/UKSTYxOH6ylBmGJtPEGyG2FhtzjWl1d78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719611496; c=relaxed/simple;
	bh=HsRrLEef53TP83+xh0ZPzK0w+8F2dvYC3ETT8nNxPJk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=uaczTbQ8B5Xw73qFytskXieGL+jZmkjsR6s3wOZNCl5fJbY9PPp70xJzRD/oUb2g7615lsYbf+H+mZ41n8JOaJGYyg1mx04g+ibcB1SdG5a/uH52TPlItO8QHGLW766761Dharh5REGBIQPJeFOFL7NuS9UBegSkSZwJwo5W9HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=HOrgHLqA; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=VZl4+lvTPgtmR0/DlzZj+Qdr0lXMBGH1rs24nSlVams=; b=HOrgHLqAI1+Ku0LToV5YwfPB/t
	/EGK/vcjjHMy2UYO0iqqeVsMk+8nqvRboVVwxE5c1uAFfLTvbPuYMVxgid+eVp9a/EdyMwFzGWxzl
	gtKbSUKwmaUTVY5pdOR0YFlEkQkKh3SUxyXd9wMia4V0rQYkyuJttGCPyOnowS5nDOgT1l7MQyh6C
	Vug1Ei42Y01ux73v+ev7aThgYY9DwXrEcFjLdRAYWrLYVG7CtYpbA5JRv7bTZP+4ulhz26xuptPMl
	mva/Oapms2XlNdRmPkYwEct8xSea1XpgxrB9EUScCsBjqDxNVQxTuGv2wj1VwAu2gv8sbAqaCbFI0
	221ALWrA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sNJ1j-000JW3-5a; Fri, 28 Jun 2024 23:21:03 +0200
Received: from [178.197.249.38] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sNJ1i-000BNB-1v;
	Fri, 28 Jun 2024 23:21:02 +0200
Subject: Re: [PATCH v5 bpf-next 2/3] netfilter: add bpf_xdp_flow_lookup kfunc
To: Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org
Cc: pablo@netfilter.org, kadlec@netfilter.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 lorenzo.bianconi@redhat.com, toke@redhat.com, fw@strlen.de, hawk@kernel.org,
 horms@kernel.org, donhunte@redhat.com, memxor@gmail.com
References: <cover.1718379122.git.lorenzo@kernel.org>
 <101e390e62edf8199db8f7cc4df79817b6741f59.1718379122.git.lorenzo@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <48b18dc0-19bd-441e-5054-4bd545cd1561@iogearbox.net>
Date: Fri, 28 Jun 2024 23:21:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <101e390e62edf8199db8f7cc4df79817b6741f59.1718379122.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27320/Fri Jun 28 10:37:18 2024)

On 6/14/24 5:40 PM, Lorenzo Bianconi wrote:
[...]
> +enum {
> +	NF_BPF_FLOWTABLE_OPTS_SZ = 4,
> +};
> +
> +__diag_push();
> +__diag_ignore_all("-Wmissing-prototypes",
> +		  "Global functions as their definitions will be in nf_flow_table BTF");

nit: __bpf_kfunc_start_defs();

> +static struct flow_offload_tuple_rhash *
> +bpf_xdp_flow_tuple_lookup(struct net_device *dev,
> +			  struct flow_offload_tuple *tuple, __be16 proto)
> +{
> +	struct flow_offload_tuple_rhash *tuplehash;
> +	struct nf_flowtable *nf_flow_table;
> +	struct flow_offload *nf_flow;
> +
> +	nf_flow_table = nf_flowtable_by_dev(dev);
> +	if (!nf_flow_table)
> +		return ERR_PTR(-ENOENT);
> +
> +	tuplehash = flow_offload_lookup(nf_flow_table, tuple);
> +	if (!tuplehash)
> +		return ERR_PTR(-ENOENT);
> +
> +	nf_flow = container_of(tuplehash, struct flow_offload,
> +			       tuplehash[tuplehash->tuple.dir]);
> +	flow_offload_refresh(nf_flow_table, nf_flow, false);
> +
> +	return tuplehash;
> +}
> +
> +__bpf_kfunc struct flow_offload_tuple_rhash *
> +bpf_xdp_flow_lookup(struct xdp_md *ctx, struct bpf_fib_lookup *fib_tuple,
> +		    struct bpf_flowtable_opts *opts, u32 opts_len)
> +{
> +	struct xdp_buff *xdp = (struct xdp_buff *)ctx;
> +	struct flow_offload_tuple tuple = {
> +		.iifidx = fib_tuple->ifindex,
> +		.l3proto = fib_tuple->family,
> +		.l4proto = fib_tuple->l4_protocol,
> +		.src_port = fib_tuple->sport,
> +		.dst_port = fib_tuple->dport,
> +	};
> +	struct flow_offload_tuple_rhash *tuplehash;
> +	__be16 proto;
> +
> +	if (opts_len != NF_BPF_FLOWTABLE_OPTS_SZ) {
> +		opts->error = -EINVAL;
> +		return NULL;
> +	}
> +
> +	switch (fib_tuple->family) {
> +	case AF_INET:
> +		tuple.src_v4.s_addr = fib_tuple->ipv4_src;
> +		tuple.dst_v4.s_addr = fib_tuple->ipv4_dst;
> +		proto = htons(ETH_P_IP);
> +		break;
> +	case AF_INET6:
> +		tuple.src_v6 = *(struct in6_addr *)&fib_tuple->ipv6_src;
> +		tuple.dst_v6 = *(struct in6_addr *)&fib_tuple->ipv6_dst;
> +		proto = htons(ETH_P_IPV6);
> +		break;
> +	default:
> +		opts->error = -EAFNOSUPPORT;
> +		return NULL;
> +	}
> +
> +	tuplehash = bpf_xdp_flow_tuple_lookup(xdp->rxq->dev, &tuple, proto);
> +	if (IS_ERR(tuplehash)) {
> +		opts->error = PTR_ERR(tuplehash);
> +		return NULL;
> +	}
> +
> +	return tuplehash;
> +}
> +
> +__diag_pop()

__bpf_kfunc_end_defs();

Otherwise LGTM!

