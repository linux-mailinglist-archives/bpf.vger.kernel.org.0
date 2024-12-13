Return-Path: <bpf+bounces-46804-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F2A9F0251
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 02:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B6FA188DB52
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 01:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032B02AE8B;
	Fri, 13 Dec 2024 01:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpF44+6C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA977182D9;
	Fri, 13 Dec 2024 01:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734053781; cv=none; b=ICw99NKTyo9XdFPk7rhZCzNY5zEmmPxXCQGVgC4gk6Wx5OzEISDXWM5ium0vg0rC8F8wBwZWwHTmrDCWmxMul1cDk6TCim0yYxGOeFBWFQHi2n0INglXXwQrtCFHj+r08OjIWE7gfaqaEjPL6wLXExNk0FIRe3wrSEHn4GPsa0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734053781; c=relaxed/simple;
	bh=auyXQvUp4TDy08g8byIVeHrL07BOq/4CFKzdGIKtFXg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=dBnU7Q0RBOe8tuKOKUzVxN0hDOPg89gUE7ovUtAS+zPEWnqdvSSQZRjuXn6rs0UgaXxXar6rxXCzdDLenByIZ8OfbaTJ1ZmuHOly7xYnZnS26QfPe99eIGZ216h2EjfxP1GBy56sFKBBw6B9pUKrMvmgn4Za4ECnKhdgC2gQk8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CpF44+6C; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-728e729562fso1016453b3a.0;
        Thu, 12 Dec 2024 17:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734053778; x=1734658578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=peRgDgLpvMIAJGNVqnPARXF+YYF/CUgxiYyuG7sqwN0=;
        b=CpF44+6CICyz9vP3mfZ5av62EdoXVSksq8pyauytxQPNkLjxwlL8neIeIzxSiRt8CQ
         f4W3xePdl/NePLGyQcsonDg93M7znM0G5jt5SiVehutXa8h9SlEzejmNarqYwTC5eBpj
         pNTdQZ94iJLzWC3uISvIkqb6tDougpSn0WbjjKrH6SAMObvgpiDG2zymfZwlxmMYMYXB
         qlgcHKgiE5ym5bXMFR6/0a25cpygbDiGBW2qtiRmSI9wfT4GLj6FBa5X75VSU9EaDNYf
         FaBEvhQpemEsY/w/pPXMnc5f+mhCs3fUcIbELcTNqwl0kStx9iiiqmgt7EIQQlPlXKYy
         bPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734053778; x=1734658578;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=peRgDgLpvMIAJGNVqnPARXF+YYF/CUgxiYyuG7sqwN0=;
        b=mhszjRCh2rET4QdASYKT2Q9vs5nPXD4Mfz6kdaLQsRDFwJJS+NUfD0ObIEcI7ptfwt
         QPeskdcYhPHEpVbAtY1y96mPH7n2LoFXcTu8YwA/+mUuO3slnTOScOj3jR7sszUkE2Zj
         KaXodALIaR0kaCUweCcoCANUQ8uiryyPLhmr6cY20X8AcMKtsn9s/lOQhcUplohAporP
         HjLbtvxXBpMBsA6cGxbBi0F0BTPjbQ1hNYnBIPSmkrWRMIYg1HW62Ie92UJ6A22MUUTh
         7TK/6GXF9b1PiEGXYMtQn79sEYcigf/1DOv7KGdlX/Q6t1OX7OZ41e1qejb/OrT/gW/N
         NrNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIlyBb9hNYin6IAktbT1C3Z8ELnQU9p+O4Y7d0cI2WkvXCrrgcNodA9JkgEQI/oTg2C0owuYtxL+huj94=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnrYm3safLiT46qYsbHrYkGCSFn0RxNOGIdUspRKDUgzJeMVbv
	EzivyA148anKDO4z1HRZKc0t0z+Z3qCKb32dprbpp9cUgWksutxI
X-Gm-Gg: ASbGncvg2m2nSpFIO8Lg+iJ+Sci8lI49soSSZXAGIolSi79KHVV+O1hJCNTdy3GrAVM
	B53TECxM464LtoLRPz+pRTMIzsfGVlSJDNproln0l8lEGJq8MjNHe+M5v3j9R2N2AIDDcP0Y/q/
	LWF5QdsZaLWOM/vKFTH7KK5LnsugW3mbeaAG9DU9thzKRSpPucaIBh/s0STY1zNLjAyilV2qXC2
	y7hV8DX5r/+1RAS+Emw2ZwPg12xACzcQ3tb93hO6sdFmmHp1EtYO/sRRQ==
X-Google-Smtp-Source: AGHT+IHGIvkpOQ30xcanm0q1lpOKcfYP416ikiRIYx6/qT0vIn/Epk45Jmxr9LQsYCDBDxQAyzmNvQ==
X-Received: by 2002:a05:6a20:c99a:b0:1d5:10d6:92b9 with SMTP id adf61e73a8af0-1e1dfe0ec97mr1200474637.30.1734053778048;
        Thu, 12 Dec 2024 17:36:18 -0800 (PST)
Received: from localhost ([98.97.37.114])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd5592e21fsm6528599a12.83.2024.12.12.17.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 17:36:17 -0800 (PST)
Date: Thu, 12 Dec 2024 17:36:15 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Jiayuan Chen <mrpre@163.com>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org, 
 martin.lau@linux.dev, 
 ast@kernel.org, 
 edumazet@google.com, 
 jakub@cloudflare.com, 
 davem@davemloft.net, 
 dsahern@kernel.org, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 linux-kernel@vger.kernel.org, 
 song@kernel.org, 
 andrii@kernel.org, 
 mhal@rbox.co, 
 yonghong.song@linux.dev, 
 daniel@iogearbox.net, 
 xiyou.wangcong@gmail.com, 
 horms@kernel.org
Message-ID: <675b8f8f65e28_ff0720890@john.notmuch>
In-Reply-To: <f2pur5raimm5y3phmtwubf6yf3sniphwgql4c4k7md25lxcehm@3qwyp4zibnrd>
References: <20241209152740.281125-1-mrpre@163.com>
 <20241209152740.281125-2-mrpre@163.com>
 <6758f4ce604d5_4e1720871@john.notmuch>
 <f2pur5raimm5y3phmtwubf6yf3sniphwgql4c4k7md25lxcehm@3qwyp4zibnrd>
Subject: Re: [PATCH bpf v2 1/2] bpf: fix wrong copied_seq calculation
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jiayuan Chen wrote:
> On Tue, Dec 10, 2024 at 06:11:26PM -0800, John Fastabend wrote:
> > Jiayuan Chen wrote:
> > > 'sk->copied_seq' was updated in the tcp_eat_skb() function when the
> > > action of a BPF program was SK_REDIRECT. For other actions, like SK_PASS,
> > > the update logic for 'sk->copied_seq' was moved to
> > > tcp_bpf_recvmsg_parser() to ensure the accuracy of the 'fionread' feature.
> > > 
> > > It works for a single stream_verdict scenario, as it also modified
> > > 'sk_data_ready->sk_psock_verdict_data_ready->tcp_read_skb'
> > > to remove updating 'sk->copied_seq'.
> > > 
> > > However, for programs where both stream_parser and stream_verdict are
> > > active(strparser purpose), tcp_read_sock() was used instead of
> > > tcp_read_skb() (sk_data_ready->strp_data_ready->tcp_read_sock)
> > > tcp_read_sock() now still update 'sk->copied_seq', leading to duplicated
> > > updates.
> > > 
> > > In summary, for strparser + SK_PASS, copied_seq is redundantly calculated
> > > in both tcp_read_sock() and tcp_bpf_recvmsg_parser().
> > > 
> > > The issue causes incorrect copied_seq calculations, which prevent
> > > correct data reads from the recv() interface in user-land.
> > > 
> > > Modifying tcp_read_sock() or strparser implementation directly is
> > > unreasonable, as it is widely used in other modules.
> > > 
> > > Here, we introduce a method tcp_bpf_read_sock() to replace
> > > 'sk->sk_socket->ops->read_sock' (like 'tls_build_proto()' does in
> > > tls_main.c). Such replacement action was also used in updating
> > > tcp_bpf_prots in tcp_bpf.c, so it's not weird.
> > > (Note that checkpatch.pl may complain missing 'const' qualifier when we
> > > define the bpf-specified 'proto_ops', but we have to do because we need
> > > update it).
> > > 
> > > Also we remove strparser check in tcp_eat_skb() since we implement custom
> > > function tcp_bpf_read_sock() without copied_seq updating.
> > > 
> > > Since strparser currently supports only TCP, it's sufficient for 'ops' to
> > > inherit inet_stream_ops.
> > > 
> > > In strparser's implementation, regardless of partial or full reads,
> > > it completely clones the entire skb, allowing us to unconditionally
> > > free skb in tcp_bpf_read_sock().
> > > 
> > > Fixes: e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq")
> > > Signed-off-by: Jiayuan Chen <mrpre@163.com>
> > 
> > [...]
> > 
> > > +/* The tcp_bpf_read_sock() is an alternative implementation
> > > + * of tcp_read_sock(), except that it does not update copied_seq.
> > > + */
> > > +static int tcp_bpf_read_sock(struct sock *sk, read_descriptor_t *desc,
> > > +			     sk_read_actor_t recv_actor)
> > > +{
> > > +	struct sk_buff *skb;
> > > +	int copied = 0;
> > > +
> > > +	if (sk->sk_state == TCP_LISTEN)
> > > +		return -ENOTCONN;
> > > +
> > > +	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
> > > +		u8 tcp_flags;
> > > +		int used;
> > > +
> > > +		WARN_ON_ONCE(!skb_set_owner_sk_safe(skb, sk));
> > > +		tcp_flags = TCP_SKB_CB(skb)->tcp_flags;
> > > +		used = recv_actor(desc, skb, 0, skb->len);
> > 
> > Here the skb is still on the receive_queue how does this work with
> > tcp_try_coalesce()? So I believe you need to unlink before you
> > call the actor which creates a bit of trouble if recv_actor
> > doesn't want the entire skb.  
> > 
> > I think easier is to do similar logic to read_sock and track
> > offset and len? Did I miss something.
> 
> Thanks to John Fastabend.
> 
> Let me explain it.
> Now I only replace the read_sock handler when using strparser.
> 
> My previous implementation added the replacement of read_sock in
> sk_psock_start_strp() to more explicitly require replacement when using
> strparser, for instance:
> '''skmsg.c
> void sk_psock_start_strp(struct sock *sk, struct sk_psock *psock)
> {
>     ...
>     sk->sk_data_ready = sk_psock_strp_data_ready;
>     /* Replacement */
>     sk->sk_socket->ops->read_sock = tcp_bpf_read_sock;
> }
> '''
> 
> As you can see that it only works for strparser.
> (The current implementation of replacement in tcp_bpf_update_proto()
> achieves the same effect just not as obviously.)
> 
> So the current implementation of recv_actor() can only be strp_recv(),
> with the call stack as follows:
> '''
> sk_psock_strp_data_ready
>   -> strp_data_ready
>     -> strp_read_sock
>       -> strp_recv
> '''
> 
> The implementation of strp_recv() will consume all input skb. Even if it
> reads part of the data, it will clone it, then place it into its own
> queue, expecting the caller to release the skb. I didn't find any
> logic like tcp_try_coalesce() (fix me if i miss something).


So here is what I believe the flow is,

sk_psock_strp_data_ready
  -> str_data_ready
     -> strp_read_sock
        -> sock->ops->read_sock(.., strp_recv)


We both have the same idea up to here. But then the proposed data_ready()
call

+	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
+		u8 tcp_flags;
+		int used;
+
+		WARN_ON_ONCE(!skb_set_owner_sk_safe(skb, sk));
+		tcp_flags = TCP_SKB_CB(skb)->tcp_flags;
+		used = recv_actor(desc, skb, 0, skb->len);

The recv_actor here is strp_recv() all good so far. But, because
that skb is still on the sk_receive_queue() the TCP stack may
at the same time do

 tcp_data_queue
  -> tcp_queue_rcv
     -> tail = skb_peek_tail(&sk->sk_receive_queue);
        tcp_try_coalesce(sk, tail, skb, fragstolen)
         -> skb_try_coalesce()
            ... skb->len += len

So among other things you will have changed the skb->len and added some
data to it. If this happens while you are running the recv actor we will
eat the data by calling tcp_eat_recv_skb(). Any data added from the
try_coalesce will just be dropped and never handled? The clone() from
the strparser side doesn't help you the tcp_eat_recv_skb call will
unlik the skb from the sk_receive_queue.

I don't think you have any way to protect this at the moment.

> 
> The record of the 'offset' is stored within its own context(strparser/_strp_msg).
> With all skbs and offset saved in strp context, the caller does not need to
> maintain it.
> 
> I have also added various logic tests for this situation in the test
> case, and it works correctly. 
> > > +		/* strparser clone and consume all input skb
> > > +		 * even in waiting head or body status
> > > +		 */
> > > +		tcp_eat_recv_skb(sk, skb);
> > > +		if (used <= 0) {
> > > +			if (!copied)
> > > +				copied = used;
> > > +			break;
> > > +		}
> > > +		copied += used;
> > > +		if (!desc->count)
> > > +			break;
> > > +		if (tcp_flags & TCPHDR_FIN)
> > > +			break;
> > > +	}
> > > +	return copied;
> > > +}
> > > +
> > >  enum {
> > >  	TCP_BPF_IPV4,
> > >  	TCP_BPF_IPV6,
> > > @@ -595,6 +636,10 @@ enum {
> 
> 



