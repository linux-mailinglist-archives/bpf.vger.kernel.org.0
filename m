Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AD26F720F
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 20:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjEDSn5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 May 2023 14:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjEDSn4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 May 2023 14:43:56 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95BA3C33
        for <bpf@vger.kernel.org>; Thu,  4 May 2023 11:43:55 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-24e4acd6b61so815696a91.0
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 11:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683225835; x=1685817835;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/3xzJqXZINYQ6by+RhH9U+CaIbju+7gxyxI1+MBCtPk=;
        b=pshkpGU/J0+LynyNbeooURI4J9nSKSiNR7rhe59/029GGiOuBZ2aDsayDwGLSKo5hR
         HpmOMHnWYeXaYUNe+MLUncmE92vsGHauzJ4SO8l61B5pvz8lWM17w/nlY/z45iB1oN1R
         SUURZmxCRYUJyctoRCRROumbwalde3RlKOQz9fAXEIr0f+vgAggUXjl1BSU7otvj4KeS
         MJFDJnmXFHwFOCdXtR+XLODZlrOen14W5C/PaJkIKhWIiqkmP6qU+6BSKCm2TNdP9Ve9
         WE5Hw8OTSu3PUenUYSP7aJshnmikvlm1qYp0FkX6l/F7inipxhOUTHgC07QkTbd0F/GZ
         mJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683225835; x=1685817835;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/3xzJqXZINYQ6by+RhH9U+CaIbju+7gxyxI1+MBCtPk=;
        b=X8PW75a/1JpMdfXEr1mphiUE6TruQrEY1D3HKQfpS6n9EGz1WwMJi+Gtz9NTv6Sznc
         UMi/YCmmtZ7r7+1jgFtuhcuotRoN+izxOGox0prf8b8JVj+aUZghZ1QLzbrtacY5SAhB
         k1APdF4DfuuQLDVzoImIzaXjfMcKFonyY9fKIaqG+XB3duN7qI3LY/5kow3RxjKBjFZ/
         jx+ESwU5qdNn5mh5JIJ5X4RKyzAU8rmEKxCSqWQfiIn41cXI1BdeiDu1Lmk7n0nsF3NQ
         wsxYak8fQ3UIh8vc4sXiFEOwG97cWTAzijCKVaSbYEf0H6pXEoCgGYVvo+L3TEG7ECo1
         ofgg==
X-Gm-Message-State: AC+VfDyqSO8d5Mvdig26nPNZTyevbXY5M1ufxpUAqCgPlM7sMbZxle9d
        mxsM53uWmdN8iunRHGAKAV8Nj3DcJyed8kT53c5FcfBAxBhN+/lPJ9eLl6fOnCB6R4Jo4JkuOvP
        nVNMetSNM7NsFmRzHY30nCTYPLFDEn3gL2ToziDBSGdEOhTT41Q==
X-Google-Smtp-Source: ACHHUZ5HAZvHxQylIFwe113Kne+St9CJ4wTsOEPA4UCRaEW0QjyIkonqogx4p4JyevImtT1Ti66FUV0=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90b:e94:b0:24d:ef90:8552 with SMTP id
 fv20-20020a17090b0e9400b0024def908552mr857908pjb.3.1683225835105; Thu, 04 May
 2023 11:43:55 -0700 (PDT)
Date:   Thu,  4 May 2023 11:43:47 -0700
In-Reply-To: <20230504184349.3632259-1-sdf@google.com>
Mime-Version: 1.0
References: <20230504184349.3632259-1-sdf@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230504184349.3632259-3-sdf@google.com>
Subject: [PATCH bpf-next v4 2/4] selftests/bpf: Update EFAULT {g,s}etsockopt selftests
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
 .../selftests/bpf/prog_tests/sockopt.c        | 103 +++++++++++++++++-
 1 file changed, 97 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt.c b/tools/testing/selftests/bpf/prog_tests/sockopt.c
index aa4debf62fc6..146b35473dcc 100644
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
@@ -648,6 +676,49 @@ static struct sockopt_test {
 
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
@@ -906,6 +977,13 @@ static int run_test(int cgroup_fd, struct sockopt_test *test)
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
@@ -921,7 +999,15 @@ static int run_test(int cgroup_fd, struct sockopt_test *test)
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
@@ -929,6 +1015,8 @@ static int run_test(int cgroup_fd, struct sockopt_test *test)
 		err = getsockopt(sock_fd, test->get_level, test->get_optname,
 				 optval, &optlen);
 		if (err) {
+			if (errno == EOPNOTSUPP && test->error == EOPNOTSUPP_GETSOCKOPT)
+				goto free_optval;
 			if (errno == EPERM && test->error == EPERM_GETSOCKOPT)
 				goto free_optval;
 			if (errno == EFAULT && test->error == EFAULT_GETSOCKOPT)
@@ -946,6 +1034,9 @@ static int run_test(int cgroup_fd, struct sockopt_test *test)
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

