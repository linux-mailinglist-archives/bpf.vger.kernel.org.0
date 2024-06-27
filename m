Return-Path: <bpf+bounces-33260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EBD91AB14
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 17:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41478B25A8A
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 15:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE57198E84;
	Thu, 27 Jun 2024 15:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="WVApRjuN"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E845D198A32;
	Thu, 27 Jun 2024 15:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719501791; cv=none; b=eF3XYtM0zVMS5s+4UcBdw2Q0Wx8D9qednqmXPD5H92sbxzPK72yXbSDrLv8GECAYhdkYPyqmzdSYdNusYHADRfW5jzjaOyck8nh3fDkP7+CBn1QjsYjCxD4ZKOede89fcdeaacqL+sUOvi7XewSAJpVxo1xYTZQJn5xLA+a8SZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719501791; c=relaxed/simple;
	bh=yP+LIbKJrOeA3BYfx1Pv/DUs/vsdWYAxVDdeHfKVSFk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=scQyhGOkeOLY/aDbZZ/cv8vsJBa1bDBwCIXxcfvQABJdw0Xg5po1zbTz64dzdL6X2asMzAIvLw28kzX3eeLgARGojHcucKRDYoycRkaA8j/FoyL4Js4Cd04Z9OLte7cuUbGQ6ihFJC2Or26uOPWBkHvn0jnoi9Ltx2OT5E2qtrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=WVApRjuN; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1719501788;
	bh=yP+LIbKJrOeA3BYfx1Pv/DUs/vsdWYAxVDdeHfKVSFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WVApRjuNzI7mkNMOWnZzOrNyniOnx7SHsAPSLjnD/kUAyGAckoDv5e93toQ7Do2ct
	 P2QUAyL+f/TNNFAJD0VICh7oKUc/wq64fX3N/sXX+dDS7R5P/+WCtOUZ6nQw1CgTW4
	 XyfmTWmo/soO9g96hwGCKECoM/xze+OvdkLOyln6pivOED+arCqCv8zb/ceamOGCIk
	 LYhDQMmT0Rq5tQWT6MlmxI4JvSg1apHF9oNrwDMm4NclYsHY3Jb1rl5lnisWGdxv81
	 pK/Y/YlMFUJ7B9KfCEgkauA+1Hpql7dNKqm7SRQgYqGxtxXnQJe4FnpQL9FrsJUZXj
	 kD7Og+DXghl6A==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4W92Q41Zmhz17dF;
	Thu, 27 Jun 2024 11:23:08 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	bpf@vger.kernel.org,
	Joel Fernandes <joel@joelfernandes.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v5 1/8] cleanup.h: Header include guard should match header name
Date: Thu, 27 Jun 2024 11:23:33 -0400
Message-Id: <20240627152340.82413-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240627152340.82413-1-mathieu.desnoyers@efficios.com>
References: <20240627152340.82413-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The include guard should match the header name. Rename __LINUX_GUARDS_H
to __LINUX_CLEANUP_H.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
---
 include/linux/cleanup.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index c2d09bc4f976..4cf8ad5d27a3 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __LINUX_GUARDS_H
-#define __LINUX_GUARDS_H
+#ifndef __LINUX_CLEANUP_H
+#define __LINUX_CLEANUP_H
 
 #include <linux/compiler.h>
 
@@ -247,4 +247,4 @@ __DEFINE_LOCK_GUARD_0(_name, _lock)
 	{ return class_##_name##_lock_ptr(_T); }
 
 
-#endif /* __LINUX_GUARDS_H */
+#endif /* __LINUX_CLEANUP_H */
-- 
2.39.2


