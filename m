Return-Path: <bpf+bounces-62337-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E617AF8218
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 22:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03CF04A83FF
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 20:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D712BE7B2;
	Thu,  3 Jul 2025 20:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6KvzkPs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC60D29B8E5
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 20:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751575717; cv=none; b=ZKYLDJtST+Aboal6Kt+YoLq/0K1sC0fpKteGUPAurcXjpi5DE7FiKjEKmo6bO4E09nmeh0ZdwMec4TzJ7BRnDiZjkQaVmnvJXyofeQN3ZTW5U3Px9pAspbaXdeVomeocZBDqbUbOphRfvEUPKYswU/FYVMvypaRrAgOY04A1BhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751575717; c=relaxed/simple;
	bh=E6+Abt1CLjBnfHopnHo3JheIACRIUpzwaEfydiovcAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C/uFjxkZ1cCOwWL6WOq9rTcjI/L6sU/T+ZDKiIjc80dKG8favwPaWW9IovzrMTPTdE+T60g+6hKVHQop5DCB8/kvo0RZrfP+zHm6iH3NYGbeu8EOTxUt9KlhLGnpT3zJu8rVhcvaE9j6vH+3l2UMTw22q/jnkswyP0OAdgd5RX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6KvzkPs; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-ae0e0271d82so45613966b.3
        for <bpf@vger.kernel.org>; Thu, 03 Jul 2025 13:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751575714; x=1752180514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MP9qvTbmB9HSbruzCn7iOi1BHB5iOvDeoz14rVAjLYI=;
        b=M6KvzkPsyuw28/6pAh5aZC0wbm8ctKJWDaC0NkuNIXGeBNxEfe1NrwlEzud6FokQmq
         1JWtLpxsHTaTfAXJezI6Y7QlJ9G5QqeO1e0T5EYy9l8qiK/Z7ruZAuPrq++0Penyv1kj
         ZWIJn5GSILcIgEidfCJtLPfhbvXe+7LeTrOkEFpuS6c2VkJOqNWVcmJrnpqTmj3BAEFC
         oihWJgOuAxuQv8vIC7bDH3yIMNJC7xUO1jt1OON4FcMI7DDxg649gc7CZjRjvL/DsCpF
         ltnxQhrQ9z8WIwEB1OHNIa9KaNqSafw4OJmogrhIZxzfTAEab6oQqD+b+P2bec7iz08Q
         s17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751575714; x=1752180514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MP9qvTbmB9HSbruzCn7iOi1BHB5iOvDeoz14rVAjLYI=;
        b=PE/buQ4+eu1rPskgwyfE80aNBKOCSpAWp9fGgxeUDsAJIkhyhudO2GISYqcRcIl2hv
         abYwy0tK2YqBIaQxqubmYvoujubKzsNTBl0PfD59i2uo0Z8n5e7e33vSX/ucnoxR6Ag6
         iyT2Ea3wY5K/aa1HfukNSLWeinc0C0LLfwzmxi01RljYeocZbAPcRc7VbVdCshUWUYvm
         +ce2MX9KGmaRzvdbAoMmTQxEU+qOWWvzsfZ/o4lZ7LZdIqbDHSqiQV37ShS8r+QRugz7
         enFbL5x9+qiZZ8nPRZTLpkn5rjC8x+fgUiMgpIlTIrtHrCYcryJ0vwOePXEfGAySesKY
         pcaw==
X-Gm-Message-State: AOJu0YyQTMYqXptMRQL+VFclhfokXfZqrx72KpqoLJc2Ref+OZAgvYPa
	cvmvh4GhV2zTN7upPewG0pMYZOS6+jgkCfLs7ET26gBlh/glyZdmqlxtwbojAjzIrVo=
X-Gm-Gg: ASbGncuX9BxBFTrVhTAeVvq1t3Rb5EuBwMEn26KcVLEcqPZ36NwelQ+kRlY7e+oGlHH
	SRHyFJIxgl044yED+X14w7jB1nxqAi/ZBcex3AJLWiIEGMhT1BCZQ5jOR58rPyQUPGYSuI3aZ0B
	+EeGz+QhIBFTEmRlNXcRIgRdXlACoyT2qRkaqOw9l8jOi5lGdARaeYB99AervumepBSUxrPjoCA
	aUpU7v3ySWagE4QvvmGiYbF7uH6PkTLEN1A5YqXaBjUFgB5nHN5f4GjwFcagsOL4d2Lk4afw3Ql
	9319liRikucCUPzAHNSpTX3pI494YlMw8gNRWumn7PzYwntUh4N1JqxS0hlcDA==
X-Google-Smtp-Source: AGHT+IErKneVbPcpw8k3AArB4UwinkKsjRhMqZ1pmOdQGc75PlhYPzhr6qssLQ3HlYRwIdktFB12OA==
X-Received: by 2002:a17:906:7309:b0:ae0:9363:4d5d with SMTP id a640c23a62f3a-ae3c2a82173mr843504066b.2.1751575713626;
        Thu, 03 Jul 2025 13:48:33 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6bb1418sm36665566b.183.2025.07.03.13.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 13:48:33 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Barret Rhoden <brho@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 07/12] bpf: Report may_goto timeout to BPF stderr
Date: Thu,  3 Jul 2025 13:48:13 -0700
Message-ID: <20250703204818.925464-8-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250703204818.925464-1-memxor@gmail.com>
References: <20250703204818.925464-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1521; h=from:subject; bh=E6+Abt1CLjBnfHopnHo3JheIACRIUpzwaEfydiovcAA=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoZudMthhutS9/HqUajVTGYH0y1qGy3Q5MjLqilB1e +ZaPpSiJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaGbnTAAKCRBM4MiGSL8RyoGsD/ 916x3IOVJ6RTkxDT9UF3ceFK9iwtlhb/p47G2Ts7Jc7BwWyYawEg1dOCRt1O0p5dOwmJL0Dsvjtsm/ Wk6pGlrl6Qwyo0Eca07uO5AoyTTj53VnVOzhaPTj8BJx94+znCnR98FEpWDABa8r64hZ931kvbwvEd ZhKAXTdhezV/5BU/xuVaiVOkg+B43leqYWmwvaDx9rs5HAfJqQ3NUhIr4v5kyx2XBFurkAN3+RcbCU 1etFbdK4q/3ZNHLWXRMXPQrFG6e1Y0UFfe4+orjpkrN9oKgzSNLTJcvXy5yTzD7ukxLLL0wXkocnN+ Swb3k5wWCWRc3C3OfITSohVXSYbSNxZ5fiB+TFl/x6uCzI9T2ygW5R68mL30D7/lHQ0bkupTSnfI15 UFw91vL0sCfGqtzBvQjZ6WvzajHr0DVoLolRXI0ZpUZiPlNnaSrbldSBo1iVq9DGMW8aSWXYwKDaIk v2xSygLKYOn1qh6DdlTVFRDtDWJkoQt7Zxw2azXiFxbYORYg2NglwWjX/UrOoqiXRqzg+LaSVS8g4Q neJQ4/KNVdAQ/9XNPA8tXAnlv77GvIS1C7ZjZ4v/tCt6UNCA+Ac0DAkga3WbuSOdU+Vkw2cXIYdeRz 1Pb5BhnQj1gNEIdkjsWty7fBMyguhejA499gYzR/xGyuutrDpT1GvWuI6uJQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Begin reporting may_goto timeouts to BPF program's stderr stream.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/core.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 037d67cf5fb1..fe8a53f3c5bc 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3168,6 +3168,22 @@ u64 __weak arch_bpf_timed_may_goto(void)
 	return 0;
 }
 
+static noinline void bpf_prog_report_may_goto_violation(void)
+{
+#ifdef CONFIG_BPF_SYSCALL
+	struct bpf_stream_stage ss;
+	struct bpf_prog *prog;
+
+	prog = bpf_prog_find_from_stack();
+	if (!prog)
+		return;
+	bpf_stream_stage(ss, prog, BPF_STDERR, ({
+		bpf_stream_printk(ss, "ERROR: Timeout detected for may_goto instruction\n");
+		bpf_stream_dump_stack(ss);
+	}));
+#endif
+}
+
 u64 bpf_check_timed_may_goto(struct bpf_timed_may_goto *p)
 {
 	u64 time = ktime_get_mono_fast_ns();
@@ -3178,8 +3194,10 @@ u64 bpf_check_timed_may_goto(struct bpf_timed_may_goto *p)
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


