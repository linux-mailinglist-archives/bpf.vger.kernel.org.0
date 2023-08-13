Return-Path: <bpf+bounces-7665-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA1377A475
	for <lists+bpf@lfdr.de>; Sun, 13 Aug 2023 02:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77BAC1C203B8
	for <lists+bpf@lfdr.de>; Sun, 13 Aug 2023 00:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A0210F6;
	Sun, 13 Aug 2023 00:59:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001507E;
	Sun, 13 Aug 2023 00:59:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7727C433C8;
	Sun, 13 Aug 2023 00:59:06 +0000 (UTC)
Date: Sat, 12 Aug 2023 20:59:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Zheao Li <me@manjusaka.me>
Cc: edumazet@google.com, bpf@vger.kernel.org, davem@davemloft.net,
 dsahern@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
 ncardwell@google.com, netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v3] tracepoint: add new `tcp:tcp_ca_event` trace event
Message-ID: <20230812205905.016106c0@rorschach.local.home>
In-Reply-To: <20230812201249.62237-1-me@manjusaka.me>
References: <CANn89iKQXhqgOTkSchH6Bz-xH--pAoSyEORBtawqBTvgG+dFig@mail.gmail.com>
	<20230812201249.62237-1-me@manjusaka.me>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Aug 2023 20:12:50 +0000
Zheao Li <me@manjusaka.me> wrote:

> +TRACE_EVENT(tcp_ca_event,
> +
> +	TP_PROTO(struct sock *sk, const u8 ca_event),
> +
> +	TP_ARGS(sk, ca_event),
> +
> +	TP_STRUCT__entry(
> +		__field(const void *, skaddr)
> +		__field(__u16, sport)
> +		__field(__u16, dport)
> +		__field(__u16, family)
> +		__array(__u8, saddr, 4)
> +		__array(__u8, daddr, 4)
> +		__array(__u8, saddr_v6, 16)
> +		__array(__u8, daddr_v6, 16)
> +		__field(__u8, ca_event)

Please DO NOT LISTEN TO CHECKPATCH!

The above looks horrendous! Put it back to:

> +		__field(	const void *,	skaddr			)
> +		__field(	__u16,		sport			)
> +		__field(	__u16,		dport			)
> +		__field(	__u16,		family			)
> +		__array(	__u8,		saddr,		4	)
> +		__array(	__u8,		daddr,		4	)
> +		__array(	__u8,		saddr_v6,	16	)
> +		__array(	__u8,		daddr_v6,	16	)
> +		__field(	__u8,		ca_event		)

See how much better it looks I can see fields this way.

The "checkpatch" way is a condensed mess.

-- Steve

> +	),
> +
> +	TP_fast_assign(
> +		struct inet_sock *inet = inet_sk(sk);
> +		__be32 *p32;
> +
> +		__entry->skaddr = sk;
> +
> +		__entry->sport = ntohs(inet->inet_sport);
> +		__entry->dport = ntohs(inet->inet_dport);
> +		__entry->family = sk->sk_family;
> +
> +		p32 = (__be32 *) __entry->saddr;
> +		*p32 = inet->inet_saddr;
> +
> +		p32 = (__be32 *) __entry->daddr;
> +		*p32 =  inet->inet_daddr;
> +
> +		TP_STORE_ADDRS(__entry, inet->inet_saddr,
> inet->inet_daddr,
> +			   sk->sk_v6_rcv_saddr, sk->sk_v6_daddr);
> +
> +		__entry->ca_event = ca_event;
> +	),
> +
> +	TP_printk("family=%s sport=%hu dport=%hu saddr=%pI4
> daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c ca_event=%s",
> +		  show_family_name(__entry->family),
> +		  __entry->sport, __entry->dport,
> +		  __entry->saddr, __entry->daddr,
> +		  __entry->saddr_v6, __entry->daddr_v6,
> +		  show_tcp_ca_event_names(__entry->ca_event))
> +);
> +
>  #endif /* _TRACE_TCP_H */
>  

