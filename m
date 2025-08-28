Return-Path: <bpf+bounces-66873-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6BEB3A97E
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 20:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6110C1C85D04
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 18:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615AB270575;
	Thu, 28 Aug 2025 18:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ip+Lh5Fv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B9326CE0C;
	Thu, 28 Aug 2025 18:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756404216; cv=none; b=an4QVZn5ell0iUQbGp0yMh2wGyXvGz4ghCjYda26Aml+LgkKSpSRDOrSNZYoFbS8RpocjENUNjWUxR8BLuAkiw+Sc333w4B++wyC2uRZyaQ3AvguGYwrvIi/Z01yCuKNIYlh93WQT8uxSUc9K2Wl0DWumfnumIahZBus0RMeAAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756404216; c=relaxed/simple;
	bh=Shk9XwWHjXHvmNsPUjC9THhLxy0GsQvAparhr+M+gFk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=BNgY6Hq3ftp/SM/Ra+2PpqeVwZnuWnAlnIYD54FBBipS1P71TsQs6Fs+YHXISDAKBXgWbHS1dIOJOT8Ns47u41bKy0cZB6J0QIl8TPuCC3ZWXCBDjadVMiWVG/kl/X+5LMTlIAFTeJYRrmxwP8kWpAhHjk0dewKpRellHNQXz3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ip+Lh5Fv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3FEC4CEEB;
	Thu, 28 Aug 2025 18:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756404216;
	bh=Shk9XwWHjXHvmNsPUjC9THhLxy0GsQvAparhr+M+gFk=;
	h=Date:From:To:Cc:Subject:References:From;
	b=Ip+Lh5FvyhTXpM9D7VoHtdPxSo8Rp6nN6FmLNPDqkzUx7b8pZKJJN/TnoROmxfsp0
	 lxzNRMzeGrLxHg1b8mH2YSMiiNT2lUsXrtEmttQmKYx9hf4M2snFtg5lfiV/lWa4wh
	 RXgeEs+xFTjtZZ1qel3FwbyIvYlCK7ZZx5YMmm3XU8Bg8NNGuDpu9mQ5N98GZbsFZg
	 eXH2xMTS0OCeCy0sa/kX0lHdNoT/AitDnu3OYxcwGDWAoxnGrS09vGLuZsfY2ybKla
	 3EYZzu8co46vbMq/uToHpBZEOPiTL3Xx67ppJHcQXAbe/vfPeGMWbCvKBcgV8TrR9A
	 MpUDG97WiRZUA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1urgyb-00000004GDG-1Z3v;
	Thu, 28 Aug 2025 14:03:57 -0400
Message-ID: <20250828180357.223298134@kernel.org>
User-Agent: quilt/0.68
Date: Thu, 28 Aug 2025 14:03:05 -0400
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
Subject: [PATCH v6 5/6] tracing: Show inode and device major:minor in deferred user space
 stacktrace
References: <20250828180300.591225320@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The deferred user space stacktrace event already does a lookup of the vma
for each address in the trace to get the file offset for those addresses,
it can also report the file itself.

Add two more arrays to the user space stacktrace event. One for the inode
number, and the other to store the device major:minor number. Now the
output looks like this:

       trace-cmd-1108    [007] .....   240.253487: <user stack unwind>
cookie=7000000000009
 =>  <00000000001001ca> : 1340007 : 254:3
 =>  <000000000000ae27> : 1308548 : 254:3
 =>  <00000000000107e7> : 1440347 : 254:3
 =>  <00000000000109d3> : 1440347 : 254:3
 =>  <0000000000011523> : 1440347 : 254:3
 =>  <000000000001f79d> : 1440347 : 254:3
 =>  <000000000001fb01> : 1440347 : 254:3
 =>  <000000000001fbc0> : 1440347 : 254:3
 =>  <000000000000eb7e> : 1440347 : 254:3
 =>  <0000000000029ca8> : 1340007 : 254:3

Use space tooling can use this information to get the actual functions
from the files.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v5: https://lore.kernel.org/20250424192613.869730948@goodmis.org

- Set inode to -1L if vma is not found for that address to let user space
  know that, and differentiate from a vdso section.

 kernel/trace/trace.c         | 26 +++++++++++++++++++++++++-
 kernel/trace/trace_entries.h |  8 ++++++--
 kernel/trace/trace_output.c  | 27 +++++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 3e9ef644dd64..c6e1471e4615 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3140,6 +3140,8 @@ static void trace_user_unwind_callback(struct unwind_work *unwind,
 	unsigned int trace_ctx;
 	struct vm_area_struct *vma = NULL;
 	unsigned long *caller;
+	unsigned long *inodes;
+	unsigned int *devs;
 	unsigned int offset;
 	int len;
 	int i;
@@ -3151,7 +3153,8 @@ static void trace_user_unwind_callback(struct unwind_work *unwind,
 	if (!(tr->trace_flags & TRACE_ITER_USERSTACKTRACE_DELAY))
 		return;
 
-	len = trace->nr * sizeof(unsigned long) + sizeof(*entry);
+	len = trace->nr * (sizeof(unsigned long) * 2 + sizeof(unsigned int))
+			   + sizeof(*entry);
 
 	trace_ctx = tracing_gen_ctx();
 
@@ -3172,6 +3175,15 @@ static void trace_user_unwind_callback(struct unwind_work *unwind,
 	entry->__data_loc_stack = offset | (len << 16);
 	caller = (void *)entry + offset;
 
+	offset += len;
+	entry->__data_loc_inodes = offset | (len << 16);
+	inodes = (void *)entry + offset;
+
+	offset += len;
+	len = sizeof(unsigned int) * trace->nr;
+	entry->__data_loc_dev = offset | (len << 16);
+	devs = (void *)entry + offset;
+
 	for (i = 0; i < trace->nr; i++) {
 		unsigned long addr = trace->entries[i];
 
@@ -3180,9 +3192,21 @@ static void trace_user_unwind_callback(struct unwind_work *unwind,
 
 		if (!vma) {
 			caller[i] = addr;
+			/* Use -1 to denote no vma found */
+			inodes[i] = -1L;
+			devs[i] = 0;
 			continue;
 		}
+
 		caller[i] = (addr - vma->vm_start) + (vma->vm_pgoff << PAGE_SHIFT);
+
+		if (vma->vm_file && vma->vm_file->f_inode) {
+			inodes[i] = vma->vm_file->f_inode->i_ino;
+			devs[i] = vma->vm_file->f_inode->i_sb->s_dev;
+		} else {
+			inodes[i] = 0;
+			devs[i] = 0;
+		}
 	}
 
 	__buffer_unlock_commit(buffer, event);
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index 40dc53ead0a8..5f7b72359901 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -256,10 +256,14 @@ FTRACE_ENTRY(user_unwind_stack, userunwind_stack_entry,
 	F_STRUCT(
 		__field(		u64,		cookie	)
 		__dynamic_array(	unsigned long,	stack	)
+		__dynamic_array(	unsigned long,	inodes	)
+		__dynamic_array(	unsigned int,	dev	)
 	),
 
-	F_printk("cookie=%lld\n%s", __entry->cookie,
-		 __print_dynamic_array(stack, sizeof(unsigned long)))
+	F_printk("cookie=%lld\n%s%s%s", __entry->cookie,
+		 __print_dynamic_array(stack, sizeof(unsigned long)),
+		 __print_dynamic_array(inodes, sizeof(unsigned long)),
+		 __print_dynamic_array(dev, sizeof(unsigned long)))
 );
 
 FTRACE_ENTRY(user_unwind_cookie, userunwind_cookie_entry,
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 9489537533f7..437e5f23b73d 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1410,9 +1410,13 @@ static enum print_line_t trace_user_unwind_stack_print(struct trace_iterator *it
 	struct userunwind_stack_entry *field;
 	struct trace_seq *s = &iter->seq;
 	unsigned long *caller;
+	unsigned long *inodes;
+	unsigned int *devs;
 	unsigned int offset;
 	unsigned int len;
 	unsigned int caller_cnt;
+	unsigned int inode_cnt;
+	unsigned int dev_cnt;
 	unsigned int i;
 
 	trace_assign_type(field, iter->ent);
@@ -1429,6 +1433,21 @@ static enum print_line_t trace_user_unwind_stack_print(struct trace_iterator *it
 
 	caller = (void *)iter->ent + offset;
 
+	/* The inodes and devices are also dynamic pointers */
+	offset = field->__data_loc_inodes;
+	len = offset >> 16;
+	offset = offset & 0xffff;
+	inode_cnt = len / sizeof(*inodes);
+
+	inodes = (void *)iter->ent + offset;
+
+	offset = field->__data_loc_dev;
+	len = offset >> 16;
+	offset = offset & 0xffff;
+	dev_cnt = len / sizeof(*devs);
+
+	devs = (void *)iter->ent + offset;
+
 	for (i = 0; i < caller_cnt; i++) {
 		unsigned long ip = caller[i];
 
@@ -1437,6 +1456,14 @@ static enum print_line_t trace_user_unwind_stack_print(struct trace_iterator *it
 
 		trace_seq_puts(s, " => ");
 		seq_print_user_ip(s, NULL, ip, flags);
+
+		if (i < inode_cnt) {
+			trace_seq_printf(s, " : %ld", inodes[i]);
+			if (i < dev_cnt) {
+				trace_seq_printf(s, " : %d:%d",
+						 MAJOR(devs[i]), MINOR(devs[i]));
+			}
+		}
 		trace_seq_putc(s, '\n');
 	}
 
-- 
2.50.1



