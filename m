Return-Path: <bpf+bounces-5383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B95FA75A0B1
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 23:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9C841C211DD
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 21:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F7525147;
	Wed, 19 Jul 2023 21:42:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F5C14A8B;
	Wed, 19 Jul 2023 21:42:07 +0000 (UTC)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F4C1FCD;
	Wed, 19 Jul 2023 14:42:06 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-635de03a85bso895506d6.3;
        Wed, 19 Jul 2023 14:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689802925; x=1690407725;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZEcCPwF3lDOUhSWr4rx2J6ccsDG/MDNU7XzCgytqJE=;
        b=q8uaNSyIZJDXAfHarfVvGy84rIoyBULL2U1BJX4XMsiyB1FiVQIneIgqCj+ksHUT+p
         nr5IGkRsTiG6M9lF46DALZN5D8O8JUpHqTbib8lRg3un6JPpUvMaj/w67ECGd4B6Okk/
         JTM58C2Cy5qI4asNAF154L8Eva8DDijaONfD457NGTZlWQWruGecaIaSAZhKbouui+7i
         IiuBQQAu/JraWuxXji5pnQRo5awzyzQqOpITKJNlg81TLtq454V959d6v4FVON1m2VLp
         PRAMk3p0ZiK+5uDXcUnFQ6QhlwR+yyn/k4jPOBIEPRZGORhexSPjH7ila4l/kk2QsMxe
         qDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689802925; x=1690407725;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+ZEcCPwF3lDOUhSWr4rx2J6ccsDG/MDNU7XzCgytqJE=;
        b=UGxyJ9aTZ279z/qXRacSvShwkS37zg+3Ixk79JmedEhrdj9sQo4Qo98jDSzVwM0XLx
         cELOG2lTP64Ey51+rqtWbTSKf4x9mUEhr4c9tuiLyV9SEF9B7215N4ouIyVDx5l4PL11
         3kMKkvs2wlUePVz+gFOvpxe0Dtjgc5KHFrenVKY7rrbMqzi+BYw7UiyY01Z+UTzOv9lV
         fuB8MTNE6wvxb25r/nq/xcjaZImi+U4Uqlldqd7MUHLHKu/FvCr6/pSJ9cmd/tJPJ+v5
         fC6fboUugKDlc7JMqrawMK1rin2096XmO3MxDy9Y5iIL7SCYuOwudmh61zmqpOSFvEEl
         R83g==
X-Gm-Message-State: ABy/qLaRYtPiy6y6AwwpjI46DR/wSLiNCriV8BCGobr+4DntXudxOje1
	USIhCtIgZWFmS/k1nQ/Qu6M=
X-Google-Smtp-Source: APBJJlFwMjqkiMyuAPZwC0xNzA4OX/TJkkbRb3VVNOW4r/JE7iuS5YOdD2hiG3LlBfdR1pluhe+wvQ==
X-Received: by 2002:a0c:8d8e:0:b0:630:14e0:9827 with SMTP id t14-20020a0c8d8e000000b0063014e09827mr3576176qvb.28.1689802925218;
        Wed, 19 Jul 2023 14:42:05 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id y26-20020a0c9a9a000000b00632191a70a2sm1730379qvd.103.2023.07.19.14.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 14:42:04 -0700 (PDT)
Date: Wed, 19 Jul 2023 17:42:04 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
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
Message-ID: <64b858ac9edd3_2849c129476@willemb.c.googlers.com.notmuch>
In-Reply-To: <20230719183734.21681-13-larysa.zaremba@intel.com>
References: <20230719183734.21681-1-larysa.zaremba@intel.com>
 <20230719183734.21681-13-larysa.zaremba@intel.com>
Subject: RE: [PATCH bpf-next v3 12/21] xdp: Add checksum hint
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Larysa Zaremba wrote:
> Implement functionality that enables drivers to expose to XDP code checksum
> information that consists of:
> 
> - Checksum status - bitfield that consists of
>   - number of consecutive validated checksums. This is almost the same as
>     csum_level in skb, but starts with 1. Enum names for those bits still
>     use checksum level concept, so it is less confusing for driver
>     developers.
>   - Is checksum partial? This bit cannot coexist with any other
>   - Is there a complete checksum available?
> - Additional checksum data, a union of:
>   - checksum start and offset, if checksum is partial
>   - complete checksum, if available
> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  Documentation/networking/xdp-rx-metadata.rst |  3 ++
>  include/linux/netdevice.h                    |  3 ++
>  include/net/xdp.h                            | 46 ++++++++++++++++++++
>  kernel/bpf/offload.c                         |  2 +
>  net/core/xdp.c                               | 23 ++++++++++
>  5 files changed, 77 insertions(+)
> 
> diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
> index ea6dd79a21d3..7f056a44f682 100644
> --- a/Documentation/networking/xdp-rx-metadata.rst
> +++ b/Documentation/networking/xdp-rx-metadata.rst
> @@ -26,6 +26,9 @@ metadata is supported, this set will grow:
>  .. kernel-doc:: net/core/xdp.c
>     :identifiers: bpf_xdp_metadata_rx_vlan_tag
>  
> +.. kernel-doc:: net/core/xdp.c
> +   :identifiers: bpf_xdp_metadata_rx_csum
> +
>  An XDP program can use these kfuncs to read the metadata into stack
>  variables for its own consumption. Or, to pass the metadata on to other
>  consumers, an XDP program can store it into the metadata area carried
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 1749f4f75c64..4f6da36ac123 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1660,6 +1660,9 @@ struct xdp_metadata_ops {
>  			       enum xdp_rss_hash_type *rss_type);
>  	int	(*xmo_rx_vlan_tag)(const struct xdp_md *ctx, u16 *vlan_tci,
>  				   __be16 *vlan_proto);
> +	int	(*xmo_rx_csum)(const struct xdp_md *ctx,
> +			       enum xdp_csum_status *csum_status,
> +			       union xdp_csum_info *csum_info);
>  };
>  
>  /**
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index 89c58f56ffc6..2b7a7d678ff4 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -391,6 +391,8 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
>  			   bpf_xdp_metadata_rx_hash) \
>  	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_VLAN_TAG, \
>  			   bpf_xdp_metadata_rx_vlan_tag) \
> +	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_CSUM, \
> +			   bpf_xdp_metadata_rx_csum) \
>  
>  enum {
>  #define XDP_METADATA_KFUNC(name, _) name,
> @@ -448,6 +450,50 @@ enum xdp_rss_hash_type {
>  	XDP_RSS_TYPE_L4_IPV6_SCTP_EX = XDP_RSS_TYPE_L4_IPV6_SCTP | XDP_RSS_L3_DYNHDR,
>  };
>  
> +union xdp_csum_info {
> +	/* Checksum referred to by ``csum_start + csum_offset`` is considered
> +	 * valid, but was never calculated, TX device has to do this,
> +	 * starting from csum_start packet byte.
> +	 * Any preceding checksums are also considered valid.
> +	 * Available, if ``status == XDP_CHECKSUM_PARTIAL``.
> +	 */
> +	struct {
> +		u16 csum_start;
> +		u16 csum_offset;
> +	};
> +
> +	/* Checksum, calculated over the whole packet.
> +	 * Available, if ``status & XDP_CHECKSUM_COMPLETE``.
> +	 */
> +	u32 checksum;
> +};
> +
> +enum xdp_csum_status {
> +	/* HW had parsed several transport headers and validated their
> +	 * checksums, same as ``CHECKSUM_UNNECESSARY`` in ``sk_buff``.
> +	 * 3 least significat bytes contain number of consecutive checksum,

typo: significant

(I did not scan for typos, just came across this when trying to understand
the skb->csum_level + 1 trick. Probably good to run a spell check).

> +	 * starting with the outermost, reported by hardware as valid.
> +	 * ``sk_buff`` checksum level (``csum_level``) notation is provided
> +	 * for driver developers.
> +	 */
> +	XDP_CHECKSUM_VALID_LVL0		= 1,	/* 1 outermost checksum */
> +	XDP_CHECKSUM_VALID_LVL1		= 2,	/* 2 outermost checksums */
> +	XDP_CHECKSUM_VALID_LVL2		= 3,	/* 3 outermost checksums */
> +	XDP_CHECKSUM_VALID_LVL3		= 4,	/* 4 outermost checksums */
> +	XDP_CHECKSUM_VALID_NUM_MASK	= GENMASK(2, 0),
> +	XDP_CHECKSUM_VALID		= XDP_CHECKSUM_VALID_NUM_MASK,
> +
> +	/* Occurs if packet is sent virtually (between Linux VMs / containers)
> +	 * This status cannot coexist with any other.
> +	 * Refer to ``csum_start`` and ``csum_offset`` in ``xdp_csum_info``
> +	 * for more information.
> +	 */
> +	XDP_CHECKSUM_PARTIAL	= BIT(3),
> +
> +	/* Checksum, calculated over the entire packet is provided */
> +	XDP_CHECKSUM_COMPLETE	= BIT(4),
> +};
> +
>  #ifdef CONFIG_NET
>  u32 bpf_xdp_metadata_kfunc_id(int id);
>  bool bpf_dev_bound_kfunc_id(u32 btf_id);
> diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
> index 986e7becfd42..f60a6add5273 100644
> --- a/kernel/bpf/offload.c
> +++ b/kernel/bpf/offload.c
> @@ -850,6 +850,8 @@ void *bpf_dev_bound_resolve_kfunc(struct bpf_prog *prog, u32 func_id)
>  		p = ops->xmo_rx_hash;
>  	else if (func_id == bpf_xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_VLAN_TAG))
>  		p = ops->xmo_rx_vlan_tag;
> +	else if (func_id == bpf_xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_CSUM))
> +		p = ops->xmo_rx_csum;
>  out:
>  	up_read(&bpf_devs_lock);
>  
> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index 8b55419d332e..d4ea54046afc 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -772,6 +772,29 @@ __bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
>  	return -EOPNOTSUPP;
>  }
>  
> +/**
> + * bpf_xdp_metadata_rx_csum - Get checksum status with additional info.
> + * @ctx: XDP context pointer.
> + * @csum_status: Destination for checksum status.
> + * @csum_info: Destination for complete checksum or partial checksum offset.
> + *
> + * Status (@csum_status) is a bitfield that informs, what checksum
> + * processing was performed. Additional results of such processing,
> + * such as complete checksum or partial checksum offsets,
> + * are passed as info (@csum_info).
> + *
> + * Return:
> + * * Returns 0 on success or ``-errno`` on error.
> + * * ``-EOPNOTSUPP`` : device driver doesn't implement kfunc
> + * * ``-ENODATA``    : Checksum status is unknown
> + */
> +__bpf_kfunc int bpf_xdp_metadata_rx_csum(const struct xdp_md *ctx,
> +					 enum xdp_csum_status *csum_status,
> +					 union xdp_csum_info *csum_info)
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



