Return-Path: <bpf+bounces-56914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED40FAA08B6
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 12:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 076A14645D2
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 10:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B032BE0FF;
	Tue, 29 Apr 2025 10:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AJkcKIOt"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED692BD59D
	for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 10:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745923006; cv=none; b=gDMnhMfkO51CHdTCymdARSDLPua2F0q3JSEmJdtxDygSsd3FERItlFBVzIOrXau7GeEL8GYcyHaXvPItF9FXJC2Fotsn0LsvELsVVmtOyH8zqs337RvgyRJLs/T3WgMLpXhTBOPyciL3KQcqIXKSMLx/8MG1ha23j3E/Ngale3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745923006; c=relaxed/simple;
	bh=z4O32WXMbZp6KoDD/rLAOJVdIV2a6ApoC4W1W2ysjr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O5L6Nf+dWEaFCKmDVptNoZRGSycdDFD2Fs98TvjaO8Lmvu5t82OHbZMSnwdQJwsjLWBM8EKMnINzmfKvxXxHnqwQmJZNra+kzhYl0dlrYtzVhbyqWCbPd5CqtmnEBdqHSvWP5o2mqaPXC498BRA8QnzeD5kCH2ZLW2UGOov5Yl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AJkcKIOt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745923003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jnnK4v0ZhrRY7uhbTKq6B6d9n3dw0rEk4NULWBTSKCY=;
	b=AJkcKIOth5Qjp+vGdIQ3yl90LykNpheaFlMvp5hnXDAA8vsM29qhRFjVWiOIlvz9YHbQ/j
	UMtooykto27+4kviT4pwXnL/c7VjvrZuVoF0VILR9Jv0ZVdnKxKwjXiy/0kVYoVx/TjJbq
	SbRv9mSj5Cs4kg4gdY06eemF+iZ7m5M=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-UsjO4X2BO2-aU7KpC6ArYQ-1; Tue, 29 Apr 2025 06:36:39 -0400
X-MC-Unique: UsjO4X2BO2-aU7KpC6ArYQ-1
X-Mimecast-MFC-AGG-ID: UsjO4X2BO2-aU7KpC6ArYQ_1745922999
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ace942ab877so262779766b.1
        for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 03:36:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745922999; x=1746527799;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jnnK4v0ZhrRY7uhbTKq6B6d9n3dw0rEk4NULWBTSKCY=;
        b=oOimOaZ6KgfqkS0ooL9Dp4iLCdtUmz/6qthLiCMtcIvxmoHiJOWly+5TZq20Pn4msw
         GoRXmM7zvjwED3sF9Zp/Rjm+Mjdi9cwLOep/0dXtFuS4yDAmVhMDnv6HCuRtbSt77rLI
         HwRUhOuszjm8dZHNpKUkSRfN6dxw7kJSfK1LHmC2USoKClVZE116taUxiMbqo6nB7Jzh
         QJ8JpOIbPEaaz8tbSNvkoiNrymwTO3JP9sxaroc8GTQbRidkEsXvmSP0a4Tc2LOQ9x6F
         +S4voLZqxEdgscxAXwRxoiL6sF+R0iivk2pOld4MIaJTjYSRK5jxf6fYC6f21OI2Mm1g
         80vA==
X-Forwarded-Encrypted: i=1; AJvYcCVu8Env5Frg6Xy3OHz2XV8FTllJjNsAF3hn4wed3CfyJvkZl26jQkZvlA9MdtpFiChbn84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9U1n6pUhjKZUVe9VdrF1uxuRtxFWoBt50l/gpNKAiKoWqQb5r
	AE/TdDM4YmAQFe95o8xPK6EJxZnYBUdDLoUrpg03Km6xTbtfpH/7UEAclkklCqYa9qyHNl3eS4c
	LBjpCDtQ/uKqcH8z/Zd9MKHK84hDj2z5qvyETXrWf9Pjyf7GL0w==
X-Gm-Gg: ASbGncvPTJ+lpbkPAeP/HJhBUsAoH2DFu51B3HVEMV7GA0k9P0+2r9Ysm6qh8fS4qAQ
	80g6RlfMPlKNzqyHKHqFdg1hK3i/LiNtOw15CHc8680E1h5ZP4jkNKt6aYlEd5tmQ7euSTJOWT9
	2OzZAZeH6ga8CClmPx+zZTxbp3Kkumt8LZALM5+YKOaEtkePoEtWc2GJ2Y1Mt3PeFdhGLX3rkcF
	If5rjJwdlr9S8+Vk43ZzhtEj+8w9HzpAnrXt2gPNHnx/L+0p87DRwFeHPt+IefPyJuca/iul1gD
	A4hlMqQbK15TMmscK5cvlvn8DCuLxD/EbiCqI74xDrtphYNmjwcLTh3lfi8=
X-Received: by 2002:a17:906:6a23:b0:ac6:bca0:eb70 with SMTP id a640c23a62f3a-ace84b55d83mr1257180566b.56.1745922998591;
        Tue, 29 Apr 2025 03:36:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYLnutURY9GSI8aMToCMoJnbXPAocgDQCYLVDcJVZnEaipHJS5GvmH6c6UiyLPyLaX/DhufA==
X-Received: by 2002:a17:906:6a23:b0:ac6:bca0:eb70 with SMTP id a640c23a62f3a-ace84b55d83mr1257178266b.56.1745922998154;
        Tue, 29 Apr 2025 03:36:38 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2726:1910:4ca0:1e29:d7a3:b897? ([2a0d:3344:2726:1910:4ca0:1e29:d7a3:b897])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6ed701eesm770725066b.140.2025.04.29.03.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 03:36:37 -0700 (PDT)
Message-ID: <4124e050-5614-424c-969c-9521ff02bee3@redhat.com>
Date: Tue, 29 Apr 2025 12:36:35 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 04/15] tcp: accecn: AccECN negotiation
To: chia-yu.chang@nokia-bell-labs.com, horms@kernel.org, dsahern@kernel.org,
 kuniyu@amazon.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 dave.taht@gmail.com, jhs@mojatatu.com, kuba@kernel.org,
 stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Olivier Tilmans <olivier.tilmans@nokia.com>
References: <20250422153602.54787-1-chia-yu.chang@nokia-bell-labs.com>
 <20250422153602.54787-5-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250422153602.54787-5-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/25 5:35 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index e36018203bd0..af38fff24aa4 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -156,6 +156,10 @@ struct tcp_request_sock {
>  #if IS_ENABLED(CONFIG_MPTCP)
>  	bool				drop_req;
>  #endif
> +	u8				accecn_ok  : 1,
> +					syn_ect_snt: 2,
> +					syn_ect_rcv: 2;
> +	u8				accecn_fail_mode:4;

AFAICS this will create a 3 bytes hole. That could be bad if it will
also increase the number of cachelines used by struct tcp_request_sock.
Please include the pahole info and struct size in the commit message.

If there is no size problem I guess you are better off using a 'bool'
for 'accecn_ok'

>  	u32				txhash;
>  	u32				rcv_isn;
>  	u32				snt_isn;
> @@ -376,7 +380,10 @@ struct tcp_sock {
>  	u8	compressed_ack;
>  	u8	dup_ack_counter:2,
>  		tlp_retrans:1,	/* TLP is a retransmission */
> -		unused:5;
> +		syn_ect_snt:2,	/* AccECN ECT memory, only */
> +		syn_ect_rcv:2,	/* ... needed durign 3WHS + first seqno */
> +		wait_third_ack:1; /* Wait 3rd ACK in simultaneous open */

A good bunch of conditionals will be added to the fast path checking
this flag. Is simult open really a thing for AccECN? Can we simple
disable AccECN in such scenarios and simplify the code a bit? In my
limited experience only syzkaller reliably use it.

> +	u8	accecn_fail_mode:4;     /* AccECN failure handling */

This is outside the fastpath area, so possibly the struct size increase
is less critical, but AFAICS this will create a 6bits hole (as the next
u8 has only 6bit used). I think it's better to read the 'unused' field
to mark such hole.

>  	u8	thin_lto    : 1,/* Use linear timeouts for thin streams */
>  		fastopen_connect:1, /* FASTOPEN_CONNECT sockopt */
>  		fastopen_no_cookie:1, /* Allow send/recv SYN+data without a cookie */

[...]
> +/* See Table 2 of the AccECN draft */
> +static void tcp_ecn_rcv_synack(struct sock *sk, const struct tcphdr *th,
> +			       u8 ip_dsfield)
> +{
> +	struct tcp_sock *tp = tcp_sk(sk);
> +	u8 ace = tcp_accecn_ace(th);
> +
> +	switch (ace) {
> +	case 0x0:
> +	case 0x7:
>  		tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
> +		break;
> +	case 0x1:
> +	case 0x5:

Possibly some human readable defines could help instead of magic numbers
here.

[...]
> @@ -6171,16 +6252,27 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
>  	 * RFC 5961 4.2 : Send a challenge ack
>  	 */
>  	if (th->syn) {
> +		if (tcp_ecn_mode_accecn(tp))
> +			send_accecn_reflector = true;
>  		if (sk->sk_state == TCP_SYN_RECV && sk->sk_socket && th->ack &&
>  		    TCP_SKB_CB(skb)->seq + 1 == TCP_SKB_CB(skb)->end_seq &&
>  		    TCP_SKB_CB(skb)->seq + 1 == tp->rcv_nxt &&
> -		    TCP_SKB_CB(skb)->ack_seq == tp->snd_nxt)
> +		    TCP_SKB_CB(skb)->ack_seq == tp->snd_nxt) {
> +			if (!tcp_ecn_disabled(tp)) {
> +				u8 ect = tp->syn_ect_rcv;
> +
> +				tp->wait_third_ack = true;
> +				__tcp_send_ack(sk, tp->rcv_nxt,
> +					       !send_accecn_reflector ? 0 :
> +					       tcp_accecn_reflector_flags(ect));

The same expression is used above possibly you can create a new helper
for this statement.

...

This patch is quite huge. Any hope to break id down to a more palatable
size? i.e. moving the 3rd ack/self connect handling to a separate patch
(if that thing is really needed).

/P


