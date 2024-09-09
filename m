Return-Path: <bpf+bounces-39354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4163972378
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 22:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 643FF2884D6
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 20:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D862E18C030;
	Mon,  9 Sep 2024 20:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="oFRABRR0"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BB918A949;
	Mon,  9 Sep 2024 20:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725913041; cv=none; b=MWqEf895b4NfgZ41ZwMa8pdIS0P3xCYbLXV4JJ41zqWUyglC1K3Uvuzy2KxzxjSDnCHhEHpKm59u04AI3wVUgn1Ph4ds7KvcfVBFbtyWZVpVkwPS6Ha4kq1EM4NEk6zks8E1Stvupo+cejumKHMYGwAcRFO9SI/9eT8xC//pILk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725913041; c=relaxed/simple;
	bh=5w5atC/L2ENxXyVQRtgR6s4glzcuw7sYXRIo0prEmhc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d1ZUJ8X5DWpWowOJ7Vkio6+HRpIP9nYIQsMuZHZlkOzWfEdNQVjFEKkPyBj9kaLB8EiT5jOJ3MFAwzYyAMeh5bbkKEHv79u5o65G9V2avD8AFfYdUhPyrBFZ5rdiMhZP9gtkB3a5LVjyOv5zg0dbCCKeqN01CJrAZteFrx7NMZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=oFRABRR0; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1725913038;
	bh=5w5atC/L2ENxXyVQRtgR6s4glzcuw7sYXRIo0prEmhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oFRABRR0Xuxpf1DM28exZ+a9fqhCTt0grXZL9/gPRSA3Gv+WVM0ve4eSeipFFMYjO
	 S4n41aya4Nl00Yl8G5pgNkvYn8oj+GixaVsMMCDhlt3IYpvyJ/ESONgy/6YPRHpxW9
	 ZgyUHnl6nWnKBlHj9Wmh3UhhKwxSOXpHdbv2QJMvpyNMV1O4YqFN4AIRHUqkCP2cQc
	 NQG6aN+FxrrsPj6PlEsZAGT4C78HPrOw8Drpckj4AJ5WgOo2vlf/obIuihGVGARPLJ
	 byIBwqXT5BNlCcxT88EUuBeDMKKeehYcC+WxFCOxEe5iLzgTcW23tuhosVfcaWdF69
	 BQJMgwhRGtmHw==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4X2dRL0vTVz1KwG;
	Mon,  9 Sep 2024 16:17:18 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	bpf@vger.kernel.org,
	Joel Fernandes <joel@joelfernandes.org>,
	linux-trace-kernel@vger.kernel.org,
	Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH 8/8] tracing/bpf: Add might_fault check to syscall probes
Date: Mon,  9 Sep 2024 16:16:52 -0400
Message-Id: <20240909201652.319406-9-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240909201652.319406-1-mathieu.desnoyers@efficios.com>
References: <20240909201652.319406-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a might_fault() check to validate that the bpf sys_enter/sys_exit
probe callbacks are indeed called from a context where page faults can
be handled.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Michael Jeanson <mjeanson@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Yonghong Song <yhs@fb.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org
Cc: Joel Fernandes <joel@joelfernandes.org>
---
 include/trace/bpf_probe.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
index 211b98d45fc6..099df5c3e38a 100644
--- a/include/trace/bpf_probe.h
+++ b/include/trace/bpf_probe.h
@@ -57,6 +57,7 @@ __bpf_trace_##call(void *__data, proto)					\
 static notrace void							\
 __bpf_trace_##call(void *__data, proto)					\
 {									\
+	might_fault();							\
 	guard(preempt_notrace)();					\
 	CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data, CAST_TO_U64(args));	\
 }
-- 
2.39.2


