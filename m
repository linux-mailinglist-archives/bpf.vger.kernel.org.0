Return-Path: <bpf+bounces-46685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 301A89EDF84
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 07:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8374A284259
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 06:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35C5204C22;
	Thu, 12 Dec 2024 06:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DQJSrYP2"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BD818787A;
	Thu, 12 Dec 2024 06:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733985409; cv=none; b=g+6UxYP/p/KxM9RQs5G+C4POx7VHZNJWqFbP7r/4dVbiZgvFyL2iBS41qnIdoc/QaU/whzSuyTVL0uyvCASoZnba6yLI752nuZgFeT7BXzER1slRh/1DGQV6wsAvp3YG6VItyMsdDUjEsiQljsHTqXrH+D34x9Nc95QIj6hVL0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733985409; c=relaxed/simple;
	bh=lDxsjLZH7C0fyjI6xqhkI8A/ySf+QdmKlDuuqR0Qn10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qd4Pr9v47aSzHE+wLS0/QPiIIACyG8feTP07d8AxIUViO7qDrbGoQTyJ8fYJtW2equAI+BN07rCi++5ZpBgX5mUuyNzIh+UKUkEM21ZmeERD3BUnWBoCO5VumEsHQEOp9dzabUCWBpD772Tep52VBu01SL3FhAv6FlbESsxDFPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DQJSrYP2; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=fbgwpTLq4/KmJQlk9CjECQduA9917iRpi7SxM7z0tvU=;
	b=DQJSrYP2zEpsiykAp2ADB9ArhOBM1SDAxMRsA4bh1mcWvt4s2LK9ed11/Numt2
	6eY1+qW/bfH6sDCgv1b+0IML0yTptu9Sm5ua428aejweR1on/TzU4Vq9AaafAOKc
	rNWdna4sQv06KHb5N8ip4UdtOqfcIbPOcHs5yULQNLQLg=
Received: from iZ0xi1olgj2q723wq4k6skZ (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3L9LIg1pn8h06AA--.5157S2;
	Thu, 12 Dec 2024 14:33:51 +0800 (CST)
Date: Thu, 12 Dec 2024 14:33:43 +0800
From: Jiayuan Chen <mrpre@163.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, ast@kernel.org, 
	edumazet@google.com, jakub@cloudflare.com, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org, song@kernel.org, 
	andrii@kernel.org, mhal@rbox.co, yonghong.song@linux.dev, daniel@iogearbox.net, 
	xiyou.wangcong@gmail.com, horms@kernel.org
Subject: Re: [PATCH bpf v2 1/2] bpf: fix wrong copied_seq calculation
Message-ID: <f2pur5raimm5y3phmtwubf6yf3sniphwgql4c4k7md25lxcehm@3qwyp4zibnrd>
References: <20241209152740.281125-1-mrpre@163.com>
 <20241209152740.281125-2-mrpre@163.com>
 <6758f4ce604d5_4e1720871@john.notmuch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6758f4ce604d5_4e1720871@john.notmuch>
X-CM-TRANSID:_____wD3L9LIg1pn8h06AA--.5157S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3XF4xGFyfuF17Kr4xKF4xXrb_yoW7Gw48pF
	WkCayrKrnrJFyxu3WvyrZFqF1Sg395KFWYyr1rXayayrWqkrna9rykKF4ayFyrGrs8Zr1U
	Zw4jqrsF9w1DAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uc2-nUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/1tbiWw+zp2dagdk5pgAAs6

On Tue, Dec 10, 2024 at 06:11:26PM -0800, John Fastabend wrote:
> Jiayuan Chen wrote:
> > 'sk->copied_seq' was updated in the tcp_eat_skb() function when the
> > action of a BPF program was SK_REDIRECT. For other actions, like SK_PASS,
> > the update logic for 'sk->copied_seq' was moved to
> > tcp_bpf_recvmsg_parser() to ensure the accuracy of the 'fionread' feature.
> > 
> > It works for a single stream_verdict scenario, as it also modified
> > 'sk_data_ready->sk_psock_verdict_data_ready->tcp_read_skb'
> > to remove updating 'sk->copied_seq'.
> > 
> > However, for programs where both stream_parser and stream_verdict are
> > active(strparser purpose), tcp_read_sock() was used instead of
> > tcp_read_skb() (sk_data_ready->strp_data_ready->tcp_read_sock)
> > tcp_read_sock() now still update 'sk->copied_seq', leading to duplicated
> > updates.
> > 
> > In summary, for strparser + SK_PASS, copied_seq is redundantly calculated
> > in both tcp_read_sock() and tcp_bpf_recvmsg_parser().
> > 
> > The issue causes incorrect copied_seq calculations, which prevent
> > correct data reads from the recv() interface in user-land.
> > 
> > Modifying tcp_read_sock() or strparser implementation directly is
> > unreasonable, as it is widely used in other modules.
> > 
> > Here, we introduce a method tcp_bpf_read_sock() to replace
> > 'sk->sk_socket->ops->read_sock' (like 'tls_build_proto()' does in
> > tls_main.c). Such replacement action was also used in updating
> > tcp_bpf_prots in tcp_bpf.c, so it's not weird.
> > (Note that checkpatch.pl may complain missing 'const' qualifier when we
> > define the bpf-specified 'proto_ops', but we have to do because we need
> > update it).
> > 
> > Also we remove strparser check in tcp_eat_skb() since we implement custom
> > function tcp_bpf_read_sock() without copied_seq updating.
> > 
> > Since strparser currently supports only TCP, it's sufficient for 'ops' to
> > inherit inet_stream_ops.
> > 
> > In strparser's implementation, regardless of partial or full reads,
> > it completely clones the entire skb, allowing us to unconditionally
> > free skb in tcp_bpf_read_sock().
> > 
> > Fixes: e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq")
> > Signed-off-by: Jiayuan Chen <mrpre@163.com>
> 
> [...]
> 
> > +/* The tcp_bpf_read_sock() is an alternative implementation
> > + * of tcp_read_sock(), except that it does not update copied_seq.
> > + */
> > +static int tcp_bpf_read_sock(struct sock *sk, read_descriptor_t *desc,
> > +			     sk_read_actor_t recv_actor)
> > +{
> > +	struct sk_buff *skb;
> > +	int copied = 0;
> > +
> > +	if (sk->sk_state == TCP_LISTEN)
> > +		return -ENOTCONN;
> > +
> > +	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
> > +		u8 tcp_flags;
> > +		int used;
> > +
> > +		WARN_ON_ONCE(!skb_set_owner_sk_safe(skb, sk));
> > +		tcp_flags = TCP_SKB_CB(skb)->tcp_flags;
> > +		used = recv_actor(desc, skb, 0, skb->len);
> 
> Here the skb is still on the receive_queue how does this work with
> tcp_try_coalesce()? So I believe you need to unlink before you
> call the actor which creates a bit of trouble if recv_actor
> doesn't want the entire skb.  
> 
> I think easier is to do similar logic to read_sock and track
> offset and len? Did I miss something.

Thanks to John Fastabend.

Let me explain it.
Now I only replace the read_sock handler when using strparser.

My previous implementation added the replacement of read_sock in
sk_psock_start_strp() to more explicitly require replacement when using
strparser, for instance:
'''skmsg.c
void sk_psock_start_strp(struct sock *sk, struct sk_psock *psock)
{
    ...
    sk->sk_data_ready = sk_psock_strp_data_ready;
    /* Replacement */
    sk->sk_socket->ops->read_sock = tcp_bpf_read_sock;
}
'''

As you can see that it only works for strparser.
(The current implementation of replacement in tcp_bpf_update_proto()
achieves the same effect just not as obviously.)

So the current implementation of recv_actor() can only be strp_recv(),
with the call stack as follows:
'''
sk_psock_strp_data_ready
  -> strp_data_ready
    -> strp_read_sock
      -> strp_recv
'''

The implementation of strp_recv() will consume all input skb. Even if it
reads part of the data, it will clone it, then place it into its own
queue, expecting the caller to release the skb. I didn't find any
logic like tcp_try_coalesce() (fix me if i miss something).

The record of the 'offset' is stored within its own context(strparser/_strp_msg).
With all skbs and offset saved in strp context, the caller does not need to
maintain it.

I have also added various logic tests for this situation in the test
case, and it works correctly. 
> > +		/* strparser clone and consume all input skb
> > +		 * even in waiting head or body status
> > +		 */
> > +		tcp_eat_recv_skb(sk, skb);
> > +		if (used <= 0) {
> > +			if (!copied)
> > +				copied = used;
> > +			break;
> > +		}
> > +		copied += used;
> > +		if (!desc->count)
> > +			break;
> > +		if (tcp_flags & TCPHDR_FIN)
> > +			break;
> > +	}
> > +	return copied;
> > +}
> > +
> >  enum {
> >  	TCP_BPF_IPV4,
> >  	TCP_BPF_IPV6,
> > @@ -595,6 +636,10 @@ enum {


