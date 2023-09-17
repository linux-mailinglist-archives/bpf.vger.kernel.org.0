Return-Path: <bpf+bounces-10222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8FF7A35C4
	for <lists+bpf@lfdr.de>; Sun, 17 Sep 2023 16:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 933071C20832
	for <lists+bpf@lfdr.de>; Sun, 17 Sep 2023 14:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4724A3B;
	Sun, 17 Sep 2023 14:07:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B69290B;
	Sun, 17 Sep 2023 14:06:59 +0000 (UTC)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D00B10B;
	Sun, 17 Sep 2023 07:06:57 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id EA5843200913;
	Sun, 17 Sep 2023 10:06:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sun, 17 Sep 2023 10:06:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjusaka.me; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm1; t=
	1694959612; x=1695046012; bh=36oFoU5myC0cy0uQQQU6bYn1vlg4AMZg4/A
	uOQKAsNk=; b=Q37CfMF5lQQDtGOpW3feCoFYHh/MbZl53T2Oq/iZobgzCeBX2hv
	aUcwJyDJrMPyC03aQ2cEQtnH+nQZM82zlkADgdxA+Bl0PaHa51IFnkgFTj4iqi7e
	y9kXX6pWNFOadV/RKHreNU4B+9Kjv0xAOM0ZwTGEqeEOQ1U6hsBJuz8/vLVcrnc+
	0XgUFZnBYyw2Nxs2FIxi/jatVtFLtBp+wHnwGWcuUukW0pORe06viWg/Ou+27A9w
	5gSE6QgZ4uHsBIb4h14Vyik1pfmrNtAycHyjzEgMIZZI+tYxObh4Y3pRniXH231x
	2SB2Y//iCIaBNdknZN0EfJAEoa/9c2Bzlmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1694959612; x=1695046012; bh=36oFoU5myC0cy0uQQQU6bYn1vlg4AMZg4/A
	uOQKAsNk=; b=WyIzRYv5w8HGgIwhCD90/+5VadegU+KAnmx8lAeN/7fiFfRF255
	0/myjRmx5b8QmeRvNmzM0FaE035quYWhfYn1PG+UvtI/0yio68CNP1gcxvq5tGw/
	oS9/Hl7oQrfEq/0xlaR4Il+MnkfaY9g3rtHuzLmk5y/LHkRXJLGoe3jWFGC3F/jX
	L0wJWpymSoJCd+0puPb9QdRdBYYfZdXCnZEKyS810pp0XiUxr80y1q6AbgDWCMx3
	YCnoKBkr4ygbG2ov59X7YO26jOd3HcEhoLoNL8VUQKqDok7Flwo5wCu2G9t/q9Xm
	4zgQeLQ7UJV6qFORiXgQLPOCV8aiRBHheYQ==
X-ME-Sender: <xms:_AcHZVkR6gLBDbvxcco6MZYWP1Lq63jaPHuJOl5H2fB3wBKmD5rYRA>
    <xme:_AcHZQ11Qf38LK9VuVqF-jUH1kSj7tCIqE2dVetVG4HcNjFCxAnzGv6qYHHSe1Ms9
    0pMdd07E-W5r4uAnTY>
X-ME-Received: <xmr:_AcHZbrcZMmWtdUL1yauWssKV-G6IcCbOCAe0H-eQxxTwLqQJLKj9lEn-PZGknyZIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejiedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefkffggfgfuvfevfhfhjggtgfesth
    ejredttddvjeenucfhrhhomhepofgrnhhjuhhsrghkrgcuoehmvgesmhgrnhhjuhhsrghk
    rgdrmhgvqeenucggtffrrghtthgvrhhnpeeiheefvddvgeektddvveegtefghfehhfeuue
    efueetieejkefhueffffekieetfeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgvsehmrg
    hnjhhushgrkhgrrdhmvg
X-ME-Proxy: <xmx:_AcHZVmDnGqeJoFcQ_hxkHFWl2XeYkcsT-FvUBNDUaCOgWroT77Ykg>
    <xmx:_AcHZT2n9YL0WSh7XoORIpFghCVN4-IIwTk67TBVyHQC8OY0-vtjkg>
    <xmx:_AcHZUuf-wkCC1TbAKXvj0q7Xq6wt9ougeWH26Xz3IbZ6CuaivluJg>
    <xmx:_AcHZVwsLUwViYoXVZ_aXzsJ2-rfaQ2Ga26DFaifYhSFf0c2ucliHA>
Feedback-ID: i3ea9498d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 17 Sep 2023 10:06:48 -0400 (EDT)
Message-ID: <c978c5a5-a9a6-41bf-86f2-2eebf6888e1e@manjusaka.me>
Date: Sun, 17 Sep 2023 22:06:45 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] tracepoint: add new `tcp:tcp_ca_event` trace event
Content-Language: en-US
To: edumazet@google.com, mhiramat@kernel.org, rostedt@goodmis.org,
 davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20230825133246.344364-1-me@manjusaka.me>
From: Manjusaka <me@manjusaka.me>
Autocrypt: addr=me@manjusaka.me;
 keydata= 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
In-Reply-To: <20230825133246.344364-1-me@manjusaka.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/8/25 21:32, Zheao Li wrote:
> Hello 
> 
> This the 4th version of the patch, the previous discusstion is here
> 
> https://lore.kernel.org/linux-trace-kernel/20230807183308.9015-1-me@manjusaka.me/
> 
> In this version of the code, here's some different:
> 
> 1. The event name has been changed from `tcp_ca_event_set` to
> `tcp_ca_event`
> 
> 2. Output the current protocol family in TP_printk
> 
> 3. Show the ca_event symbol instead of the original number
> 
> But the `./scripts/checkpatch.pl` has been failed to check this patch,
> because we sill have some code error in ./scripts/checkpatch.pl(in
> another world, the test would be failed when we use the 
> scripts/checkpatch.pl to check the events/tcp.h
> 
> Feel free to ask me if you have have any issues and ideas.
> 
> Thanks
> 
> ---
> 
> In normal use case, the tcp_ca_event would be changed in high frequency.
> 
> The developer can monitor the network quality more easier by tracing
> TCP stack with this TP event.
> 
> So I propose to add a `tcp:tcp_ca_event` trace event
> like `tcp:tcp_cong_state_set` to help the people to
> trace the TCP connection status
> 
> Signed-off-by: Zheao Li <me@manjusaka.me>
> ---
>  include/net/tcp.h          |  9 ++----
>  include/trace/events/tcp.h | 60 ++++++++++++++++++++++++++++++++++++++
>  net/ipv4/tcp_cong.c        | 10 +++++++
>  3 files changed, 72 insertions(+), 7 deletions(-)
> 
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 0ca972ebd3dd..a68c5b61889c 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1154,13 +1154,8 @@ static inline bool tcp_ca_needs_ecn(const struct sock *sk)
>  	return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ECN;
>  }
>  
> -static inline void tcp_ca_event(struct sock *sk, const enum tcp_ca_event event)
> -{
> -	const struct inet_connection_sock *icsk = inet_csk(sk);
> -
> -	if (icsk->icsk_ca_ops->cwnd_event)
> -		icsk->icsk_ca_ops->cwnd_event(sk, event);
> -}
> +/* from tcp_cong.c */
> +void tcp_ca_event(struct sock *sk, const enum tcp_ca_event event);
>  
>  /* From tcp_cong.c */
>  void tcp_set_ca_state(struct sock *sk, const u8 ca_state);
> diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
> index 7b1ddffa3dfc..993eb00403ea 100644
> --- a/include/trace/events/tcp.h
> +++ b/include/trace/events/tcp.h
> @@ -41,6 +41,18 @@
>  	TP_STORE_V4MAPPED(__entry, saddr, daddr)
>  #endif
>  
> +/* The TCP CA event traced by tcp_ca_event*/
> +#define tcp_ca_event_names    \
> +		EM(CA_EVENT_TX_START)     \
> +		EM(CA_EVENT_CWND_RESTART) \
> +		EM(CA_EVENT_COMPLETE_CWR) \
> +		EM(CA_EVENT_LOSS)         \
> +		EM(CA_EVENT_ECN_NO_CE)    \
> +		EMe(CA_EVENT_ECN_IS_CE)
> +
> +#define show_tcp_ca_event_names(val) \
> +	__print_symbolic(val, tcp_ca_event_names)
> +
>  /*
>   * tcp event with arguments sk and skb
>   *
> @@ -419,6 +431,54 @@ TRACE_EVENT(tcp_cong_state_set,
>  		  __entry->cong_state)
>  );
>  
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
> +		TP_STORE_ADDRS(__entry, inet->inet_saddr, inet->inet_daddr,
> +			   sk->sk_v6_rcv_saddr, sk->sk_v6_daddr);
> +
> +		__entry->ca_event = ca_event;
> +	),
> +
> +	TP_printk("family=%s sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c ca_event=%s",
> +		  show_family_name(__entry->family),
> +		  __entry->sport, __entry->dport,
> +		  __entry->saddr, __entry->daddr,
> +		  __entry->saddr_v6, __entry->daddr_v6,
> +		  show_tcp_ca_event_names(__entry->ca_event))
> +);
> +
>  #endif /* _TRACE_TCP_H */
>  
>  /* This part must be outside protection */
> diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
> index 1b34050a7538..fb7ec6ebbbd0 100644
> --- a/net/ipv4/tcp_cong.c
> +++ b/net/ipv4/tcp_cong.c
> @@ -34,6 +34,16 @@ struct tcp_congestion_ops *tcp_ca_find(const char *name)
>  	return NULL;
>  }
>  
> +void tcp_ca_event(struct sock *sk, const enum tcp_ca_event event)
> +{
> +	const struct inet_connection_sock *icsk = inet_csk(sk);
> +
> +	trace_tcp_ca_event(sk, (u8)event);
> +
> +	if (icsk->icsk_ca_ops->cwnd_event)
> +		icsk->icsk_ca_ops->cwnd_event(sk, event);
> +}
> +
>  void tcp_set_ca_state(struct sock *sk, const u8 ca_state)
>  {
>  	struct inet_connection_sock *icsk = inet_csk(sk);


Ping to review(

