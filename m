Return-Path: <bpf+bounces-33376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 939DB91C804
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 23:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 009F11F22AA3
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 21:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24247D41D;
	Fri, 28 Jun 2024 21:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="paQI/crL"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B791C6A4;
	Fri, 28 Jun 2024 21:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719609564; cv=none; b=PtDUp3e9H0sfwgAMEdWp8MNGNxM5MTj+iQI315AIsE0nXYtzxe1NLTeZ496ZxnAEdyiCdtDYH5AaxPMQktPKZJb/KSEO8WU5SPY520Sum25gnjc3bt8fPd26yNPPA7KmnCSC+hTUnk8miuXVBE155r9DkUmjKrIOVmCyGCfHFw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719609564; c=relaxed/simple;
	bh=ge1yIoG7ZHxCiPS9ePEOh9LArlpdmPzC0Ftt/Qa3/BU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=V34dD4mg5Ti2ZQxC81rRiey6TWmoRzM6ozM5fqledvHBAOy24XR24RxKs/yd7c4zQdo3N4bmNk8GY+4nBiWw/OSJEJ02wQLRK8IpBe+BoV1WW1Am87yW9AQT3R4D+VW2DKiaQvHaaWHOwZh3fgB+c7rOgHFRiZy6XiIU2FcKTzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=paQI/crL; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=5MkI8Bp/RWvcIRDsdO+uzOTH8hiuQq6PeoTgh2pR4vo=; b=paQI/crLyFET4Aiu18WEJf2mge
	XIgm/ttaEYpeSyOxWI3c3dI+UK9atjr8nZe7BDYIbROm6Ai7hARxEDvEiK+BNN9V/VqJxJt+dh2p/
	Rr3OU36aQh2qC2OAADUIzP42SOpZXWmJL7LtDmMjtjjquHA87wiw/zjxkxlerJNliJzPuyvPcGFE1
	n5yxGZXH507lEr7YC+56B7+L79gzcG9MtfGSDWENjU/YDYdt8M/gh1QDh/KzCHXSiXN+yHRf3HoaJ
	6+lwhHAFx7lWjybvwUL3e/w0hyopmFlf71vEQzKTaZiNiKtGfWOAP5mXHmVAAGyNdoBpkoj0okAjy
	t6KX1L1w==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sNJ01-000JNM-JJ; Fri, 28 Jun 2024 23:19:17 +0200
Received: from [178.197.249.38] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sNJ00-0004A2-35;
	Fri, 28 Jun 2024 23:19:16 +0200
Subject: Re: [PATCH v5 bpf-next 1/3] netfilter: nf_tables: add flowtable map
 for xdp offload
To: Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org
Cc: pablo@netfilter.org, kadlec@netfilter.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 lorenzo.bianconi@redhat.com, toke@redhat.com, fw@strlen.de, hawk@kernel.org,
 horms@kernel.org, donhunte@redhat.com, memxor@gmail.com
References: <cover.1718379122.git.lorenzo@kernel.org>
 <d32ace9a34be6196313a9c24e0c52df979c507c3.1718379122.git.lorenzo@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <793fd9a3-0562-1edd-e2b4-f88fa81d876d@iogearbox.net>
Date: Fri, 28 Jun 2024 23:19:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d32ace9a34be6196313a9c24e0c52df979c507c3.1718379122.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27320/Fri Jun 28 10:37:18 2024)

On 6/14/24 5:40 PM, Lorenzo Bianconi wrote:
[...]
> diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
> index a010b25076ca0..d9b019c98694b 100644
> --- a/net/netfilter/nf_flow_table_offload.c
> +++ b/net/netfilter/nf_flow_table_offload.c
> @@ -1192,7 +1192,7 @@ int nf_flow_table_offload_setup(struct nf_flowtable *flowtable,
>   	int err;
>   
>   	if (!nf_flowtable_hw_offload(flowtable))
> -		return 0;
> +		return nf_flow_offload_xdp_setup(flowtable, dev, cmd);
>   
>   	if (dev->netdev_ops->ndo_setup_tc)
>   		err = nf_flow_table_offload_cmd(&bo, flowtable, dev, cmd,
> @@ -1200,8 +1200,10 @@ int nf_flow_table_offload_setup(struct nf_flowtable *flowtable,
>   	else
>   		err = nf_flow_table_indr_offload_cmd(&bo, flowtable, dev, cmd,
>   						     &extack);
> -	if (err < 0)
> +	if (err < 0) {
> +		nf_flow_offload_xdp_cancel(flowtable, dev, cmd);
>   		return err;
> +	}
>   
>   	return nf_flow_table_block_setup(flowtable, &bo, cmd);
>   }
> diff --git a/net/netfilter/nf_flow_table_xdp.c b/net/netfilter/nf_flow_table_xdp.c
> new file mode 100644
> index 0000000000000..b9bdf27ba9bd3
> --- /dev/null
> +++ b/net/netfilter/nf_flow_table_xdp.c
> @@ -0,0 +1,163 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/netfilter.h>
> +#include <linux/rhashtable.h>
> +#include <linux/netdevice.h>
> +#include <net/flow_offload.h>
> +#include <net/netfilter/nf_flow_table.h>
> +
> +struct flow_offload_xdp_ft {
> +	struct list_head head;
> +	struct nf_flowtable *ft;
> +	struct rcu_head rcuhead;
> +};
> +
> +struct flow_offload_xdp {
> +	struct hlist_node hnode;
> +	unsigned long net_device_addr;
> +	struct list_head head;
> +};
> +
> +#define NF_XDP_HT_BITS	4
> +static DEFINE_HASHTABLE(nf_xdp_hashtable, NF_XDP_HT_BITS);
> +static DEFINE_MUTEX(nf_xdp_hashtable_lock);
> +
> +/* caller must hold rcu read lock */
> +struct nf_flowtable *nf_flowtable_by_dev(const struct net_device *dev)
> +{
> +	unsigned long key = (unsigned long)dev;
> +	struct flow_offload_xdp *iter;
> +
> +	hash_for_each_possible_rcu(nf_xdp_hashtable, iter, hnode, key) {
> +		if (key == iter->net_device_addr) {
> +			struct flow_offload_xdp_ft *ft_elem;
> +
> +			/* The user is supposed to insert a given net_device
> +			 * just into a single nf_flowtable so we always return
> +			 * the first element here.
> +			 */
> +			ft_elem = list_first_or_null_rcu(&iter->head,
> +							 struct flow_offload_xdp_ft,
> +							 head);
> +			return ft_elem ? ft_elem->ft : NULL;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +static int nf_flowtable_by_dev_insert(struct nf_flowtable *ft,
> +				      const struct net_device *dev)
> +{
> +	struct flow_offload_xdp *iter, *elem = NULL;
> +	unsigned long key = (unsigned long)dev;
> +	struct flow_offload_xdp_ft *ft_elem;
> +
> +	ft_elem = kzalloc(sizeof(*ft_elem), GFP_KERNEL_ACCOUNT);
> +	if (!ft_elem)
> +		return -ENOMEM;
> +
> +	ft_elem->ft = ft;
> +
> +	mutex_lock(&nf_xdp_hashtable_lock);
> +
> +	hash_for_each_possible(nf_xdp_hashtable, iter, hnode, key) {
> +		if (key == iter->net_device_addr) {
> +			elem = iter;
> +			break;
> +		}
> +	}
> +
> +	if (!elem) {
> +		elem = kzalloc(sizeof(*elem), GFP_KERNEL_ACCOUNT);
> +		if (!elem)
> +			goto err_unlock;
> +
> +		elem->net_device_addr = key;

Looks good, as I understand (but just to double check) if a device goes away then
upper layers in the nf flowtable code will trigger the nf_flowtable_by_dev_remove()
based on the device pointer to clean this up again from nf_xdp_hashtable.

> +		INIT_LIST_HEAD(&elem->head);
> +		hash_add_rcu(nf_xdp_hashtable, &elem->hnode, key);
> +	}
> +	list_add_tail_rcu(&ft_elem->head, &elem->head);
> +
> +	mutex_unlock(&nf_xdp_hashtable_lock);
> +
> +	return 0;
> +
> +err_unlock:
> +	mutex_unlock(&nf_xdp_hashtable_lock);
> +	kfree(ft_elem);
> +
> +	return -ENOMEM;
> +}

