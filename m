Return-Path: <bpf+bounces-51336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EABF6A3357F
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 03:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC30A167F17
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 02:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF7B1FF7DD;
	Thu, 13 Feb 2025 02:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="nyOnpUaC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D642841C6A;
	Thu, 13 Feb 2025 02:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739413523; cv=none; b=UiuKvJmpS55WxYy37wpF6B31dSpTNDcI3X8YT0ZnOPCoAWDeN0y4uLYmbGpDd+YKGOY55bntbi2IjsPvV5L5C4IVlKlU2iNC3OqUUFtQGrhHdukHNik19T4PF6Zpz+ySjwB12TIlZsRRAOHNLjmXsIH0U0AKtzFCr6g6Hc1hdfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739413523; c=relaxed/simple;
	bh=4oBLu/wQm6Fdtv7Weitaq6mSScWS1ZC/DNvpaTlpbBw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sv8K+a3HMzJxp7p/shp2ytgC3Jqkp1PFok7wMAqMDMv/4b14uaNBha6TftCPdcf43+ja6ELeRTwLazJxoKSNqmE0iom8zWcaFprrbwf1/BxPhy62FFOO/GnvbqSzEJ4Nw38a5O4s5/GIo0j17npIK7GHISvcSU9ID2ZBzvUu9Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=nyOnpUaC; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739413522; x=1770949522;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GCqE0oUuNfVwkjtXyU2x15eI0yVRW/EppQVEg177ssc=;
  b=nyOnpUaCJ7VaZ+5vMgdYd3SqqgUJV9YRFTZVx5NDIqp6BbKaR+OUtwJ6
   1oeKRWILHFi8gtMRyxVIMAY2ww/bbiQgBovMExn0yGr4t6dxoJtr3lpID
   46VALrkwKuW4WnpivVYlUa1ykv4PFV2btWGXyw9ys9gfGdA2PCuFRF2mp
   w=;
X-IronPort-AV: E=Sophos;i="6.13,281,1732579200"; 
   d="scan'208";a="466418217"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 02:25:18 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:60759]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.136:2525] with esmtp (Farcaster)
 id ede0a335-e8f1-41a4-8e13-a05dd0aab1df; Thu, 13 Feb 2025 02:25:17 +0000 (UTC)
X-Farcaster-Flow-ID: ede0a335-e8f1-41a4-8e13-a05dd0aab1df
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 13 Feb 2025 02:25:16 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Feb 2025 02:25:09 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kerneljasonxing@gmail.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<eddyz87@gmail.com>, <edumazet@google.com>, <haoluo@google.com>,
	<horms@kernel.org>, <john.fastabend@gmail.com>, <jolsa@kernel.org>,
	<kpsingh@kernel.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<martin.lau@linux.dev>, <ncardwell@google.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <sdf@fomichev.me>, <song@kernel.org>,
	<yonghong.song@linux.dev>
Subject: Re: [PATCH net-next 2/3] bpf: add TCP_BPF_RTO_MAX for bpf_setsockopt
Date: Thu, 13 Feb 2025 11:25:01 +0900
Message-ID: <20250213022501.76123-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250213004355.38918-3-kerneljasonxing@gmail.com>
References: <20250213004355.38918-3-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB001.ant.amazon.com (10.13.139.152) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 13 Feb 2025 08:43:53 +0800
> Support bpf_setsockopt() to set the maximum value of RTO for
> BPF program.
> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>  Documentation/networking/ip-sysctl.rst | 3 ++-
>  include/uapi/linux/bpf.h               | 2 ++
>  net/core/filter.c                      | 6 ++++++
>  tools/include/uapi/linux/bpf.h         | 2 ++
>  4 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
> index 054561f8dcae..78eb0959438a 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -1241,7 +1241,8 @@ tcp_rto_min_us - INTEGER
>  
>  tcp_rto_max_ms - INTEGER
>  	Maximal TCP retransmission timeout (in ms).
> -	Note that TCP_RTO_MAX_MS socket option has higher precedence.
> +	Note that TCP_BPF_RTO_MAX and TCP_RTO_MAX_MS socket option have the
> +	higher precedence for configuring this setting.
>  
>  	When changing tcp_rto_max_ms, it is important to understand
>  	that tcp_retries2 might need a change.
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 2acf9b336371..8ab6ef144217 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -2868,6 +2868,7 @@ union bpf_attr {
>   * 		  **TCP_NODELAY**, **TCP_MAXSEG**, **TCP_WINDOW_CLAMP**,
>   * 		  **TCP_THIN_LINEAR_TIMEOUTS**, **TCP_BPF_DELACK_MAX**,
>   *		  **TCP_BPF_RTO_MIN**, **TCP_BPF_SOCK_OPS_CB_FLAGS**.
> + *		  **TCP_BPF_RTO_MAX**
>   * 		* **IPPROTO_IP**, which supports *optname* **IP_TOS**.
>   * 		* **IPPROTO_IPV6**, which supports the following *optname*\ s:
>   * 		  **IPV6_TCLASS**, **IPV6_AUTOFLOWLABEL**.
> @@ -7091,6 +7092,7 @@ enum {
>  	TCP_BPF_SYN_IP		= 1006, /* Copy the IP[46] and TCP header */
>  	TCP_BPF_SYN_MAC         = 1007, /* Copy the MAC, IP[46], and TCP header */
>  	TCP_BPF_SOCK_OPS_CB_FLAGS = 1008, /* Get or Set TCP sock ops flags */
> +	TCP_BPF_RTO_MAX		= 1009, /* Max delay ack in msecs */
>  };
>  
>  enum {
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 2ec162dd83c4..a21a147e0a86 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5303,6 +5303,12 @@ static int bpf_sol_tcp_setsockopt(struct sock *sk, int optname,
>  			return -EINVAL;
>  		tp->bpf_sock_ops_cb_flags = val;
>  		break;
> +	case TCP_BPF_RTO_MAX:
> +		if (val > TCP_RTO_MAX_SEC * MSEC_PER_SEC ||
> +		    val < TCP_RTO_MAX_MIN_SEC * MSEC_PER_SEC)
> +			return -EINVAL;
> +		inet_csk(sk)->icsk_rto_max = msecs_to_jiffies(val);
> +		break;
>  	default:
>  		return -EINVAL;
>  	}

You need not define TCP_BPF_RTO_MAX because TCP_RTO_MAX is not a
BPF specific option, and you can just reuse do_tcp_setsockopt(),
then bpf_getsockopt() also works.

---8<---
diff --git a/net/core/filter.c b/net/core/filter.c
index 2ec162dd83c4..77732f10097c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5382,6 +5382,7 @@ static int sol_tcp_sockopt(struct sock *sk, int optname,
 	case TCP_USER_TIMEOUT:
 	case TCP_NOTSENT_LOWAT:
 	case TCP_SAVE_SYN:
+	case TCP_RTO_MAX:
 		if (*optlen != sizeof(int))
 			return -EINVAL;
 		break;
---8<---

