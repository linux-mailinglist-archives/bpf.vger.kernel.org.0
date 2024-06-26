Return-Path: <bpf+bounces-33184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D19E91936C
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 20:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0301BB221C1
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 18:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F4B19069D;
	Wed, 26 Jun 2024 18:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="O8H30BvR"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DA219006C;
	Wed, 26 Jun 2024 18:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719428362; cv=none; b=dYJtEWLlahKBTEzBXXoaT+P1DuFRJDPcCXWW6LVD0z7O7N2ozWD0qZmS2vq43F7uUzliiePsK7vSg8CzxY/+6Ostpl6b6BLqgxjE4Lmd6s+c/V7lUsixHGm3yPg0LMou9qYhkDO6DGW/vONAHwRGq2HV0n3skdR+JYngKCw+1HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719428362; c=relaxed/simple;
	bh=yP+LIbKJrOeA3BYfx1Pv/DUs/vsdWYAxVDdeHfKVSFk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jDOzDn2okNGeAnIWSw/zupkcJxwhABYYUu1BNnCfKoPDxsOy05ZYSW1+lrPbF8mGbKFpfyv/pXW95+NEHmsfyhkleBsMABzQH/s94n3hPFH6uHsPL6w51EJiJaOFxoRkGo3+BsSO//boz2q5EPF1vKe6+nx3rpqegKVYY7n3dbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=O8H30BvR; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1719428353;
	bh=yP+LIbKJrOeA3BYfx1Pv/DUs/vsdWYAxVDdeHfKVSFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O8H30BvRBrN3MRFdDRRitHB87Mg1mxfUYJa40lT7NJHoink1a5ljxYu8TtEDFB1NO
	 TYo9RWmNSq9omEz68dLtz5ADim4iiIoG2SQAP6KJCgVUHbZIkZM2hDHBXluLJ8/fvf
	 8uaQ4a4TOYCEUKr0IkMdeBzsPIqwdCBYyoVmMiOfU1olfwd6iyOZ5twJ5tpmpBKaHi
	 QLHOTWSbuGt0CLIYmZbvbgApSASEcNr0TswWqUR2AXZlzYv+BkmdpHY+JGLUTqmeVM
	 mTzimsfAlMrUlnrHd/6cOqx+eEXwQ6aWADyJQ/ZdCAQLefm+qF3LJX/HXr6N439oMN
	 X5+uG8aCm7Ldw==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4W8WFr5vCqz17tY;
	Wed, 26 Jun 2024 14:59:12 -0400 (EDT)
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
	Jiri Olsa <jolsa@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	bpf@vger.kernel.org,
	Joel Fernandes <joel@joelfernandes.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v5 1/8] cleanup.h: Header include guard should match header name
Date: Wed, 26 Jun 2024 14:59:34 -0400
Message-Id: <20240626185941.68420-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240626185941.68420-1-mathieu.desnoyers@efficios.com>
References: <20240626185941.68420-1-mathieu.desnoyers@efficios.com>
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


