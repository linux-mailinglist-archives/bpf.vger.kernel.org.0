Return-Path: <bpf+bounces-60870-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 741FBADDF3B
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 00:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50B6140062E
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 22:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925392F3C18;
	Tue, 17 Jun 2025 22:51:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE0A2F0C62;
	Tue, 17 Jun 2025 22:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750200685; cv=none; b=MrSt4TNYqPG0TfoFgt7QLl7N0dly2Cs0vi5Ojbt90O+Gb4WnoqInPG0ubEr6cFULtpcikzfoRKR9Jhf2l8pq3f8Cz5oFShboze24UDgD6qFC3OOO99Tg4GOP+bowh8plw8N6ZdaAL69/YXz4cJt52qK1EXf3fpBqw2xaQ3TyYzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750200685; c=relaxed/simple;
	bh=9m5PXLzk+nB2noJJboTPg5LzSGgn7c11qCCeurwP7ac=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=b/KRMP1MRnkdBmundgmUfdukfu4qbxwKAW05fTF9QAOBHiOe66OiS3YeR1iHaPEUYy/raBiPAav3dp4FHXVgcq8GulFvb6Yxtpg7pAnYDIncoCIyE50ekqaSNYnIszr6kJEkXbaSM4Ehr1fKF/CH13gEBnU0lw+IAsa2RV4nU7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 4232914110A;
	Tue, 17 Jun 2025 22:51:14 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 3C0022002D;
	Tue, 17 Jun 2025 22:51:11 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uRf9C-00000002L5u-0in3;
	Tue, 17 Jun 2025 18:51:18 -0400
Message-ID: <20250617225118.022317038@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 17 Jun 2025 18:50:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
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
 Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 06/12] unwind_user/sframe: Add prctl() interface for registering .sframe
 sections
References: <20250617225009.233007152@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 3C0022002D
X-Stat-Signature: i93xey3p7h4dbudkeisrppphk8p55ffa
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19DlMrmPTiuSVbEqmTnPfSvV/ssVsV1utE=
X-HE-Tag: 1750200671-734612
X-HE-Meta: U2FsdGVkX1/MLM5P8OFibyZCH1qipt+hpYgGdsjZzQfK3FOe/IpTyK6mAhiOeQOAnfjWrT8bnKb1H4BKGD6HkgBu+hVwdEoMBDgv24t4cDNPyEBpXTkE874TSsxeB1/qduio9lfszsNZSemGGQ+qbvIEa/YIm9PmxvoTQyeG9EX22knbm6uKvy74UIWRdGVHgU+C4nJd4UP/nGrBvib42izDFho/phU+r3SNapP4hzlG/zBixQJLRlGf2imRUQ0NBYZUc0+05upfyA8WSfH8WWRR/ipeQq0KWskshfGXq4QFQYgn6lCthNPiUMc/1KzO8mITmV9sn1bLMtLL+9DrJvHXrzcXqwIIB8AJseF5Z/g0ELzw5VPU47gJ36FADSKLI2fUrsgT6T96uMsB3MuYpbqhGigeVEPd1M8Oa2YTcds=

From: Josh Poimboeuf <jpoimboe@kernel.org>

The kernel doesn't have direct visibility to the ELF contents of shared
libraries.  Add some prctl() interfaces which allow glibc to tell the
kernel where to find .sframe sections.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/uapi/linux/prctl.h | 6 +++++-
 kernel/sys.c               | 9 +++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 43dec6eed559..c575cf7151b1 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -351,7 +351,7 @@ struct prctl_mm_map {
  * configuration.  All bits may be locked via this call, including
  * undefined bits.
  */
-#define PR_LOCK_SHADOW_STACK_STATUS      76
+#define PR_LOCK_SHADOW_STACK_STATUS	76
 
 /*
  * Controls the mode of timer_create() for CRIU restore operations.
@@ -371,4 +371,8 @@ struct prctl_mm_map {
 # define PR_FUTEX_HASH_GET_SLOTS	2
 # define PR_FUTEX_HASH_GET_IMMUTABLE	3
 
+/* SFRAME management */
+#define PR_ADD_SFRAME			79
+#define PR_REMOVE_SFRAME		80
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index adc0de0aa364..cf788e66dc86 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -65,6 +65,7 @@
 #include <linux/rcupdate.h>
 #include <linux/uidgid.h>
 #include <linux/cred.h>
+#include <linux/sframe.h>
 
 #include <linux/nospec.h>
 
@@ -2824,6 +2825,14 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
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
2.47.2



