Return-Path: <bpf+bounces-18019-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1778D814E28
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 18:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EA751C23F82
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 17:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E25C563A1;
	Fri, 15 Dec 2023 17:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HqagrAq6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5EEtusZ0"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59EF4654A;
	Fri, 15 Dec 2023 17:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702660237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CX4pb+3godYGbYL2L5DP5LSVnm+uYrRc03oRZsT6xW0=;
	b=HqagrAq65uQAIAobjbUr4Dx14XchauBivPibNfYj2mQ5AwLbO3ALFUn+JieHhkpzNkVpsa
	wxETScLpeyAo5czQVKHMZdSwWqVygfFhh9RwnF92sZu0e1qO3ZoDNEIeE2fq2DA5B56cqq
	CHExNwPEs/JMbQbOjTmCvjRFEOdDfxOcP+q3GFe3PdTnvZvKT5/8eF8IYcwaJOmaDhd2cs
	muBVpo1ENYqit4LqG7FAoxqsb0osvK99ozR6nykis0OTKU1Vj8weabfIgWmFEAUSrIWDrD
	56OzsB21LEdNLlC3ZvA1LH5pRn9/c12AvqybfYZaSw42a9Cm5gmZP7Vo/yCQbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702660237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CX4pb+3godYGbYL2L5DP5LSVnm+uYrRc03oRZsT6xW0=;
	b=5EEtusZ07Rc3a5s2wX4WniJ1XNm1V1gXAbqutydc+D/8XbjphtsbP1gqjDLuGNtmutCDRS
	qy1Kwlt1T/tt6kBA==
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
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	bpf@vger.kernel.org
Subject: [PATCH net-next 14/24] net: Add a lock which held during the redirect process.
Date: Fri, 15 Dec 2023 18:07:33 +0100
Message-ID: <20231215171020.687342-15-bigeasy@linutronix.de>
In-Reply-To: <20231215171020.687342-1-bigeasy@linutronix.de>
References: <20231215171020.687342-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The XDP redirect process is two staged:
- bpf_prog_run_xdp() is invoked to run a eBPF program which inspects the
  packet and makes decisions. While doing that, the per-CPU variable
  bpf_redirect_info is used.

- Afterwards xdp_do_redirect() is invoked and accesses bpf_redirect_info
  and it may also access other per-CPU variables like xskmap_flush_list.

At the very end of the NAPI callback, xdp_do_flush() is invoked which
does not access bpf_redirect_info but will touch the individual per-CPU
lists.

The per-CPU variables are only used in the NAPI callback hence disabling
bottom halves is the only protection mechanism. Users from preemptible
context (like cpu_map_kthread_run()) explicitly disable bottom halves
for protections reasons.
Without locking in local_bh_disable() on PREEMPT_RT this data structure
requires explicit locking.

Introduce redirect_lock as a lock to be acquired when access to these
per-CPU variables is performed. Usually the lock is part of the per-CPU
variable which is about to be protected but since there are a few
different per-CPU variables which need to be protected at the same
time (and some of the variables depend on a CONFIG setting) a new
per-CPU data structure with variable bpf_run_lock is used for this.

The lock is a nested-BH lock meaning that on non-PREEMPT_RT kernels this
simply results in a lockdep check and ensuring that bottom halves are
disabled. On PREEMPT_RT kernels this will provide the needed
synchronisation once local_bh_disable() does not act as per-CPU lock.

This patch introduces the bpf_run_lock.redirect_lock lock. It will be
used by drivers in the following patches.

A follow-up step could be to keep bpf_prog_run_xdp() and the
XDP_REDIRECT switch case (with xdp_do_redirect()) close together. That
would allow a single scoped_guard() macro to cover the two required
instaces that require locking instead the whole switch case.

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Hao Luo <haoluo@google.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>
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
 include/linux/bpf.h | 6 ++++++
 net/core/filter.c   | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index cff5bb08820ec..6912b85209b12 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -291,6 +291,12 @@ struct bpf_map {
 	s64 __percpu *elem_count;
 };
=20
+struct bpf_run_lock {
+	local_lock_t redirect_lock;
+};
+
+DECLARE_PER_CPU(struct bpf_run_lock, bpf_run_lock);
+
 static inline const char *btf_field_type_name(enum btf_field_type type)
 {
 	switch (type) {
diff --git a/net/core/filter.c b/net/core/filter.c
index 896aa3fa699f9..7c9653734fb60 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -89,6 +89,11 @@
 static const struct bpf_func_proto *
 bpf_sk_base_func_proto(enum bpf_func_id func_id);
=20
+DEFINE_PER_CPU(struct bpf_run_lock, bpf_run_lock) =3D {
+	.redirect_lock =3D INIT_LOCAL_LOCK(redirect_lock),
+};
+EXPORT_PER_CPU_SYMBOL_GPL(bpf_run_lock);
+
 int copy_bpf_fprog_from_user(struct sock_fprog *dst, sockptr_t src, int le=
n)
 {
 	if (in_compat_syscall()) {
--=20
2.43.0


