Return-Path: <bpf+bounces-32397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BED90C6E4
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 12:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65DEC2837BE
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 10:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FA014B94E;
	Tue, 18 Jun 2024 08:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTM03l7l"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391A213C9CA;
	Tue, 18 Jun 2024 08:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718698495; cv=none; b=cgJln2LBJE8x12mdTg11Z/KugpFO/NUrlqLB8e56lBrMlacKMDOUmUsAoXu4Xe7ZKz5P+eRVGUGOMB+MDae3aXGYWe/ufk3EfCCGmgujjWQ/6eb5ojGo7ziVpZV2XJsTnBXWilQZb5qmeJ6jsKayekZIYMCJYxBZqcJox2QvsEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718698495; c=relaxed/simple;
	bh=zlCDXefRON0FAF8gTSzpEaEP8+H4tiyr3HYpIgBFslg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fGc3qKjISK9NE1v0op8ACBCUxQkKj8hFUj7QaVM79APn209oUWniJrTCGajZIkX7eWlJjI+zVCvckEPdeXD83CBJCdvx1Oq81+GlMggcdqHmp4uGgJCF+jrl2Jq23LTqGNDz6iby52L2DsUlj4gVVBQvEy0Xc0BXJ7TAU1jPhiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTM03l7l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEEE0C4AF1D;
	Tue, 18 Jun 2024 08:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718698494;
	bh=zlCDXefRON0FAF8gTSzpEaEP8+H4tiyr3HYpIgBFslg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BTM03l7lfrQLJnaYzBrrkZKaZ6N7NWnlO3XETb8YQ1F7Ep+ARGVEmDiYYZM2YQBGq
	 JSCeqs7wDvKWXCSrtDRPl5RPppnPge6q1XBS3d3ZmIXYR6elE1PINPD4rAYi8RdSVt
	 FEoEpws5BzuPrwlDYkW7MllJ6zNnRuD6nvvqy0xwDYOrla3fDgd3Xk/3u/RUVHfeZR
	 diqZNcjMhxWzh8oY7M3NM59/jYlaD4ItsQN+Sc34jSt1NyTHyV6/GcY+nKJetU/sgh
	 02iiPAKXigPcL9At1SiPh0YGrJp+5hHEfbzUiyAz6vvjZeWJ6BBYhqhJDONAMkF7Vl
	 S6xC7RJbgZTlg==
Message-ID: <532e7984-91a8-4faf-8367-bb309884c8e8@kernel.org>
Date: Tue, 18 Jun 2024 10:14:31 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 14/15] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Daniel Bristot de Oliveira <bristot@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Eric Dumazet <edumazet@google.com>, Frederic Weisbecker
 <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
References: <20240618072526.379909-1-bigeasy@linutronix.de>
 <20240618072526.379909-15-bigeasy@linutronix.de>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20240618072526.379909-15-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 18/06/2024 09.13, Sebastian Andrzej Siewior wrote:
> The XDP redirect process is two staged:
> - bpf_prog_run_xdp() is invoked to run a eBPF program which inspects the
>    packet and makes decisions. While doing that, the per-CPU variable
>    bpf_redirect_info is used.
> 
> - Afterwards xdp_do_redirect() is invoked and accesses bpf_redirect_info
>    and it may also access other per-CPU variables like xskmap_flush_list.
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
> it, bpf_net_ctx_clear() removes it again.
> The bpf_net_ctx_set() may nest. For instance a function can be used from
> within NET_RX_SOFTIRQ/ net_rx_action which uses bpf_net_ctx_set() and
> NET_TX_SOFTIRQ which does not. Therefore only the first invocations
> updates the pointer.
> Use bpf_net_ctx_get_ri() as a wrapper to retrieve the current struct
> bpf_redirect_info. The returned data structure is zero initialized to
> ensure nothing is leaked from stack. This is done on first usage of the
> struct. bpf_net_ctx_set() sets bpf_redirect_info::kern_flags  to 0 to
> note that initialisation is required. First invocation of
> bpf_net_ctx_get_ri() will memset() the data structure and update
> bpf_redirect_info::kern_flags.
> bpf_redirect_info::nh  is excluded from memset because it is only used
> once BPF_F_NEIGH is set which also sets the nh member. The kern_flags is
> moved past nh to exclude it from memset.
> 
> The pointer to bpf_net_context is saved task's task_struct. Using
> always the bpf_net_context approach has the advantage that there is
> almost zero differences between PREEMPT_RT and non-PREEMPT_RT builds.
> 
> Cc: Alexei Starovoitov<ast@kernel.org>
> Cc: Andrii Nakryiko<andrii@kernel.org>
> Cc: Eduard Zingerman<eddyz87@gmail.com>
> Cc: Hao Luo<haoluo@google.com>
> Cc: Jesper Dangaard Brouer<hawk@kernel.org>
> Cc: Jiri Olsa<jolsa@kernel.org>
> Cc: John Fastabend<john.fastabend@gmail.com>
> Cc: KP Singh<kpsingh@kernel.org>
> Cc: Martin KaFai Lau<martin.lau@linux.dev>
> Cc: Song Liu<song@kernel.org>
> Cc: Stanislav Fomichev<sdf@google.com>
> Cc: Toke Høiland-Jørgensen<toke@redhat.com>
> Cc: Yonghong Song<yonghong.song@linux.dev>
> Cc:bpf@vger.kernel.org
> Acked-by: Alexei Starovoitov<ast@kernel.org>
> Reviewed-by: Toke Høiland-Jørgensen<toke@redhat.com>
> Signed-off-by: Sebastian Andrzej Siewior<bigeasy@linutronix.de>

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

> ---
>   include/linux/filter.h | 56 ++++++++++++++++++++++++++++++++++--------
>   include/linux/sched.h  |  3 +++
>   kernel/bpf/cpumap.c    |  3 +++
>   kernel/bpf/devmap.c    |  9 ++++++-
>   kernel/fork.c          |  1 +
>   net/bpf/test_run.c     | 11 ++++++++-
>   net/core/dev.c         | 26 +++++++++++++++++++-
>   net/core/filter.c      | 44 +++++++++------------------------
>   net/core/lwt_bpf.c     |  3 +++
>   9 files changed, 111 insertions(+), 45 deletions(-)

