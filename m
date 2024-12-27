Return-Path: <bpf+bounces-47656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C42679FD521
	for <lists+bpf@lfdr.de>; Fri, 27 Dec 2024 15:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ADD21885180
	for <lists+bpf@lfdr.de>; Fri, 27 Dec 2024 14:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DE914C59C;
	Fri, 27 Dec 2024 14:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="cLGptPC6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE791E489
	for <bpf@vger.kernel.org>; Fri, 27 Dec 2024 14:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735308606; cv=none; b=tzVfH04L7OdKFId8u3he9CWnFnzh6m3wNO/NTD5OM7UeA/Mw11P4DA5KtUh4a4Er4qqyfdW7dRChsMPbfQZKYEcodeZc7ZrOjQkuWsQCtpKOVUYqm9WBVQUvWBNuGncH/EPHLwXxTnij1i6zhFH4EtoaadL+qVGkgWQ1VAunP6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735308606; c=relaxed/simple;
	bh=sdHv2Y3+pTRiGoZoBNa0A8nM0Q+mscRylcBhqYSQATQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nVJ50yP0qvElGi/cCpDQjZRjoxt8evFQ+8mSZjMEps0gKtTcMeT5oDqNKCU3TFkdcft//rTI38h8FMMcDxogNiBrwLvsUIBcMYycPRKlhnjWZUlMYl1BpFM3M8yU689S2GArllZGz4otiuHPVv1kYuRbKJQ5rtQ3K/btTKtTufw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=cLGptPC6; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d3f65844deso11494913a12.0
        for <bpf@vger.kernel.org>; Fri, 27 Dec 2024 06:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1735308603; x=1735913403; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aqVpPncJPNWoq4MhqUOLRJfGTNULjrM320NMYVIJ38E=;
        b=cLGptPC6H4RNq2yexdHh3toI/ABXt5bRSV9OpOreL4ehDnbabf4w5AKmxFtl3pfRRo
         J9Mov+XpT69EYVTX8p5V55GKf9LbAbuZ6ecKieAJtRhM4FUbgn9QQEkdmjOszOwFJXjO
         VBXI2ihISw68AkS5RLo4v4YMibDM2mfNgezgQAFZMwmAF/w3ztsZpf0BvPjdU4iwbzJo
         ziyKnzG2vaDlrQN7UzZcnuEKCMB9fNMdMHz6nK/zu4i0vLkY50xvOARrOzb9vg+qbfgL
         MZp1h5kG9QUow8ZVlVQEdMT6Tm04jy4QynZeKFc7TPJe/mezAAxhclaZKdRj1QFvhDBy
         x21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735308603; x=1735913403;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aqVpPncJPNWoq4MhqUOLRJfGTNULjrM320NMYVIJ38E=;
        b=dONhCOKL8tB6P9lCLMMOUIXmTNnotMXS48RBuStCBGPAkgMmyUIGcoCh6mkGnNk+bT
         fYIrtcxUQZQ8dKXOBPHnbsdSasJyVuINP8jEVNSGp9ny+seGmUHiOwIBAjbOL2/FhtPx
         32/PtvaW5phqA8iYX6IbgfNHyvyQY64xCuK8Rd73SiXjdX/mxzVQEj1QQEqO3htK4Tx3
         mMefKChFXileRt1tb7MoswDAsV8qLvbBp8oaq8/Qwj3YRCHt+BG5ZjptJBecraXu7d8p
         7P3fhY8y5fKoUk0IIFgvUpJDocltehA75VY6cb9jGR1/JyK47x8KUY+XQ1lDspx8RfAh
         6muA==
X-Forwarded-Encrypted: i=1; AJvYcCUVsyVaNS/SqsdSS5zOYefGv3whKKgHW1FvFIdNeV7e+Gz3GbKKqLbz0lFQ/XW33PsT8EI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyoIuUO5/zTqxsRT+izH4SiSxBU6hOgDYU5cZbpJuseSSs9g0y
	FCf8Xcu6vionMYzwX+St6juA9X7hVdKfvP5gpxfX4HfdSZszdJR2aZPrkSkjdNc=
X-Gm-Gg: ASbGncvxuWjcFH4hPVp43Y1l8G5sQsmHzYT1vH7euwDAIkLB39dmC/Ph0v9bB8X82Ix
	XNDcm4O3dMzXjdQvY01qlIWB1R8QRuCZNsqWEPWGlPzruSB9F2R1rihX/hcgA2IeLdfdENEkooc
	XTKb46epURYI8d4uUAFYtJBED5XmiG66OHTeRfRNa7A1UXdTPRWUEfLDxkyhp804MHpjXuYA+KP
	Yjv/xN480TYu5doe5oA+L74wMMAe3RvSB2TfzSubwVLcNpOJA==
X-Google-Smtp-Source: AGHT+IEW661Rmtzi2QPuTuqK8/Lkyj//WlxZnVAum0TdF0XCMwFuH2RP1GHU3krnKkhvvmXoOPxK2w==
X-Received: by 2002:a05:6402:1d50:b0:5d2:b712:fbcf with SMTP id 4fb4d7f45d1cf-5d81de23128mr21866224a12.21.1735308602635;
        Fri, 27 Dec 2024 06:10:02 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:507b:2387::38a:49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80679f112sm10818655a12.52.2024.12.27.06.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2024 06:10:00 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <mrpre@163.com>
Cc: John Fastabend <john.fastabend@gmail.com>,  bpf@vger.kernel.org,
  martin.lau@linux.dev,  ast@kernel.org,  edumazet@google.com,
  davem@davemloft.net,  dsahern@kernel.org,  kuba@kernel.org,
  pabeni@redhat.com,  linux-kernel@vger.kernel.org,  song@kernel.org,
  andrii@kernel.org,  mhal@rbox.co,  yonghong.song@linux.dev,
  daniel@iogearbox.net,  xiyou.wangcong@gmail.com,  horms@kernel.org
Subject: Re: [PATCH bpf v3 1/2] bpf: fix wrong copied_seq calculation
In-Reply-To: <lu7yzq2rsbu2jkffpm4pyinvggs6hrjyyi2h6udtgcq2thfs4k@3b2qsgjo4owm>
	(Jiayuan Chen's message of "Tue, 24 Dec 2024 15:16:34 +0800")
References: <20241218053408.437295-1-mrpre@163.com>
	<20241218053408.437295-2-mrpre@163.com>
	<87jzbxvw9y.fsf@cloudflare.com>
	<ojwjcubviyjxpucryc3ypi4b77h5f5g6ouv7ovaljah5harfyj@jue7hqit2t5n>
	<87h66ujex9.fsf@cloudflare.com> <87msgmuhvt.fsf@cloudflare.com>
	<lu7yzq2rsbu2jkffpm4pyinvggs6hrjyyi2h6udtgcq2thfs4k@3b2qsgjo4owm>
Date: Fri, 27 Dec 2024 15:09:57 +0100
Message-ID: <87v7v5z07e.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Dec 24, 2024 at 03:16 PM +08, Jiayuan Chen wrote:
> On Mon, Dec 23, 2024 at 11:57:58PM +0800, Jakub Sitnicki wrote:
>> On Mon, Dec 23, 2024 at 09:57 PM +01, Jakub Sitnicki wrote:
>> > On Thu, Dec 19, 2024 at 05:30 PM +08, Jiayuan Chen wrote:
>> >> Currently, not all modules using strparser have issues with
>> >> copied_seq miscalculation. The issue exists mainly with
>> >> bpf::sockmap + strparser because bpf::sockmap implements a
>> >> proprietary read interface for user-land: tcp_bpf_recvmsg_parser().
>> >>
>> >> Both this and strp_recv->tcp_read_sock update copied_seq, leading
>> >> to errors.
>> >>
>> >> This is why I rewrote the tcp_read_sock() interface specifically for
>> >> bpf::sockmap.
>> >
>> > All right. Looks like reusing read_skb is not going to pan out.
>> >
>> > But I think we should not give up just yet. It's easy to add new code.
>> >
>> > We can try to break up and parametrize tcp_read_sock - if other
>> > maintainers are not against it. Does something like this work for you?
>> >
>> >   https://github.com/jsitnicki/linux/commits/review/stp-copied_seq/idea-2/
>> 
>> Actually it reads better if we just add early bailout to tcp_read_sock:
>> 
>>   https://github.com/jsitnicki/linux/commits/review/stp-copied_seq/idea-2.1/
>> 
>> ---8<---
>> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
>> index 6a07d98017f7..6564ea3b6cd4 100644
>> --- a/net/ipv4/tcp.c
>> +++ b/net/ipv4/tcp.c
>> @@ -1565,12 +1565,13 @@ EXPORT_SYMBOL(tcp_recv_skb);
>>   *	  or for 'peeking' the socket using this routine
>>   *	  (although both would be easy to implement).
>>   */
>> -int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
>> -		  sk_read_actor_t recv_actor)
>> +static inline int __tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
>> +				  sk_read_actor_t recv_actor, bool noack,
>> +				  u32 *copied_seq)
>>  {
>>  	struct sk_buff *skb;
>>  	struct tcp_sock *tp = tcp_sk(sk);
>> -	u32 seq = tp->copied_seq;
>> +	u32 seq = *copied_seq;
>>  	u32 offset;
>>  	int copied = 0;
>>  
>> @@ -1624,9 +1625,12 @@ int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
>>  		tcp_eat_recv_skb(sk, skb);
>>  		if (!desc->count)
>>  			break;
>> -		WRITE_ONCE(tp->copied_seq, seq);
>> +		WRITE_ONCE(*copied_seq, seq);
>>  	}
>> -	WRITE_ONCE(tp->copied_seq, seq);
>> +	WRITE_ONCE(*copied_seq, seq);
>> +
>> +	if (noack)
>> +		goto out;
>>  
>>  	tcp_rcv_space_adjust(sk);
>>  
>> @@ -1635,10 +1639,25 @@ int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
>>  		tcp_recv_skb(sk, seq, &offset);
>>  		tcp_cleanup_rbuf(sk, copied);
>>  	}
>> +out:
>>  	return copied;
>>  }
>> +
>> +int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
>> +		  sk_read_actor_t recv_actor)
>> +{
>> +	return __tcp_read_sock(sk, desc, recv_actor, false,
>> +			       &tcp_sk(sk)->copied_seq);
>> +}
>>  EXPORT_SYMBOL(tcp_read_sock);
>>  
>> +int tcp_read_sock_noack(struct sock *sk, read_descriptor_t *desc,
>> +			sk_read_actor_t recv_actor, u32 *copied_seq)
>> +{
>> +	return __tcp_read_sock(sk, desc, recv_actor, true, copied_seq);
>> +}
>> +EXPORT_SYMBOL(tcp_read_sock_noack);
>> +
>>  int tcp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
>>  {
>>  	struct sk_buff *skb;
>
> This modification definitely reduces code duplication and makes it more
> elegant compared to my previous idea. Also If we want to avoid modifying
> the strp code and not introduce new ops, perhaps we could revert to the
> simplest solution:
> '''
> void sk_psock_start_strp(struct sock *sk, struct sk_psock *psock)
> {
>     ...
>     sk->sk_data_ready = sk_psock_strp_data_ready;
>     /* Replacement */
>     psock->saved_read_sock = sk->sk_socket->ops->read_sock;
>     sk->sk_socket->ops->read_sock = tcp_read_sock_noack;
> }
> '''
> If acceptable, I can incorporate this approach in the next patch version.

SGTM

