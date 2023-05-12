Return-Path: <bpf+bounces-449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE9A700EEB
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 20:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 608E61C213AE
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 18:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AD123D54;
	Fri, 12 May 2023 18:35:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1521B23D4D
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 18:35:02 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754065FEF
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 11:34:27 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-55a1427cbacso168476667b3.3
        for <bpf@vger.kernel.org>; Fri, 12 May 2023 11:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683916463; x=1686508463;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ksHSwdf3LwcwVL3OE9a2eYWhGDTEko4fWy0aHJsHDCU=;
        b=1qXhzjtoALC7LbPCjmNHDKpuDvTISdkcKIC+yZpoPn4HTlYjny8TG6ILSGhADhBXTb
         2SoGAFXyKUGXpGLQzgEynaaCDq25XGTUeg4gsm9RGHc0JGRJeH5tAaubJKfewgpjW3v5
         96XWVae0jmVbKjNcbFpilhqhcjAsTL+aM6qE+oEi7CHNep5VQRAr+QeMxjar7jIH0mzt
         coO8tZUpUzQSmyw50e7qP+CWMWv8iWDAW0qzlPwXzZCJiIEg3ymnkl+Aed6CTIBAoBKC
         XMkZ9kKOZLIchnpHF8BeQIZKB3I/zbMeVaQl7nhSVuQqYq9N+gOl31e3qBnnb1HIyHAQ
         1XaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683916463; x=1686508463;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ksHSwdf3LwcwVL3OE9a2eYWhGDTEko4fWy0aHJsHDCU=;
        b=KL0edWd7i2v2og7ukInOg43HG8RLIDvlwNhQSwaQAp4/vuXudb68oqNa162F4ZhMtA
         tjbE2gC71TrE/etEkkaOwEagPqNoRSiuMwzsojBEFqkupCd88PZeKS++qFR5AY5+/3C9
         PEIqeHiWicAuHVmT5/hDBmoEg8BcD27imwQDKQJ3b6HVGt1yFo2PtA+zN1N7/b3oeIlP
         gpBO5b7hElXkCVg+78vnrecaBRW0wSdy+sjUi/lsJ8Ah32cIqYUy0EMgdjUpghULN1iJ
         ErtXmQiALFQzh3znehrGgyxN5W7FphsA1dTEYZWb5GCTRf/zjHyP1EFfGAHG/RfrDxWc
         wL8Q==
X-Gm-Message-State: AC+VfDxujkG0UD8UGtt0EPk0y71iKaIuuJ1c1BPukA107vd+NC3gCi4M
	CwLmimvAUs5I9dxbMJ0MO1Rq3tE=
X-Google-Smtp-Source: ACHHUZ6Sw+JVn0ptcM72e1Wp1MOw6FgFKWFiZmnTwGnuLBFu/ZagRmDQMzwhOzRPdysj3HzHBs+xUH8=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:ac05:0:b0:561:2078:c4cd with SMTP id
 k5-20020a81ac05000000b005612078c4cdmr1405616ywh.2.1683916462870; Fri, 12 May
 2023 11:34:22 -0700 (PDT)
Date: Fri, 12 May 2023 11:34:21 -0700
In-Reply-To: <20230512152607.992209-12-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230512152607.992209-1-larysa.zaremba@intel.com> <20230512152607.992209-12-larysa.zaremba@intel.com>
Message-ID: <ZF6GrXsA8L0THVFB@google.com>
Subject: Re: [PATCH RESEND bpf-next 11/15] xdp: Add checksum level hint
From: Stanislav Fomichev <sdf@google.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, Jesse Brandeburg <jesse.brandeburg@intel.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Anatoly Burakov <anatoly.burakov@intel.com>, 
	Jesper Dangaard Brouer <brouer@redhat.com>, Alexander Lobakin <alexandr.lobakin@intel.com>, 
	Magnus Karlsson <magnus.karlsson@gmail.com>, Maryam Tahhan <mtahhan@redhat.com>, 
	xdp-hints@xdp-project.net, netdev@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 05/12, Larysa Zaremba wrote:
> Implement functionality that enables drivers to expose to XDP code,
> whether checksums was checked and on what level.
> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  Documentation/networking/xdp-rx-metadata.rst |  3 +++
>  include/linux/netdevice.h                    |  1 +
>  include/net/xdp.h                            |  2 ++
>  kernel/bpf/offload.c                         |  2 ++
>  net/core/xdp.c                               | 12 ++++++++++++
>  5 files changed, 20 insertions(+)
> 
> diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
> index 73a78029c596..f74f0e283097 100644
> --- a/Documentation/networking/xdp-rx-metadata.rst
> +++ b/Documentation/networking/xdp-rx-metadata.rst
> @@ -29,6 +29,9 @@ metadata is supported, this set will grow:
>  .. kernel-doc:: net/core/xdp.c
>     :identifiers: bpf_xdp_metadata_rx_stag
>  
> +.. kernel-doc:: net/core/xdp.c
> +   :identifiers: bpf_xdp_metadata_rx_csum_lvl
> +
>  An XDP program can use these kfuncs to read the metadata into stack
>  variables for its own consumption. Or, to pass the metadata on to other
>  consumers, an XDP program can store it into the metadata area carried
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index fdae37fe11f5..ddade3a15366 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1657,6 +1657,7 @@ struct xdp_metadata_ops {
>  			       enum xdp_rss_hash_type *rss_type);
>  	int	(*xmo_rx_ctag)(const struct xdp_md *ctx, u16 *vlan_tag);
>  	int	(*xmo_rx_stag)(const struct xdp_md *ctx, u16 *vlan_tag);
> +	int	(*xmo_rx_csum_lvl)(const struct xdp_md *ctx, u8 *csum_level);
>  };
>  
>  /**
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index 2db7439fc60f..0fbd25616241 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -393,6 +393,8 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
>  			   bpf_xdp_metadata_rx_ctag) \
>  	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_STAG, \
>  			   bpf_xdp_metadata_rx_stag) \
> +	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_CSUM_LVL, \
> +			   bpf_xdp_metadata_rx_csum_lvl) \
>  
>  enum {
>  #define XDP_METADATA_KFUNC(name, _) name,
> diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
> index 2c6b6e82cfac..8bd54fb4ac63 100644
> --- a/kernel/bpf/offload.c
> +++ b/kernel/bpf/offload.c
> @@ -852,6 +852,8 @@ void *bpf_dev_bound_resolve_kfunc(struct bpf_prog *prog, u32 func_id)
>  		p = ops->xmo_rx_ctag;
>  	else if (func_id == bpf_xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_STAG))
>  		p = ops->xmo_rx_stag;
> +	else if (func_id == bpf_xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_CSUM_LVL))
> +		p = ops->xmo_rx_csum_lvl;
>  out:
>  	up_read(&bpf_devs_lock);
>  
> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index eff21501609f..7dd45fd62983 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -762,6 +762,18 @@ __bpf_kfunc int bpf_xdp_metadata_rx_stag(const struct xdp_md *ctx, u16 *vlan_tag
>  	return -EOPNOTSUPP;
>  }
>  
> +/**
> + * bpf_xdp_metadata_rx_csum_lvl - Get depth at which HW has checked the checksum.
> + * @ctx: XDP context pointer.
> + * @csum_level: Return value pointer.

Let's maybe clarify what the level means here? For example, do we start
counting from 0 or 1?

> + *
> + * Returns 0 on success (HW has checked the checksum) or ``-errno`` on error.
> + */
> +__bpf_kfunc int bpf_xdp_metadata_rx_csum_lvl(const struct xdp_md *ctx, u8 *csum_level)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  __diag_pop();
>  
>  BTF_SET8_START(xdp_metadata_kfunc_ids)
> -- 
> 2.35.3
> 

