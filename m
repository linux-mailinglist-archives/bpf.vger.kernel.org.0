Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D44D8406A3B
	for <lists+bpf@lfdr.de>; Fri, 10 Sep 2021 12:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbhIJKn2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Sep 2021 06:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbhIJKn0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Sep 2021 06:43:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4097C061574;
        Fri, 10 Sep 2021 03:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DXrJBxKcsbepOR9WSPVVjIBdjJnJxeIocqbecuTYqnY=; b=sZCILqfSU5B2cA/LvNr+NVQ3b1
        WXIZhbzbI6+KLNgARqJ2ZGIA7Ng+uwxf21W2m6YUmeIdg4IeK7V1poYVBhcnbG7QBDhQugjNp70HI
        Qb5tixqfFRSyqlmLOrq4ouQu+IYysbURbekJlNDzb1mmUXCLI5RdAMU28QHLSo+347J0+1g7CN9L/
        HwHz/sCTZv5gqsXPSazUJUDp6HGN3tHrDngCciW2YAyrt+3RGcdm7uViNDyDcquXDQyDDkwQFBWv+
        k2xWdX7juqR6QPp7SdHy/SZvFGBoQO8UkqHPr8VnQphwVpcLDpjq7DvMht+7G4seWS2u9ff/RUvFg
        VHMdQy6A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOdxk-00AvCi-Mc; Fri, 10 Sep 2021 10:41:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 29435300047;
        Fri, 10 Sep 2021 12:40:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 078BF2BC05F1B; Fri, 10 Sep 2021 12:40:51 +0200 (CEST)
Date:   Fri, 10 Sep 2021 12:40:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        mingo@redhat.com, kjain@linux.ibm.com, kernel-team@fb.com,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v6 bpf-next 1/3] perf: enable branch record for software
 events
Message-ID: <YTs2MpaI7iofckJI@hirez.programming.kicks-ass.net>
References: <20210907202802.3675104-1-songliubraving@fb.com>
 <20210907202802.3675104-2-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210907202802.3675104-2-songliubraving@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 07, 2021 at 01:28:00PM -0700, Song Liu wrote:

> +static int
> +intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries, unsigned int cnt)
> +{
> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	intel_pmu_disable_all();
> +	intel_pmu_lbr_read();
> +	cnt = min_t(unsigned int, cnt, x86_pmu.lbr_nr);
> +
> +	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
> +	intel_pmu_enable_all(0);
> +	local_irq_restore(flags);
> +	return cnt;
> +}

So elsewhere you state:

+       /* Given we stop LBR in software, we will waste a few entries.
+        * But we should try to waste as few as possible entries. We are at
+        * about 11 on x86_64 systems.
+        * Add a check for < 15 so that we get heads-up when something
+        * changes and wastes too many entries.
+        */
+       ASSERT_LT(skel->bss->wasted_entries, 15, "check_wasted_entries");

Which is atrocious.. so I disassembled the new function to get horrible
crap. The below seems to cure that.

---
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2143,19 +2143,19 @@ static __initconst const u64 knl_hw_cach
  * However, there are some cases which may change PEBS status, e.g. PMI
  * throttle. The PEBS_ENABLE should be updated where the status changes.
  */
-static __always_inline void __intel_pmu_disable_all(void)
+static __always_inline void __intel_pmu_disable_all(bool bts)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
 	wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL, 0);
 
-	if (test_bit(INTEL_PMC_IDX_FIXED_BTS, cpuc->active_mask))
+	if (bts && test_bit(INTEL_PMC_IDX_FIXED_BTS, cpuc->active_mask))
 		intel_pmu_disable_bts();
 }
 
 static __always_inline void intel_pmu_disable_all(void)
 {
-	__intel_pmu_disable_all();
+	__intel_pmu_disable_all(true);
 	intel_pmu_pebs_disable_all();
 	intel_pmu_lbr_disable_all();
 }
@@ -2186,14 +2186,12 @@ static void intel_pmu_enable_all(int add
 	__intel_pmu_enable_all(added, false);
 }
 
-static int
-intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries, unsigned int cnt)
+static noinline int
+__intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries,
+				  unsigned int cnt, unsigned long flags)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	unsigned long flags;
 
-	local_irq_save(flags);
-	intel_pmu_disable_all();
 	intel_pmu_lbr_read();
 	cnt = min_t(unsigned int, cnt, x86_pmu.lbr_nr);
 
@@ -2203,6 +2201,36 @@ intel_pmu_snapshot_branch_stack(struct p
 	return cnt;
 }
 
+static int
+intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries, unsigned int cnt)
+{
+	unsigned long flags;
+
+	/* must not have branches... */
+	local_irq_save(flags);
+	__intel_pmu_disable_all(false); /* we don't care about BTS */
+	__intel_pmu_pebs_disable_all();
+	__intel_pmu_lbr_disable();
+	/*            ... until here */
+
+	return __intel_pmu_snapshot_branch_stack(entries, cnt, flags);
+}
+
+static int
+intel_pmu_snapshot_arch_branch_stack(struct perf_branch_entry *entries, unsigned int cnt)
+{
+	unsigned long flags;
+
+	/* must not have branches... */
+	local_irq_save(flags);
+	__intel_pmu_disable_all(false); /* we don't care about BTS */
+	__intel_pmu_pebs_disable_all();
+	__intel_pmu_arch_lbr_disable();
+	/*            ... until here */
+
+	return __intel_pmu_snapshot_branch_stack(entries, cnt, flags);
+}
+
 /*
  * Workaround for:
  *   Intel Errata AAK100 (model 26)
@@ -2946,7 +2974,7 @@ static int intel_pmu_handle_irq(struct p
 		apic_write(APIC_LVTPC, APIC_DM_NMI);
 	intel_bts_disable_local();
 	cpuc->enabled = 0;
-	__intel_pmu_disable_all();
+	__intel_pmu_disable_all(true);
 	handled = intel_pmu_drain_bts_buffer();
 	handled += intel_bts_interrupt();
 	status = intel_pmu_get_status();
@@ -6304,9 +6332,15 @@ __init int intel_pmu_init(void)
 		pr_cont("%d-deep LBR, ", x86_pmu.lbr_nr);
 
 		/* only support branch_stack snapshot for perfmon >= v2 */
-		if (x86_pmu.disable_all == intel_pmu_disable_all)
-			static_call_update(perf_snapshot_branch_stack,
-					   intel_pmu_snapshot_branch_stack);
+		if (x86_pmu.disable_all == intel_pmu_disable_all) {
+			if (boot_cpu_has(X86_FEATURE_ARCH_LBR)) {
+				static_call_update(perf_snapshot_branch_stack,
+						   intel_pmu_snapshot_arch_branch_stack);
+			} else {
+				static_call_update(perf_snapshot_branch_stack,
+						   intel_pmu_snapshot_branch_stack);
+			}
+		}
 	}
 
 	intel_pmu_check_extra_regs(x86_pmu.extra_regs);
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1296,6 +1296,14 @@ void intel_pmu_pebs_enable_all(void)
 		wrmsrl(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
 }
 
+void intel_pmu_pebs_disable_all(void)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+
+	if (cpuc->pebs_enabled)
+		__intel_pmu_pebs_disable_all();
+}
+
 static int intel_pmu_pebs_fixup_ip(struct pt_regs *regs)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1240,12 +1240,23 @@ static inline bool intel_pmu_has_bts(str
 	return intel_pmu_has_bts_period(event, hwc->sample_period);
 }
 
-static __always_inline void intel_pmu_pebs_disable_all(void)
+static __always_inline void __intel_pmu_pebs_disable_all(void)
 {
-	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	wrmsrl(MSR_IA32_PEBS_ENABLE, 0);
+}
 
-	if (cpuc->pebs_enabled)
-		wrmsrl(MSR_IA32_PEBS_ENABLE, 0);
+static __always_inline void __intel_pmu_arch_lbr_disable(void)
+{
+	wrmsrl(MSR_ARCH_LBR_CTL, 0);
+}
+
+static __always_inline void __intel_pmu_lbr_disable(void)
+{
+	u64 debugctl;
+
+	rdmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
+	debugctl &= ~(DEBUGCTLMSR_LBR | DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
+	wrmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
 }
 
 int intel_pmu_save_and_restart(struct perf_event *event);
@@ -1322,6 +1333,8 @@ void intel_pmu_pebs_disable(struct perf_
 
 void intel_pmu_pebs_enable_all(void);
 
+void intel_pmu_pebs_disable_all(void);
+
 void intel_pmu_pebs_sched_task(struct perf_event_context *ctx, bool sched_in);
 
 void intel_pmu_auto_reload_read(struct perf_event *event);

