Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5F93E42E6
	for <lists+bpf@lfdr.de>; Mon,  9 Aug 2021 11:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234701AbhHIJfl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Aug 2021 05:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234678AbhHIJfi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Aug 2021 05:35:38 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B69FC06179B
        for <bpf@vger.kernel.org>; Mon,  9 Aug 2021 02:35:18 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id gs8so27724554ejc.13
        for <bpf@vger.kernel.org>; Mon, 09 Aug 2021 02:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zUdGMump2UWFWhTKE7J223AILDuinxW6u2xGASPuBak=;
        b=I3AQTEXrs1Ypvdh/NfJ5dPwI7kXzCsA4vpIfrRac281YFW6gX31aJxlNNd0VZDXxh2
         g48TlyO8w+ajNulrRKi5tWvNvuMGnu9VLWT9CqrV4R+tC6W3eStplkyYH0aWis0nJUG0
         vSGlgPcO3RNP2YlJlgLts2T15TxYhB8c6gvZlh6I3YSJ1cprfzcVTlMdCzCGEMaU8IWT
         rBpStECV3oJqKCnQgaMU572DRaUYrTNdQfDZbvF2fw1ZRi1ZQAZo3XaVxCIp9jolTyxP
         Q/RRwN4Ir1N6nZYhqr7tII29uAV8oeKkykyjMUOtkpa41wWZX79G8ygakVWX9cSm6k9h
         1H5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zUdGMump2UWFWhTKE7J223AILDuinxW6u2xGASPuBak=;
        b=KrSjiZeX1lKnrcFqijfVU6daDUWFeSfVSFL1Cn4NaHh8804XjMAShO5R/YRF3iloBU
         KO1fv0TqUriL9uJn3O7vuQ826cIKeDAQphANLy5iID3PXlt00mD4ppoedaM/35vC62hi
         VvOL/LgT58lV7Wp180dVAqTvBuvMCAjcSyujM316gnE/379VsINGEzYo42tBpFWyprZz
         1u2KBdFguOE1MAck+88hiTN+7ecPY4hFQ4Z2Mqx4LCwGA4f+A7r1Y3LDsouK6q4HUzgg
         30YdmNir5K5SP0IhpeWaK376iO0YwDQzvMNdhlzsi/tBtAlJVp5sh1GthyNI1vGgB3M9
         tC4Q==
X-Gm-Message-State: AOAM532wi+r9FZQzYU6PQ0514tpYkIDgJV/yOKuxm95A4AXMn9siR0tz
        s0wTSWvSWV+Z6z/Ny/fJxkjHXQ==
X-Google-Smtp-Source: ABdhPJzyTxuK5wBGFCXksJ9TUSHIWviY75jd8NuV5w9DeBlaY0I27Zv/YBnjY0fh7unkMFutWEJYQw==
X-Received: by 2002:a17:906:a018:: with SMTP id p24mr21453229ejy.349.1628501717082;
        Mon, 09 Aug 2021 02:35:17 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id c8sm1989732ejp.124.2021.08.09.02.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 02:35:16 -0700 (PDT)
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
Subject: [PATCH bpf-next 7/7] x86: bpf: Fix comments on tail call count limiting
Date:   Mon,  9 Aug 2021 11:34:37 +0200
Message-Id: <20210809093437.876558-8-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210809093437.876558-1-johan.almbladh@anyfinetworks.com>
References: <20210809093437.876558-1-johan.almbladh@anyfinetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Before, the comments in the 32-bit eBPF JIT claimed that up to
MAX_TAIL_CALL_CNT + 1 tail calls were allowed, when in fact the
implementation was using the correct limit of MAX_TAIL_CALL_CNT.
Now, the comments are in line with what the code actually does.

Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
---
 arch/x86/net/bpf_jit_comp32.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index 3bfda5f502cb..8db9ab11abda 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -1272,7 +1272,7 @@ static void emit_epilogue(u8 **pprog, u32 stack_depth)
  * ... bpf_tail_call(void *ctx, struct bpf_array *array, u64 index) ...
  *   if (index >= array->map.max_entries)
  *     goto out;
- *   if (++tail_call_cnt > MAX_TAIL_CALL_CNT)
+ *   if (tail_call_cnt++ >= MAX_TAIL_CALL_CNT)
  *     goto out;
  *   prog = array->ptrs[index];
  *   if (prog == NULL)
@@ -1307,7 +1307,7 @@ static void emit_bpf_tail_call(u8 **pprog)
 	EMIT2(IA32_JBE, jmp_label(jmp_label1, 2));
 
 	/*
-	 * if (tail_call_cnt > MAX_TAIL_CALL_CNT)
+	 * if (tail_call_cnt >= MAX_TAIL_CALL_CNT)
 	 *     goto out;
 	 */
 	lo = (u32)MAX_TAIL_CALL_CNT;
@@ -1321,7 +1321,7 @@ static void emit_bpf_tail_call(u8 **pprog)
 	/* cmp ecx,lo */
 	EMIT3(0x83, add_1reg(0xF8, IA32_ECX), lo);
 
-	/* ja out */
+	/* jae out */
 	EMIT2(IA32_JAE, jmp_label(jmp_label1, 2));
 
 	/* add eax,0x1 */
-- 
2.25.1

