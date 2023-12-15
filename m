Return-Path: <bpf+bounces-18016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B47814E1F
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 18:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21A1E1C23F7E
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 17:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C3849F66;
	Fri, 15 Dec 2023 17:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i1txzjU2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qpiqOMh1"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E658246459;
	Fri, 15 Dec 2023 17:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702660237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ttIXeZ1ovHzP3s4F4dQhi8p1AikC0DzBNJEl/q3oOFU=;
	b=i1txzjU2KalZCJ8xYOeccEgh79T53JDMXo6hg9E0Mau+4g4nEzUiD/CU8QtNlcyNoMioNh
	TxMQ6lCO2yFp+l4aRR42CeLo7AtXdM42ZZzsnfMKblwNsySw00E19iXVw2u5HXIlKMh1od
	0Llrgx3TK8reem3ivDEKJy2UXYWWALyMSBMFYs9+zxL/HlBtrzIcUXm5m8ZZ/5YImNN7lO
	cAGnMTMRhHeXvmYWjgB14T5Fcz6Y7eQAgy4ZqjE08SOVUO1jI2u1fAy/aFqNaScVh8B9jc
	QCHYZ1d78L1SzqyNvK0hY0llM5vR2g43iaL1X+2sVIpumHkKDsIyh1k5X25prQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702660237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ttIXeZ1ovHzP3s4F4dQhi8p1AikC0DzBNJEl/q3oOFU=;
	b=qpiqOMh1zBcnXXLLLCyeEFb2GN33yYgr8NRbg0Pr11SJ8OU7LfkwcblN3sg2bH4nUYN3Sc
	jk7theU4aQBFwpBA==
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
Subject: [PATCH net-next 13/24] net: Use nested-BH locking for bpf_scratchpad.
Date: Fri, 15 Dec 2023 18:07:32 +0100
Message-ID: <20231215171020.687342-14-bigeasy@linutronix.de>
In-Reply-To: <20231215171020.687342-1-bigeasy@linutronix.de>
References: <20231215171020.687342-1-bigeasy@linutronix.de>
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
index c8013f762524b..896aa3fa699f9 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1652,9 +1652,12 @@ struct bpf_scratchpad {
 		__be32 diff[MAX_BPF_STACK / sizeof(__be32)];
 		u8     buff[MAX_BPF_STACK];
 	};
+	local_lock_t	lock;
 };
=20
-static DEFINE_PER_CPU(struct bpf_scratchpad, bpf_sp);
+static DEFINE_PER_CPU(struct bpf_scratchpad, bpf_sp) =3D {
+	.lock	=3D INIT_LOCAL_LOCK(lock),
+};
=20
 static inline int __bpf_try_make_writable(struct sk_buff *skb,
 					  unsigned int write_len)
@@ -2023,6 +2026,7 @@ BPF_CALL_5(bpf_csum_diff, __be32 *, from, u32, from_s=
ize,
 		     diff_size > sizeof(sp->diff)))
 		return -EINVAL;
=20
+	guard(local_lock_nested_bh)(&bpf_sp.lock);
 	for (i =3D 0; i < from_size / sizeof(__be32); i++, j++)
 		sp->diff[j] =3D ~from[i];
 	for (i =3D 0; i <   to_size / sizeof(__be32); i++, j++)
--=20
2.43.0


