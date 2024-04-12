Return-Path: <bpf+bounces-26599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 422CB8A2361
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 03:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 643551C213C8
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 01:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE19524C;
	Fri, 12 Apr 2024 01:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="FQ3BuQZb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120C5DF58
	for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 01:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712886648; cv=none; b=mr4DSjoq2HLnCFs1CRYliaBhLcPzC0Zbay1GMUqwkNK1fdNgjhVR2O/S6GJECkq+X3b8/PGu4iMQaWnGrsVl4JTuUZ1oOFb8KB2TLxbl+3arTH3voVJVvB0+xZNmBgYzTIH5DX5wAoB3hC3BSGXex3iwZ1UVrcbRfZmVv+G0d/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712886648; c=relaxed/simple;
	bh=lLcJXMGYAt18ckXzjBJt3RZcIlon0AJDakZC8+N8M0M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r5kY52Snju41gC8fmzL8a59Zwd3U0MGd3pawRavC3EOmRijSayx3xdhOLgLaj+SAbC0Op0KprhVq+2Nodj2vGLCzI3s/CWDbl1/WPBxDcDZxKKrJO90ifsqwfyereQBTDOB0nmUB8eg+8iXCU04Wd19MZcygSTFZqAZE/GdhaZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=FQ3BuQZb; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-78ec78c4fceso56190785a.0
        for <bpf@vger.kernel.org>; Thu, 11 Apr 2024 18:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1712886646; x=1713491446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2I8ioTIE3St0NCO304/67c5ZZcTg34djE+ltGa2DGgk=;
        b=FQ3BuQZb8LtOhmt890Bmeq2fPTjqyrHlVC00FaR2K+bSiNS5ffhWMIBCbKqWbCoF9a
         yTKEojGuNSBLHgeauasteqnUs7ZXlVqVebsjOuOToLwj2QxBsBLCTIrm1YgnQ4ZdptSY
         Kn0JB14JBHBz64zM4H39qMyt7yft6iJNslfW7EP1u006R86EdrKnRdvwl1GqckKj6Ie2
         bmgYnPNGoRRPQnX0i07qpCzGA/iBz/eNkYm2z65qVVDMY6G7ohPS6eRhxyOMeMtXrw90
         /p4V0rsU/WxnRWomdyk0/CjfkbhOjQ+wcY/Gtshn6HRziwKWDkEIHi6FpxzvGm7vATrB
         pbfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712886646; x=1713491446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2I8ioTIE3St0NCO304/67c5ZZcTg34djE+ltGa2DGgk=;
        b=bcW8NlyH6M5MJRK8ht3GWnB30IlG3A4NWYL7qPmp/XOfWeL3APQGbui96qljxQ40kQ
         YkhVjhlPLTmldYjyn8GaUEY+w3Qqxd4k3BU09sfFb5sviclJz9qWeLh9CEb/z+/vPcJp
         ePJCl5N4RdsU5yxsbzjw+B4TYLKoDUykSBclKhRvH5mt0gVD8UwgUNk7omaPXRk2uPye
         bvJYenaivTk0jIULfl++szUWqjs/YoJr4o+puRYyF/HguUeVnzrXFGSfMThnkwAtPlqL
         zC5ggQpkbUwf9cpgZ1jp4jcMD/nWcnYeznbs6W23FL+97upwrqWu+Ej+Qhgj7x+FHVTW
         T6Cw==
X-Forwarded-Encrypted: i=1; AJvYcCXBIGKo2kAmVV9oJHddDvXHeeZTH5RXbmiY7KU8lqX2nT7s22+ZfmKYjhxFY5HUPyGaL45UTc6i6NlClkH/d9wHhEyK
X-Gm-Message-State: AOJu0YxTZCSPscbaRNV4M6whKhOreMj9YZphGj36KguA2nox3mRd6zSN
	I6BxBgEUMk3ww4MeqtAcmK2CFEj4nW0IIxoBAbreow/1y+n0rBz7sdI1WKbUUQ==
X-Google-Smtp-Source: AGHT+IEpPEvWFpAFcQSe+VQV8imp3rgz2Yo/hr1w0rVz+GPtikTxqKZX7MSio59IOMcIrmeqvbBuxg==
X-Received: by 2002:a05:620a:4589:b0:78e:b996:db93 with SMTP id bp9-20020a05620a458900b0078eb996db93mr3057028qkb.3.1712886646096;
        Thu, 11 Apr 2024 18:50:46 -0700 (PDT)
Received: from ip-172-31-44-15.us-east-2.compute.internal (ec2-52-15-100-147.us-east-2.compute.amazonaws.com. [52.15.100.147])
        by smtp.googlemail.com with ESMTPSA id f10-20020a05620a15aa00b0078d76c1178esm1756677qkk.119.2024.04.11.18.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 18:50:45 -0700 (PDT)
From: Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To: Kyle Huey <khuey@kylehuey.com>,
	linux-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Marco Elver <elver@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Robert O'Callahan <robert@ocallahan.org>,
	bpf@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v6 1/7] perf/bpf: Reorder bpf_overflow_handler() ahead of __perf_event_overflow()
Date: Thu, 11 Apr 2024 18:50:13 -0700
Message-Id: <20240412015019.7060-2-khuey@kylehuey.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412015019.7060-1-khuey@kylehuey.com>
References: <20240412015019.7060-1-khuey@kylehuey.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will allow __perf_event_overflow() to call bpf_overflow_handler().

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
---
 kernel/events/core.c | 183 ++++++++++++++++++++++---------------------
 1 file changed, 92 insertions(+), 91 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 724e6d7e128f..ee025125a681 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9544,6 +9544,98 @@ static inline bool sample_is_allowed(struct perf_event *event, struct pt_regs *r
 	return true;
 }
 
+#ifdef CONFIG_BPF_SYSCALL
+static void bpf_overflow_handler(struct perf_event *event,
+				 struct perf_sample_data *data,
+				 struct pt_regs *regs)
+{
+	struct bpf_perf_event_data_kern ctx = {
+		.data = data,
+		.event = event,
+	};
+	struct bpf_prog *prog;
+	int ret = 0;
+
+	ctx.regs = perf_arch_bpf_user_pt_regs(regs);
+	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1))
+		goto out;
+	rcu_read_lock();
+	prog = READ_ONCE(event->prog);
+	if (prog) {
+		perf_prepare_sample(data, event, regs);
+		ret = bpf_prog_run(prog, &ctx);
+	}
+	rcu_read_unlock();
+out:
+	__this_cpu_dec(bpf_prog_active);
+	if (!ret)
+		return;
+
+	event->orig_overflow_handler(event, data, regs);
+}
+
+static int perf_event_set_bpf_handler(struct perf_event *event,
+				      struct bpf_prog *prog,
+				      u64 bpf_cookie)
+{
+	if (event->overflow_handler_context)
+		/* hw breakpoint or kernel counter */
+		return -EINVAL;
+
+	if (event->prog)
+		return -EEXIST;
+
+	if (prog->type != BPF_PROG_TYPE_PERF_EVENT)
+		return -EINVAL;
+
+	if (event->attr.precise_ip &&
+	    prog->call_get_stack &&
+	    (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN) ||
+	     event->attr.exclude_callchain_kernel ||
+	     event->attr.exclude_callchain_user)) {
+		/*
+		 * On perf_event with precise_ip, calling bpf_get_stack()
+		 * may trigger unwinder warnings and occasional crashes.
+		 * bpf_get_[stack|stackid] works around this issue by using
+		 * callchain attached to perf_sample_data. If the
+		 * perf_event does not full (kernel and user) callchain
+		 * attached to perf_sample_data, do not allow attaching BPF
+		 * program that calls bpf_get_[stack|stackid].
+		 */
+		return -EPROTO;
+	}
+
+	event->prog = prog;
+	event->bpf_cookie = bpf_cookie;
+	event->orig_overflow_handler = READ_ONCE(event->overflow_handler);
+	WRITE_ONCE(event->overflow_handler, bpf_overflow_handler);
+	return 0;
+}
+
+static void perf_event_free_bpf_handler(struct perf_event *event)
+{
+	struct bpf_prog *prog = event->prog;
+
+	if (!prog)
+		return;
+
+	WRITE_ONCE(event->overflow_handler, event->orig_overflow_handler);
+	event->prog = NULL;
+	bpf_prog_put(prog);
+}
+#else
+static int perf_event_set_bpf_handler(struct perf_event *event,
+				      struct bpf_prog *prog,
+				      u64 bpf_cookie)
+{
+	return -EOPNOTSUPP;
+}
+
+static void perf_event_free_bpf_handler(struct perf_event *event)
+{
+}
+#endif
+
 /*
  * Generic event overflow handling, sampling.
  */
@@ -10422,97 +10514,6 @@ static void perf_event_free_filter(struct perf_event *event)
 	ftrace_profile_free_filter(event);
 }
 
-#ifdef CONFIG_BPF_SYSCALL
-static void bpf_overflow_handler(struct perf_event *event,
-				 struct perf_sample_data *data,
-				 struct pt_regs *regs)
-{
-	struct bpf_perf_event_data_kern ctx = {
-		.data = data,
-		.event = event,
-	};
-	struct bpf_prog *prog;
-	int ret = 0;
-
-	ctx.regs = perf_arch_bpf_user_pt_regs(regs);
-	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1))
-		goto out;
-	rcu_read_lock();
-	prog = READ_ONCE(event->prog);
-	if (prog) {
-		perf_prepare_sample(data, event, regs);
-		ret = bpf_prog_run(prog, &ctx);
-	}
-	rcu_read_unlock();
-out:
-	__this_cpu_dec(bpf_prog_active);
-	if (!ret)
-		return;
-
-	event->orig_overflow_handler(event, data, regs);
-}
-
-static int perf_event_set_bpf_handler(struct perf_event *event,
-				      struct bpf_prog *prog,
-				      u64 bpf_cookie)
-{
-	if (event->overflow_handler_context)
-		/* hw breakpoint or kernel counter */
-		return -EINVAL;
-
-	if (event->prog)
-		return -EEXIST;
-
-	if (prog->type != BPF_PROG_TYPE_PERF_EVENT)
-		return -EINVAL;
-
-	if (event->attr.precise_ip &&
-	    prog->call_get_stack &&
-	    (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN) ||
-	     event->attr.exclude_callchain_kernel ||
-	     event->attr.exclude_callchain_user)) {
-		/*
-		 * On perf_event with precise_ip, calling bpf_get_stack()
-		 * may trigger unwinder warnings and occasional crashes.
-		 * bpf_get_[stack|stackid] works around this issue by using
-		 * callchain attached to perf_sample_data. If the
-		 * perf_event does not full (kernel and user) callchain
-		 * attached to perf_sample_data, do not allow attaching BPF
-		 * program that calls bpf_get_[stack|stackid].
-		 */
-		return -EPROTO;
-	}
-
-	event->prog = prog;
-	event->bpf_cookie = bpf_cookie;
-	event->orig_overflow_handler = READ_ONCE(event->overflow_handler);
-	WRITE_ONCE(event->overflow_handler, bpf_overflow_handler);
-	return 0;
-}
-
-static void perf_event_free_bpf_handler(struct perf_event *event)
-{
-	struct bpf_prog *prog = event->prog;
-
-	if (!prog)
-		return;
-
-	WRITE_ONCE(event->overflow_handler, event->orig_overflow_handler);
-	event->prog = NULL;
-	bpf_prog_put(prog);
-}
-#else
-static int perf_event_set_bpf_handler(struct perf_event *event,
-				      struct bpf_prog *prog,
-				      u64 bpf_cookie)
-{
-	return -EOPNOTSUPP;
-}
-static void perf_event_free_bpf_handler(struct perf_event *event)
-{
-}
-#endif
-
 /*
  * returns true if the event is a tracepoint, or a kprobe/upprobe created
  * with perf_event_open()
-- 
2.34.1


