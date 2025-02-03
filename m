Return-Path: <bpf+bounces-50309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0776EA25114
	for <lists+bpf@lfdr.de>; Mon,  3 Feb 2025 02:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AE94163C65
	for <lists+bpf@lfdr.de>; Mon,  3 Feb 2025 01:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F6B17993;
	Mon,  3 Feb 2025 01:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lN8T4puC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96CCF4FA;
	Mon,  3 Feb 2025 01:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738546355; cv=none; b=KdxZnf+x1zWLkmd/nTI0YUYPv7PrcQQlSQJ7pKXQRoJw3gBnJJ0SxyvCl046SBRlNguIA1uuME/Ksosn9y6mLfJS21saDD6NtIAc57A424NpugoZgvyzqMAcaBuFkGG5XQRXrFQY/+nHULW8tClGXxrETamZuwfsoP/+7PajkbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738546355; c=relaxed/simple;
	bh=dN5f9jjM0DCXRnwKFJdUMSWiBnrg1qPn22llODkACsI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=cmwNM5OEuD7WEs7xJsttwc7aPbbl430kgTY0W1m49CIuYn2QhpBuGtCYEvhqNx6p1NKy9+4iDuo2lrA6JKflHaM3NZt8MuLfWuOAFWV/rZfVdMssnnI+jhgr0LrCqdLX6cJMzwE0cVTJmPf8PLt/kYDCQ2MTitpugaBBbMVuc4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lN8T4puC; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4afd56903b7so1064811137.1;
        Sun, 02 Feb 2025 17:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738546353; x=1739151153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eNsj052nqOVvYLM94Nf+wcinQK63FS1fM6XfTCK/kEQ=;
        b=lN8T4puCBolkq7W0IBFfQkpi9xtvblu3XW+FyoJar8nycfviZSFrZFE2nwVBjjBKTL
         hzqt7875gpWU+MTzyeV7UCa0SunIst72mnYjnkhkWOIn+SeC3ZrubG4+kXUUmE6jywtM
         s5qrNdUlhdGJgmaQ+FzTJRf092OvWEjVvV3OvlZzSjkxDAX1BznzcgpTSZ9sFvst9xVX
         K6WcknPHdNZqQxyK2Le+7K3+lR3sI8ZBBdzXLCLA8evJNK2JNZjHSqSq9jFBfexhYAMY
         YonRqu/Ozw7XQ6hhljQJV5nc0OuZJxb4/KYJFhd55cx9JFDrTa3YtW1XVdpvWZ5rAUhM
         HeIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738546353; x=1739151153;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eNsj052nqOVvYLM94Nf+wcinQK63FS1fM6XfTCK/kEQ=;
        b=ar073qiGcEZZ6aedUqN13ydwhc5glmiYCXTkLM32jq/s0vP5BhvVE8KXqKwTjRzKj9
         yQrKT838l0FciFqvAvxbvPdVBTqBGrf7226Z4OKpLovZy++jHqaNfhGOEIPliK37svsN
         z0UvV/s/2ak66OD7Kg5pt9SZo+jSI6xNf2gSqOa8XnTGZnA4/1gITbeg6KawABUyOWvA
         WwiuIlb2UQlRYnBW9D+yT3GZAA6SO2H3u1OsPJnVVNr5AKY63DNkmLUUBI3/ugckeXbC
         jpjP+L9I6cNi+AWLMhlPK7Wc6aCRvxZxbg+UbGp7h+QZOXakPc/PmjQIlHgIUQuUUdIk
         loWw==
X-Forwarded-Encrypted: i=1; AJvYcCVYQL55tKr6u2g8iw5EKfaM0peHNgagthOGBHRiSAdzz2XBTaj5EReoCBwtqlllgEFXnZ8=@vger.kernel.org, AJvYcCVgPPxecBpNSTVoB+D4hW+WxizoITrG7Vo/oZX1WMp8jZ6niWTz0GS6xiX+YyGEQGVBWmSDKPuCd98kWm/L@vger.kernel.org
X-Gm-Message-State: AOJu0YyCw+reAUyDfQJBhrIbCZBiApXWK9/l7v/jI7mQN0/lfAap3JJi
	g6a00xkQA4T/x8IKiKUMcnAAXGa2gh2xUS/DDM6HHgzImKNgV6Lw
X-Gm-Gg: ASbGnctralDXpDQu6taJV0OgRakxHIVvjySDkCXNehAx0DLEWZ6dQqhewrYUXdRTo7X
	I3LYiAwc/EN6VHkZeu0tJ5jZaVNNZ1UBsEPttMkFElE+fu1RZrNovLRZK450qhyjAtKb7BfWBBv
	fIT6Bg0NzIf/JEBYh7RaZbvJ+DqiTu1tlgQNZ4A2H+mK+aqcZ1a4se0RicuQVjkHuvfaoKNLNjd
	BjhIiXYZ2k4b6OPC5MwMjJIHNudkcKtI3WGuE7w5VBESogY6RtdeDzAuPdDXDbRfBIll+DgQke4
	VF9fU3VZ2OZ1m6sVQjCy9/DO8k9JDcWuQ9jCDRPI41R+8kv1wCVehJOBIdN731o=
X-Google-Smtp-Source: AGHT+IFnMAxMUsCwDteu+W7xJ3mCsa3sz3TXuKHCk7VFYJjvWZN1WywuqoM36/MyQ1tpoKE1LGK14w==
X-Received: by 2002:a05:6102:226a:b0:4b9:bdd8:2091 with SMTP id ada2fe7eead31-4b9bdd82bf9mr6620384137.14.1738546352620;
        Sun, 02 Feb 2025 17:32:32 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b9baad593fsm1398619137.13.2025.02.02.17.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2025 17:32:31 -0800 (PST)
Date: Sun, 02 Feb 2025 20:32:30 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>, 
 Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 jasowang@redhat.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 hawk@kernel.org, 
 john.fastabend@gmail.com
Message-ID: <67a01caec79d1_3bbd8e29416@willemb.c.googlers.com.notmuch>
In-Reply-To: <a1120039-b0a6-4882-be23-7ea1174f8ab7@hetzner-cloud.de>
References: <20250130171614.1657224-1-marcus.wichelmann@hetzner-cloud.de>
 <20250130171614.1657224-2-marcus.wichelmann@hetzner-cloud.de>
 <Z5wIZ2LAjz0wTWg5@mini-arch>
 <a1120039-b0a6-4882-be23-7ea1174f8ab7@hetzner-cloud.de>
Subject: Re: [PATCH 1/1] net: tun: add XDP metadata support
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Marcus Wichelmann wrote:
> Am 31.01.25 um 00:16 schrieb Stanislav Fomichev:
> > On 01/30, Marcus Wichelmann wrote:
> >> Enable the support for bpf_xdp_adjust_meta for XDP buffers initialized
> >> by the tun driver. This is useful to pass metadata from an XDP program
> >> that's attached to a tap device to following XDP/TC programs.
> >>
> >> When used together with vhost_net, the batched XDP buffers were already
> >> initialized with metadata support by the vhost_net driver, but the
> >> metadata was not yet passed to the skb on XDP_PASS. So this also adds
> >> the required skb_metadata_set calls.
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
>     packets from userspace into the tap device. In this case, the xdp_buff
>     created in tun_build_skb has no support for bpf_xdp_adjust_meta and calls
>     of that helper function result in ENOTSUPP.
> 
> 2. tun_xdp_one, which is called by tun_sendmsg which again is called by other
>     drivers (e.g. vhost_net). When the TUN_MSG_PTR mode is used, another driver
>     may pass a batch of xdp_buffs to the tun driver. In this case, that other
>     driver is the one initializing the xdp_buff already. And in the case of
>     vhost_net,  it already initializes the buffer with metadata support (see
>     xdp_prepare_buff call).
>     See 043d222f93ab ("tuntap: accept an array of XDP buffs through sendmsg()")
>     for details.
> 
> This patch enables metadata support for the first code path.
> 
> It also adds the missing skb_metadata_set calls for both code paths.

Thanks for the clarification.

Sounds like this may be better two patches. And some of the
explanation in this thread wrapped into the commit messages.

> This is
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
> >> Signed-off-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
> >> ---
> >>   drivers/net/tun.c | 23 ++++++++++++++++++-----
> >>   1 file changed, 18 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >> index e816aaba8..d3cfea40a 100644
> >> --- a/drivers/net/tun.c
> >> +++ b/drivers/net/tun.c
> >> @@ -1600,7 +1600,8 @@ static bool tun_can_build_skb(struct tun_struct *tun, struct tun_file *tfile,
> >>   
> >>   static struct sk_buff *__tun_build_skb(struct tun_file *tfile,
> >>   				       struct page_frag *alloc_frag, char *buf,
> >> -				       int buflen, int len, int pad)
> >> +				       int buflen, int len, int pad,
> >> +				       int metasize)
> >>   {
> >>   	struct sk_buff *skb = build_skb(buf, buflen);
> >>   
> >> @@ -1609,6 +1610,8 @@ static struct sk_buff *__tun_build_skb(struct tun_file *tfile,
> >>   
> >>   	skb_reserve(skb, pad);
> >>   	skb_put(skb, len);
> >> +	if (metasize)
> >> +		skb_metadata_set(skb, metasize);
> >>   	skb_set_owner_w(skb, tfile->socket.sk);
> >>   
> >>   	get_page(alloc_frag->page);
> >> @@ -1668,6 +1671,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
> >>   	char *buf;
> >>   	size_t copied;
> >>   	int pad = TUN_RX_PAD;
> >> +	int metasize = 0;
> >>   	int err = 0;
> >>   
> >>   	rcu_read_lock();
> >> @@ -1695,7 +1699,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
> >>   	if (hdr->gso_type || !xdp_prog) {
> >>   		*skb_xdp = 1;
> >>   		return __tun_build_skb(tfile, alloc_frag, buf, buflen, len,
> >> -				       pad);
> >> +				       pad, metasize);
> >>   	}
> >>   
> >>   	*skb_xdp = 0;
> >> @@ -1709,7 +1713,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
> >>   		u32 act;
> >>   
> >>   		xdp_init_buff(&xdp, buflen, &tfile->xdp_rxq);
> >> -		xdp_prepare_buff(&xdp, buf, pad, len, false);
> >> +		xdp_prepare_buff(&xdp, buf, pad, len, true);
> >>   
> >>   		act = bpf_prog_run_xdp(xdp_prog, &xdp);
> >>   		if (act == XDP_REDIRECT || act == XDP_TX) {
> >> @@ -1730,12 +1734,16 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
> >>   
> >>   		pad = xdp.data - xdp.data_hard_start;
> >>   		len = xdp.data_end - xdp.data;
> >> +
> >> +		metasize = xdp.data - xdp.data_meta;
> > 
> > [..]
> > 
> >> +		metasize = metasize > 0 ? metasize : 0;
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

Please use min()


