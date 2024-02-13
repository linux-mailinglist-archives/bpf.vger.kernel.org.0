Return-Path: <bpf+bounces-21850-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DB08533FF
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 16:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 439721C28462
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 15:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CFA6025F;
	Tue, 13 Feb 2024 14:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sgVW7DLx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GW9Fj45k"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6C760257;
	Tue, 13 Feb 2024 14:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836375; cv=none; b=q5NxCisCW3gDYk8uh+Dpy9Qna9On0zBVOz+rn5r5Y+OtPlVd0X3LyWB6slcej/oRvdFBmUvD5JL6JIc6psWCbigxI+o1fi+i3WhKVEmHX71AMz1i/tYEiRuRDHP6aVpPdY28gkjE7rjaUCYKea2C/pLsXxZmhmDpwZ96eTk08y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836375; c=relaxed/simple;
	bh=v9otiP5L8nHjXa/xwRy5kki/uXCwA9X2sejhc0Pk9FQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NXdfdThX1XAVC1YdY64Fj0vXqD7iqsPyQB5RIF2DZQ2IcAsw/mga2++OOG5zcryZeu3c/q0aDfNmJ93Xep08ChSGUtoVXUaUP/14f0OV7Mvqu4zX7zv2TPCF5h/CNkGVoaO+sKZ00waeaHGDv3f27N+rwTly5JTMOLTUwf2M/6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sgVW7DLx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GW9Fj45k; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707836371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=v9otiP5L8nHjXa/xwRy5kki/uXCwA9X2sejhc0Pk9FQ=;
	b=sgVW7DLxSPFUEr3WODMIU52ucuOp8Ik0oeYTP/IYtOC0mUdS8x9scn8m/E7naZ+euf6cyA
	ZHDYK2wFlGV8Im6YUcqDjMqRrJDttHFi+Az+I9z5FAGJImYNRH8fdLk7yJdnMRtdPuivFD
	yBxxgcFXA0SGBmPPk4QozSCYZbMo8QPg9q9cgg4D9o55pNRucJC4+1M+4I+Wi5pfcHi5fU
	V/sbM+H+3RXeW8QP8nQL9ULgRJSRsF7YHoyHk4b07/50PRNzQnql05DyWLXoOmvjVMBri2
	pYVAOO8Fjbjg9JrVz3aGbrJV4T3z0egy/XpwXkCZBmPcA24n2f8go81rgF0SVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707836371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=v9otiP5L8nHjXa/xwRy5kki/uXCwA9X2sejhc0Pk9FQ=;
	b=GW9Fj45kkrd1rEH/XgKVU8QbkAXvBUd3b/98V7bWLdSNrqh6zkvwXo3sgRgSlppiVnGEYc
	/pzYFrzAM2ufhaCQ==
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
Subject: [PATCH RFC net-next 0/2] Use per-task storage for XDP-redirects on PREEMPT_RT
Date: Tue, 13 Feb 2024 15:58:51 +0100
Message-ID: <20240213145923.2552753-1-bigeasy@linutronix.de>
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

I'm posting here only two patches which replace the XDP redirect part
(patches 14 to 24) from the original series.

[0] https://lore.kernel.org/all/20231215171020.687342-1-bigeasy@linutronix.=
de/
[1] https://lore.kernel.org/all/CAADnVQKJBpvfyvmgM29FLv+KpLwBBRggXWzwKzaCT9=
U-4bgxjA@mail.gmail.com/
[2] https://lore.kernel.org/all/20231215145059.3b42ee35@kernel.org

Sebastian

