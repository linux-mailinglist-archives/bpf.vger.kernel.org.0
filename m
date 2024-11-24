Return-Path: <bpf+bounces-45554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4B99D7936
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 00:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B7E9B22E80
	for <lists+bpf@lfdr.de>; Sun, 24 Nov 2024 23:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B3918C92F;
	Sun, 24 Nov 2024 23:49:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5301718873F;
	Sun, 24 Nov 2024 23:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732492173; cv=none; b=hU25NrVNWiobV0hltE4uhiWxr8fbwFhgqa5m0A29mYFxT/ScbjSqR87mHEGBPArCMkLWvmuC0dQAlUQqdslC4g3qwWkIkz+w/WSkesCG3vxrYDjB7hHMU+f4fQrPkFSjwLuanXjFEpNwqUJj0QoNt4/6b43Sg/hOqHNc26Yo/NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732492173; c=relaxed/simple;
	bh=uvmRKB6hMrxNIblTFCPkCu7S+gNjAWEdtf0pOA/AyAY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ar4ptmeO0rl0sQ0oDvRVPJBkVu1tqDU6ZB1DSJZS+BrNlIQ/2wUZR5gawtI8vuARYF8dqoBCh1FS6HVc6i5J/xr1Tw2n4WC9Q36Ye2fCT+tBvZrzhz3UlgbVLAQFfRMBrJEbxYb4UiX0WB4MAaITOtn7JvmhuCBFLb3vWJmZeyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2463C4CEDD;
	Sun, 24 Nov 2024 23:49:32 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tFMMt-00000006vk9-0MAP;
	Sun, 24 Nov 2024 18:50:19 -0500
Message-ID: <20241124235018.937057267@goodmis.org>
User-Agent: quilt/0.68
Date: Sun, 24 Nov 2024 18:49:43 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Michael Jeanson <mjeanson@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Namhyung Kim <namhyung@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 bpf@vger.kernel.org,
 Joel Fernandes <joel@joelfernandes.org>,
 Jordan Rife <jrife@google.com>
Subject: [for-next][PATCH 3/6] tracing: Remove __idx variable from __DO_TRACE
References: <20241124234940.017394686@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Since the removal of SRCU-protected tracepoints, the __idx variable in
__DO_TRACE is unused. Remove this variable.

Fixes: 48bcda684823 ("tracing: Remove definition of trace_*_rcuidle()")
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Michael Jeanson <mjeanson@efficios.com>
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
Cc: Jordan Rife <jrife@google.com>
Link: https://lore.kernel.org/20241123153031.2884933-3-mathieu.desnoyers@efficios.com
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/tracepoint.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index d390e8cabf02..867f3c1ac7dc 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -218,8 +218,6 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
  */
 #define __DO_TRACE(name, args, cond, syscall)				\
 	do {								\
-		int __maybe_unused __idx = 0;				\
-									\
 		if (!(cond))						\
 			return;						\
 									\
-- 
2.45.2



