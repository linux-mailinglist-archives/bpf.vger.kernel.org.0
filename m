Return-Path: <bpf+bounces-31344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA0E8FB7D0
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 17:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C3E11C20A5D
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 15:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A41C13C9CF;
	Tue,  4 Jun 2024 15:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fe0VzxAc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e+fricD/"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697BD149000;
	Tue,  4 Jun 2024 15:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717515895; cv=none; b=h8PG4XcuAJK5QBXMouUrnMmDPR+Yx4YHcknzxmIl8txcP29opeWXuhmDSJt5FgIrCfbdWEQzYxvVmsX02DGi48IwbqlYtviH6u7TCscD0wBlgya1y0vlEZOacuPXumHVFBm95GapDAicdTt424QnCF4yYZJvFUDDI8Sfs+uL9As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717515895; c=relaxed/simple;
	bh=fxJVmdO1CTi7V8vAAKfth09PKKmQR961Uj2IUC0/xxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YEnd66wr/gY5SFN5tleYA2g9oL+hjR19gE6PDUh0IqB2CBwRQ9y53oNsT3DJVkjzQRMr31rBm0pywMrBIB8DxdVcmGdiwzeuPpBmcu38qksHsmt61OtF0HG9IiYrkBQTbTSJemGk9pF2JTwQU0ZAt/WuD8o89XuO0Lm1ZvWIRyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fe0VzxAc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e+fricD/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717515892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hJt9gmCzXKZq1/EDvJLFPCVcIT0BYHNB+LSrBaTimp0=;
	b=fe0VzxAcTFVdsFkFJFpDL1+1n8nICuKctkRpBl0d4Aq6Bl0YIjd45JXYIKfzmOj1C+koOw
	A/+TnQ5NHNuWBEfICJlgAcBqQ4wBKeo90XO5GunDeH2lZMaxyiV5kDQw+aOJaRvDeoYV6L
	/z2/xDPflrzH1XhyR4URer7LqXzPj+VV1RcHYzAUgE0K/cCv6XcEne9l7F93Qw96hfhKNJ
	csRm2cGy5INANPkD5NnJSSOd/UlB6GsdCCxwe+4/VUzUnNHSw2KrfSRWc32R8enrTSk96J
	PHI8iGOlcybQKb/fPlVKGYQZgreLmRSEYK4MovMBcc4hzS3VM1I7rk56mHce0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717515892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hJt9gmCzXKZq1/EDvJLFPCVcIT0BYHNB+LSrBaTimp0=;
	b=e+fricD/CinJLizzUzmU78peMB/LCy7pjpJVIGx2smV4esX+YofDxD4cdrQGpfPGZ0q/73
	z6AmEim1Qjj7jmCQ==
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
Subject: [PATCH v4 net-next 12/14] net: Use nested-BH locking for bpf_scratchpad.
Date: Tue,  4 Jun 2024 17:24:19 +0200
Message-ID: <20240604154425.878636-13-bigeasy@linutronix.de>
In-Reply-To: <20240604154425.878636-1-bigeasy@linutronix.de>
References: <20240604154425.878636-1-bigeasy@linutronix.de>
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
index ba1a739a9bedc..d6cf1a63c3f43 100644
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
2.45.1


