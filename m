Return-Path: <bpf+bounces-57105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF294AA59A7
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 04:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F8AF7B7D38
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 02:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA5B22FACE;
	Thu,  1 May 2025 02:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQ76sJoC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72A1C2ED;
	Thu,  1 May 2025 02:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746066419; cv=none; b=lG4fLLjL6AJLQZ10RofLJ0Uj0HY2c31xeCacGJ4t8P1Kd2PdpLPgMLUDXlhOpqhrxLOQ393SZVZOkiKw6i01tN+qB/y/YkK6ElOtlJ3HLlZUFo7bKBYQNK7asHtGQp9wacCpwEFlRCtfLVKcghh2kP2284ftw+a2Obo55A9mXk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746066419; c=relaxed/simple;
	bh=EFrvP0jW5mht/7/5ka9ai18SxKTSXPrfcHN5RFHFpJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSnV97YkXPdeEvX9Fp0FVCsK3t/Ryv3bJ6GopnweV6RbP4Gy0VBYHCmXm/PUXdXeF74Hgih46jlhiBksxl+FQwBbJ1YNlIW79V2Kl8wnpH0RRL68ebJ2TUDkLde26QNjb8NIsk/8PmwAhZFeTmX6Okx7lfFUgIzxAUvJ+adwTno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQ76sJoC; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-736c1cf75e4so506730b3a.2;
        Wed, 30 Apr 2025 19:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746066417; x=1746671217; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AsXSjpDlzlHMcY/o57YlDKr908Ffiw47tWoUmfnrKkA=;
        b=BQ76sJoC84GrNn8pZK9yJ8hoWBlgdkv6UT49gCWNItCs3sXBwcHlTswUMGkHrq/D39
         K/sBYXz5rOAaY5W4V4oNE3DzH5n7YItxH5qF0VjL2lhWYBSuAM9EfV5v6E9UiwKnNMTd
         Pne2o32XCHMTcB5EkQcaFgwGRqpHzx4hmDky3qMwWfONn7pR3HbeiZdnFGpCF/68wHOO
         Hscaxo9yKlZVqCVds3U84gMpIWcsXWLynp86DC7sc9WcB6eAuHC64Kx6dxPtV7mWwI8k
         F8pASiIEcbsqbEauCtlLmB5OrUT6IvnyaXL0VsA2G/DnCs0XMEAalNyMsvBEQ7bbnNBw
         IwmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746066417; x=1746671217;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AsXSjpDlzlHMcY/o57YlDKr908Ffiw47tWoUmfnrKkA=;
        b=L/0AgrBh7xJoD/PTEcyYW6Q9xsHrKx2WUlAKb8VXJBaO6Lw4VOJtc2AK54QrcMiBZT
         va16APLzvN1fOS/3xQ78WZvr170ZBLeBdf/zH/LVau5rpo1C71pTj8QIOSNXFmofeGJt
         0dGyyvWgDr1U3CQvylpqYfnGZBtqPV5uYsdmDBWUSlfYwgg6oBV9U5xRuodPCKrLS9uk
         hvDxZydN2sfyIIyUq/UPLyFGVslg5jzw3Vnfw6A7JjlzIJPHwONTgN0wBqrA/plgXQai
         7GNWAOkZuqTDRPNlD7ZWksKHr/xu8PxR28hpF26A0C0dvtKRSZDWPbnKLLtVasCBQ5Vl
         2hZA==
X-Forwarded-Encrypted: i=1; AJvYcCUKwokwEylBzsLdUvCXUlbRylNr/ITdKrduzxV6aw/y0xAq02/uBhgDfN6s6LCoV/7jMCL02VtqrCpbyHgf@vger.kernel.org, AJvYcCUP8OangwZgQUZ8S9CPHXBJZt6fN3zqVcGyGwVQzVxbvc5e9VZhV2LC3EsNGTO8qc2DPGaajIWy@vger.kernel.org, AJvYcCVNwSiHihI4E3hB734qbTATK1CiJOBF0wCziiq9itugm29xjeS0O6Mi8LtMrPoUDBTE7vM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+2RerZ3NhSis2LaROP94DHhbgv1DdZQ773287yu5Vl1UmNw5C
	I6RRhdvtA7fNW53E6DNfMXSYCw2VXwQx5FCaZw6xWqWQ3PIXPnY=
X-Gm-Gg: ASbGncsxt6hUQlqzlOdQsLqd4tvts8jHWntFSpqoTs7zNPWOWTSxdtOkejK81oo5MNY
	cn/6kh/AkQikthDnqaRE8YYliqUgp1r6AvP3xKpGVeWNV4xYL+Eo1PB2JOWaFwFbZEzdwLit4+j
	qVYr21NfY7t9EpJExmiTlZkEZrVn4YB2jIjUIU8V0LUWAUzIewB8atrnakMmbF3+zdEU6UvRXod
	qhRxdZYiVWb6MNsiXNSB8ZuqjLiEDrz5P42qmLW9fi0AyY5s7eIwFEv5NC9O3XbjyOlkQkbF88t
	8MuMnqx/oRSZJFyRUM7KA1S4vpVkVDjctwPuNU6z+J/B4jPmdZhPSyDhFOCpVr8u47C5dwOlDjo
	=
X-Google-Smtp-Source: AGHT+IHageym6EE6fYnAYRcUHcoYDxmY9WXdc6BGW3qvOSPrgg/ll6IlGx4aOLb3zbRmQiANzWaflA==
X-Received: by 2002:a05:6a00:10ce:b0:73e:2dca:f91b with SMTP id d2e1a72fcca58-74049255508mr1115872b3a.18.1746066416690;
        Wed, 30 Apr 2025 19:26:56 -0700 (PDT)
Received: from localhost (c-73-170-40-124.hsd1.ca.comcast.net. [73.170.40.124])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74039a94845sm2537281b3a.170.2025.04.30.19.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 19:26:56 -0700 (PDT)
Date: Wed, 30 Apr 2025 19:26:55 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jon Kohler <jon@nutanix.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v2] xdp: Add helpers for head length, headroom,
 and metadata length
Message-ID: <aBLb79yyDErh9IS1@mini-arch>
References: <20250430201120.1794658-1-jon@nutanix.com>
 <aBKReJUy2Z-JQwr4@mini-arch>
 <32FB9CF5-E5BB-4912-B76D-53971C6B6F98@nutanix.com>
 <aBLPtszlDe74yTlk@mini-arch>
 <3D448771-8354-46D0-BDFF-449FE1BD1B59@nutanix.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3D448771-8354-46D0-BDFF-449FE1BD1B59@nutanix.com>

On 05/01, Jon Kohler wrote:
> 
> 
> > On Apr 30, 2025, at 9:34 PM, Stanislav Fomichev <stfomichev@gmail.com> wrote:
> > 
> > !-------------------------------------------------------------------|
> >  CAUTION: External Email
> > 
> > |-------------------------------------------------------------------!
> > 
> > On 05/01, Jon Kohler wrote:
> >> 
> >> 
> >>> On Apr 30, 2025, at 5:09 PM, Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >>> 
> >>> !-------------------------------------------------------------------|
> >>> CAUTION: External Email
> >>> 
> >>> |-------------------------------------------------------------------!
> >>> 
> >>> On 04/30, Jon Kohler wrote:
> >>>> Introduce new XDP helpers:
> >>>> - xdp_headlen: Similar to skb_headlen
> >>>> - xdp_headroom: Similar to skb_headroom
> >>>> - xdp_metadata_len: Similar to skb_metadata_len
> >>>> 
> >>>> Integrate these helpers into tap, tun, and XDP implementation to start.
> >>>> 
> >>>> No functional changes introduced.
> >>>> 
> >>>> Signed-off-by: Jon Kohler <jon@nutanix.com>
> >>>> ---
> >>>> v1->v2: Integrate feedback from Willem
> >>>> https://urldefense.proofpoint.com/v2/url?u=https-3A__patchwork.kernel.org_project_netdevbpf_patch_20250430182921.1704021-2D1-2Djon-40nutanix.com_&d=DwIBaQ&c=s883GpUCOChKOHiocYtGcg&r=NGPRGGo37mQiSXgHKm5rCQ&m=9pdxzQszX_M0K3gEPeYOyMZZYSkRR8IMvxslS8320Eoctk58y-ELCdZ5iaryF2GH&s=J-ILB7E9VQ_plo0hyjEtzGzjy6G0_o4MMMmmE_z8vvc&e= 
> >>>> 
> >>>> drivers/net/tap.c |  6 +++---
> >>>> drivers/net/tun.c | 12 +++++------
> >>>> include/net/xdp.h | 54 +++++++++++++++++++++++++++++++++++++++++++----
> >>>> net/core/xdp.c    | 12 +++++------
> >>>> 4 files changed, 65 insertions(+), 19 deletions(-)
> >>>> 
> >>>> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> >>>> index d4ece538f1b2..a62fbca4b08f 100644
> >>>> --- a/drivers/net/tap.c
> >>>> +++ b/drivers/net/tap.c
> >>>> @@ -1048,7 +1048,7 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
> >>>> struct sk_buff *skb;
> >>>> int err, depth;
> >>>> 
> >>>> - if (unlikely(xdp->data_end - xdp->data < ETH_HLEN)) {
> >>>> + if (unlikely(xdp_headlen(xdp) < ETH_HLEN)) {
> >>>> err = -EINVAL;
> >>>> goto err;
> >>>> }
> >>>> @@ -1062,8 +1062,8 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
> >>>> goto err;
> >>>> }
> >>>> 
> >>>> - skb_reserve(skb, xdp->data - xdp->data_hard_start);
> >>>> - skb_put(skb, xdp->data_end - xdp->data);
> >>>> + skb_reserve(skb, xdp_headroom(xdp));
> >>>> + skb_put(skb, xdp_headlen(xdp));
> >>>> 
> >>>> skb_set_network_header(skb, ETH_HLEN);
> >>>> skb_reset_mac_header(skb);
> >>>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >>>> index 7babd1e9a378..4c47eed71986 100644
> >>>> --- a/drivers/net/tun.c
> >>>> +++ b/drivers/net/tun.c
> >>>> @@ -1567,7 +1567,7 @@ static int tun_xdp_act(struct tun_struct *tun, struct bpf_prog *xdp_prog,
> >>>> dev_core_stats_rx_dropped_inc(tun->dev);
> >>>> return err;
> >>>> }
> >>>> - dev_sw_netstats_rx_add(tun->dev, xdp->data_end - xdp->data);
> >>>> + dev_sw_netstats_rx_add(tun->dev, xdp_headlen(xdp));
> >>>> break;
> >>>> case XDP_TX:
> >>>> err = tun_xdp_tx(tun->dev, xdp);
> >>>> @@ -1575,7 +1575,7 @@ static int tun_xdp_act(struct tun_struct *tun, struct bpf_prog *xdp_prog,
> >>>> dev_core_stats_rx_dropped_inc(tun->dev);
> >>>> return err;
> >>>> }
> >>>> - dev_sw_netstats_rx_add(tun->dev, xdp->data_end - xdp->data);
> >>>> + dev_sw_netstats_rx_add(tun->dev, xdp_headlen(xdp));
> >>>> break;
> >>>> case XDP_PASS:
> >>>> break;
> >>>> @@ -2355,7 +2355,7 @@ static int tun_xdp_one(struct tun_struct *tun,
> >>>>      struct xdp_buff *xdp, int *flush,
> >>>>      struct tun_page *tpage)
> >>>> {
> >>>> - unsigned int datasize = xdp->data_end - xdp->data;
> >>>> + unsigned int datasize = xdp_headlen(xdp);
> >>>> struct tun_xdp_hdr *hdr = xdp->data_hard_start;
> >>>> struct virtio_net_hdr *gso = &hdr->gso;
> >>>> struct bpf_prog *xdp_prog;
> >>>> @@ -2415,14 +2415,14 @@ static int tun_xdp_one(struct tun_struct *tun,
> >>>> goto out;
> >>>> }
> >>>> 
> >>>> - skb_reserve(skb, xdp->data - xdp->data_hard_start);
> >>>> - skb_put(skb, xdp->data_end - xdp->data);
> >>>> + skb_reserve(skb, xdp_headroom(xdp));
> >>>> + skb_put(skb, xdp_headlen(xdp));
> >>>> 
> >>>> /* The externally provided xdp_buff may have no metadata support, which
> >>>> * is marked by xdp->data_meta being xdp->data + 1. This will lead to a
> >>>> * metasize of -1 and is the reason why the condition checks for > 0.
> >>>> */
> >>>> - metasize = xdp->data - xdp->data_meta;
> >>>> + metasize = xdp_metadata_len(xdp);
> >>>> if (metasize > 0)
> >>>> skb_metadata_set(skb, metasize);
> >>>> 
> >>>> diff --git a/include/net/xdp.h b/include/net/xdp.h
> >>>> index 48efacbaa35d..044345b18305 100644
> >>>> --- a/include/net/xdp.h
> >>>> +++ b/include/net/xdp.h
> >>>> @@ -151,10 +151,56 @@ xdp_get_shared_info_from_buff(const struct xdp_buff *xdp)
> >>>> return (struct skb_shared_info *)xdp_data_hard_end(xdp);
> >>>> }
> >>>> 
> >>>> +/**
> >>>> + * xdp_headlen - Calculate the length of the data in an XDP buffer
> >>>> + * @xdp: Pointer to the XDP buffer structure
> >>>> + *
> >>>> + * Compute the length of the data contained in the XDP buffer. Does not
> >>>> + * include frags, use xdp_get_buff_len() for that instead.
> >>>> + *
> >>>> + * Analogous to skb_headlen().
> >>>> + *
> >>>> + * Return: The length of the data in the XDP buffer in bytes.
> >>>> + */
> >>>> +static inline unsigned int xdp_headlen(const struct xdp_buff *xdp)
> >>>> +{
> >>>> + return xdp->data_end - xdp->data;
> >>>> +}
> >>>> +
> >>>> +/**
> >>>> + * xdp_headroom - Calculate the headroom available in an XDP buffer
> >>>> + * @xdp: Pointer to the XDP buffer structure
> >>>> + *
> >>>> + * Compute the headroom in an XDP buffer.
> >>>> + *
> >>>> + * Analogous to the skb_headroom().
> >>>> + *
> >>>> + * Return: The size of the headroom in bytes.
> >>>> + */
> >>>> +static inline unsigned int xdp_headroom(const struct xdp_buff *xdp)
> >>>> +{
> >>>> + return xdp->data - xdp->data_hard_start;
> >>>> +}
> >>>> +
> >>>> +/**
> >>>> + * xdp_metadata_len - Calculate the length of metadata in an XDP buffer
> >>>> + * @xdp: Pointer to the XDP buffer structure
> >>>> + *
> >>>> + * Compute the length of the metadata region in an XDP buffer.
> >>>> + *
> >>>> + * Analogous to skb_metadata_len().
> >>>> + *
> >>>> + * Return: The length of the metadata in bytes.
> >>>> + */
> >>>> +static inline unsigned int xdp_metadata_len(const struct xdp_buff *xdp)
> >>> 
> >>> I believe this has to return int, not unsigned int. There are places
> >>> where we do data_meta = data + 1, and the callers check whether
> >>> the result is signed or sunsigned.
> >> 
> >> The existing SKB APIs are the exact same return type (I copied them 1:1),
> >> but I have a feeling that we’re never intending these values to either A) be
> >> negative and/or B) wrap in strange ways?
> >> 
> >>> 
> >>>> +{
> >>>> + return xdp->data - xdp->data_meta;
> >>>> +}
> >>>> +
> >>>> static __always_inline unsigned int
> >>>> xdp_get_buff_len(const struct xdp_buff *xdp)
> >>>> {
> >>>> - unsigned int len = xdp->data_end - xdp->data;
> >>>> + unsigned int len = xdp_headlen(xdp);
> >>>> const struct skb_shared_info *sinfo;
> >>>> 
> >>>> if (likely(!xdp_buff_has_frags(xdp)))
> >>>> @@ -364,8 +410,8 @@ int xdp_update_frame_from_buff(const struct xdp_buff *xdp,
> >>>> int metasize, headroom;
> >> 
> >> Said another way, perhaps this should be unsigned?
> >> 
> >>>> 
> >>>> /* Assure headroom is available for storing info */
> >>>> - headroom = xdp->data - xdp->data_hard_start;
> >>>> - metasize = xdp->data - xdp->data_meta;
> >>>> + headroom = xdp_headroom(xdp);
> >>>> + metasize = xdp_metadata_len(xdp);
> >>>> metasize = metasize > 0 ? metasize : 0;
> >>> 
> >>> ^^ like here
> >> 
> >> Look across the tree, seems like more are unsigned than signed
> > 
> > The ones that are unsigned are either calling xdp_data_meta_unsupported
> > explicitly (and it does > to check for this condition, not signed math)
> > or are running in the drivers that are guaranteed to have metadata
> > support (and, hence, always have data_meta <= data).
> > 
> >> These ones use unsigned:
> >> xdp_convert_zc_to_xdp_frame
> > 
> > This uses xdp_data_meta_unsupported
> > 
> >> veth_xdp_rcv_skb
> >> xsk_construct_skb
> >> bnxt_copy_xdp
> >> i40e_build_skb
> >> i40e_construct_skb_zc
> >> ice_build_skb (this is u8)
> >> ice_construct_skb_zc
> >> igb_build_skb
> >> igb_construct_skb_zc
> >> igc_build_skb
> >> igc_construct_skb
> >> igc_construct_skb_zc
> >> ixgbe_build_skb
> >> ixgbe_construct_skb_zc
> >> ixgbevf_build_skb
> >> mvneta_swbm_build_skb
> >> mlx5e_xsk_construct_skb
> >> mana_build_skb
> >> stmmac_construct_skb_zc
> >> bpf_prog_run_generic_xdp
> > 
> > These run in the drivers that support metadata (data_meta <= data)
> > 
> >> xdp_get_metalen
> > 
> > This uses xdp_data_meta_unsupported
> > 
> >> These ones are regular int:
> >> xdp_build_skb_from_buff
> >> xdp_build_skb_from_zc
> >> xdp_update_frame_from_buff
> >> tun_xdp_one
> >> build_skb_from_xdp_buff
> > 
> > These can be called from the drivers that support and don't support 
> > the metadata, so have to (correctly) use int.
> > 
> >> Perhaps a separate patch to convert the regulars to unsigned,
> >> thoughts?
> > 
> > Take a look at xdp_set_data_meta_invalid and xdp_data_meta_unsupported.
> > There are cases where xdp->data - xdp->data_meta is -1 (and the callers
> > check for this condition), we can't use unsigned unconditionally
> > (unless we use xdp_data_meta_unsupported).
> 
> Ah! Good catch, and thank you for helping me to understand that,
> I appreciate it. About to turn in for the evening, will wait for any more
> comments and I’m happy to send out a v3.
> 
> One thought is that I stumbled upon xdp_get_metalen in filter.c. I wonder it
> would make sense to pirate that logic and move it into xdp.h? That might be
> a simply solution here that would allow us to keep unsigned like SKB API?
> 
> Happy to take feedback either way. 

I'd keep it signed for now, we don't have to match skb interfaces.
In theory it should generate better code (one conditional jmp vs two in
the unsigned case):
- https://godbolt.org/z/xdh7fPxrz
- https://godbolt.org/z/5dvPoGxqd

