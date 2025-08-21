Return-Path: <bpf+bounces-66150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C525DB2ED64
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 07:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5939E6874D6
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 05:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF2722A4F1;
	Thu, 21 Aug 2025 05:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRBiQi6X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C307F3C17
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 05:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755752641; cv=none; b=ifCpSoE4ry4iT37h3nUpXvJJl8zGMIqr25p3t8Cqu1FQPEx1cTTVUKceFSnQW1ylnlZ0JbkHXJFFWrAp6ZlJ8p9GJTPw7vlDkM5E1GjFruS0yujIGhbj1yGihI/FiSlGoZ5Z73ztE7WLJRpHWR4xxJbcsF1ef5lo+cO0yTDa4EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755752641; c=relaxed/simple;
	bh=U/8Mgq7GOQfQ2HADhyHbQwOTjOpAofjTfl8Ev7+Nt4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NtL6uFuLCdaAqmigYVrWlsDE/mML73u45E9Wc6MDAdRD6I1B7h/aPjN6Hu0aDECm3bgvaZd9n58Mi2G0IbUY/gQbv8LsJsgN/c/QlOHN+ke5YNfpn2eoJniHTUm/6wqlnW7McZvxD9TqgrkbTeHwC+oKd8lv9dgnc3/GNR5G3HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRBiQi6X; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24458242b33so6148715ad.3
        for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 22:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755752639; x=1756357439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vn75KSu3Btbez3eSlSoACeyElCtE0DB74/gM5tjVeBU=;
        b=lRBiQi6XWXM2PBpnpg8CKaklNkEvMlar+W4Vo4xC2AHKyw04lkfSTdWzNCJnAqiJtM
         FUsxpoRpS9GmmzZd8as/MxOkmLuDRR3V8E8OncghZ/XZOC3/VLLS3vithsmXEq5Zj/w8
         Pe1VfNoX9nhXLFjM/6CVrq7a4TqgMvXV/tmwIFbwZxnRphjNeqpSFXsspxgp0fHhsNMx
         Hj0dWyVxxKC7/+XjIbiIb6gHlz8y2WQxG8KhVWoKhZagPyTpYs83fgacekHCI/2/43F6
         5EaZRWZ5vgE0jA08wk55TrN29OsDp+3gt5mZlC1Rj5WFcrhwkJqIdUF73If8u9Q9zqP3
         BpaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755752639; x=1756357439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vn75KSu3Btbez3eSlSoACeyElCtE0DB74/gM5tjVeBU=;
        b=GYiENlroBWRuJbYSQa6C/QeeJrHQ4Bmn7yroYBUj4b2YTHIxigV8mp3tJCLyVbnPV1
         Pq/kzJnQMOh21oblbl5r2iao5Q5w+2DsRg+i7D8BwK2xd3IPX9NZHEqiy9TbTXgYngb1
         UYBCUyC6F1DWKhlpDVxfxOad/URrFmr5qf+dQ86zR+cOQZUw38UJnYjc92Mzlh6eLqPG
         0SYa5QFV/1kba5fzsyNSw1NRZjkux4yDheYO5EXIG2SQ/ZR+gNHUy89SppjuEx7s/63i
         I9OIxs2ZPd0LSVhhehCIatVPk5kpydwMlNnpSTXSGGdUoiIiHtTbQ20OafEej2z3QMtf
         7q+A==
X-Gm-Message-State: AOJu0Yz2qp8TOO94f1Uxc9SMs+Sl6hba8j6GL4xUNcSgtclTst23MxYI
	dhdfpJ8Xs1ypTahx8rNpQTIGq6/4c5PBXNqkafLhf6foW8pjybgxGeno+ADouOoOsXY=
X-Gm-Gg: ASbGncvuSof4FbTmi0HmyEEvlXpcCPkxQ4i1yd8AbXrMlRNeexF+kPgJQR9yXoLk1Ww
	G9PCpL+72wPZiACrEGQenYmtxRRd3AWb1nYqSIK2gXa9ZQ6UmpEliRTxRVFHqNLEx1vHZpweCt8
	BzBNnMS1GlaRCkRlDo7VvyYxaKQX5hOoJJcJoztKhprYpd42adrfgzSN2tb1+k69MX5GJfqwCFq
	YWDx9wUXD89pcve9UXgaSs1eAvdyOT0dR2KuqfRrdzA4fmiqV9YxoeRnI6gcALk4qHHTyL5+FGP
	cmuGSLxeiogXiio3y55ObmuLM97cHOvwpgZ/PoNRkg+R2mF2P/yV94CtTaW/FQ/22xV/RCLQyM0
	prZMoQfgTvWoCDRPe37DXaV3Ii4ciWdTztrBFqsv0
X-Google-Smtp-Source: AGHT+IGpG7lgc8vl3FceyGJzmT8R14jN3BzsEuadlszU5P9xVoNuJwbLZyjY0dzBcNzHZx59OdNP2Q==
X-Received: by 2002:a17:903:198e:b0:245:f5a7:1b60 with SMTP id d9443c01a7336-245febef4e6mr14193805ad.10.1755752638751;
        Wed, 20 Aug 2025 22:03:58 -0700 (PDT)
Received: from devbox.. ([43.132.141.27])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4ebc4esm42557665ad.115.2025.08.20.22.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 22:03:58 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev
Cc: hengqi.chen@gmail.com
Subject: [PATCH bpf-next v3] selftests/bpf: Use vmlinux.h for BPF programs
Date: Thu, 21 Aug 2025 03:02:54 +0000
Message-ID: <20250821030254.398826-1-hengqi.chen@gmail.com>
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
 tools/testing/selftests/bpf/progs/loop1.c     |  7 +------
 tools/testing/selftests/bpf/progs/loop2.c     |  7 +------
 tools/testing/selftests/bpf/progs/loop3.c     |  7 +------
 tools/testing/selftests/bpf/progs/loop6.c     | 21 +++++++------------
 .../selftests/bpf/progs/test_overhead.c       |  5 +----
 5 files changed, 11 insertions(+), 36 deletions(-)

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
index e4ff97fbcce1..dd36aff4fba3 100644
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
@@ -62,7 +55,7 @@ static inline struct scatterlist *get_sgp(struct scatterlist **sgs, int i)
 	return sgp;
 }
 
-int config = 0;
+int run_once = 0;
 int result = 0;
 
 SEC("kprobe/virtqueue_add_sgs")
@@ -73,14 +66,14 @@ int BPF_KPROBE(trace_virtqueue_add_sgs, void *unused, struct scatterlist **sgs,
 	__u64 length1 = 0, length2 = 0;
 	unsigned int i, n, len;
 
-	if (config != 0)
+	if (run_once != 0)
 		return 0;
 
 	for (i = 0; (i < VIRTIO_MAX_SGS) && (i < out_sgs); i++) {
 		__sink(out_sgs);
 		for (n = 0, sgp = get_sgp(sgs, i); sgp && (n < SG_MAX);
 		     sgp = __sg_next(sgp)) {
-			bpf_probe_read_kernel(&len, sizeof(len), &sgp->length);
+			len = BPF_CORE_READ(sgp, length);
 			length1 += len;
 			n++;
 		}
@@ -90,13 +83,13 @@ int BPF_KPROBE(trace_virtqueue_add_sgs, void *unused, struct scatterlist **sgs,
 		__sink(in_sgs);
 		for (n = 0, sgp = get_sgp(sgs, i); sgp && (n < SG_MAX);
 		     sgp = __sg_next(sgp)) {
-			bpf_probe_read_kernel(&len, sizeof(len), &sgp->length);
+			len = BPF_CORE_READ(sgp, length);
 			length2 += len;
 			n++;
 		}
 	}
 
-	config = 1;
+	run_once = 1;
 	result = length2 - length1;
 	return 0;
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



