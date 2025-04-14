Return-Path: <bpf+bounces-55879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB48A88841
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 18:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2339718990E7
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 16:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC162820BF;
	Mon, 14 Apr 2025 16:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q93PRU+h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAED27F73A
	for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 16:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744647300; cv=none; b=mNBdL5fcaScefkeDMcn+pSahLilnSFq55/rbg3N6cmeY1mnrYx40NdGgVgItQ79KUCehejxhcUnDmB73rlvTRCaaPAO/zOyyP1lgnr/yON366LsuqVh3B8G1mEhfpXDB8lhl43Sc1xTbnmdJlnr6Gf/U8KGUqz5KzyCmJ/cl0JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744647300; c=relaxed/simple;
	bh=tB6K4JQ9EYC9mrriWsSPZ9Q2Zj1Ne9+56vDzR84aFNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EBsqlz41dkecBbAwI+BWhAHBkabv5Ef/3DR/Lb9IH7tip4LgWw4TGC6MHmOTLjffY2SFCChIzcgMqud/1JuygRkFCdYtVSzWgZg9QJWkrlwDJuVj30OC0kKj7sL0scS9wWmkxoGaMUP9X7csVXWVmAFOQbmbCD80Yr5F/OgpY/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q93PRU+h; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-43cf05f0c3eso32378545e9.0
        for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 09:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744647297; x=1745252097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Bm/8t1hj4L/P4KrqCB4L2o8waIgiNgEazkFsHQLKHI=;
        b=Q93PRU+h7goz6wDykcATeDfxqe4KI6yvYegL8ukH/wuU7010Y0V3h3Q7jLEpHgXeqF
         1XURPqxLNWhNFcesfYaSDAcMBRmZBCIIGBe9ScSU/fnXi69G10ZZPHcFusa3tfEnwz5y
         UjrE9El+ZpomE1eN4ri1AiOtMm/WeWuq2T1S71xBm53GykW7Bcp3TUkW6+2LCRmMN8ky
         plisdANHzU1c/Qri5mBbyrlCwgYODYPdC646BimcCX1v8Jd06ob1jxs6npI/5LcdqICc
         HQyFx1nxz/8gmfWFhXcL7JcGMZMzYVsR6zYIpk49ioOcaiQX9Zh32fzDgVGV/LNsaTeV
         YWbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744647297; x=1745252097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Bm/8t1hj4L/P4KrqCB4L2o8waIgiNgEazkFsHQLKHI=;
        b=COjcNQDS6YjLlkRQ1MvR5QyRGgDsdg8IhSpeVglSO7EbmfibvFf2S3UtvycPcBsiKJ
         XuUEcZzTsk1qjUpYvoMQEs8Rwdc0IQjRNv4rz+xWExnfnA5tqjhP5cMpePOMt9tJfSAN
         wkkay+sratgL5dcGcOv+w+Xw3VVn0yMCfRxKlwfXL6IysBm3qOOGAQj8VP58J6RPqaEd
         j8eW7mjQ9eBdsGeGaw68ytYZDGLgQh9s88AEw5oZf1VYcOVnT3rWAS0QBElNhNyWct3G
         aV8nRDNXA0jREb7EXGWBrQMFbF8SLWaUg2PXo5BrODoYvQOkjNnwG6kzA1kSzpyoDvKr
         7txg==
X-Gm-Message-State: AOJu0Yy+n+HhGyy8+4NEIWhIJLnwf5ZVdWFAqz5lYCdKkBLGz2aPoHaz
	P57TQ3i6oSO9aKACEKoxLmLAu0BM3ayEq5MT21knMHyRk9bM8ahhSen2FFnvs5A=
X-Gm-Gg: ASbGncu206uo1kcx8e8aHOjEUbI7E1k4PQa5hHosdseoyOkAlL4d6feQE+052Ixec8P
	PBmYPENQCqP3ghQMHjCst8tMJC85kjdM0U0yRDF08OjiwLWNdxm8GsUbhOvlO7BcF4LUyPFPLuG
	oiSxU+F68vXm6w+ClrCCNUrxUdMhG5DBwJiwOIVQE9JCSl6szd/bMAc6gbHKGPKoL4mQ6XlkCf6
	i/NLnmlo7KeNyq18KNM8Ygfj+LMxCiUhgu95SBMYShbK3Au8eJYD+UUCHiNpM62uLj7gSNmGVul
	UKWYyO+BUrScJnpDHEtW2buTAf4E1PxJ42GCEpGF
X-Google-Smtp-Source: AGHT+IEDDsFE1/+51mJGtrPCGPY/8AXEdVK1XvVjMqT+QlfaHI2OiXPB89ZrHLvdk20zbHU7VT50dQ==
X-Received: by 2002:a05:600c:348f:b0:439:86fb:7340 with SMTP id 5b1f17b1804b1-43f3a9b0264mr129540795e9.30.1744647296645;
        Mon, 14 Apr 2025 09:14:56 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:7::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f20a9f14csm114767355e9.1.2025.04.14.09.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 09:14:56 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next/net v1 09/13] bpf: Report may_goto timeout to BPF stderr
Date: Mon, 14 Apr 2025 09:14:39 -0700
Message-ID: <20250414161443.1146103-10-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250414161443.1146103-1-memxor@gmail.com>
References: <20250414161443.1146103-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2283; h=from:subject; bh=tB6K4JQ9EYC9mrriWsSPZ9Q2Zj1Ne9+56vDzR84aFNs=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBn/TOKNzjKVCzGh1whFtObUVkhyN5IAA+XQnRWUZoT IJXQFPeJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ/0zigAKCRBM4MiGSL8Ryqu2D/ 9IJj2+S60ofgPw/4Jq8LT0twkxx558Np79Flwf6NSvVvjx28OhQvCRlAh+MtwRIDMe9eel8mf4/LqO nKLY/ufiQX7b4/2cMsWo26JwaIVSWRtIHEMFQe53p1LTKpnKGZ6RY9qMuXaHHjMGTf/CA61GIuSxK5 eNtUSO3ha2QPuDiTJQ7z5VvMlph1reo13xUTn2ooC0AFgluBZ9P/6ITiBpi9xCVIe2jSpciVBRpIYw NkQGK+Uy4hmxdRwZ0MFAIyAByHKC/xQw/+iGHbsuLoTtTITroEIhjCgXWghi+gzU+eQRYsWAtFcqeZ Hx6zxcf4un53y9s0M0zibIapC2mlPRFYY1v8H6h8jN8MpIxi1MSRiyrWM6sx7IRGyJNfhnTOPE7TU8 xa3ZyHfPrNBFv8Fk8scjLFfvdC3IXurC8bBMErouC3c7AFQTwKWFUY5Imh2IrwQQVi+n20mcmtaSGa cIeBs+DwbkersLkmXIjzgCQmPMiffWp8ZkpfeAizWxLtE64s3nqTdbXyYUVpG9udBHWMMwJzXLByrT cXStrTF5soldVdzoZxaJaicWafunsHpvpvXs3K2iwv6Pjk40qUC+wZlw/XNQqzqNjJuBHOMmv/ikiF m4ZJgnxOygj+kfcxzMpB3cTqm6pFEJO9zownXi4rStzJTGGiILcU1MAbk9Ng==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Begin reporting may_goto timeouts to BPF program's stderr stream.
Also, pace the reporting frequency by printing at most 64 instances
of any errors, so that we don't end up stressing the allocator and
exhausting memory in case of misbehaving programs.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h |  3 +++
 kernel/bpf/core.c   | 17 ++++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d4687da63645..cf057327798c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1662,6 +1662,7 @@ struct bpf_prog_aux {
 		struct rcu_head	rcu;
 	};
 	struct bpf_stream stream[2];
+	atomic_long_t error_count;
 };
 
 struct bpf_prog {
@@ -3584,6 +3585,8 @@ void bpf_bprintf_cleanup(struct bpf_bprintf_data *data);
 int bpf_try_get_buffers(struct bpf_bprintf_buffers **bufs);
 void bpf_put_buffers(void);
 
+#define BPF_PROG_ERROR_COUNT_MAX 64
+
 void bpf_prog_stream_init(struct bpf_prog *prog);
 void bpf_prog_stream_free(struct bpf_prog *prog);
 __printf(2, 3)
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 1bfc6f7ea3da..cde1be7ffa8b 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3151,6 +3151,19 @@ u64 __weak arch_bpf_timed_may_goto(void)
 	return 0;
 }
 
+static noinline void bpf_prog_report_may_goto_violation(void)
+{
+	struct bpf_prog *prog;
+
+	prog = bpf_prog_find_from_stack();
+	if (!prog)
+		return;
+	if (atomic_long_fetch_add(1, &prog->aux->error_count) >= BPF_PROG_ERROR_COUNT_MAX)
+		return;
+	bpf_prog_stderr_printk(prog, "ERROR: Timeout detected for may_goto instruction\n");
+	bpf_prog_stderr_dump_stack(prog);
+}
+
 u64 bpf_check_timed_may_goto(struct bpf_timed_may_goto *p)
 {
 	u64 time = ktime_get_mono_fast_ns();
@@ -3161,8 +3174,10 @@ u64 bpf_check_timed_may_goto(struct bpf_timed_may_goto *p)
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
-- 
2.47.1


