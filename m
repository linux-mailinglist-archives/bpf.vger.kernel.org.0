Return-Path: <bpf+bounces-64897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B83D3B184C1
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 17:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE5BA1C22CF5
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 15:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E41127056B;
	Fri,  1 Aug 2025 15:14:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AB826FA7B;
	Fri,  1 Aug 2025 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754061284; cv=none; b=gg6l0t7hjFKDmFBiSEy2lHrzf4BrA4PygPRNX44CzCMNwc0qCPXZ95W2q/21EJAdSHWF3oBAsi13mRR8vJUXZvTp6S3E/KmdAmV4KtGRY1o7bFWDjsFC09+ANdcm/97yBJu9GaLygBEhRGmk8wtNKj6OJ+ViYCiV28p/FOsFDtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754061284; c=relaxed/simple;
	bh=z/VXTL9XJ4xncPDLbz2NCbekM9lyeRi/bg0hzGvJNV0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ZyN6UibjAbdFtMquNaaIt5wySqYaNVaNRPT4Awof19C1SsN0AcNNAeuuGOQvkigLClOQBwA03gTcflDJR9oBdX9nNx2ViSjb0lwOiInyO11iqo7XpWlanHBPOil1aLtnA8FCQlQdGY1BengIOEomsKmdZYXJEBZkkApHlLmL//A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 5F2501A012E;
	Fri,  1 Aug 2025 15:14:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 8C44420011;
	Fri,  1 Aug 2025 15:14:32 +0000 (UTC)
Date: Fri, 1 Aug 2025 11:14:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, bpf@vger.kernel.org, Douglas Raillard
 <douglas.raillard@arm.com>, Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH v2] tracing: Have unsigned int function args displayed as 
 hexadecimal
Message-ID: <20250801111453.01502861@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: iyzrnr6w4pjc1djibas7in4xd3rr8x5q
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 8C44420011
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18xssWv1N8xOSx5bKZvuO7jwFLxY1ftaow=
X-HE-Tag: 1754061272-841103
X-HE-Meta: U2FsdGVkX1+lplGtHrEAOkWKXPskBQQAellZmOYwCbwAU98pNAaFo31+QYlRNB/tKE+WEwWhpUmiSmvXvt5kQWhomZcmMfOoLL1FETZ66ZZ8uuEiM/VEYynAVv77VYUXoFgbpuLNRNmzpRfn57FZxLWZtpO0T50W2sxzpm9vLjcjno8w+oh+ilaiKzMJpefGec0I1qO5vuUo23L2wTiYuRS3lDvooqx9lgsixZ8quEO16HXPR+RTMAJNk1NX7F+x5V15U/TXlT1HJCgjBRo5FxXbMAEMQ5t0cC+hm4WSBpYp7tm5dNzkrvwoLn2jd9Ho/muqSrZWt4h7cGk8+tOcG6cO6VVzibYWBSF5h2EiuQhvjFFaKZ6L07pgIm9eXGqQvRVIzTkW4HY3TvRf9KYXUA==

From: Steven Rostedt <rostedt@goodmis.org>

Most function arguments that are passed in as unsigned int or unsigned
long are better displayed as hexadecimal than normal integer. For example,
the functions:

static void __create_object(unsigned long ptr, size_t size,
				int min_count, gfp_t gfp, unsigned int objflags);

static bool stack_access_ok(struct unwind_state *state, unsigned long _addr,
			    size_t len);

void __local_bh_disable_ip(unsigned long ip, unsigned int cnt);

Show up in the trace as:

    __create_object(ptr=-131387050520576, size=4096, min_count=1, gfp=3264, objflags=0) <-kmem_cache_alloc_noprof
    stack_access_ok(state=0xffffc9000233fc98, _addr=-60473102566256, len=8) <-unwind_next_frame
    __local_bh_disable_ip(ip=-2127311112, cnt=256) <-handle_softirqs

Instead, by displaying unsigned as hexadecimal, they look more like this:

    __create_object(ptr=0xffff8881028d2080, size=0x280, min_count=1, gfp=0x82820, objflags=0x0) <-kmem_cache_alloc_node_noprof
    stack_access_ok(state=0xffffc90000003938, _addr=0xffffc90000003930, len=0x8) <-unwind_next_frame
    __local_bh_disable_ip(ip=0xffffffff8133cef8, cnt=0x100) <-handle_softirqs

Which is much easier to understand as most unsigned longs are usually just
pointers. Even the "unsigned int cnt" in __local_bh_disable_ip() looks
better as hexadecimal as a lot of flags are passed as unsigned.

Acked-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/20250731193126.2eeb21c6@gandalf.local.home

- Fixed whitespace issues (Yonghong Song)

 kernel/trace/trace_output.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 0b3db02030a7..fe54003de860 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -690,6 +690,12 @@ int trace_print_lat_context(struct trace_iterator *iter)
 }
 
 #ifdef CONFIG_FUNCTION_TRACE_ARGS
+
+static u32 btf_type_int(const struct btf_type *t)
+{
+	return *(u32 *)(t + 1);
+}
+
 void print_function_args(struct trace_seq *s, unsigned long *args,
 			 unsigned long func)
 {
@@ -701,6 +707,8 @@ void print_function_args(struct trace_seq *s, unsigned long *args,
 	struct btf *btf;
 	s32 tid, nr = 0;
 	int a, p, x;
+	int int_data;
+	u16 encode;
 
 	trace_seq_printf(s, "(");
 
@@ -744,7 +752,14 @@ void print_function_args(struct trace_seq *s, unsigned long *args,
 			trace_seq_printf(s, "0x%lx", arg);
 			break;
 		case BTF_KIND_INT:
-			trace_seq_printf(s, "%ld", arg);
+			/* Get the INT encodoing */
+			int_data = btf_type_int(t);
+			encode = BTF_INT_ENCODING(int_data);
+			/* Print unsigned ints as hex */
+			if (encode & BTF_INT_SIGNED)
+				trace_seq_printf(s, "%ld", arg);
+			else
+				trace_seq_printf(s, "0x%lx", arg);
 			break;
 		case BTF_KIND_ENUM:
 			trace_seq_printf(s, "%ld", arg);
-- 
2.47.2


