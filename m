Return-Path: <bpf+bounces-43461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2BC9B58A6
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 01:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 627421C22C17
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 00:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4AF14286;
	Wed, 30 Oct 2024 00:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fnP3VB84"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10433D528
	for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 00:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730248376; cv=none; b=T4Xci7QxQlC9WHclYjrnfvhD/rZnm+9AQ5E4yRWwaUPHYmmYinvMXHDd2gHkrYMv9Fnl/Fwba4Mcu6kr6Uk62mtx5qek2z14+TTMShG8CT03zw3Co9Do5oOvHglFi76Gyigg+R0HbhwsH0AWnwPnkCCRet/J8Ygl0YNJdKOyC/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730248376; c=relaxed/simple;
	bh=l6eQS+Vahmy7V6Nq3VsU+55gtEB1m12pWsK/tCnHOoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=irXTIdII8wz8oNEsKrUN/6UB/QkTKvfoP19Whdp/N7FAxHsg0LzV3eeA5DbEII+ux0uZudX5R2xX+zZl+hARKpNLyh83a0HLwHD7m/VnvAmwQ3AFrTMFKkUoHbkFx1q377RWhT80Kq5pJ8xCtM6cYBXsMU+hmuQkl4avoD/HGlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fnP3VB84; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9a821495-cac7-48d8-a2bc-1bd7ebeef23c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730248370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z0Y0lFZ0qQSnv3we6RWgnOtGin4q6102uB7b96bEsEw=;
	b=fnP3VB84a5+87QICZGLPIGPHl1IGHUszFsgDTmT/npi+y65kFvpdK+qy7UNRfXepUjPt0S
	FsSghnOBDMPMgPEH9jm3JsEg8VAF8fZONEhh9vqIaW7eeK2CRLC+Qgf3wdDRGRTcykgFBo
	QmXexY4q+Le60qgI6WKnp8rWj0R79/A=
Date: Tue, 29 Oct 2024 17:32:41 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 03/14] net-timestamp: open gate for
 bpf_setsockopt/_getsockopt
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, ykolal@fb.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <20241028110535.82999-4-kerneljasonxing@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20241028110535.82999-4-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/28/24 4:05 AM, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> For now, we support bpf_setsockopt to set or clear timestamps flags.
> 
> Users can use something like this in bpf program to turn on the feature:
> flags = SOF_TIMESTAMPING_TX_SCHED;
> bpf_setsockopt(skops, SOL_SOCKET, SO_TIMESTAMPING, &flags, sizeof(flags));
> The specific use cases can be seen in the bpf selftest in this series.
> 
> Later, I will support each flags one by one based on this.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>   include/net/sock.h              |  4 ++--
>   include/uapi/linux/net_tstamp.h |  7 +++++++
>   net/core/filter.c               |  7 +++++--
>   net/core/sock.c                 | 34 ++++++++++++++++++++++++++-------
>   net/ipv4/udp.c                  |  2 +-
>   net/mptcp/sockopt.c             |  2 +-
>   net/socket.c                    |  2 +-
>   7 files changed, 44 insertions(+), 14 deletions(-)
> 
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 5384f1e49f5c..062f405c744e 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1775,7 +1775,7 @@ static inline void skb_set_owner_edemux(struct sk_buff *skb, struct sock *sk)
>   #endif
>   
>   int sk_setsockopt(struct sock *sk, int level, int optname,
> -		  sockptr_t optval, unsigned int optlen);
> +		  sockptr_t optval, unsigned int optlen, bool bpf_timetamping);
>   int sock_setsockopt(struct socket *sock, int level, int op,
>   		    sockptr_t optval, unsigned int optlen);
>   int do_sock_setsockopt(struct socket *sock, bool compat, int level,
> @@ -1784,7 +1784,7 @@ int do_sock_getsockopt(struct socket *sock, bool compat, int level,
>   		       int optname, sockptr_t optval, sockptr_t optlen);
>   
>   int sk_getsockopt(struct sock *sk, int level, int optname,
> -		  sockptr_t optval, sockptr_t optlen);
> +		  sockptr_t optval, sockptr_t optlen, bool bpf_timetamping);
>   int sock_gettstamp(struct socket *sock, void __user *userstamp,
>   		   bool timeval, bool time32);
>   struct sk_buff *sock_alloc_send_pskb(struct sock *sk, unsigned long header_len,
> diff --git a/include/uapi/linux/net_tstamp.h b/include/uapi/linux/net_tstamp.h
> index 858339d1c1c4..0696699cf964 100644
> --- a/include/uapi/linux/net_tstamp.h
> +++ b/include/uapi/linux/net_tstamp.h
> @@ -49,6 +49,13 @@ enum {
>   					 SOF_TIMESTAMPING_TX_SCHED | \
>   					 SOF_TIMESTAMPING_TX_ACK)
>   
> +#define SOF_TIMESTAMPING_BPF_SUPPPORTED_MASK (SOF_TIMESTAMPING_SOFTWARE | \

hmm... so we are allowing it but SOF_TIMESTAMPING_SOFTWARE won't do anything 
(meaning set and not-set are both no-op) ?

> +					      SOF_TIMESTAMPING_TX_SCHED | \
> +					      SOF_TIMESTAMPING_TX_SOFTWARE | \
> +					      SOF_TIMESTAMPING_TX_ACK | \
> +					      SOF_TIMESTAMPING_OPT_ID | \
> +					      SOF_TIMESTAMPING_OPT_ID_TCP)
> +
>   /**
>    * struct so_timestamping - SO_TIMESTAMPING parameter
>    *
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 58761263176c..dc8ecf899ced 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5238,6 +5238,9 @@ static int sol_socket_sockopt(struct sock *sk, int optname,
>   		break;
>   	case SO_BINDTODEVICE:
>   		break;
> +	case SO_TIMESTAMPING_NEW:

How about only allow bpf_setsockopt(SO_TIMESTAMPING_NEW) instead of 
bpf_setsockopt(SO_TIMESTAMPING). Does it solve the issue reported in v2?

> +	case SO_TIMESTAMPING_OLD:
> +		break;
>   	default:
>   		return -EINVAL;
>   	}
> @@ -5247,11 +5250,11 @@ static int sol_socket_sockopt(struct sock *sk, int optname,
>   			return -EINVAL;
>   		return sk_getsockopt(sk, SOL_SOCKET, optname,
>   				     KERNEL_SOCKPTR(optval),
> -				     KERNEL_SOCKPTR(optlen));
> +				     KERNEL_SOCKPTR(optlen), true);
>   	}
>   
>   	return sk_setsockopt(sk, SOL_SOCKET, optname,
> -			     KERNEL_SOCKPTR(optval), *optlen);
> +			     KERNEL_SOCKPTR(optval), *optlen, true);
>   }
>   
>   static int bpf_sol_tcp_setsockopt(struct sock *sk, int optname,
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 7f398bd07fb7..7e05748b1a06 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -941,6 +941,19 @@ int sock_set_timestamping(struct sock *sk, int optname,
>   	return 0;
>   }
>   
> +static int sock_set_timestamping_bpf(struct sock *sk,
> +				     struct so_timestamping timestamping)
> +{
> +	u32 flags = timestamping.flags;
> +
> +	if (flags & ~SOF_TIMESTAMPING_BPF_SUPPPORTED_MASK)
> +		return -EINVAL;
> +
> +	WRITE_ONCE(sk->sk_tsflags_bpf, flags);

I think it is cleaner to directly "WRITE_ONCE(sk->sk_tsflags_bpf, flags);" in 
sol_socket_sockopt() instead of adding "bool bpf_timestamping" to sk_setsockopt. 
sk_tsflags_bpf is a separate u32 anyway, so not a lot of code to share. The same 
for getsockopt.

[ will continue the remaining patches a little later ]

> +
> +	return 0;
> +}
> +
>   void sock_set_keepalive(struct sock *sk)
>   {
>   	lock_sock(sk);
> @@ -1159,7 +1172,7 @@ static int sockopt_validate_clockid(__kernel_clockid_t value)
>    */
>   
>   int sk_setsockopt(struct sock *sk, int level, int optname,
> -		  sockptr_t optval, unsigned int optlen)
> +		  sockptr_t optval, unsigned int optlen, bool bpf_timetamping)
>   {
>   	struct so_timestamping timestamping;
>   	struct socket *sock = sk->sk_socket;
> @@ -1409,7 +1422,10 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
>   			memset(&timestamping, 0, sizeof(timestamping));
>   			timestamping.flags = val;
>   		}
> -		ret = sock_set_timestamping(sk, optname, timestamping);
> +		if (!bpf_timetamping)
> +			ret = sock_set_timestamping(sk, optname, timestamping);
> +		else
> +			ret = sock_set_timestamping_bpf(sk, timestamping);
>   		break;
>   
>   	case SO_RCVLOWAT:
> @@ -1626,7 +1642,7 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
>   		    sockptr_t optval, unsigned int optlen)
>   {
>   	return sk_setsockopt(sock->sk, level, optname,
> -			     optval, optlen);
> +			     optval, optlen, false);
>   }
>   EXPORT_SYMBOL(sock_setsockopt);
>   
> @@ -1670,7 +1686,7 @@ static int groups_to_user(sockptr_t dst, const struct group_info *src)
>   }
>   
>   int sk_getsockopt(struct sock *sk, int level, int optname,
> -		  sockptr_t optval, sockptr_t optlen)
> +		  sockptr_t optval, sockptr_t optlen, bool bpf_timetamping)
>   {
>   	struct socket *sock = sk->sk_socket;
>   
> @@ -1793,9 +1809,13 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
>   		 * returning the flags when they were set through the same option.
>   		 * Don't change the beviour for the old case SO_TIMESTAMPING_OLD.
>   		 */
> -		if (optname == SO_TIMESTAMPING_OLD || sock_flag(sk, SOCK_TSTAMP_NEW)) {
> -			v.timestamping.flags = READ_ONCE(sk->sk_tsflags);
> -			v.timestamping.bind_phc = READ_ONCE(sk->sk_bind_phc);
> +		if (!bpf_timetamping) {
> +			if (optname == SO_TIMESTAMPING_OLD || sock_flag(sk, SOCK_TSTAMP_NEW)) {
> +				v.timestamping.flags = READ_ONCE(sk->sk_tsflags);
> +				v.timestamping.bind_phc = READ_ONCE(sk->sk_bind_phc);
> +			}
> +		} else {
> +			v.timestamping.flags = READ_ONCE(sk->sk_tsflags_bpf);
>   		}
>   		break;
>   
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 0e24916b39d4..9a20af41e272 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -2679,7 +2679,7 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
>   	int is_udplite = IS_UDPLITE(sk);
>   
>   	if (level == SOL_SOCKET) {
> -		err = sk_setsockopt(sk, level, optname, optval, optlen);
> +		err = sk_setsockopt(sk, level, optname, optval, optlen, false);
>   
>   		if (optname == SO_RCVBUF || optname == SO_RCVBUFFORCE) {
>   			sockopt_lock_sock(sk);
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 505445a9598f..7b12cc2db136 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -306,7 +306,7 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
>   			return PTR_ERR(ssk);
>   		}
>   
> -		ret = sk_setsockopt(ssk, SOL_SOCKET, optname, optval, optlen);
> +		ret = sk_setsockopt(ssk, SOL_SOCKET, optname, optval, optlen, false);
>   		if (ret == 0) {
>   			if (optname == SO_REUSEPORT)
>   				sk->sk_reuseport = ssk->sk_reuseport;
> diff --git a/net/socket.c b/net/socket.c
> index 9a8e4452b9b2..4bdca39685a6 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -2385,7 +2385,7 @@ int do_sock_getsockopt(struct socket *sock, bool compat, int level,
>   
>   	ops = READ_ONCE(sock->ops);
>   	if (level == SOL_SOCKET) {
> -		err = sk_getsockopt(sock->sk, level, optname, optval, optlen);
> +		err = sk_getsockopt(sock->sk, level, optname, optval, optlen, false);
>   	} else if (unlikely(!ops->getsockopt)) {
>   		err = -EOPNOTSUPP;
>   	} else {


