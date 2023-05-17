Return-Path: <bpf+bounces-813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C424A70704D
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 20:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A99661C20B23
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 18:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C527B31EFA;
	Wed, 17 May 2023 18:00:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9438810966
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 18:00:10 +0000 (UTC)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4CA10D0
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 11:00:09 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-25344113e9bso780814a91.3
        for <bpf@vger.kernel.org>; Wed, 17 May 2023 11:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1684346408; x=1686938408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WftXfWdAZD6uuzC3b6AEEhK30JaZ2vZwm1NTFpU16cM=;
        b=eBh23dTe/Ys1ebPxpsqbha8jJQ2vOoAeVS9dRCrtjnLZGD7NfvQvloy4D5S22p7ZhB
         y1Yflo1zlkoxEHHMb9dPVLOSi9XqXCAjP9x/TMUd7sFxntv/jD9L2/dTp0syYr1pApWO
         /SiNHsjDjaPMoYLktSAUGE98YxP10QG9KHqhrL+L5M+KZMvikorm1vy4W/ooapeDuU0X
         zLKIWfR7wM6PJZLc9/2kWMZXUelvSfPZvZTAQLmq2CdJkfAiOnHT4JOeaViwoC5/LMHU
         G0MG0YAEeL729+03Kmwkjh9y+W4vFnq2rUsshsjiic51NI5B4Id5fLGSBwZ9oHYp8nsW
         +K0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684346408; x=1686938408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WftXfWdAZD6uuzC3b6AEEhK30JaZ2vZwm1NTFpU16cM=;
        b=jAITYcYNWR93m9Fvzx/K9JPrFvCmYKgHIwBleYPgKZbDfP30+I2Y2DMfmCDdxdqq34
         yrrD0EHROcwRk1K04COzrnhfi+HJSb9B41bskwpPVppKX1YjRPAIBzjS3pBQzcwU6MJO
         6ObTJ0/fwx8HePwRtBW+xfF1GbPtJWmzPE+zICXw3DY+u9pn5E1iSeT4G5dqsErH2Cp1
         CjawGX7HPhKRamDUMaQHIuLWyumT1OTjV1tGMYvuB0t+0XTx1cklaASPX3lXZ2VrnV+B
         edcOmfwm8pLp0ZKdznZkCvImkuH/ssMaB1Lg/GrsLoDUNP6yL0+PiXiqkvUy54wIviKL
         XuXw==
X-Gm-Message-State: AC+VfDzzQnPmA+NW1yCgkeenYfE3RsO4i+cNjlxiuXqXybIK/m5O+a9i
	0l+FHpKXHeIzes+cb8DCATPUtM7/1mAeEAS2Suw=
X-Google-Smtp-Source: ACHHUZ7yV43ijhzfhEPpytas8WrVS4hCOGfHpGmC3HG2yk/InGDsx6Xk699P30PXaQ4e787ceGdC5Q==
X-Received: by 2002:a17:90a:2a06:b0:253:50d0:a39d with SMTP id i6-20020a17090a2a0600b0025350d0a39dmr367565pjd.48.1684346408501;
        Wed, 17 May 2023 11:00:08 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id s12-20020a17090aba0c00b0025289bc1ce4sm1885702pjr.17.2023.05.17.11.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 11:00:08 -0700 (PDT)
From: Aditi Ghag <aditi.ghag@isovalent.com>
To: bpf@vger.kernel.org
Cc: kafai@fb.com,
	sdf@google.com,
	aditi.ghag@isovalent.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH v8 bpf-next 10/10] selftests/bpf: Extend bpf_sock_destroy tests
Date: Wed, 17 May 2023 18:00:03 +0000
Message-Id: <20230517180003.528401-1-aditi.ghag@isovalent.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This commit adds a test case to verify that the
`bpf_sock_destroy` kfunc is not allowed from
program attach types other than BPF trace iterator.
Unsupprted programs calling the kfunc will be rejected by
the verifier.

Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 .../selftests/bpf/prog_tests/sock_destroy.c   |  2 ++
 .../bpf/progs/sock_destroy_prog_fail.c        | 22 +++++++++++++++++++
 2 files changed, 24 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/sock_destroy_prog_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_destroy.c b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
index 56b72594cd6b..b0583309a94e 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
@@ -3,6 +3,7 @@
 #include <bpf/bpf_endian.h>
 
 #include "sock_destroy_prog.skel.h"
+#include "sock_destroy_prog_fail.skel.h"
 #include "network_helpers.h"
 
 #define TEST_NS "sock_destroy_netns"
@@ -208,6 +209,7 @@ void test_sock_destroy(void)
 	if (test__start_subtest("udp_server"))
 		test_udp_server(skel);
 
+	RUN_TESTS(sock_destroy_prog_fail);
 
 cleanup:
 	if (nstoken)
diff --git a/tools/testing/selftests/bpf/progs/sock_destroy_prog_fail.c b/tools/testing/selftests/bpf/progs/sock_destroy_prog_fail.c
new file mode 100644
index 000000000000..dd6850b58e25
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/sock_destroy_prog_fail.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+int bpf_sock_destroy(struct sock_common *sk) __ksym;
+
+SEC("tp_btf/tcp_destroy_sock")
+__failure __msg("calling kernel function bpf_sock_destroy is not allowed")
+int BPF_PROG(trace_tcp_destroy_sock, struct sock *sk)
+{
+	/* should not load */
+	bpf_sock_destroy((struct sock_common *)sk);
+
+	return 0;
+}
+
-- 
2.34.1


