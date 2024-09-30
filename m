Return-Path: <bpf+bounces-40601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 449F498ACDE
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 21:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5EE71F225AC
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 19:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D16C199958;
	Mon, 30 Sep 2024 19:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="WVM635kA"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CC619ABC3;
	Mon, 30 Sep 2024 19:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727724396; cv=none; b=VWhVdT+a1uTDtA//WDmjDXvvkccaKD0lIV4rbCBy8oByAl2I6wbZ79ppOKuPvW7vxmgZ1fd8oczK96tvtrveSpjTEqBGIjA1GnHKyPmATkqBtwIxkbW8T8TuZBKRKCE503NnsXG8k8ozgbigAMAwOaiFbfiq48s8l3t/a/0nmDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727724396; c=relaxed/simple;
	bh=iV8BNOEUAlVnHaxKIKuldZvcuyZQrIw4r05iL6v8clg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yco9UsUSmEu5qLJL7cyKjbQOVbId1QWX+exMYEndyghxMUsYtFCBnCEoJxC5vnWem0DhaEn8m0nUSnRhNsjFGt+deDnWZfiRwms19R12X/03E61ph3vZZy/+YPMA4Rv1NG3IHxawbzKOLbczXcAN0fw9vFZ6C3PQf1WcYO8l8Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=WVM635kA; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727724393;
	bh=iV8BNOEUAlVnHaxKIKuldZvcuyZQrIw4r05iL6v8clg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WVM635kA5GrnUEYPnE4b4+Us/P2YAOSfJs6BF99O+udp2iUMhyhxH8lDaujuFxjwZ
	 MdYoMDnDhSjHKgmMTnFIk54h0LoGPuyfVhBbg3wSWBqc2Pn2hKfHO7QQwGgRvAcai3
	 vUOe80mFpG4PZLH3pORXkvQ00Gqe5RkuOToRLmgEo/mbY+D2xTklpXOBHym/yvsiaa
	 dCM1WCWQLJSlBj9aLPK6DT1do1+zVI9qJbWfIay5kWNOQKiVpyy9wBebBZJtJ/Pj5D
	 76OWvxNyynMQfPOGhgL5s+IBL374uTAiSXD5DzibxwlC4xJJLbrG+TOMRvjQWN/fIF
	 Zugd00u+k6NZg==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XHWK52jRwzQgJ;
	Mon, 30 Sep 2024 15:26:33 -0400 (EDT)
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
	Andrii Nakryiko <andrii@kernel.org>,
	Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH resend 8/8] tracing/bpf: Add might_fault check to syscall probes
Date: Mon, 30 Sep 2024 15:23:57 -0400
Message-Id: <20240930192357.1154417-9-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240930192357.1154417-1-mathieu.desnoyers@efficios.com>
References: <20240930192357.1154417-1-mathieu.desnoyers@efficios.com>
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
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Tested-by: Andrii Nakryiko <andrii@kernel.org> # BPF parts
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


