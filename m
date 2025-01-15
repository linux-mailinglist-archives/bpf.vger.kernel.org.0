Return-Path: <bpf+bounces-48913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58612A11CED
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 10:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8529188B9CF
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 09:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEAE246A3D;
	Wed, 15 Jan 2025 09:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="S1aO34th"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9C1246A09;
	Wed, 15 Jan 2025 09:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932040; cv=none; b=OqbIfQEG2rG5Th/rWidaqlYDzQzw0X8kkMUQDw0Mj8YwqD3GqOs5YZu/Md2q2ZPoF6rDC4ZxuuRgiHsIOJjYcAjGYzFVCOvFtaU5LXQZpmqsTfllqhagod0+8udteR0vRsPMiHqCnRl3FMwSWkMRHlP5EO1KED9BE+nuwhnIH9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932040; c=relaxed/simple;
	bh=0SbXO/ikYw9MNi/LCUVjKxtIfUARrWW3BkRlVBA5MZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gx/xvdg8gO5MLOoGuOxx8dNXHhkC+WyfN3LjJTG0pAzgu0bCJejfB3z0kquZBNEsCGgATvFWruRvWODmMxDRfS212g6eYHl3M8e01ZsEnk8UmLikbhPCvB5rnoEjXUS3G3KB5VBFWdkL1vgwS6OX61JzA/W1CgMlvtwpXckV8/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=S1aO34th; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=ORzGAoZLDUNCiSablFf0VkBztvJE5S/3eR3QPvTy90I=;
	b=S1aO34th/5zl/HADChHyZqUHhVrkfgTP63wLiV7/5/WGKfhm7kksq4T5xBguBR
	aGKtF+8WrDJXrVgFkJgbKQoWlHqKQTMVx2S4LaU/NU2DvHsSDNbe+/5sxlsS0hd6
	GbS9+w42aZ3S3SGSnqCOT3pEu+LF0BMKoBLc3HlT0rNRY=
Received: from osx (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wCHjRAfeodnV2xXGQ--.25333S2;
	Wed, 15 Jan 2025 17:04:33 +0800 (CST)
Date: Wed, 15 Jan 2025 17:04:31 +0800
From: Jiayuan Chen <mrpre@163.com>
To: bpf@vger.kernel.org, jakub@cloudflare.com, john.fastabend@gmail.com
Cc: netdev@vger.kernel.org, martin.lau@linux.dev, ast@kernel.org, 
	edumazet@google.com, davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, linux-kernel@vger.kernel.org, song@kernel.org, andrii@kernel.org, 
	mhal@rbox.co, yonghong.song@linux.dev, daniel@iogearbox.net, 
	xiyou.wangcong@gmail.com, horms@kernel.org, corbet@lwn.net, eddyz87@gmail.com, 
	cong.wang@bytedance.com, shuah@kernel.org, mykolal@fb.com, jolsa@kernel.org, 
	haoluo@google.com, sdf@fomichev.me, kpsingh@kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH bpf v6 1/3] bpf: fix wrong copied_seq calculation
Message-ID: <pxqoucw6bdnchyfvgyfpxaxnjwbf3t6zzaliyoul5vwn3ycqpd@jtv52cji6b4k>
References: <20250114132312.49407-1-mrpre@163.com>
 <20250114132312.49407-2-mrpre@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114132312.49407-2-mrpre@163.com>
X-CM-TRANSID:_____wCHjRAfeodnV2xXGQ--.25333S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Gry5Ww43JF43Wr13uF45Jrb_yoWfWrW5pF
	1DAaykCrW7JFyUu3WrJFykGrZI93yrtFW7Cr18X3y3trs2gr1fXFyrKF1YyF1UKr45CF43
	tr4DGwsxCw1DZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ue89NUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/xtbBDw3Vp2eHcgbMBgABsv

On Tue, Jan 14, 2025 at 09:23:09PM +0800, Jiayuan Chen wrote:
> --- a/include/net/strparser.h
> +++ b/include/net/strparser.h
> @@ -43,6 +43,8 @@ struct strparser;
>  struct strp_callbacks {
>  	int (*parse_msg)(struct strparser *strp, struct sk_buff *skb);
>  	void (*rcv_msg)(struct strparser *strp, struct sk_buff *skb);
> +	int (*read_sock)(struct strparser *strp, read_descriptor_t *desc,
> +			 sk_read_actor_t recv_actor);
>  	int (*read_sock_done)(struct strparser *strp, int err);
>  	void (*abort_parser)(struct strparser *strp, int err);
>  	void (*lock)(struct strparser *strp);
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index e9b37b76e894..5a40bea15016 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -729,6 +729,9 @@ void tcp_get_info(struct sock *, struct tcp_info *);
>  /* Read 'sendfile()'-style from a TCP socket */
>  int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
>  		  sk_read_actor_t recv_actor);
> +int tcp_read_sock_noack(struct sock *sk, read_descriptor_t *desc,
> +			sk_read_actor_t recv_actor, bool noack,
> +			u32 *copied_seq);
>  int tcp_read_skb(struct sock *sk, skb_read_actor_t recv_actor);
>  struct sk_buff *tcp_recv_skb(struct sock *sk, u32 seq, u32 *off);
>  void tcp_read_done(struct sock *sk, size_t len);
> @@ -2609,6 +2612,11 @@ static inline void tcp_eat_skb(struct sock *sk, struct sk_buff *skb)
>  }
>  #endif
>  
> +#ifdef CONFIG_BPF_STREAM_PARSER
> +int tcp_bpf_strp_read_sock(struct sock *sk, read_descriptor_t *desc,
> +			   sk_read_actor_t recv_actor);
> +#endif /* CONFIG_BPF_STREAM_PARSER */
> +
>  int tcp_bpf_sendmsg_redir(struct sock *sk, bool ingress,
>  			  struct sk_msg *msg, u32 bytes, int flags);
>  #endif /* CONFIG_NET_SOCK_MSG */
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 61f3f3d4e528..2e404caf10f2 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -548,7 +548,9 @@ static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
>  		if (unlikely(num_sge < 0))
>  			return num_sge;
>  	}
> -
> +#if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
> +	psock->ingress_bytes += len;
> +#endif
>  	copied = len;
>  	msg->sg.start = 0;
>  	msg->sg.size = copied;
> @@ -1092,6 +1094,20 @@ static int sk_psock_strp_read_done(struct strparser *strp, int err)
>  	return err;
>  }
>  
> +static int sk_psock_strp_read_sock(struct strparser *strp,
> +				   read_descriptor_t *desc,
> +				   sk_read_actor_t recv_actor)
> +{
> +	struct sock *sk = strp->sk;
> +
> +	if (WARN_ON(!sk_is_tcp(sk))) {
> +		desc->error = -EINVAL;
> +		return 0;
> +	}
> +
> +	return tcp_bpf_strp_read_sock(sk, desc, recv_actor);
> +}
> +

well, reply to myself. This code doesn't feel right if we want support
other stream socket like unix, which has been supported by stream_verdict.
Still an abstraction should be used. Should we just add a handler like
'read_sock_nock' into 'struct proto_ops' like read_skb or read_sock does,
without some replacement action which introduced by v1.

or just add handler into 'struct psock' if we do not want to break
'struct proto_ops' definition.

CC jakub.

>  static int sk_psock_strp_parse(struct strparser *strp, struct sk_buff *skb)
>  {
>  	struct sk_psock *psock = container_of(strp, struct sk_psock, strp);
> @@ -1136,6 +1152,7 @@ int sk_psock_init_strp(struct sock *sk, struct sk_psock *psock)
>  
>  	static const struct strp_callbacks cb = {
>  		.rcv_msg	= sk_psock_strp_read,
> +		.read_sock	= sk_psock_strp_read_sock,
>  		.read_sock_done	= sk_psock_strp_read_done,
>  		.parse_msg	= sk_psock_strp_parse,
>  	};
> @@ -1144,6 +1161,9 @@ int sk_psock_init_strp(struct sock *sk, struct sk_psock *psock)
>  	if (!ret)
>  		sk_psock_set_state(psock, SK_PSOCK_RX_STRP_ENABLED);
>  
> +	if (sk_is_tcp(sk))
> +		psock->copied_seq = tcp_sk(sk)->copied_seq;
> +
>  	return ret;
>  }
>  
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 0d704bda6c41..285678d8ce07 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1565,12 +1565,13 @@ EXPORT_SYMBOL(tcp_recv_skb);
>   *	  or for 'peeking' the socket using this routine
>   *	  (although both would be easy to implement).
>   */
> -int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
> -		  sk_read_actor_t recv_actor)
> +static int __tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
> +			   sk_read_actor_t recv_actor, bool noack,
> +			   u32 *copied_seq)
>  {
>  	struct sk_buff *skb;
>  	struct tcp_sock *tp = tcp_sk(sk);
> -	u32 seq = tp->copied_seq;
> +	u32 seq = *copied_seq;
>  	u32 offset;
>  	int copied = 0;
>  
> @@ -1624,9 +1625,12 @@ int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
>  		tcp_eat_recv_skb(sk, skb);
>  		if (!desc->count)
>  			break;
> -		WRITE_ONCE(tp->copied_seq, seq);
> +		WRITE_ONCE(*copied_seq, seq);
>  	}
> -	WRITE_ONCE(tp->copied_seq, seq);
> +	WRITE_ONCE(*copied_seq, seq);
> +
> +	if (noack)
> +		goto out;
>  
>  	tcp_rcv_space_adjust(sk);
>  
> @@ -1635,10 +1639,25 @@ int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
>  		tcp_recv_skb(sk, seq, &offset);
>  		tcp_cleanup_rbuf(sk, copied);
>  	}
> +out:
>  	return copied;
>  }
> +
> +int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
> +		  sk_read_actor_t recv_actor)
> +{
> +	return __tcp_read_sock(sk, desc, recv_actor, false,
> +			       &tcp_sk(sk)->copied_seq);
> +}
>  EXPORT_SYMBOL(tcp_read_sock);
>  
> +int tcp_read_sock_noack(struct sock *sk, read_descriptor_t *desc,
> +			sk_read_actor_t recv_actor, bool noack,
> +			u32 *copied_seq)
> +{
> +	return __tcp_read_sock(sk, desc, recv_actor, noack, copied_seq);
> +}
> +
>  int tcp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
>  {
>  	struct sk_buff *skb;
> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index 47f65b1b70ca..d303486bfc59 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -698,3 +698,44 @@ void tcp_bpf_clone(const struct sock *sk, struct sock *newsk)
>  		newsk->sk_prot = sk->sk_prot_creator;
>  }
>  #endif /* CONFIG_BPF_SYSCALL */
> +
> +#if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
> +int tcp_bpf_strp_read_sock(struct sock *sk, read_descriptor_t *desc,
> +			   sk_read_actor_t recv_actor)
> +{
> +	struct sk_psock *psock;
> +	struct tcp_sock *tp;
> +	int copied = 0;
> +
> +	tp = tcp_sk(sk);
> +	rcu_read_lock();
> +	psock = sk_psock(sk);
> +	if (WARN_ON(!psock)) {
> +		desc->error = -EINVAL;
> +		goto out;
> +	}
> +
> +	psock->ingress_bytes = 0;
> +	/* We could easily add copied_seq and noack into desc then call
> +	 * ops->read_sock without calling symbol directly. But unfortunately
> +	 * most descriptors used by other modules are not inited with zero.
> +	 * Also replacing ops->read_sock can't be workd without introducing
> +	 * new ops as ops itself is located in rodata segment.
> +	 */
> +	copied = tcp_read_sock_noack(sk, desc, recv_actor, true,
> +				     &psock->copied_seq);
> +	if (copied < 0)
> +		goto out;
> +	/* recv_actor may redirect skb to another socket(SK_REDIRECT) or
> +	 * just put skb into ingress queue of current socket(SK_PASS).
> +	 * For SK_REDIRECT, we need 'ack' the frame immediately but for
> +	 * SK_PASS, the 'ack' was delay to tcp_bpf_recvmsg_parser()
> +	 */
> +	tp->copied_seq = psock->copied_seq - psock->ingress_bytes;
> +	tcp_rcv_space_adjust(sk);
> +	__tcp_cleanup_rbuf(sk, copied - psock->ingress_bytes);
> +out:
> +	rcu_read_unlock();
> +	return copied;
> +}
> +#endif /* CONFIG_BPF_STREAM_PARSER */
> diff --git a/net/strparser/strparser.c b/net/strparser/strparser.c
> index 8299ceb3e373..95696f42647e 100644
> --- a/net/strparser/strparser.c
> +++ b/net/strparser/strparser.c
> @@ -347,7 +347,10 @@ static int strp_read_sock(struct strparser *strp)
>  	struct socket *sock = strp->sk->sk_socket;
>  	read_descriptor_t desc;
>  
> -	if (unlikely(!sock || !sock->ops || !sock->ops->read_sock))
> +	if (unlikely(!sock || !sock->ops))
> +		return -EBUSY;
> +
> +	if (unlikely(!strp->cb.read_sock && !sock->ops->read_sock))
>  		return -EBUSY;
>  
>  	desc.arg.data = strp;
> @@ -355,7 +358,10 @@ static int strp_read_sock(struct strparser *strp)
>  	desc.count = 1; /* give more than one skb per call */
>  
>  	/* sk should be locked here, so okay to do read_sock */
> -	sock->ops->read_sock(strp->sk, &desc, strp_recv);
> +	if (strp->cb.read_sock)
> +		strp->cb.read_sock(strp, &desc, strp_recv);
> +	else
> +		sock->ops->read_sock(strp->sk, &desc, strp_recv);
>  
>  	desc.error = strp->cb.read_sock_done(strp, desc.error);
>  
> @@ -468,6 +474,7 @@ int strp_init(struct strparser *strp, struct sock *sk,
>  	strp->cb.unlock = cb->unlock ? : strp_sock_unlock;
>  	strp->cb.rcv_msg = cb->rcv_msg;
>  	strp->cb.parse_msg = cb->parse_msg;
> +	strp->cb.read_sock = cb->read_sock;
>  	strp->cb.read_sock_done = cb->read_sock_done ? : default_read_sock_done;
>  	strp->cb.abort_parser = cb->abort_parser ? : strp_abort_strp;
>  
> -- 
> 2.43.5


