Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8D849873F
	for <lists+bpf@lfdr.de>; Mon, 24 Jan 2022 18:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244332AbiAXRvE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Jan 2022 12:51:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:40768 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241600AbiAXRvD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 24 Jan 2022 12:51:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643046663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XXLqqvkl2WnqmUcF9sdvORyv1rSQivT9oTXnBtAWkms=;
        b=igKjfbeFS/7Om9ZawY5ZxOoNlvyOAuogbQQ+d77vAU+SOTr3vsrJU4r0cHMGn4CoVyyGx8
        59FVZ9Ioj2FaYrvugMGOfCZHytQCWl4AsAJrA54RHzyT6RcvoNi6SNVnV6Ksb6BEiR0yIe
        HE0jqCZ4p+1kL9+AIy6xLH2kHkHF0oc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-8fGjkjw5MhKgbxO3L0_3pA-1; Mon, 24 Jan 2022 12:51:01 -0500
X-MC-Unique: 8fGjkjw5MhKgbxO3L0_3pA-1
Received: by mail-ej1-f70.google.com with SMTP id l18-20020a1709063d3200b006a93f7d4941so2406355ejf.1
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 09:51:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=XXLqqvkl2WnqmUcF9sdvORyv1rSQivT9oTXnBtAWkms=;
        b=K3ZHSaeGPU1TM4z3vZaKkAfM4gEo9xg1gh7/XesNoL6YB0dz/6gDfQ7/KrMUwintVW
         GCOFl2lZOWvIIWiSL1XrXwU/7Mj81myQ4b7czR6BlEzfJre8RkG7QTE23RZsLhhv4DXu
         9ThX5Q/PnmkBWXTYUuGWaJy2M0QazT6/bOGogFx1X3PEwm/ck/TZ+DUWLkRZhMa7VONP
         QkNETr6bD2pdd1g7XOto7PRycIntGAaCpjb2DSY79cI2IlWqJfI3knrLm9yRVME4lv5n
         ylJt5QE4aJjdPpmkOaPhuWVq0OEGjWrxUG9r484BhuNqZkQUuY6A9YnWDfupm89Jg3cH
         JpSA==
X-Gm-Message-State: AOAM530Un4ZUPIqYhQfUOslHhnJuaKFSfgR5ONwdxeebObhtQ7KN26+2
        9KqFvPuUA7l3TOUVU38fiMCfYiezJgKO4Y13A2oJNjhygG4eEFOnp/lyKN/iDd9o/I0vOss2Goa
        m/8hz6R91U9sO
X-Received: by 2002:a17:907:2d0c:: with SMTP id gs12mr7135611ejc.165.1643046659495;
        Mon, 24 Jan 2022 09:50:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz0qQQWkHXyLNHj6NIOtHYXa1eK6SAY2pgvS4o4LZPiCL9JJ6OVR8m+3n0gl8QXjd1lfyecBw==
X-Received: by 2002:a17:907:2d0c:: with SMTP id gs12mr7135554ejc.165.1643046658452;
        Mon, 24 Jan 2022 09:50:58 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id f3sm5160783eja.139.2022.01.24.09.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 09:50:57 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 4395D1805FB; Mon, 24 Jan 2022 18:50:57 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, dsahern@kernel.org,
        komachi.yoshiki@gmail.com, brouer@redhat.com, memxor@gmail.com,
        andrii.nakryiko@gmail.com
Subject: Re: [RFC bpf-next 1/2] net: bridge: add unstable
 br_fdb_find_port_from_ifindex helper
In-Reply-To: <720907692575488526f06edc2cf5c8f783777d4f.1643044381.git.lorenzo@kernel.org>
References: <cover.1643044381.git.lorenzo@kernel.org>
 <720907692575488526f06edc2cf5c8f783777d4f.1643044381.git.lorenzo@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 24 Jan 2022 18:50:57 +0100
Message-ID: <878rv558fy.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

[ snip to focus on the API ]

> +int br_fdb_find_port_from_ifindex(struct xdp_md *xdp_ctx,
> +				  struct bpf_fdb_lookup *opt,
> +				  u32 opt__sz)
> +{
> +	struct xdp_buff *ctx = (struct xdp_buff *)xdp_ctx;
> +	struct net_bridge_port *port;
> +	struct net_device *dev;
> +	int ret = -ENODEV;
> +
> +	BUILD_BUG_ON(sizeof(struct bpf_fdb_lookup) != NF_BPF_FDB_OPTS_SZ);
> +	if (!opt || opt__sz != sizeof(struct bpf_fdb_lookup))
> +		return -ENODEV;

Why is the BUILD_BUG_ON needed? Or why is the NF_BPF_FDB_OPTS_SZ
constant even needed?

> +	rcu_read_lock();

This is not needed when the function is only being called from XDP...

> +
> +	dev = dev_get_by_index_rcu(dev_net(ctx->rxq->dev), opt->ifindex);
> +	if (!dev)
> +		goto out;
> +
> +	if (unlikely(!netif_is_bridge_port(dev)))
> +		goto out;
> +
> +	port = br_port_get_check_rcu(dev);
> +	if (unlikely(!port || !port->br))
> +		goto out;
> +
> +	dev = __br_fdb_find_port(port->br->dev, opt->addr, opt->vid, true);
> +	if (dev)
> +		ret = dev->ifindex;
> +out:
> +	rcu_read_unlock();
> +
> +	return ret;
> +}
> +
>  struct net_bridge_fdb_entry *br_fdb_find_rcu(struct net_bridge *br,
>  					     const unsigned char *addr,
>  					     __u16 vid)
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 2661dda1a92b..64d4f1727da2 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -18,6 +18,7 @@
>  #include <linux/if_vlan.h>
>  #include <linux/rhashtable.h>
>  #include <linux/refcount.h>
> +#include <linux/bpf.h>
>  
>  #define BR_HASH_BITS 8
>  #define BR_HASH_SIZE (1 << BR_HASH_BITS)
> @@ -2094,4 +2095,15 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
>  void br_do_suppress_nd(struct sk_buff *skb, struct net_bridge *br,
>  		       u16 vid, struct net_bridge_port *p, struct nd_msg *msg);
>  struct nd_msg *br_is_nd_neigh_msg(struct sk_buff *skb, struct nd_msg *m);
> +
> +#define NF_BPF_FDB_OPTS_SZ	12
> +struct bpf_fdb_lookup {
> +	u8	addr[ETH_ALEN]; /* ETH_ALEN */
> +	u16	vid;
> +	u32	ifindex;
> +};

It seems like addr and ifindex should always be required, right? So why
not make them regular function args? That way the ptr to eth addr could
be a ptr directly to the packet header (saving a memcpy), and the common
case(?) could just pass a NULL opts struct?

> +int br_fdb_find_port_from_ifindex(struct xdp_md *xdp_ctx,
> +				  struct bpf_fdb_lookup *opt,
> +				  u32 opt__sz);

It should probably be documented that the return value is an ifindex as
well; I guess one of the drawbacks of kfunc's relative to regular
helpers is that there is no convention for how to document their usage -
maybe we should fix that before we get too many of them? :)

-Toke

