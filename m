Return-Path: <bpf+bounces-58881-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E74A0AC2CDC
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 03:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89CE3542145
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 01:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767E41E1DE2;
	Sat, 24 May 2025 01:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgyZCxsU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9461DF723
	for <bpf@vger.kernel.org>; Sat, 24 May 2025 01:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748049542; cv=none; b=rtSLPlyqYeFGCduA3bNkN/tTr0I0fiQwRWGoKPq3tURLGqnhM2rrO2k4wZy0AjplCVp/a85YEWioyuPgN07vk4TE7fjGgIqXlxb0+IF59ynyNdkWFHFWJNBaGFdtPLCahmKYbbqi6ovbjGiw/+/OP2d5renxrThin76KHvIYvXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748049542; c=relaxed/simple;
	bh=u4+IKDoESnBll+Sikb3PoMvFRtPWx8JuZq29EmvTOpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vn8VrpyOvZoNyQ8DKBaPhwOvQ2FdiBgYKLzbEpVU5PWp3ORaFI9XeffuXY/PW2bUzIYa/DWwatfUswh+5ZttT1rQ0hgYs60zmEPdFY7WMzKq8TL6LlSr6rHLTUKyaozS3y3n94T3eCJFbcjKzFPzEyJbD/cNcqWaUoZfP/vOtWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgyZCxsU; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-3a363d15c64so315283f8f.3
        for <bpf@vger.kernel.org>; Fri, 23 May 2025 18:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748049538; x=1748654338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xafF9ZmSVQpEukTqde76O/rRiBlWs4LIDby7KNcteBY=;
        b=ZgyZCxsU25UmMCcoI7zFgM/GRQnyVWawp5BTThsnvLuFhPgDIOM7ZMZA2jAVCaln9y
         +IVDyuhjulZvO93F75ElqSGiAPfrEu34SsVReT5mKewwhbc5TybxLDeNThsmxB/ZqR/2
         Lsln9m2xwsDnUvWI2jvUYkpv+rCeJwV2gt+k3QiRzzgmKLaDC9JZApX00wZVRqzC9mcJ
         qLv13pY2ul6AnPdpAd2pDJEwh7w4dIF3eay0eKlaTyOVAoQMQXZElQvFrBoym36CAaqc
         WfTf/Kl+0FEx5cWdsQu3cRhDXXNzna0rf1TSGP3tQR5M5/9Eke9Gr0o1wvHvNsxjzi9y
         H6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748049538; x=1748654338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xafF9ZmSVQpEukTqde76O/rRiBlWs4LIDby7KNcteBY=;
        b=ekqHtnEZl5mH7aIIjFoUzBLdyBdZrORDK4HJO8i2Lq+X72d3uWBN+9aKKGvH1M5/f8
         eHfAstDkAOClOYB9AfV3ZGgcxF1+KOish329k4r0fxx+Mol5aGlz9ZvILho6zC/CI18N
         jeFY4RXo6dLC3UEONBqBtAfKtP3S2IpFogn5Me+kaBR8p52E5fULonG58/KPEfVeg7AT
         3hb+di13Oz9MzGHOUMugJBGnhhVryGYJi0K7VCSIQG1ewbuu2mizml97jUzzwTWGrmnS
         GdQGlqn4ggqqC0CYKCztG6EdKNmx/ydFtEdLwfh6m0pgq5u0TPOoD2Vh24wk9gdvlvn9
         YtlQ==
X-Gm-Message-State: AOJu0YzI5RRt36Pk4r1WBkaaWfsMuc9qYn7xQ28MjDBYUf8ds6Rhb+jl
	kcsMIEjZWA1pVX06PmkwEIo71U37KSWt9SM7A/pjq4XCoVOtjLB8PUSyDIDCWoLvzhY=
X-Gm-Gg: ASbGncs7Vg4l8sJ3HzTM4VeWin+K6huaa2fl1W1uZI5FN9Vd8npHSktUjL8CYHOwzQ8
	6VC/9ts6wmQ6iKCvZkA/kX/vIn0vwQSyqOe8MfPcR6Ed03FVYQMoOxf5ayfEMYiZFMSFj2KZhyS
	NGAf7FH4UNgO8/LmxTjXnnjWd9BwSr+h3GAh8/6YzmnVMn3FUXHalevhk8mPRFSOgd5Tu1JpR3I
	VfgE40hI2OeRyNYSfdDI1MKqq9flFbN+Tsg7eFm3QtLrY0swdW+go4eACGBkX0Y4Xlm/PObpZ8g
	VlQnRMQl8BM2yGky7yyp1K3qvnfbIoQwGXku6FaqAw==
X-Google-Smtp-Source: AGHT+IGXsLBUxRPfL2x7zCdfEus39WRZxhIWaNd1ABp5eKBeuelY1RXgW51uGMOTb8KRLrsqRRMzgg==
X-Received: by 2002:a05:6000:2f88:b0:3a2:ffbe:52e3 with SMTP id ffacd0b85a97d-3a4cb444e86mr1015445f8f.21.1748049538125;
        Fri, 23 May 2025 18:18:58 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:74::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca6265fsm28174140f8f.43.2025.05.23.18.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 18:18:57 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 06/11] bpf: Report may_goto timeout to BPF stderr
Date: Fri, 23 May 2025 18:18:44 -0700
Message-ID: <20250524011849.681425-7-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250524011849.681425-1-memxor@gmail.com>
References: <20250524011849.681425-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4354; h=from:subject; bh=u4+IKDoESnBll+Sikb3PoMvFRtPWx8JuZq29EmvTOpE=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoMR3PUb9lZUHWtptGXDIQLAM73ROBBKIUN/JqYpy6 mDwBRL6JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaDEdzwAKCRBM4MiGSL8Rysd4EA CmvdVpNbbEn60hN8uzXsfDA9PAJ4PuMovaYjALKbKcJ8Dt7FDlMkeS7hfkxRYsz41azwwKu8pxfYz/ XbNHuwCPUq+iSNB4e699hAGml0t11Ekifv41yUCeVQ+0lhABURHKJBXSaAdI3i4e7MzcVMG7NS7De1 hU8PZFEdyFl/IEiMrbmMhbrPZWjhYUmmSLbZt1Ic7E0tvEecI9YPY0P3JSSR8gcon/Ghd2OpIxTFJA Tj+DVCBpID3bwYGLVOrTZIDPDrcFCFh1jt/T4czCyLt+hJBkIyJR0mgYFgos9qxxIYFgj5NI6jufq+ ywpXEQoq9iXyRrKz2IOrDRxtlmJmwT2aN1aHDF0DUWFYPxMYGYnVYvhPP51/VwwTegnprP1vo08HmE VuufBCTfTE9kY4Vpon1KeXdVyyWLzLucOBd+tIH5WZYKkQgDRm5myqRVZwbl6v05HPYjzBDSUg9bvt R0/lO9YmpF32teoJNjcf4cFKYPn3VXs0NA8dMqz2JDnsm8739rDIbHPlziQlB9TQM7rOKUnuU2a8bM ACErCo1doNbajQyZz3jMitJsEziPnevdggjk+QuYUHMn12mGS1nnQ9CqY894+akHmANLWJoDyqSCZO 8J5mRjfojdh/v+ZEJrgZpWN2wmTmxKJ0zdxU0+b3GhlgYWu2IKvLxuylWZKA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Begin reporting may_goto timeouts to BPF program's stderr stream.
Make sure that we don't end up spamming too many errors if the
program keeps failing repeatedly and filling up the stream, hence
emit at most 512 error messages from the kernel for a given stream.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h | 21 ++++++++++++++-------
 kernel/bpf/core.c   | 19 ++++++++++++++++++-
 kernel/bpf/stream.c |  5 +++++
 3 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index aab5ea17a329..3449a31e9f66 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1682,6 +1682,7 @@ struct bpf_prog_aux {
 		struct rcu_head	rcu;
 	};
 	struct bpf_stream stream[2];
+	atomic_t stream_error_cnt;
 };
 
 struct bpf_prog {
@@ -3604,6 +3605,8 @@ void bpf_bprintf_cleanup(struct bpf_bprintf_data *data);
 int bpf_try_get_buffers(struct bpf_bprintf_buffers **bufs);
 void bpf_put_buffers(void);
 
+#define BPF_PROG_STREAM_ERROR_CNT 512
+
 void bpf_prog_stream_init(struct bpf_prog *prog);
 void bpf_prog_stream_free(struct bpf_prog *prog);
 int bpf_prog_stream_read(struct bpf_prog *prog, enum bpf_stream_id stream_id, void __user *buf, int len);
@@ -3615,16 +3618,20 @@ int bpf_stream_stage_commit(struct bpf_stream_stage *ss, struct bpf_prog *prog,
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
index 959538f91c60..8e74562e4114 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3160,6 +3160,21 @@ u64 __weak arch_bpf_timed_may_goto(void)
 	return 0;
 }
 
+static noinline void bpf_prog_report_may_goto_violation(void)
+{
+#ifdef CONFIG_BPF_SYSCALL
+	struct bpf_prog *prog;
+
+	prog = bpf_prog_find_from_stack();
+	if (!prog)
+		return;
+	bpf_stream_stage(prog, BPF_STDERR, ({
+		bpf_stream_printk("ERROR: Timeout detected for may_goto instruction\n");
+		bpf_stream_dump_stack();
+	}));
+#endif
+}
+
 u64 bpf_check_timed_may_goto(struct bpf_timed_may_goto *p)
 {
 	u64 time = ktime_get_mono_fast_ns();
@@ -3170,8 +3185,10 @@ u64 bpf_check_timed_may_goto(struct bpf_timed_may_goto *p)
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
index cebd596671cd..c72b9480008c 100644
--- a/kernel/bpf/stream.c
+++ b/kernel/bpf/stream.c
@@ -537,3 +537,8 @@ int bpf_stream_stage_dump_stack(struct bpf_stream_stage *ss)
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


