Return-Path: <bpf+bounces-23070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9021F86D25A
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 19:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45DDF1F21E4A
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 18:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2507453E27;
	Thu, 29 Feb 2024 18:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l8mPdTAS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VBN3PkA9"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6A137A;
	Thu, 29 Feb 2024 18:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709231489; cv=none; b=WNyW8Z8kx5FaFAISlcsTZZLL9pyRMTu6j4WEonh0yJ3/tPMbvUe+SK3mzdF68bICG5A7PufZXO6oCVbJGpxCWw7RY3cVX+VD5TAKScgyzUF740s5j58PttC8O2gMsjAI8BuEHgkUpoi6DDUiDrxTIbUEVlsL7h14bhEyjNr8vI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709231489; c=relaxed/simple;
	bh=kVQBBG8K+hDcFi7OSyJAb1VmE5J43rZTZM807TYsBKA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BMLaaiLKVircJ2dp8DDiIE8H1YhjevSbFfA5FehfaiNGZRheWdA0BFQuTpl2cztkvIuM1tZwQ6xAtEs0J97TdFVAgCODZPn4OxyqvO/S26bakV4HvfRl19H1E0titjo5CWtArDdjummVuLaQNxB3uyRddebXYhHzHpVDO5hTmdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l8mPdTAS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VBN3PkA9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709231486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2ghJABFM1TMIbzRqLTziilHNZM/la1mEMF6DVsm8KTY=;
	b=l8mPdTASf6JTitOVtaeF/6Ea9NFJgZ+zLcUzrQvkPx09S3GD6DTWUnYkR8EW1HIj02PpO4
	Xvlz9e233YrpVYmmXEqvVuVJbNW1/nlFJU3RYNTUhDU4HocoX2MivDNKZc+rPI0i8/S40g
	8D8TraiA446cR0f3vrWp5PCBe67AQ6l4BwEb/fqKEoN0HgyVZZ8dn1jFQ5GfPKtAgaFD4j
	CyXKzo4504Q6OX9tUW6QE7vNAp2496L2aspt/lS48VecVVS5ayG4LSO54B7ctc5W1BOCFr
	zrx4rFSVzE33234V1YEbDd9ZXWaKVTl/jDv4uGT1Iz6nrXrUxu6ZLlw2FmpYSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709231486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2ghJABFM1TMIbzRqLTziilHNZM/la1mEMF6DVsm8KTY=;
	b=VBN3PkA9k94JvHmpHEk+qjVGEUQ37tkg1ToHf9ABvlC1Q56uUU9rmXJXqvCZhT9Ai/XfPI
	tGKKVOhLJ3nwmqBA==
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Hao Luo <haoluo@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH RFC v2 net-next 0/2] Use per-task storage for XDP-redirects on PREEMPT_RT
Date: Thu, 29 Feb 2024 19:17:54 +0100
Message-ID: <20240229183109.646865-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

In [0] I introduced explicit locking for resources which are otherwise
locked implicit locked by local_bh_disable() and this protections goes
away if the lock in local_bh_disable() is removed on PREEMPT_RT.

There was a big complained once it came to the locking of XDP related
resources during XDP-redirect because it was mostly per-packet and the
locking, even not contended, was seen as a problem [1]. Another XDP
related problem was that I also touched every NIC-driver using XDP. This
complicated the "how to write a NIC driver" further.

To solve both problems I was thinking about an alternative and ended up
with moving the data structure from per-CPU to per-task on PREEMPT_RT.
Instead of adding it to task_struct, I added a pointer there and setup
the struct on stack. In my debug build on x86-64 the struct
bpf_xdp_storage has 112 bytes and collected the per-CPU ressources.

I've been benchmark the outcome on !RT. I meassured 14,880,077 pkt/s
with pktgen + "xdp-bench drop" on a ixgbe which is the interface limit.
I then lowered the clockspeed of the CPU (on the RX side) and received
approx between 12,156,279 and 12,476,759 pkt/s. The results were not
consistent and varied between runs mostly in that range with and without
the patches.

v1=E2=80=A6v2 https://lore.kernel.org/all/20240213145923.2552753-1-bigeasy@=
linutronix.de
  - Renamed the container struct from xdp_storage to bpf_net_context. Sugge=
sted
    by Toke H=C3=B8iland-J=C3=B8rgensen.
  - Use the container struct also on !PREEMPT_RT builds. Store the pointer =
to
    the on-stack struct in a per-CPU variable. Suggested by Toke
    H=C3=B8iland-J=C3=B8rgensen.

I'm posting here only two patches which replace the XDP redirect part
(patches 14 to 24) from the original series.

[0] https://lore.kernel.org/all/20231215171020.687342-1-bigeasy@linutronix.=
de/
[1] https://lore.kernel.org/all/CAADnVQKJBpvfyvmgM29FLv+KpLwBBRggXWzwKzaCT9=
U-4bgxjA@mail.gmail.com/
[2] https://lore.kernel.org/all/20231215145059.3b42ee35@kernel.org

Sebastian


