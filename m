Return-Path: <bpf+bounces-3921-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AC674643C
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 22:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E774280F0A
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 20:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DE111CA8;
	Mon,  3 Jul 2023 20:38:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2E7101C1;
	Mon,  3 Jul 2023 20:38:30 +0000 (UTC)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901BEE5D;
	Mon,  3 Jul 2023 13:38:29 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-52cb8e5e9f5so2985208a12.0;
        Mon, 03 Jul 2023 13:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688416709; x=1691008709;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLIZ+aY5RKrZYY1Nrh3dnM+rmqLgzQjdPn/yRszBdZw=;
        b=KCIJ0IiqG6kyPPFmO30JrO5Z1jEbltKPdnYMPALSzTxQwVV2D/BVV4N5g1Nl4JYENg
         o6muzcyGhyJ7WyR3cFWDPN1OhBSXQUH1eiEBNahaogY1NY7ZQLZs9AtpCreVIBB1C8cq
         d8sOEFChifn/CNNe59KecBRQIUjm4cqrzLanZc0P5imD07gLYi9800Yq7OCLoMHRtV/c
         pWrtIJkFJsyJtieb/niTiQUZxHFy9SImc51N4vPSraBaXulLduTVI/ujCTuVTxxWJ7yz
         fPCYpEFLynnUivuPDTfzncLMXuTjDLajYS+EmNNRrl4MdcBU+TJBfDEU4n0loXY1L9B8
         V33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688416709; x=1691008709;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uLIZ+aY5RKrZYY1Nrh3dnM+rmqLgzQjdPn/yRszBdZw=;
        b=JxbrRlYgqitncdC71jx3lrV390D3rKlGkzIApYMPsqIhEue42bA3va0sfsaXeLF8+F
         5wOvU+J0xq0daPl4NwK3g85FeH9hfTFz+tqcfeFwoM522jyW7691Ibl2dhLEINgqTHv2
         h0OcaWO/Op2uf/EAF57dYJiG/V4KqNXYHEFYTE3Sz3vBQw01OyuR24Rud49OOmyj6qW/
         X1Fac3+ALXwI/QaslgeskfNWl0ByJjKO8kF8SWlK3X0fi7dCdJEbXo2U4EYmg5nXGZ9M
         f1kWEEwuLV8DpX8rm41Sx4TZyggGTJeUUQ9NyAs6KtYK3FQngd0ynQOpgPCs8xTGdpnW
         sc4A==
X-Gm-Message-State: AC+VfDwwTOC/8dCfiavh12ypKf/xZZX6csS8INTjMj775rVi4WgLi2wW
	s55fh1XEOQy6PxlPuiPoRT8=
X-Google-Smtp-Source: ACHHUZ673tjR479nVy7ImkItn5HaZHkzvGKTkLylT5eliKY4H1K+aUkjwGYIZAjrH76otP8CrdTYkg==
X-Received: by 2002:a05:6a21:9985:b0:10c:322:72d5 with SMTP id ve5-20020a056a21998500b0010c032272d5mr15442153pzb.23.1688416708861;
        Mon, 03 Jul 2023 13:38:28 -0700 (PDT)
Received: from localhost ([2605:59c8:148:ba10::41f])
        by smtp.gmail.com with ESMTPSA id n18-20020aa78a52000000b00679fef56287sm12078163pfa.147.2023.07.03.13.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 13:38:28 -0700 (PDT)
Date: Mon, 03 Jul 2023 13:38:27 -0700
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
Message-ID: <64a331c338a5a_628d3208cb@john.notmuch>
In-Reply-To: <20230703181226.19380-13-larysa.zaremba@intel.com>
References: <20230703181226.19380-1-larysa.zaremba@intel.com>
 <20230703181226.19380-13-larysa.zaremba@intel.com>
Subject: RE: [PATCH bpf-next v2 12/20] xdp: Add checksum level hint
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
> Implement functionality that enables drivers to expose to XDP code,
> whether checksums was checked and on what level.
> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  Documentation/networking/xdp-rx-metadata.rst |  3 +++
>  include/linux/netdevice.h                    |  1 +
>  include/net/xdp.h                            |  2 ++
>  kernel/bpf/offload.c                         |  2 ++
>  net/core/xdp.c                               | 21 ++++++++++++++++++++
>  5 files changed, 29 insertions(+)
> 
> diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
> index ea6dd79a21d3..4ec6ddfd2a52 100644
> --- a/Documentation/networking/xdp-rx-metadata.rst
> +++ b/Documentation/networking/xdp-rx-metadata.rst
> @@ -26,6 +26,9 @@ metadata is supported, this set will grow:
>  .. kernel-doc:: net/core/xdp.c
>     :identifiers: bpf_xdp_metadata_rx_vlan_tag
>  
> +.. kernel-doc:: net/core/xdp.c
> +   :identifiers: bpf_xdp_metadata_rx_csum_lvl
> +
>  An XDP program can use these kfuncs to read the metadata into stack
>  variables for its own consumption. Or, to pass the metadata on to other
>  consumers, an XDP program can store it into the metadata area carried
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 4fa4380e6d89..569563687172 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1660,6 +1660,7 @@ struct xdp_metadata_ops {
>  			       enum xdp_rss_hash_type *rss_type);
>  	int	(*xmo_rx_vlan_tag)(const struct xdp_md *ctx, u16 *vlan_tag,
>  				   __be16 *vlan_proto);
> +	int	(*xmo_rx_csum_lvl)(const struct xdp_md *ctx, u8 *csum_level);
>  };
>  
>  /**
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index 89c58f56ffc6..61ed38fa79d1 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -391,6 +391,8 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
>  			   bpf_xdp_metadata_rx_hash) \
>  	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_VLAN_TAG, \
>  			   bpf_xdp_metadata_rx_vlan_tag) \
> +	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_CSUM_LVL, \
> +			   bpf_xdp_metadata_rx_csum_lvl) \
>  
>  enum {
>  #define XDP_METADATA_KFUNC(name, _) name,
> diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
> index 986e7becfd42..a133fb775f49 100644
> --- a/kernel/bpf/offload.c
> +++ b/kernel/bpf/offload.c
> @@ -850,6 +850,8 @@ void *bpf_dev_bound_resolve_kfunc(struct bpf_prog *prog, u32 func_id)
>  		p = ops->xmo_rx_hash;
>  	else if (func_id == bpf_xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_VLAN_TAG))
>  		p = ops->xmo_rx_vlan_tag;
> +	else if (func_id == bpf_xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_CSUM_LVL))
> +		p = ops->xmo_rx_csum_lvl;
>  out:
>  	up_read(&bpf_devs_lock);
>  
> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index f6262c90e45f..c666d3e0a26c 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -758,6 +758,27 @@ __bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx, u16 *vlan
>  	return -EOPNOTSUPP;
>  }
>  
> +/**
> + * bpf_xdp_metadata_rx_csum_lvl - Get depth at which HW has checked the checksum.
> + * @ctx: XDP context pointer.
> + * @csum_level: Return value pointer.
> + *
> + * In case of success, csum_level contains depth of the last verified checksum.
> + * If only the outermost checksum was verified, csum_level is 0, if both
> + * encapsulation and inner transport checksums were verified, csum_level is 1,
> + * and so on.
> + * For more details, refer to csum_level field in sk_buff.
> + *
> + * Return:
> + * * Returns 0 on success or ``-errno`` on error.
> + * * ``-EOPNOTSUPP`` : device driver doesn't implement kfunc
> + * * ``-ENODATA``    : Checksum was not validated
> + */
> +__bpf_kfunc int bpf_xdp_metadata_rx_csum_lvl(const struct xdp_md *ctx, u8 *csum_level)

Istead of ENODATA should we return what would be put in the ip_summed field
CHECKSUM_{NONE, UNNECESSARY, COMPLETE, PARTIAL}? Then sig would be,

 bpf_xdp_metadata_rx_csum_lvl(const struct xdp_md *ctx, u8 *type, u8 *lvl);

or something like that? Or is the thought that its not really necessary?
I don't have a strong preference but figured it was worth asking.

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

