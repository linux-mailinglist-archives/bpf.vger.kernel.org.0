Return-Path: <bpf+bounces-61078-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C123AE0803
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 15:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AE0517B4DC
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 13:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1C227EC9C;
	Thu, 19 Jun 2025 13:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFRYufkG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E280728C01F;
	Thu, 19 Jun 2025 13:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750341216; cv=none; b=bBr0ebFkW+idTT/RAnTXOUSiVGTqMPFtNXvv6n+GrV0d1Ig6emkKtADF+pAXKhrwI6Jc+1p4VGsZdM5Ai62s8uP8FrLAFW7gqCp91KG59tVTbijx1ts9bcmWc/11PxOZSVQGJGZXgWlBPPP0pwkpASnEm4RsIABIPTVW15FNlHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750341216; c=relaxed/simple;
	bh=+4/KULQnt1QVdDRfZPJoZykSkWFk0NKalwmaclIyAng=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=VnUstZQXql7Pg/56iisQJDEqsoYTXRojULVs9SvtfsKQrj65h0ZpF3UI7WRe8waBFLDcTrVPDrnkxaSlGMpdgRg57V2B1H1VzHW9ZWulunwQ+XaxqKl6XGQZQwSceCS1a5hm4IMyernkGccfueKqouW2XazTPzWctZXAfhrlY+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFRYufkG; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7086dcab64bso7207127b3.1;
        Thu, 19 Jun 2025 06:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750341214; x=1750946014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMRUt2RduZne7GKizARN4qGmIPTo9I14azEWJz8sU08=;
        b=IFRYufkGcWrtyw6h8Jpozb4CHP/q2OgmgHxqeRf4Du5TG7LeZg/iLmQm1owHBgGPCx
         +XH5JCH9r86tRzSCcnIiEjlJiAq4m7dp/EfCYROaqnCBGa0WvRGAy49HWGA6WnAhTU5H
         N6SNxXItqIA6BoAJi/Ev6S/DeHfhG1U7lfRDxh5WsQUWnMsxn4pQnSqtvOd+D96DeMyh
         jyKyQ6uPUR43B3kIcf0vf5C50BUmdK3tZpQFfNtiBHt/FbTqCXzabczUQWRiP5aGy+gR
         uKc3vLK++TwmZRQJfRLXihqeBTyVTIGvrI5p6BIGzh+YjS146WmWvZ0iLdE2Z7i7/7dw
         AuDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750341214; x=1750946014;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AMRUt2RduZne7GKizARN4qGmIPTo9I14azEWJz8sU08=;
        b=hWsqi/wiZmtAVObP2vx/8iPc/Xpc9pXdkhwVjNXJXAj4Ur83GnvrrEjvPnjJWqBbhl
         4G6z6kDyYgBZqUv1jdrk/+b1h03p4YSnmROMHUOEdKnjHXT+hCffeiyYakfA7nLjTPOc
         535BqJufmwz3X/X2jVUvcw7dFVudu2kSV+TL82ebeAuPzShPmnm4e5utFUgzlBGDkt3a
         fc0pYfL12I5DcDwPP6VhTZC/VeyMz266IgF8jDO9biQX7M5Ij2GYXS2nGgoCgsxrdh6g
         ABOlUQlLx88Z3WHGOWZYN9Z7vnWVTAQHCaaSbjVk3GpRaGID9x6lHF9brk2OPvqiKkTM
         Q02w==
X-Forwarded-Encrypted: i=1; AJvYcCXe6UrvpgD2irOY/rVZh1QOb2Mekzqs3FK2OxKH3MXecZQ2CiOC0IW52avwkHD3cK4StkkrXMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrOkhxLWnInm11+OV/Qz3ZsBmmkgFgA038MNB9dX5ie4fnNOoQ
	QQAc1KUols0zJ/Fkhwl3q+gr9opRwutyYiYoznRHCCyDz5d16sYlYiBb
X-Gm-Gg: ASbGncttqwc5e7o5ZNjlGVYuaHsUDCNkf6igUvIwgVKbLC49e0GG1IuoGOaT30yzh79
	r+rFmmYqSvj2Ho0VIaJf74oP+6xNRA2QVTUS11+FJ84MPrLUGM+b1KJ5El+mk9hndnfOHSgGh//
	7F5a2KG7XI2pz67XLvGOVP+lsfXg4B4SMvQOpaAj6DPOdOT4aJ9giM/TO6s+GA02/aMTkyZ6TnB
	od53ewvb2Y+zD9s5zxHzeiOQ/mkiW37/Mu8odGCUizfnRCLqc47c1Es9glyOVt/Qj4d98eZ6qab
	Vu7aljOLubYnjcSwTMi9kMyMl9rNib0Fw5Z+HpUbJdVCoOa0rPbA8YXzEcWHoIh6xSJCcaQBnso
	jqckVXlzS8Oyu3psYnaV1GRTA5IS4lV8c+K0r8/fJMw==
X-Google-Smtp-Source: AGHT+IHD7YKTP3/HmU3cVkiaFOzOBUtqMYmjv5P0IqiopJaOqNiUq25fzmK4/ZeWG8cD6mGJo7blkQ==
X-Received: by 2002:a05:690c:1a:b0:711:41a5:482a with SMTP id 00721157ae682-7117544ca60mr309774447b3.27.1750341213715;
        Thu, 19 Jun 2025 06:53:33 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-712b7b7fee2sm3100607b3.56.2025.06.19.06.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 06:53:33 -0700 (PDT)
Date: Thu, 19 Jun 2025 09:53:32 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 bjorn@kernel.org, 
 magnus.karlsson@intel.com, 
 maciej.fijalkowski@intel.com, 
 jonathan.lemon@gmail.com, 
 sdf@fomichev.me, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 hawk@kernel.org, 
 john.fastabend@gmail.com, 
 joe@dama.to, 
 willemdebruijn.kernel@gmail.com
Cc: bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <6854165ccb312_3a357029426@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250619090440.65509-1-kerneljasonxing@gmail.com>
References: <20250619090440.65509-1-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v3] net: xsk: introduce XDP_MAX_TX_BUDGET
 set/getsockopt
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> The patch does the following things:
> - Add XDP_MAX_TX_BUDGET socket option.
> - Unify TX_BATCH_SIZE and MAX_PER_SOCKET_BUDGET into single one
>   tx_budget_spent.
> - tx_budget_spent is set to 32 by default in the initialization phase.
>   It's a per-socket granular control.
> 
> The idea behind this comes out of real workloads in production. We use a
> user-level stack with xsk support to accelerate sending packets and
> minimize triggering syscall. When the packets are aggregated, it's not
> hard to hit the upper bound (namely, 32). The moment user-space stack
> fetches the -EAGAIN error number passed from sendto(), it will loop to try
> again until all the expected descs from tx ring are sent out to the driver.
> Enlarging the XDP_MAX_TX_BUDGET value contributes to less frequencies of
> sendto(). Besides, applications leveraging this setsockopt can adjust
> its proper value in time after noticing the upper bound issue happening.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
> V3
> Link: https://lore.kernel.org/all/20250618065553.96822-1-kerneljasonxing@gmail.com/
> 1. use a per-socket control (suggested by Stanislav)
> 2. unify both definitions into one
> 3. support setsockopt and getsockopt
> 4. add more description in commit message

+1 on an XSK setsockopt only

> 
> V2
> Link: https://lore.kernel.org/all/20250617002236.30557-1-kerneljasonxing@gmail.com/
> 1. use a per-netns sysctl knob
> 2. use sysctl_xsk_max_tx_budget to unify both definitions.
> ---
>  include/net/xdp_sock.h            |  3 ++-
>  include/uapi/linux/if_xdp.h       |  1 +
>  net/xdp/xsk.c                     | 36 +++++++++++++++++++++++++------
>  tools/include/uapi/linux/if_xdp.h |  1 +
>  4 files changed, 34 insertions(+), 7 deletions(-)
> 
> diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> index e8bd6ddb7b12..8eecafad92c0 100644
> --- a/include/net/xdp_sock.h
> +++ b/include/net/xdp_sock.h
> @@ -65,11 +65,12 @@ struct xdp_sock {
>  	struct xsk_queue *tx ____cacheline_aligned_in_smp;
>  	struct list_head tx_list;
>  	/* record the number of tx descriptors sent by this xsk and
> -	 * when it exceeds MAX_PER_SOCKET_BUDGET, an opportunity needs
> +	 * when it exceeds max_tx_budget, an opportunity needs
>  	 * to be given to other xsks for sending tx descriptors, thereby
>  	 * preventing other XSKs from being starved.
>  	 */
>  	u32 tx_budget_spent;
> +	u32 max_tx_budget;

This probably does not need to be a u32?

It does fit in an existing hole. Is it also a warm cacheline wherever
this is touched in the hot path?

>  
>  	/* Statistics */
>  	u64 rx_dropped;
> diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
> index 44f2bb93e7e6..07c6d21c2f1c 100644
> --- a/include/uapi/linux/if_xdp.h
> +++ b/include/uapi/linux/if_xdp.h
> @@ -79,6 +79,7 @@ struct xdp_mmap_offsets {
>  #define XDP_UMEM_COMPLETION_RING	6
>  #define XDP_STATISTICS			7
>  #define XDP_OPTIONS			8
> +#define XDP_MAX_TX_BUDGET		9
>  
>  struct xdp_umem_reg {
>  	__u64 addr; /* Start of packet data area */
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 72c000c0ae5f..7c47f665e9d1 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -33,9 +33,6 @@
>  #include "xdp_umem.h"
>  #include "xsk.h"
>  
> -#define TX_BATCH_SIZE 32
> -#define MAX_PER_SOCKET_BUDGET (TX_BATCH_SIZE)
> -
>  void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
>  {
>  	if (pool->cached_need_wakeup & XDP_WAKEUP_RX)
> @@ -424,7 +421,9 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc)
>  	rcu_read_lock();
>  again:
>  	list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
> -		if (xs->tx_budget_spent >= MAX_PER_SOCKET_BUDGET) {
> +		int max_budget = READ_ONCE(xs->max_tx_budget);
> +
> +		if (xs->tx_budget_spent >= max_budget) {
>  			budget_exhausted = true;
>  			continue;
>  		}
> @@ -779,7 +778,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  static int __xsk_generic_xmit(struct sock *sk)
>  {
>  	struct xdp_sock *xs = xdp_sk(sk);
> -	u32 max_batch = TX_BATCH_SIZE;
> +	u32 max_budget = READ_ONCE(xs->max_tx_budget);
>  	bool sent_frame = false;
>  	struct xdp_desc desc;
>  	struct sk_buff *skb;
> @@ -797,7 +796,7 @@ static int __xsk_generic_xmit(struct sock *sk)
>  		goto out;
>  
>  	while (xskq_cons_peek_desc(xs->tx, &desc, xs->pool)) {
> -		if (max_batch-- == 0) {
> +		if (max_budget-- == 0) {
>  			err = -EAGAIN;
>  			goto out;
>  		}
> @@ -1437,6 +1436,18 @@ static int xsk_setsockopt(struct socket *sock, int level, int optname,
>  		mutex_unlock(&xs->mutex);
>  		return err;
>  	}
> +	case XDP_MAX_TX_BUDGET:
> +	{
> +		unsigned int budget;
> +
> +		if (optlen < sizeof(budget))
> +			return -EINVAL;
> +		if (copy_from_sockptr(&budget, optval, sizeof(budget)))
> +			return -EFAULT;
> +
> +		WRITE_ONCE(xs->max_tx_budget, budget);

Sanitize input: bounds check

> +		return 0;
> +	}
>  	default:
>  		break;
>  	}
> @@ -1588,6 +1599,18 @@ static int xsk_getsockopt(struct socket *sock, int level, int optname,
>  
>  		return 0;
>  	}
> +	case XDP_MAX_TX_BUDGET:
> +	{
> +		unsigned int budget = READ_ONCE(xs->max_tx_budget);
> +
> +		if (copy_to_user(optval, &budget, sizeof(budget)))
> +			return -EFAULT;
> +		if (put_user(sizeof(budget), optlen))
> +			return -EFAULT;
> +
> +		return 0;
> +	}
> +
>  	default:
>  		break;
>  	}
> @@ -1734,6 +1757,7 @@ static int xsk_create(struct net *net, struct socket *sock, int protocol,
>  
>  	xs = xdp_sk(sk);
>  	xs->state = XSK_READY;
> +	xs->max_tx_budget = 32;
>  	mutex_init(&xs->mutex);
>  
>  	INIT_LIST_HEAD(&xs->map_list);
> diff --git a/tools/include/uapi/linux/if_xdp.h b/tools/include/uapi/linux/if_xdp.h
> index 44f2bb93e7e6..07c6d21c2f1c 100644
> --- a/tools/include/uapi/linux/if_xdp.h
> +++ b/tools/include/uapi/linux/if_xdp.h
> @@ -79,6 +79,7 @@ struct xdp_mmap_offsets {
>  #define XDP_UMEM_COMPLETION_RING	6
>  #define XDP_STATISTICS			7
>  #define XDP_OPTIONS			8
> +#define XDP_MAX_TX_BUDGET		9
>  
>  struct xdp_umem_reg {
>  	__u64 addr; /* Start of packet data area */
> -- 
> 2.43.5
> 



