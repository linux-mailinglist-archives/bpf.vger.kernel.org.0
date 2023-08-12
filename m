Return-Path: <bpf+bounces-7663-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5ECD77A26A
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 22:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45AFF281016
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 20:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9728C15;
	Sat, 12 Aug 2023 20:18:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1738BF7;
	Sat, 12 Aug 2023 20:18:06 +0000 (UTC)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D13211B;
	Sat, 12 Aug 2023 13:17:32 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 9A39A5C0041;
	Sat, 12 Aug 2023 16:17:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 12 Aug 2023 16:17:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjusaka.me; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm3; t=
	1691871451; x=1691957851; bh=dwUrYUSS3BNOuFNrVi8ePvuWThlSfmuh8XX
	ktmDPG2U=; b=kXaNMy2D6AG3GmLfn/Fs1q5KkoZbXnQgg3vspm8hfJmuE1cjCmX
	9zE3a6aZAowUi1SZPZt9Sy8d9CXgwgc7gKnYL5Eb/Fd+IqPm9vpOLoJtMySsiLGG
	yY+euIagmHY1HFqIAjjZ+bJ30gs8CJnYRdV6g6X9E2ffv1gXkMpdtuMSlmBbzE6u
	E+66V/DRZhonnzH4+FQMJYdsfAE19ehVOcXQ9QIG+qge4TiQMwad+3hAg0rxGQ2o
	lOXM0HnlfL6k+NZ0VPI8qsecvwuJ2Sq4OjlOd/9QzSjiX/oUMeMZU+remXATqLKR
	coOyjQKBeaM5dezp1smA63RYKdkuapmVUBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1691871451; x=1691957851; bh=dwUrYUSS3BNOuFNrVi8ePvuWThlSfmuh8XX
	ktmDPG2U=; b=EaovutxcRfBKyqy1pkX5h0d7u6lQx+udCrACmfe+ewgb6APGEbL
	m6z5kk/uPgbEos/xl4blmWgPeehBCLyB0IZn2vkwKBKtFF1mn2dsH6M2Bsz4P3DX
	TeCuxm3LqRfQ3rOlZjxElQwwKIksmabmxBGUTauAsOEu98bJa2zROv2PEY5YU9EM
	W7neEUU11NBx46pF7uL8SH9o0IF49xVfZ7J/mgejAQtpH2KcNzx8XlzUamlDef39
	UEcwGLtDU7L/7BL7shS9Ag2tpgGyGbVL+1TSUE6ct24c2JtIH5l7/YOl5TrUUMSZ
	QjVE1riYT4r/jlUDqgi33tHB3T3JaUxY6fg==
X-ME-Sender: <xms:2ujXZLCNwsf9zpxBLt1_fwfNoi-azSLqTPq4_5rDbrOkfMVZsHNlfg>
    <xme:2ujXZBiQWF_h569jmhOIt6WxIPKvLSCbJBBXfCtfnw8giQTCPexDKnLpWg6WzDgf0
    BJTiR5uvY7F7WncIRk>
X-ME-Received: <xmr:2ujXZGlCq8cWRgMADwwsVJZ_DbrwA_3HeKwpO0DvD7QlgTaMLoziI0E5S1F6_yZFeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddttddgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepkfffgggfuffvvehfhfgjtgfgse
    htjeertddtvdejnecuhfhrohhmpeforghnjhhushgrkhgruceomhgvsehmrghnjhhushgr
    khgrrdhmvgeqnecuggftrfgrthhtvghrnhepheehveejiedugeeltdelveduudeftddtke
    dugfetjeejteefjeeljefftddvueegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepmhgvsehmrghnjhhushgrkhgrrdhmvg
X-ME-Proxy: <xmx:2ujXZNwIRW0WbLf3OqGi-RXwLFwd-1f6U8MwFmM2r4rM_GVLnGnhlw>
    <xmx:2ujXZAQybrvU10xya8F7XHkjd1eCLaWitzMGqcpWIivIsFs3EXrcqg>
    <xmx:2ujXZAaAceNciyVwKltsmymP7y4cUvX6iEidA4FHDlD98tdLG6ebrQ>
    <xmx:2-jXZFJNlS1hadEeGT7eVlNvcWAle8xGxA2SDSCUMSqrLqLjYOXUSw>
Feedback-ID: i3ea9498d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Aug 2023 16:17:26 -0400 (EDT)
Message-ID: <c0d899ef-38c8-4e24-b351-9a0958a0e669@manjusaka.me>
Date: Sun, 13 Aug 2023 04:17:24 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tracepoint: add new `tcp:tcp_ca_event` trace event
Content-Language: en-US
To: edumazet@google.com
Cc: bpf@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
 ncardwell@google.com, netdev@vger.kernel.org, pabeni@redhat.com,
 rostedt@goodmis.org
References: <CANn89iKQXhqgOTkSchH6Bz-xH--pAoSyEORBtawqBTvgG+dFig@mail.gmail.com>
 <20230812201249.62237-1-me@manjusaka.me>
From: Manjusaka <me@manjusaka.me>
In-Reply-To: <20230812201249.62237-1-me@manjusaka.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/8/13 04:12, Zheao Li wrote:
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

For more information, this patch is not passthrough the `./scripts/checkpatch.pl` check 
with the following error message `Macros with complex values should be enclosed in parentheses`.

I have no idea because there is no complex expression and the `include/trace/events/sock.h` files 
also failed in the style check.

