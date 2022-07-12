Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BAE57130A
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 09:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbiGLHZM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 03:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiGLHZM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 03:25:12 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93F4691C9;
        Tue, 12 Jul 2022 00:25:11 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id v4-20020a17090abb8400b001ef966652a3so10569005pjr.4;
        Tue, 12 Jul 2022 00:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=DVN/4Sh+nfE9G8lUiTHC5v23V8EO98doCkU0WCCJ3Ms=;
        b=GIoXYnM+9Dlivi8O2MGHohjd1R7bfiZSfRp/oHFPAf3Kzvf7HaIwvm58aHkdfScBvM
         hnyq5aecf2snRfyD79SGh/pG4RDTHNDRqolLpX06iWs16Epm98FdP9Aeb5L+OR/r6Vxf
         hh7xtPD0PPImmkgsJEvvBFMHrrq31xf3i0JpQ9CAGtV9lmQqTNONHAtG+apiXffbxacS
         72RlmqiUvznMJg/dNEoYRXQJx2SckWj/zW2/Svi00EWyVuHyiNfRnjCAeywkS3NA6FiZ
         vCH3UG24knnA1JjF8cqgkbBeKEXANP/3RoS0Bp+6qU1NRm3R3Vz6nHmJ4YN+dYnYgm/8
         3wXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DVN/4Sh+nfE9G8lUiTHC5v23V8EO98doCkU0WCCJ3Ms=;
        b=vL1D3jp7g61ZLbPE07tdf73qyjzLlAwhkNgEzQBWLBGRYRDFDxGqxjG2/yjB+3eo5c
         KEGtTiUirZmXpctuGKcyB3HFG87Jv64jdraX2GYTgYpkSYgGgbvj7aR9V6lYtIMkeIiT
         lLTr2EqnK/VipvY/2hHrD0vRIlyD1tnHF8mscNbMM9kRE0x9jGZzBsNc+7u7p6XoPBNl
         MfbO8bEXN1NmWa5Anr9d6RmomRKnW/qjLBTywCtOg+PpQFXOqh/RvvX1rMCz+Nl9LzYL
         BunlFeSNoL5DKGZyMX+l8Nj7xSUTZtn4o3NN2+WM9XpenyceGZFkiBMU4l/2Jdqb4hOP
         ZvAw==
X-Gm-Message-State: AJIora8rFz9h/if0Gl/OfGjx2Fqut2k5RrsmXrIiIBt6zmNnPL5mJRjT
        p/2b7In46L9mwBop4fI9QG4=
X-Google-Smtp-Source: AGRyM1sMWOUNSipO80EXp63FSw7Dj02/JE90hf6vuQECcbsOM93Ukbeb/YNxxKUedyqv+573h9/E3g==
X-Received: by 2002:a17:903:244d:b0:16c:52f1:d12 with SMTP id l13-20020a170903244d00b0016c52f10d12mr5647382pls.44.1657610711173;
        Tue, 12 Jul 2022 00:25:11 -0700 (PDT)
Received: from localhost.localdomain ([23.91.97.158])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902714b00b001690d398401sm6020437plm.88.2022.07.12.00.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 00:25:10 -0700 (PDT)
From:   xiaolinkui <xiaolinkui@gmail.com>
X-Google-Original-From: xiaolinkui <xiaolinkui@kylinos.cn>
To:     xiaolinkui@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: [PATCH] samples: bpf: Replace sizeof(arr)/sizeof(arr[0]) with ARRAY_SIZE
Date:   Tue, 12 Jul 2022 15:23:02 +0800
Message-Id: <20220712072302.13761-1-xiaolinkui@kylinos.cn>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Linkui Xiao<xiaolinkui@kylinos.cn>

The ARRAY_SIZE macro is more compact and more formal in linux source.

Signed-off-by: Linkui Xiao<xiaolinkui@kylinos.cn>
---
 samples/bpf/fds_example.c          | 3 ++-
 samples/bpf/sock_example.c         | 3 ++-
 samples/bpf/test_cgrp2_attach.c    | 3 ++-
 samples/bpf/test_lru_dist.c        | 2 +-
 samples/bpf/test_map_in_map_user.c | 4 +++-
 samples/bpf/tracex5_user.c         | 3 ++-
 6 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/samples/bpf/fds_example.c b/samples/bpf/fds_example.c
index 16dbf49e0f19..88a26f3ce201 100644
--- a/samples/bpf/fds_example.c
+++ b/samples/bpf/fds_example.c
@@ -17,6 +17,7 @@
 #include <bpf/libbpf.h>
 #include "bpf_insn.h"
 #include "sock_example.h"
+#include "bpf_util.h"
 
 #define BPF_F_PIN	(1 << 0)
 #define BPF_F_GET	(1 << 1)
@@ -52,7 +53,7 @@ static int bpf_prog_create(const char *object)
 		BPF_MOV64_IMM(BPF_REG_0, 1),
 		BPF_EXIT_INSN(),
 	};
-	size_t insns_cnt = sizeof(insns) / sizeof(struct bpf_insn);
+	size_t insns_cnt = ARRAY_SIZE(insns);
 	struct bpf_object *obj;
 	int err;
 
diff --git a/samples/bpf/sock_example.c b/samples/bpf/sock_example.c
index a88f69504c08..5b66f2401b96 100644
--- a/samples/bpf/sock_example.c
+++ b/samples/bpf/sock_example.c
@@ -29,6 +29,7 @@
 #include <bpf/bpf.h>
 #include "bpf_insn.h"
 #include "sock_example.h"
+#include "bpf_util.h"
 
 char bpf_log_buf[BPF_LOG_BUF_SIZE];
 
@@ -58,7 +59,7 @@ static int test_sock(void)
 		BPF_MOV64_IMM(BPF_REG_0, 0), /* r0 = 0 */
 		BPF_EXIT_INSN(),
 	};
-	size_t insns_cnt = sizeof(prog) / sizeof(struct bpf_insn);
+	size_t insns_cnt = ARRAY_SIZE(prog);
 	LIBBPF_OPTS(bpf_prog_load_opts, opts,
 		.log_buf = bpf_log_buf,
 		.log_size = BPF_LOG_BUF_SIZE,
diff --git a/samples/bpf/test_cgrp2_attach.c b/samples/bpf/test_cgrp2_attach.c
index 6d90874b09c3..68ce69457afe 100644
--- a/samples/bpf/test_cgrp2_attach.c
+++ b/samples/bpf/test_cgrp2_attach.c
@@ -31,6 +31,7 @@
 #include <bpf/bpf.h>
 
 #include "bpf_insn.h"
+#include "bpf_util.h"
 
 enum {
 	MAP_KEY_PACKETS,
@@ -70,7 +71,7 @@ static int prog_load(int map_fd, int verdict)
 		BPF_MOV64_IMM(BPF_REG_0, verdict), /* r0 = verdict */
 		BPF_EXIT_INSN(),
 	};
-	size_t insns_cnt = sizeof(prog) / sizeof(struct bpf_insn);
+	size_t insns_cnt = ARRAY_SIZE(prog);
 	LIBBPF_OPTS(bpf_prog_load_opts, opts,
 		.log_buf = bpf_log_buf,
 		.log_size = BPF_LOG_BUF_SIZE,
diff --git a/samples/bpf/test_lru_dist.c b/samples/bpf/test_lru_dist.c
index be98ccb4952f..5efb91763d65 100644
--- a/samples/bpf/test_lru_dist.c
+++ b/samples/bpf/test_lru_dist.c
@@ -523,7 +523,7 @@ int main(int argc, char **argv)
 		return -1;
 	}
 
-	for (f = 0; f < sizeof(map_flags) / sizeof(*map_flags); f++) {
+	for (f = 0; f < ARRAY_SIZE(map_flags); f++) {
 		test_lru_loss0(BPF_MAP_TYPE_LRU_HASH, map_flags[f]);
 		test_lru_loss1(BPF_MAP_TYPE_LRU_HASH, map_flags[f]);
 		test_parallel_lru_loss(BPF_MAP_TYPE_LRU_HASH, map_flags[f],
diff --git a/samples/bpf/test_map_in_map_user.c b/samples/bpf/test_map_in_map_user.c
index e8b4cc184ac9..652ec720533d 100644
--- a/samples/bpf/test_map_in_map_user.c
+++ b/samples/bpf/test_map_in_map_user.c
@@ -12,6 +12,8 @@
 #include <bpf/bpf.h>
 #include <bpf/libbpf.h>
 
+#include "bpf_util.h"
+
 static int map_fd[7];
 
 #define PORT_A		(map_fd[0])
@@ -28,7 +30,7 @@ static const char * const test_names[] = {
 	"Hash of Hash",
 };
 
-#define NR_TESTS (sizeof(test_names) / sizeof(*test_names))
+#define NR_TESTS ARRAY_SIZE(test_names)
 
 static void check_map_id(int inner_map_fd, int map_in_map_fd, uint32_t key)
 {
diff --git a/samples/bpf/tracex5_user.c b/samples/bpf/tracex5_user.c
index e910dc265c31..9d7d79f0d47d 100644
--- a/samples/bpf/tracex5_user.c
+++ b/samples/bpf/tracex5_user.c
@@ -8,6 +8,7 @@
 #include <bpf/bpf.h>
 #include <bpf/libbpf.h>
 #include "trace_helpers.h"
+#include "bpf_util.h"
 
 #ifdef __mips__
 #define	MAX_ENTRIES  6000 /* MIPS n64 syscalls start at 5000 */
@@ -24,7 +25,7 @@ static void install_accept_all_seccomp(void)
 		BPF_STMT(BPF_RET+BPF_K, SECCOMP_RET_ALLOW),
 	};
 	struct sock_fprog prog = {
-		.len = (unsigned short)(sizeof(filter)/sizeof(filter[0])),
+		.len = (unsigned short)ARRAY_SIZE(filter),
 		.filter = filter,
 	};
 	if (prctl(PR_SET_SECCOMP, 2, &prog))
-- 
2.17.1

