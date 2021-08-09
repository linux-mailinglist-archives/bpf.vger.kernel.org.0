Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3003E42DD
	for <lists+bpf@lfdr.de>; Mon,  9 Aug 2021 11:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbhHIJfe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Aug 2021 05:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234680AbhHIJfc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Aug 2021 05:35:32 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68A5C0613CF
        for <bpf@vger.kernel.org>; Mon,  9 Aug 2021 02:35:11 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id y12so23595017edo.6
        for <bpf@vger.kernel.org>; Mon, 09 Aug 2021 02:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sh4cRycWMWzCRbwiJkF7TB0944OQB2vAB6mEODY+LIg=;
        b=UQLPkMecDxAZpR9aawXrXnanYl9BJUEr9P94N1ku9/joi9jSxjkfM8192rdduNtFW3
         RGpyk2HYyTLTjqhluWXfD1V13U7wh5KwZyha4weRHIqpT8qAz8ujBcwKhemXhsz9uOHS
         7CTmYfwM/Rd6zjg29OamtWlDALGITRyPIDL8e8hU0Mtu/dt4Way3dXmEo9DtqMc2ehAZ
         BDuGU0P6pryHmdgpmFDES27DRgl44cK/xXvBIrZhKytlGSoToCrEL2W0DmWQlCO4BQpJ
         VJcBcxxfCoanBSDOPd5ROO6Tbu3Igv8J6yts+DDcjjb/RPz1jEF7X+mHUSXVg4NyQPnp
         FDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sh4cRycWMWzCRbwiJkF7TB0944OQB2vAB6mEODY+LIg=;
        b=gCqoPy1DNjf86mF6PPyIMIke9NzVwHN7fMMgbeN39YFnQqFNCPHGExMcSUTTmOB2Gc
         OhHtUS9ReFSv2xDCeXaVR1WGRl1QxpszCBzN3T38UznmdN1Pl5X1CDD2wuWQXv9G0KaL
         GWCNDST4H3y4iiv0S/8L+sCp8EyEsDuC40ZQvbxTH+WAbOFVvF4jc8p6D+MUHWgnHLqi
         5rqG+RpccVNR17hf/A+MyPC9f0vHBGk77OuchW9EQwBIpBnu9ucPUeUPnWjIpked2TGU
         ef5gpFpfvRTq68JzRJFMScl2X7zq152g9fylygjAkpAS0Cuf0CiJOadcfZwROwSTfpo7
         yxfw==
X-Gm-Message-State: AOAM533dVKn2IBL2y0ZT1GQXeYuX47IgnqlfWb6ReocUzix+TvZyYTBn
        1QaD86Qn3JNStn9Eyu3UsxOVZg==
X-Google-Smtp-Source: ABdhPJwukWaouuhkMqhAfHZRo40lEF5CPK9OrONFO8LhcrFR7OMhHw2Ea+L3a6BBHTvJO3055LHlpA==
X-Received: by 2002:a05:6402:c1b:: with SMTP id co27mr28669384edb.147.1628501710408;
        Mon, 09 Aug 2021 02:35:10 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id c8sm1989732ejp.124.2021.08.09.02.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 02:35:10 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        illusionist.neo@gmail.com, zlim.lnx@gmail.com,
        paulburton@kernel.org, naveen.n.rao@linux.ibm.com,
        sandipan@linux.ibm.com, luke.r.nels@gmail.com, bjorn@kernel.org,
        iii@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        davem@davemloft.net, udknight@gmail.com,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH bpf-next 2/7] arm64: bpf: Fix off-by-one in tail call count limiting
Date:   Mon,  9 Aug 2021 11:34:32 +0200
Message-Id: <20210809093437.876558-3-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210809093437.876558-1-johan.almbladh@anyfinetworks.com>
References: <20210809093437.876558-1-johan.almbladh@anyfinetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Before, the eBPF JIT allowed up to MAX_TAIL_CALL_CNT + 1 tail calls.
Now, precisely MAX_TAIL_CALL_CNT is allowed, which is in line with the
behaviour of the interpreter. Verified with the test_bpf test suite
on qemu-system-aarch64.

Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
---
 arch/arm64/net/bpf_jit_comp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 41c23f474ea6..cda53e33bbec 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -286,11 +286,11 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	emit(A64_CMP(0, r3, tmp), ctx);
 	emit(A64_B_(A64_COND_CS, jmp_offset), ctx);
 
-	/* if (tail_call_cnt > MAX_TAIL_CALL_CNT)
+	/* if (tail_call_cnt >= MAX_TAIL_CALL_CNT)
 	 *     goto out;
 	 * tail_call_cnt++;
 	 */
-	emit_a64_mov_i64(tmp, MAX_TAIL_CALL_CNT, ctx);
+	emit_a64_mov_i64(tmp, MAX_TAIL_CALL_CNT - 1, ctx);
 	emit(A64_CMP(1, tcc, tmp), ctx);
 	emit(A64_B_(A64_COND_HI, jmp_offset), ctx);
 	emit(A64_ADD_I(1, tcc, tcc, 1), ctx);
-- 
2.25.1

