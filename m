Return-Path: <bpf+bounces-63218-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF331B044F1
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 18:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BECFE1A60ED1
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 16:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680CF14D29B;
	Mon, 14 Jul 2025 16:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="micpndqh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFE42561D1;
	Mon, 14 Jul 2025 16:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752509004; cv=none; b=Y14w+P27IICfXcYV7tQZ6c27B2UweiBXl4L8ZjEve9+xB59BaH/geYm+SWaukh0K7jqyOFkoZ3Etdn08PnZSkPk0n3sb8hiMzAJ65NEHjZpjwgpDDIUi8kCL93dptJxEzFgLDTOzwnjLvdwhWEnInpE3nbukBniHrr8opwLwPv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752509004; c=relaxed/simple;
	bh=aQFCSlgl6zqpImdWrVzV1OSQUGueQ6jLI4cVl7nPKb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdGblFTIflnW0ooR+PrynyG9ApLlJr4I5V+eZnSkTJdKY0zWNZCUNRYuslJmHBOPb/ItaL1p8RLd+wjf6/zDJJ9iuX/GWdzWcj5ubN8i+J0bGMLO4uGKmF0P8XKdLBeAtGAHr+sNrfb8MR04Wn0xTSdCsG5JwDqQIqnUeoIc3t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=micpndqh; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23649faf69fso37041985ad.0;
        Mon, 14 Jul 2025 09:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752509002; x=1753113802; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=amnLextWhq80dn/j8sIhCq8KWtGHDL318UCdcM88YKc=;
        b=micpndqh+kHuZHVG4pOZiQE/ac0n7RWncreFnm6F5ymGInWHKJ6r4dyvHKLd85g4tU
         IzmLEOBdVo7xcR05tazAS1mX7A9nBnAmooRsycwDqwiTYuswfz/HRO2gd+S2OMt9s1Uf
         tM03lucRzC4mvM2XN+TTNCYxfom87+8QCxnoFRZcfNj8lUfmuBbIKBf1SwcgAJz9g0Ih
         4fYuzOxMxxOX2zEkMA0KLvfjMa0bkpnrK/86g9mzIplYvFqP6fxa1oUaWod0+c5FEox8
         jiU9qp8n2EMlVTLpC0+dVA8KDjSq+6bfx3pBQ3tzTSvn2rwbq3+53c5m8c+nWWU1K11c
         Or3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752509002; x=1753113802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amnLextWhq80dn/j8sIhCq8KWtGHDL318UCdcM88YKc=;
        b=oEjexoKT0ZNf89h29gP1X89kflk2rdpSKuZnWawE9RBp60r74Qhp/5rcN8KLudBPZV
         gzdw/i3blOyPfs2WS6+RQPO8F2ERMeUIV+MLV+ZZdI8Ck50C0LrgUoQFN74ZoR6xEp0q
         GAax9Ne6JdQ+6RqMWZ23OocLXw19w7NkKtJ8y1/GREkSQowHnLc8uh0mURJZAmy1nbhe
         +1btpznDK5dZQD18yausptZoe36ZcqCVNAQegC0eFQ3mNqbFvmtDMPpEsKMHrgpYr5Hl
         jpS8JW2NHWxgkXGo3OISdO6dihFUZJ+yvRox/nkPv4SUv5C3HhxOixInmn+HM/936bOu
         oF/w==
X-Forwarded-Encrypted: i=1; AJvYcCWP4pIj4ZhyqSaLMEA9TAbyXMfom4SfgZO3SW5t3pcA9zQtOWo5mlCXVH+hb7+DBf78/u4=@vger.kernel.org, AJvYcCXhzriHN7q4KgTIk32wYRTSYnNLNSAfTm+FuLW7PwaX40wLtBbnhtW3MfbIwijTXZbBDD2dFt/6@vger.kernel.org
X-Gm-Message-State: AOJu0YwRtg0airgYxj1E3aSQKbKfaPY52f/uRDOvP6PRhUElvskQhEKX
	an5IU6tBT5x3FjpT+oNR28bGL/A7cP9tZ4wxM5drj8tgkbNkgSEIquc=
X-Gm-Gg: ASbGncux86FJ2iCDdqvdlbprRDl99FBP1HUzzahS1wLl71XkX52sNKj1Rgh018a5g6O
	x1bP5Lb4vz/gFv5xusPWclf7ALm4X8pmC7slVW1OLvi3/6rrsTp/ud88pOyoaDAZC0BQ9REOBIh
	AjwRtaexm5nAl27oJ/aCK3l8s7+6aQSeI42la6tRjEuDtteaypmfP8tQEWCL7ovWI9CHaD8a8e5
	s/1RTVvKksYNhk0rO3rXoMp+ip3gZtREbYsLZrrA4k1KKw6T8vTZ72A3CKPlLfTsF9eLFwVF7cn
	uniJxpoUxqr5d5vo829xStXMEV+VcXP+LkMb4ASDoeg//h+W53mySz3wBcKcKs4ahbKH9o9adSx
	Qs+bBE1VdwUOd655vb/JT7d9d92PnKH7SXyxyG2cDl7aIv8DuVWYKjpjusyQLh32mY3N4ug==
X-Google-Smtp-Source: AGHT+IFVZ+X9qYs9CduYgGeyjQEVSntwIhIeGWS9e4z5RbGoLlVPVwwNPVPOui0qViZhyARsR7Hxyg==
X-Received: by 2002:a17:902:d58c:b0:235:f298:cbb3 with SMTP id d9443c01a7336-23dee1e84c4mr193895945ad.18.1752509001369;
        Mon, 14 Jul 2025 09:03:21 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23de42ad2fesm99524185ad.70.2025.07.14.09.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 09:03:20 -0700 (PDT)
Date: Mon, 14 Jul 2025 09:03:19 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	sdf@fomichev.me, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, joe@dama.to,
	willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next] xsk: skip validating skb list in xmit path
Message-ID: <aHUqR5_NoU8BYbz5@mini-arch>
References: <20250713025756.24601-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250713025756.24601-1-kerneljasonxing@gmail.com>

On 07/13, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> For xsk, it's not needed to validate and check the skb in
> validate_xmit_skb_list() in copy mode because xsk_build_skb() doesn't
> and doesn't need to prepare those requisites to validate. Xsk is just
> responsible for delivering raw data from userspace to the driver.

So the __dev_direct_xmit was taken out of af_packet in commit 865b03f21162
("dev: packet: make packet_direct_xmit a common function"). And a call
to validate_xmit_skb_list was added in 104ba78c9880 ("packet: on direct_xmit,
limit tso and csum to supported devices") to support TSO. Since we don't
support tso/vlan offloads in xsk_build_skb, removing validate_xmit_skb_list
seems fair.

Although, again, if you care about performance, why not use zerocopy
mode?

> Skipping numerous checks somehow contributes to the transmission
> especially in the extremely hot path.
> 
> Performance-wise, I used './xdpsock -i enp2s0f0np0 -t  -S -s 64' to verify
> the guess and then measured on the machine with ixgbe driver. It stably
> goes up by 5.48%, which can be seen in the shown below:
> Before:
>  sock0@enp2s0f0np0:0 txonly xdp-skb
>                    pps            pkts           1.00
> rx                 0              0
> tx                 1,187,410      3,513,536
> After:
>  sock0@enp2s0f0np0:0 txonly xdp-skb
>                    pps            pkts           1.00
> rx                 0              0
> tx                 1,252,590      2,459,456
> 
> This patch also removes total ~4% consumption which can be observed
> by perf:
> |--2.97%--validate_xmit_skb
> |          |
> |           --1.76%--netif_skb_features
> |                     |
> |                      --0.65%--skb_network_protocol
> |
> |--1.06%--validate_xmit_xfrm

It is a bit surprising that mostly no-op validate_xmit_skb_list takes
4% of the cycles. netif_skb_features taking ~2%? Any idea why? Is
it unoptimized kernel? Which driver is it?

> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  include/linux/netdevice.h |  4 ++--
>  net/core/dev.c            | 10 ++++++----
>  net/xdp/xsk.c             |  2 +-
>  3 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index a80d21a14612..2df44c22406c 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3351,7 +3351,7 @@ u16 dev_pick_tx_zero(struct net_device *dev, struct sk_buff *skb,
>  		     struct net_device *sb_dev);
>  
>  int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev);
> -int __dev_direct_xmit(struct sk_buff *skb, u16 queue_id);
> +int __dev_direct_xmit(struct sk_buff *skb, u16 queue_id, bool validate);
>  
>  static inline int dev_queue_xmit(struct sk_buff *skb)
>  {
> @@ -3368,7 +3368,7 @@ static inline int dev_direct_xmit(struct sk_buff *skb, u16 queue_id)
>  {
>  	int ret;
>  
> -	ret = __dev_direct_xmit(skb, queue_id);
> +	ret = __dev_direct_xmit(skb, queue_id, true);
>  	if (!dev_xmit_complete(ret))
>  		kfree_skb(skb);
>  	return ret;

Implementation wise, will it be better if we move a call to validate_xmit_skb_list
from __dev_direct_xmit to dev_direct_xmit (and a few other callers of
__dev_direct_xmit)? This will avoid the new flag.

