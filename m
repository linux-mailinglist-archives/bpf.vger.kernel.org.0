Return-Path: <bpf+bounces-50265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDF4A246EE
	for <lists+bpf@lfdr.de>; Sat,  1 Feb 2025 04:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B22EB3A883D
	for <lists+bpf@lfdr.de>; Sat,  1 Feb 2025 03:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E08153363;
	Sat,  1 Feb 2025 03:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adytjhAl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3A933E1;
	Sat,  1 Feb 2025 03:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738381169; cv=none; b=Kfa6lSG9q5EYbSieaWb3o1emuiqLS2WcpZZefJJFN/eze7UbEnkzUJCufg7ReIdhSbhit7WT/pYiqNundoMF/VfbVD6DZ0wjxbURtbpmcJ+v264Cssq0Ypy+dsQ7qEV9WGJ16T1qKmXJMEsrD75T7peRMKyp0VoVWxFXhy18gmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738381169; c=relaxed/simple;
	bh=wCwKfPQ5j35oRo9TmwWKNstqcLvRIxHfyfhKNl29hXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7M7Qy92MPDdFU2qTAcU8F2/ZfxrkVFe6KRV4kvoVfP+UyBD1duAl4NKg2GsVZkuQxYh2hiiVT0gRGy+HEU0WiYG/Larce7PZsiPjmObntrY54CSw/lDcMCOd2c5Voc5PCr6oTzZJhpdunpeQ+q4lOi3EcP2HoFMbrFV86Sk9x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adytjhAl; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21619108a6bso46227665ad.3;
        Fri, 31 Jan 2025 19:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738381167; x=1738985967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uLd6289gn1moH4/PV+xrUGhkHNww3B56UM7DKW02haY=;
        b=adytjhAlLb6TEz4/1OwPadytKJrjiLHXfa5rwxBosvWDFC0po2t4DVm1n36WLBC2nv
         gfNd96BSua9xqeHvYcb1wj1yzJSIvDGCjOhG9uKl/4Lw96GaYhlT8a+DNOVdI77PhN0v
         fxBBH8j1ot50X0LdNb45VcWA2Nj84KQyj5W+660U3yMZwIZCbHDUOpg8qMRXX7+gqEnW
         pgf5CITHcplidaKlbg7U2R/dckONbu5RjYGoIs77UfIzGRNsxg+qR6Tj1WK1V4kLVQyf
         +wyy0s7Pllt6K6q5X1uVu8cdeapL47lPbUHyKYNK3aJ82jiit6xstNPnxX8vWNpdLmT+
         Nl7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738381167; x=1738985967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLd6289gn1moH4/PV+xrUGhkHNww3B56UM7DKW02haY=;
        b=TjTXYdiMwnqEdlP4SenQ6Xo60KBsCn++oAKtglei2zJVzaVt5zKkSFIL+PQRX0VcTU
         45Gk/5+whS4cxaOMHqepg353eGOzew28LbD9/ggWy6u5XWtEcbTPKLkSGjUZRKZb7tYS
         73DCBc4kjG1mHyGVLMG8YjGDc/oZmhBsHsj9CdBLjkoXaZT5Bl1j1HBw65+W+DD/l6Bb
         OaKPg32DnlkEITRIULBFDO+XR4cdV0tJTbQtKwSbyRdCye2bKs8wyLyyhaDKKXxKdvlF
         J1Iw/oCOJAIho16A5qvAQXSXA7zf7+F7rsrStZ+6qqObv5LCWsGYvVuhMtMyryv7cMb7
         feoA==
X-Forwarded-Encrypted: i=1; AJvYcCWnZou0IIMwx4FJYxtfebF1O4Y7f/oJvD9Dp02PzcgfFBap92Ybk6e2dH31MWxE6mc/X8A=@vger.kernel.org, AJvYcCX6VJZoNbEo0D8M83AWVil80ME/YQM9k9y9P4HM/tI9MiGPsEFPzjUTTuONRfZ5mDOQbmh3/nuBhQ67EI04@vger.kernel.org
X-Gm-Message-State: AOJu0YwAlH6Vy0VaU7lCF0rXy5uMSf3inkCoAFftpaELiCMNhVZk0COJ
	2q84qBnYmTc1wqbI7DO9nTV+eiieAYhoSiAgpSI3L9xunpCuynpN9IB3
X-Gm-Gg: ASbGnct3E2VcWv8HfFu0ZMsdFWSNBjWZ+7GaO+h0nWMc9TBd72G0UCO766xWqrcg+nM
	Q2QDle0DaCweimXeeAU6gqalCekwH9OghPEf2Bi35N5ZG4HVFkTTffjFQEPbRipgoOOmTsyKq9I
	m/BienCd1Ts3CW7FgQ5gPyiOsQSFgS17X0UnImpVu7bTORP+3H2nr96xXE4mOv4hhL27mMM/Hs6
	yE8yjb0xiEMqxRnXoxu9QX+UQcz7fWdLg+d/9K8VBX5IjVEsw5jgOK2Z4krezcFFIAXDLMt6g0M
	MN5/9ylK02T/CfI=
X-Google-Smtp-Source: AGHT+IH0+YBjbxK5qMHtWpRLn9GTgwtuLuyXq3DC0KCVE/OuTYo9TgOcMt9qOqgOPQ2Ur1g5nH3c1g==
X-Received: by 2002:a17:902:d4c3:b0:216:4e9f:4ebe with SMTP id d9443c01a7336-21dd7de213cmr188799265ad.42.1738381166905;
        Fri, 31 Jan 2025 19:39:26 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21de330758csm37003665ad.194.2025.01.31.19.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 19:39:26 -0800 (PST)
Date: Fri, 31 Jan 2025 19:39:25 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com
Subject: Re: [PATCH 1/1] net: tun: add XDP metadata support
Message-ID: <Z52Xbb8oEsimsl1B@mini-arch>
References: <20250130171614.1657224-1-marcus.wichelmann@hetzner-cloud.de>
 <20250130171614.1657224-2-marcus.wichelmann@hetzner-cloud.de>
 <Z5wIZ2LAjz0wTWg5@mini-arch>
 <a1120039-b0a6-4882-be23-7ea1174f8ab7@hetzner-cloud.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a1120039-b0a6-4882-be23-7ea1174f8ab7@hetzner-cloud.de>

On 01/31, Marcus Wichelmann wrote:
> Am 31.01.25 um 00:16 schrieb Stanislav Fomichev:
> > On 01/30, Marcus Wichelmann wrote:
> > > Enable the support for bpf_xdp_adjust_meta for XDP buffers initialized
> > > by the tun driver. This is useful to pass metadata from an XDP program
> > > that's attached to a tap device to following XDP/TC programs.
> > > 
> > > When used together with vhost_net, the batched XDP buffers were already
> > > initialized with metadata support by the vhost_net driver, but the
> > > metadata was not yet passed to the skb on XDP_PASS. So this also adds
> > > the required skb_metadata_set calls.
> > 
> > Can you expand more on what kind of metadata is present with vhost_net
> > and who fills it in? Is it virtio header stuff? I wonder how you
> > want to consume it..
> 
> Hm, my commit message may have been a bit misleading.
> 
> I'm talking about regular support for the bpf_xdp_adjust_meta helper
> function. This allows to reserve a metadata area that is useful to pass
> any information from one XDP program to another one, for example when
> using tail-calls.
> 
> Whether it can be used in an XDP program depends on how the xdp_buff
> was initialized. Most net drivers initialize the xdp_buff in a way, that
> allows bpf_xdp_adjust_meta to be used. In case of the tun driver, this is
> not always the case.
> 
> There are two code paths in the tun driver that lead to a bpf_prog_run_xdp:
> 
> 1. tun_build_skb, which is called by tun_get_user and is used when writing
>    packets from userspace into the tap device. In this case, the xdp_buff
>    created in tun_build_skb has no support for bpf_xdp_adjust_meta and calls
>    of that helper function result in ENOTSUPP.
> 
> 2. tun_xdp_one, which is called by tun_sendmsg which again is called by other
>    drivers (e.g. vhost_net). When the TUN_MSG_PTR mode is used, another driver
>    may pass a batch of xdp_buffs to the tun driver. In this case, that other
>    driver is the one initializing the xdp_buff already. And in the case of
>    vhost_net,  it already initializes the buffer with metadata support (see
>    xdp_prepare_buff call).
>    See 043d222f93ab ("tuntap: accept an array of XDP buffs through sendmsg()")
>    for details.
> 
> This patch enables metadata support for the first code path.
> 
> It also adds the missing skb_metadata_set calls for both code paths. This is
> important when the attached XDP program returns with XDP_PASS, because then
> the code continues with creating an skb and that skb should be aware of the
> metadata area's size. At a later stage, a TC program, for example, can then
> access the metadata again using __sk_buff->data_meta.
> 
> So I'm doing not much new here but am rather enabling a feature that is
> supported by other drivers already.
> 
> > Can you also add a selftest to use this new functionality?
> 
> Of course, I'll see what I can do.
> 
> > > Signed-off-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
> > > ---
> > >   drivers/net/tun.c | 23 ++++++++++++++++++-----
> > >   1 file changed, 18 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > > index e816aaba8..d3cfea40a 100644
> > > --- a/drivers/net/tun.c
> > > +++ b/drivers/net/tun.c
> > > @@ -1600,7 +1600,8 @@ static bool tun_can_build_skb(struct tun_struct *tun, struct tun_file *tfile,
> > >   static struct sk_buff *__tun_build_skb(struct tun_file *tfile,
> > >   				       struct page_frag *alloc_frag, char *buf,
> > > -				       int buflen, int len, int pad)
> > > +				       int buflen, int len, int pad,
> > > +				       int metasize)
> > >   {
> > >   	struct sk_buff *skb = build_skb(buf, buflen);
> > > @@ -1609,6 +1610,8 @@ static struct sk_buff *__tun_build_skb(struct tun_file *tfile,
> > >   	skb_reserve(skb, pad);
> > >   	skb_put(skb, len);
> > > +	if (metasize)
> > > +		skb_metadata_set(skb, metasize);
> > >   	skb_set_owner_w(skb, tfile->socket.sk);
> > >   	get_page(alloc_frag->page);
> > > @@ -1668,6 +1671,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
> > >   	char *buf;
> > >   	size_t copied;
> > >   	int pad = TUN_RX_PAD;
> > > +	int metasize = 0;
> > >   	int err = 0;
> > >   	rcu_read_lock();
> > > @@ -1695,7 +1699,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
> > >   	if (hdr->gso_type || !xdp_prog) {
> > >   		*skb_xdp = 1;
> > >   		return __tun_build_skb(tfile, alloc_frag, buf, buflen, len,
> > > -				       pad);
> > > +				       pad, metasize);
> > >   	}
> > >   	*skb_xdp = 0;
> > > @@ -1709,7 +1713,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
> > >   		u32 act;
> > >   		xdp_init_buff(&xdp, buflen, &tfile->xdp_rxq);
> > > -		xdp_prepare_buff(&xdp, buf, pad, len, false);
> > > +		xdp_prepare_buff(&xdp, buf, pad, len, true);
> > >   		act = bpf_prog_run_xdp(xdp_prog, &xdp);
> > >   		if (act == XDP_REDIRECT || act == XDP_TX) {
> > > @@ -1730,12 +1734,16 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
> > >   		pad = xdp.data - xdp.data_hard_start;
> > >   		len = xdp.data_end - xdp.data;
> > > +
> > > +		metasize = xdp.data - xdp.data_meta;
> > 
> > [..]
> > 
> > > +		metasize = metasize > 0 ? metasize : 0;
> > 
> > Why is this part needed?
> 
> When an xdp_buff was initialized withouth metadata support (meta_valid
> argument of xdp_prepare_buff is false), then data_meta == data + 1.
> So this check makes sure that metadata was supported for the given xdp_buff
> and metasize is not -1 (data - data_meta).
> 
> But you have a good point here: Because we have control over the
> initialization of xdp_buff in the tun_build_skb function (first code path),
> we know, that metadata is always supported for that buffer and metasize
> is never < 0. So this check is redundant and I'll remove it.
> 
> But in the tun_xdp_one function (second code path), I'd prefer to keep that
> check, as the xdp_buff is externally passed to tun_sendmsg and the tun driver
> should probably not make assumptions about the metadata support of buffers
> created by other drivers (e.g. vhost_net).
> 
> Thank you for taking a look, I hope things are more clear now.

Thanks for the explanations, makes sense. Please follow up with a
selftest (in tools/testing/selftests/bpf) and take a look at [0] to route it
to the proper bpf-next subtree (unless netdev folks prefer to take it via
net-next).

0: https://www.kernel.org/doc/html/latest/bpf/bpf_devel_QA.html

