Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A077943C5E9
	for <lists+bpf@lfdr.de>; Wed, 27 Oct 2021 11:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241150AbhJ0JC3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Oct 2021 05:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241149AbhJ0JC2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Oct 2021 05:02:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D28C061767
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 02:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:To:From:Date:Message-ID:Sender:Reply-To:Cc:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=7cf9h23TD3nPfQF5SaN1Z4UwfMkhhq2LV+J3X/o4Dq8=; b=Wg87KlpYvNcWuenUv9+5a4NCTO
        SFQGCLnIbIsGrT2YH+pLU0bRigf2e6BWCXakEykV08gnHPt/nFLgNC3Bu+9WyIYkBfQktc2y9nkxE
        Fz4CrCK3sZAM2tu49TKd3mye2YKOf7Jo9ovL0guyaa8+ED9Pjgd/uDm6vtQL/hPihKXnWLSZsK8X0
        DYhkVSq3a3iQWV463EDZiH6sVvkoHDOvsBfufPL0mBjopdSdSXpUnQBsEnhRjLRQGWl9XFao6atr3
        DKHWyF2JnfLcGkUT0hr0v+I3u5DSMkREjoW3Ke3XGepwCT9VI/mwcttk4h/bj1deBKrijS9NpCg1Y
        d1C7Zh+A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfelT-00HWU2-6v
        for bpf@vger.kernel.org; Wed, 27 Oct 2021 08:58:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BACD030220B
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 10:58:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id AC481236E43DC; Wed, 27 Oct 2021 10:58:20 +0200 (CEST)
Message-ID: <20211027085521.072502199@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 27 Oct 2021 10:52:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     bpf@vger.kernel.org
Subject: [PATCH bpf-next 15/17] x86,bugs: Unconditionally allow spectre_v2=retpoline,amd
References: <20211027085243.008677168@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently Linux prevents usage of retpoline,amd on !AMD hardware, this
is unfriendly and gets in the way of testing. Remove this restriction.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/cpu/bugs.c |    7 -------
 1 file changed, 7 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -882,13 +882,6 @@ static enum spectre_v2_mitigation_cmd __
 		return SPECTRE_V2_CMD_AUTO;
 	}
 
-	if (cmd == SPECTRE_V2_CMD_RETPOLINE_AMD &&
-	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON &&
-	    boot_cpu_data.x86_vendor != X86_VENDOR_AMD) {
-		pr_err("retpoline,amd selected but CPU is not AMD. Switching to AUTO select\n");
-		return SPECTRE_V2_CMD_AUTO;
-	}
-
 	spec_v2_print_cond(mitigation_options[i].option,
 			   mitigation_options[i].secure);
 	return cmd;


