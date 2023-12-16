Return-Path: <bpf+bounces-18060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EA38155B0
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 01:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35A01B23429
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 00:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B163910EE;
	Sat, 16 Dec 2023 00:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rr9q1gui"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AF710F1
	for <bpf@vger.kernel.org>; Sat, 16 Dec 2023 00:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6d9ac148ca3so1002317a34.0
        for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 16:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702687553; x=1703292353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H60zVe4OQIN/1JJ5qEkZzb2SFU4f62aU67ftKV6217k=;
        b=Rr9q1gui45/Yjl0UVHPyEsxUrrrOgtOo3CKI0Ed5m1OnnCbB6cPas02y6PpvgerT+J
         RufwmiP7/gNgB0tEjVDaRD/VdBlY1+r7EivwgntM+OECwHXzLUidxDnyTq0q7VlCw16a
         LjwmDcDZGlJM/GIAAh7NnM0bT8P0EUMyuu250uGUY9XGYxcF5uPnEktuuCJemVOeF1YY
         KAwmQJRzTWZlAw69Vc83u/aGUXvkEPBuu8GeOa/omdGiO6IYdjnm2eZN5d/pDDhRHvZb
         MqHB9OZrGyn17VseWE7P1cFOOyyxFRVMtnnJaA+whJ0cCEsAlEHDg2iiKSzx++G8bSON
         Wt2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702687553; x=1703292353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H60zVe4OQIN/1JJ5qEkZzb2SFU4f62aU67ftKV6217k=;
        b=QKV2R0SSA2VVN5rjyWheq1M1Kb7tePYjgzhgUxj7Gf1yoVM+h0KQqc1LFiThs2NOk/
         L/6k9PwnCKy1ES9pULjr+2l/CVCZPLhPntZyLXK/DefSnJvIXPsHHtZ8pU9de1faAUwv
         QCootvHWVKCxhp1UJ15ZK+Pg5jvCJd5R7Yd1kHZV+TeH5ntlf5vqCkelJpPyLiPRfGCm
         QfBI/rdAZdM9R/KO3lreb2EyuIdKETGpDkQCLi/h5EfxBtpJW9P9WFkeLcc7aHRTh7Xb
         znI6Dfl788TbpnXAkeb5cOTLaG+l/zsvpafOKakOz0lXStFRfPnESKzYfO+TcXnL/Pb5
         OGUQ==
X-Gm-Message-State: AOJu0YwH7Mq2rTUGWYEVyHe8Kfohrb8tEFYmHUsMfi1l2DwkQZCFGqp/
	Km/Ptns3sL6r8XZoXv4mZ1A=
X-Google-Smtp-Source: AGHT+IGUz39A4B1W+UQIoxk0v+4b1gjLISXmynUxRZ81JSsgCGexUCoXV1FLVctF/5vHgbt0kzxImQ==
X-Received: by 2002:a9d:65c5:0:b0:6d9:e37f:5c52 with SMTP id z5-20020a9d65c5000000b006d9e37f5c52mr10174549oth.27.1702687552887;
        Fri, 15 Dec 2023 16:45:52 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::4:795b])
        by smtp.gmail.com with ESMTPSA id x47-20020a056a000bef00b006cefa247464sm11622112pfu.188.2023.12.15.16.45.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 15 Dec 2023 16:45:52 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: iii@linux.ibm.com
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	peterz@infradead.org,
	martin.lau@kernel.org,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next] s390/bpf: Fix indirect trampoline generation
Date: Fri, 15 Dec 2023 16:45:49 -0800
Message-Id: <20231216004549.78355-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

The func_addr used to be NULL for indirect trampolines used by struct_ops.
Now func_addr is a valid function pointer.
Hence use BPF_TRAMP_F_INDIRECT flag to detect such condition.

Fixes: 2cd3e3772e41 ("x86/cfi,bpf: Fix bpf_struct_ops CFI")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/s390/net/bpf_jit_comp.c               | 3 ++-
 tools/testing/selftests/bpf/DENYLIST.s390x | 2 --
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index cc129617480a..7f0a7b97ef4c 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2362,7 +2362,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 		return -ENOTSUPP;
 
 	/* Return to %r14, since func_addr and %r0 are not available. */
-	if (!func_addr && !(flags & BPF_TRAMP_F_ORIG_STACK))
+	if ((!func_addr && !(flags & BPF_TRAMP_F_ORIG_STACK)) ||
+	    (flags & BPF_TRAMP_F_INDIRECT))
 		flags |= BPF_TRAMP_F_SKIP_FRAME;
 
 	/*
diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
index d27aa42d11a4..1a63996c0304 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -1,7 +1,5 @@
 # TEMPORARY
 # Alphabetical order
-dummy_st_ops/dummy_init_ret_value
-dummy_st_ops/dummy_init_ptr_arg
 exceptions				 # JIT does not support calling kfunc bpf_throw				       (exceptions)
 get_stack_raw_tp                         # user_stack corrupted user stack                                             (no backchain userspace)
 stacktrace_build_id                      # compare_map_keys stackid_hmap vs. stackmap err -2 errno 2                   (?)
-- 
2.34.1


