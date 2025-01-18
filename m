Return-Path: <bpf+bounces-49256-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2094EA15D8B
	for <lists+bpf@lfdr.de>; Sat, 18 Jan 2025 16:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90E9B1888851
	for <lists+bpf@lfdr.de>; Sat, 18 Jan 2025 15:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447AA199FA2;
	Sat, 18 Jan 2025 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="DuSS+wiE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A5D172BB9
	for <bpf@vger.kernel.org>; Sat, 18 Jan 2025 15:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737212620; cv=none; b=oNgD8n8lJeLnkZ/f+YWswDkv5Qkq6rGSI/q8RW9yEWJz3WMNcqIRRtrFqiPpJnEzKF75k9bjWuKsZZMs44l6GeV9ATwwfJS7oew7JdE1WSJ8F6kdWc9y5qu7TtNrpEBzVG/2N89rMQGSh/ft7YMgmpSSXz7V8luYBaQS4G9xS0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737212620; c=relaxed/simple;
	bh=NablIjmRy2nMx39DICWLlVTQ1be/IJAFT6T9D7/baDk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xui4WiZSUW12MoeXLDAq8MSQ6DrVygYz2dghGW4SDao3JbC6cVvGBXW3e8Cb8WjT+S4oznLxtLnsSMcyyvKnsnqowsGxsnMXe7/20gDHQDQHr7P+uKLBrSEkaBTzNtrNj9AYfR4K8iC0EGzYEfIbP+vqkdsA8So1kosYbb5nZ7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=DuSS+wiE; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa68b513abcso566374666b.0
        for <bpf@vger.kernel.org>; Sat, 18 Jan 2025 07:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1737212616; x=1737817416; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BsU0V10dN1yqoMT6qC2L8DSBzvmEhUqKxrypw2scHJ4=;
        b=DuSS+wiElEwB1O4ZL0hpejwnJ5OJfYMvapKTUjF5pkEWbcyKGsWaRZpjqHczNQ7WZj
         aAJD/d1D/rAw34tmjbnXzeZEqHkHWXRhQirJFQ7TeE4/Y2Le8PBM9E6HxerF6XETU8ko
         zT2UgIor+hHlG7m4FcnRTzEf0XUOeQ3IUnwMN7HhGNkmFGJnLn/lEbT7Oz8dqV/C9gJO
         +QwUU8UnKzrYIPkwXLLP4RkODM5dKuf/TmhGG1aeC4VPG2da+Igxp+rMUzBEPdMbsHnx
         UGs2mjI5gkSo5I8sv4001QqzMGHPeVFHvf6fPz/k3lr+ywtljGZq4fapmBSLLvtra1yc
         x0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737212616; x=1737817416;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BsU0V10dN1yqoMT6qC2L8DSBzvmEhUqKxrypw2scHJ4=;
        b=uT0eRvnnj/Uye0ZWxU1j/s+31iUmEF7NVACisIFyFk7yrUXwmthfTe4ngN+Um+REas
         czGEo3tsv82q8IMuylnccp5IJE/Ag1hf2A3t8kGlZj8dyp7l56Y7DPZ3paWR8spJEImG
         Wrn4lFV0TfzaVVRSUkKm6x0p9O+JYTUkeXA8X/4tgQbOx9CbN55hXaNrCQqifOGcA/SS
         D0bZXtZA1AaKLydVu78LMSgoFaXkm4WE2LpjNvEl6ARNAl+GkRkqKPnGP6PolZNccDI0
         PXczx3TmrsD+LJEWvH6uYIq59XKoYizTaievaHJP1v4Hry4wg6YrS/B732/FBp55BCXZ
         4wqg==
X-Gm-Message-State: AOJu0YwG6D+E8MUC0MLxESVQafmBIXUQUt/c5Hkx5BkC0QfqIsKGIV6v
	2qlQqBgVXbO+8ZZ9SGitaQZg8Vzudgqp6AOyOIiB5IA4qjlehWBZM2dCW/WWH6E=
X-Gm-Gg: ASbGncviQGYyNNkjdeTzNLMiVPAO3zKf3usqNJuNHUYCCs4Cgo9l/EjmfEAilYJ+OqR
	b6ed9zTqPHGHz50tv5DHPZ+gJa3Z0hoQ0bjfHUXzce0jZaP0novM/FROIc/QrfJ1f8aIwpwl3Mi
	MsTLtJzyyIGNv/ATfnLYh24JPORwj9zmvq37cQBb3it4LXiAg8qijHJ6YdkW5l761ISjnf7w3ng
	YXqrjyDj65aIbMIJDBL+/F7Feu/AKUdaz6Vd4hyXHLzPYKlDioT/rTnVLyPVw==
X-Google-Smtp-Source: AGHT+IFly84G+OXXo/u1XMLfKGjBq9YlBfFskeFDqv4t2HPmXeMR34kxPqt/OhU/z8Yer8BWZqR6Fg==
X-Received: by 2002:a17:907:805:b0:aa6:7c8e:8085 with SMTP id a640c23a62f3a-ab38b1100f2mr638880466b.15.1737212615807;
        Sat, 18 Jan 2025 07:03:35 -0800 (PST)
Received: from cloudflare.com ([2a09:bac1:5ba0:d60::38a:14])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384c613d9sm348102566b.31.2025.01.18.07.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2025 07:03:34 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <mrpre@163.com>
Cc: bpf@vger.kernel.org,  john.fastabend@gmail.com,  netdev@vger.kernel.org,
  martin.lau@linux.dev,  ast@kernel.org,  edumazet@google.com,
  davem@davemloft.net,  dsahern@kernel.org,  kuba@kernel.org,
  pabeni@redhat.com,  linux-kernel@vger.kernel.org,  song@kernel.org,
  andrii@kernel.org,  mhal@rbox.co,  yonghong.song@linux.dev,
  daniel@iogearbox.net,  xiyou.wangcong@gmail.com,  horms@kernel.org,
  corbet@lwn.net,  eddyz87@gmail.com,  cong.wang@bytedance.com,
  shuah@kernel.org,  mykolal@fb.com,  jolsa@kernel.org,  haoluo@google.com,
  sdf@fomichev.me,  kpsingh@kernel.org,  linux-doc@vger.kernel.org
Subject: Re: [PATCH bpf v7 3/5] bpf: disable non stream socket for strparser
In-Reply-To: <20250116140531.108636-4-mrpre@163.com> (Jiayuan Chen's message
	of "Thu, 16 Jan 2025 22:05:29 +0800")
References: <20250116140531.108636-1-mrpre@163.com>
	<20250116140531.108636-4-mrpre@163.com>
Date: Sat, 18 Jan 2025 16:03:33 +0100
Message-ID: <87a5bodv0a.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jan 16, 2025 at 10:05 PM +08, Jiayuan Chen wrote:
> Currently, only TCP supports strparser, but sockmap doesn't intercept
> non-TCP to attach strparser. For example, with UDP, although the
> read/write handlers are replaced, strparser is not executed due to the
> lack of read_sock operation.
>
> Furthermore, in udp_bpf_recvmsg(), it checks whether psock has data, and
> if not, it falls back to the native UDP read interface, making
> UDP + strparser appear to read correctly. According to it's commit
> history, the behavior is unexpected.
>
> Moreover, since UDP lacks the concept of streams, we intercept it
> directly. Later, we will try to support Unix streams and add more
> check.
>
> Signed-off-by: Jiayuan Chen <mrpre@163.com>
> ---

Needs a Fixes: tag.

>  net/core/sock_map.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index f1b9b3958792..c6ee2d1d9cf2 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -214,6 +214,14 @@ static struct sk_psock *sock_map_psock_get_checked(struct sock *sk)
>  	return psock;
>  }
>  
> +static bool sock_map_sk_strp_allowed(const struct sock *sk)
> +{
> +	/* todo: support unix stream socket */
> +	if (sk_is_tcp(sk))
> +		return true;
> +	return false;
> +}
> +

We don't need this yet, so please don't add it. Especially since this is
fix. It should be kept down to a minimum. Do the sk_is_tcp() check
directly from sock_map_link().

>  static int sock_map_link(struct bpf_map *map, struct sock *sk)
>  {
>  	struct sk_psock_progs *progs = sock_map_progs(map);
> @@ -303,7 +311,10 @@ static int sock_map_link(struct bpf_map *map, struct sock *sk)
>  
>  	write_lock_bh(&sk->sk_callback_lock);
>  	if (stream_parser && stream_verdict && !psock->saved_data_ready) {
> -		ret = sk_psock_init_strp(sk, psock);
> +		if (sock_map_sk_strp_allowed(sk))
> +			ret = sk_psock_init_strp(sk, psock);
> +		else
> +			ret = -EOPNOTSUPP;
>  		if (ret) {
>  			write_unlock_bh(&sk->sk_callback_lock);
>  			sk_psock_put(sk, psock);

