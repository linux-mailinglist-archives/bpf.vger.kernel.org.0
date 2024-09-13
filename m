Return-Path: <bpf+bounces-39833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AE597817F
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 15:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E91CA1F21AEE
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 13:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C55A1DA313;
	Fri, 13 Sep 2024 13:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMHj37mU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048C743144
	for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 13:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726235402; cv=none; b=fFMnjpLfu1aQPFXChsqDuECV+erFHANxXUUHdhI+T7lMRenbdVMnH4YLfhIlfT3irLgnRO0ob7XMH18ODXgiUxSZB1xi03LEfoQ7UDBxgxlP/ZJ01nGiZzFqGNMfkC2XomyvV3wXq0g8xc7ANh2bMIJBvs8kiskPr/xFH4TtppI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726235402; c=relaxed/simple;
	bh=GrfsLses5J04wyGvYuLX5YF+IzblJF/SBuqS6MXBzBI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XayiXPrZUYpuiJs7ILaGTm73AMtyS2dMZqtOtzZZOoptyCWsdRC5IKu6qiTiOgf49yke1wJkZKkrdS6aXxPinYrxcAJ6jvu3pdEXomeAqUXytsrMf9xcNwiUloMp3L3EPMPBzhOdz2nAhYjK7EOiu7uLoud/mnWtWXtDwvQPkq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMHj37mU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B60BC4CEC0;
	Fri, 13 Sep 2024 13:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726235401;
	bh=GrfsLses5J04wyGvYuLX5YF+IzblJF/SBuqS6MXBzBI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gMHj37mUcZrXJ2dDBn3I58fVKMWysa8nTYDCFhCvmFt4BvIJJtwgK7ezlAvXuUsZg
	 LQ0/pvEwuuxmEh1gDDDOVHnBLc+ArTAAvS3pSXzg+O7MMtzuzWVPn9ANSrUM3Gz35C
	 9RwbChHBT2F8WfKpDlcOfLEobj5AJvXd79GxT208ZZ21caRrHbHYvGRP6F2WPcykaG
	 qxmQlDc8kzkVDFPiLUBVzQM7eYtRfhfzgCCq7C0IZCdtfgNyu9qgaRUX8jKbRxQ/SW
	 nlgkbt93a7nOMynpzbJd82tpjEJ8WYvSu9mSuSobYlQGUFTR0bio0hRUrXC9fyJLPX
	 IoCTcUXvKTs4w==
Date: Fri, 13 Sep 2024 22:49:57 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, kernel-ci@meta.com,
 bot+bpf-ci@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, bpf <bpf@vger.kernel.org>, Jiri Olsa
 <jolsa@kernel.org>
Subject: Re: [PATCH v14 00/19] tracing: fprobe: function_graph:
 Multi-function graph and fprobe on fgraph
Message-Id: <20240913224957.5bfa380429020f3cbe9eeb63@kernel.org>
In-Reply-To: <20240913214515.894c868a1ef4968550553b86@kernel.org>
References: <172615368656.133222.2336770908714920670.stgit@devnote2>
	<0170cd7d95df0583770c385c1e11bd27dfacf618b71b6e723f0952efc0ce9040@mail.kernel.org>
	<CAEf4BzZgAkSkMd6Vk3m1D-0AVqXp06PaBPr+2L7Dd3WRgJ8JvA@mail.gmail.com>
	<20240913085402.9e5b2c506a8973b099679d04@kernel.org>
	<CAEf4BzZEoNHgcLDPTPQ=yyQTZtEZoVrGbBbeTf3vqe_wcpS6EA@mail.gmail.com>
	<20240913175935.bb0892ab1e6052efc12c6423@kernel.org>
	<20240913214515.894c868a1ef4968550553b86@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Sep 2024 21:45:15 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Fri, 13 Sep 2024 17:59:35 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > > 
> > > Taking failing output from the test:
> > > 
> > > > > > kprobe_multi_testmod_check:FAIL:kretprobe_test3_result unexpected kretprobe_test3_result: actual 0 != expected 1
> > > 
> > > kretprobe_test3_result is a sort of identifier for a test condition,
> > > you can find a corresponding line in user space .c file grepping for
> > > that:
> > > 
> > > ASSERT_EQ(skel->bss->kretprobe_testmod_test3_result, 1,
> > > "kretprobe_test3_result");
> > > 
> > > Most probably the problem is in:
> > > 
> > > __u64 addr = bpf_get_func_ip(ctx);
> > 
> > Yeah, and as I replyed to another thread, the problem is
> > that the ftrace entry_ip is not symbol ip.
> > 
> > We have ftrace_call_adjust() arch function for reverse
> > direction (symbol ip to ftrace entry ip) but what we need
> > here is the reverse translate function (ftrace entry to symbol)
> > 
> > The easiest way is to use kallsyms to find it, but this is
> > a bit costful (but it just increase bsearch in several levels).
> > Other possible options are
> > 
> >  - Change bpf_kprobe_multi_addrs_cmp() to accept a range
> >    of address. [sym_addr, sym_addr + offset) returns true,
> >    bpf_kprobe_multi_cookie() can find the entry address.
> >    The offset depends on arch, but 16 is enough.
> 
> Oops. no, this bpf_kprobe_multi_cookie() is used only for storing
> test data. Not a general problem solving. (I saw kprobe_multi_check())
> 
> So solving problem is much costly, we need to put more arch-
> dependent in bpf_trace, and make sure it does reverse translation
> of ftrace_call_adjust(). (this means if you expand arch support,
> you need to add such implementation)

OK, can you try this one?


From 81bc599911507215aa9faa1077a601880cbd654a Mon Sep 17 00:00:00 2001
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Date: Fri, 13 Sep 2024 21:43:46 +0900
Subject: [PATCH] bpf: Add get_entry_ip() for arm64

Add get_entry_ip() implementation for arm64. This is based on
the information in ftrace_call_adjust() for arm64.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/bpf_trace.c | 64 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index deb629f4a510..b0cf6e5b8965 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1066,6 +1066,70 @@ static unsigned long get_entry_ip(unsigned long fentry_ip)
 		fentry_ip -= ENDBR_INSN_SIZE;
 	return fentry_ip;
 }
+#elif defined (CONFIG_ARM64)
+#include <asm/insn.h>
+
+static unsigned long get_entry_ip(unsigned long fentry_ip)
+{
+	u32 insn;
+
+	/*
+	 * When using patchable-function-entry without pre-function NOPS, ftrace
+	 * entry is the address of the first NOP after the function entry point.
+	 *
+	 * The compiler has either generated:
+	 *
+	 * func+00:	func:	NOP		// To be patched to MOV X9, LR
+	 * func+04:		NOP		// To be patched to BL <caller>
+	 *
+	 * Or:
+	 *
+	 * func-04:		BTI	C
+	 * func+00:	func:	NOP		// To be patched to MOV X9, LR
+	 * func+04:		NOP		// To be patched to BL <caller>
+	 *
+	 * The fentry_ip is the address of `BL <caller>` which is at `func + 4`
+	 * bytes in either case.
+	 */
+	if (!IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS))
+		return fentry_ip - AARCH64_INSN_SIZE;
+
+	/*
+	 * When using patchable-function-entry with pre-function NOPs, BTI is
+	 * a bit different.
+	 *
+	 * func+00:	func:	NOP		// To be patched to MOV X9, LR
+	 * func+04:		NOP		// To be patched to BL <caller>
+	 *
+	 * Or:
+	 *
+	 * func+00:	func:	BTI	C
+	 * func+04:		NOP		// To be patched to MOV X9, LR
+	 * func+08:		NOP		// To be patched to BL <caller>
+	 *
+	 * The fentry_ip is the address of `BL <caller>` which is at either
+	 * `func + 4` or `func + 8` depends on whether there is a BTI.
+	 */
+
+	/* If there is no BTI, the func address should be one instruction before. */
+	if (!IS_ENABLED(CONFIG_ARM64_BTI_KERNEL))
+		return fentry_ip - AARCH64_INSN_SIZE;
+
+	/* We want to be extra safe in case entry ip is on the page edge,
+	 * but otherwise we need to avoid get_kernel_nofault()'s overhead.
+	 */
+	if ((fentry_ip & ~PAGE_MASK) < AARCH64_INSN_SIZE * 2) {
+		if (get_kernel_nofault(insn, (u32 *)(fentry_ip - AARCH64_INSN_SIZE * 2)))
+			return fentry_ip - AARCH64_INSN_SIZE;
+	} else {
+		insn = *(u32 *)(fentry_ip - AARCH64_INSN_SIZE * 2);
+	}
+
+	if (aarch64_insn_is_bti(le32_to_cpu((__le32)insn)))
+		return fentry_ip - AARCH64_INSN_SIZE * 2;
+
+	return fentry_ip - AARCH64_INSN_SIZE;
+}
 #else
 #define get_entry_ip(fentry_ip) fentry_ip
 #endif
-- 
2.34.1



-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

