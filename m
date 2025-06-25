Return-Path: <bpf+bounces-61525-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 520CFAE84F5
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 15:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7AE91649F1
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 13:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8D2261594;
	Wed, 25 Jun 2025 13:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hG8JGrQ3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F73525A2A3;
	Wed, 25 Jun 2025 13:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750858729; cv=none; b=f2fFt9oUakGac1iUhtiQS13Avu4WHmLboxE2pAJop3UztXkAj3+XI6G20MKI4aDLTIb/5AcWBwfJE2YGsw1tASdmHStXWYGffSkDDKbw8KUrDjTCya9nYYcqw/w1eoy8RaKxP+IqZlCprmvkBRtED4wMHHA7mRZMPXW0xLG1DNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750858729; c=relaxed/simple;
	bh=P9WQKe++9OST0ycBYGVmzNi6Nfj5SxEAkWBx7whSND0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=tzfBoYJOamaajjhRIUb013bHiPsfuTd0FsY3zmZYGuPGLybG4fQGKekFQBVGoVaw/3hfv5ptLTQzcRAKbjl0pHJAfhhZgn3E9Ez/5o0wioptcM/5+mnjOh2g5R7v56sg0G+uHcr97d7PqheEmN5Ob0X/MGXqOLXyTJWqmE3qgG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hG8JGrQ3; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-710bbd7a9e2so62431397b3.0;
        Wed, 25 Jun 2025 06:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750858724; x=1751463524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BURGxb3vqCAqaXDf+ewl2SPZ7B6+pG1t9AaxpEP3SX0=;
        b=hG8JGrQ3KdSX35R3YOIQLqK2yI9tMasbs/st8ge1XWQzWOHKJlqFhZBcNHZKg1eVff
         nZ5hv3Ggpwrd/op+scNUbNIFw5mpZWL0DTFK5BDQPINRr6CbQjfu3AlaV4r12Qpb5mUE
         +/LB6KR5rX5Um6GEiewOAAmBS1lQMR6fNZayWA9qkwaEiitsMQDhOlWgHyqnO6X23uEV
         RpvE3N7VQvHpOeafi8daOWTLSx2zoqy/GLzVr3WsCOfiLdeW3eDWbBA2bHnIEU38tSNH
         3ePeJ0O6Enu9MJyjKYVnxs+WwELXS4zEPTwR/KfGm5OM5j+1riPovt67zcKyAFLQJje7
         ybLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750858724; x=1751463524;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BURGxb3vqCAqaXDf+ewl2SPZ7B6+pG1t9AaxpEP3SX0=;
        b=q1eoLlIjCVNNZMgVHWCoL6Op63zCmYsMV6MuBWwekkTZu0iJdDWolI4BB6OeceA2zf
         mzqhXOfr11tseOTp1OZWZYzcaz0KWCKrTpy+cbZjeVu+MVeTOg3cl6Y2Da/ljJpJg/jC
         kwfFNm4AMkN3FAsKAI49mVt1uwbyHuDAY8ZyfPWnYV53M66fk3lzfkraftyv30e5s+W/
         OwXoozmh5CmS5Kaayu5Cads9mtrfcA7WUo/ojv/2c2mH6LlRDBwR5VOT2h+3YZ6J+CO5
         hvlaWeLrRLdptUm5mpo/7+SleDOlq8WWPRVa5pRbtfTpUWgCc67b+gdPtBapvyxI0yAB
         GC9A==
X-Forwarded-Encrypted: i=1; AJvYcCWySpnQtxaVqO9ctAuIwCOSgnSASl1H0n0JQFLg8L3jLSDJ1gb0Hdoy69osmFWVS4XzJKE0PIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTQbqqdONkw72hdxicRxXYJuvGptCSbGEgmSlz0f/Rb0m5WdoN
	LawNI1nOFaW5/FVoXoSRG2wPYCGqU+/ChAmqucJqVSEI7GOOqdjrM469
X-Gm-Gg: ASbGnculfYgTQ+SpM+73sOjIzjA+7MU3LRn0u5H8M5xOKFHOycLhMgfm9IwXyFDUUEm
	8D5rScHFfwQIvTBG11WXFEUAieOXP9y+R++rmhoOtZjOqI+6ye5s0NXZJ8FuEIpk803/r8GPhfq
	m0nKXlUejl9DtuaVOwEOZVRJcAf3RIk0kE1lpwh5zYBHFgMZzlsSBd8o4Of2jOnjOmdLlO2Criv
	eGQEuxz3xapuvvJ4R+FMUhfwqroLd1bDjsbN1jDQGTxo7g0q7TC8y9LEY9fytmDDqoC17XDLkCh
	p+6CGGgGvjMNewGEA+Kjw7UApYQPwdW0z6/cra96yAPJZ6XnyzVf8Nvpm8/VeDh28baG94vhLYz
	q0qDrox5YIgozaDxcul6k20ISEi2W3jXo2+01NSeIxQ==
X-Google-Smtp-Source: AGHT+IFzSnaZuw1vxr8bRId9VHHb3yC5WvExJ2tENfJelaTyUFPRwlB1xWiOSY+AAJLJSWG7MkvJ/Q==
X-Received: by 2002:a05:690c:28b:b0:70e:7ae4:5a3e with SMTP id 00721157ae682-71406ca0ca8mr48003617b3.11.1750858723935;
        Wed, 25 Jun 2025 06:38:43 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-712c4c1a8cbsm24254107b3.109.2025.06.25.06.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 06:38:43 -0700 (PDT)
Date: Wed, 25 Jun 2025 09:38:42 -0400
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
Message-ID: <685bfbe2b5f51_21d18929413@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250625123527.98209-1-kerneljasonxing@gmail.com>
References: <20250625123527.98209-1-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v5] net: xsk: introduce XDP_MAX_TX_BUDGET
 setsockopt
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
> This patch provides a setsockopt method to let applications leverage to
> adjust how many descs to be handled at most in one send syscall. It
> mitigates the situation where the default value (32) that is too small
> leads to higher frequency of triggering send syscall.
> 
> Considering the prosperity/complexity the applications have, there is no
> absolutely ideal suggestion fitting all cases. So keep 32 as its default
> value like before.
> 
> The patch does the following things:
> - Add XDP_MAX_TX_BUDGET socket option.
> - Convert TX_BATCH_SIZE tx_budget_spent.
> - Set tx_budget_spent to 32 by default in the initialization phase as a
>   per-socket granular control.
> 
> The idea behind this comes out of real workloads in production. We use a
> user-level stack with xsk support to accelerate sending packets and
> minimize triggering syscalls. When the packets are aggregated, it's not
> hard to hit the upper bound (namely, 32). The moment user-space stack
> fetches the -EAGAIN error number passed from sendto(), it will loop to try
> again until all the expected descs from tx ring are sent out to the driver.
> Enlarging the XDP_MAX_TX_BUDGET value contributes to less frequency of
> sendto() and higher throughput/PPS.
> 
> Here is what I did in production, along with some numbers as follows:
> For one application I saw lately, I suggested using 128 as max_tx_budget
> because I saw two limitations without changing any default configuration:
> 1) XDP_MAX_TX_BUDGET, 2) socket sndbuf which is 212992 decided by
> net.core.wmem_default. As to XDP_MAX_TX_BUDGET, the scenario behind
> this was I counted how many descs are transmitted to the driver at one
> time of sendto() based on [1] patch and then I calculated the
> possibility of hitting the upper bound. Finally I chose 128 as a
> suitable value because 1) it covers most of the cases, 2) a higher
> number would not bring evident results. After twisting the parameters,
> a stable improvement of around 4% for both PPS and throughput and less
> resources consumption were found to be observed by strace -c -p xxx:
> 1) %time was decreased by 7.8%
> 2) error counter was decreased from 18367 to 572
> 
> [1]: https://lore.kernel.org/all/20250619093641.70700-1-kerneljasonxing@gmail.com/
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
> v5
> Link: https://lore.kernel.org/all/20250623021345.69211-1-kerneljasonxing@gmail.com/
> 1. remove changes around zc mode
> 
> v4
> Link: https://lore.kernel.org/all/20250619090440.65509-1-kerneljasonxing@gmail.com/
> 1. remove getsockopt as it seems no real use case.
> 2. adjust the position of max_tx_budget to make sure it stays with other
> read-most fields in one cacheline.
> 3. set one as the lower bound of max_tx_budget
> 4. add more descriptions/performance data in Doucmentation and commit message.
> 
> V3
> Link: https://lore.kernel.org/all/20250618065553.96822-1-kerneljasonxing@gmail.com/
> 1. use a per-socket control (suggested by Stanislav)
> 2. unify both definitions into one
> 3. support setsockopt and getsockopt
> 4. add more description in commit message
> 
> V2
> Link: https://lore.kernel.org/all/20250617002236.30557-1-kerneljasonxing@gmail.com/
> 1. use a per-netns sysctl knob
> 2. use sysctl_xsk_max_tx_budget to unify both definitions.
> ---
>  Documentation/networking/af_xdp.rst |  8 ++++++++
>  include/net/xdp_sock.h              |  1 +
>  include/uapi/linux/if_xdp.h         |  1 +
>  net/xdp/xsk.c                       | 20 ++++++++++++++++----
>  tools/include/uapi/linux/if_xdp.h   |  1 +
>  5 files changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/networking/af_xdp.rst b/Documentation/networking/af_xdp.rst
> index dceeb0d763aa..9eb6f7b630a5 100644
> --- a/Documentation/networking/af_xdp.rst
> +++ b/Documentation/networking/af_xdp.rst
> @@ -442,6 +442,14 @@ is created by a privileged process and passed to a non-privileged one.
>  Once the option is set, kernel will refuse attempts to bind that socket
>  to a different interface.  Updating the value requires CAP_NET_RAW.
>  
> +XDP_MAX_TX_BUDGET setsockopt
> +----------------------------
> +
> +This setsockopt sets the maximum number of descriptors that can be handled
> +and passed to the driver at one send syscall. It is applied in the non-zero
> +copy mode to allow application to tune the per-socket maximum iteration for
> +better throughput and less frequency of send syscall. Default is 32.
> +
>  XDP_STATISTICS getsockopt
>  -------------------------
>  
> diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> index e8bd6ddb7b12..ce587a225661 100644
> --- a/include/net/xdp_sock.h
> +++ b/include/net/xdp_sock.h
> @@ -84,6 +84,7 @@ struct xdp_sock {
>  	struct list_head map_list;
>  	/* Protects map_list */
>  	spinlock_t map_list_lock;
> +	u32 max_tx_budget;
>  	/* Protects multiple processes in the control path */
>  	struct mutex mutex;
>  	struct xsk_queue *fq_tmp; /* Only as tmp storage before bind */
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
> index 72c000c0ae5f..97aded3555c1 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -33,8 +33,7 @@
>  #include "xdp_umem.h"
>  #include "xsk.h"
>  
> -#define TX_BATCH_SIZE 32
> -#define MAX_PER_SOCKET_BUDGET (TX_BATCH_SIZE)
> +#define MAX_PER_SOCKET_BUDGET 32
>  
>  void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
>  {
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
> +		if (optlen != sizeof(budget))
> +			return -EINVAL;
> +		if (copy_from_sockptr(&budget, optval, sizeof(budget)))
> +			return -EFAULT;
> +
> +		WRITE_ONCE(xs->max_tx_budget, max(budget, 1));

I still think that this needs a more sane upper bound than U32_MAX.

One limiting factor is the XSK TxQ length. At least it should be
possible to fail if trying to set beyond that.

> +		return 0;
> +	}
>  	default:
>  		break;
>  	}
> @@ -1734,6 +1745,7 @@ static int xsk_create(struct net *net, struct socket *sock, int protocol,
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
> 2.41.3
> 



