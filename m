Return-Path: <bpf+bounces-30876-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 055668D4122
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 00:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85F161F236BC
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 22:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FE91C9EC9;
	Wed, 29 May 2024 22:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RfqzMy4I"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E6F1A0B06
	for <bpf@vger.kernel.org>; Wed, 29 May 2024 22:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717020569; cv=none; b=ldTGFFkfTnXYIWHY+oYxGVru43oAnzEavP3MPfi+oJw+gZaEplTDrxR5iR44DbjEch2F5lsnJ2KX3KGClUETuTOzObeKFTxEMZPYNuz/pK6G3HsQ/kvYqLByh2sxpDKOKdUuE24OJTKal71nE3ZPAIjDTsYeqh4O5a6CXPDhpJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717020569; c=relaxed/simple;
	bh=0vYVZzUaVKP4uUJpRFZyVVfF/2Uv+MQRVxcUlKxLmrw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZZ1RrsW1478BF3IJTckkfBN6RaRhJUskuX0q/US7bhGpbRBKiJV0nCrQAg81ggpm4NRW9KRVRwQD3KnquGq8oKfd+1Ii9NisEAsjAOUR4ieZk5ZXrMbZWTxbuoM/ZhWxT9MHsUfp/6DcLQgmdwB4M+CKjTIWhh4qGRbUmUMnK/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RfqzMy4I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717020566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z9ow/XSyHWasa02XS2ZsOAzreuOoRcDV7JFckpkP2k0=;
	b=RfqzMy4IRHBCPh4LB2wFNYo3tI2k4XNTcIbUWXpDKIHqdnIk2q4clSMvoZcBcwDPkJFzri
	p1LerShYtyO0ml3BWyoZ3904FsbM141DScq4PjrnlfHA7ppSr25gFbsNnrVeQmU4ZxTDxj
	ei74VNbWkVaGiOYRDMiWnrTCKq+fqtc=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-DG9aaVJZNLGhsDHGeQIFFw-1; Wed, 29 May 2024 18:09:25 -0400
X-MC-Unique: DG9aaVJZNLGhsDHGeQIFFw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ea7dfffc8fso1301241fa.1
        for <bpf@vger.kernel.org>; Wed, 29 May 2024 15:09:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717020564; x=1717625364;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9ow/XSyHWasa02XS2ZsOAzreuOoRcDV7JFckpkP2k0=;
        b=eCxmpfo11pYdser4KhjENRsDpuffPpVlflLaNQy639oQMtsew388Eylc44kVuiotO4
         KzV5K/ai3q5dMKg85/c2Mb6SHiUAEz/+aWzCEmx+6zpLJzUBQUol7KomgxXJae4kfoMe
         4s+8Rcy5dTupEIfSNCt32Pkiw1CIYKjhqRd1PcVKQSLA0N2B7RsEdpjUGCCmRSaJi0G8
         JV6yn8H0FoZyswZlEE9WI/gA5fx/lQsAAN/6bDcMTDMOyqJa34rHiRyAkShE5igfbSSr
         L/7tNGUXQxN7/AV9+ENTGAZDOxGCTIDH9xNgy3Et4k4pgXFc8Cx5kej3yAiqBB9iBAoh
         sxPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWj/LAW/py3T6KSdqfRmGY/DKg+ascoWbkvBhwVEcEhDnahqrROvVwGbY1zl9bMywM2pRuOdKTvrv6OTdo4YzJwThl
X-Gm-Message-State: AOJu0YyIjFEdeSw+AvOup1ozUqjwzcqyztixmDp3G+3SiqQSqLGhjrhi
	W5KBUGiovbw/uZSL2u+IZ4CxBTvAVBD6FMnh+7EXu7r+5mkZR+meOdt6d1GFpx/DCV3cqT5tlKM
	gkjS1XD3ohMyjJJ7qiJg/f5cQbBRu2GxzdV2TG8d65Z20yxFW9A==
X-Received: by 2002:a2e:96d7:0:b0:2e4:7996:f9f0 with SMTP id 38308e7fff4ca-2ea847a4e39mr834831fa.17.1717020563619;
        Wed, 29 May 2024 15:09:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHS4TnQrU0cpBMki4X+FLRIe/I3dM8DaBDsz9YNFoO9JKW6QwSUwuAEBHJzx8kQBjtDxsdWyg==
X-Received: by 2002:a2e:96d7:0:b0:2e4:7996:f9f0 with SMTP id 38308e7fff4ca-2ea847a4e39mr834621fa.17.1717020563092;
        Wed, 29 May 2024 15:09:23 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5785ed2bb6asm8099164a12.26.2024.05.29.15.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 15:09:22 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id B488712F7F44; Thu, 30 May 2024 00:09:21 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Boqun Feng
 <boqun.feng@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Eric
 Dumazet <edumazet@google.com>, Frederic Weisbecker <frederic@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Waiman Long <longman@redhat.com>, Will
 Deacon <will@kernel.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Hao
 Luo <haoluo@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song
 Liu <song@kernel.org>, Stanislav Fomichev <sdf@google.com>, Yonghong Song
 <yonghong.song@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH v3 net-next 14/15] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
In-Reply-To: <20240529162927.403425-15-bigeasy@linutronix.de>
References: <20240529162927.403425-1-bigeasy@linutronix.de>
 <20240529162927.403425-15-bigeasy@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 30 May 2024 00:09:21 +0200
Message-ID: <87y17sfey6.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> The XDP redirect process is two staged:
> - bpf_prog_run_xdp() is invoked to run a eBPF program which inspects the
>   packet and makes decisions. While doing that, the per-CPU variable
>   bpf_redirect_info is used.
>
> - Afterwards xdp_do_redirect() is invoked and accesses bpf_redirect_info
>   and it may also access other per-CPU variables like xskmap_flush_list.
>
> At the very end of the NAPI callback, xdp_do_flush() is invoked which
> does not access bpf_redirect_info but will touch the individual per-CPU
> lists.
>
> The per-CPU variables are only used in the NAPI callback hence disabling
> bottom halves is the only protection mechanism. Users from preemptible
> context (like cpu_map_kthread_run()) explicitly disable bottom halves
> for protections reasons.
> Without locking in local_bh_disable() on PREEMPT_RT this data structure
> requires explicit locking.
>
> PREEMPT_RT has forced-threaded interrupts enabled and every
> NAPI-callback runs in a thread. If each thread has its own data
> structure then locking can be avoided.
>
> Create a struct bpf_net_context which contains struct bpf_redirect_info.
> Define the variable on stack, use bpf_net_ctx_set() to save a pointer to
> it. Use the __free() annotation to automatically reset the pointer once
> function returns.
> The bpf_net_ctx_set() may nest. For instance a function can be used from
> within NET_RX_SOFTIRQ/ net_rx_action which uses bpf_net_ctx_set() and
> NET_TX_SOFTIRQ which does not. Therefore only the first invocations
> updates the pointer.
> Use bpf_net_ctx_get_ri() as a wrapper to retrieve the current struct
> bpf_redirect_info.
>
> On PREEMPT_RT the pointer to bpf_net_context is saved task's
> task_struct. On non-PREEMPT_RT builds the pointer saved in a per-CPU
> variable (which is always NODE-local memory). Using always the
> bpf_net_context approach has the advantage that there is almost zero
> differences between PREEMPT_RT and non-PREEMPT_RT builds.
>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Hao Luo <haoluo@google.com>
> Cc: Jesper Dangaard Brouer <hawk@kernel.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Song Liu <song@kernel.org>
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: bpf@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[...]
> @@ -240,12 +240,14 @@ static int cpu_map_bpf_prog_run(struct bpf_cpu_map_=
entry *rcpu, void **frames,
>  				int xdp_n, struct xdp_cpumap_stats *stats,
>  				struct list_head *list)
>  {
> +	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
>  	int nframes;

I think we need to zero-initialise all the context objects we allocate
on the stack.

The reason being that an XDP program can return XDP_REDIRECT without
calling any of the redirect helpers first; which will lead to
xdp_do_redirect() being called without any of the fields in struct
bpf_redirect_info having being set. This can lead to a crash if the
values happen to be the wrong value; and if we're not initialising the
stack space used by this struct, we have no guarantees about what value
they will end up with.

We fixed a similar bug relatively recently, see:

5bcf0dcbf906 ("xdp: use flags field to disambiguate broadcast redirect")

>  void bpf_clear_redirect_map(struct bpf_map *map)
>  {
> -	struct bpf_redirect_info *ri;
> -	int cpu;
> -
> -	for_each_possible_cpu(cpu) {
> -		ri =3D per_cpu_ptr(&bpf_redirect_info, cpu);
> -		/* Avoid polluting remote cacheline due to writes if
> -		 * not needed. Once we pass this test, we need the
> -		 * cmpxchg() to make sure it hasn't been changed in
> -		 * the meantime by remote CPU.
> -		 */
> -		if (unlikely(READ_ONCE(ri->map) =3D=3D map))
> -			cmpxchg(&ri->map, map, NULL);
> -	}
> +	/* ri->map is assigned in __bpf_xdp_redirect_map() from within a eBPF
> +	 * program/ during NAPI callback. It is used during
> +	 * xdp_do_generic_redirect_map()/ __xdp_do_redirect_frame() from the
> +	 * redirect callback afterwards. ri->map is cleared after usage.
> +	 * The path has no explicit RCU read section but the local_bh_disable()
> +	 * is also a RCU read section which makes the complete softirq callback
> +	 * RCU protected. This in turn makes ri->map RCU protected and it is
> +	 * sufficient to wait a grace period to ensure that no "ri->map =3D=3D =
map"
> +	 * exists. dev_map_free() removes the map from the list and then
> +	 * invokes synchronize_rcu() after calling this function.
> +	 */
>  }

With the zeroing of the stack variable mentioned above, I agree that
this is not needed anymore, but I think we should just get rid of the
function entirely and put a comment in devmap.c instead of the call to
the (now empty) function.

-Toke


