Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1886F0CD0
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 22:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjD0UES (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 16:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245540AbjD0UEQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 16:04:16 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A43C2D74
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 13:04:15 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-64115ef7234so5811011b3a.1
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 13:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682625854; x=1685217854;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X6ZC+1x9ueI+ENQfDLLj/ebYGpNxhIsZZ44SjLDor/o=;
        b=CG+Do3v/bMrrZSXfYsNG+U3C+B0VWZSeG+f8ibIcH9mzKDiFoeOnhXLlWrSWVYpNIp
         MdAEdUqs+jjhWDy0+QpsXZ47DssQ0hu45tuly2Al7nnjha2ccEa55O/69NEG+PIoV9kb
         UV3OoL2i9Qw7QKpRwRPD+jgt4IkjMGpEyJh8z2K7wJLT+OTijPHtVFONZfdIhTyUHORt
         5zlt5k0Dh8iwM6yh4HO9BavQev4UzbocyZIjCnc//aWjJ2Y4CVMo9bFb85GJ8FPJcEwp
         gGDJ9hMgYB1611Er8fzzaCNY+FXCCZTmesNCp1cK6JaPeM+s5++g0iDeRg6Xm1ZgKIpx
         IGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682625854; x=1685217854;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X6ZC+1x9ueI+ENQfDLLj/ebYGpNxhIsZZ44SjLDor/o=;
        b=TXUYtkJgLENeBmrfp/pEGJL+uyLdpE4CymNQ5ANXCyE6lhxXyjQwuB5S1YNHIZVy9+
         QyDcqu45OoUi8DUe64x33GxuMTzzGaNlLLgtD8jAAngAJdqPEeTG+qHDKnPCf3ysbVjs
         AEe0XDDcvSObsOfZhK0tglLpOHw49XpXDhTp1gCmaugyZkNx2+vMGbHHy7mJqOMRrkx0
         IGx5MxdtNwKDsY0YvqEyli9oU58K8YVoWWxQojkPGX9KHETde9a1EzPkmygq/pLunpdq
         te6c0pZgmjRImAgZtJIBLNj4VTxDsnuSIBvoBto7u+QgdoCYtk2zgu/MYgHvtdjhVXQK
         bSpA==
X-Gm-Message-State: AC+VfDz3QpWNoe1BBs/vIVIFfcLewDHgauSrHWvptcyt65M+ruhBnA1o
        HcWqB8RMbsWgHq/p8O9nP3GzXmG2LGd093TDqqc0dE6VPPbxTQMRTXzqTvtkv7Sgw8NOH+2e7Y3
        sKyEs5RnhwM2cm2qHDE4s9hENd41FAD8RR3gD8VfOAFIBm3kycw==
X-Google-Smtp-Source: ACHHUZ63Ok0VMTftBu9lOB/PxjEAzFjfvSgSccoFWurF+TDBHLog28uJkhezl7DewAmSb6OrJM5fWe0=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:fc4b:0:b0:521:70e7:a8b with SMTP id
 r11-20020a63fc4b000000b0052170e70a8bmr1833684pgk.1.1682625854494; Thu, 27 Apr
 2023 13:04:14 -0700 (PDT)
Date:   Thu, 27 Apr 2023 13:04:07 -0700
In-Reply-To: <20230427200409.1785263-1-sdf@google.com>
Mime-Version: 1.0
References: <20230427200409.1785263-1-sdf@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230427200409.1785263-3-sdf@google.com>
Subject: [PATCH bpf-next v2 2/4] selftests/bpf: Update EFAULT {g,s}etsockopt selftests
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
 .../selftests/bpf/prog_tests/sockopt.c        | 80 +++++++++++++++++--
 1 file changed, 74 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt.c b/tools/testing/selftests/bpf/prog_tests/sockopt.c
index aa4debf62fc6..8dad30ce910e 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt.c
@@ -273,10 +273,30 @@ static struct sockopt_test {
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
 
@@ -287,9 +307,10 @@ static struct sockopt_test {
 		.attach_type = BPF_CGROUP_GETSOCKOPT,
 		.expected_attach_type = BPF_CGROUP_GETSOCKOPT,
 
-		.get_optlen = 64,
-
-		.error = EFAULT_GETSOCKOPT,
+		.get_level = 1234,
+		.get_optname = 5678,
+		.get_optval = {}, /* the changes are ignored */
+		.get_optlen = 4096 + 1,
 	},
 	{
 		.descr = "getsockopt: support smaller ctx->optlen",
@@ -648,6 +669,49 @@ static struct sockopt_test {
 
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
+		.set_optlen = 4096 + 1,
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
@@ -922,6 +986,7 @@ static int run_test(int cgroup_fd, struct sockopt_test *test)
 
 	if (test->get_optlen) {
 		optval = malloc(test->get_optlen);
+		memset(optval, 0, test->get_optlen);
 		socklen_t optlen = test->get_optlen;
 		socklen_t expected_get_optlen = test->get_optlen_ret ?:
 			test->get_optlen;
@@ -946,6 +1011,9 @@ static int run_test(int cgroup_fd, struct sockopt_test *test)
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

