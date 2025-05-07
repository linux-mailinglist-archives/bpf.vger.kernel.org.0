Return-Path: <bpf+bounces-57677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D34D3AAE794
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 19:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 217894E683D
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 17:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81D128C5D0;
	Wed,  7 May 2025 17:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYRbwkUN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64A01D5ABA
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 17:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746638254; cv=none; b=moIRaG6U9Gyr1MN6juYM5n8otNRrX7SLDaZ19O93GmiptTZ4PdjKmWm7DSfn+1pNo9nh7taXnCnUtQlAJAyTqBQ9U45sY4zVquPmBjqfmqBXFnSL9jm1KyQx0G0Rm5h0ctBrUxWZjqlGRKjtIGgNWQpaUGl6N7CU3g4EoFKmkAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746638254; c=relaxed/simple;
	bh=zJdgrVS4WPKNsMv/n923x4hX2eFFZRCXrz7VowKS1cU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pc0NLXrEt20aHfeZDsXtacxR2obXWKxhFG7MgbcP2INdBQSZ+WhUdtcWWSHTYxUp12nzF3I1MJ0pidRxf1wx4UUu3npB03nwRoYTx3yOe/VuiC3UxZTgKC7QjZ/w2Oy4mutq6y6XJZByjh4pq4FbtBREm3QQ0bNiscBbbQHGurw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYRbwkUN; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-39ee5a5bb66so78674f8f.3
        for <bpf@vger.kernel.org>; Wed, 07 May 2025 10:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746638251; x=1747243051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kf2a/uhJsacZ2V037A5YffZ38/QWJBiN/SKNkr4IUpg=;
        b=CYRbwkUNwVhnuErnprN7MMoaefL3gHVtix1lmSlaBiK+BnaDLLBKyNiCbKLDRK2OrA
         TxBgP8wXco+3we1qMsgPTJLo/rwQR7Nnn+lLdicxW+UO5dOVTt1PrLbbQTG1lOZ5yU1B
         0/dhRtEpCUrb2Vx4n95ZrHoMUgaS/qU5hIe3jVOWuWn0lzLS40R/GCNlZiCX58GTMJWa
         ftsDwqgOyMENuUmDFoHz2UxHL3uDJIh2kb2VwIWckgVZviknRHjF6Nqt1aGknVEapxcd
         lR4Q4bLKqvkYulleBXSfN/SOD0oPkiefGcQg30LeBjN0ZggjAx0LZtbDNkRb8deanVya
         A0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746638251; x=1747243051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kf2a/uhJsacZ2V037A5YffZ38/QWJBiN/SKNkr4IUpg=;
        b=hTDajahIHGYbCn5ykzluAs8PDwGT/5+tE5lPsRpWOS0A0U3wX3Gc6WHyiZmV6wplfK
         ke/KjZ/l1M3X6X9Xw2MY9Ftbtuj7KJNOsAFFp+vIECVI15GLr9Z0gjriYFrDHMA/9m0k
         rBr2/bp/Q9EvZu3xstNVRUGyD8aj7NtwCpEqfCA/c9oC3rBCLzp932AHn1StsQQlmYk9
         CDxebSiZWj8xMaXjZJtzHTHp+Fl6koUn2dEW1qEubRKSlPQGEdGFaA4YVDrnhDfPYXBU
         JVIJjvwJate2PZXvuVFudemDflNMFGkmKdDvTcdYOcrgnQWRf3jaN6Wxdw4d6b4dF5nI
         Oinw==
X-Gm-Message-State: AOJu0YzVygFRFhjUW8Te1PXIWXISZ5HvLlSKqqlIrpzYZJuweqikXcxo
	MfdvWtknrJWh09rCqnzTBNVEjEzYJGfmYJtNdN9kYCGBXbaLqVbpH+oXf7v4nGw=
X-Gm-Gg: ASbGnctDeoRFUezBCC3seO4uECDET1sflccPjoSdbhvunRTFQXaFEUR4klQ+QaU9km2
	m0rEriKYWsjp96MdU+ewGs1VC4Bmrq/Nv/SuQuxefxVt/wEB7BLZ2+rJ3B0i73+0j82fclUsWWm
	xcuzfmSWrpQ2Wv2YBVE+68uEjebVAGqAGcCFwZv17NgQkgw/ocKgpweCesw5C+4L99Tjzosl//F
	IWF5fGsy7WRwoNKRnDc1ekKmbJ/llhkbfBZ/fXDLM+DtsGHUNruO0a2sEdKGY37WVrG5Ke0jYqj
	tffjqjKBB4x7X2BCp6pNBoyIL2PJvc10OR3Xiz3/FA==
X-Google-Smtp-Source: AGHT+IEJAyCSGnhvI8XzzZ9OGEleyAixKULwqS1EZj0RMt4zr3fIvRlxl/vRnGAZ4/5Yhm8PvRWBbw==
X-Received: by 2002:a5d:64e8:0:b0:3a0:7d82:d454 with SMTP id ffacd0b85a97d-3a0b49ac335mr3501732f8f.20.1746638250767;
        Wed, 07 May 2025 10:17:30 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:4b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd350cebsm7391735e9.17.2025.05.07.10.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 10:17:29 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 06/11] bpf: Report may_goto timeout to BPF stderr
Date: Wed,  7 May 2025 10:17:15 -0700
Message-ID: <20250507171720.1958296-7-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250507171720.1958296-1-memxor@gmail.com>
References: <20250507171720.1958296-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4162; h=from:subject; bh=zJdgrVS4WPKNsMv/n923x4hX2eFFZRCXrz7VowKS1cU=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoG5WJrmQvCTYcr+T8H1y4EmzIdyl5yRYjnD55kIc+ qlFS+f6JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaBuViQAKCRBM4MiGSL8RypQBEA CsuikSSENz7m44Q70Ty5hKOCg0VL7ckz1M7hVUAy4oFSQyeEntrVX/MvNYkL/rlb+x3gBpFgvumIHX 87OOs+TWQTkC8d3bJq90Q0kqOJ3UQR0Gwe64qIRGF+lS+ESciR8j1EP609OfzF9BIpmkOB2ifAQcP0 uoy42BHHiDmTEJrzpAEdD4218YEAFYzHHLgcJbjahtoEW9P4DI8P033IONa0oVRTVZAEMqeAiCpEnQ iMAjuQwhJJX8OvFymNl1jzcPCDi7z5IKFc7L1DyKDg5i5sTQMpB6ibFSJEUH8rFSU9d8nRRthtj6Ae 8cbqIsWMbChR8hzd5XhDfTdRN5EacWb6JpJe30EWewjzBnMAuQczb610BA57go566Dqzq/cun+SxTb wwlQRf1DdV6SMSZG3RUhZ0J3iPvpOfWqh7ERfbTJXuFDJQwsa+C4rirki1WLsD0AKBZvtRhvdqMCst Jl7Yh5muVGWVShqugpbPZcuOfKgnqM7Kcrl+s/59uXuxrVETkhCMYiPu8tpeL8uJ9VHimdHTIMt74p x5ggIQGwkc2d70mz41o0ov4TmmuRsAGJWWhXoc25AjvfUW8xZKJoJ1JTujWjcxT4sDXQ9kJoVeDDW2 8fiuM1tz6t3a7w5LcJOkVhl1FSnDyYghqhEA2fM+bxaHqMYemE0ZHPPxsT3w==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Begin reporting may_goto timeouts to BPF program's stderr stream.
Make sure that we don't end up spamming too many errors if the
program keeps failing repeatedly and filling up the stream, hence
emit at most 512 error messages from the kernel for a given stream.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h | 21 ++++++++++++++-------
 kernel/bpf/core.c   | 17 ++++++++++++++++-
 kernel/bpf/stream.c |  5 +++++
 3 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 46ce05aad0ed..daf95333be78 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1667,6 +1667,7 @@ struct bpf_prog_aux {
 		struct rcu_head	rcu;
 	};
 	struct bpf_stream stream[2];
+	atomic_t stream_error_cnt;
 };
 
 struct bpf_prog {
@@ -3589,6 +3590,8 @@ void bpf_bprintf_cleanup(struct bpf_bprintf_data *data);
 int bpf_try_get_buffers(struct bpf_bprintf_buffers **bufs);
 void bpf_put_buffers(void);
 
+#define BPF_PROG_STREAM_ERROR_CNT 512
+
 void bpf_prog_stream_init(struct bpf_prog *prog);
 void bpf_prog_stream_free(struct bpf_prog *prog);
 
@@ -3600,16 +3603,20 @@ int bpf_stream_stage_commit(struct bpf_stream_stage *ss, struct bpf_prog *prog,
 			    enum bpf_stream_id stream_id);
 int bpf_stream_stage_dump_stack(struct bpf_stream_stage *ss);
 
+bool bpf_prog_stream_error_limit(struct bpf_prog *prog);
+
 #define bpf_stream_printk(...) bpf_stream_stage_printk(&__ss, __VA_ARGS__)
 #define bpf_stream_dump_stack() bpf_stream_stage_dump_stack(&__ss)
 
-#define bpf_stream_stage(prog, stream_id, expr)                  \
-	({                                                       \
-		struct bpf_stream_stage __ss;                    \
-		bpf_stream_stage_init(&__ss);                    \
-		(expr);                                          \
-		bpf_stream_stage_commit(&__ss, prog, stream_id); \
-		bpf_stream_stage_free(&__ss);                    \
+#define bpf_stream_stage(prog, stream_id, expr)                          \
+	({                                                               \
+		struct bpf_stream_stage __ss;                            \
+		if (!bpf_prog_stream_error_limit(prog)) {                \
+			bpf_stream_stage_init(&__ss);                    \
+			(expr);                                          \
+			bpf_stream_stage_commit(&__ss, prog, stream_id); \
+			bpf_stream_stage_free(&__ss);                    \
+		}                                                        \
 	})
 
 #ifdef CONFIG_BPF_LSM
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index dcb665bff22f..d21c304fe829 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3156,6 +3156,19 @@ u64 __weak arch_bpf_timed_may_goto(void)
 	return 0;
 }
 
+static noinline void bpf_prog_report_may_goto_violation(void)
+{
+	struct bpf_prog *prog;
+
+	prog = bpf_prog_find_from_stack();
+	if (!prog)
+		return;
+	bpf_stream_stage(prog, BPF_STDERR, ({
+		bpf_stream_printk("ERROR: Timeout detected for may_goto instruction\n");
+		bpf_stream_dump_stack();
+	}));
+}
+
 u64 bpf_check_timed_may_goto(struct bpf_timed_may_goto *p)
 {
 	u64 time = ktime_get_mono_fast_ns();
@@ -3166,8 +3179,10 @@ u64 bpf_check_timed_may_goto(struct bpf_timed_may_goto *p)
 		return BPF_MAX_TIMED_LOOPS;
 	}
 	/* Check if we've exhausted our time slice, and zero count. */
-	if (time - p->timestamp >= (NSEC_PER_SEC / 4))
+	if (unlikely(time - p->timestamp >= (NSEC_PER_SEC / 4))) {
+		bpf_prog_report_may_goto_violation();
 		return 0;
+	}
 	/* Refresh the count for the stack frame. */
 	return BPF_MAX_TIMED_LOOPS;
 }
diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
index a921fb1de319..eaf0574866b1 100644
--- a/kernel/bpf/stream.c
+++ b/kernel/bpf/stream.c
@@ -539,3 +539,8 @@ int bpf_stream_stage_dump_stack(struct bpf_stream_stage *ss)
 	ret = ret ?: ctx.err;
 	return ret ?: bpf_stream_stage_printk(ss, "\n");
 }
+
+bool bpf_prog_stream_error_limit(struct bpf_prog *prog)
+{
+	return atomic_fetch_add(1, &prog->aux->stream_error_cnt) >= BPF_PROG_STREAM_ERROR_CNT;
+}
-- 
2.47.1


