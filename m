Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C62D3406D31
	for <lists+bpf@lfdr.de>; Fri, 10 Sep 2021 15:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbhIJN4V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Sep 2021 09:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbhIJN4U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Sep 2021 09:56:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12A4C061574;
        Fri, 10 Sep 2021 06:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9ImyjIQib3SxIlByLQNiBXiiPVZK58gAv8kSEMD9sVE=; b=oBN7pCYz8VJ7+hrMhxoU5Oij6M
        i9W2Webo06YujU1PHoBJLxTBPW8Kkv+nVKIMIzqCjQQM62u65SnRjm7yyDtjOPv2VK2vq5EN88IFP
        Tsa9QkKntfCwVt9ZGt7zxrBFNYR49+szBCP971/mWZhp5+ijFB1xv1TfE09+43Yy9N9c+5TBLz2UR
        0HQ8pu9JrbxD8ULdvqdEV7RrLKNt9jT43HhBTOiVcQLRHUhm68uKBuFceDVMTXMa1UetgtLkHl4Sx
        9BdUC2i06YN7mdCzDZsHaCvkvlUJF+AFQM+/1N0YM4k2HG4Pn0gS9HX9Ho5SQkVrx4RVJWIxR8b1E
        /NWTkGGw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOgyi-00B3X5-6o; Fri, 10 Sep 2021 13:54:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5FB4E300047;
        Fri, 10 Sep 2021 15:54:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4025420195557; Fri, 10 Sep 2021 15:54:03 +0200 (CEST)
Date:   Fri, 10 Sep 2021 15:54:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        mingo@redhat.com, kjain@linux.ibm.com, kernel-team@fb.com,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v6 bpf-next 1/3] perf: enable branch record for software
 events
Message-ID: <YTtjeyfJXXiDielu@hirez.programming.kicks-ass.net>
References: <20210907202802.3675104-1-songliubraving@fb.com>
 <20210907202802.3675104-2-songliubraving@fb.com>
 <YTs2MpaI7iofckJI@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTs2MpaI7iofckJI@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 10, 2021 at 12:40:51PM +0200, Peter Zijlstra wrote:

> The below seems to cure that.

Seems I lost a hunk, fold below.

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 9e6d6eaeb4cb..6b72e9b55c69 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -228,20 +228,6 @@ static void __intel_pmu_lbr_enable(bool pmi)
 		wrmsrl(MSR_ARCH_LBR_CTL, lbr_select | ARCH_LBR_CTL_LBREN);
 }
 
-static void __intel_pmu_lbr_disable(void)
-{
-	u64 debugctl;
-
-	if (static_cpu_has(X86_FEATURE_ARCH_LBR)) {
-		wrmsrl(MSR_ARCH_LBR_CTL, 0);
-		return;
-	}
-
-	rdmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
-	debugctl &= ~(DEBUGCTLMSR_LBR | DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
-	wrmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
-}
-
 void intel_pmu_lbr_reset_32(void)
 {
 	int i;
@@ -779,8 +765,12 @@ void intel_pmu_lbr_disable_all(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
-	if (cpuc->lbr_users && !vlbr_exclude_host())
+	if (cpuc->lbr_users && !vlbr_exclude_host()) {
+		if (static_cpu_has(X86_FEATURE_ARCH_LBR))
+			return __intel_pmu_arch_lbr_disable();
+
 		__intel_pmu_lbr_disable();
+	}
 }
 
 void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
