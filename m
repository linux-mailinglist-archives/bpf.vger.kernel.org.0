Return-Path: <bpf+bounces-5379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52378759E0C
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 20:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B62C281AC2
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 18:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C46111A9;
	Wed, 19 Jul 2023 18:59:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF42275BD;
	Wed, 19 Jul 2023 18:59:39 +0000 (UTC)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E35199A;
	Wed, 19 Jul 2023 11:59:38 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bb119be881so50713615ad.3;
        Wed, 19 Jul 2023 11:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689793177; x=1692385177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5ke2+UctC+DoOwplZHrK3x2BR06F4065MTKEWhT518s=;
        b=CbsznE8dvx8wKJEQAxpORbIXdmli5Zh/FPlmQ4MIyqQYlQlNjsA5dP40FCBBYE+eQY
         4/+4JI9nwSc9KoqplrIaeDxJ0dydcLJ2b5q9tzkzky9Sd40Y5guMJY70lstH44YvnLGr
         U1KlW4zL7ZqqCi5Q05CgPJEwjYxGbfvMMRPaxxJQGYEPTF3ljzUWl1nmZyuzp1FZNJKB
         LVl3xkYBzyK+8E1mHV8Bx+M+Cdj9c8VF2zzhhajhxy7BeAmrZQMBZcv6p++uDIAj67PP
         jnO/iqLE891qEavXM+s5x9i9CNqWRTlgOMfgUrE7TPggt3g0e/mFo+tACWmH+drqStJA
         Yprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689793177; x=1692385177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ke2+UctC+DoOwplZHrK3x2BR06F4065MTKEWhT518s=;
        b=ROIAX41pkiwhFTyaAPKAZrrMaweAGiD6bWjNzaJwj38rSPO4rcPbwx8ce1P1rp+Lsg
         RtWXxqkwdfwWBWs5/bRmHyKvtdGsWB4s7pn/zNctpHtVFXs7sKqYt7QKafaiWNMfCdhV
         3bHFmPqOHRZZrKPrIM6XH4tO8RML5tu03+WPAnB4jSFL8eDUAIO6bWeGtAWagbVzy4/a
         0/UG0v3nx4426N5JqjcKpPagvsJYkF8c26ePurQounvV+odDjjT47aoPkOYerpw8mc6y
         dZRZBMcE3Swcak6Wt6D/6HSgGRybbCCwUYsnYs5EBW4/+EYpRQinyTq6jQJu0mW43t6e
         cW6w==
X-Gm-Message-State: ABy/qLZH+7M5wjHtXHvp+KZvGy0W/yfIpJbUMxo4HqJ36JGrShps2g26
	ZlvdvXFzH/KETrzn70WGXs4=
X-Google-Smtp-Source: APBJJlFFs6ZPqDq5j/f2gL+3ynFPPHBUrnM/pdVxNM3ZzTJGDgYheYOnkkODQvN1NPk3F+2i0jkrtQ==
X-Received: by 2002:a17:902:cec3:b0:1b8:971c:b7b7 with SMTP id d3-20020a170902cec300b001b8971cb7b7mr23731180plg.56.1689793177405;
        Wed, 19 Jul 2023 11:59:37 -0700 (PDT)
Received: from macbook-pro-8.dhcp.thefacebook.com ([2620:10d:c090:500::4:8907])
        by smtp.gmail.com with ESMTPSA id l8-20020a170902f68800b001b892aac5c9sm4305624plg.298.2023.07.19.11.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 11:59:37 -0700 (PDT)
Date: Wed, 19 Jul 2023 11:59:30 -0700
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
	netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 13/21] ice: Implement checksum hint
Message-ID: <20230719185930.6adapqctxfdsfmye@macbook-pro-8.dhcp.thefacebook.com>
References: <20230719183734.21681-1-larysa.zaremba@intel.com>
 <20230719183734.21681-14-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719183734.21681-14-larysa.zaremba@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 08:37:26PM +0200, Larysa Zaremba wrote:
> Implement .xmo_rx_csum callback to allow XDP code to determine,
> whether HW has validated any checksums.
> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> index 54685d0747aa..6647a7e55ac8 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> @@ -660,8 +660,37 @@ static int ice_xdp_rx_vlan_tag(const struct xdp_md *ctx, u16 *vlan_tci,
>  	return 0;
>  }
>  
> +/**
> + * ice_xdp_rx_csum_lvl - Get level, at which HW has checked the checksum
> + * @ctx: XDP buff pointer
> + * @csum_status: destination address
> + * @csum_info: destination address
> + *
> + * Copy HW checksum level (if was checked) to the destination address.
> + */
> +static int ice_xdp_rx_csum(const struct xdp_md *ctx,
> +			   enum xdp_csum_status *csum_status,
> +			   union xdp_csum_info *csum_info)
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
> +	if (status & ICE_RX_CSUM_NONE)
> +		return -ENODATA;
> +
> +	*csum_status = ice_rx_csum_lvl(status) + 1;
> +	return 0;
> +}

and xdp_csum_info from previous patch left uninitialized?
What was the point adding it then?

