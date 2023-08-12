Return-Path: <bpf+bounces-7664-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB4977A41D
	for <lists+bpf@lfdr.de>; Sun, 13 Aug 2023 01:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98C7328100F
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 23:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD2D8F4E;
	Sat, 12 Aug 2023 23:00:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2470C2585;
	Sat, 12 Aug 2023 23:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FAEAC433C7;
	Sat, 12 Aug 2023 23:00:19 +0000 (UTC)
Date: Sat, 12 Aug 2023 19:00:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Manjusaka <me@manjusaka.me>
Cc: edumazet@google.com, bpf@vger.kernel.org, davem@davemloft.net,
 dsahern@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
 ncardwell@google.com, netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v3] tracepoint: add new `tcp:tcp_ca_event` trace event
Message-ID: <20230812190017.3a62396c@rorschach.local.home>
In-Reply-To: <c0d899ef-38c8-4e24-b351-9a0958a0e669@manjusaka.me>
References: <CANn89iKQXhqgOTkSchH6Bz-xH--pAoSyEORBtawqBTvgG+dFig@mail.gmail.com>
	<20230812201249.62237-1-me@manjusaka.me>
	<c0d899ef-38c8-4e24-b351-9a0958a0e669@manjusaka.me>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 13 Aug 2023 04:17:24 +0800
Manjusaka <me@manjusaka.me> wrote:

> On 2023/8/13 04:12, Zheao Li wrote:
> > In normal use case, the tcp_ca_event would be changed in high frequency.
> > 
> > The developer can monitor the network quality more easier by tracing
> > TCP stack with this TP event.
> > 
> > So I propose to add a `tcp:tcp_ca_event` trace event
> > like `tcp:tcp_cong_state_set` to help the people to
> > trace the TCP connection status
> > 
> > Signed-off-by: Zheao Li <me@manjusaka.me>
> > ---
> >  include/net/tcp.h          |  9 ++----
> >  include/trace/events/tcp.h | 60 ++++++++++++++++++++++++++++++++++++++
> >  net/ipv4/tcp_cong.c        | 10 +++++++
> >  3 files changed, 72 insertions(+), 7 deletions(-)
> > 
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index 0ca972ebd3dd..a68c5b61889c 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -1154,13 +1154,8 @@ static inline bool tcp_ca_needs_ecn(const struct sock *sk)
> >  	return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ECN;
> >  }
> >  
> > -static inline void tcp_ca_event(struct sock *sk, const enum tcp_ca_event event)
> > -{
> > -	const struct inet_connection_sock *icsk = inet_csk(sk);
> > -
> > -	if (icsk->icsk_ca_ops->cwnd_event)
> > -		icsk->icsk_ca_ops->cwnd_event(sk, event);
> > -}
> > +/* from tcp_cong.c */
> > +void tcp_ca_event(struct sock *sk, const enum tcp_ca_event event);
> >  
> >  /* From tcp_cong.c */
> >  void tcp_set_ca_state(struct sock *sk, const u8 ca_state);
> > diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
> > index 7b1ddffa3dfc..993eb00403ea 100644
> > --- a/include/trace/events/tcp.h
> > +++ b/include/trace/events/tcp.h
> > @@ -41,6 +41,18 @@
> >  	TP_STORE_V4MAPPED(__entry, saddr, daddr)
> >  #endif
> >  
> > +/* The TCP CA event traced by tcp_ca_event*/
> > +#define tcp_ca_event_names    \
> > +		EM(CA_EVENT_TX_START)     \
> > +		EM(CA_EVENT_CWND_RESTART) \
> > +		EM(CA_EVENT_COMPLETE_CWR) \
> > +		EM(CA_EVENT_LOSS)         \
> > +		EM(CA_EVENT_ECN_NO_CE)    \
> > +		EMe(CA_EVENT_ECN_IS_CE)
> > +
> > +#define show_tcp_ca_event_names(val) \
> > +	__print_symbolic(val, tcp_ca_event_names)
> > +
> >  /*
> >   * tcp event with arguments sk and skb
> >   *
> > @@ -419,6 +431,54 @@ TRACE_EVENT(tcp_cong_state_set,
> >  		  __entry->cong_state)
> >  );
> >  
> > +TRACE_EVENT(tcp_ca_event,
> > +
> > +	TP_PROTO(struct sock *sk, const u8 ca_event),
> > +
> > +	TP_ARGS(sk, ca_event),
> > +
> > +	TP_STRUCT__entry(
> > +		__field(const void *, skaddr)
> > +		__field(__u16, sport)
> > +		__field(__u16, dport)
> > +		__field(__u16, family)
> > +		__array(__u8, saddr, 4)
> > +		__array(__u8, daddr, 4)
> > +		__array(__u8, saddr_v6, 16)
> > +		__array(__u8, daddr_v6, 16)
> > +		__field(__u8, ca_event)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		struct inet_sock *inet = inet_sk(sk);
> > +		__be32 *p32;
> > +
> > +		__entry->skaddr = sk;
> > +
> > +		__entry->sport = ntohs(inet->inet_sport);
> > +		__entry->dport = ntohs(inet->inet_dport);
> > +		__entry->family = sk->sk_family;
> > +
> > +		p32 = (__be32 *) __entry->saddr;
> > +		*p32 = inet->inet_saddr;
> > +
> > +		p32 = (__be32 *) __entry->daddr;
> > +		*p32 =  inet->inet_daddr;
> > +
> > +		TP_STORE_ADDRS(__entry, inet->inet_saddr, inet->inet_daddr,
> > +			   sk->sk_v6_rcv_saddr, sk->sk_v6_daddr);
> > +
> > +		__entry->ca_event = ca_event;
> > +	),
> > +
> > +	TP_printk("family=%s sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c ca_event=%s",
> > +		  show_family_name(__entry->family),
> > +		  __entry->sport, __entry->dport,
> > +		  __entry->saddr, __entry->daddr,
> > +		  __entry->saddr_v6, __entry->daddr_v6,
> > +		  show_tcp_ca_event_names(__entry->ca_event))
> > +);
> > +
> >  #endif /* _TRACE_TCP_H */
> >  
> >  /* This part must be outside protection */
> > diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
> > index 1b34050a7538..fb7ec6ebbbd0 100644
> > --- a/net/ipv4/tcp_cong.c
> > +++ b/net/ipv4/tcp_cong.c
> > @@ -34,6 +34,16 @@ struct tcp_congestion_ops *tcp_ca_find(const char *name)
> >  	return NULL;
> >  }
> >  
> > +void tcp_ca_event(struct sock *sk, const enum tcp_ca_event event)
> > +{
> > +	const struct inet_connection_sock *icsk = inet_csk(sk);
> > +
> > +	trace_tcp_ca_event(sk, (u8)event);
> > +
> > +	if (icsk->icsk_ca_ops->cwnd_event)
> > +		icsk->icsk_ca_ops->cwnd_event(sk, event);
> > +}
> > +
> >  void tcp_set_ca_state(struct sock *sk, const u8 ca_state)
> >  {
> >  	struct inet_connection_sock *icsk = inet_csk(sk);  
> 
> For more information, this patch is not passthrough the `./scripts/checkpatch.pl` check 
> with the following error message `Macros with complex values should be enclosed in parentheses`.
> 
> I have no idea because there is no complex expression and the `include/trace/events/sock.h` files 
> also failed in the style check.

Please ignore all checkpatch.pl messages when it comes to the
TRACE_EVENT() macro and pretty much anything it recommends to do with
TRACE_EVENTS() in general.

checkpatch.pl's recommendations on the include/trace code is just
wrong, and makes it worse.

One day I need to add a patch to fix checkpatch.

-- Steve



