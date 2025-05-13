Return-Path: <bpf+bounces-58119-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE88AB568C
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 15:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AB848633CB
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 13:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D8B2BCF5B;
	Tue, 13 May 2025 13:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aOpM7Izy"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2B128F527
	for <bpf@vger.kernel.org>; Tue, 13 May 2025 13:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747144522; cv=none; b=qKRNI2otD2i1InEJO1Su1l5z2LHWmSAX6l1HWX6MBFAQTkp6K39Z+XCAXykyVt3r39AQHyaWtZkMQQr5JWXl1u9uotk+ECzx7WtCmSRLBFSKT5WIJiZNyE0DcckHi8H0EfRE6DEdY/n79ilIm8gAyOYPdF4h/DIb/qHNteJJYhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747144522; c=relaxed/simple;
	bh=k8MO0qQYf2yjnXq8zGlgq6trmVTpsGIo34uVN9tvwMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a79mJ80FV3e5lQY759KFDBUzDFA/UREQVxWhaCexyv9SOK8x4bIL0Cj8ppfE5Fs8edO2q+kyo0Ftu9/Axlrq66ptS8tgqoGrhO2SR+9ScviqSwb8s/GC+O61ZatwqYgVWZJAc9GZqEm+COjV2SLLuZRxS59olBxTHsbOXu/lpcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aOpM7Izy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747144519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2mDXk/1z60Kt8lR+wZMc16OkBv5Hh1LoZwzwZnjv5+0=;
	b=aOpM7IzybmBrpA3d/D3cB0iUZylkn152A/3vBpyRooEEIXBSKv9yjx/660y9mjxkdQMD5n
	fTLduBMijHy0Y3RHA2ztJb2USndTfMZQJWTp7wYHTu6KHq46vlyO3PiZ7IO61WqmYqpCai
	DFs2iVYce0F1yfRhEEXcsaxIlkEB1x8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-bxvm901SO9CDQRg-A3uRzg-1; Tue, 13 May 2025 09:55:18 -0400
X-MC-Unique: bxvm901SO9CDQRg-A3uRzg-1
X-Mimecast-MFC-AGG-ID: bxvm901SO9CDQRg-A3uRzg_1747144517
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a1f9ddf04bso2427574f8f.3
        for <bpf@vger.kernel.org>; Tue, 13 May 2025 06:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747144517; x=1747749317;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2mDXk/1z60Kt8lR+wZMc16OkBv5Hh1LoZwzwZnjv5+0=;
        b=KpYB/88qPbKKazWE1ReLk7+3c/zSWVrwzKYRtqszM5DHDx2+S16s5JAjT5c8JU+q/b
         ePwxDNR8sZjODNjBwpLbosO2s1BAPaN95aau9k+evSPmq1Rt/u8/zc40V4vpJqE5Phi9
         qjDgRqV9OETOdiJoUqTgjStqJocnnd8FKr36Pc4OpjwHmf9vX6hTJQn7GfZRI6b/N66J
         gWvRQdXyxkmqNb6+p0wRLXsrNIjKhqY1ILtorUt7S6iLZcC1oJ3ZUmUJaBL0scnVz8HP
         wpt0mRGkbB93HGsPaMKK3AIuukidT+gZenATnUkY/fsLjWQVAmVvQ4nA2RdIsZQi2ruG
         TdNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWe/GQsXxAUJUwMD6vMhqdQNne9ZJ6YV5UQs481ejDGMp1Zpk0oT1A2qBqC7dQDOHvW3IM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIjJ6DI8DOl8HPMgGekSa3z7/yu3MQ0j5nFl5LnG8FjqLm/v5t
	DwdobMk6cVk60GtWLScANhZCinyIZmnky7GQL+6D7I3S4FV4cBJ4yC0DROX2ImTdd5vEfto/+Qs
	SttPlKcwAedFcif9dv7/in+h5CQoVtvqDv0qB3+L14dqmAB2Trw==
X-Gm-Gg: ASbGncutlK8h7oAW3ZV3gPh7Gn1OKoi9Ri2htmsYCBLCsoXCHLA8IomJgvSWhFXy9mU
	P45JKeFMIMADMB1oddRlk2VTBYUETjebzqVbK189VQ1NlEVHBpxjCE3ox117ls250QOKH+Wf0Vm
	7PK+/IQ8EgZ85SXKTWl+Bdtvf3S9H8WWYFL0QerufYcW8luMYXOeinl0TBOHJQhzW9g0w8nCuvu
	+6dOa3NjEJugu64f+2T/uSfNxNIxpY93FZZ1Ck1ilHmd2Ibzz6Ktz++uk+ljRHarhHhmg3CtiFC
	uu9WlqoqJgUO8Nz/378=
X-Received: by 2002:a5d:598e:0:b0:39c:2688:612b with SMTP id ffacd0b85a97d-3a1f64277femr15324307f8f.7.1747144517297;
        Tue, 13 May 2025 06:55:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/3P787hez5DUCbzjfJPJODBbn5DQDvgAda7uo/wL13u5mlBuNcHOROPQYLGn7Nvk65To4cg==
X-Received: by 2002:a5d:598e:0:b0:39c:2688:612b with SMTP id ffacd0b85a97d-3a1f64277femr15324275f8f.7.1747144516860;
        Tue, 13 May 2025 06:55:16 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cc59:6510::f39? ([2a0d:3341:cc59:6510::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f57dde0esm16586527f8f.18.2025.05.13.06.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 06:55:16 -0700 (PDT)
Message-ID: <39e06f51-621a-4d17-a4dd-17287e260e18@redhat.com>
Date: Tue, 13 May 2025 15:55:14 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 04/15] tcp: AccECN core
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
References: <20250509211820.36880-1-chia-yu.chang@nokia-bell-labs.com>
 <20250509211820.36880-5-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250509211820.36880-5-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/25 11:18 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> @@ -5098,7 +5100,8 @@ static void __init tcp_struct_check(void)
>  	/* 32bit arches with 8byte alignment on u64 fields might need padding
>  	 * before tcp_clock_cache.
>  	 */
> -	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 92 + 4);
> +	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 96 + 4);

This looks inconsistent with the pahole output in the commit message
(the groups looks 95 bytes wide, comprising the holes)

[...]
> @@ -382,11 +393,17 @@ static void tcp_ecn_send(struct sock *sk, struct sk_buff *skb,
>  {
>  	struct tcp_sock *tp = tcp_sk(sk);
>  
> -	if (tcp_ecn_mode_rfc3168(tp)) {
> +	if (!tcp_ecn_mode_any(tp))
> +		return;
> +
> +	INET_ECN_xmit(sk);
> +	if (tcp_ecn_mode_accecn(tp)) {
> +		tcp_accecn_set_ace(th, tp);
> +		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
> +	} else {
>  		/* Not-retransmitted data segment: set ECT and inject CWR. */
>  		if (skb->len != tcp_header_len &&
>  		    !before(TCP_SKB_CB(skb)->seq, tp->snd_nxt)) {
> -			INET_ECN_xmit(sk);

The above chunk apparently changes the current behaviour for
!tcp_ecn_mode_accecn(), unconditionally setting ECN, while before ECN
was set only for non retrans segments.

/P


