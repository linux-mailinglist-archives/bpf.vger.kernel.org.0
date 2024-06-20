Return-Path: <bpf+bounces-32596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69408910614
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 15:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12EAD1F21909
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 13:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F6C1B47DF;
	Thu, 20 Jun 2024 13:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DNz4OG6a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3ymlR7JR"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9521AE0A5;
	Thu, 20 Jun 2024 13:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718890059; cv=none; b=Hr74wCoyS815PRVgou3FBJ2sBTei9DtZC8b0OKGkrqvYD9OYCzeM7qA1zB/OIgIkiqBKr1UBoyxQFmrHBM3zIs/gNSIalzIr8JJ/5XbYPmvtVX8yU23lPOEX6OerWXfAUBnv/aZHD4yaeuAFDhFzLSnz+w5/UJinEfNDH72jW4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718890059; c=relaxed/simple;
	bh=mmb/n5Zpp12YZ/miCg0qq3L4AeVcYXceQP9aeoru8uM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XcaWk0KDztYUvbGz6qvRKGmxuRdXCjziQvD7VRtycPNMmn5hF5hK0s37ZblabKCeNFvlOXrHajrvmVQ9ll6d521H8CBYVksalg31ECSp7Q7ulmFCX0Q1gf8ZQP7VMmzL5xevqpr3zaE/xDVmz+EWbL54UHI0hER2CSGfFp/ynF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DNz4OG6a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3ymlR7JR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718890056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2sNhpYc6Zhv5uHBsgsP2eGCPDInHSPpYVSlYr9BEPkY=;
	b=DNz4OG6aRuZjCTCGrx+cbR/r+tImEPpe4wq84hqsT1Y5E7U4jyVNwQue8nqtXxR4m08PnC
	ySg3bCMgXym2zn8TuBrocZLyRUgjOKcUUri8bW4u4IvEWZrkeu2VxSNBNGluNc/rPAe2jj
	CwORC7Mos6CUGv90/s2sI+MJjQcwah/w6IZiYAlsA0lggj/4zBxHLjeIAgGcj3ezJ/sRUO
	X10AEGRH5LjRhDN2oYA1U68KrYJucBVDLlydyUBQwClxHPLcPuofe7Xe2zI8hALw0TIcUS
	fuGDTgaDRBP4zegocXKnPACGpTQdL/GCKQKx7NqQO7t8hXtApootCQoGvt22ig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718890056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2sNhpYc6Zhv5uHBsgsP2eGCPDInHSPpYVSlYr9BEPkY=;
	b=3ymlR7JRXyXarzkCfFWMcRb+f4kvlRhEK3jJw8bwCWQ4TYQvMS5CcX3rtiz14Nht6YPfkj
	aaTCUgSedkJx0xDw==
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
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
Subject: [PATCH v9 net-next 13/15] net: Use nested-BH locking for bpf_scratchpad.
Date: Thu, 20 Jun 2024 15:22:03 +0200
Message-ID: <20240620132727.660738-14-bigeasy@linutronix.de>
In-Reply-To: <20240620132727.660738-1-bigeasy@linutronix.de>
References: <20240620132727.660738-1-bigeasy@linutronix.de>
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
 net/core/filter.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index ba1a739a9bedc..fbcfd563dccfd 100644
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
@@ -2016,6 +2019,7 @@ BPF_CALL_5(bpf_csum_diff, __be32 *, from, u32, from_s=
ize,
 	struct bpf_scratchpad *sp =3D this_cpu_ptr(&bpf_sp);
 	u32 diff_size =3D from_size + to_size;
 	int i, j =3D 0;
+	__wsum ret;
=20
 	/* This is quite flexible, some examples:
 	 *
@@ -2029,12 +2033,15 @@ BPF_CALL_5(bpf_csum_diff, __be32 *, from, u32, from=
_size,
 		     diff_size > sizeof(sp->diff)))
 		return -EINVAL;
=20
+	local_lock_nested_bh(&bpf_sp.bh_lock);
 	for (i =3D 0; i < from_size / sizeof(__be32); i++, j++)
 		sp->diff[j] =3D ~from[i];
 	for (i =3D 0; i <   to_size / sizeof(__be32); i++, j++)
 		sp->diff[j] =3D to[i];
=20
-	return csum_partial(sp->diff, diff_size, seed);
+	ret =3D csum_partial(sp->diff, diff_size, seed);
+	local_unlock_nested_bh(&bpf_sp.bh_lock);
+	return ret;
 }
=20
 static const struct bpf_func_proto bpf_csum_diff_proto =3D {
--=20
2.45.2


