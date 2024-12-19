Return-Path: <bpf+bounces-47312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3679F7896
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 10:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 897B37A4952
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 09:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887812206B1;
	Thu, 19 Dec 2024 09:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TFaGhtxj"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2DA23B0;
	Thu, 19 Dec 2024 09:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734600740; cv=none; b=E2kQELzbc3R+YUJZvl+jqf2ujSfkA+NJcmhHqqsQlKSyH6YhHi9U75ajbgQ3Oy8LUUbA3H0xN4ZiaGOOBBE6jchtYJMsQy7GGgIVZi1k3hC3untBeYTNLX5tLdwe35JCDP1G9WQ4fGtUI/DoUdyS29n0I3qWTPP/iU7oc5KmTYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734600740; c=relaxed/simple;
	bh=sVU+wRPX6XgdtGLLWfzDqNDcEAlCA1QYvIWI5zOUGfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wb4QEAr7/7U6wkLwj16vwdQxYx2OagUUmcHGH7A612QXcnWrYt/xMDt2lBRIlM2ZGXuiiNqAV8EqnZE6xyM6720a1GssphAmd/2HmLWturSp1m1GwkLmq8M6/D5DxYWQa7HfrDyHVE4M8jhxRVw7YLOI2fgp+ACbXT2SaU9dJMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TFaGhtxj; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=1hJmEkXkHLf73pKLKD5N7Cmoz4MXGDElEZfQ+ZKcKao=;
	b=TFaGhtxjzAbw6MnGoiUZ8IsHcfign+Wl9cUnjXaYAJigpWyrpFw0lgSMCPpAK0
	jFfytX0bjnhbNVc+O0i04Z5fUmwyVgb+Nc9eAQHgFW6ZT1HFRvXEsGJOUbwIFcmx
	1kFNtuwrb0XrWp81YEwo+l9A2h8tI1h4EanLMTvO1jxMc=
Received: from osx (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wC3_iTO52NnpU3tAA--.26627S2;
	Thu, 19 Dec 2024 17:30:55 +0800 (CST)
Date: Thu, 19 Dec 2024 17:30:53 +0800
From: Jiayuan Chen <mrpre@163.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, ast@kernel.org, 
	edumazet@google.com, davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, linux-kernel@vger.kernel.org, song@kernel.org, 
	john.fastabend@gmail.com, andrii@kernel.org, mhal@rbox.co, yonghong.song@linux.dev, 
	daniel@iogearbox.net, xiyou.wangcong@gmail.com, horms@kernel.org
Subject: Re: [PATCH bpf v3 1/2] bpf: fix wrong copied_seq calculation
Message-ID: <ojwjcubviyjxpucryc3ypi4b77h5f5g6ouv7ovaljah5harfyj@jue7hqit2t5n>
References: <20241218053408.437295-1-mrpre@163.com>
 <20241218053408.437295-2-mrpre@163.com>
 <87jzbxvw9y.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzbxvw9y.fsf@cloudflare.com>
X-CM-TRANSID:_____wC3_iTO52NnpU3tAA--.26627S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3GFy8Cr4UGFWUWr4kAFyfCrg_yoW7ZFyrpF
	1DC3W5WrsrtFy8Z3Z5JF9ayF4Fg34rtFW8CryrW3yayrs7Kr95XFy8Kr1ayr1UGrs5ZFWU
	urWDuwsxuw1DXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uc2-nUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/xtbBDwC6p2dj3XbSdgABsY

On Wed, Dec 18, 2024 at 04:35:53PM +0800, Jakub Sitnicki wrote:
[...]
> On Wed, Dec 18, 2024 at 01:34 PM +08, Jiayuan Chen wrote:
> > +		if (tcp_flags & TCPHDR_FIN)
> > +			break;
> > +	}
> > +
> > +	WRITE_ONCE(psock->strp_offset, offset);
> > +	return copied;
> > +}
> > +
> >  enum {
> >  	TCP_BPF_IPV4,
> >  	TCP_BPF_IPV6,
> 
> [...]
> 
> To reiterate my earlier question / suggestion [1] - it would be great if
> we can avoid duplicating what tcp_read_skb / tcp_read_sock already do.
> 
> Keeping extra state in sk_psock / strparser seems to be the key. I think
> you should be able to switch strp_data_ready / str_read_sock to
> ->read_skb and make an adapter around strp_recv.
> 
> Rough code below is what I have in mind. Not tested, compiled
> only. Don't expect it to work. And I haven't even looked how to address
> the kTLS path. But you get the idea.
> 
> [1] https://msgid.link/87o71bx1l4.fsf@cloudflare.com
> 
> ---8<---
> 
> diff --git a/include/net/strparser.h b/include/net/strparser.h
> index 41e2ce9e9e10..0dd48c1bc23b 100644
> --- a/include/net/strparser.h
> +++ b/include/net/strparser.h
> @@ -95,9 +95,14 @@ struct strparser {
>  	u32 interrupted : 1;
>  	u32 unrecov_intr : 1;
>  
> +	unsigned int need_bytes;
> +
>  	struct sk_buff **skb_nextp;
>  	struct sk_buff *skb_head;
> -	unsigned int need_bytes;
> +
> +	int rcv_err;
> +	unsigned int rcv_off;
> +
>  	struct delayed_work msg_timer_work;
>  	struct work_struct work;
>  	struct strp_stats stats;
> diff --git a/net/strparser/strparser.c b/net/strparser/strparser.c
> index 8299ceb3e373..8a08996429d3 100644
> --- a/net/strparser/strparser.c
> +++ b/net/strparser/strparser.c
> @@ -18,6 +18,7 @@
>  #include <linux/poll.h>
>  #include <linux/rculist.h>
>  #include <linux/skbuff.h>
> +#include <linux/skmsg.h>
>  #include <linux/socket.h>
>  #include <linux/uaccess.h>
>  #include <linux/workqueue.h>
> @@ -327,13 +328,39 @@ int strp_process(struct strparser *strp, struct sk_buff *orig_skb,
>  }
>  EXPORT_SYMBOL_GPL(strp_process);
>  
> -static int strp_recv(read_descriptor_t *desc, struct sk_buff *orig_skb,
> -		     unsigned int orig_offset, size_t orig_len)
> +static int strp_read_skb(struct sock *sk, struct sk_buff *skb)
>  {
> -	struct strparser *strp = (struct strparser *)desc->arg.data;
> -
> -	return __strp_recv(desc, orig_skb, orig_offset, orig_len,
> -			   strp->sk->sk_rcvbuf, strp->sk->sk_rcvtimeo);
> +	struct sk_psock *psock = sk_psock_get(sk);
> +	struct strparser *strp = &psock->strp;
> +	read_descriptor_t desc = {
> +		.arg.data = strp,
> +		.count = 1,
> +		.error = 0,
> +	};
> +	unsigned int off;
> +	size_t len;
> +	int used;
> +
> +	off = strp->rcv_off;
> +	len = skb->len - off;
> +	used = __strp_recv(&desc, skb, off, len,
> +			   sk->sk_rcvbuf, sk->sk_rcvtimeo);
> +	/* skb not consumed */
> +	if (used <= 0) {
> +		strp->rcv_err = used;
> +		return used;
> +	}
> +	/* skb partially consumed */
> +	if (used < len) {
> +		strp->rcv_err = 0;
> +		strp->rcv_off += used;
> +		return -EPIPE;	/* stop reading */
> +	}
> +	/* skb fully consumed */
> +	strp->rcv_err = 0;
> +	strp->rcv_off = 0;
> +	tcp_eat_recv_skb(sk, skb);
> +	return used;
>  }
>  
>  static int default_read_sock_done(struct strparser *strp, int err)
> @@ -345,21 +372,14 @@ static int default_read_sock_done(struct strparser *strp, int err)
>  static int strp_read_sock(struct strparser *strp)
>  {
>  	struct socket *sock = strp->sk->sk_socket;
> -	read_descriptor_t desc;
>  
> -	if (unlikely(!sock || !sock->ops || !sock->ops->read_sock))
> +	if (unlikely(!sock || !sock->ops || !sock->ops->read_skb))
>  		return -EBUSY;
>  
> -	desc.arg.data = strp;
> -	desc.error = 0;
> -	desc.count = 1; /* give more than one skb per call */
> -
>  	/* sk should be locked here, so okay to do read_sock */
> -	sock->ops->read_sock(strp->sk, &desc, strp_recv);
> -
> -	desc.error = strp->cb.read_sock_done(strp, desc.error);
> +	sock->ops->read_skb(strp->sk, strp_read_skb);
>  
> -	return desc.error;
> +	return strp->cb.read_sock_done(strp, strp->rcv_err);
>  }
>  
>  /* Lower sock lock held */

Thanks Jakub Sitnicki.

I understand your point about using tcp_read_skb to replace
tcp_read_sock, avoiding code duplication and reducing the number of
interfaces.

Currently, not all modules using strparser have issues with
copied_seq miscalculation. The issue exists mainly with
bpf::sockmap + strparser because bpf::sockmap implements a
proprietary read interface for user-land: tcp_bpf_recvmsg_parser().

Both this and strp_recv->tcp_read_sock update copied_seq, leading
to errors.

This is why I rewrote the tcp_read_sock() interface specifically for
bpf::sockmap.

So far, I found two other modules that use the standard strparser module:

1.kcmsock.c
2.espintcp.c (ESP over TCP implementation)
(Interesting, these two don't have self-tests)

Take kcm as an example: its custom read interface kcm_recvmsg()
does not conflict with copied_seq updates in tcp_read_sock().

Therefore, for kcmsock, updating copied_seq in tcp_read_sock is
necessary and aligns with the read semantics. espintcp is similar.

In summary, different modules using strp_recv have different needs
for copied_seq. I still insist on implementing tcp_bpf_read_sock()
specifically for bpf::sockmap without affecting others.

Otherwise, we may need tcp_read_skb() to determine whether
to update copied_seq according to the different needs of each module.


Additionally,
I've found that KTLS has its own read_sock() and
a strparser-like implementation (in tls_strp.c), separate from the
standard strparser module. Therefore, even with your proposed
solution, KTLS may be not affected.

regards


