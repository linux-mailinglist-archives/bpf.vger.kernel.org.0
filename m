Return-Path: <bpf+bounces-50025-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7113A21944
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 09:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39599188715C
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 08:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D831A262A;
	Wed, 29 Jan 2025 08:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DkQ2RiM7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zsx3Trl7"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88DF2D627;
	Wed, 29 Jan 2025 08:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738140476; cv=none; b=qTtbmSHHbdYg1GmjimQaKlDM4SqSp2X7y9/RroCAL4UhOCL0EuVYI7VQKeUgGKFr/4YeeTLiDfxC3ZrPvpZmVCKm1iOLKSLOo38+UWVAH/TO1/5w90tC18XqBxam7devQTQbNfCtMU4jVh7znQDY0qc3XxfSZtDw/rqhk+I7Cto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738140476; c=relaxed/simple;
	bh=IRSYsnFTl7GoJrzCtumS87btxucbhXtd4YE2R0MqWwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMgp6551FLjVYtpgjyJ1qs3sIJsBxAgUcaJm3RF/kUQeQtu8XWcYHLLZ/+1inaO6ibfljmRnKqQ5aZ+YR+xH/QSQkvRqBG3MSxgtpetUs+SxEL9qZP/Dw8ILtlYKRxW5eN2p+Q3O4itbwsZI5XNS7QJvTeVWRQKr1obwGpBp+44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DkQ2RiM7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zsx3Trl7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Jan 2025 09:47:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738140473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ksEbIYmixQ1riVYIMLfOM0Bq27Mu3VzLFkEyv4A1JMI=;
	b=DkQ2RiM7VSLwAjmNtu4+jvU9jzzhb/S1miMl0+tE+SRj4pMPnS9N5AVs5yT7um75MFEEnh
	ErRP6z2obh1gkfZUSZzgBMD4oDAkKXhDz+x+w74bgcU6H1MV6DQ3Ss5E/zjqGNcekpbmF6
	7LYqjvD5YMutYQ2g95L+g4PY5b48W1cVogwbZvG1v6tbb7UHlYBgWI0gGXQr6eyEChPUov
	6x+w+pTZdi7An0OdHaAhTH6TJz/8lDWDmVq8f2uW6X3VtNgyynjESd39anTijK3IVGAZL2
	insmXgaMjO/ePMt/Y8rbZjKsEikE9PiwjBLQWZSOVSXyIuYqYFXqEc/IhDN4bQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738140473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ksEbIYmixQ1riVYIMLfOM0Bq27Mu3VzLFkEyv4A1JMI=;
	b=zsx3Trl7xAMFkt/jBr9+KNuIqR553V9Aui8t1Eor0XOsU3j8o7oiiLYWgY0xtpHqSSsU0E
	gSurOZXoerJuoODw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: linux-modules@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Daniel Gomez <da.gomez@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Steven Rostedt <rostedt@goodmis.org>,
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: [PATCH v3.5 25/28] bpf: Use RCU in all users of
 __module_text_address().
Message-ID: <20250129084751.tH6iidUO@linutronix.de>
References: <20250108090457.512198-1-bigeasy@linutronix.de>
 <20250108090457.512198-26-bigeasy@linutronix.de>
 <CAADnVQJPf9N1THd4DXbOC=UthYvaPmOm5xQD2rcFunGXp6h5_g@mail.gmail.com>
 <20250109205440.J5EYqOuu@linutronix.de>
 <CAADnVQKOB0AB+VGuO5aG6LCMdfkEp3ACyDmqkX0fk9nFNeUmDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAADnVQKOB0AB+VGuO5aG6LCMdfkEp3ACyDmqkX0fk9nFNeUmDw@mail.gmail.com>

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
Acked-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

The previous version was broken in terms that the break statement broke
out of the scoped_guard loop and added something to the list. This is
now fixed by adding the "skip_add" bool.
While at it, I updated the comment by removing the "we".

 kernel/trace/bpf_trace.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index adc947587eb81..e6a17a60d8787 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2345,10 +2345,9 @@ void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp)
 {
 	struct module *mod;
 
-	preempt_disable();
+	guard(rcu)();
 	mod = __module_address((unsigned long)btp);
 	module_put(mod);
-	preempt_enable();
 }
 
 static __always_inline
@@ -2932,18 +2931,21 @@ static int get_modules_for_addrs(struct module ***mods, unsigned long *addrs, u3
 	u32 i, err = 0;
 
 	for (i = 0; i < addrs_cnt; i++) {
+		bool skip_add = false;
 		struct module *mod;
 
-		preempt_disable();
-		mod = __module_address(addrs[i]);
-		/* Either no module or we it's already stored  */
-		if (!mod || has_module(&arr, mod)) {
-			preempt_enable();
-			continue;
+		scoped_guard(rcu) {
+			mod = __module_address(addrs[i]);
+			/* Either no module or it's already stored  */
+			if (!mod || has_module(&arr, mod)) {
+				skip_add = true;
+				break; /* scoped_guard */
+			}
+			if (!try_module_get(mod))
+				err = -EINVAL;
 		}
-		if (!try_module_get(mod))
-			err = -EINVAL;
-		preempt_enable();
+		if (skip_add)
+			continue;
 		if (err)
 			break;
 		err = add_module(&arr, mod);
-- 
2.47.2


