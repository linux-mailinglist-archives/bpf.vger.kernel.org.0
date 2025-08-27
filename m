Return-Path: <bpf+bounces-66721-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD045B38AF7
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 22:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE407189C2DA
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 20:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAFE3081C7;
	Wed, 27 Aug 2025 20:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wf4MHHj+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5030130749E;
	Wed, 27 Aug 2025 20:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756326263; cv=none; b=FZ70ei8u+nKKpRKOOzjSKt1dNcrVBQs1Z05wNfKmBXWd2JYBd5c+zxiJaBi0cmWYLIEk/JtLl79eDRIxAUKEwbHP6q2/BUTAH7g4DDzotO9uFTq4D1yckVmBwxK+BK3+BLxsvT1NixaH12hvn+znK3sVaLYXFKcmKwVuCBkMRTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756326263; c=relaxed/simple;
	bh=EcoepKxpaib08JEAUBe/rbQ989EbwLD/UsSh+4p+mfQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=J0EsRSQk/CWNAXGTkX9LYHsfRkZJQTHFTSpb/VQr0Q4Md0vf3TkgF83UMxNxnr7X/qh97r3/bc8mG4335XHL2D1znEyQrll+N4llljCx+6Emqc46DxKWMjyTyMJSOsZ6ixncqEocjnmoGlroQbPWVI1QYVuPmXlTj04BYcHD/T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wf4MHHj+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4E5C4CEFC;
	Wed, 27 Aug 2025 20:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756326263;
	bh=EcoepKxpaib08JEAUBe/rbQ989EbwLD/UsSh+4p+mfQ=;
	h=Date:From:To:Cc:Subject:References:From;
	b=Wf4MHHj+LWL/MisFVeOoKZQSxnXZ+RqIQMsWDbhQskReHP8F+zA39h4Cn/Ds5csKA
	 wiGC7dJQ3totPlHqfNY0XtNy+5iY7kd4TIDCRQjt2zcJVCRbeCm2gwaZyYymzXHC10
	 AhIrfoNG5Xk9HekU2Vdn94uoweDozhMVk33FDvZMf5XEAvK3tn36VFIcjLi2HmNaVZ
	 82KZlUCbNbQQxlFiVF4+r3PVUoKGfXI7ljKTPqKT2Gy+v479mhDUUGMzur05KFlAB8
	 LPM0n96cDXAQUyZSebvsZNRP6ZkFYHQWPDAM8cKE7yqyUqRS2YzOAAVxltzr/3QdA6
	 eE93pqNLjQAjQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1urMhG-00000003l1K-0OTE;
	Wed, 27 Aug 2025 16:24:42 -0400
Message-ID: <20250827202441.946968550@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 27 Aug 2025 16:15:59 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org,
 x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Florian Weimer <fweimer@redhat.com>,
 Sam James <sam@gentoo.org>,
 Kees Cook <kees@kernel.org>,
 "Carlos O'Donell" <codonell@redhat.com>
Subject: [PATCH v10 11/11] [DO NOT APPLY]unwind_user/sframe: Add prctl() interface for registering .sframe
 sections
References: <20250827201548.448472904@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Josh Poimboeuf <jpoimboe@kernel.org>

The kernel doesn't have direct visibility to the ELF contents of shared
libraries.  Add some prctl() interfaces which allow glibc to tell the
kernel where to find .sframe sections.

[
  This adds an interface for prctl() for testing loading of sframes for
  libraries. But this interface should really be a system call. This patch
  is for testing purposes only and should not be applied to mainline.
]

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/uapi/linux/prctl.h | 6 +++++-
 kernel/sys.c               | 9 +++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index ed3aed264aeb..b807baa8a53b 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -358,7 +358,7 @@ struct prctl_mm_map {
  * configuration.  All bits may be locked via this call, including
  * undefined bits.
  */
-#define PR_LOCK_SHADOW_STACK_STATUS      76
+#define PR_LOCK_SHADOW_STACK_STATUS	76
 
 /*
  * Controls the mode of timer_create() for CRIU restore operations.
@@ -376,4 +376,8 @@ struct prctl_mm_map {
 # define PR_FUTEX_HASH_SET_SLOTS	1
 # define PR_FUTEX_HASH_GET_SLOTS	2
 
+/* SFRAME management */
+#define PR_ADD_SFRAME			79
+#define PR_REMOVE_SFRAME		80
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index 1e28b40053ce..e6ce79a3a7aa 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -65,6 +65,7 @@
 #include <linux/rcupdate.h>
 #include <linux/uidgid.h>
 #include <linux/cred.h>
+#include <linux/sframe.h>
 
 #include <linux/nospec.h>
 
@@ -2805,6 +2806,14 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 	case PR_FUTEX_HASH:
 		error = futex_hash_prctl(arg2, arg3, arg4);
 		break;
+	case PR_ADD_SFRAME:
+		error = sframe_add_section(arg2, arg3, arg4, arg5);
+		break;
+	case PR_REMOVE_SFRAME:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = sframe_remove_section(arg2);
+		break;
 	default:
 		trace_task_prctl_unknown(option, arg2, arg3, arg4, arg5);
 		error = -EINVAL;
-- 
2.50.1



