Return-Path: <bpf+bounces-447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50774700EDE
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 20:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 101BE281D83
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 18:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838671EA8B;
	Fri, 12 May 2023 18:32:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493741EA6E
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 18:32:03 +0000 (UTC)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC792729
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 11:31:27 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-643bb9cdd3cso8038960b3a.1
        for <bpf@vger.kernel.org>; Fri, 12 May 2023 11:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683916283; x=1686508283;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wq2By9mZuUQ7p1oM5SkoXHJiUzdgw169iTgadwLtfnQ=;
        b=JWT1FrK7ck7EpDsQRE4pCSwDvUGJ63OfyV6gRQBf3N6utX08/U1OHXmvomU3P6Z3G6
         N5Tvx3vxz4Y6ynHYvG8gsQs85MZ7VK/EoDwOcb9T7Vuf16vwygdYAzo/UNwe5EPtiLD8
         HAQ764S9LE4N6qXozvAtzgduNz/lnpvl878hU17TpCFsRDDOzxM/9/Y7iSQQ3Zx2WZpj
         I4fJF+J/zB+k1AZUcc8RBSXW1+T9EWoDEQpcvOtBknUhsuo/Cja32EUu70hGOaWdrDKH
         6PzSqv0XmVdYlay6qmzlhnjOFde/W19FX57pttk9HvCy1ixM/Fgu/A/6SlTmkdEkZhVw
         NRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683916283; x=1686508283;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wq2By9mZuUQ7p1oM5SkoXHJiUzdgw169iTgadwLtfnQ=;
        b=diFV+zvfMKRqNZNdJnDpcno5IseXyC982E0IMg2a1R0bDSTzt6ctF2+j+sxO2G7b/m
         EQK0srP44XbILDZkC3LC58B2zLRD8khDQHRPmvzf3r3jx/bKsD/fRqdK/JyeqPBu/jHr
         37S5Mn2aAwwNiYym3bleKzJ+OI/wSV3mnM5efRAktmmNdtLfWPyZdnqvAdRSuc97G6hL
         rWDTnuUhEgQ1vr7LJb6EnhcnjDY9wUVucTq2wfZOO95GGn4F6ymJScrRC957+Y+JPmf2
         9ZKt58un7O3pV3xpNjIVyAZvPQ8eN5yZxDJQyM/jMnsWcsKzCuBt4rKgfoieC7c2We/B
         NOgg==
X-Gm-Message-State: AC+VfDxyGlb4z44TSRvxKFHqFu2/yexqbBmLg32ckwnl/FdKqhid9NpD
	R/B83Ax8xLXjQnVeVm0jD1Dz3nk=
X-Google-Smtp-Source: ACHHUZ5yguYzBo0raBvnnA2xkJTrHlxk1B/ym21H6OwVm5I5+i5m5lU08ouAnUGmmP635rdcxpsTQfI=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:7c6:b0:643:599b:4db4 with SMTP id
 n6-20020a056a0007c600b00643599b4db4mr6882664pfu.1.1683916282830; Fri, 12 May
 2023 11:31:22 -0700 (PDT)
Date: Fri, 12 May 2023 11:31:21 -0700
In-Reply-To: <20230512152607.992209-11-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230512152607.992209-1-larysa.zaremba@intel.com> <20230512152607.992209-11-larysa.zaremba@intel.com>
Message-ID: <ZF6F+UQlXA9REqag@google.com>
Subject: Re: [PATCH RESEND bpf-next 10/15] ice: Implement VLAN tag hint
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
> Implement .xmo_rx_vlan_tag callback to allow XDP code to read
> packet's VLAN tag.
> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> index 1caa73644e7b..39547feb6106 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> @@ -627,7 +627,51 @@ static int ice_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
>  	return 0;
>  }
>  
> +/**
> + * ice_xdp_rx_ctag - VLAN tag XDP hint handler
> + * @ctx: XDP buff pointer
> + * @vlan_tag: destination address
> + *
> + * Copy VLAN tag (if was stripped) to the destination address.
> + */
> +static int ice_xdp_rx_ctag(const struct xdp_md *ctx, u16 *vlan_tag)
> +{
> +	const struct ice_xdp_buff *xdp_ext = (void *)ctx;
> +	netdev_features_t features;
> +

[..]

> +	features = xdp_ext->rx_ring->netdev->features;
> +
> +	if (!(features & NETIF_F_HW_VLAN_CTAG_RX))
> +		return -EINVAL;

Passing-by comment: why do we need to check features?
ice_get_vlan_tag_from_rx_desc seems to be checking a bunch of
fields in the descriptors, so that should be enough?

> +
> +	*vlan_tag = ice_get_vlan_tag_from_rx_desc(xdp_ext->eop_desc);

Should we also do the following:

if (!*vlan_tag)
	return -ENODATA;

?

> +	return 0;
> +}
> +
> +/**
> + * ice_xdp_rx_stag - VLAN s-tag XDP hint handler
> + * @ctx: XDP buff pointer
> + * @vlan_tag: destination address
> + *
> + * Copy VLAN s-tag (if was stripped) to the destination address.
> + */
> +static int ice_xdp_rx_stag(const struct xdp_md *ctx, u16 *vlan_tag)
> +{
> +	const struct ice_xdp_buff *xdp_ext = (void *)ctx;
> +	netdev_features_t features;
> +
> +	features = xdp_ext->rx_ring->netdev->features;
> +
> +	if (!(features & NETIF_F_HW_VLAN_STAG_RX))
> +		return -EINVAL;
> +
> +	*vlan_tag = ice_get_vlan_tag_from_rx_desc(xdp_ext->eop_desc);
> +	return 0;
> +}
> +
>  const struct xdp_metadata_ops ice_xdp_md_ops = {
>  	.xmo_rx_timestamp		= ice_xdp_rx_hw_ts,
>  	.xmo_rx_hash			= ice_xdp_rx_hash,
> +	.xmo_rx_ctag			= ice_xdp_rx_ctag,
> +	.xmo_rx_stag			= ice_xdp_rx_stag,
>  };
> -- 
> 2.35.3
> 

