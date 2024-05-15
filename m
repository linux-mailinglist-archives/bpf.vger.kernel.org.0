Return-Path: <bpf+bounces-29808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6478C6E20
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 00:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27245B22FB6
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 22:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB7315B56F;
	Wed, 15 May 2024 22:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJ4IXAgO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092E83BBEA;
	Wed, 15 May 2024 22:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715810405; cv=none; b=nvmkP3ezJnoJ8VypsWVKRULny9D+2dWVOmgE/okcJd8l/Kxdvnj2oFL13/GSet1GXC+B4xSXQYEJUun4VrzIohkBWXoPVV4jHZoeOKrsZL2LNlh/8M43zwxylu498n/K6uSugXuDFro5lx5d5koY02og9IM0js7z9O0FSjqj4nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715810405; c=relaxed/simple;
	bh=hA/aGq35Rjzszj4oH64PmYa2Z4m37f9xNIvrtpKx2FM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cIsfzD0pSK49yEquc1opngnjyS5cTKlE6Rx2uch/sEPAl+hd8UxaqhKN3D0Y8KTGpGu3EwDdWIrrwcUTBYtnKjtqVdKx2bu9MvGxmnfqJkWP/P0niNEjhvpQaprIHg9zU9sO2tYB1usT+RtWtWofQdN/Qaa7Fr0Ab8Exk3Q1sLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJ4IXAgO; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-572f6ee87c1so2195599a12.2;
        Wed, 15 May 2024 15:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715810402; x=1716415202; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nd5sYUKhc830SPcchQEmWoYzsYZzZrwOm5i7M/deN+0=;
        b=SJ4IXAgOPWPhTzGgYAW3/wqEYXczVsIBqdHes/qPsO8XTeIInIhQzpqxbifCtzA81O
         5qiixryz50rvHiBCvSqWmxxv01DAGKbrIL3YJqTzO50hw5q7mXMBW8KsN/ShBZQnxsV+
         7GsMYxbaFcPXnARj997bFEzIIotJ8Ys9B1IEYgbrrLi960t2EP9yQvB+fZmsj2fqJXiI
         bdH4DMzBelMzaJNwX7lQlxKB+yUotzpsPVRYR2kzays0nVeXY6kmSYxv4SE/L/a+/IxB
         mr4jn3oYQLwGeij/7zvGv1rmfT8d5748DkUbjUjQApcR6ldeCuWuSlQ0EjWTecahun/U
         qctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715810402; x=1716415202;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nd5sYUKhc830SPcchQEmWoYzsYZzZrwOm5i7M/deN+0=;
        b=U5v+UYYZ0IAZbxUYbhOfxl+fEjzKhoJj4/Agt/Kd8UQx/Cy2mgs0x+eJ+ooKQH5ZV9
         U2wlZHOupL/ef6tUT8BLJkitVqmXFNhOrcmnyqBExIXiUoGkw8raNynsZdQlT/p5uVd8
         UAi3ykPk2H6DA7RXeR/Gnnu2TZKS7jLm5za5Q6IjexyFyo68RkQyHH3pSG3GhZ9peW0n
         xaqpOBzKDNRdxPX5IzTDZTwlKBTWJqbubCFYqCylDxt3MKGFNIkhX58aOYkwZ2WDvn3g
         OpfV+sIXv8x6Z8CBHzKXjWyfrRKX840moNKzJP674pBoxNVzEQqIaY1416Fkrb/Ifwav
         Tdeg==
X-Forwarded-Encrypted: i=1; AJvYcCVsXQriIZv+Cxe97HRFfOoOxkCCAsb6ydUt1qJjt0ny2deP0sAm2g2shc4vM4dWl7A7gZZDFZwAgyadPibioYo6HxJrlR3j5JpjbVsRihverfo66cMvurdXshYendHbuwqbXVLUQzK3
X-Gm-Message-State: AOJu0YyWxp+5taV53QYbc0yi15jzSeOGSXeaZLOQt6i2B0ZYNDNiViuN
	G72m13uVexnPfLlp5W1DeW9FdHLWMn3j+ZX7A170Vxv96NtSbjOieVMtHa3PAs3Z7s4aZayFqD9
	RwPveZcLldZF7qH29/HoQgpF2atE=
X-Google-Smtp-Source: AGHT+IHa6/R5ne74PwKld0AAGaO/RcRRSb3Z5X4wZHPam3D53IdHkgdiikOyk6gohJKwotT3lzT6Umk2bckqsxvNZSw=
X-Received: by 2002:a50:ed0d:0:b0:574:eba7:473f with SMTP id
 4fb4d7f45d1cf-574eba75099mr3923230a12.3.1715810402100; Wed, 15 May 2024
 15:00:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1715807303.git.lorenzo@kernel.org> <c87caa37757cdf6e323c89748fd0a0408fd47da2.1715807303.git.lorenzo@kernel.org>
In-Reply-To: <c87caa37757cdf6e323c89748fd0a0408fd47da2.1715807303.git.lorenzo@kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 15 May 2024 23:59:25 +0200
Message-ID: <CAP01T76razfX1e7BsMbbyecPF+RjtJYoZifR-Um_BAoyPNOyKg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] netfilter: add bpf_xdp_flow_offload_lookup kfunc
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: bpf@vger.kernel.org, pablo@netfilter.org, kadlec@netfilter.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, lorenzo.bianconi@redhat.com, 
	toke@redhat.com, fw@strlen.de, hawk@kernel.org, horms@kernel.org, 
	donhunte@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 May 2024 at 23:13, Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>
> Introduce bpf_xdp_flow_offload_lookup kfunc in order to perform the
> lookup of a given flowtable entry based on a fib tuple of incoming
> traffic.
> bpf_xdp_flow_offload_lookup can be used as building block to offload
> in xdp the processing of sw flowtable when hw flowtable is not
> available.
>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  include/net/netfilter/nf_flow_table.h | 10 +++
>  net/netfilter/Makefile                |  5 ++
>  net/netfilter/nf_flow_table_bpf.c     | 95 +++++++++++++++++++++++++++
>  net/netfilter/nf_flow_table_inet.c    |  2 +
>  4 files changed, 112 insertions(+)
>  create mode 100644 net/netfilter/nf_flow_table_bpf.c
>
> diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
> index 0bbe6ea8e0651..085660cbcd3f2 100644
> --- a/include/net/netfilter/nf_flow_table.h
> +++ b/include/net/netfilter/nf_flow_table.h
> @@ -312,6 +312,16 @@ unsigned int nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
>  unsigned int nf_flow_offload_ipv6_hook(void *priv, struct sk_buff *skb,
>                                        const struct nf_hook_state *state);
>
> +#if (IS_BUILTIN(CONFIG_NF_FLOW_TABLE) && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) || \
> +    (IS_MODULE(CONFIG_NF_FLOW_TABLE) && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES))
> +extern int nf_flow_offload_register_bpf(void);
> +#else
> +static inline int nf_flow_offload_register_bpf(void)
> +{
> +       return 0;
> +}
> +#endif
> +
>  #define MODULE_ALIAS_NF_FLOWTABLE(family)      \
>         MODULE_ALIAS("nf-flowtable-" __stringify(family))
>
> diff --git a/net/netfilter/Makefile b/net/netfilter/Makefile
> index 614815a3ed738..18b09cec92024 100644
> --- a/net/netfilter/Makefile
> +++ b/net/netfilter/Makefile
> @@ -144,6 +144,11 @@ obj-$(CONFIG_NF_FLOW_TABLE)        += nf_flow_table.o
>  nf_flow_table-objs             := nf_flow_table_core.o nf_flow_table_ip.o \
>                                    nf_flow_table_offload.o
>  nf_flow_table-$(CONFIG_NF_FLOW_TABLE_PROCFS) += nf_flow_table_procfs.o
> +ifeq ($(CONFIG_NF_FLOW_TABLE),m)
> +nf_flow_table-$(CONFIG_DEBUG_INFO_BTF_MODULES) += nf_flow_table_bpf.o
> +else ifeq ($(CONFIG_NF_FLOW_TABLE),y)
> +nf_flow_table-$(CONFIG_DEBUG_INFO_BTF) += nf_flow_table_bpf.o
> +endif
>
>  obj-$(CONFIG_NF_FLOW_TABLE_INET) += nf_flow_table_inet.o
>
> diff --git a/net/netfilter/nf_flow_table_bpf.c b/net/netfilter/nf_flow_table_bpf.c
> new file mode 100644
> index 0000000000000..836a1127e4052
> --- /dev/null
> +++ b/net/netfilter/nf_flow_table_bpf.c
> @@ -0,0 +1,95 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Unstable Flow Table Helpers for XDP hook
> + *
> + * These are called from the XDP programs.
> + * Note that it is allowed to break compatibility for these functions since
> + * the interface they are exposed through to BPF programs is explicitly
> + * unstable.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <net/netfilter/nf_flow_table.h>
> +#include <linux/bpf.h>
> +#include <linux/btf.h>
> +#include <net/xdp.h>
> +
> +__diag_push();
> +__diag_ignore_all("-Wmissing-prototypes",
> +                 "Global functions as their definitions will be in nf_flow_table BTF");
> +
> +static struct flow_offload_tuple_rhash *
> +bpf_xdp_flow_offload_tuple_lookup(struct net_device *dev,
> +                                 struct flow_offload_tuple *tuple,
> +                                 __be16 proto)
> +{
> +       struct flow_offload_tuple_rhash *tuplehash;
> +       struct nf_flowtable *flow_table;
> +       struct flow_offload *flow;
> +
> +       flow_table = nf_flowtable_by_dev(dev);
> +       if (!flow_table)
> +               return ERR_PTR(-ENOENT);
> +
> +       tuplehash = flow_offload_lookup(flow_table, tuple);
> +       if (!tuplehash)
> +               return ERR_PTR(-ENOENT);

This is fine to do, but the caller should catch it using IS_ERR_PTR
and return NULL.
BPF side cannot distinguish ERR_PTR from normal pointer, so this will
cause a bad deref in the program.

> +
> +       flow = container_of(tuplehash, struct flow_offload,
> +                           tuplehash[tuplehash->tuple.dir]);
> +       flow_offload_refresh(flow_table, flow, false);
> +
> +       return tuplehash;
> +}
> +
> +__bpf_kfunc struct flow_offload_tuple_rhash *
> +bpf_xdp_flow_offload_lookup(struct xdp_md *ctx,
> +                           struct bpf_fib_lookup *fib_tuple,
> +                           u32 fib_tuple__sz)

Do you think the __sz has the intended effect? It only works when the
preceding parameter is a void *.
If you have a type like struct bpf_fib_lookup, I think it should work
fine without taking a size at all.

> +{
> +       struct xdp_buff *xdp = (struct xdp_buff *)ctx;
> +       struct flow_offload_tuple tuple = {
> +               .iifidx = fib_tuple->ifindex,
> +               .l3proto = fib_tuple->family,
> +               .l4proto = fib_tuple->l4_protocol,
> +               .src_port = fib_tuple->sport,
> +               .dst_port = fib_tuple->dport,
> +       };
> +       __be16 proto;
> +
> +       switch (fib_tuple->family) {
> +       case AF_INET:
> +               tuple.src_v4.s_addr = fib_tuple->ipv4_src;
> +               tuple.dst_v4.s_addr = fib_tuple->ipv4_dst;
> +               proto = htons(ETH_P_IP);
> +               break;
> +       case AF_INET6:
> +               tuple.src_v6 = *(struct in6_addr *)&fib_tuple->ipv6_src;
> +               tuple.dst_v6 = *(struct in6_addr *)&fib_tuple->ipv6_dst;
> +               proto = htons(ETH_P_IPV6);
> +               break;
> +       default:
> +               return ERR_PTR(-EINVAL);

Likewise. While you check IS_ERR_VALUE in selftest, direct dereference
will be allowed by verifier, which would crash the kernel.
It's better to do something like conntrack kfuncs, where they set
opts->error when returning NULL, allowing better debugging in case
lookup fails.

> +       }
> +
> +       return bpf_xdp_flow_offload_tuple_lookup(xdp->rxq->dev, &tuple, proto);
> +}
> +
> +__diag_pop()
> +
> +BTF_KFUNCS_START(nf_ft_kfunc_set)
> +BTF_ID_FLAGS(func, bpf_xdp_flow_offload_lookup)
> +BTF_KFUNCS_END(nf_ft_kfunc_set)
> +
> +static const struct btf_kfunc_id_set nf_flow_offload_kfunc_set = {
> +       .owner = THIS_MODULE,
> +       .set   = &nf_ft_kfunc_set,
> +};
> +
> +int nf_flow_offload_register_bpf(void)
> +{
> +       return register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP,
> +                                        &nf_flow_offload_kfunc_set);
> +}

We should probably also expose it to skb? We just need net_device, so
it can work with both XDP and TC progs.
That would be similar to how we expose conntrack kfuncs to both XDP
and TC progs.

> +EXPORT_SYMBOL_GPL(nf_flow_offload_register_bpf);
> diff --git a/net/netfilter/nf_flow_table_inet.c b/net/netfilter/nf_flow_table_inet.c
> index 6eef15648b7b0..b13587238eceb 100644
> --- a/net/netfilter/nf_flow_table_inet.c
> +++ b/net/netfilter/nf_flow_table_inet.c
> @@ -98,6 +98,8 @@ static int __init nf_flow_inet_module_init(void)
>         nft_register_flowtable_type(&flowtable_ipv6);
>         nft_register_flowtable_type(&flowtable_inet);
>
> +       nf_flow_offload_register_bpf();
> +

Error checking needed here? Kfunc registration can fail.

>         return 0;
>  }
>
> --
> 2.45.0
>
>

