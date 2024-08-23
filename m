Return-Path: <bpf+bounces-37941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A11995CBC6
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 13:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 913FF1C20A93
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 11:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBF918787F;
	Fri, 23 Aug 2024 11:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="LVKUqzQ4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DE815382E
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 11:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724414146; cv=none; b=KsvkLlo4/tKZQwv+HraOkN0Ctwq70zjJkXwixdv9mqfURJ05vFyrgY1pd9IwuVA2ooI98/AYBvmiMpoImPtRJxz3SCGDEb3R6R0TI4BA/qkfZ1uFdJVUnVTg3xbfxJEYi1PfmShxwYeWPSf/8KX4Z3Uu4h+kWpbRVEPlxb0TFls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724414146; c=relaxed/simple;
	bh=OAw1ctritTsq/dMDRD2dD5NaMmegvf7DkNQKeVfjH38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXxRSDsaPc7xcpiZwt7mVeQhjxgtIO8TkMojJL3s+Bqhd53SOSpE0ft0hDWIyH8ibjBWDUClBy853zFAfsicazAa7zyteumotG82z37QqKPG7tFlHNueSX2sibrKRdjTQlpGlTLySDWLUzpHPFwcqqkCBg3MYehVD9a2Q//e3FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=LVKUqzQ4; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a86859e2fc0so229627166b.3
        for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 04:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1724414142; x=1725018942; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D4BFrh763eCa6FHGzYT0flqYQBNlmub8RNPp8zn1r7E=;
        b=LVKUqzQ4KGjvtvMrZr6glQbvAJFLUHeiMGrh0p6D9laRZsSXN++7NZra/tEZqakd2H
         6Duc2PYSO3gVbafOSsvtYv1QaPWzjo8kK0yPEXoUcf8A+idMIoFFRcqG/lueIeCSQcrj
         JqfrxwJX6kMV7borr0aV4T3lvrD1Yiox/W6L16wrONrav8IleEzMZ/x4QRJsKe1DBFbD
         TtevtnT6e45GrDq84FCiaW+FKzh6bKccbaT/P9mFnanHb/D66vKwHkQf9YVK8k5q5Xh9
         9Gi0oC0abw3/15YxNAxtuzNsb+Gtoj1mZ2UK3mjAGDSqZyipz35R8RmHQ8Sy/MdqdwaV
         rg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724414142; x=1725018942;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D4BFrh763eCa6FHGzYT0flqYQBNlmub8RNPp8zn1r7E=;
        b=w9tGfTt390NuYsFNpdE22qyIunkqdtmD0faDv7igPZ1OtsBS3npDEha4XBqhnGHBn8
         pAtYR1NKmsIyW28Y+z923LUvdnbi7dZeig3Q9y6cJm8u6qXM9Fm5eTSAlKWLjqRWAbO+
         /96/35r+0Prjptf2qFXcthE880ewo1HNOhcWf+qyKfkPhqiszYi+AltBKar/JFPuDfxi
         sED4aYjDulN5xXmhar4WleBLH+rF4EWz/2cMHv9TzQf8g1YQc5dgs0VNZDfVXAzCFK9t
         Zibs2qB7Ct9jHS6Hyp5M3sbpm6txK11DOitA2yNQ8dx+qnY5jIs+LqlFHgcR2QjoZ7Dn
         DpGw==
X-Forwarded-Encrypted: i=1; AJvYcCXBhxniv10eyBOFDT0afmb86Kqtr81nLq8isCuwT3KexK+crgJPypVqpfSrWbYrxufqqyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaQfbC4is9MuS3W9hdjPOQ0QKnI95ohBahWjQaSEu7lJAm8tFq
	hSGco1IwyPUfoWQcJ+H31yhw76Ji5VB6DPjIpM2H7qvBrOmyGdT5ifazTh26I+Q=
X-Google-Smtp-Source: AGHT+IHc/MhbYWOLkuVUYhr6jE4YNr3rrbrwk4qzS4Q0NsvUyW8HecvlKHYggdIaUYJD+LQvJaCBAw==
X-Received: by 2002:a17:906:d54c:b0:a86:9ac9:f3fa with SMTP id a640c23a62f3a-a86a54aa691mr169687166b.50.1724414141884;
        Fri, 23 Aug 2024 04:55:41 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f47d1dfsm252646566b.149.2024.08.23.04.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 04:55:41 -0700 (PDT)
Date: Fri, 23 Aug 2024 13:55:40 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Feng zhou <zhoufeng.zf@bytedance.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, bigeasy@linutronix.de,
	lorenzo@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	yangzhenze@bytedance.com, wangdongdong.6@bytedance.com,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Subject: Re: [PATCH bpf-next v2] net: Don't allow to attach xdp if bond slave
 device's upper already has a program
Message-ID: <Zsh4vPAPBKdRUq8H@nanopsycho.orion>
References: <20240823084204.67812-1-zhoufeng.zf@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240823084204.67812-1-zhoufeng.zf@bytedance.com>

Fri, Aug 23, 2024 at 10:42:04AM CEST, zhoufeng.zf@bytedance.com wrote:
>From: Feng Zhou <zhoufeng.zf@bytedance.com>
>
>Cannot attach when an upper device already has a program, This
>restriction is only for bond's slave devices or team port, and
>should not be accidentally injured for devices like eth0 and vxlan0.

What if I attach xdp program to solo netdev and then I enslave it
to bond/team netdev that already has xdp program attached?
What prevents me from doing that?


>
>Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
>Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
>---
>Changelog:
>v1->v2: Addressed comments from Paolo Abeni, Jiri Pirko
>- Use "netif_is_lag_port" relace of "netif_is_bond_slave"
>Details in here:
>https://lore.kernel.org/netdev/3bf84d23-a561-47ae-84a4-e99488fc762b@bytedance.com/T/
>
> net/core/dev.c | 10 ++++++----
> 1 file changed, 6 insertions(+), 4 deletions(-)
>
>diff --git a/net/core/dev.c b/net/core/dev.c
>index f66e61407883..49144e62172e 100644
>--- a/net/core/dev.c
>+++ b/net/core/dev.c
>@@ -9502,10 +9502,12 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
> 	}
> 
> 	/* don't allow if an upper device already has a program */
>-	netdev_for_each_upper_dev_rcu(dev, upper, iter) {
>-		if (dev_xdp_prog_count(upper) > 0) {
>-			NL_SET_ERR_MSG(extack, "Cannot attach when an upper device already has a program");
>-			return -EEXIST;
>+	if (netif_is_lag_port(dev)) {
>+		netdev_for_each_upper_dev_rcu(dev, upper, iter) {
>+			if (dev_xdp_prog_count(upper) > 0) {
>+				NL_SET_ERR_MSG(extack, "Cannot attach when an upper device already has a program");
>+				return -EEXIST;
>+			}
> 		}
> 	}
> 
>-- 
>2.30.2
>

