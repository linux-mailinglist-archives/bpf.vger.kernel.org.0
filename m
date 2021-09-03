Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A77A53FFB84
	for <lists+bpf@lfdr.de>; Fri,  3 Sep 2021 10:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348198AbhICIFM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Sep 2021 04:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348165AbhICIE7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Sep 2021 04:04:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC60AC061575;
        Fri,  3 Sep 2021 01:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fCkb2r0eTx7M6SKEWAOZLjX5uTeQOJ1FoT+YRXBSZkA=; b=QViuH9gmnTkIya/4ywjmpaFuX8
        WPx8E/MrSBUgLBOX4kqZd1OSPy7JWPgc+zsxMKRjZhzofHcMOjeM2qeXqQNCPfSbB+5sVFG4Sq0Se
        8gGpV2SxDZ1mUnMMbkq3winBOFSrUMpAqpflimm8tz18wOCx0309hX5RTixfGEolzhbp+q85SrFwZ
        rE3mvgjz5OQrflUpzf/m4XnNpivOdVPViFWS45ByI6Exw0XkFBaUAHAnYK8RIEGxyIWMO3k/JH/4E
        wKN2LcYUWdhQNEyMyeMhXDq1y6CzhGwAsS/Gh7VWtQDim8ay1ggvJWtH3QCPBfoEeou4r5wJKHpZn
        WWSN4lbA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mM49q-004Gan-Mw; Fri, 03 Sep 2021 08:02:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 06EA830018E;
        Fri,  3 Sep 2021 10:02:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D7C3828B658E4; Fri,  3 Sep 2021 10:02:40 +0200 (CEST)
Date:   Fri, 3 Sep 2021 10:02:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        mingo@redhat.com, kjain@linux.ibm.com, kernel-team@fb.com
Subject: Re: [PATCH v5 bpf-next 1/3] perf: enable branch record for software
 events
Message-ID: <YTHWoCcSgvfx24/N@hirez.programming.kicks-ass.net>
References: <20210902165706.2812867-1-songliubraving@fb.com>
 <20210902165706.2812867-2-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902165706.2812867-2-songliubraving@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 02, 2021 at 09:57:04AM -0700, Song Liu wrote:
> +static int
> +intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries, unsigned int cnt)
> +{
> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +
> +	intel_pmu_disable_all();
> +	intel_pmu_lbr_read();
> +	cnt = min_t(unsigned int, cnt, x86_pmu.lbr_nr);
> +
> +	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
> +	intel_pmu_enable_all(0);
> +	return cnt;
> +}

Would something like the below help get rid of that memcpy() ?

(compile tested only)

---
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 7011e87be6d0..c508ba6099d2 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2938,7 +2938,7 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
 
 	loops = 0;
 again:
-	intel_pmu_lbr_read();
+	intel_pmu_lbr_read(&cpuc->lbr_stack);
 	intel_pmu_ack_status(status);
 	if (++loops > 100) {
 		static bool warned;
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 9e6d6eaeb4cb..0a5bacba86c2 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -170,7 +170,7 @@ enum {
 
 #define ARCH_LBR_CTL_MASK			0x7f000e
 
-static void intel_pmu_lbr_filter(struct cpu_hw_events *cpuc);
+static void intel_pmu_lbr_filter(struct cpu_hw_events *cpuc, struct perf_branch_stack *bs);
 
 static __always_inline bool is_lbr_call_stack_bit_set(u64 config)
 {
@@ -783,7 +783,7 @@ void intel_pmu_lbr_disable_all(void)
 		__intel_pmu_lbr_disable();
 }
 
-void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
+void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc, struct perf_branch_stack *bs)
 {
 	unsigned long mask = x86_pmu.lbr_nr - 1;
 	u64 tos = intel_pmu_lbr_tos();
@@ -801,18 +801,18 @@ void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
 
 		rdmsrl(x86_pmu.lbr_from + lbr_idx, msr_lastbranch.lbr);
 
-		cpuc->lbr_entries[i].from	= msr_lastbranch.from;
-		cpuc->lbr_entries[i].to		= msr_lastbranch.to;
-		cpuc->lbr_entries[i].mispred	= 0;
-		cpuc->lbr_entries[i].predicted	= 0;
-		cpuc->lbr_entries[i].in_tx	= 0;
-		cpuc->lbr_entries[i].abort	= 0;
-		cpuc->lbr_entries[i].cycles	= 0;
-		cpuc->lbr_entries[i].type	= 0;
-		cpuc->lbr_entries[i].reserved	= 0;
+		bs->entries[i].from	= msr_lastbranch.from;
+		bs->entries[i].to	= msr_lastbranch.to;
+		bs->entries[i].mispred	= 0;
+		bs->entries[i].predicted= 0;
+		bs->entries[i].in_tx	= 0;
+		bs->entries[i].abort	= 0;
+		bs->entries[i].cycles	= 0;
+		bs->entries[i].type	= 0;
+		bs->entries[i].reserved	= 0;
 	}
-	cpuc->lbr_stack.nr = i;
-	cpuc->lbr_stack.hw_idx = tos;
+	bs->nr = i;
+	bs->hw_idx = tos;
 }
 
 /*
@@ -820,7 +820,7 @@ void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
  * is the same as the linear address, allowing us to merge the LIP and EIP
  * LBR formats.
  */
-void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
+void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc, struct perf_branch_stack *bs)
 {
 	bool need_info = false, call_stack = false;
 	unsigned long mask = x86_pmu.lbr_nr - 1;
@@ -896,19 +896,19 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 		if (abort && x86_pmu.lbr_double_abort && out > 0)
 			out--;
 
-		cpuc->lbr_entries[out].from	 = from;
-		cpuc->lbr_entries[out].to	 = to;
-		cpuc->lbr_entries[out].mispred	 = mis;
-		cpuc->lbr_entries[out].predicted = pred;
-		cpuc->lbr_entries[out].in_tx	 = in_tx;
-		cpuc->lbr_entries[out].abort	 = abort;
-		cpuc->lbr_entries[out].cycles	 = cycles;
-		cpuc->lbr_entries[out].type	 = 0;
-		cpuc->lbr_entries[out].reserved	 = 0;
+		bs->entries[out].from	 = from;
+		bs->entries[out].to	 = to;
+		bs->entries[out].mispred = mis;
+		bs->entries[out].predicted = pred;
+		bs->entries[out].in_tx	 = in_tx;
+		bs->entries[out].abort	 = abort;
+		bs->entries[out].cycles	 = cycles;
+		bs->entries[out].type	 = 0;
+		bs->entries[out].reserved = 0;
 		out++;
 	}
-	cpuc->lbr_stack.nr = out;
-	cpuc->lbr_stack.hw_idx = tos;
+	bs->nr = out;
+	bs->hw_idx = tos;
 }
 
 static __always_inline int get_lbr_br_type(u64 info)
@@ -945,7 +945,8 @@ static __always_inline u16 get_lbr_cycles(u64 info)
 }
 
 static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
-				struct lbr_entry *entries)
+				struct lbr_entry *entries,
+				struct perf_branch_stack *bs)
 {
 	struct perf_branch_entry *e;
 	struct lbr_entry *lbr;
@@ -954,7 +955,7 @@ static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
 
 	for (i = 0; i < x86_pmu.lbr_nr; i++) {
 		lbr = entries ? &entries[i] : NULL;
-		e = &cpuc->lbr_entries[i];
+		e = &bs->entries[i];
 
 		from = rdlbr_from(i, lbr);
 		/*
@@ -977,28 +978,28 @@ static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
 		e->reserved	= 0;
 	}
 
-	cpuc->lbr_stack.nr = i;
+	bs->nr = i;
 }
 
-static void intel_pmu_arch_lbr_read(struct cpu_hw_events *cpuc)
+static void intel_pmu_arch_lbr_read(struct cpu_hw_events *cpuc, struct perf_branch_stack *bs)
 {
-	intel_pmu_store_lbr(cpuc, NULL);
+	intel_pmu_store_lbr(cpuc, NULL, bs);
 }
 
-static void intel_pmu_arch_lbr_read_xsave(struct cpu_hw_events *cpuc)
+static void intel_pmu_arch_lbr_read_xsave(struct cpu_hw_events *cpuc, struct perf_branch_stack *bs)
 {
 	struct x86_perf_task_context_arch_lbr_xsave *xsave = cpuc->lbr_xsave;
 
 	if (!xsave) {
-		intel_pmu_store_lbr(cpuc, NULL);
+		intel_pmu_store_lbr(cpuc, NULL, bs);
 		return;
 	}
 	xsaves(&xsave->xsave, XFEATURE_MASK_LBR);
 
-	intel_pmu_store_lbr(cpuc, xsave->lbr.entries);
+	intel_pmu_store_lbr(cpuc, xsave->lbr.entries, bs);
 }
 
-void intel_pmu_lbr_read(void)
+void intel_pmu_lbr_read(struct perf_branch_stack *bs)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
@@ -1012,9 +1013,8 @@ void intel_pmu_lbr_read(void)
 	    cpuc->lbr_users == cpuc->lbr_pebs_users)
 		return;
 
-	x86_pmu.lbr_read(cpuc);
-
-	intel_pmu_lbr_filter(cpuc);
+	x86_pmu.lbr_read(cpuc, bs);
+	intel_pmu_lbr_filter(cpuc, bs);
 }
 
 /*
@@ -1402,7 +1402,7 @@ static const int arch_lbr_br_type_map[ARCH_LBR_BR_TYPE_MAP_MAX] = {
  * in PERF_SAMPLE_BRANCH_STACK sample may vary.
  */
 static void
-intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
+intel_pmu_lbr_filter(struct cpu_hw_events *cpuc, struct perf_branch_stack *bs)
 {
 	u64 from, to;
 	int br_sel = cpuc->br_sel;
@@ -1414,11 +1414,11 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
 	    ((br_sel & X86_BR_TYPE_SAVE) != X86_BR_TYPE_SAVE))
 		return;
 
-	for (i = 0; i < cpuc->lbr_stack.nr; i++) {
+	for (i = 0; i < bs->nr; i++) {
 
-		from = cpuc->lbr_entries[i].from;
-		to = cpuc->lbr_entries[i].to;
-		type = cpuc->lbr_entries[i].type;
+		from = bs->entries[i].from;
+		to = bs->entries[i].to;
+		type = bs->entries[i].type;
 
 		/*
 		 * Parse the branch type recorded in LBR_x_INFO MSR.
@@ -1430,9 +1430,9 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
 			to_plm = kernel_ip(to) ? X86_BR_KERNEL : X86_BR_USER;
 			type = arch_lbr_br_type_map[type] | to_plm;
 		} else
-			type = branch_type(from, to, cpuc->lbr_entries[i].abort);
+			type = branch_type(from, to, bs->entries[i].abort);
 		if (type != X86_BR_NONE && (br_sel & X86_BR_ANYTX)) {
-			if (cpuc->lbr_entries[i].in_tx)
+			if (bs->entries[i].in_tx)
 				type |= X86_BR_IN_TX;
 			else
 				type |= X86_BR_NO_TX;
@@ -1440,25 +1440,25 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
 
 		/* if type does not correspond, then discard */
 		if (type == X86_BR_NONE || (br_sel & type) != type) {
-			cpuc->lbr_entries[i].from = 0;
+			bs->entries[i].from = 0;
 			compress = true;
 		}
 
 		if ((br_sel & X86_BR_TYPE_SAVE) == X86_BR_TYPE_SAVE)
-			cpuc->lbr_entries[i].type = common_branch_type(type);
+			bs->entries[i].type = common_branch_type(type);
 	}
 
 	if (!compress)
 		return;
 
 	/* remove all entries with from=0 */
-	for (i = 0; i < cpuc->lbr_stack.nr; ) {
-		if (!cpuc->lbr_entries[i].from) {
+	for (i = 0; i < bs->nr; ) {
+		if (!bs->entries[i].from) {
 			j = i;
-			while (++j < cpuc->lbr_stack.nr)
-				cpuc->lbr_entries[j-1] = cpuc->lbr_entries[j];
-			cpuc->lbr_stack.nr--;
-			if (!cpuc->lbr_entries[i].from)
+			while (++j < bs->nr)
+				bs->entries[j-1] = bs->entries[j];
+			bs->nr--;
+			if (!bs->entries[i].from)
 				continue;
 		}
 		i++;
@@ -1476,8 +1476,8 @@ void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr)
 	else
 		cpuc->lbr_stack.hw_idx = intel_pmu_lbr_tos();
 
-	intel_pmu_store_lbr(cpuc, lbr);
-	intel_pmu_lbr_filter(cpuc);
+	intel_pmu_store_lbr(cpuc, lbr, &cpuc->lbr_stack);
+	intel_pmu_lbr_filter(cpuc, &cpuc->lbr_stack);
 }
 
 /*
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index e3ac05c97b5e..9700fb1f47c3 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -852,7 +852,7 @@ struct x86_pmu {
 	unsigned int	lbr_br_type:1;
 
 	void		(*lbr_reset)(void);
-	void		(*lbr_read)(struct cpu_hw_events *cpuc);
+	void		(*lbr_read)(struct cpu_hw_events *cpuc, struct perf_branch_stack *bs);
 	void		(*lbr_save)(void *ctx);
 	void		(*lbr_restore)(void *ctx);
 
@@ -1345,11 +1345,11 @@ void intel_pmu_lbr_enable_all(bool pmi);
 
 void intel_pmu_lbr_disable_all(void);
 
-void intel_pmu_lbr_read(void);
+void intel_pmu_lbr_read(struct perf_branch_stack *bs);
 
-void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc);
+void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc, struct perf_branch_stack *bs);
 
-void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc);
+void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc, struct perf_branch_stack *bs);
 
 void intel_pmu_lbr_save(void *ctx);
 
