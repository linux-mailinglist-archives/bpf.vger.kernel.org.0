Return-Path: <bpf+bounces-47457-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A68A69F994F
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 19:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68A1B18881DE
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 18:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1449D231CB0;
	Fri, 20 Dec 2024 17:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D9ahDB8R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eeW9haKq"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6D7228C87;
	Fri, 20 Dec 2024 17:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734716870; cv=none; b=uNSAzK9P9Z3feeYMLX2XXluL3k1ONQq5LXjnJBBdcauW4NmZYNKDs9uNdwZXtJV5LQTd2ELBQcHo51QFWm6jGYkcqGMcXtOFlsORjognVeQEwMuxOPS7mHmctlAbO0dlUV0m/Gwk9KN44cbANWjP6JT7xDdlRV15xAKGQ9QEqLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734716870; c=relaxed/simple;
	bh=wT1uBpL1/SaJ4hNyMwwXG5byQc1hQ2W8jUnWEH+nwtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/VwdXURULv5F7UEaCTIjoSRFfPbD0gCWwIiPgujIH7zcIfJRQGBP9rm/lza3mSt9CAMQWdIdIOwzCf6SCRhtedJNWJev7dEPizmNkClWOQSw0TViil960aWZrhh8hm/x+5HdK9ls8f3PmQ0J4j01PRttX6ZCamqxfcc8EzcyxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D9ahDB8R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eeW9haKq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734716866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kG1v1wu3D3TuS8vhLDHRaF7dmu7B/vJ02VdgW4EZUoE=;
	b=D9ahDB8RXZP0FtEdc1K/ru4TjyLny1CvEWUccj/8qDL3JOmdQaKnqUfVD+5Zf0NP14XOT8
	+eZxOXzNIomH4vyUH6d44nxYhI9Tnx2s+fjaxsPcggMHo9qLDKNgRq+CeHKYvmZsHLdOPF
	Lb/lnZI2q8y/5ia53tHAYCkzI3WCK1ZwJ5yj11d5ejhwHCoJ4vid/pBXEnpVC7R+hRZX7s
	Luz0K3hLjrUdbXIyFPsl3KxB9Zts77Mt+5pn43WXjGRppaMGptPmPplypEE6R5iVcHIpQ7
	/OPg0nGDhabIy9XwWkOESpRLMsFqRH2qhMn5fhfFV2qD/micRXTaG6Xo0btN8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734716866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kG1v1wu3D3TuS8vhLDHRaF7dmu7B/vJ02VdgW4EZUoE=;
	b=eeW9haKq3KowFdehTfjJFroB4yIBxuCgvJQQ+lUIH+tMDD5bZ+6Vyrs8xQNLbZj+YfH9cM
	45VM35EtlGj7qmBg==
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
Subject: [PATCH v2 24/28] bpf: Use RCU in all users of __module_text_address().
Date: Fri, 20 Dec 2024 18:41:38 +0100
Message-ID: <20241220174731.514432-25-bigeasy@linutronix.de>
In-Reply-To: <20241220174731.514432-1-bigeasy@linutronix.de>
References: <20241220174731.514432-1-bigeasy@linutronix.de>
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
2.45.2


