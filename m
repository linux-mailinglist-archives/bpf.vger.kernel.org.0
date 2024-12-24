Return-Path: <bpf+bounces-47578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8429FBA23
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 08:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 810B47A1765
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 07:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6453517B506;
	Tue, 24 Dec 2024 07:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YYotzNve"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E419414E2C2;
	Tue, 24 Dec 2024 07:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735024692; cv=none; b=jWbCrhDUetmxp76Mr+oyDqcilUsCRXnjHkmzSy2+K+LdhiuYE1fEMR0tFZOI0M4AZCSprrWCh7Not/5nQeEUlKtOh/APwxVv5X28FvqVcP6qS9Cw+1q3IfwR/Wu2odcHiVMo/UFArilwPql1CdJx5YY3vnp8f2WrC+1Eaey9dJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735024692; c=relaxed/simple;
	bh=zAU/eKyEzGk+3K5AOwFFx8CrXOSm8JnmIf5DSGHbDK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gDZMz6UEy7RXFHpSlhfulry/I97JiAOGnOAQEND44oZ8Qr0TLXoWYAOZyloY8l3fB/8VhhY7aAUJFKbV6iMluyhK8e3Uga8eRAo4ekuxnZfRB6astjmBQNcRlQ26spN8qZgztFyNElEXfNz3eSYHRz8UiUT2sj/owjoEUdCd36Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YYotzNve; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=HD5MgmlcS1PWDjepWNXtUV19Tsx44BQ2lz1u98gzmS0=;
	b=YYotzNveM0h7JSsDTn8xisHxBAdmg7ykDn6jB1zyDAetl4LEQBhFirrr2fJl+4
	5fWxmbxhCyB5Ice4+X0kNEXbIb2MV7PGtl7xKdRZiNvl4MvU0n+9PU6frPiNC3sq
	KOoYlC+1Xixvp1YTxi+ZhABV7HxtU2hRzeLKefspL09E8=
Received: from osx (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD339XSX2pn8SRSBQ--.57001S2;
	Tue, 24 Dec 2024 15:16:35 +0800 (CST)
Date: Tue, 24 Dec 2024 15:16:34 +0800
From: Jiayuan Chen <mrpre@163.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, 
	John Fastabend <john.fastabend@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org, 
	martin.lau@linux.dev, ast@kernel.org, edumazet@google.com, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	song@kernel.org, andrii@kernel.org, mhal@rbox.co, yonghong.song@linux.dev, 
	daniel@iogearbox.net, xiyou.wangcong@gmail.com, horms@kernel.org
Subject: Re: [PATCH bpf v3 1/2] bpf: fix wrong copied_seq calculation
Message-ID: <lu7yzq2rsbu2jkffpm4pyinvggs6hrjyyi2h6udtgcq2thfs4k@3b2qsgjo4owm>
References: <20241218053408.437295-1-mrpre@163.com>
 <20241218053408.437295-2-mrpre@163.com>
 <87jzbxvw9y.fsf@cloudflare.com>
 <ojwjcubviyjxpucryc3ypi4b77h5f5g6ouv7ovaljah5harfyj@jue7hqit2t5n>
 <87h66ujex9.fsf@cloudflare.com>
 <87msgmuhvt.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87msgmuhvt.fsf@cloudflare.com>
X-CM-TRANSID:_____wD339XSX2pn8SRSBQ--.57001S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXw45ZF18uF1DJr4DtF13urg_yoWrGr4DpF
	WkJayDGFyUJFyUuwnYyas7X34jq393KFWUWr18XayfZrn2krn3XFWvkF4YyayUGr45Zr13
	Xryjgws3uwnrua7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uc2-nUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/1tbiDwm-p2dqXpIjSgAAs2

On Mon, Dec 23, 2024 at 11:57:58PM +0800, Jakub Sitnicki wrote:
> On Mon, Dec 23, 2024 at 09:57 PM +01, Jakub Sitnicki wrote:
> > On Thu, Dec 19, 2024 at 05:30 PM +08, Jiayuan Chen wrote:
> >> Currently, not all modules using strparser have issues with
> >> copied_seq miscalculation. The issue exists mainly with
> >> bpf::sockmap + strparser because bpf::sockmap implements a
> >> proprietary read interface for user-land: tcp_bpf_recvmsg_parser().
> >>
> >> Both this and strp_recv->tcp_read_sock update copied_seq, leading
> >> to errors.
> >>
> >> This is why I rewrote the tcp_read_sock() interface specifically for
> >> bpf::sockmap.
> >
> > All right. Looks like reusing read_skb is not going to pan out.
> >
> > But I think we should not give up just yet. It's easy to add new code.
> >
> > We can try to break up and parametrize tcp_read_sock - if other
> > maintainers are not against it. Does something like this work for you?
> >
> >   https://github.com/jsitnicki/linux/commits/review/stp-copied_seq/idea-2/
> 
> Actually it reads better if we just add early bailout to tcp_read_sock:
> 
>   https://github.com/jsitnicki/linux/commits/review/stp-copied_seq/idea-2.1/
> 
> ---8<---
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 6a07d98017f7..6564ea3b6cd4 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1565,12 +1565,13 @@ EXPORT_SYMBOL(tcp_recv_skb);
>   *	  or for 'peeking' the socket using this routine
>   *	  (although both would be easy to implement).
>   */
> -int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
> -		  sk_read_actor_t recv_actor)
> +static inline int __tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
> +				  sk_read_actor_t recv_actor, bool noack,
> +				  u32 *copied_seq)
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
> +			sk_read_actor_t recv_actor, u32 *copied_seq)
> +{
> +	return __tcp_read_sock(sk, desc, recv_actor, true, copied_seq);
> +}
> +EXPORT_SYMBOL(tcp_read_sock_noack);
> +
>  int tcp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
>  {
>  	struct sk_buff *skb;

This modification definitely reduces code duplication and makes it more
elegant compared to my previous idea. Also If we want to avoid modifying
the strp code and not introduce new ops, perhaps we could revert to the
simplest solution:
'''
void sk_psock_start_strp(struct sock *sk, struct sk_psock *psock)
{
    ...
    sk->sk_data_ready = sk_psock_strp_data_ready;
    /* Replacement */
    psock->saved_read_sock = sk->sk_socket->ops->read_sock;
    sk->sk_socket->ops->read_sock = tcp_read_sock_noack;
}
'''
If acceptable, I can incorporate this approach in the next patch version.

BTW, It seems CI run checkpatch.pl with '--strict' argument so I lost few
of warnings compare to CI, will fix it in next revision.


