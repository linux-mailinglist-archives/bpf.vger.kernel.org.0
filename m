Return-Path: <bpf+bounces-3920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E806E7463CE
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 22:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24DF61C20A6A
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 20:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD0011CA3;
	Mon,  3 Jul 2023 20:15:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857E611C81;
	Mon,  3 Jul 2023 20:15:38 +0000 (UTC)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84CEE4E;
	Mon,  3 Jul 2023 13:15:36 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3a1d9b64837so3745098b6e.0;
        Mon, 03 Jul 2023 13:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688415336; x=1691007336;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1QpQGP9rvocuSnenq70u1UMswFFVxfOIHLX5ujR7Os=;
        b=Hm1LUTkkUP3O8GA6LbR5tH9/rOpH9HqEqSou8MDRZWdejP8Ira76tetUbuLPzYRBeU
         1mk0hp7bKtayNU0wUGH/K2zJzXDKP4f6MVvplpyXrohZwCe3V9/rJt8k40LdMoOyESnA
         iOyCC5NPnR/OnEds6H0FD40AxlzKL4IuNGA/VUYy6QRCxeLUXdwZRzE71vO3dDqPCS/d
         s/zz0IblJI1NPeS5/RKILsrCsghQuUG+rKupvmcB3S+o8SKFbhy36fj4YPe8i17sG5uP
         //pd+8d0cIdJng1IoKy33MEhc4/KCa/Vk9WnaMPQJ1EQLLmoQd8M6rffCKZWL0ko/nXN
         AzZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688415336; x=1691007336;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s1QpQGP9rvocuSnenq70u1UMswFFVxfOIHLX5ujR7Os=;
        b=Fa/+ptBXdoR8tCSynEfXd8BFQ8mhopau7ZJnAGkN8/rt5bIjRevFJhldZCIMG59yMc
         dRZzrE8Q9e3OvpvPBCjyWIgiFGjT4XLD4Rds/5zTtGvJPPlluT65KMMtkpyf4fmhnPZX
         7vJb+XN9Pgjl8KOFmhG0aK03N9+pigkny1QsoMqWDKPDvq1nMsIVn7QiI4FNRXd0YMSj
         b71thR8lNXNJZhvxBX1EyXt82iT1U0OvorDte62gG+zVbPuN6LRen8/hHmfmNuuklnuK
         sQ5KgDyH4dNKDfb6EtAgVXOvppvA2ldsSXYawanRHWDn62wwH9HqO2aEwim6/arYiAe0
         dVIQ==
X-Gm-Message-State: AC+VfDykB2iKFSaK0lUjlv0t4HnGEfvjj/7IOTxpuEgANRfWnltg4MKM
	MVjir5Nnz2CpC90D2Q21adI=
X-Google-Smtp-Source: ACHHUZ5/X0zn73FlGhaYWI+V0OMUJlS++5inTN25v9AHyShBwBFgF5AVgcvp0IAU6UCdy7Ob4OhctA==
X-Received: by 2002:a05:6808:318:b0:3a0:83cf:1d82 with SMTP id i24-20020a056808031800b003a083cf1d82mr10233954oie.22.1688415335902;
        Mon, 03 Jul 2023 13:15:35 -0700 (PDT)
Received: from localhost ([2605:59c8:148:ba10::41f])
        by smtp.gmail.com with ESMTPSA id g15-20020a17090ace8f00b002636e5c224asm6574612pju.56.2023.07.03.13.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 13:15:35 -0700 (PDT)
Date: Mon, 03 Jul 2023 13:15:34 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>, 
 bpf@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 song@kernel.org, 
 yhs@fb.com, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@google.com, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 David Ahern <dsahern@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Jesper Dangaard Brouer <brouer@redhat.com>, 
 Anatoly Burakov <anatoly.burakov@intel.com>, 
 Alexander Lobakin <alexandr.lobakin@intel.com>, 
 Magnus Karlsson <magnus.karlsson@gmail.com>, 
 Maryam Tahhan <mtahhan@redhat.com>, 
 xdp-hints@xdp-project.net, 
 netdev@vger.kernel.org
Message-ID: <64a32c661648e_628d32085f@john.notmuch>
In-Reply-To: <20230703181226.19380-10-larysa.zaremba@intel.com>
References: <20230703181226.19380-1-larysa.zaremba@intel.com>
 <20230703181226.19380-10-larysa.zaremba@intel.com>
Subject: RE: [PATCH bpf-next v2 09/20] xdp: Add VLAN tag hint
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Larysa Zaremba wrote:
> Implement functionality that enables drivers to expose VLAN tag
> to XDP code.
> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  Documentation/networking/xdp-rx-metadata.rst |  8 +++++++-
>  include/linux/netdevice.h                    |  2 ++
>  include/net/xdp.h                            |  2 ++
>  kernel/bpf/offload.c                         |  2 ++
>  net/core/xdp.c                               | 20 ++++++++++++++++++++
>  5 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
> index 25ce72af81c2..ea6dd79a21d3 100644
> --- a/Documentation/networking/xdp-rx-metadata.rst
> +++ b/Documentation/networking/xdp-rx-metadata.rst
> @@ -18,7 +18,13 @@ Currently, the following kfuncs are supported. In the future, as more
>  metadata is supported, this set will grow:
>  
>  .. kernel-doc:: net/core/xdp.c
> -   :identifiers: bpf_xdp_metadata_rx_timestamp bpf_xdp_metadata_rx_hash
> +   :identifiers: bpf_xdp_metadata_rx_timestamp
> +
> +.. kernel-doc:: net/core/xdp.c
> +   :identifiers: bpf_xdp_metadata_rx_hash
> +
> +.. kernel-doc:: net/core/xdp.c
> +   :identifiers: bpf_xdp_metadata_rx_vlan_tag
>  
>  An XDP program can use these kfuncs to read the metadata into stack
>  variables for its own consumption. Or, to pass the metadata on to other
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index b828c7a75be2..4fa4380e6d89 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1658,6 +1658,8 @@ struct xdp_metadata_ops {
>  	int	(*xmo_rx_timestamp)(const struct xdp_md *ctx, u64 *timestamp);
>  	int	(*xmo_rx_hash)(const struct xdp_md *ctx, u32 *hash,
>  			       enum xdp_rss_hash_type *rss_type);
> +	int	(*xmo_rx_vlan_tag)(const struct xdp_md *ctx, u16 *vlan_tag,
> +				   __be16 *vlan_proto);
>  };
>  
>  /**
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index 6381560efae2..89c58f56ffc6 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -389,6 +389,8 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
>  			   bpf_xdp_metadata_rx_timestamp) \
>  	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_HASH, \
>  			   bpf_xdp_metadata_rx_hash) \
> +	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_VLAN_TAG, \
> +			   bpf_xdp_metadata_rx_vlan_tag) \
>  
>  enum {
>  #define XDP_METADATA_KFUNC(name, _) name,
> diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
> index 8a26cd8814c1..986e7becfd42 100644
> --- a/kernel/bpf/offload.c
> +++ b/kernel/bpf/offload.c
> @@ -848,6 +848,8 @@ void *bpf_dev_bound_resolve_kfunc(struct bpf_prog *prog, u32 func_id)
>  		p = ops->xmo_rx_timestamp;
>  	else if (func_id == bpf_xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_HASH))
>  		p = ops->xmo_rx_hash;
> +	else if (func_id == bpf_xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_VLAN_TAG))
> +		p = ops->xmo_rx_vlan_tag;
>  out:
>  	up_read(&bpf_devs_lock);
>  
> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index 41e5ca8643ec..f6262c90e45f 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -738,6 +738,26 @@ __bpf_kfunc int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash,
>  	return -EOPNOTSUPP;
>  }
>  
> +/**
> + * bpf_xdp_metadata_rx_vlan_tag - Get XDP packet outermost VLAN tag with protocol
> + * @ctx: XDP context pointer.
> + * @vlan_tag: Destination pointer for VLAN tag
> + * @vlan_proto: Destination pointer for VLAN protocol identifier in network byte order.
> + *
> + * In case of success, vlan_tag contains VLAN tag, including 12 least significant bytes
> + * containing VLAN ID, vlan_proto contains protocol identifier.

Above is a bit confusing to me at least.

The vlan tag would be both the 16bit TPID and 16bit TCI. What fields
are to be included here? The VlanID or the full 16bit TCI meaning the
PCP+DEI+VID? I think by "including 12 least significant bytes" you
mean bits, but also not clear about those 4 other bits.

I can likely figure it out in next patches from implementation but
would be nice to clean up docs.

> + *
> + * Return:
> + * * Returns 0 on success or ``-errno`` on error.
> + * * ``-EOPNOTSUPP`` : device driver doesn't implement kfunc
> + * * ``-ENODATA``    : VLAN tag was not stripped or is not available
> + */
> +__bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx, u16 *vlan_tag,
> +					     __be16 *vlan_proto)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  __diag_pop();
>  
>  BTF_SET8_START(xdp_metadata_kfunc_ids)
> -- 
> 2.41.0
> 



