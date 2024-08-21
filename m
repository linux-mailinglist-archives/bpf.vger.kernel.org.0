Return-Path: <bpf+bounces-37693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C86729598A4
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 12:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC061F225AB
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 10:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90761AF4D0;
	Wed, 21 Aug 2024 09:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="EVEViz/g"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62651E8626
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 09:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724232202; cv=none; b=jjtvNNHOKxmNOv70VEsiW2OyMP4F2bKBL3KR6ecHdmN/RKIbNKGUOxUTv+dKQ3l2FRqnlgFJIgeW3S2fvXZMy5b7EfQbVTPg0ND5SDDtzHAcKC0o2D4UBop4fJUPdLJZgYj+6kixBMl7O3c21Omjix+td+51IZW/0YMjzuBY66w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724232202; c=relaxed/simple;
	bh=d0HaBTQXXRypBVAlllqPljWMAXRz7z1v+0XOXOylDrw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wel49W1TbF+bJDc4WOIjnaUcWsO9CcSSYjAQ569VHxm3oB8XfAbY5xLfGtdlELRDSC0Hn/5e6GnwxoBx+5ErQN+LWQIpjFpzCSw9Jw5GjNXjALi7yJ7vjQbMDdlt1CfNb8vXUv9+ldWd/iyPqYT0wH0FOR1k+0rTzDMtef3nevQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=EVEViz/g; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5befd2f35bfso3585410a12.2
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 02:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1724232199; x=1724836999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDS6EsIq/KBd/jIekHf5yf430h3uz3GCHdbbNrSHAc4=;
        b=EVEViz/gEI/ucTAXA9ArvX8O443jZ8hS3Rdu2pHJtEDhn115keYKSa8KMJCn36JWjE
         WEDBvWNAt9Y1pywt+H7q+qne+CgxM4qzF09NcXkPUKoL3MLxEmQkM8gCx6awOwjrAbHv
         FZwEQYX+6aW4nt2BonFyTrCau9G+a55l12vRmQQN7o71IfNRapYeoehyl29N2C2G/udC
         6o8N7fMcM0KLBVgNS6r4FD3USnqPSmdo66VArUFC7MvYSkAjGso6uFH0Qcu6OXg5KjxO
         Lu5kYm9q+ZOdJyPuvXXtbKJFnpP0FzpO2OTEsKrUsmVWU2Nld5GtfTrK+ex7DDnBuUv8
         ZCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724232199; x=1724836999;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eDS6EsIq/KBd/jIekHf5yf430h3uz3GCHdbbNrSHAc4=;
        b=KypawIm9OTqCfGg3m0VeYJa300VQjioK0kYE9qTRf2ONoBdcdmNKPCOhHI1/PJhR87
         d8Tp77COHoBJdwdA5moVlk0mH3GiQPs1YMqNJb5jw1P6dCRpE0rE1zMtr5JoDtld8mXr
         vMqV5CcVfk/Xu5TmQkO0z+7I9Etq+CQLslO+ihlCbnElcEaICsTxHvrdeS0FdxlTficn
         /+Hxd0OW+MVccfh4RPubgRwzJWnImhF+u8NqFjWahR1PNL/xMtpHqLMH9Cn5Or5BEpq/
         Fkm9UuWM81fXcL0xoIqiSHQ+vFM4tcNr7qZ8lk1gw6FVeJg9do25EN1ZtwmzRT+zzeQA
         OopA==
X-Gm-Message-State: AOJu0YykxfAr+G+ek7uZ8yHdIqZ1zQRD1LBsenc6fpAEhUa8ajTDVwUB
	kDMAHf5zsc75QwIeHLOedvhWRXi7xGWu4uxQzKMqjhtrrHV2DusGcp8Ofe/X38g=
X-Google-Smtp-Source: AGHT+IGyCf+2YZsiggyP5MLbhpGf9T+G4qgugt1YVFdwRCZpKPdsXzZ9ffwiQgFV6vDGInkriWW0ig==
X-Received: by 2002:a05:6402:254d:b0:5be:fa53:f81 with SMTP id 4fb4d7f45d1cf-5bf1f28a6damr1293389a12.37.1724232198883;
        Wed, 21 Aug 2024 02:23:18 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:4d])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbdfad42sm7903800a12.47.2024.08.21.02.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 02:23:18 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Philo Lu <lulie@linux.alibaba.com>
Cc: bpf <bpf@vger.kernel.org>,  netdev@vger.kernel.org,  ast@kernel.org,
  daniel@iogearbox.net,  andrii@kernel.org, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, kernel-team
 <kernel-team@cloudflare.com>
Subject: Re: Question: Move BPF_SK_LOOKUP ahead of connected UDP sk lookup?
In-Reply-To: <6e239bb7-b7f9-4a40-bd1d-a522d4b9529c@linux.alibaba.com> (Philo
	Lu's message of "Tue, 20 Aug 2024 20:31:00 +0800")
References: <6e239bb7-b7f9-4a40-bd1d-a522d4b9529c@linux.alibaba.com>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Wed, 21 Aug 2024 11:23:16 +0200
Message-ID: <87bk1mdybf.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Philo,

[CC Eric and Paolo who have more context than me here.]

On Tue, Aug 20, 2024 at 08:31 PM +08, Philo Lu wrote:
> Hi all, I wonder if it is feasible to move BPF_SK_LOOKUP ahead of connect=
ed UDP
> sk lookup?
>
> That is something like:
> (i.e., move connected udp socket lookup behind bpf sk lookup prog)
> ```
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index ddb86baaea6c8..9a1408775bcb1 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -493,13 +493,6 @@ struct sock *__udp4_lib_lookup(const struct net *net,
> __be32 saddr,
>         slot2 =3D hash2 & udptable->mask;
>         hslot2 =3D &udptable->hash2[slot2];
>
> -       /* Lookup connected or non-wildcard socket */
> -       result =3D udp4_lib_lookup2(net, saddr, sport,
> -                                 daddr, hnum, dif, sdif,
> -                                 hslot2, skb);
> -       if (!IS_ERR_OR_NULL(result) && result->sk_state =3D=3D TCP_ESTABL=
ISHED)
> -               goto done;
> -
>         /* Lookup redirect from BPF */
>         if (static_branch_unlikely(&bpf_sk_lookup_enabled) &&
>             udptable =3D=3D net->ipv4.udp_table) {
> @@ -512,6 +505,13 @@ struct sock *__udp4_lib_lookup(const struct net *net,
> __be32 saddr,
>                 }
>         }
>
> +       /* Lookup connected or non-wildcard socket */
> +       result =3D udp4_lib_lookup2(net, saddr, sport,
> +                                 daddr, hnum, dif, sdif,
> +                                 hslot2, skb);
> +       if (!IS_ERR_OR_NULL(result) && result->sk_state =3D=3D TCP_ESTABL=
ISHED)
> +               goto done;
> +
>         /* Got non-wildcard socket or error on first lookup */
>         if (result)
>                 goto done;
> ```
>
> This will be useful, e.g., if there are many concurrent udp sockets of a =
same
> ip:port, where udp4_lib_lookup2() may induce high softirq overhead, becau=
se it
> computes score for all sockets of the ip:port. With bpf sk_lookup prog, w=
e can
> implement 4-tuple hash for udp socket lookup to solve the problem (if bpf=
 prog
> runs before udp4_lib_lookup2).
>
> Currently, in udp, bpf sk lookup runs after connected socket lookup. IIUC=
, this
> is because the early version of SK_LOOKUP[0] modified local_ip/local_port=
 to
> redirect socket. This may interact wrongly with udp lookup because udp us=
es
> score to select socket, and setting local_ip/local_port cannot guarantee =
the
> result socket selected. However, now we get socket directly from map in b=
pf
> sk_lookup prog, so the above problem no longer exists.
>
> So is there any other problem on it=EF=BC=9FOr I'll try to work on it and=
 commit
> patches later.
>
> [0]https://lore.kernel.org/bpf/20190618130050.8344-1-jakub@cloudflare.com/
>
> Thank you for your time.

It was done like that to maintain the connected UDP socket guarantees.
Similarly to the established TCP sockets. The contract is that if you
are bound to a 4-tuple, you will receive the packets destined to it.

It sounds like you are looking for an efficient way to lookup a
connected UDP socket. We would be interested in that as well. We use
connected UDP/QUIC on egress where we don't expect the peer to roam and
change its address. There's a memory cost on the kernel side to using
them, but they make it easier to structure your application, because you
can have roughly the same design for TCP and UDP transport.

So what if instead of doing it in BPF, we make it better for everyone
and introduce a hash table keyed by 4-tuple for connected sockets in the
udp stack itself (counterpart of ehash in tcp)?

Thanks,
(the other) Jakub

