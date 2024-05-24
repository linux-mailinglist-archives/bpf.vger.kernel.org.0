Return-Path: <bpf+bounces-30488-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4E58CE686
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 16:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1D07B215B8
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 14:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAF012C47C;
	Fri, 24 May 2024 14:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sXX2qWPE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ocpWJufA"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D155312C46D;
	Fri, 24 May 2024 14:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716559204; cv=none; b=rhkLvA930SH7rC1meHhq2i6WAZyy33hmAj+4mDAUUFGFH28cb/3wNoed1Mvf5s2xF7FjOsCNZgNd8HZApGpo6wth/obun4OApvyw0S+fsarYH1h2A9GNh0w+2SfxiBQxbn/rs8rKFPO8kzwSjACokPxGsUoH7Qx+ZV4yysTP1a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716559204; c=relaxed/simple;
	bh=gJOCT9na8gry+4kXfZZGIyNB2OqFORA7gmU/xzaZpnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLr/xqHcK/43am91TsDnMpf5gj4GpDIpAlI79egrnQYcQdkG1BoB+q0Z8TzGvA9GTbi9fSsQJEfB8AfA32CHIQC79v07iQVu89nUPnc2fpInIXb3b/ePUUreCANinjyMtTN/mDS96j/U05Tljwf4HjFKypU2MQD66yYygQNLfI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sXX2qWPE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ocpWJufA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 24 May 2024 15:59:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716559200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f/A76odAYegRpkEVI5Walq5hzKKve1wY3Z0ErX+bHh4=;
	b=sXX2qWPEA8chrXcJ5424BF7eZxPJ9k/+L3mC3BklBqoz19/ciT0r0y1KlT+uHiGMewROaV
	TTL+gtNq3MKVZfVohkCLOb2XyXyRA8dWZdgSInLYwFmdJ14x77gyNA11CP5Bh8OJwYpNxu
	USKphm1glvtN5HHYBJ1ro6qT0EHpGgxwwqRrfqI5c3EFWZcoHhhHW9ldBZBMNr9s4ZdL+3
	xisBVeFnBwxOXhVV1RaaHOKI53+LrbC5fOI2BRwKv/O3mb4sZ29PqSWBEmT7QJnSHyiW3y
	4r/xxlM9C1JIKqmiy+yf4WHF4K29IYm/KkxuhK39Vtizlw/r32Pqx7A8UULVaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716559200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f/A76odAYegRpkEVI5Walq5hzKKve1wY3Z0ErX+bHh4=;
	b=ocpWJufA8orew8av39YAhNWCk5RR8amlti0napT73GMhadT2nEg4/46mHPkZYDYb+db9b7
	i2QTUrHSeBIeMqDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH net-next 14/15 v2] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
Message-ID: <20240524135958.I_5-z_K6@linutronix.de>
References: <CAADnVQJkiwaYXUo+LyKoV96VFFCFL0VY5Jgpuv_0oypksrnciA@mail.gmail.com>
 <20240507123636.cTnT7TvU@linutronix.de>
 <93062ce7-8dfa-48a9-a4ad-24c5a3993b41@kernel.org>
 <20240510162121.f-tvqcyf@linutronix.de>
 <20240510162214.zNWRKgFU@linutronix.de>
 <4949dca0-377a-45b1-a0fd-17bdf5a6ab10@kernel.org>
 <20240514054345.DZkx7fJs@linutronix.de>
 <e4123697-3e6e-4d4a-8b06-f69e1c453225@kernel.org>
 <20240517161553.SSh4BNQO@linutronix.de>
 <e3e21c87-d210-4360-8beb-25c6a04ce581@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e3e21c87-d210-4360-8beb-25c6a04ce581@kernel.org>

On 2024-05-22 09:09:45 [+0200], Jesper Dangaard Brouer wrote:
> For this benchmark, to focus, I would reduce this to:
>   # perf report --sort cpu,symbol --no-children

Keeping the bpf_net_ctx_set()/clear, removing the NULL checks (to align
with Alexei in his last email).
Perf numbers wise, I'm using
	xdp-bench redirect-cpu --cpu 3 --remote-action drop eth1 -e

unpached:

| eth1->?                 9,427,705 rx/s                  0 err,drop/s
|   receive total         9,427,705 pkt/s                 0 drop/s                0 error/s
|     cpu:17              9,427,705 pkt/s                 0 drop/s                0 error/s
|   enqueue to cpu 3      9,427,708 pkt/s                 0 drop/s             8.00 bulk-avg
|     cpu:17->3           9,427,708 pkt/s                 0 drop/s             8.00 bulk-avg
|   kthread total         9,427,710 pkt/s                 0 drop/s          147,276 sched
|     cpu:3               9,427,710 pkt/s                 0 drop/s          147,276 sched
|     xdp_stats                   0 pass/s        9,427,710 drop/s                0 redir/s
|       cpu:3                     0 pass/s        9,427,710 drop/s                0 redir/s
|   redirect_err                  0 error/s
|   xdp_exception                 0 hit/s

Patched:
| eth1->?                 9,557,170 rx/s                  0 err,drop/s
|   receive total         9,557,170 pkt/s                 0 drop/s                0 error/s
|     cpu:9               9,557,170 pkt/s                 0 drop/s                0 error/s
|   enqueue to cpu 3      9,557,170 pkt/s                 0 drop/s             8.00 bulk-avg
|     cpu:9->3            9,557,170 pkt/s                 0 drop/s             8.00 bulk-avg
|   kthread total         9,557,195 pkt/s                 0 drop/s          126,164 sched
|     cpu:3               9,557,195 pkt/s                 0 drop/s          126,164 sched
|     xdp_stats                   0 pass/s        9,557,195 drop/s                0 redir/s
|       cpu:3                     0 pass/s        9,557,195 drop/s                0 redir/s
|   redirect_err                  0 error/s
|   xdp_exception                 0 hit/s

I think this is noise. perf output as suggested (perf report --sort
cpu,symbol --no-children).

unpatched:
|  19.05%  017  [k] bpf_prog_4f0ffbb35139c187_cpumap_l4_hash
|  11.40%  017  [k] ixgbe_poll
|  10.68%  003  [k] cpu_map_kthread_run
|   7.62%  003  [k] intel_idle
|   6.11%  017  [k] xdp_do_redirect
|   6.01%  003  [k] page_frag_free
|   4.72%  017  [k] bq_flush_to_queue
|   3.74%  017  [k] cpu_map_redirect
|   2.35%  003  [k] xdp_return_frame
|   1.55%  003  [k] bpf_prog_57cd311f2e27366b_cpumap_drop
|   1.49%  017  [k] dma_sync_single_for_device
|   1.41%  017  [k] ixgbe_alloc_rx_buffers
|   1.26%  017  [k] cpu_map_enqueue
|   1.24%  017  [k] dma_sync_single_for_cpu
|   1.12%  003  [k] __xdp_return
|   0.83%  017  [k] bpf_trace_run4
|   0.77%  003  [k] __switch_to

patched:
|  18.20%  009  [k] bpf_prog_4f0ffbb35139c187_cpumap_l4_hash
|  11.64%  009  [k] ixgbe_poll
|   7.74%  003  [k] page_frag_free
|   6.69%  003  [k] cpu_map_bpf_prog_run_xdp
|   6.02%  003  [k] intel_idle
|   5.96%  009  [k] xdp_do_redirect
|   4.45%  003  [k] cpu_map_kthread_run
|   3.71%  009  [k] cpu_map_redirect
|   3.23%  009  [k] bq_flush_to_queue
|   2.55%  003  [k] xdp_return_frame
|   1.67%  003  [k] bpf_prog_57cd311f2e27366b_cpumap_drop
|   1.60%  009  [k] _raw_spin_lock
|   1.57%  009  [k] bpf_prog_d7eca17ddc334d36_tp_xdp_cpumap_enqueue
|   1.48%  009  [k] dma_sync_single_for_device
|   1.47%  009  [k] ixgbe_alloc_rx_buffers
|   1.39%  009  [k] dma_sync_single_for_cpu
|   1.33%  009  [k] cpu_map_enqueue
|   1.19%  003  [k] __xdp_return
|   0.66%  003  [k] __switch_to

I'm going to repost the series once the merge window closes unless there
is something you want me to do.

> --Jesper

Sebastian

