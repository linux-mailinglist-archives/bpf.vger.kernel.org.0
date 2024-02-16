Return-Path: <bpf+bounces-22166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBBC858325
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 17:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFFEE1C23087
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 16:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EC4130E25;
	Fri, 16 Feb 2024 16:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fcafaV6/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cZf9ceIF"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91B9130AF2;
	Fri, 16 Feb 2024 16:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708102662; cv=none; b=hIUVkaEGkxDv4PQS1RUg5bsM7HVUHixlwd84JCyzfPuerI3HuKYGakpFokWCDnLBCiw5lDOMTSFz1DvBbSPvPs1+zkGJsVucR/IIWP3cig96oZ/eBe3RRWCqf6VWb4/7fYIR2kZt3yEAOX0Hlj3Kvsw6/6cx+C/fHIo1bD0TFWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708102662; c=relaxed/simple;
	bh=kaPNPJvzjPget46jaXL8xszSapcjiU23O7CPCwGlTn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWnUrtlLCw1jH0XZtmmDsvTpSHIJtrEphYodPbVhUIyqW8Jxe0YQ4TKV1LB0hYSpCEYnjqcK4Nf1m5UxzO0HcqF/0lqQoScuYj56hDEi2aEKSKlNxAY9hhVHRmNInzBx5d8N6MxkHwi0BuqXhvLpTkLtOeV8HddvCzQq6XC+zYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fcafaV6/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cZf9ceIF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 17:57:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708102658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aFmDNEElF/VWZeUTxvj+mfaiyGTApkE7wx3z3xUMwXQ=;
	b=fcafaV6/dvA6nPxfuowbaVmvagJFAos5XinbbIvoXeitAixnlPQ/A9+YvhijVclnUzUq3H
	lDqov57ezGvej4Gj9f2JtTOLBiIPdeusuQeTJvWnkc2339/UDp0o6/vKgWN2gJRGuYczov
	+POeHGGMXIZYBbwnoKfr/yG7gdHI1XevYDgP+47EzkkrA0Nci9LVa71HWypsFsUb5UVZCn
	r8Ua3ikc5kQ4c5vEBceXUbOXciia27M3m2IRFKbgoYWvc+j8HkkPTtrSk3K1qFVuvokzX8
	Ik+U2y21m4YFSgqnb5N99L4dEF7FKiFSrOicbdFgF3hYf+xAFd50cZK6zaR70A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708102658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aFmDNEElF/VWZeUTxvj+mfaiyGTApkE7wx3z3xUMwXQ=;
	b=cZf9ceIFXFfsWHctMTzDR4bxMOb8RsPz7989okTAFS0nkRHxcjgZKHuAIa32eoIEzDtIsA
	SNX6OiliPyppyiDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>, Hao Luo <haoluo@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH RFC net-next 1/2] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
Message-ID: <20240216165737.oIFG5g-U@linutronix.de>
References: <20240213145923.2552753-1-bigeasy@linutronix.de>
 <20240213145923.2552753-2-bigeasy@linutronix.de>
 <66d9ee60-fbe3-4444-b98d-887845d4c187@kernel.org>
 <20240214121921.VJJ2bCBE@linutronix.de>
 <87y1bndvsx.fsf@toke.dk>
 <20240214142827.3vV2WhIA@linutronix.de>
 <87le7ndo4z.fsf@toke.dk>
 <20240214163607.RjjT5bO_@linutronix.de>
 <87jzn5cw90.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87jzn5cw90.fsf@toke.dk>

On 2024-02-15 21:23:23 [+0100], Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> The tricky part is that the traffic actually has to stress the CPU,
> which means that the offered load has to be higher than what the CPU can
> handle. Which generally means running on high-speed NICs with small
> packets: a modern server CPU has no problem keeping up with a 10G link
> even at 64-byte packet size, so a 100G NIC is needed, or the test needs
> to be run on a low-powered machine.

I have 10G box. I can tell cpufreq to go down to 1.1Ghz and I could
reduce the queues to one and hope that it is slow enough.

> As a traffic generator, the xdp-trafficgen utility also in xdp-tools can
> be used, or the in-kernel pktgen, or something like T-rex or Moongen.
> Generally serving UDP traffic with 64-byte packets on a single port
> is enough to make sure the traffic is serviced by a single CPU, although
> some configuration may be needed to steer IRQs as well.

I played with xdp-trafficgen:
| # xdp-trafficgen udp eno2  -v
| Current rlimit is infinity or 0. Not raising
| Kernel supports 5-arg xdp_cpumap_kthread tracepoint
| Error in ethtool ioctl: Operation not supported
| Got -95 queues for ifname lo
| Kernel supports 5-arg xdp_cpumap_kthread tracepoint
| Got 94 queues for ifname eno2
| Transmitting on eno2 (ifindex 3)
| lo->eno2                        0 err/s                 0 xmit/s
| lo->eno2                        0 err/s                 0 xmit/s
| lo->eno2                        0 err/s                 0 xmit/s

I even tried set the MAC address with -M/ -m but nothing happens. I see
and on drop side something happening when I issue a ping command.
Does something ring a bell? Otherwise I try the pktgen. This is a Debian
kernel (just to ensure I didn't break something or forgot a config
switch).

> -Toke

Sebastian

