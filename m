Return-Path: <bpf+bounces-357-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7626FF80E
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 19:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B71128189B
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 17:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9546E8F52;
	Thu, 11 May 2023 17:05:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6510F79EC
	for <bpf@vger.kernel.org>; Thu, 11 May 2023 17:05:11 +0000 (UTC)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B762769F
	for <bpf@vger.kernel.org>; Thu, 11 May 2023 10:05:02 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-528ab71c95cso4361470a12.0
        for <bpf@vger.kernel.org>; Thu, 11 May 2023 10:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683824702; x=1686416702;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n20mivcjzgHVgwNuEyG156S3Zik7k+LV6J+jO8w6rAI=;
        b=GmScmhFe3AretrzTLiRWf7Zpr3qah4roQIUXbVfcrpR3v2dftQMLVWTNj9LjjHArVQ
         gMcwM47FCbMYFBuo2LWTSty30xcIRcr4C+GBeLfNuaPhBsSXoXQy55gvbcf1WUNe63oL
         W8JpNTTTT09DamVW2Yg6YiASwnEOdGN7ix0F3H1V4v52NYPXWgqhk2iazuPaGU61sb9W
         zEEJPa7O/n9y4iCjAh3NzjVO4S3gng3m46exLi5wlTGKA7fhcx1XtKykfJhUILzTgnLM
         L0uGS8Gu5Irp9TaX5UihVNfeo9B4660374KBiW8P7Fk5j9J+Dvm+XBBcL5nSH5H9+aXS
         l/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683824702; x=1686416702;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n20mivcjzgHVgwNuEyG156S3Zik7k+LV6J+jO8w6rAI=;
        b=X3XgeqOSDcVQA/xRf1Bw4y+Gjgbjdy04Bp7tdBrGWWm27LsIDGdcMkhaFV7wFL4vIc
         xrmWOWyZGLow48CSkJ2kkIq0L+6FtwiSa29jKvwAfbQHVgI03iV0/cng7CfmpjYEV0Kz
         LNV+e4SIHpZ6YOFubsPBdfr2rIn8QuDwFybttJLzsk5mYIV77LVX81+g/MA7Ncmsil1D
         Up1WdKevz49KeHur08RBqg55khJh0TQl5c77URcDYGOdjN/jPRZMPWKrAieX+be//7cx
         6mAsf79gpnzyfBL3FrJ/RwPvOk09KVkXfjGN/cRkg0K4BkIgo3kjT0V32ObT1Caxi7E7
         mRSg==
X-Gm-Message-State: AC+VfDxWaxCz8oxSbz3B1Z+8R+CYuHbx9FPdQfsxxIBUf3CX6i6TraEU
	srRMfYE65enNq89BCca0sxaHogeHFmvU4ZPLmN+ilRlcFhOvXztO04rh392tW0Ka68QKzDv6qJ0
	QVdqCa4ANt83fWuK1tvfMUg7yYfhx+gwHLXG/pIWFokhuqgPkzA==
X-Google-Smtp-Source: ACHHUZ5TCJn6gtLJTxxig4cHjdUweZw6lkCxWc+BzyFMmWo0AwfZwdSynhAmdQuqrVo0mBq9RTnFFA0=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:4e47:0:b0:530:638d:cf91 with SMTP id
 o7-20020a634e47000000b00530638dcf91mr1441703pgl.4.1683824701703; Thu, 11 May
 2023 10:05:01 -0700 (PDT)
Date: Thu, 11 May 2023 10:04:54 -0700
In-Reply-To: <20230511170456.1759459-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230511170456.1759459-1-sdf@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230511170456.1759459-3-sdf@google.com>
Subject: [PATCH bpf-next v6 2/4] selftests/bpf: Update EFAULT {g,s}etsockopt selftests
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Instead of assuming EFAULT, let's assume the BPF program's
output is ignored.

Remove "getsockopt: deny arbitrary ctx->retval" because it
was actually testing optlen. We have separate set of tests
for retval.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../selftests/bpf/prog_tests/sockopt.c        | 99 +++++++++++++++++--
 1 file changed, 93 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt.c b/tools/testing/selftests/bpf/prog_tests/sockopt.c
index aa4debf62fc6..bd09f1a33341 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt.c
@@ -5,10 +5,15 @@
 static char bpf_log_buf[4096];
 static bool verbose;
 
+#ifndef PAGE_SIZE
+#define PAGE_SIZE 4096
+#endif
+
 enum sockopt_test_error {
 	OK = 0,
 	DENY_LOAD,
 	DENY_ATTACH,
+	EOPNOTSUPP_GETSOCKOPT,
 	EPERM_GETSOCKOPT,
 	EFAULT_GETSOCKOPT,
 	EPERM_SETSOCKOPT,
@@ -273,10 +278,31 @@ static struct sockopt_test {
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
+			/* retval changes are ignored */
+			/* ctx->retval = 5 */
+			BPF_MOV64_IMM(BPF_REG_0, 5),
 			BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0,
 				    offsetof(struct bpf_sockopt, retval)),
 
@@ -287,9 +313,11 @@ static struct sockopt_test {
 		.attach_type = BPF_CGROUP_GETSOCKOPT,
 		.expected_attach_type = BPF_CGROUP_GETSOCKOPT,
 
-		.get_optlen = 64,
-
-		.error = EFAULT_GETSOCKOPT,
+		.get_level = 1234,
+		.get_optname = 5678,
+		.get_optval = {}, /* the changes are ignored */
+		.get_optlen = PAGE_SIZE + 1,
+		.error = EOPNOTSUPP_GETSOCKOPT,
 	},
 	{
 		.descr = "getsockopt: support smaller ctx->optlen",
@@ -648,6 +676,45 @@ static struct sockopt_test {
 
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
+			BPF_ST_MEM(BPF_B, BPF_REG_2, 0, 0xF0),
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
+		.set_optval = {},
+		.set_optlen = PAGE_SIZE + 1,
+
+		.get_level = SOL_IP,
+		.get_optname = IP_TOS,
+		.get_optval = {}, /* the changes are ignored */
+		.get_optlen = 4,
+	},
 	{
 		.descr = "setsockopt: allow changing ctx->optlen within bounds",
 		.insns = {
@@ -906,6 +973,13 @@ static int run_test(int cgroup_fd, struct sockopt_test *test)
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
@@ -921,7 +995,15 @@ static int run_test(int cgroup_fd, struct sockopt_test *test)
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
@@ -929,6 +1011,8 @@ static int run_test(int cgroup_fd, struct sockopt_test *test)
 		err = getsockopt(sock_fd, test->get_level, test->get_optname,
 				 optval, &optlen);
 		if (err) {
+			if (errno == EOPNOTSUPP && test->error == EOPNOTSUPP_GETSOCKOPT)
+				goto free_optval;
 			if (errno == EPERM && test->error == EPERM_GETSOCKOPT)
 				goto free_optval;
 			if (errno == EFAULT && test->error == EFAULT_GETSOCKOPT)
@@ -946,6 +1030,9 @@ static int run_test(int cgroup_fd, struct sockopt_test *test)
 			goto free_optval;
 		}
 
+		if (optlen > sizeof(test->get_optval))
+			optlen = sizeof(test->get_optval);
+
 		if (memcmp(optval, test->get_optval, optlen) != 0) {
 			errno = 0;
 			log_err("getsockopt returned unexpected optval");
-- 
2.40.1.521.gf1e218fcd8-goog


