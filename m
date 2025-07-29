Return-Path: <bpf+bounces-64606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A68E0B14BEA
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 12:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 640331AA4B00
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 10:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24508288C0D;
	Tue, 29 Jul 2025 10:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWQEf1Kw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25C32882D3;
	Tue, 29 Jul 2025 10:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753783593; cv=none; b=aRZhgVcjvglP33j9iafaSJe3Mx88OmfRCLqoZSt5QIW2YXPfvSmRsTwIMI3lqOQXd+Wh8UCDM2y5gnCSuNrYaTQB6SexUq/yOasGHWr6ucFL3laO7jxisKcIAMESEP+iaQW6IMGVvRcnCT3f52FlwmPFnLdXeOexkvStbSc6Rmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753783593; c=relaxed/simple;
	bh=rwqc6ZdOVfKMgpH/GvJTRTBI/ETqCD8YkIwHBPZ0kR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p31gMVS+Z7JmlL82AOi7JB2pDj8NGX0r8bmV3AMujXAEmBtKAoqgWiCU5dKEh2Au38ZGxPSTIZCcRNIszPktjPsongNWxMiPopI8b5aYFB4CQQ5wkk2NBk3kOkhn/UVScfHQKq/Uq6fH4HtkqhWylDCxvAaR5WaNv35myGeyHFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWQEf1Kw; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-455fdfb5d04so29122675e9.2;
        Tue, 29 Jul 2025 03:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753783590; x=1754388390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mdXN7Iex4BK1HyIVUk7Q0aYT6k4ehYGtHeixZxZQAkM=;
        b=MWQEf1Kw7Gg+D7rJsmFUaYrOfIpyQkl1hf897eIBHrKk6YlSH8nAw2xZ81zhgmZhWd
         GS1fhhqo9mWjYOEeNE1qHp2dfltAAS69wQskv1QSqXRhZgF1HDq0eG1nAJEe6f77D1NU
         5rpIIl5OixumfMy0CjvSECLPObfOLt9iktGrKDTPQexwAX1xUNXjllva5ONnLGFncqp2
         tueRrUSX5+fbMv1YoTYPeqv1nX7G7Tmxub1Lby7IOe+plmCZYXskT1Nr6oAeCaijrMJM
         CuyPoQRBxmATsxzMfBXkLxO8tE1zKBNNCk8tAh/rfibfTT3+AbpatxXKQiTBDDlHF57V
         zIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753783590; x=1754388390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mdXN7Iex4BK1HyIVUk7Q0aYT6k4ehYGtHeixZxZQAkM=;
        b=SjMQPVJUCGIxKdpFoWMiNNLwOUAyPwgWv02UmnFV19uB/jvgAOwMPeaZKfWHiZHvbY
         aETuVH4xdfKTo4jHO3OzT6SoksMJFe+Ce5zaoLJ+nGl9OKL0IEXdCnVEPV9c/+ikcIGp
         lWUcLoymVQu8d/CN1G5+MNqBxcC+Cmt9RFFjsfwREqx2Z1Sb+9da1b9QMcJODlgRC2Zs
         75vEA4/wLlNzu4Pf8eronl3CSYB3RZTMR3DoE2sgEVNmZYvsM9KGkR7xqUd/5zEerbqX
         rzCZW5yME6qtJ2b0NnfJqpRRtUYZ6KC2zViNUE6TyF8BqBBQyDf/ezgbIqzvIz0aOL5W
         yDHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUckcoMB8zjqqXGIKR2kwBuO+CdOLNwclbDiL4jTFAKxuh+Co9OE3M3KNB4u8qTOvkBiS2EixLLILbQfjvuZ3ri@vger.kernel.org, AJvYcCUgxOV3KAdQ/kL4ZU9yYkxDJIt/jvxDBTi3sxE8hAAqIPeKNPJ0ULJgEDfbOzJQ8F/r1gZFYGvi@vger.kernel.org, AJvYcCWaT/W5088Qt/ChDMDc9qiaTrkHh7XVLqiw+WFrAjWYOMRazca53THF8J9631aCp05i4ho=@vger.kernel.org
X-Gm-Message-State: AOJu0YzztwyAYW37B5RUSGYtImc7vXbMXqMPjyvK3Fx/W3Fy7cGHsk+O
	eSieFnmhtVlEek8CXfTC2WSRMdu+aBlD9nfyEBETiaovd66Qre720+op
X-Gm-Gg: ASbGnctPNcmNB1zPXNfSlH8WUCZR8HaQZsb0UGX14yH5Pr2hxBQVbtrJWTjGEmodsBM
	12X8zdtch57PCOIHUa2BpsX5VGdF3FgnF+8skV6z2QTJUXwn11f/WC/aROQ48GXr49b1oWIJt44
	QyAeilbVYvvUiwipNvpP+gOEOeD0n1kGDjr9iV2+3hbki6AVQPWC+XQlV/6NGDGXQNKr48oef94
	z3RxafSbSq9PbrX9gb8glmPLWwsqmE20MEI1K2EHy1Eo1rPJO0I88IYREp3dwIKkNtREVqJReLc
	3jl10ftYLUrmeCtT7kq8S2to1rwQjAjddFUoxJrWL3qQ6O0pgmGDQbiPfFPIA9dL47pomv8I4Ae
	BIQvRh4LHeomOY7KC+D+dT69LIscW6BB2CqPgRPBTIGl01ZxXnAN30aw=
X-Google-Smtp-Source: AGHT+IFpV/5AQ7Le9es/B08A2PqUmoRpsyrCJrzXn4belGHLzurWA4MhsXCXoDQ9TRT225Ganr19WA==
X-Received: by 2002:a05:600c:4749:b0:456:1e4a:bb5b with SMTP id 5b1f17b1804b1-458765551c5mr111140555e9.32.1753783590072;
        Tue, 29 Jul 2025 03:06:30 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587272b405sm167860195e9.19.2025.07.29.03.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 03:06:29 -0700 (PDT)
Date: Tue, 29 Jul 2025 12:06:26 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org,
	bpf@vger.kernel.org, coreteam@netfilter.org, daniel@iogearbox.net,
	fw@strlen.de, john.fastabend@gmail.com, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
	pablo@netfilter.org, lkp@intel.com
Subject: Re: [PATCH bpf-next v3 3/4] bpf: add bpf_icmp_send_unreach
 cgroup_skb kfunc
Message-ID: <aIidIq2EM--Ugp6f@gmail.com>
References: <202507270940.kXGmRbg5-lkp@intel.com>
 <20250728094345.46132-1-mahe.tardy@gmail.com>
 <20250728094345.46132-4-mahe.tardy@gmail.com>
 <b3f25e61-7b0c-4576-baae-9b498c3b8748@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3f25e61-7b0c-4576-baae-9b498c3b8748@linux.dev>

On Mon, Jul 28, 2025 at 06:05:26PM -0700, Martin KaFai Lau wrote:
> On 7/28/25 2:43 AM, Mahe Tardy wrote:
> > This is needed in the context of Tetragon to provide improved feedback
> > (in contrast to just dropping packets) to east-west traffic when blocked
> > by policies using cgroup_skb programs.
> > 
> > This reuse concepts from netfilter reject target codepath with the
> > differences that:
> > * Packets are cloned since the BPF user can still return SK_PASS from
> >    the cgroup_skb progs and the current skb need to stay untouched
> 
> This needs more details. Which field(s) of the skb are changed by the kfunc,
> the skb_dst_set in ip[6]_route_reply_fetch_dst() and/or the code path in the
> icmp[v6]_send() ?

Okay I can add that: "ip[6]_route_reply_fetch_dst set the dst of the skb
by using the saddr as a daddr and routing it", I don't think
icmp[v6]_send touches the skb?

> 
> >    (cgroup_skb hooks only allow read-only skb payload).
> > * Since cgroup_skb programs are called late in the stack, checksums do
> >    not need to be computed or verified, and IPv4 fragmentation does not
> >    need to be checked (ip_local_deliver should take care of that
> >    earlier).
> > 
> > Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> > ---
> >   net/core/filter.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 61 insertions(+)
> > 
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 7a72f766aacf..050872324575 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -85,6 +85,10 @@
> >   #include <linux/un.h>
> >   #include <net/xdp_sock_drv.h>
> >   #include <net/inet_dscp.h>
> > +#include <linux/icmp.h>
> > +#include <net/icmp.h>
> > +#include <net/route.h>
> > +#include <net/ip6_route.h>
> > 
> >   #include "dev.h"
> > 
> > @@ -12148,6 +12152,53 @@ __bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern *skops,
> >   	return 0;
> >   }
> > 
> > +__bpf_kfunc int bpf_icmp_send_unreach(struct __sk_buff *__skb, int code)
> > +{
> > +	struct sk_buff *skb = (struct sk_buff *)__skb;
> > +	struct sk_buff *nskb;
> > +
> > +	switch (skb->protocol) {
> > +	case htons(ETH_P_IP):
> > +		if (code < 0 || code > NR_ICMP_UNREACH)
> > +			return -EINVAL;
> > +
> > +		nskb = skb_clone(skb, GFP_ATOMIC);
> > +		if (!nskb)
> > +			return -ENOMEM;
> > +
> > +		if (ip_route_reply_fetch_dst(nskb) < 0) {
> > +			kfree_skb(nskb);
> > +			return -EHOSTUNREACH;
> > +		}
> > +
> > +		icmp_send(nskb, ICMP_DEST_UNREACH, code, 0);
> > +		kfree_skb(nskb);
> > +		break;
> > +#if IS_ENABLED(CONFIG_IPV6)
> > +	case htons(ETH_P_IPV6):
> > +		if (code < 0 || code > ICMPV6_REJECT_ROUTE)
> > +			return -EINVAL;
> > +
> > +		nskb = skb_clone(skb, GFP_ATOMIC);
> > +		if (!nskb)
> > +			return -ENOMEM;
> > +
> > +		if (ip6_route_reply_fetch_dst(nskb) < 0) {
> 
> From a very quick look at icmpv6_send(), it does its own route lookup. I
> haven't looked at the v4 yet.
> 
> I am likely missing some details. Can you explain why it needs to do a
> lookup before calling icmpv6_send()?

From my understanding, I need to do this to invert the daddr with the
saddr to send the unreach message back to the sender.

> 
> > +			kfree_skb(nskb);
> > +			return -EHOSTUNREACH;
> > +		}
> > +
> > +		icmpv6_send(nskb, ICMPV6_DEST_UNREACH, code, 0);
> > +		kfree_skb(nskb);
> > +		break;
> > +#endif
> > +	default:
> > +		return -EPROTONOSUPPORT;
> > +	}
> > +
> > +	return SK_DROP;
> > +}
> > +

