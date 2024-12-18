Return-Path: <bpf+bounces-47193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 276159F5E2F
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 06:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9126E1890ECB
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 05:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F36155330;
	Wed, 18 Dec 2024 05:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Am+H1u+U"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39FB153824;
	Wed, 18 Dec 2024 05:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734498317; cv=none; b=k2RVE7Lm7dIArugjVVzfkbQhHrIJTP+Up6bJMNFNp1W7bhHz/zo/z0rbYyWF4yAXu0DIw8Gy1p4EkBfnagA1cDPc7a1QN1q4iBZVO4dkra+ilOL+hoI1kjyUt40z6LPynv5ErfCJVtspupCXrQIpFhXQN4zn9DJiTnDEZE4cjbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734498317; c=relaxed/simple;
	bh=ZvzL8w3cps5gLtpUCtsRfTTODfRUtfOmFSgDTVUBhLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxBSECW/8bUYqNyazXtO84ibV8j11zm8y9x/Lmi/gbrCYwqV/sm3IrD+k9VDvQOHjC/4EcCHSwn2av3gT1qH4eJSzElGjF/fT+qTf3yq2iaVjHW5IbzWgLPPVCiEHwEl4g0YMLlujG+5VeN6lB9R26Bg2VMIQjI/ozch9H4B2zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Am+H1u+U; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=zasN1dYdbLx3vfULJvVHCDlAh4jtvi119Mhrz18Dc8E=;
	b=Am+H1u+Unn2mluR2xXUHc5pOtEd6uoHOlSkbqBHpHPTSBhukcJmeM4lOtpfOsn
	kdmD+F/2RVr1Sr95+EPrGjdBO9JVGByaEAzOdF4ecC6/quKw8Rb3Ss+ughCS275v
	wpSemm4UN2UmY8Dmr/wMEb2/Cll0K63uZQEFnvQMeepVQ=
Received: from osx (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3f7M1V2JnUMhFBQ--.28991S2;
	Wed, 18 Dec 2024 13:01:42 +0800 (CST)
Date: Wed, 18 Dec 2024 13:01:41 +0800
From: Jiayuan Chen <mrpre@163.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, ast@kernel.org, 
	edumazet@google.com, jakub@cloudflare.com, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org, song@kernel.org, 
	andrii@kernel.org, mhal@rbox.co, yonghong.song@linux.dev, daniel@iogearbox.net, 
	xiyou.wangcong@gmail.com, horms@kernel.org
Subject: Re: [PATCH bpf v2 1/2] bpf: fix wrong copied_seq calculation
Message-ID: <luget5z5ep2ikuwnkpddbdwl2yueb34nhqqms2hhij25guut4l@qm56ut744lz5>
References: <20241209152740.281125-1-mrpre@163.com>
 <20241209152740.281125-2-mrpre@163.com>
 <6758f4ce604d5_4e1720871@john.notmuch>
 <f2pur5raimm5y3phmtwubf6yf3sniphwgql4c4k7md25lxcehm@3qwyp4zibnrd>
 <675b8f8f65e28_ff0720890@john.notmuch>
 <xtsolkbkdecvlbqx4zjtvd74c45lg5kqx2ojgdvovxrjgaghij@ld4wjwi7imvy>
 <675f9f3184dfe_159ba20815@john.notmuch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <675f9f3184dfe_159ba20815@john.notmuch>
X-CM-TRANSID:_____wD3f7M1V2JnUMhFBQ--.28991S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWFWrGrW5uFW5Ar45Kr17KFg_yoW5Gw4rpa
	9rJay7tr4kJry5A3s2vr4IqFy09w1rCr1fXFyfWFyayrn0qrn3tryrGr429FsFgrs5Ca1v
	y3yDXFZrXwn8CaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uc2-nUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/xtbBDwa5p2diUPaUYgAAsC

On Sun, Dec 15, 2024 at 07:32:01PM +0800, John Fastabend wrote:
> Jiayuan Chen wrote:
[...]
> > On Thu, Dec 12, 2024 at 05:36:15PM -0800, John Fastabend wrote:
> > [...]
> > > 
> > > 
> > > So here is what I believe the flow is,
> > > 
> > > sk_psock_strp_data_ready
> > >   -> str_data_ready
> > >      -> strp_read_sock
> > >         -> sock->ops->read_sock(.., strp_recv)
> > > 
> > > 
> > > We both have the same idea up to here. But then the proposed data_ready()
> > > call
> > > 
> > > +	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
> > > +		u8 tcp_flags;
> > > +		int used;
> > > +
> > > +		WARN_ON_ONCE(!skb_set_owner_sk_safe(skb, sk));
> > > +		tcp_flags = TCP_SKB_CB(skb)->tcp_flags;
> > > +		used = recv_actor(desc, skb, 0, skb->len);
> > > 
> > > The recv_actor here is strp_recv() all good so far. But, because
> > > that skb is still on the sk_receive_queue() the TCP stack may
> > > at the same time do
> > > 
> > >  tcp_data_queue
> > >   -> tcp_queue_rcv
> > >      -> tail = skb_peek_tail(&sk->sk_receive_queue);
> > >         tcp_try_coalesce(sk, tail, skb, fragstolen)
> > >          -> skb_try_coalesce()
> > >             ... skb->len += len
> > > 
> > > So among other things you will have changed the skb->len and added some
> > > data to it. If this happens while you are running the recv actor we will
> > > eat the data by calling tcp_eat_recv_skb(). Any data added from the
> > > try_coalesce will just be dropped and never handled? The clone() from
> > > the strparser side doesn't help you the tcp_eat_recv_skb call will
> > > unlik the skb from the sk_receive_queue.
> > > 
> > > I don't think you have any way to protect this at the moment.
> > 
> > Thanks John Fastabend.
> > 
> > It seems sk was always locked whenever data_ready called.
> > 
> > '''
> > bh_lock_sock_nested(sk)
> > tcp_v4_do_rcv(sk)
> >    |
> >    |-> tcp_rcv_established
> >    	|-> tcp_queue_rcv 
> >    		|-> tcp_try_coalesce
> >    |
> >    |-> tcp_rcv_state_process
> >    	|-> tcp_queue_rcv
> >    		|-> tcp_try_coalesce
> >    |
> >    |-> sk->sk_data_ready()
> > 
> > bh_unlock_sock(sk)
> > '''
> > 
> > other data_ready path:
> > '''
> > lock_sk(sk)
> > sk->sk_data_ready()
> > release_sock(sk)
> > '''
> > 
> > I can not find any concurrency there. 
> 
> OK thanks, one more concern though. What if strp_recv thorws an ENOMEM
> error on the clone? Would we just drop the data then? This is problem
> not the expected behavior its already been ACKed.
> 
> Thanks,
> John
Thank, I did miss ENOMEM error. I also realized that when an ENOMEM error
occurs, the strparser framework will replay the skb, so it is necessary to
record the offset read from the skb to avoid data duplication or loss.

Sorry for the slow response; it took quite some time to write test cases
and set up an environment to simulate ENOMEM. I will send the v3 patch.


