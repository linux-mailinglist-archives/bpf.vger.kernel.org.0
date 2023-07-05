Return-Path: <bpf+bounces-4082-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8153748A11
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 19:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34679281070
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 17:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47B8134AD;
	Wed,  5 Jul 2023 17:25:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA1A9470
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 17:25:04 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850E319B
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 10:25:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c386ccab562so7346616276.3
        for <bpf@vger.kernel.org>; Wed, 05 Jul 2023 10:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688577903; x=1691169903;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CxfUFrp22faM6yocaPqFBZtPAz5DjOt4ynE8IBV8bNM=;
        b=c+UJldqODstcg5PwT6EPmiSS4mdL3PxWjeRwNOb1AH1Rojzk7MXulMdZQUxXtogiE7
         Uh8GR7IEJBMLxj/m+dyp5SrFkktba2THXAKRLvcaiBrVtNW3Cdi0KWKnbaC78OtXwaIG
         hIJ844MYhe1sWdLyGRuEES/N3MgrA8EdL7Kg6C7nf+OF+4kRwuGnuz+4vA+mqiARYIal
         B5iz2WAH5b+e3oP9RWrINtr/9JrwoofMjnQVl83SneiDJ1TeFruj6sALS0fEN23k8G4f
         d+6z0aC77RtAVomwW+HsvrklfNH0BBuhsOeA6XSaKNNvy62s2iFpZIGaea5v0mEiBv45
         g6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688577903; x=1691169903;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CxfUFrp22faM6yocaPqFBZtPAz5DjOt4ynE8IBV8bNM=;
        b=cf3AhskE4c7YH9NPsJUk2/rGI5isTxK0R1DUwhlGuj6xVBLUz/HmGput7FSlf4Oecv
         l4DKYEH9LS64vWaiShBIJrYe21W82R9Bp8zbtOGRkS9OjBG7RFY/0sQVfwKmhcl9ALGr
         dikBqkB7WLBciYc5pgK/65dgPYu8shCGFpavKW9ATqCZx9BF2NaVG2/VP4FggHRNofF5
         ufJBx4Qs8b06iq+1yCw3HMYg58ICKu+eYLnAQlhBoZ28wdWStp4GxqM0x3H5Bapln4xs
         udf0bBJ3yshNDwwnIwQFLTBh6ocrxLtikblkiy2zAfL/fqdqFTBrabUh3CZ92sgzOIm1
         Bi5g==
X-Gm-Message-State: ABy/qLb/fCHGKSPCMM1yXfHt/LbLX5Nd80v/fYbyhykVdwaTh7z7qQEL
	N14wrKfu3pEgRRYMs0oU9Yi5zOM=
X-Google-Smtp-Source: APBJJlHBEGfmPdf09pEer+j0AZfp8LuqWeR7ikx6GC0fxeCkefYmRn5l3kF99n0QHWUZN9azdCZXqMU=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:a249:0:b0:c39:d6f6:481f with SMTP id
 b67-20020a25a249000000b00c39d6f6481fmr138970ybi.10.1688577902793; Wed, 05 Jul
 2023 10:25:02 -0700 (PDT)
Date: Wed, 5 Jul 2023 10:25:01 -0700
In-Reply-To: <20230703181226.19380-18-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230703181226.19380-1-larysa.zaremba@intel.com> <20230703181226.19380-18-larysa.zaremba@intel.com>
Message-ID: <ZKWnbfTXp/vyHYUU@google.com>
Subject: Re: [PATCH bpf-next v2 17/20] veth: Implement VLAN tag and checksum
 level XDP hint
From: Stanislav Fomichev <sdf@google.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Jesper Dangaard Brouer <brouer@redhat.com>, 
	Anatoly Burakov <anatoly.burakov@intel.com>, Alexander Lobakin <alexandr.lobakin@intel.com>, 
	Magnus Karlsson <magnus.karlsson@gmail.com>, Maryam Tahhan <mtahhan@redhat.com>, 
	xdp-hints@xdp-project.net, netdev@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/03, Larysa Zaremba wrote:
> In order to test VLAN tag and checksum level XDP hints in
> hardware-independent selfttests, implement newly added XDP hints in veth
> driver.
> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  drivers/net/veth.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 614f3e3efab0..a7f2b679551d 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -1732,6 +1732,44 @@ static int veth_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
>  	return 0;
>  }
>  
> +static int veth_xdp_rx_vlan_tag(const struct xdp_md *ctx, u16 *vlan_tag,
> +				__be16 *vlan_proto)
> +{
> +	struct veth_xdp_buff *_ctx = (void *)ctx;
> +	struct sk_buff *skb = _ctx->skb;
> +	int err;
> +
> +	if (!skb)
> +		return -ENODATA;
> +

[..]

> +	err = __vlan_hwaccel_get_tag(skb, vlan_tag);

We probably need to open code __vlan_hwaccel_get_tag here. Because it
returns -EINVAL on !skb_vlan_tag_present where the expectation, for us,
I'm assuming is -ENODATA?

> +	if (err)
> +		return err;
> +
> +	*vlan_proto = skb->vlan_proto;
> +	return err;
> +}
> +
> +static int veth_xdp_rx_csum_lvl(const struct xdp_md *ctx, u8 *csum_level)
> +{
> +	struct veth_xdp_buff *_ctx = (void *)ctx;
> +	struct sk_buff *skb = _ctx->skb;
> +
> +	if (!skb)
> +		return -ENODATA;
> +
> +	if (skb->ip_summed == CHECKSUM_UNNECESSARY)
> +		*csum_level = skb->csum_level;
> +	else if (skb->ip_summed == CHECKSUM_PARTIAL &&
> +		 skb_checksum_start_offset(skb) == skb_transport_offset(skb) ||
> +		 skb->csum_valid)
> +		*csum_level = 0;
> +	else
> +		return -ENODATA;
> +
> +	return 0;
> +}
> +
>  static const struct net_device_ops veth_netdev_ops = {
>  	.ndo_init            = veth_dev_init,
>  	.ndo_open            = veth_open,
> @@ -1756,6 +1794,8 @@ static const struct net_device_ops veth_netdev_ops = {
>  static const struct xdp_metadata_ops veth_xdp_metadata_ops = {
>  	.xmo_rx_timestamp		= veth_xdp_rx_timestamp,
>  	.xmo_rx_hash			= veth_xdp_rx_hash,
> +	.xmo_rx_vlan_tag		= veth_xdp_rx_vlan_tag,
> +	.xmo_rx_csum_lvl		= veth_xdp_rx_csum_lvl,
>  };
>  
>  #define VETH_FEATURES (NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_HW_CSUM | \
> -- 
> 2.41.0
> 

