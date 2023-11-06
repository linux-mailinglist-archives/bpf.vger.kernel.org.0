Return-Path: <bpf+bounces-14299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9477E2ADF
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 18:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD55BB211C7
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 17:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654EA29CF9;
	Mon,  6 Nov 2023 17:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QroTw1TC"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F3329D04
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 17:22:02 +0000 (UTC)
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630C5B0
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 09:22:01 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1cc42d3f61eso38122255ad.3
        for <bpf@vger.kernel.org>; Mon, 06 Nov 2023 09:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699291321; x=1699896121; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UsGIrvGQPvl+jlrIkAaumx9ydFi19GX+URg2DQaDyt0=;
        b=QroTw1TCYpKaU2zf2BoUoOGl3QGEocIa0dQcRbSBEzPv3kZEyA5S2q/AONx8+nAEwS
         9cQ+HRrpkQKb7qz7Vm7PbVHzYb+vx7zOkh0Su1QwlMBF7tEyuqVj9pM/rmmC1tyO5IZa
         A2vTe2D15J8wXwxc+Pxcgo/snbx8PqoIboIQNt4FX1nALmWZmU/0pHePgjC3W9LReWWd
         U3L+QEnI8e9lwWr2bJra2AkiZxxaHEuJ8U/TxWDAx2JjobhFIg2vsLt/GFh3b7gc6kMc
         sKWCWFjHEC+nBRsWzo6Ixtzq5Ocnud/GSEHgI5GBp1wWrBZP7kz6S4TPlvbMimpgWn6L
         LqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699291321; x=1699896121;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UsGIrvGQPvl+jlrIkAaumx9ydFi19GX+URg2DQaDyt0=;
        b=k6QdqZI3CTon1+NIuOR/j2pHZquAzQ2P+SXERxo4LtwbuYFMzx1IRmj8lIN/z6JTeA
         nn2HX0saPZB+hsEiHC00URmYqTjdpN6vhYsOvIKNbBv6XYAvv4L26vf9Mt1m3+N0rc+f
         ny1foO13/RvzavAYw5Eu1NHhOOK/1UzcYcrYX2NjIVl+SV/6TXft1H27lMG87rQjZJY+
         yf2gto4AZuY9+l2qhPYRVfc4GhuC5AajwL0troxOg0OplhyyU9gGOPlQn+HAQdr7IG5j
         RzPopDKvz8r5sywT6zAtzzidjKdfurJDiwmQSAEu+qHuXUNGCzxF0f6DqwlKepKVh6BB
         yNlg==
X-Gm-Message-State: AOJu0YwMqhrbCMmeAoM5L4Xwv+zErFgG1nQvkOHUgoH+Fme5ydv4BKkl
	6NirUUNoo2f0exKIxHdLFuLl/Ss=
X-Google-Smtp-Source: AGHT+IGJ5W4iTr1qlF8r5K7jfABNdTMHeWikykBWHeDpfCRGrHjKKtt9ryQ2DAdtxVSnmN4+LQs7mlc=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:f7c3:b0:1cc:29fb:f398 with SMTP id
 h3-20020a170902f7c300b001cc29fbf398mr554881plw.10.1699291320856; Mon, 06 Nov
 2023 09:22:00 -0800 (PST)
Date: Mon, 6 Nov 2023 09:21:59 -0800
In-Reply-To: <20231103222748.12551-5-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231103222748.12551-1-daniel@iogearbox.net> <20231103222748.12551-5-daniel@iogearbox.net>
Message-ID: <ZUkgtxlK9MRGHx8v@google.com>
Subject: Re: [PATCH bpf 4/6] bpf, netkit: Add indirect call wrapper for
 fetching peer dev
From: Stanislav Fomichev <sdf@google.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: martin.lau@kernel.org, kuba@kernel.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>
Content-Type: text/plain; charset="utf-8"

On 11/03, Daniel Borkmann wrote:
> ndo_get_peer_dev is used in tcx BPF fast path, therefore make use of
> indirect call wrapper and therefore optimize the bpf_redirect_peer()
> internal handling a bit. Add a small skb_get_peer_dev() wrapper which
> utilizes the INDIRECT_CALL_1() macro instead of open coding.
> 
> Co-developed-by: Nikolay Aleksandrov <razor@blackwall.org>
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  drivers/net/netkit.c |  3 ++-
>  include/net/netkit.h |  6 ++++++
>  net/core/filter.c    | 18 +++++++++++++-----
>  3 files changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
> index dc51c23b40f0..934c71a73b5c 100644
> --- a/drivers/net/netkit.c
> +++ b/drivers/net/netkit.c
> @@ -7,6 +7,7 @@
>  #include <linux/filter.h>
>  #include <linux/netfilter_netdev.h>
>  #include <linux/bpf_mprog.h>
> +#include <linux/indirect_call_wrapper.h>
>  
>  #include <net/netkit.h>
>  #include <net/dst.h>
> @@ -177,7 +178,7 @@ static void netkit_set_headroom(struct net_device *dev, int headroom)
>  	rcu_read_unlock();
>  }
>  
> -static struct net_device *netkit_peer_dev(struct net_device *dev)
> +INDIRECT_CALLABLE_SCOPE struct net_device *netkit_peer_dev(struct net_device *dev)
>  {
>  	return rcu_dereference(netkit_priv(dev)->peer);
>  }
> diff --git a/include/net/netkit.h b/include/net/netkit.h
> index 0ba2e6b847ca..9ec0163739f4 100644
> --- a/include/net/netkit.h
> +++ b/include/net/netkit.h
> @@ -10,6 +10,7 @@ int netkit_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog);
>  int netkit_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
>  int netkit_prog_detach(const union bpf_attr *attr, struct bpf_prog *prog);
>  int netkit_prog_query(const union bpf_attr *attr, union bpf_attr __user *uattr);
> +INDIRECT_CALLABLE_DECLARE(struct net_device *netkit_peer_dev(struct net_device *dev));
>  #else
>  static inline int netkit_prog_attach(const union bpf_attr *attr,
>  				     struct bpf_prog *prog)
> @@ -34,5 +35,10 @@ static inline int netkit_prog_query(const union bpf_attr *attr,
>  {
>  	return -EINVAL;
>  }
> +
> +static inline struct net_device *netkit_peer_dev(struct net_device *dev)
> +{
> +	return NULL;
> +}
>  #endif /* CONFIG_NETKIT */
>  #endif /* __NET_NETKIT_H */
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 7aca28b7d0fd..dbf92b272022 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -81,6 +81,7 @@
>  #include <net/xdp.h>
>  #include <net/mptcp.h>
>  #include <net/netfilter/nf_conntrack_bpf.h>
> +#include <net/netkit.h>
>  #include <linux/un.h>
>  
>  #include "dev.h"
> @@ -2468,6 +2469,16 @@ static const struct bpf_func_proto bpf_clone_redirect_proto = {
>  DEFINE_PER_CPU(struct bpf_redirect_info, bpf_redirect_info);
>  EXPORT_PER_CPU_SYMBOL_GPL(bpf_redirect_info);
>  
> +static struct net_device *skb_get_peer_dev(struct net_device *dev)
> +{
> +	const struct net_device_ops *ops = dev->netdev_ops;
> +
> +	if (likely(ops->ndo_get_peer_dev))
> +		return INDIRECT_CALL_1(ops->ndo_get_peer_dev,
> +				       netkit_peer_dev, dev);

nit: why not put both netkit and veth here under INDIRECT_CALL_2 ?
Presumably should help with the veth deployments as well?

