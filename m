Return-Path: <bpf+bounces-57103-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5E3AA5966
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 03:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B96AE1B65958
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 01:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38D61EF39E;
	Thu,  1 May 2025 01:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c292zasy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA42158A09;
	Thu,  1 May 2025 01:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746063290; cv=none; b=HhkTOqUPCRtaNP7BnMSA3LzWfo4U6UaAUmz1gMCTtftEPHYNCaJ3Pmhm4aTY4X2Mm2J5ZiL5K3NPXnv1C+LWc5eCNpBibUfx8YbPEDDUJr5d4wwcCumw61Kki2xuvrARJgqWpICEU7fFy6NUq1QKlm3lp9AOHfhZR1ObUMcDHNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746063290; c=relaxed/simple;
	bh=K4FK1SksihiDRwHS9IOcnoEUnF35eZSZx4EEULu2AdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QATbmVEIHLf7y1gfMRg7DymvGa50zVD5+elhfWWNKPxcD4b+0/mPRpApOf8fwegS0Uan0B8MwH9DtIAf9CZufsEaJGkXtZkLRdnq81g89qKmVVclmm2Rmi1gKjtLYPqY/ebp2ijp6YwoRt9v7R8MkFce8R589IiTJghwFtkDOk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c292zasy; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-73bf5aa95e7so487126b3a.1;
        Wed, 30 Apr 2025 18:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746063288; x=1746668088; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1EJVZoGVPtB0ls/jqlR50tgBETOk68yBgDdBhLsXmyY=;
        b=c292zasyoHycEyFE281T5gs3nCO9GDVejwhA0Ug1ctdbEbsJKAL4QbVdeGd+L0kIoo
         qcPR5n7XKIstVPXpvcH8d+3WTQ5f5+AberzYrDSAIwbwr7tGeHPfzq1NtS1YpAIfyf6k
         kBnfp0MF8v9n5XmISMKLaWRCR/M6lpRbnLXLBygmHf5sutl5909RzakbDcnNORnNweWB
         Ae+5o34/6TootdTIBQRM5uzH/kVZcCXLe/GuDWYB2Di2Keep4S6OybSh2BrM3j8um3Kx
         NjFoj07GSXmHfy3zbtxHOdSu9TzZYVFb6rUMG8+BmrWASzFQS1vcpt7G1nRz+czk+akl
         yItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746063288; x=1746668088;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1EJVZoGVPtB0ls/jqlR50tgBETOk68yBgDdBhLsXmyY=;
        b=M6JHLeR10ui1+WOACBYfgTjkJfdhzQMbzQ0k+K+L8+X31BSvyL+5FubcYsqzmXTd+j
         4S/194hevBUaVeeJw4acbYPdCd3KVTTd4DzXHHy9mgphI65Qv4Q21oDH9I6hzQ7wu4MW
         XD9HpQ1zUKw50IRlcwxPq+zJQJTaUvxKe6M61mrLxb0H9/tQDQmTBg7DoN95toEhKtw6
         A+2F9RoRCIx/JNNvxytIx/BWsMUKJEmfqoAoH9V5Ywwy9Q/4X6Efk1Pv9TQ/YXbYMP4m
         X2DXGto3Fb8WV3tHMp9LXQANtL30HIwMzq/SN4hSFyOEy3vJTtXSeMaCLy5k9TdW/for
         J0hQ==
X-Forwarded-Encrypted: i=1; AJvYcCVh2DxNDeH+fE65uch4xdsK3MwdGdvi/gbIWKFH/w4nGD+gLulimeLtCcOvkucIyUtK4NPSy83k@vger.kernel.org, AJvYcCX07fMyPVpygUCexBbp6aVuVgu7q78sbgX1CEQHp7JQm67ObYT+s3lvFcR3eObhu2eT5UkYmewLeZ8qHm9C@vger.kernel.org, AJvYcCX4sZNT3O2eExFBX08irUWxQR5CrT1bJ8+bAsV5k9rlfkDkuZVi9G/Ks6G2EJYwfI9884k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA5jIP4rqPviOhqvW58uPPSBQD9BG4he4hkTwf6fgJBSsA5tLD
	rE47pZBa10IoKJ76aDOiOWWqw4sG2nMDeDC7Eeas1KEp+B7k8jg=
X-Gm-Gg: ASbGncveXfirXJsBjaibhwL0PM0sDmDLk3pnkmJpx3l0k0e5VW2Pb2QwPWDON+yCjNB
	RxZ78GDM+vZz8lWiOVMNM4oIIEAkwC09tkKPb5C8OQTugfHdHYQckI+MG3E/ujgv3gJuefJfrlk
	Abn99i8ZkUpeNHCDYC526j/4LIHTKhJaDiY5PtbmnordTtkhALRYElt2mqpoFGvX4HEC8bF26sv
	zDdyCtP+8EMl8M9z84tY+20KtsDSsH7T/XecJpSL0y87QVotvER2mIVLy5vgQSDCmJPBJjQMK0v
	dqQNihu9k4Y+IFkvXf5t4RWIGYIxkBns2Smti/v+xy3gND++tdbydH5NQmpnA4XkwfE3YFhtdAq
	mK9+e36OpLw==
X-Google-Smtp-Source: AGHT+IFNsKs/G+y5JObZ9injpFGWoGxzqspTFfuUyi/an9Y5CFE+Wct757N+xfdnPxt028yFjJSkPw==
X-Received: by 2002:a05:6a20:3d8c:b0:204:2936:bce with SMTP id adf61e73a8af0-20bd804a2a9mr1094153637.31.1746063287773;
        Wed, 30 Apr 2025 18:34:47 -0700 (PDT)
Received: from localhost (c-73-170-40-124.hsd1.ca.comcast.net. [73.170.40.124])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b15f7ec0bb2sm11293329a12.18.2025.04.30.18.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 18:34:47 -0700 (PDT)
Date: Wed, 30 Apr 2025 18:34:46 -0700
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
Message-ID: <aBLPtszlDe74yTlk@mini-arch>
References: <20250430201120.1794658-1-jon@nutanix.com>
 <aBKReJUy2Z-JQwr4@mini-arch>
 <32FB9CF5-E5BB-4912-B76D-53971C6B6F98@nutanix.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32FB9CF5-E5BB-4912-B76D-53971C6B6F98@nutanix.com>

On 05/01, Jon Kohler wrote:
> 
> 
> > On Apr 30, 2025, at 5:09 PM, Stanislav Fomichev <stfomichev@gmail.com> wrote:
> > 
> > !-------------------------------------------------------------------|
> >  CAUTION: External Email
> > 
> > |-------------------------------------------------------------------!
> > 
> > On 04/30, Jon Kohler wrote:
> >> Introduce new XDP helpers:
> >> - xdp_headlen: Similar to skb_headlen
> >> - xdp_headroom: Similar to skb_headroom
> >> - xdp_metadata_len: Similar to skb_metadata_len
> >> 
> >> Integrate these helpers into tap, tun, and XDP implementation to start.
> >> 
> >> No functional changes introduced.
> >> 
> >> Signed-off-by: Jon Kohler <jon@nutanix.com>
> >> ---
> >> v1->v2: Integrate feedback from Willem
> >> https://urldefense.proofpoint.com/v2/url?u=https-3A__patchwork.kernel.org_project_netdevbpf_patch_20250430182921.1704021-2D1-2Djon-40nutanix.com_&d=DwIBaQ&c=s883GpUCOChKOHiocYtGcg&r=NGPRGGo37mQiSXgHKm5rCQ&m=9pdxzQszX_M0K3gEPeYOyMZZYSkRR8IMvxslS8320Eoctk58y-ELCdZ5iaryF2GH&s=J-ILB7E9VQ_plo0hyjEtzGzjy6G0_o4MMMmmE_z8vvc&e= 
> >> 
> >> drivers/net/tap.c |  6 +++---
> >> drivers/net/tun.c | 12 +++++------
> >> include/net/xdp.h | 54 +++++++++++++++++++++++++++++++++++++++++++----
> >> net/core/xdp.c    | 12 +++++------
> >> 4 files changed, 65 insertions(+), 19 deletions(-)
> >> 
> >> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> >> index d4ece538f1b2..a62fbca4b08f 100644
> >> --- a/drivers/net/tap.c
> >> +++ b/drivers/net/tap.c
> >> @@ -1048,7 +1048,7 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
> >> struct sk_buff *skb;
> >> int err, depth;
> >> 
> >> - if (unlikely(xdp->data_end - xdp->data < ETH_HLEN)) {
> >> + if (unlikely(xdp_headlen(xdp) < ETH_HLEN)) {
> >> err = -EINVAL;
> >> goto err;
> >> }
> >> @@ -1062,8 +1062,8 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
> >> goto err;
> >> }
> >> 
> >> - skb_reserve(skb, xdp->data - xdp->data_hard_start);
> >> - skb_put(skb, xdp->data_end - xdp->data);
> >> + skb_reserve(skb, xdp_headroom(xdp));
> >> + skb_put(skb, xdp_headlen(xdp));
> >> 
> >> skb_set_network_header(skb, ETH_HLEN);
> >> skb_reset_mac_header(skb);
> >> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >> index 7babd1e9a378..4c47eed71986 100644
> >> --- a/drivers/net/tun.c
> >> +++ b/drivers/net/tun.c
> >> @@ -1567,7 +1567,7 @@ static int tun_xdp_act(struct tun_struct *tun, struct bpf_prog *xdp_prog,
> >> dev_core_stats_rx_dropped_inc(tun->dev);
> >> return err;
> >> }
> >> - dev_sw_netstats_rx_add(tun->dev, xdp->data_end - xdp->data);
> >> + dev_sw_netstats_rx_add(tun->dev, xdp_headlen(xdp));
> >> break;
> >> case XDP_TX:
> >> err = tun_xdp_tx(tun->dev, xdp);
> >> @@ -1575,7 +1575,7 @@ static int tun_xdp_act(struct tun_struct *tun, struct bpf_prog *xdp_prog,
> >> dev_core_stats_rx_dropped_inc(tun->dev);
> >> return err;
> >> }
> >> - dev_sw_netstats_rx_add(tun->dev, xdp->data_end - xdp->data);
> >> + dev_sw_netstats_rx_add(tun->dev, xdp_headlen(xdp));
> >> break;
> >> case XDP_PASS:
> >> break;
> >> @@ -2355,7 +2355,7 @@ static int tun_xdp_one(struct tun_struct *tun,
> >>       struct xdp_buff *xdp, int *flush,
> >>       struct tun_page *tpage)
> >> {
> >> - unsigned int datasize = xdp->data_end - xdp->data;
> >> + unsigned int datasize = xdp_headlen(xdp);
> >> struct tun_xdp_hdr *hdr = xdp->data_hard_start;
> >> struct virtio_net_hdr *gso = &hdr->gso;
> >> struct bpf_prog *xdp_prog;
> >> @@ -2415,14 +2415,14 @@ static int tun_xdp_one(struct tun_struct *tun,
> >> goto out;
> >> }
> >> 
> >> - skb_reserve(skb, xdp->data - xdp->data_hard_start);
> >> - skb_put(skb, xdp->data_end - xdp->data);
> >> + skb_reserve(skb, xdp_headroom(xdp));
> >> + skb_put(skb, xdp_headlen(xdp));
> >> 
> >> /* The externally provided xdp_buff may have no metadata support, which
> >> * is marked by xdp->data_meta being xdp->data + 1. This will lead to a
> >> * metasize of -1 and is the reason why the condition checks for > 0.
> >> */
> >> - metasize = xdp->data - xdp->data_meta;
> >> + metasize = xdp_metadata_len(xdp);
> >> if (metasize > 0)
> >> skb_metadata_set(skb, metasize);
> >> 
> >> diff --git a/include/net/xdp.h b/include/net/xdp.h
> >> index 48efacbaa35d..044345b18305 100644
> >> --- a/include/net/xdp.h
> >> +++ b/include/net/xdp.h
> >> @@ -151,10 +151,56 @@ xdp_get_shared_info_from_buff(const struct xdp_buff *xdp)
> >> return (struct skb_shared_info *)xdp_data_hard_end(xdp);
> >> }
> >> 
> >> +/**
> >> + * xdp_headlen - Calculate the length of the data in an XDP buffer
> >> + * @xdp: Pointer to the XDP buffer structure
> >> + *
> >> + * Compute the length of the data contained in the XDP buffer. Does not
> >> + * include frags, use xdp_get_buff_len() for that instead.
> >> + *
> >> + * Analogous to skb_headlen().
> >> + *
> >> + * Return: The length of the data in the XDP buffer in bytes.
> >> + */
> >> +static inline unsigned int xdp_headlen(const struct xdp_buff *xdp)
> >> +{
> >> + return xdp->data_end - xdp->data;
> >> +}
> >> +
> >> +/**
> >> + * xdp_headroom - Calculate the headroom available in an XDP buffer
> >> + * @xdp: Pointer to the XDP buffer structure
> >> + *
> >> + * Compute the headroom in an XDP buffer.
> >> + *
> >> + * Analogous to the skb_headroom().
> >> + *
> >> + * Return: The size of the headroom in bytes.
> >> + */
> >> +static inline unsigned int xdp_headroom(const struct xdp_buff *xdp)
> >> +{
> >> + return xdp->data - xdp->data_hard_start;
> >> +}
> >> +
> >> +/**
> >> + * xdp_metadata_len - Calculate the length of metadata in an XDP buffer
> >> + * @xdp: Pointer to the XDP buffer structure
> >> + *
> >> + * Compute the length of the metadata region in an XDP buffer.
> >> + *
> >> + * Analogous to skb_metadata_len().
> >> + *
> >> + * Return: The length of the metadata in bytes.
> >> + */
> >> +static inline unsigned int xdp_metadata_len(const struct xdp_buff *xdp)
> > 
> > I believe this has to return int, not unsigned int. There are places
> > where we do data_meta = data + 1, and the callers check whether
> > the result is signed or sunsigned.
> 
> The existing SKB APIs are the exact same return type (I copied them 1:1),
> but I have a feeling that we’re never intending these values to either A) be
> negative and/or B) wrap in strange ways?
> 
> > 
> >> +{
> >> + return xdp->data - xdp->data_meta;
> >> +}
> >> +
> >> static __always_inline unsigned int
> >> xdp_get_buff_len(const struct xdp_buff *xdp)
> >> {
> >> - unsigned int len = xdp->data_end - xdp->data;
> >> + unsigned int len = xdp_headlen(xdp);
> >> const struct skb_shared_info *sinfo;
> >> 
> >> if (likely(!xdp_buff_has_frags(xdp)))
> >> @@ -364,8 +410,8 @@ int xdp_update_frame_from_buff(const struct xdp_buff *xdp,
> >> int metasize, headroom;
> 
> Said another way, perhaps this should be unsigned?
> 
> >> 
> >> /* Assure headroom is available for storing info */
> >> - headroom = xdp->data - xdp->data_hard_start;
> >> - metasize = xdp->data - xdp->data_meta;
> >> + headroom = xdp_headroom(xdp);
> >> + metasize = xdp_metadata_len(xdp);
> >> metasize = metasize > 0 ? metasize : 0;
> > 
> > ^^ like here
> 
> Look across the tree, seems like more are unsigned than signed

The ones that are unsigned are either calling xdp_data_meta_unsupported
explicitly (and it does > to check for this condition, not signed math)
or are running in the drivers that are guaranteed to have metadata
support (and, hence, always have data_meta <= data).

> These ones use unsigned:
> xdp_convert_zc_to_xdp_frame

This uses xdp_data_meta_unsupported

> veth_xdp_rcv_skb
> xsk_construct_skb
> bnxt_copy_xdp
> i40e_build_skb
> i40e_construct_skb_zc
> ice_build_skb (this is u8)
> ice_construct_skb_zc
> igb_build_skb
> igb_construct_skb_zc
> igc_build_skb
> igc_construct_skb
> igc_construct_skb_zc
> ixgbe_build_skb
> ixgbe_construct_skb_zc
> ixgbevf_build_skb
> mvneta_swbm_build_skb
> mlx5e_xsk_construct_skb
> mana_build_skb
> stmmac_construct_skb_zc
> bpf_prog_run_generic_xdp

These run in the drivers that support metadata (data_meta <= data)

> xdp_get_metalen

This uses xdp_data_meta_unsupported

> These ones are regular int:
> xdp_build_skb_from_buff
> xdp_build_skb_from_zc
> xdp_update_frame_from_buff
> tun_xdp_one
> build_skb_from_xdp_buff

These can be called from the drivers that support and don't support 
the metadata, so have to (correctly) use int.

> Perhaps a separate patch to convert the regulars to unsigned,
> thoughts?

Take a look at xdp_set_data_meta_invalid and xdp_data_meta_unsupported.
There are cases where xdp->data - xdp->data_meta is -1 (and the callers
check for this condition), we can't use unsigned unconditionally
(unless we use xdp_data_meta_unsupported).

