Return-Path: <bpf+bounces-30079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 633508CA5E9
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 03:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 878E21C21336
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 01:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D29D51E;
	Tue, 21 May 2024 01:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqLHupjO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909F58BF8;
	Tue, 21 May 2024 01:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716255697; cv=none; b=nvvmCWOZXPBQS6ttCzOgj4xXPpMtoVcRAl4rnYVB8y6/KqX+JpaIf3TnoqA3QOlRgGKCPxR/suwmzxzZAe9biSKOf8SRaKwA4SP0P0OWf74On2acMF+GZbYDf87LWVd4ZG4KN3EHokRCgzvjhZLg+dw8BBcjcW2es8e6/+fEybc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716255697; c=relaxed/simple;
	bh=OijL6t1xs7YMdTSvtCBIX9nEkB52wrzHZdx9VIFxyTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DGN+mBciz4w/cYuYtE+tMtnQgXh+bTWUqYsDijjfUIfGl8I0Jwx7dzLV+YxOGv/z+wDGRk2m9yprF9HmfsUAX7mpmcZpEfQ2ql2O8FIrMFyUgwyESZJDf4IqIZOKG7rSFV2SjhXE4SpuyIdBwW1fjp5tMJADwZN5Uttygvz9diw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqLHupjO; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-34d9c9f2cf0so2661859f8f.3;
        Mon, 20 May 2024 18:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716255694; x=1716860494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcWeoXVGuV5Q1SVXbMSapv1ao2FKwbqK710K39h/CRo=;
        b=IqLHupjOJ97VHWwUzmQF0TGC+gumxOtV/AGxz3+4QdUYxu+iDAHXsVy1ICCwULu3bj
         aqKQGPc/SnaADD3mwGLAJz8JbQx132ewdCKSwKYjh+1fsm1i6Q79Ue1BTtWZLKqlAp5P
         xmSslZQvviZ3/Et66YE8iQh2c8SlPZYmtYREVETNT2H5O0T1wWK2xyc+hCN77pVSoNx4
         CBO7c4oCIZIDZ61YNpQO1naHtH7TGPIuzHaCIvifxD93Qe8n4367axgg5MmOCAXu1YBF
         ZgU0C/BJBAGQb546e2IBuB106v6r7bZ/8g4Xldce6uoE9Dhq55G8ipvoTVvtYeukNKIz
         tksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716255694; x=1716860494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CcWeoXVGuV5Q1SVXbMSapv1ao2FKwbqK710K39h/CRo=;
        b=vZYth8W+YNhcMy81oOB7RMkQMnyHYYFdLPZ0fB1NpTeXuXFJYFxHTXApdXGvYmeMpu
         nN3wPMeRHh46AQMFGqPgiGi1jc68VBnGPr056OyRzGuhg+RUQ1O9/MSg4DA+xNHdUtiU
         Nf5b6jrMzVgRchBJEcBrkgBZZKryA0+hMIPoPOePoSgg7CNx3Jx+iAL24bTd01SFWfic
         whedWqflHDutcbGawkHCFuc7S3E79I6hT9kVlXY3sgvjRYZcyIIUYoj5LC4Ry8bL4du7
         RJmZ3KGB6a+joNDAMnV2bEdG9nzeI1do1UeVagPz//NxPgczRDo+Anb60daKFu70R3mg
         s+3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXZW+OasbeYlrTdlTs0LNb27c4bYyfMrfqgPXD9gdkqxrchVydi1u7y2s030StUfdnchtaSLUNSA/qpT+hTEPB/QKkE0wZMaPdHRrQgJGmcfOdK6FQDUQjyc8EnIFJC+QuUV0hkMO2z
X-Gm-Message-State: AOJu0Yzy78T5cD6fP9q9rS1w9cKwhxeY/Pn25rv2/NohwSieBwLzKV25
	2ojINBdn3HO12ka+aPElOubaW8J17Ef0aYvaFJmfllMaYEicNY5V1QYDc+oFic//4r7WbpC58xd
	aWtQCSaJ434yRK6F5cydm3F8dxD0=
X-Google-Smtp-Source: AGHT+IEn/8pwStLBNWAyq9EBObRBpZHTVrtZapksYFkC+eigLhSCvvyGRduN5CfuqfD4lJA8iLZBu6KpK/i5oU/arTY=
X-Received: by 2002:a5d:42c9:0:b0:351:d8f3:d4dd with SMTP id
 ffacd0b85a97d-351d8f3d90cmr11530443f8f.7.1716255693608; Mon, 20 May 2024
 18:41:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1716026761.git.lorenzo@kernel.org> <0ddc5e4fcc6a38c74c185063e73ef4c496eaa7ca.1716026761.git.lorenzo@kernel.org>
In-Reply-To: <0ddc5e4fcc6a38c74c185063e73ef4c496eaa7ca.1716026761.git.lorenzo@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 20 May 2024 18:41:21 -0700
Message-ID: <CAADnVQLaM1eTH75-PQQA--uYbYaEwBzbJJ-KjgeqGb3i0QyM=g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/4] netfilter: add bpf_xdp_flow_offload_lookup
 kfunc
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Jozsef Kadlecsik <kadlec@netfilter.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netfilter-devel <netfilter-devel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Florian Westphal <fw@strlen.de>, Jesper Dangaard Brouer <hawk@kernel.org>, Simon Horman <horms@kernel.org>, donhunte@redhat.com, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 18, 2024 at 3:13=E2=80=AFAM Lorenzo Bianconi <lorenzo@kernel.or=
g> wrote:
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
>  net/netfilter/nf_flow_table_bpf.c     | 94 +++++++++++++++++++++++++++
>  net/netfilter/nf_flow_table_inet.c    |  2 +-
>  4 files changed, 110 insertions(+), 1 deletion(-)
>  create mode 100644 net/netfilter/nf_flow_table_bpf.c
>
> diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilte=
r/nf_flow_table.h
> index 0bbe6ea8e0651..085660cbcd3f2 100644
> --- a/include/net/netfilter/nf_flow_table.h
> +++ b/include/net/netfilter/nf_flow_table.h
> @@ -312,6 +312,16 @@ unsigned int nf_flow_offload_ip_hook(void *priv, str=
uct sk_buff *skb,
>  unsigned int nf_flow_offload_ipv6_hook(void *priv, struct sk_buff *skb,
>                                        const struct nf_hook_state *state)=
;
>
> +#if (IS_BUILTIN(CONFIG_NF_FLOW_TABLE) && IS_ENABLED(CONFIG_DEBUG_INFO_BT=
F)) || \
> +    (IS_MODULE(CONFIG_NF_FLOW_TABLE) && IS_ENABLED(CONFIG_DEBUG_INFO_BTF=
_MODULES))
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
> @@ -144,6 +144,11 @@ obj-$(CONFIG_NF_FLOW_TABLE)        +=3D nf_flow_tabl=
e.o
>  nf_flow_table-objs             :=3D nf_flow_table_core.o nf_flow_table_i=
p.o \
>                                    nf_flow_table_offload.o
>  nf_flow_table-$(CONFIG_NF_FLOW_TABLE_PROCFS) +=3D nf_flow_table_procfs.o
> +ifeq ($(CONFIG_NF_FLOW_TABLE),m)
> +nf_flow_table-$(CONFIG_DEBUG_INFO_BTF_MODULES) +=3D nf_flow_table_bpf.o
> +else ifeq ($(CONFIG_NF_FLOW_TABLE),y)
> +nf_flow_table-$(CONFIG_DEBUG_INFO_BTF) +=3D nf_flow_table_bpf.o
> +endif
>
>  obj-$(CONFIG_NF_FLOW_TABLE_INET) +=3D nf_flow_table_inet.o
>
> diff --git a/net/netfilter/nf_flow_table_bpf.c b/net/netfilter/nf_flow_ta=
ble_bpf.c
> new file mode 100644
> index 0000000000000..f999ed9712796
> --- /dev/null
> +++ b/net/netfilter/nf_flow_table_bpf.c
> @@ -0,0 +1,94 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Unstable Flow Table Helpers for XDP hook
> + *
> + * These are called from the XDP programs.
> + * Note that it is allowed to break compatibility for these functions si=
nce
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
> +                 "Global functions as their definitions will be in nf_fl=
ow_table BTF");
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
> +       flow_table =3D nf_flowtable_by_dev(dev);
> +       if (!flow_table)
> +               return NULL;
> +
> +       tuplehash =3D flow_offload_lookup(flow_table, tuple);
> +       if (!tuplehash)
> +               return NULL;
> +
> +       flow =3D container_of(tuplehash, struct flow_offload,
> +                           tuplehash[tuplehash->tuple.dir]);
> +       flow_offload_refresh(flow_table, flow, false);
> +
> +       return tuplehash;
> +}
> +
> +__bpf_kfunc struct flow_offload_tuple_rhash *
> +bpf_xdp_flow_offload_lookup(struct xdp_md *ctx,
> +                           struct bpf_fib_lookup *fib_tuple)
> +{
> +       struct xdp_buff *xdp =3D (struct xdp_buff *)ctx;
> +       struct flow_offload_tuple tuple =3D {
> +               .iifidx =3D fib_tuple->ifindex,
> +               .l3proto =3D fib_tuple->family,
> +               .l4proto =3D fib_tuple->l4_protocol,
> +               .src_port =3D fib_tuple->sport,
> +               .dst_port =3D fib_tuple->dport,
> +       };
> +       __be16 proto;
> +
> +       switch (fib_tuple->family) {
> +       case AF_INET:
> +               tuple.src_v4.s_addr =3D fib_tuple->ipv4_src;
> +               tuple.dst_v4.s_addr =3D fib_tuple->ipv4_dst;
> +               proto =3D htons(ETH_P_IP);
> +               break;
> +       case AF_INET6:
> +               tuple.src_v6 =3D *(struct in6_addr *)&fib_tuple->ipv6_src=
;
> +               tuple.dst_v6 =3D *(struct in6_addr *)&fib_tuple->ipv6_dst=
;
> +               proto =3D htons(ETH_P_IPV6);
> +               break;
> +       default:
> +               return NULL;
> +       }
> +
> +       return bpf_xdp_flow_offload_tuple_lookup(xdp->rxq->dev, &tuple, p=
roto);
> +}
> +
> +__diag_pop()
> +
> +BTF_KFUNCS_START(nf_ft_kfunc_set)
> +BTF_ID_FLAGS(func, bpf_xdp_flow_offload_lookup)

I think it needs to be KF_RET_NULL.
And most likely KF_TRUSTED_ARGS as well.

Also the "offload" doesn't fit in the name.
The existing code calls it "offload", because it's actually
pushing the rules to HW (if I understand the code),
but here it's just a lookup from xdp.
So call it
bpf_xdp_flow_lookup() ?

Though "flow" is a bit too generic here.
nf_flow maybe?

> +BTF_KFUNCS_END(nf_ft_kfunc_set)
> +
> +static const struct btf_kfunc_id_set nf_flow_offload_kfunc_set =3D {
> +       .owner =3D THIS_MODULE,
> +       .set   =3D &nf_ft_kfunc_set,
> +};
> +
> +int nf_flow_offload_register_bpf(void)
> +{
> +       return register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP,
> +                                        &nf_flow_offload_kfunc_set);
> +}
> +EXPORT_SYMBOL_GPL(nf_flow_offload_register_bpf);
> diff --git a/net/netfilter/nf_flow_table_inet.c b/net/netfilter/nf_flow_t=
able_inet.c
> index 6eef15648b7b0..6175f7556919d 100644
> --- a/net/netfilter/nf_flow_table_inet.c
> +++ b/net/netfilter/nf_flow_table_inet.c
> @@ -98,7 +98,7 @@ static int __init nf_flow_inet_module_init(void)
>         nft_register_flowtable_type(&flowtable_ipv6);
>         nft_register_flowtable_type(&flowtable_inet);
>
> -       return 0;
> +       return nf_flow_offload_register_bpf();
>  }
>
>  static void __exit nf_flow_inet_module_exit(void)
> --
> 2.45.1
>

