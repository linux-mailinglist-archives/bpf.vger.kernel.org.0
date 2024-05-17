Return-Path: <bpf+bounces-29956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EAF8C89DF
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 18:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ECD41C217C1
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 16:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9303612FB18;
	Fri, 17 May 2024 16:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="odMDw5B5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jQQmelsg"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7455B12F5A7;
	Fri, 17 May 2024 16:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715962559; cv=none; b=jSVgj4ppdVw5U6wd8lgeuugBd9nodURLzpO+Ciu8ruHIbWSao1ffAQQCvAlEetiwuJCrsyLlToE5QnC96PhVHs6zOBc744/8bMUA3FW+Bs3L/KR6IEiIK3p65yMNeM0onaEvZ7vjVi/KnATjeNORoVjduM0T4VL7I3x2eL35D7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715962559; c=relaxed/simple;
	bh=EmAE75Rh1IojcGIii7mshbjXPWbWpMjnetS2uQdsF04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/hNLf77UdrF3AW5nCRaXckdbJqBKsKUByowhS4Ij4XANJEhDnW3POZefF57yEeV961qbMzkjvqcJKovP3YBBgtPgW+yIgWWdl3vX8V2q2/4L1ZL6rCuSywpOtjEb1E+kU55qa6ZmVJdLLzJ651Fyq2kXXO/9uzlyLPeHMDAYBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=odMDw5B5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jQQmelsg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 17 May 2024 18:15:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715962555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nu7OJz7stGDD7aVVbUS1exAOqBswvTYuUIGwWepjL+Y=;
	b=odMDw5B5NmpDQv+vVzfiiZ+jCVCfC5SspPiJtsW9aRwVGIP7eF7ZCBSSMLW3/B1JLGnBsg
	0xt/SBvTsNSGFIALeR4WWbgxNeVAyOZduMfOpUuGu9pFgExmSIJgiZiSS9DfZkZMb0+3f1
	IkW64GnlkhCpcC4APBnOmrp/xhfkmhqcoH7HdZLv+RnCT70dAVr6EvFzmyroHkT7SMlqhe
	e7Dk400XpXYd5TGiVLMfMtsvWrvaQEJleudgZr746fe4SeZDNiFC0mi53ia5LBIc0H5q7x
	UqRTipVe9iHk3OAS9e6ayM7yXdoDK/SvsxVYNDKuWhuz+8pFMOe0P2rjhuhWcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715962555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nu7OJz7stGDD7aVVbUS1exAOqBswvTYuUIGwWepjL+Y=;
	b=jQQmelsgpA0lT0C4fRIIw6vi6VwS7QZY53uLwQ12igOcw8ADTaJ/vvm9O2q2qeoy1NgHgY
	QtbjugbWbYbPSEBA==
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
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next 14/15 v2] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
Message-ID: <20240517161553.SSh4BNQO@linutronix.de>
References: <20240503182957.1042122-15-bigeasy@linutronix.de>
 <87y18mohhp.fsf@toke.dk>
 <CAADnVQJkiwaYXUo+LyKoV96VFFCFL0VY5Jgpuv_0oypksrnciA@mail.gmail.com>
 <20240507123636.cTnT7TvU@linutronix.de>
 <93062ce7-8dfa-48a9-a4ad-24c5a3993b41@kernel.org>
 <20240510162121.f-tvqcyf@linutronix.de>
 <20240510162214.zNWRKgFU@linutronix.de>
 <4949dca0-377a-45b1-a0fd-17bdf5a6ab10@kernel.org>
 <20240514054345.DZkx7fJs@linutronix.de>
 <e4123697-3e6e-4d4a-8b06-f69e1c453225@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e4123697-3e6e-4d4a-8b06-f69e1c453225@kernel.org>

On 2024-05-14 14:20:03 [+0200], Jesper Dangaard Brouer wrote:
> Trick for CPU-map to do early drop on remote CPU:
> 
>  # ./xdp-bench redirect-cpu --cpu 3 --remote-action drop ixgbe1
> 
> I recommend using Ctrl+\ while running to show more info like CPUs being
> used and what kthread consumes.  To catch issues e.g. if you are CPU
> redirecting to same CPU as RX happen to run on.

Okay. So I reworked the last two patches make the struct part of
task_struct and then did as you suggested:

Unpatched:
|Sending:
|Show adapter(s) (eno2np1) statistics (ONLY that changed!)
|Ethtool(eno2np1 ) stat:    952102520 (    952,102,520) <= port.tx_bytes /sec
|Ethtool(eno2np1 ) stat:     14876602 (     14,876,602) <= port.tx_size_64 /sec
|Ethtool(eno2np1 ) stat:     14876602 (     14,876,602) <= port.tx_unicast /sec
|Ethtool(eno2np1 ) stat:    446045897 (    446,045,897) <= tx-0.bytes /sec
|Ethtool(eno2np1 ) stat:      7434098 (      7,434,098) <= tx-0.packets /sec
|Ethtool(eno2np1 ) stat:    446556042 (    446,556,042) <= tx-1.bytes /sec
|Ethtool(eno2np1 ) stat:      7442601 (      7,442,601) <= tx-1.packets /sec
|Ethtool(eno2np1 ) stat:    892592523 (    892,592,523) <= tx_bytes /sec
|Ethtool(eno2np1 ) stat:     14876542 (     14,876,542) <= tx_packets /sec
|Ethtool(eno2np1 ) stat:            2 (              2) <= tx_restart /sec
|Ethtool(eno2np1 ) stat:            2 (              2) <= tx_stopped /sec
|Ethtool(eno2np1 ) stat:     14876622 (     14,876,622) <= tx_unicast /sec
|
|Receive:
|eth1->?                 8,732,508 rx/s                  0 err,drop/s
|  receive total         8,732,508 pkt/s                 0 drop/s                0 error/s
|    cpu:10              8,732,508 pkt/s                 0 drop/s                0 error/s
|  enqueue to cpu 3      8,732,510 pkt/s                 0 drop/s             7.00 bulk-avg
|    cpu:10->3           8,732,510 pkt/s                 0 drop/s             7.00 bulk-avg
|  kthread total         8,732,506 pkt/s                 0 drop/s          205,650 sched
|    cpu:3               8,732,506 pkt/s                 0 drop/s          205,650 sched
|    xdp_stats                   0 pass/s        8,732,506 drop/s                0 redir/s
|      cpu:3                     0 pass/s        8,732,506 drop/s                0 redir/s
|  redirect_err                  0 error/s
|  xdp_exception                 0 hit/s

I verified that the "drop only" case hits 14M packets/s while this
redirect part reports 8M packets/s.

Patched:
|Sending:
|Show adapter(s) (eno2np1) statistics (ONLY that changed!)
|Ethtool(eno2np1 ) stat:    952635404 (    952,635,404) <= port.tx_bytes /sec
|Ethtool(eno2np1 ) stat:     14884934 (     14,884,934) <= port.tx_size_64 /sec
|Ethtool(eno2np1 ) stat:     14884928 (     14,884,928) <= port.tx_unicast /sec
|Ethtool(eno2np1 ) stat:    446496117 (    446,496,117) <= tx-0.bytes /sec
|Ethtool(eno2np1 ) stat:      7441602 (      7,441,602) <= tx-0.packets /sec
|Ethtool(eno2np1 ) stat:    446603461 (    446,603,461) <= tx-1.bytes /sec
|Ethtool(eno2np1 ) stat:      7443391 (      7,443,391) <= tx-1.packets /sec
|Ethtool(eno2np1 ) stat:    893086506 (    893,086,506) <= tx_bytes /sec
|Ethtool(eno2np1 ) stat:     14884775 (     14,884,775) <= tx_packets /sec
|Ethtool(eno2np1 ) stat:           14 (             14) <= tx_restart /sec
|Ethtool(eno2np1 ) stat:           14 (             14) <= tx_stopped /sec
|Ethtool(eno2np1 ) stat:     14884937 (     14,884,937) <= tx_unicast /sec
|
|Receive:
|eth1->?                 8,735,198 rx/s                  0 err,drop/s
|  receive total         8,735,198 pkt/s                 0 drop/s                0 error/s
|    cpu:6               8,735,198 pkt/s                 0 drop/s                0 error/s
|  enqueue to cpu 3      8,735,193 pkt/s                 0 drop/s             7.00 bulk-avg
|    cpu:6->3            8,735,193 pkt/s                 0 drop/s             7.00 bulk-avg
|  kthread total         8,735,191 pkt/s                 0 drop/s          208,054 sched
|    cpu:3               8,735,191 pkt/s                 0 drop/s          208,054 sched
|    xdp_stats                   0 pass/s        8,735,191 drop/s                0 redir/s
|      cpu:3                     0 pass/s        8,735,191 drop/s                0 redir/s
|  redirect_err                  0 error/s
|  xdp_exception                 0 hit/s

This looks to be in the same range/ noise level. top wise I have
ksoftirqd at 100% and cpumap/./map at ~60% so I hit CPU speed limit on a
10G link. perf top shows
|   18.37%  bpf_prog_4f0ffbb35139c187_cpumap_l4_hash         [k] bpf_prog_4f0ffbb35139c187_cpumap_l4_hash
|   13.15%  [kernel]                                         [k] cpu_map_kthread_run
|   12.96%  [kernel]                                         [k] ixgbe_poll
|    6.78%  [kernel]                                         [k] page_frag_free
|    5.62%  [kernel]                                         [k] xdp_do_redirect

for the top 5. Is this something that looks reasonable?

Sebastian

