Return-Path: <bpf+bounces-32595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D2B910613
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 15:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 619F31F21748
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 13:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322A41B47C9;
	Thu, 20 Jun 2024 13:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eGwCLRfe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kYKulGVl"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348A51B150D;
	Thu, 20 Jun 2024 13:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718890059; cv=none; b=UFTlPo+gVFm7dIhb800yIAuaJAFghaRcTT5QmKYa/MosMTQW0khhyvDkGH6eUkeqicgB9Nn7GiwWx6UZWSedk0PNS/Rl0gzpQUfMzDYejAa93FvUW9svsybkl59Ltx+zBAyqtVfNOoLAGOzfTwtRDcfB39TwqEgo8iQf2HqBRC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718890059; c=relaxed/simple;
	bh=FbbAiov4OHSV7INKnGdeocZuk+klys2tkIDh/H6h8/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mkiVbkDE7gdCuFWdGJgzaPTnM9FK39w0t/FjnlIAem56cQpO2Hhizo1C5U8YAhcWKxd5BZRfHlO25vQYaQjIo6Y8z8fiAV7gYo6KtUW/hitJ84xWxj36p8ZeLWc8MMkLiuKZ9rdZ+i9nm5MDteicmXueYVeVakPr02Givfc+hNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eGwCLRfe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kYKulGVl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718890055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xg1ApPCQGVJ8CFcoKgcEnIVTe/xamtVzkM/qsLKXD5I=;
	b=eGwCLRfexfwVKGxWDTzXRH8wAdFxuxQ/h1VrmZH5MhSlc6hOPvzDSbZuS+18vAD+YYrahJ
	QT/xZDUSXgRjoIBwtWY3WEO9Aa5ZaECenmltKt1P8e4f4R8pu2OL304c/hjEB1KmcQjIuk
	cQoBqXG37VFcuv5WQdbbw5ahg4dbmQDJoNUklLM1S4bnElxPcdLUSV3JsvgAKlNPcK8qOY
	8Kp89qRW3AR4DfxlsMeZrBCSDIU3vPqAT0KUedrfcJlVieyYTWRROCGr20A6jlzSm6Ql68
	651bbagmO3zSCiE+njLC32DaHhCStbHkviHi3CudY7J4/H6ApXWLTMv9dL4g0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718890055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xg1ApPCQGVJ8CFcoKgcEnIVTe/xamtVzkM/qsLKXD5I=;
	b=kYKulGVlx4KNm/1UugWA0UyH9zJJ42qcEUSpUQ0rc4jDTnAjoiDyPqQziF44s66Dl9/boS
	4hXgsYHWDElnkNCg==
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
	David Ahern <dsahern@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	bpf@vger.kernel.org
Subject: [PATCH v9 net-next 12/15] seg6: Use nested-BH locking for seg6_bpf_srh_states.
Date: Thu, 20 Jun 2024 15:22:02 +0200
Message-ID: <20240620132727.660738-13-bigeasy@linutronix.de>
In-Reply-To: <20240620132727.660738-1-bigeasy@linutronix.de>
References: <20240620132727.660738-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The access to seg6_bpf_srh_states is protected by disabling preemption.
Based on the code, the entry point is input_action_end_bpf() and
every other function (the bpf helper functions bpf_lwt_seg6_*()), that
is accessing seg6_bpf_srh_states, should be called from within
input_action_end_bpf().

input_action_end_bpf() accesses seg6_bpf_srh_states first at the top of
the function and then disables preemption. This looks wrong because if
preemption needs to be disabled as part of the locking mechanism then
the variable shouldn't be accessed beforehand.

Looking at how it is used via test_lwt_seg6local.sh then
input_action_end_bpf() is always invoked from softirq context. If this
is always the case then the preempt_disable() statement is superfluous.
If this is not always invoked from softirq then disabling only
preemption is not sufficient.

Replace the preempt_disable() statement with nested-BH locking. This is
not an equivalent replacement as it assumes that the invocation of
input_action_end_bpf() always occurs in softirq context and thus the
preempt_disable() is superfluous.
Add a local_lock_t the data structure and use local_lock_nested_bh() for
locking. Add lockdep_assert_held() to ensure the lock is held while the
per-CPU variable is referenced in the helper functions.

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: David Ahern <dsahern@kernel.org>
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
 include/net/seg6_local.h |  1 +
 net/core/filter.c        |  3 +++
 net/ipv6/seg6_local.c    | 22 ++++++++++++++--------
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/include/net/seg6_local.h b/include/net/seg6_local.h
index 3fab9dec2ec45..888c1ce6f5272 100644
--- a/include/net/seg6_local.h
+++ b/include/net/seg6_local.h
@@ -19,6 +19,7 @@ extern int seg6_lookup_nexthop(struct sk_buff *skb, struc=
t in6_addr *nhaddr,
 extern bool seg6_bpf_has_valid_srh(struct sk_buff *skb);
=20
 struct seg6_bpf_srh_state {
+	local_lock_t bh_lock;
 	struct ipv6_sr_hdr *srh;
 	u16 hdrlen;
 	bool valid;
diff --git a/net/core/filter.c b/net/core/filter.c
index 7c46ecba3b01b..ba1a739a9bedc 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6450,6 +6450,7 @@ BPF_CALL_4(bpf_lwt_seg6_store_bytes, struct sk_buff *=
, skb, u32, offset,
 	void *srh_tlvs, *srh_end, *ptr;
 	int srhoff =3D 0;
=20
+	lockdep_assert_held(&srh_state->bh_lock);
 	if (srh =3D=3D NULL)
 		return -EINVAL;
=20
@@ -6506,6 +6507,7 @@ BPF_CALL_4(bpf_lwt_seg6_action, struct sk_buff *, skb,
 	int hdroff =3D 0;
 	int err;
=20
+	lockdep_assert_held(&srh_state->bh_lock);
 	switch (action) {
 	case SEG6_LOCAL_ACTION_END_X:
 		if (!seg6_bpf_has_valid_srh(skb))
@@ -6582,6 +6584,7 @@ BPF_CALL_3(bpf_lwt_seg6_adjust_srh, struct sk_buff *,=
 skb, u32, offset,
 	int srhoff =3D 0;
 	int ret;
=20
+	lockdep_assert_held(&srh_state->bh_lock);
 	if (unlikely(srh =3D=3D NULL))
 		return -EINVAL;
=20
diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index 24e2b4b494cb0..c4828c6620f07 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -1380,7 +1380,9 @@ static int input_action_end_b6_encap(struct sk_buff *=
skb,
 	return err;
 }
=20
-DEFINE_PER_CPU(struct seg6_bpf_srh_state, seg6_bpf_srh_states);
+DEFINE_PER_CPU(struct seg6_bpf_srh_state, seg6_bpf_srh_states) =3D {
+	.bh_lock	=3D INIT_LOCAL_LOCK(bh_lock),
+};
=20
 bool seg6_bpf_has_valid_srh(struct sk_buff *skb)
 {
@@ -1388,6 +1390,7 @@ bool seg6_bpf_has_valid_srh(struct sk_buff *skb)
 		this_cpu_ptr(&seg6_bpf_srh_states);
 	struct ipv6_sr_hdr *srh =3D srh_state->srh;
=20
+	lockdep_assert_held(&srh_state->bh_lock);
 	if (unlikely(srh =3D=3D NULL))
 		return false;
=20
@@ -1408,8 +1411,7 @@ bool seg6_bpf_has_valid_srh(struct sk_buff *skb)
 static int input_action_end_bpf(struct sk_buff *skb,
 				struct seg6_local_lwt *slwt)
 {
-	struct seg6_bpf_srh_state *srh_state =3D
-		this_cpu_ptr(&seg6_bpf_srh_states);
+	struct seg6_bpf_srh_state *srh_state;
 	struct ipv6_sr_hdr *srh;
 	int ret;
=20
@@ -1420,10 +1422,14 @@ static int input_action_end_bpf(struct sk_buff *skb,
 	}
 	advance_nextseg(srh, &ipv6_hdr(skb)->daddr);
=20
-	/* preempt_disable is needed to protect the per-CPU buffer srh_state,
-	 * which is also accessed by the bpf_lwt_seg6_* helpers
+	/* The access to the per-CPU buffer srh_state is protected by running
+	 * always in softirq context (with disabled BH). On PREEMPT_RT the
+	 * required locking is provided by the following local_lock_nested_bh()
+	 * statement. It is also accessed by the bpf_lwt_seg6_* helpers via
+	 * bpf_prog_run_save_cb().
 	 */
-	preempt_disable();
+	local_lock_nested_bh(&seg6_bpf_srh_states.bh_lock);
+	srh_state =3D this_cpu_ptr(&seg6_bpf_srh_states);
 	srh_state->srh =3D srh;
 	srh_state->hdrlen =3D srh->hdrlen << 3;
 	srh_state->valid =3D true;
@@ -1446,15 +1452,15 @@ static int input_action_end_bpf(struct sk_buff *skb,
=20
 	if (srh_state->srh && !seg6_bpf_has_valid_srh(skb))
 		goto drop;
+	local_unlock_nested_bh(&seg6_bpf_srh_states.bh_lock);
=20
-	preempt_enable();
 	if (ret !=3D BPF_REDIRECT)
 		seg6_lookup_nexthop(skb, NULL, 0);
=20
 	return dst_input(skb);
=20
 drop:
-	preempt_enable();
+	local_unlock_nested_bh(&seg6_bpf_srh_states.bh_lock);
 	kfree_skb(skb);
 	return -EINVAL;
 }
--=20
2.45.2


