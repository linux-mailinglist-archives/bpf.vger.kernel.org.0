Return-Path: <bpf+bounces-64849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3189FB17A0F
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 01:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C23217A6E3
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 23:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B59288C3D;
	Thu, 31 Jul 2025 23:31:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CC8288C13;
	Thu, 31 Jul 2025 23:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754004674; cv=none; b=UMOcp9tM91Bfzbs8aRWz5czirVyZbbU8y2rK6n9i0GEt8maAaBRlGxwjooPcR4buZ7TpiGjp++L4DsfBhYysmxglvX8O5gihsfpwDwz41NdX6YQbS9wCorGXPld9ugCsslikRJZDDFvARobxZeif8PHvopBN1viBXxQGDrUQmQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754004674; c=relaxed/simple;
	bh=X6ag863tsAMX72vxVmuzaAl3aNsCRnexcpmqmW3S/bw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=TgJeAeXmmojF9VvrJN34wteNuVRQzOxWPNfLnel18NoT4DJPsUr0XXLbkwadlVeoTq7Ipo9stMIp2KspnPM8gSIVPuYUFHLxTAAraGTl1y4j4+nHlm0bi1rsxVrpOadGjOGy+hVc1nDLIAMVNIjr0T0Q4YaXr2I/HwVV6f1p2CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 348081A0B32;
	Thu, 31 Jul 2025 23:31:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 8082B20025;
	Thu, 31 Jul 2025 23:31:07 +0000 (UTC)
Date: Thu, 31 Jul 2025 19:31:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, bpf@vger.kernel.org, Douglas Raillard
 <douglas.raillard@arm.com>
Subject: [PATCH] tracing: Have unsigned int function args displayed as
 hexadecimal
Message-ID: <20250731193126.2eeb21c6@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: afjqzmu6nzyhwkeonr138bmxsjxupxw3
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 8082B20025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/YeDc0ItVMUA3mLMe0onyOkUEa2serYZM=
X-HE-Tag: 1754004667-959313
X-HE-Meta: U2FsdGVkX1+z+Dq5IE/EHdZLBzL2QtoUEsiLkpqrXCweM9zvEJ9RW3b7LYH5RoEWW4wV8oerCSaWKgX4HFYmGFtJSAtXaCdwOoRibagsLWbukgTeUY623Ue9piuaZkRJmCuuPkduW528/ME/qIOceA/NZ3GDmW+wssgNvwjpS2HDurBz3VG/rVN9ZlbN8nr4rtWZ4lU1nBO1YMXwqjSsMX3FdKpAPa3qEq51DdiBwXP22xpabwLns5Pwc0s4wbRHebj9NTGbuNaocvEvO9ZCUCvns9ZW4z3ZVG4Ow+yXmaofZ7AfuCu4pePE4GsNEPOPaBwOiEvIzdfmAhQTadIhnQluSBHuziRJJVkOx64yARTdh2zmgpO0vX0ShDIqOkHs

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

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_output.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 0b3db02030a7..b18393d66a7f 100644
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
+                        encode = BTF_INT_ENCODING(int_data);
+                        /* Print unsigned ints as hex */
+                        if (encode & BTF_INT_SIGNED)
+				trace_seq_printf(s, "%ld", arg);
+                        else
+                                trace_seq_printf(s, "0x%lx", arg);
 			break;
 		case BTF_KIND_ENUM:
 			trace_seq_printf(s, "%ld", arg);
-- 
2.47.2


