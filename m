Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8123943C5EA
	for <lists+bpf@lfdr.de>; Wed, 27 Oct 2021 11:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241149AbhJ0JCa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Oct 2021 05:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241151AbhJ0JC2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Oct 2021 05:02:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F3AC0613B9
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 02:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:To:From:Date:Message-ID:Sender:Reply-To:Cc:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=zTrjCjnHX9bpXdHyaicQk1ET7be4ygMdSBbtvPxisCM=; b=hSkQL7JYN+MtK9myRrgcDDxi0U
        jV6FsZNTWGkQVspmEM23I5BA2IKJi1IHeKed3ehpWT10s3aFkUCK539n/mMnefl+VeeAWbRGxcItD
        ngIylwn6Xf29LasVKE/Bp9A9SAwcSYgap2AJNNxzmprzTRmD3ZDfmqfgvd9A8g6fx8HhSWvI7GoWR
        CfvaREzh6umtSFf0f+X+bwl2jHPHvbgVqaiNswEYScCQLLpgDOzPktnaNcAUrMjaCWdL0zOoqTkch
        t1ylRap4k0+rOLpotEeUc9G9AmT9daImk49RkOUOnkGaswLlqJkl1LYLFNBbZ8dSjswB4KN92zPOf
        38AOLzRg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfelQ-00HWTK-5B
        for bpf@vger.kernel.org; Wed, 27 Oct 2021 08:58:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8F162300950
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 10:58:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7E994236E43DC; Wed, 27 Oct 2021 10:58:20 +0200 (CEST)
Message-ID: <20211027085520.486795685@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 27 Oct 2021 10:52:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     bpf@vger.kernel.org
Subject: [PATCH bpf-next 07/17] x86/asm: Fix register order
References: <20211027085243.008677168@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Ensure the register order is correct; this allows for easy translation
between register number and trampoline and vice-versa.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/GEN-for-each-reg.h |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/GEN-for-each-reg.h
+++ b/arch/x86/include/asm/GEN-for-each-reg.h
@@ -1,11 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * These are in machine order; things rely on that.
+ */
 #ifdef CONFIG_64BIT
 GEN(rax)
-GEN(rbx)
 GEN(rcx)
 GEN(rdx)
+GEN(rbx)
+GEN(rsp)
+GEN(rbp)
 GEN(rsi)
 GEN(rdi)
-GEN(rbp)
 GEN(r8)
 GEN(r9)
 GEN(r10)
@@ -16,10 +20,11 @@ GEN(r14)
 GEN(r15)
 #else
 GEN(eax)
-GEN(ebx)
 GEN(ecx)
 GEN(edx)
+GEN(ebx)
+GEN(esp)
+GEN(ebp)
 GEN(esi)
 GEN(edi)
-GEN(ebp)
 #endif


