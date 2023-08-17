Return-Path: <bpf+bounces-8022-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E065978003E
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 23:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9934F282205
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 21:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B771BEE4;
	Thu, 17 Aug 2023 21:58:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D5B1ADC8;
	Thu, 17 Aug 2023 21:58:32 +0000 (UTC)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE302698;
	Thu, 17 Aug 2023 14:58:31 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2685bcd046eso197854a91.3;
        Thu, 17 Aug 2023 14:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692309511; x=1692914311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GINBlOUN78JQAVZLCyadtlAejrOaDZvkhNHX3xHJbIA=;
        b=RzMjdJdCUKJCTf7fI3fc/wIBGlIIjqaTWtwE9ycDNv2m4cNYvGJey6yihBIA3CAbkq
         RmJPRgQ/h1E0dGNCahy9HGSwCSUkjx5bZP1OWUD4soUUZcQ3BL8GvPQQSWmkF74+5A2n
         9E2KVwJrg6JyCABiL6N7KJ8f02G6VPVD+K9sUwXcJmRe/ck+UnlkNnrXJpQN6BaAvc0M
         ycsNCRgH1KwYHVtqqtglQv6QR8M3QkBqWcMJi3zSe3NV3MRfx7CVo29qWqk/DQtfzsG4
         LIptvRZrFGLHCByQ/VlMf3JX+6vGO/0bazj8auI1oWseGbKpn/zJqIcLVHI1e4Id4mrI
         wyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692309511; x=1692914311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GINBlOUN78JQAVZLCyadtlAejrOaDZvkhNHX3xHJbIA=;
        b=HB+fBejiL64z/bkOKug5ew70Q/T54WqbDhb+08QAA/4eadwdalcM93xFJzFH6/V5f+
         aLdl5TDFHQfjtPtB8Os6Ne5FIfldw2Ji8BhMK0pyOKj48humGOwjWO+Y1nZk3veHis+D
         e+6RYGcD2HD3MfbabYP7reKY0OTCG205d6feu8t/4Ta9vwDk0Qscuq0PIjdYAkqEZxIe
         mlIAoxVS+jVqgPoK5vWl50LjFgVEvYLHaiY5Ebh6y26dxbvYO7WfrNSWR4dys+igg3tM
         GR3wV4RAwtrOvX/4hJlEVjvYw1PPNHPFz1jmOMbwxblwUY1OQ0WfdO0Hgq8yu1may3Au
         UhxQ==
X-Gm-Message-State: AOJu0YxL4XsZ4qUlE6maCKLc5BbzsbPCwGqiF3OdCrzNnMEiifskghP6
	wSKrMk4HRZ22qFYCt3Hlwew=
X-Google-Smtp-Source: AGHT+IGxkIxUbdobemPAjFwPTFS1otmjb9kmh1krxv/YtvUP/c92nBH5UbW8yWyibu0MRQH+GWyjcA==
X-Received: by 2002:a17:90a:2a01:b0:26b:e80:11de with SMTP id i1-20020a17090a2a0100b0026b0e8011demr734132pjd.25.1692309510832;
        Thu, 17 Aug 2023 14:58:30 -0700 (PDT)
Received: from macbook-pro-8.dhcp.thefacebook.com ([2620:10d:c090:500::4:8d88])
        by smtp.gmail.com with ESMTPSA id x14-20020a17090a6b4e00b00268320ab9f2sm1734599pjl.6.2023.08.17.14.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 14:58:30 -0700 (PDT)
Date: Thu, 17 Aug 2023 14:58:26 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
	sdf@google.com, haoluo@google.com, jolsa@kernel.org,
	David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Jesper Dangaard Brouer <brouer@redhat.com>,
	Anatoly Burakov <anatoly.burakov@intel.com>,
	Alexander Lobakin <alexandr.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@gmail.com>,
	Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
	netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH bpf-next v5 13/21] ice: Implement checksum hint
Message-ID: <20230817215826.sx7t6mipx7pajuzo@macbook-pro-8.dhcp.thefacebook.com>
References: <20230811161509.19722-1-larysa.zaremba@intel.com>
 <20230811161509.19722-14-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811161509.19722-14-larysa.zaremba@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 11, 2023 at 06:15:01PM +0200, Larysa Zaremba wrote:
> Implement .xmo_rx_csum callback to allow XDP code to determine,
> whether HW has validated any checksums.
> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> index 6ae57a98a4d8..f11a245705bc 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> @@ -660,8 +660,34 @@ static int ice_xdp_rx_vlan_tag(const struct xdp_md *ctx, u16 *vlan_tci,
>  	return 0;
>  }
>  
> +/**
> + * ice_xdp_rx_csum - RX checksum XDP hint handler
> + * @ctx: XDP buff pointer
> + * @csum_status: status destination address
> + * @csum: not used
> + */
> +static int ice_xdp_rx_csum(const struct xdp_md *ctx,
> +			   enum xdp_csum_status *csum_status, __wsum *csum)
> +{
> +	const struct ice_xdp_buff *xdp_ext = (void *)ctx;
> +	const union ice_32b_rx_flex_desc *eop_desc;
> +	enum ice_rx_csum_status status;
> +	u16 ptype;
> +
> +	eop_desc = xdp_ext->pkt_ctx.eop_desc;
> +	ptype = ice_get_ptype(eop_desc);
> +
> +	status = ice_get_rx_csum_status(eop_desc, ptype);
> +	if (status & ICE_RX_CSUM_FAIL)
> +		return -ENODATA;
> +
> +	*csum_status = XDP_CHECKSUM_VERIFIED;
> +	return 0;
> +}
> +
>  const struct xdp_metadata_ops ice_xdp_md_ops = {
>  	.xmo_rx_timestamp		= ice_xdp_rx_hw_ts,
>  	.xmo_rx_hash			= ice_xdp_rx_hash,
>  	.xmo_rx_vlan_tag		= ice_xdp_rx_vlan_tag,
> +	.xmo_rx_csum			= ice_xdp_rx_csum,

timestamp hint is implemented by igc, mlx4, mlx5, stmmac
hash hint is implemneted by igc, mlx4, mlx5.
With above csum and vlan hints will be in ice only.
I'd like to see at least one more driver to implement them as well to make sure
the proposed API works for other vendors.

