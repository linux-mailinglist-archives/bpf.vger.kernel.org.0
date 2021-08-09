Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F43C3E42DE
	for <lists+bpf@lfdr.de>; Mon,  9 Aug 2021 11:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbhHIJff (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Aug 2021 05:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234665AbhHIJfe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Aug 2021 05:35:34 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C05C0613D3
        for <bpf@vger.kernel.org>; Mon,  9 Aug 2021 02:35:13 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id x14so1050626edr.12
        for <bpf@vger.kernel.org>; Mon, 09 Aug 2021 02:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zTHGmLGouU4onJNlIUfhsVpstydj2zsoOFj28SOcX2I=;
        b=AsmMb0l1iIz/FbTwdxzIK/MmEhR8aE+v2biehMPNoBacgy0P8h0nEnKVQSxZm6UcfZ
         s9UBA/ZcHKc9BGCQLDWt9oDF9iEhDoy4i8+vVtFfPvN7qRxZcJ/rA/hCZM+newx7krGk
         yidWXthlsTvdgy2goJGOqYgJeip0oKPUJTVk/u2K1qwRhbZCJGq6s/TDIJhkmdhlokry
         /bCec6Nz4QxgsE8BLhpdTkTE7VlGhfJs5GU+3FHmG5Y4rRx4sn3AqDfcQ7ZRf61oKBEP
         wN8GN4NSy57T98MKKll/4n3rBW2/czgFcydK7OqUUtZZKxMbJId7loF2ErWnjQ9f2V59
         6yzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zTHGmLGouU4onJNlIUfhsVpstydj2zsoOFj28SOcX2I=;
        b=hd6z3cyeg80yjf2IcAn3Vg0ecGhSQAQUf2TzEMffTcIpEK9b5QMjkZLcqKZaNoXR6D
         +E26mREm/VsU9d1nN+2hUi+99A0JWbMivT1vNxsPNjCI4TlgqE/Md24W1gKfimlDfkt0
         KgNz0XQf8ANbJujA+S4gkbNk1OKtqzHkFC4NISEDzzqWyTJcX/p/KFeWlT1rlAi4b6a9
         nytLHY3BLlQn9vPJXEtz0zaQE0RkzvfUsKWhFuj0LJ3flYi9QqdSIgrNodGJQ3jHSbNc
         DpA4taCE6Hm+qJ3AiVE2R53QnSvRuTSrEBz7Izr5iB4DOX9i6UAkQYZr/cQhKtts50M8
         q1TA==
X-Gm-Message-State: AOAM532SCqqKibsJWGPiPS1oS3r/ungfm6WGIIEu7JzLO7VVhLIFA8dO
        WHNdL/2PQexJVosnXLWkU1v74g==
X-Google-Smtp-Source: ABdhPJw2NYrzipLDFdyGBZ/wzTS6WLyxGQTpv32qMIVFb9661DjUwT8fRBeleuy37oJGVX86uzt+5g==
X-Received: by 2002:aa7:d40f:: with SMTP id z15mr777078edq.113.1628501711748;
        Mon, 09 Aug 2021 02:35:11 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id c8sm1989732ejp.124.2021.08.09.02.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 02:35:11 -0700 (PDT)
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
Subject: [PATCH bpf-next 3/7] powerpc: bpf: Fix off-by-one in tail call count limiting
Date:   Mon,  9 Aug 2021 11:34:33 +0200
Message-Id: <20210809093437.876558-4-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210809093437.876558-1-johan.almbladh@anyfinetworks.com>
References: <20210809093437.876558-1-johan.almbladh@anyfinetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Before, the eBPF JITs allowed up to MAX_TAIL_CALL_CNT + 1 tail calls.
Now, precisely MAX_TAIL_CALL_CNT is allowed, which is in line with the
behaviour of the interpreter. Verified with the test_bpf test suite
on qemu-system-ppc and qemu-system-ppc64, respectively.

Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
---
 arch/powerpc/net/bpf_jit_comp32.c | 4 ++--
 arch/powerpc/net/bpf_jit_comp64.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
index beb12cbc8c29..6d720728df09 100644
--- a/arch/powerpc/net/bpf_jit_comp32.c
+++ b/arch/powerpc/net/bpf_jit_comp32.c
@@ -221,13 +221,13 @@ static void bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32
 	PPC_BCC(COND_GE, out);
 
 	/*
-	 * if (tail_call_cnt > MAX_TAIL_CALL_CNT)
+	 * if (tail_call_cnt >= MAX_TAIL_CALL_CNT)
 	 *   goto out;
 	 */
 	EMIT(PPC_RAW_CMPLWI(_R0, MAX_TAIL_CALL_CNT));
 	/* tail_call_cnt++; */
 	EMIT(PPC_RAW_ADDIC(_R0, _R0, 1));
-	PPC_BCC(COND_GT, out);
+	PPC_BCC(COND_GE, out);
 
 	/* prog = array->ptrs[index]; */
 	EMIT(PPC_RAW_RLWINM(_R3, b2p_index, 2, 0, 29));
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index b87a63dba9c8..2f4d24ed90a4 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -227,12 +227,12 @@ static void bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32
 	PPC_BCC(COND_GE, out);
 
 	/*
-	 * if (tail_call_cnt > MAX_TAIL_CALL_CNT)
+	 * if (tail_call_cnt >= MAX_TAIL_CALL_CNT)
 	 *   goto out;
 	 */
 	PPC_BPF_LL(b2p[TMP_REG_1], 1, bpf_jit_stack_tailcallcnt(ctx));
 	EMIT(PPC_RAW_CMPLWI(b2p[TMP_REG_1], MAX_TAIL_CALL_CNT));
-	PPC_BCC(COND_GT, out);
+	PPC_BCC(COND_GE, out);
 
 	/*
 	 * tail_call_cnt++;
-- 
2.25.1

