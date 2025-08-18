Return-Path: <bpf+bounces-65854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A102B299C5
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 08:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 444D73A47EE
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 06:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF3F275105;
	Mon, 18 Aug 2025 06:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9DYgF5e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6678C274FF9
	for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 06:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755498719; cv=none; b=Q1MGBAa2BvyfIGya5UqOfwnco+8m9SH60FH/ZMg0npzgclobJ/K4Jh+g7zGoaNVEzQjfxgUSNMHSuv3GE/ZP1q8Pkx+NgOL7Tic++b/tAm5m0Zj8mzLaZbNGuQNpcRtkQu9tz28EIYpREhR0YCsVU4XNR7QNQyjSHGGbx5v0Ah4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755498719; c=relaxed/simple;
	bh=y8s+HdC3DYdZew+GcRCTL1D6UoaPUyunhqgv13tqFcY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b0b52GftjoN5WJzmPtmOU6UdNSNwqyzbEw47umYgpxmNMpEPhHD+NQkIYUyfxcaq6jS3R7Paf7TeMjErJPBXzlisArTj3b8K+73LDrw+rU7BpmLoo3uq4PeXPisiN6jchyO7LEuUY/s0MOyIpFliL0+LPx7FBUmEhPEps+kIUDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9DYgF5e; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-323267bc0a8so4834378a91.1
        for <bpf@vger.kernel.org>; Sun, 17 Aug 2025 23:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755498717; x=1756103517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iF7PgJ1LBxEjn4IzQYOX5Fj7N1XRRCuxAC03mMa2Kz4=;
        b=U9DYgF5e3MS8NINBbnkPOZuC3uJyiPDuIVz/P1fwrNTHMBnSKVAapMQKqUZR9mb0T7
         ZRjK9dXtviDBt/jtv4uUTJzZ/xVQ6gDQrPuhj9ThJ8YFv36+ClFCKVQpFQMs8CRykzBB
         S66tRMDtA0gssriUoLQENQFmiDUHjml+xCdI23VqsSpPWhTCPoPtbsQzGpJs5w5tuhZo
         +UwcBjmcSaV6GAWDYiyTLTqHBiHrot/9jcHqFoHXht3so1+syyQgXnwEQ6ii6wjAZDlN
         l294Gp0cITboWluHfdX3bnZZOYpNVQZhsmQdPuxps+g8NDe195Z9wq003yjeVwJpOHOa
         GNvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755498717; x=1756103517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iF7PgJ1LBxEjn4IzQYOX5Fj7N1XRRCuxAC03mMa2Kz4=;
        b=Ne2YVf3Wkc3fq8MAWY1XNYsUCNSYCAwwvPz+iqjEAD04Bv+CiqSN0uU9cCgIvHcLtC
         eVVzkpy03z+vnqHJn/0dYXhK8rBREII4f4cijEKVLwA14AN6ioUyMTtBbDKrb4LxgeSq
         VyqbAn5xztxGQC8Cc/JMx761aHJphEBNi3PybKMtSqICXUq38Ywr9EVrW6WW0guTG0z+
         l9fUm4KZNh8b1ceoL5+ZHC4pMPzr52/ZknLIVKwaNzUONDztWnMw/x1Bev0WGtQmtL6I
         aKeHghaQ7LmoW76Tihpa6V/zzJ1JuSMyQBMYHR3oAF58RBWUUWjCcZdjA4/1y/SrMgoE
         Fmcg==
X-Gm-Message-State: AOJu0YxYvbD8Kk0lOc6NDFT9dPJZR4BsDeNTVPYFDs4rT6e/qmAVwqZT
	qoUDLj91QAC1zOJmOTFF7NEM2h/j8CXNRk7KYRYccf13VflM4KvVQon+MFMWvxLr4/k=
X-Gm-Gg: ASbGncuPruuf4zgoibSdVn/CEHM8xD/7TvHoaLhdot4ONGOMZpGvUYQ+TvlZ0xBB26r
	wRv/z6cIwgmIoNyjXFKui7PqS6d/xhyMDmNG+ojvEuJRKiT86GRSxr9UMvwRg6se8joPX8sGgDe
	XrD7Kb9uSHuBqlLxdSW5G0cbxgsV84nD0kdDCs3U9pp1iNXhr3k3m7Pf96FuZIphPsw8XnIHrQG
	0LlrhQ2aoBDLsyctuaVADNJExylGDbZEM4W9hdJNx22EmOEdzHWGPaNc66wmAjeJ9fmunVz/Je7
	ytd8eFLAVSFZ/OVEj6ZTItnVk53oESaXriQkjQPmMNEQAeJ3VqElJSW6rtHCQh2xU7FROWslyJo
	SBPnUknC7zNalhKxUZ9ejT+vAy0OeDXl4fmidzOi1
X-Google-Smtp-Source: AGHT+IG2sQCuFsCdT9AB04oKcrk2ks+cbHuHohnTUdgl0iAmr0ioWHdDTgRBcdPUA6qzQ33LQCu6xQ==
X-Received: by 2002:a17:90b:390f:b0:321:2407:3cef with SMTP id 98e67ed59e1d1-32342107d3emr12458353a91.32.1755498717177;
        Sun, 17 Aug 2025 23:31:57 -0700 (PDT)
Received: from devbox.. ([43.132.141.27])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3232f7445f2sm6050321a91.2.2025.08.17.23.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 23:31:56 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev
Cc: hengqi.chen@gmail.com
Subject: [PATCH bpf-next v2] selftests/bpf: Use vmlinux.h for BPF programs
Date: Mon, 18 Aug 2025 04:30:20 +0000
Message-ID: <20250818043020.371093-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of the bpf test progs still use linux/libc headers.
Let's use vmlinux.h instead like the rest of test progs.
This will also ease cross compiling.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/testing/selftests/bpf/progs/loop1.c         |  7 +------
 tools/testing/selftests/bpf/progs/loop2.c         |  7 +------
 tools/testing/selftests/bpf/progs/loop3.c         |  7 +------
 tools/testing/selftests/bpf/progs/loop6.c         | 15 ++++-----------
 tools/testing/selftests/bpf/progs/test_overhead.c |  5 +----
 5 files changed, 8 insertions(+), 33 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/loop1.c b/tools/testing/selftests/bpf/progs/loop1.c
index 50e66772c046..b0fa26fb4760 100644
--- a/tools/testing/selftests/bpf/progs/loop1.c
+++ b/tools/testing/selftests/bpf/progs/loop1.c
@@ -1,11 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2019 Facebook
-#include <linux/sched.h>
-#include <linux/ptrace.h>
-#include <stdint.h>
-#include <stddef.h>
-#include <stdbool.h>
-#include <linux/bpf.h>
+#include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
diff --git a/tools/testing/selftests/bpf/progs/loop2.c b/tools/testing/selftests/bpf/progs/loop2.c
index 947bb7e988c2..0227409d4b0e 100644
--- a/tools/testing/selftests/bpf/progs/loop2.c
+++ b/tools/testing/selftests/bpf/progs/loop2.c
@@ -1,11 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2019 Facebook
-#include <linux/sched.h>
-#include <linux/ptrace.h>
-#include <stdint.h>
-#include <stddef.h>
-#include <stdbool.h>
-#include <linux/bpf.h>
+#include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
diff --git a/tools/testing/selftests/bpf/progs/loop3.c b/tools/testing/selftests/bpf/progs/loop3.c
index 717dab14322b..5d1c9a775e6b 100644
--- a/tools/testing/selftests/bpf/progs/loop3.c
+++ b/tools/testing/selftests/bpf/progs/loop3.c
@@ -1,11 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2019 Facebook
-#include <linux/sched.h>
-#include <linux/ptrace.h>
-#include <stdint.h>
-#include <stddef.h>
-#include <stdbool.h>
-#include <linux/bpf.h>
+#include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
diff --git a/tools/testing/selftests/bpf/progs/loop6.c b/tools/testing/selftests/bpf/progs/loop6.c
index e4ff97fbcce1..f48e5599d4fd 100644
--- a/tools/testing/selftests/bpf/progs/loop6.c
+++ b/tools/testing/selftests/bpf/progs/loop6.c
@@ -1,8 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include <linux/ptrace.h>
-#include <stddef.h>
-#include <linux/bpf.h>
+#include <vmlinux.h>
+#include <bpf/bpf_core_read.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include "bpf_misc.h"
@@ -26,12 +25,6 @@ char _license[] SEC("license") = "GPL";
 #define SG_CHAIN	0x01UL
 #define SG_END		0x02UL
 
-struct scatterlist {
-	unsigned long   page_link;
-	unsigned int    offset;
-	unsigned int    length;
-};
-
 #define sg_is_chain(sg)		((sg)->page_link & SG_CHAIN)
 #define sg_is_last(sg)		((sg)->page_link & SG_END)
 #define sg_chain_ptr(sg)	\
@@ -80,7 +73,7 @@ int BPF_KPROBE(trace_virtqueue_add_sgs, void *unused, struct scatterlist **sgs,
 		__sink(out_sgs);
 		for (n = 0, sgp = get_sgp(sgs, i); sgp && (n < SG_MAX);
 		     sgp = __sg_next(sgp)) {
-			bpf_probe_read_kernel(&len, sizeof(len), &sgp->length);
+			len = BPF_CORE_READ(sgp, length);
 			length1 += len;
 			n++;
 		}
@@ -90,7 +83,7 @@ int BPF_KPROBE(trace_virtqueue_add_sgs, void *unused, struct scatterlist **sgs,
 		__sink(in_sgs);
 		for (n = 0, sgp = get_sgp(sgs, i); sgp && (n < SG_MAX);
 		     sgp = __sg_next(sgp)) {
-			bpf_probe_read_kernel(&len, sizeof(len), &sgp->length);
+			len = BPF_CORE_READ(sgp, length);
 			length2 += len;
 			n++;
 		}
diff --git a/tools/testing/selftests/bpf/progs/test_overhead.c b/tools/testing/selftests/bpf/progs/test_overhead.c
index abb7344b531f..5edf3cdc213d 100644
--- a/tools/testing/selftests/bpf/progs/test_overhead.c
+++ b/tools/testing/selftests/bpf/progs/test_overhead.c
@@ -1,9 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2019 Facebook */
-#include <stdbool.h>
-#include <stddef.h>
-#include <linux/bpf.h>
-#include <linux/ptrace.h>
+#include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
-- 
2.43.5



