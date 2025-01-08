Return-Path: <bpf+bounces-48228-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF46A05651
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 10:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65BD81883B16
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 09:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DCF1FC7ED;
	Wed,  8 Jan 2025 09:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OlQxyPTc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pi0E5pkC"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307761F9420;
	Wed,  8 Jan 2025 09:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736327128; cv=none; b=gtO8456BIoKB8MfFGnXFgh/MD8pifedZY0NvLjdYPrwYs/WIPnYK4FJPi5+jXNaAW5WTV+ViM9KnFrXBBL3/d8oyEOZp4XMVnpjoCwrkoYBM8c1U35N1LaxztsAnQ25MCUwZQUWY/PKxxE7HOPUML3y5GJHu4vfS9kSrg/I/b5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736327128; c=relaxed/simple;
	bh=Rfno/WDBaQo6Megi5n9CLWuW+Sf5W7R4mY0Et7Ub/lI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WMYzjwuoNmJyU+XpLsWNpZx3IEhLvlOWTFKZBHJ37ZjreyakRmIM44cduHc2r3cty5PSKzvwgvxzKBzQ4J70wZP46KxEUb9WXBtII66UfeFR7pJgY94yy+TAVwzCqLBJN7SuxhLl+CBRV8nC3tJ0vh+n1hyrZP2+nXx1qc+GDcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OlQxyPTc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pi0E5pkC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736327124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aWZxQxOJaEGd9SElXjI4Z9tZyIiipQdtqCaCraspLAk=;
	b=OlQxyPTc4KXCBeZGT3TJa+bbkReub6yPnM2lqBeJYit76X+ZTMq2yA0QoY08+401skoxFX
	dYJ40n67dA+bywAEOToIEQlia/tRRCRY8AbYUF7kOK5dgWaih7fk9FejvNIjyGgDX/rkYS
	fZCnagS96iMzk5UG0V+o/n5m7OGktAptW2Uhze9UoCeKXif7Csjsohks9L1nt6Zi0Bi0uR
	Skw19b5vmyf7Fk/A6MPJM4Zs4OpVPjdt5+xI+/8/7gh5esgz0OslIDcPrgbTRWeDurLemF
	O9SxQ7WM65wZHD2m54kgPfWgHyupWGbr3mY+3/23khr8bWuCp8a6bkqx2y7Y9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736327124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aWZxQxOJaEGd9SElXjI4Z9tZyIiipQdtqCaCraspLAk=;
	b=Pi0E5pkCHo/POaYqtA2D8zPpOtGjm4FDBWb3u3Jd9uYvwb5+wePI0na9fXkwzIO4roKQ81
	vwjUMv0cYkSEvMDg==
To: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Gomez <da.gomez@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Steven Rostedt <rostedt@goodmis.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 25/28] bpf: Use RCU in all users of __module_text_address().
Date: Wed,  8 Jan 2025 10:04:54 +0100
Message-ID: <20250108090457.512198-26-bigeasy@linutronix.de>
In-Reply-To: <20250108090457.512198-1-bigeasy@linutronix.de>
References: <20250108090457.512198-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

__module_address() can be invoked within a RCU section, there is no
requirement to have preemption disabled.

Replace the preempt_disable() section around __module_address() with
RCU.

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Matt Bobrowski <mattbobrowski@google.com>
Cc: Song Liu <song@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/trace/bpf_trace.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 1b8db5aee9d38..020df7b6ff90c 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2336,10 +2336,9 @@ void bpf_put_raw_tracepoint(struct bpf_raw_event_map=
 *btp)
 {
 	struct module *mod;
=20
-	preempt_disable();
+	guard(rcu)();
 	mod =3D __module_address((unsigned long)btp);
 	module_put(mod);
-	preempt_enable();
 }
=20
 static __always_inline
@@ -2907,16 +2906,14 @@ static int get_modules_for_addrs(struct module ***m=
ods, unsigned long *addrs, u3
 	for (i =3D 0; i < addrs_cnt; i++) {
 		struct module *mod;
=20
-		preempt_disable();
-		mod =3D __module_address(addrs[i]);
-		/* Either no module or we it's already stored  */
-		if (!mod || has_module(&arr, mod)) {
-			preempt_enable();
-			continue;
+		scoped_guard(rcu) {
+			mod =3D __module_address(addrs[i]);
+			/* Either no module or we it's already stored  */
+			if (!mod || has_module(&arr, mod))
+				continue;
+			if (!try_module_get(mod))
+				err =3D -EINVAL;
 		}
-		if (!try_module_get(mod))
-			err =3D -EINVAL;
-		preempt_enable();
 		if (err)
 			break;
 		err =3D add_module(&arr, mod);
--=20
2.47.1


