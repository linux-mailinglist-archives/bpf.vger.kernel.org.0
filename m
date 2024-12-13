Return-Path: <bpf+bounces-46853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 878179F0EAC
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 15:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 386C628239A
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 14:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECCA1E1A3E;
	Fri, 13 Dec 2024 14:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EqVja4p+"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8F01E1A2B;
	Fri, 13 Dec 2024 14:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734098944; cv=none; b=uKA+FH1RcG2f6fez85aTN4ODkwF4GC7Tc+oZVl0Ix9JXhi0D/1KiA4RLQbr97NmxiF67xBWF1vnwhoXIOFhB2BY2UK1CR4e+TwO/qpcxnJ8HAAyEmFrmrMPa29Od+Y12vtkgcmC+toXYCGfKalBZzztSQbSKrb//gXWPzd/pN2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734098944; c=relaxed/simple;
	bh=CD1WOtRLzuVMHhngLdy/bz/qra6W87BJvO+WW4EKqOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftKwS+eHZkYFLn//hXh2uMTzbewSKkT+7tsYace83pOsGNq8gQ2J5ZBecBE8gxly/jDoVBLIPO2GLQcQFYz2qgUxFu+OUG0FjhFYB9Qjv5XD9RZ8b1Aa6/hfivTB7Z2pZuay3GEIj7uDXKMLLE9tdjl4zR4XKCBzrYdPZJYq59s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EqVja4p+; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=Stc+DbZ8vt98n/5CtpcpiMrgDGti6EGxF31caTQlCvg=;
	b=EqVja4p+6RaogHoVMPZ4mTngDjaFaUt9ln+pg5l5Tv0iLKYhfnLEItVLd/9PqD
	kapp1C88lGJQeHoQa8FEdsWXwHkfXJYQNjannr5Xoq8WG3oZI74kH81fGOvvAHFb
	beMXgjsv2Cl/npx+Wgr8cAHzfRoSDaIrLclnfk+5vDA70=
Received: from iZj6c3ewsy61ybpk7hrb16Z (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3f+60P1xn40hMAQ--.32891S2;
	Fri, 13 Dec 2024 22:07:50 +0800 (CST)
Date: Fri, 13 Dec 2024 22:07:48 +0800
From: Jiayuan Chen <mrpre@163.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, ast@kernel.org, 
	edumazet@google.com, jakub@cloudflare.com, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org, song@kernel.org, 
	andrii@kernel.org, mhal@rbox.co, yonghong.song@linux.dev, daniel@iogearbox.net, 
	xiyou.wangcong@gmail.com, horms@kernel.org
Subject: Re: [PATCH bpf v2 1/2] bpf: fix wrong copied_seq calculation
Message-ID: <xtsolkbkdecvlbqx4zjtvd74c45lg5kqx2ojgdvovxrjgaghij@ld4wjwi7imvy>
References: <20241209152740.281125-1-mrpre@163.com>
 <20241209152740.281125-2-mrpre@163.com>
 <6758f4ce604d5_4e1720871@john.notmuch>
 <f2pur5raimm5y3phmtwubf6yf3sniphwgql4c4k7md25lxcehm@3qwyp4zibnrd>
 <675b8f8f65e28_ff0720890@john.notmuch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <675b8f8f65e28_ff0720890@john.notmuch>
X-CM-TRANSID:_____wD3f+60P1xn40hMAQ--.32891S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWFWrWry7KF1Utr43tFWxCrg_yoWrXr43pa
	97Aay7KwnrJrW0v34Iv397WF1Sg348KF43Jr1rWa43Cr98Wrn3tryfKF4a9F45Krs5uF4U
	Zw4UtFsruwsxuFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U-dbbUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/xtbBDwS0p2dcNYbidAAAsG

On Thu, Dec 12, 2024 at 05:36:15PM -0800, John Fastabend wrote:
[...]
> > > I think easier is to do similar logic to read_sock and track
> > > offset and len? Did I miss something.
> > 
> > Thanks to John Fastabend.
> > 
> > Let me explain it.
> > Now I only replace the read_sock handler when using strparser.
> > 
> > My previous implementation added the replacement of read_sock in
> > sk_psock_start_strp() to more explicitly require replacement when using
> > strparser, for instance:
> > '''skmsg.c
> > void sk_psock_start_strp(struct sock *sk, struct sk_psock *psock)
> > {
> >     ...
> >     sk->sk_data_ready = sk_psock_strp_data_ready;
> >     /* Replacement */
> >     sk->sk_socket->ops->read_sock = tcp_bpf_read_sock;
> > }
> > '''
> > 
> > As you can see that it only works for strparser.
> > (The current implementation of replacement in tcp_bpf_update_proto()
> > achieves the same effect just not as obviously.)
> > 
> > So the current implementation of recv_actor() can only be strp_recv(),
> > with the call stack as follows:
> > '''
> > sk_psock_strp_data_ready
> >   -> strp_data_ready
> >     -> strp_read_sock
> >       -> strp_recv
> > '''
> > 
> > The implementation of strp_recv() will consume all input skb. Even if it
> > reads part of the data, it will clone it, then place it into its own
> > queue, expecting the caller to release the skb. I didn't find any
> > logic like tcp_try_coalesce() (fix me if i miss something).
> 
> 
> So here is what I believe the flow is,
> 
> sk_psock_strp_data_ready
>   -> str_data_ready
>      -> strp_read_sock
>         -> sock->ops->read_sock(.., strp_recv)
> 
> 
> We both have the same idea up to here. But then the proposed data_ready()
> call
> 
> +	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
> +		u8 tcp_flags;
> +		int used;
> +
> +		WARN_ON_ONCE(!skb_set_owner_sk_safe(skb, sk));
> +		tcp_flags = TCP_SKB_CB(skb)->tcp_flags;
> +		used = recv_actor(desc, skb, 0, skb->len);
> 
> The recv_actor here is strp_recv() all good so far. But, because
> that skb is still on the sk_receive_queue() the TCP stack may
> at the same time do
> 
>  tcp_data_queue
>   -> tcp_queue_rcv
>      -> tail = skb_peek_tail(&sk->sk_receive_queue);
>         tcp_try_coalesce(sk, tail, skb, fragstolen)
>          -> skb_try_coalesce()
>             ... skb->len += len
> 
> So among other things you will have changed the skb->len and added some
> data to it. If this happens while you are running the recv actor we will
> eat the data by calling tcp_eat_recv_skb(). Any data added from the
> try_coalesce will just be dropped and never handled? The clone() from
> the strparser side doesn't help you the tcp_eat_recv_skb call will
> unlik the skb from the sk_receive_queue.
> 
> I don't think you have any way to protect this at the moment.

Thanks John Fastabend.

It seems sk was always locked whenever data_ready called.

'''
bh_lock_sock_nested(sk)
tcp_v4_do_rcv(sk)
   |
   |-> tcp_rcv_established
   	|-> tcp_queue_rcv 
   		|-> tcp_try_coalesce
   |
   |-> tcp_rcv_state_process
   	|-> tcp_queue_rcv
   		|-> tcp_try_coalesce
   |
   |-> sk->sk_data_ready()

bh_unlock_sock(sk)
'''

other data_ready path:
'''
lock_sk(sk)
sk->sk_data_ready()
release_sock(sk)
'''

I can not find any concurrency there. 
> > 
> > The record of the 'offset' is stored within its own context(strparser/_strp_msg).
> > With all skbs and offset saved in strp context, the caller does not need to
> > maintain it.
> > 
> > I have also added various logic tests for this situation in the test
> > case, and it works correctly. 
> > > > +		/* strparser clone and consume all input skb
> > > > +		 * even in waiting head or body status
> > > > +		 */
> > > > +		tcp_eat_recv_skb(sk, skb);
> > > > +		if (used <= 0) {
> > > > +			if (!copied)
> > > > +				copied = used;
> > > > +			break;
> > > > +		}
> > > > +		copied += used;
> > > > +		if (!desc->count)
> > > > +			break;
> > > > +		if (tcp_flags & TCPHDR_FIN)
> > > > +			break;
> > > > +	}
> > > > +	return copied;
> > > > +}
> > > > +
> > > >  enum {
> > > >  	TCP_BPF_IPV4,
> > > >  	TCP_BPF_IPV6,
> > > > @@ -595,6 +636,10 @@ enum {
> > 
> > 
> 
> 


