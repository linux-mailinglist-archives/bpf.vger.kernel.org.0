Return-Path: <bpf+bounces-28536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CBB8BB33B
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 20:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D09B1F201A1
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 18:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B0213A25B;
	Fri,  3 May 2024 18:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hpW97fX4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ssmiv9hm"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD63C1591F1;
	Fri,  3 May 2024 18:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714761014; cv=none; b=I+mFn6yyVje1Bguv9xqS2xgzMADEFWtS/MEafynthM4AEIIxJTB3z60z8aOyoxWRrnorsOMBr9N3B00e6rAvZ9sTg4NaaXXAehG7oPuWox1I4gV2HyblIndKk6yFd6u6KEBgMRUBD3DMCpR1mdFxzSkr1DtbcN59rcX5jVQmFxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714761014; c=relaxed/simple;
	bh=6fVCWFsuEBR7nJV+h+rv294+QgH0Wy9inghRo5IE69k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jPQ37TuQFkOM/Y5JDnR5HNrjrR8pRmyt2G0TUjYAOMf/mofmu2iCvhsJ9ulWxuc+hkPUKnbv29m/KiGcL9N4wALC+qsPWfCj529+Wx2QWFSmhNl6h6emidcAU0Qba7fl8/h1Q3bCq4WcoqPjWX1kHvAcM3fn902ip6Uycr49vxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hpW97fX4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ssmiv9hm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714761010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ybrNKVMPkZ4Ap31+Up4JCU5gLeDUDgUGDfpmjWAnCM=;
	b=hpW97fX4evbEt0tWQbOvOP61Uj5ksTD/64vN6UYwBwECNGgT89P7IQWlYezsnZ67Vymtsq
	tcpqYqRCHoHti+ZTXiAH6um/7o3j4E/Q9+4tZofYYGvCT+PXrmdizM0DXsQGjV9mRlASuv
	6j1l6KxjNZfuZGxEcX4NgQX6tMfzfW5WW+0vLvDyLkEWmxuhuz9HxvQE8OdBFniSeZN1DN
	WGs3YnW8oe0vS+tt4hpZnFTNgWIgkbd4oamLnQm/kv5tTEZVjtTb7chdKRotAY+k0RKpiX
	UavJJ4P/QnD4G9qBVkAYCpc2hdpToj+O1lgSnoBEqGQD2QKyYMVuoVtFv6lwkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714761010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ybrNKVMPkZ4Ap31+Up4JCU5gLeDUDgUGDfpmjWAnCM=;
	b=Ssmiv9hmiUSp1iHRdezmkdqkkK3COLazKJDAi/W/DvYC0fZ3hOoM1UGn1Om40iRt7c5xvm
	RlcAOAQLtBV9HVCQ==
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	bpf@vger.kernel.org
Subject: [PATCH net-next 13/15] net: Use nested-BH locking for bpf_scratchpad.
Date: Fri,  3 May 2024 20:25:17 +0200
Message-ID: <20240503182957.1042122-14-bigeasy@linutronix.de>
In-Reply-To: <20240503182957.1042122-1-bigeasy@linutronix.de>
References: <20240503182957.1042122-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

bpf_scratchpad is a per-CPU variable and relies on disabled BH for its
locking. Without per-CPU locking in local_bh_disable() on PREEMPT_RT
this data structure requires explicit locking.

Add a local_lock_t to the data structure and use local_lock_nested_bh()
for locking. This change adds only lockdep coverage and does not alter
the functional behaviour for !PREEMPT_RT.

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Song Liu <song@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/core/filter.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index cfe8ea59fd9db..e95b235a1e4f4 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1658,9 +1658,12 @@ struct bpf_scratchpad {
 		__be32 diff[MAX_BPF_STACK / sizeof(__be32)];
 		u8     buff[MAX_BPF_STACK];
 	};
+	local_lock_t	bh_lock;
 };
=20
-static DEFINE_PER_CPU(struct bpf_scratchpad, bpf_sp);
+static DEFINE_PER_CPU(struct bpf_scratchpad, bpf_sp) =3D {
+	.bh_lock	=3D INIT_LOCAL_LOCK(bh_lock),
+};
=20
 static inline int __bpf_try_make_writable(struct sk_buff *skb,
 					  unsigned int write_len)
@@ -2029,6 +2032,7 @@ BPF_CALL_5(bpf_csum_diff, __be32 *, from, u32, from_s=
ize,
 		     diff_size > sizeof(sp->diff)))
 		return -EINVAL;
=20
+	guard(local_lock_nested_bh)(&bpf_sp.bh_lock);
 	for (i =3D 0; i < from_size / sizeof(__be32); i++, j++)
 		sp->diff[j] =3D ~from[i];
 	for (i =3D 0; i <   to_size / sizeof(__be32); i++, j++)
--=20
2.43.0


