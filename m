Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C924A6F3876
	for <lists+bpf@lfdr.de>; Mon,  1 May 2023 21:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbjEATsd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 May 2023 15:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbjEATsc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 May 2023 15:48:32 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EFA1FCE
        for <bpf@vger.kernel.org>; Mon,  1 May 2023 12:48:30 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9dcfade347so3415581276.2
        for <bpf@vger.kernel.org>; Mon, 01 May 2023 12:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682970510; x=1685562510;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C28FV4ULK57/6m2AG7xVSR5op2veBdJro+MC8IdFN7M=;
        b=dtjUukrvx3fCKwJ86T49dpUS1JGTUMcTuUinAc3LOnAqBte6Gj85cKDDjePVLeUCu4
         jAR81NHTYN92HWjNsvpVNe0i1sloePaIFUnNB+7Fv6ByVyESf03tasgpcT8C1qnFVUjf
         2u7qiCO5p+C9Am+mf4+/qWL+INXq/qDOSndLCCPkaaK8rG+s79XOpuv/Qy0y9cJpQyDr
         ZmyChM3cS03q2ldJAPVWWR5EFz+Pt75uGmT/wQ+CwIYhPOVmeBg769ULqSyu17PmWjLP
         xja25r5KuGQKpyC6yHyFS2rtQofVpASZ4iRcRRUbAZF6/z4FJEL1ru9YDVMdUfKrjvAo
         YMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682970510; x=1685562510;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C28FV4ULK57/6m2AG7xVSR5op2veBdJro+MC8IdFN7M=;
        b=V/ByZRbrEomSESbX0g8ktkn1RVo2nE2RPWFJDlM+RkFJ22iB0+ZTw5gdjJEgBvLzNo
         QKnyEl8Io/t1M+7c3D0b8jFE6LCrb/05vQHo2T3l5pnd7UKniX7Ob7gtGoJ2tJbTsHD5
         G04gtNd3btOnN7xKzXoLBU7i1Mzab5Bpf0X57s4CCBkzCLjMAmPXCBZEcPEcx55mEPly
         vm/kjzCkWktf9P+Oh1PhHpmCEdTknabLWCgKZ4msOxmhc/TM26KeWnNkM31it8vwMNta
         yVIw4PkNfR1Z1JFm5mioxQ8MKaAIc/y9H2TqW4gg7c8z2jw513Nghqimlfo3MuLlSxIK
         NzMA==
X-Gm-Message-State: AC+VfDw9VycauMutpuevaTt/H6J5/R5ms1JA+YAdwPXAed1hmviuhOT9
        yx7+lOq1yTUCRXxO1C6jGJnT5ob18G2heJvhRuNj62/4M7Uvvbqvd21FOUdzAr/nvkNXO5ccsuH
        g2vKyo4Xep7QWNEEYHw5x/yHbv6uwmjPibcXBtSsbx2yLFLcabQ==
X-Google-Smtp-Source: ACHHUZ6lFttKBbk5rnxGlP899+z/DdsZUhUwSAcrDKgWRPFELa97+f6Eh38YqgSu6CCLezqwaYXk7rI=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:4245:0:b0:b97:8207:443b with SMTP id
 p66-20020a254245000000b00b978207443bmr5266338yba.5.1682970510211; Mon, 01 May
 2023 12:48:30 -0700 (PDT)
Date:   Mon,  1 May 2023 12:48:23 -0700
In-Reply-To: <20230501194825.2864150-1-sdf@google.com>
Mime-Version: 1.0
References: <20230501194825.2864150-1-sdf@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230501194825.2864150-3-sdf@google.com>
Subject: [PATCH bpf-next v3 2/4] selftests/bpf: Update EFAULT {g,s}etsockopt selftests
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Instead of assuming EFAULT, let's assume the BPF program's
output is ignored.

Remove "getsockopt: deny arbitrary ctx->retval" because it
was actually testing optlen. We have separate set of tests
for retval.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../selftests/bpf/prog_tests/sockopt.c        | 98 +++++++++++++++++--
 1 file changed, 92 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt.c b/tools/testing/selftests/bpf/prog_tests/sockopt.c
index aa4debf62fc6..a7bc9dc93ce0 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt.c
@@ -5,6 +5,10 @@
 static char bpf_log_buf[4096];
 static bool verbose;
 
+#ifndef PAGE_SIZE
+#define PAGE_SIZE 4096
+#endif
+
 enum sockopt_test_error {
 	OK = 0,
 	DENY_LOAD,
@@ -273,10 +277,30 @@ static struct sockopt_test {
 		.error = EFAULT_GETSOCKOPT,
 	},
 	{
-		.descr = "getsockopt: deny arbitrary ctx->retval",
+		.descr = "getsockopt: ignore >PAGE_SIZE optlen",
 		.insns = {
-			/* ctx->retval = 123 */
-			BPF_MOV64_IMM(BPF_REG_0, 123),
+			/* write 0xFF to the first optval byte */
+
+			/* r6 = ctx->optval */
+			BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1,
+				    offsetof(struct bpf_sockopt, optval)),
+			/* r2 = ctx->optval */
+			BPF_MOV64_REG(BPF_REG_2, BPF_REG_6),
+			/* r6 = ctx->optval + 1 */
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 1),
+
+			/* r7 = ctx->optval_end */
+			BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_1,
+				    offsetof(struct bpf_sockopt, optval_end)),
+
+			/* if (ctx->optval + 1 <= ctx->optval_end) { */
+			BPF_JMP_REG(BPF_JGT, BPF_REG_6, BPF_REG_7, 1),
+			/* ctx->optval[0] = 0xF0 */
+			BPF_ST_MEM(BPF_B, BPF_REG_2, 0, 0xFF),
+			/* } */
+
+			/* ctx->retval = 0 */
+			BPF_MOV64_IMM(BPF_REG_0, 0),
 			BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0,
 				    offsetof(struct bpf_sockopt, retval)),
 
@@ -287,9 +311,10 @@ static struct sockopt_test {
 		.attach_type = BPF_CGROUP_GETSOCKOPT,
 		.expected_attach_type = BPF_CGROUP_GETSOCKOPT,
 
-		.get_optlen = 64,
-
-		.error = EFAULT_GETSOCKOPT,
+		.get_level = 1234,
+		.get_optname = 5678,
+		.get_optval = {}, /* the changes are ignored */
+		.get_optlen = PAGE_SIZE + 1,
 	},
 	{
 		.descr = "getsockopt: support smaller ctx->optlen",
@@ -648,6 +673,49 @@ static struct sockopt_test {
 
 		.error = EFAULT_SETSOCKOPT,
 	},
+	{
+		.descr = "setsockopt: ignore >PAGE_SIZE optlen",
+		.insns = {
+			/* write 0xFF to the first optval byte */
+
+			/* r6 = ctx->optval */
+			BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1,
+				    offsetof(struct bpf_sockopt, optval)),
+			/* r2 = ctx->optval */
+			BPF_MOV64_REG(BPF_REG_2, BPF_REG_6),
+			/* r6 = ctx->optval + 1 */
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 1),
+
+			/* r7 = ctx->optval_end */
+			BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_1,
+				    offsetof(struct bpf_sockopt, optval_end)),
+
+			/* if (ctx->optval + 1 <= ctx->optval_end) { */
+			BPF_JMP_REG(BPF_JGT, BPF_REG_6, BPF_REG_7, 1),
+			/* ctx->optval[0] = 0xF0 */
+			BPF_ST_MEM(BPF_B, BPF_REG_2, 0, 0xFF),
+			/* } */
+
+			BPF_MOV64_IMM(BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.attach_type = BPF_CGROUP_SETSOCKOPT,
+		.expected_attach_type = BPF_CGROUP_SETSOCKOPT,
+
+		.set_level = SOL_IP,
+		.set_optname = IP_TOS,
+		.set_optval = { 1 << 3 },
+		.set_optlen = PAGE_SIZE + 1,
+
+		.get_level = SOL_IP,
+		.get_optname = IP_TOS,
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+		.get_optval = { 1 << 3, 0, 0, 0 }, /* the changes are ignored */
+#else
+		.get_optval = { 0, 0, 0, 1 << 3 }, /* the changes are ignored */
+#endif
+		.get_optlen = 4,
+	},
 	{
 		.descr = "setsockopt: allow changing ctx->optlen within bounds",
 		.insns = {
@@ -906,6 +974,13 @@ static int run_test(int cgroup_fd, struct sockopt_test *test)
 	}
 
 	if (test->set_optlen) {
+		if (test->set_optlen >= PAGE_SIZE) {
+			int num_pages = test->set_optlen / PAGE_SIZE;
+			int remainder = test->set_optlen % PAGE_SIZE;
+
+			test->set_optlen = num_pages * sysconf(_SC_PAGESIZE) + remainder;
+		}
+
 		err = setsockopt(sock_fd, test->set_level, test->set_optname,
 				 test->set_optval, test->set_optlen);
 		if (err) {
@@ -921,7 +996,15 @@ static int run_test(int cgroup_fd, struct sockopt_test *test)
 	}
 
 	if (test->get_optlen) {
+		if (test->get_optlen >= PAGE_SIZE) {
+			int num_pages = test->get_optlen / PAGE_SIZE;
+			int remainder = test->get_optlen % PAGE_SIZE;
+
+			test->get_optlen = num_pages * sysconf(_SC_PAGESIZE) + remainder;
+		}
+
 		optval = malloc(test->get_optlen);
+		memset(optval, 0, test->get_optlen);
 		socklen_t optlen = test->get_optlen;
 		socklen_t expected_get_optlen = test->get_optlen_ret ?:
 			test->get_optlen;
@@ -946,6 +1029,9 @@ static int run_test(int cgroup_fd, struct sockopt_test *test)
 			goto free_optval;
 		}
 
+		if (optlen > sizeof(test->get_optval))
+			optlen = sizeof(test->get_optval);
+
 		if (memcmp(optval, test->get_optval, optlen) != 0) {
 			errno = 0;
 			log_err("getsockopt returned unexpected optval");
-- 
2.40.1.495.gc816e09b53d-goog

