Return-Path: <bpf+bounces-66870-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C94B3A97C
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 20:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07D4C5677C0
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 18:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1973126FA7B;
	Thu, 28 Aug 2025 18:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgDp6LSh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727D5262FD7;
	Thu, 28 Aug 2025 18:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756404216; cv=none; b=eIL40wVcAx5CK8JmeJqoAs3rv/qRMbEQL63ECYSgM9XcZjXynZTaieKn8jPzAK96iUQKz1O+lXK67eZYI1HCGYTDqQVjfLyVb4FbniyoWQs5iH4kAUkQMe51LX6nMGvZLKgv3nosT0X5An1oCTedyjyRs/EvRP2dS5QNMyT8oFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756404216; c=relaxed/simple;
	bh=ndrE4gvdhVRpRUi6pNX6gi19dw4jMHbZ54Q/ID3v70c=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=hUlPapkna8fA0O0tLuvZpqYtOSIiT7VhGboqYnZb6Y9OHno+0SWrO7GUY8OMR03lkW+lwrduZ3OWQD7MdOjzEJSQiaaqecsMTfhULbcxTnwI66T7S78uaPAIoEzHf86XsrKNauiLD0MZ+b/qi3q7UeheYaeRZUZX16rwY4JJY/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgDp6LSh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2252C4CEF4;
	Thu, 28 Aug 2025 18:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756404216;
	bh=ndrE4gvdhVRpRUi6pNX6gi19dw4jMHbZ54Q/ID3v70c=;
	h=Date:From:To:Cc:Subject:References:From;
	b=mgDp6LSh2Bs/3yqNuAqNaq6W4stRWT66hiYWS+SGJ0h0e/bSrELTcF6SgFDyTDVbf
	 nc8wVQ82dzKPHg2ZbbdXK58VCulitnJlnoQk1DQ2yPx0BFAEPeEmE2/o3mzLO5Ii9M
	 gUI75wFfNqrcm9VEMoxb3TZYXmazuCpJYsPj+xadm5fB1CQ+X3zmbIvOMjmYf/ssY3
	 N2mCPd5X9Ia9GlSGWwW1xWuNOZNr0RQjLgKtdUg7o0Q75nQE/br5jVB35ZtCVY+e3H
	 FJRWqqXVng8WzK07B9+jyYx5ROaWjjHnlsmPM547shHd4s4wKFo88Dvrh1hquOgvG3
	 HZgAuf048a7Ew==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1urgya-00000004GBo-3bon;
	Thu, 28 Aug 2025 14:03:56 -0400
Message-ID: <20250828180356.716157474@kernel.org>
User-Agent: quilt/0.68
Date: Thu, 28 Aug 2025 14:03:02 -0400
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
Subject: [PATCH v6 2/6] tracing: Rename __dynamic_array() to __dynamic_field() for ftrace
 events
References: <20250828180300.591225320@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The ftrace events (like function, trace_print, etc) are created somewhat
manually and not via the TRACE_EVENT() or tracepoint magic macros. It has
its own macros.

The dynamic fields used __dynamic_array() to be created, but the output is
different than the __dynamic_array() used by TRACE_EVENT().

The TRACE_EVENT() __dynamic_array() creates the field like:

	field:__data_loc u8[] v_data;   offset:120;     size:4; signed:0;

Whereas the ftrace event is created as:

	field:char buf[];       offset:12;      size:0; signed:0;

The difference is that the ftrace field is defined as the rest of the size
of the event saved in the ring buffer. TRACE_EVENT() doesn't have such a
dynamic field, and its version saves a word that holds the offset into the
event that the field is stored, as well as the size.

For consistency rename the ftrace event macro to __dynamic_field(). This
way the ftrace event can also include a __dynamic_array() later that works
the same as the TRACE_EVENT() dynamic array.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.h         |  4 ++--
 kernel/trace/trace_entries.h | 10 +++++-----
 kernel/trace/trace_export.c  | 12 ++++++------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 5f4bed5842f9..0fd2559ff119 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -92,8 +92,8 @@ enum trace_type {
 #undef __array_desc
 #define __array_desc(type, container, item, size)
 
-#undef __dynamic_array
-#define __dynamic_array(type, item)	type	item[];
+#undef __dynamic_field
+#define __dynamic_field(type, item)	type	item[];
 
 #undef __rel_dynamic_array
 #define __rel_dynamic_array(type, item)	type	item[];
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index de294ae2c5c5..5cf80f6c704a 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -63,7 +63,7 @@ FTRACE_ENTRY_REG(function, ftrace_entry,
 	F_STRUCT(
 		__field_fn(	unsigned long,		ip		)
 		__field_fn(	unsigned long,		parent_ip	)
-		__dynamic_array( unsigned long,		args		)
+		__dynamic_field( unsigned long,		args		)
 	),
 
 	F_printk(" %ps <-- %ps",
@@ -81,7 +81,7 @@ FTRACE_ENTRY(funcgraph_entry, ftrace_graph_ent_entry,
 		__field_struct(	struct ftrace_graph_ent,	graph_ent	)
 		__field_packed(	unsigned long,	graph_ent,	func		)
 		__field_packed(	unsigned int,	graph_ent,	depth		)
-		__dynamic_array(unsigned long,	args				)
+		__dynamic_field(unsigned long,	args				)
 	),
 
 	F_printk("--> %ps (%u)", (void *)__entry->func, __entry->depth)
@@ -259,7 +259,7 @@ FTRACE_ENTRY(bprint, bprint_entry,
 	F_STRUCT(
 		__field(	unsigned long,	ip	)
 		__field(	const char *,	fmt	)
-		__dynamic_array(	u32,	buf	)
+		__dynamic_field(	u32,	buf	)
 	),
 
 	F_printk("%ps: %s",
@@ -272,7 +272,7 @@ FTRACE_ENTRY_REG(print, print_entry,
 
 	F_STRUCT(
 		__field(	unsigned long,	ip	)
-		__dynamic_array(	char,	buf	)
+		__dynamic_field(	char,	buf	)
 	),
 
 	F_printk("%ps: %s",
@@ -287,7 +287,7 @@ FTRACE_ENTRY(raw_data, raw_data_entry,
 
 	F_STRUCT(
 		__field(	unsigned int,	id	)
-		__dynamic_array(	char,	buf	)
+		__dynamic_field(	char,	buf	)
 	),
 
 	F_printk("id:%04x %08x",
diff --git a/kernel/trace/trace_export.c b/kernel/trace/trace_export.c
index 1698fc22afa0..d9d41e3ba379 100644
--- a/kernel/trace/trace_export.c
+++ b/kernel/trace/trace_export.c
@@ -57,8 +57,8 @@ static int ftrace_event_register(struct trace_event_call *call,
 #undef __array_desc
 #define __array_desc(type, container, item, size)	type item[size];
 
-#undef __dynamic_array
-#define __dynamic_array(type, item)			type item[];
+#undef __dynamic_field
+#define __dynamic_field(type, item)			type item[];
 
 #undef F_STRUCT
 #define F_STRUCT(args...)				args
@@ -123,8 +123,8 @@ static void __always_unused ____ftrace_check_##name(void)		\
 #undef __array_desc
 #define __array_desc(_type, _container, _item, _len) __array(_type, _item, _len)
 
-#undef __dynamic_array
-#define __dynamic_array(_type, _item) {					\
+#undef __dynamic_field
+#define __dynamic_field(_type, _item) {					\
 	.type = #_type "[]", .name = #_item,				\
 	.size = 0, .align = __alignof__(_type),				\
 	is_signed_type(_type), .filter_type = FILTER_OTHER },
@@ -161,8 +161,8 @@ static struct trace_event_fields ftrace_event_fields_##name[] = {	\
 #undef __array_desc
 #define __array_desc(type, container, item, len)
 
-#undef __dynamic_array
-#define __dynamic_array(type, item)
+#undef __dynamic_field
+#define __dynamic_field(type, item)
 
 #undef F_printk
 #define F_printk(fmt, args...) __stringify(fmt) ", "  __stringify(args)
-- 
2.50.1



