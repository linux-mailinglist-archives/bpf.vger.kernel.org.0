Return-Path: <bpf+bounces-71498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E99C2BF5C57
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 12:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C268818C8530
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 10:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CAC32C949;
	Tue, 21 Oct 2025 10:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="fYONXq4X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28D632B999
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 10:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761042281; cv=none; b=ETTMd1nSmAhAuZqPcPH5T3B3MRphk+STuGF5P1niYgjSEMgDJCY6UxAWA4uctMsHEif7+2mdVvpOi10Ao/YBHPAf5BNmLZeXL6g+Aq2RWGvbKzTiqsXIGSZdYFo92WhbYsWM4yemtPmNluXzRDjR7lTk0MSWPvq0+BumC4Y1AR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761042281; c=relaxed/simple;
	bh=B3s7ZSl86JD4ZLrcy7v2rLerojZVW4rI6JyJqxX2Opw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WQsAlF56BtgVkeDQoKb5w+L0cPNWC111by38H/HaSpu4hPifqxrCTtuuY0SLxQQLyophSJktlu0R7ZUmwOheAuicx/nP2o5nVJbOxpDyVnOe+t5Zt8dP6AizlJSL2PLh8SNWuoi1Y/AhpR7KWOJdewRZq+6xIB0tyAG2do5AZTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=fYONXq4X; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-63c3c7d3d53so6197413a12.2
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 03:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1761042276; x=1761647076; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JcFCzEhSLG+mhX1K/VGxSMuzwAex5vT0vkcdh5aIy+o=;
        b=fYONXq4XOeRd1D/VeQ7wsDVll2QuE+S7FML5Na0kk+LYWI/nIdZdFTu9k0PZVRjE4s
         92e4nR9nrGjLdbusoffg0QSwppIFAKW6ezo3ZMb0WKlrr33Fe84KNw4EM7fSOFhkGwqa
         kvkeZrIOQg5rKdhy5zyYjK5LZhj34CTJ4Y32dHqYndbWdbLZwFZNW+8d9mrTTXwac+wc
         kp7AFDiW+PwU0LilUiucbxX4GoGNyvvHWBovqNb1UFzDgZiWRFRnjuZHOupIwFhVlK4Z
         4DjzM9bLAOkez+aunzkwB01uEGaJBTyxl86/mMVhLaBjCPdHph4DCDigvfp9yEHn82dV
         /kmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761042276; x=1761647076;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JcFCzEhSLG+mhX1K/VGxSMuzwAex5vT0vkcdh5aIy+o=;
        b=k2IG4Ih2eSzAhabZnjQ4lYUmPs4qbdsPTX5l+rE5HdRAcDLiFQNHIwZ/5ZVyQexyxX
         n/kYgVmc2yqSugRMc3ghvvJVqyZfz9cIcxjBGzA0gwVf096T7ZvoUWFDdFtkO9AnUq5U
         5IxLGM9zX6Hx4h/bg/BRip+0Z0um+Mm2XsCoIzdTNA9Pw5EA70ni94XrIogRSv3IhS7K
         2gaQNZHEQWfXCKZkqZZ9dSBhZRH1tWrAnPdX53f9LENvmFP3uA5AtuHoUl4K5GrhG+dH
         sczwndQktkUkou+16yXiNlAaHfn+ATYEMHW0D41wAst1jiwX5j4yQwg6abqaf8Xzm0Ao
         OAbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFyplXPo7zpXktulQZaV7YlFFzC62dvsaBm9wG4AxwXnDAPSCgzecFv0486Lv4wOOOuUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YykiQrRalmsZGwP8kKZnW4uHJ41S2fSK4+tl34+RUb3+2aqBgU2
	wGJKuKft9+JPETzHzbsq2iOpUlf+1FjDd6Qu9oGXkJFdcbe2Er7TnsWQ8adcKNpHpOg=
X-Gm-Gg: ASbGncvM5NlKZuiXmB6z+zxR49VQyEAnCYpFQKklJNw8AfJdJz0kCvK1bWP8223CMUa
	gxWz5tF163M/TnBYRvt63mtVEuiOCOiKCt2f4Uha7YmYuMJFV0OK1miJJ8lhTg0yfWaTh4J+OwW
	B3yBqx6+wCsfG/I2f0nN4XcSIFAHlvfiIHjakFcsP3uboOVgl7gbz5ugDAsLolpruJp486ohDZb
	+GGxWKVwPf0XnYcdt2cOOiFU4/ZRk1iofMdaCNFFNSCSqjvT/2EeN8jFQ/PqHJKy745SCaIsy9Q
	1SZmJ01Ns3EHeoz9+ub/ecA4KUsBC498sIpQn4cixcZCvztD/10HdUmWUJAC0eB6LJPMmrnvnPu
	1YZ4pNI/22SyHphSjB2sSYxKTrYZjEtmH94t/6NkED1yewk0Yr0x5z2OI6mQWtJLV5qqrBPfsrj
	ft7ig=
X-Google-Smtp-Source: AGHT+IHkXRt1bvA2nq78V9v3smCUF/mdE6nd/jsrFec9VaW89MGSq10bqEG5Bj4znCDYslvVrucVQw==
X-Received: by 2002:a05:6402:254b:b0:634:9121:7a2d with SMTP id 4fb4d7f45d1cf-63c1f6e5309mr17096839a12.26.1761042276183;
        Tue, 21 Oct 2025 03:24:36 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:d0])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c4945efebsm8971783a12.32.2025.10.21.03.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 03:24:35 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: mptcp@lists.linux.dev,  netdev@vger.kernel.org,  bpf@vger.kernel.org,
  John Fastabend <john.fastabend@gmail.com>,  Eric Dumazet
 <edumazet@google.com>,  Kuniyuki Iwashima <kuniyu@google.com>,  Paolo
 Abeni <pabeni@redhat.com>,  Willem de Bruijn <willemb@google.com>,  "David
 S. Miller" <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>,
  Simon Horman <horms@kernel.org>,  Matthieu Baerts <matttbe@kernel.org>,
  Mat Martineau <martineau@kernel.org>,  Geliang Tang <geliang@kernel.org>,
  Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Martin
 KaFai Lau <martin.lau@linux.dev>,  Eduard Zingerman <eddyz87@gmail.com>,
  Song Liu <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao
 Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  Florian Westphal <fw@strlen.de>,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v2 1/3] net,mptcp: fix incorrect IPv4/IPv6 fallback
 detection with BPF Sockmap
In-Reply-To: <20251020060503.325369-2-jiayuan.chen@linux.dev> (Jiayuan Chen's
	message of "Mon, 20 Oct 2025 14:04:46 +0800")
References: <20251020060503.325369-1-jiayuan.chen@linux.dev>
	<20251020060503.325369-2-jiayuan.chen@linux.dev>
Date: Tue, 21 Oct 2025 12:24:34 +0200
Message-ID: <87h5vswo0t.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Oct 20, 2025 at 02:04 PM +08, Jiayuan Chen wrote:
> When the server has MPTCP enabled but receives a non-MP-capable request
> from a client, it calls mptcp_fallback_tcp_ops().
>
> Since non-MPTCP connections are allowed to use sockmap, which replaces
> sk->sk_prot, using sk->sk_prot to determine the IP version in
> mptcp_fallback_tcp_ops() becomes unreliable. This can lead to assigning
> incorrect ops to sk->sk_socket->ops.
>
> Additionally, when BPF Sockmap modifies the protocol handlers, the
> original WARN_ON_ONCE(sk->sk_prot != &tcp_prot) check would falsely
> trigger warnings.
>
> Fix this by using the more stable sk_family to distinguish between IPv4
> and IPv6 connections, ensuring correct fallback protocol operations are
> selected even when BPF Sockmap has modified the socket protocol handlers.
>
> Fixes: 0b4f33def7bb ("mptcp: fix tcp fallback crash")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  net/mptcp/protocol.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 0292162a14ee..c2d1513615ae 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -61,11 +61,14 @@ static u64 mptcp_wnd_end(const struct mptcp_sock *msk)
>  
>  static const struct proto_ops *mptcp_fallback_tcp_ops(const struct sock *sk)
>  {
> +	/* When BPF Sockmap is used, it replaces sk->sk_prot.
> +	 * Using sk_family is a reliable way to determine the IP version.
> +	 */
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> -	if (sk->sk_prot == &tcpv6_prot)
> +	if (sk->sk_family == AF_INET6)
>  		return &inet6_stream_ops;
>  #endif
> -	WARN_ON_ONCE(sk->sk_prot != &tcp_prot);
> +	WARN_ON_ONCE(sk->sk_family != AF_INET);
>  	return &inet_stream_ops;
>  }

Should probably be a READ_ONCE(sk->sk_family) based on what I see in
IPV6_ADDRFORM:

https://elixir.bootlin.com/linux/v6.18-rc1/source/net/ipv6/ipv6_sockglue.c#L607

Nit: It's BPF sockmap, cpumap, etc. We don't treat it as a proper noun.

Other than that:

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

