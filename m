Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5BC59E9A5
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 19:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbiHWR0V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 13:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235604AbiHWRZr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 13:25:47 -0400
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39E911A39;
        Tue, 23 Aug 2022 08:03:09 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4MBslz5sGsz9v7J7;
        Tue, 23 Aug 2022 22:57:51 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwBnIhqd6wRjjU5GAA--.52413S10;
        Tue, 23 Aug 2022 16:02:41 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        corbet@lwn.net, dhowells@redhat.com, jarkko@kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, shuah@kernel.org
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        deso@posteo.net, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v13 08/10] selftests/bpf: Add verifier tests for bpf_lookup_*_key() and bpf_key_put()
Date:   Tue, 23 Aug 2022 17:00:33 +0200
Message-Id: <20220823150035.711534-9-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220823150035.711534-1-roberto.sassu@huaweicloud.com>
References: <20220823150035.711534-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwBnIhqd6wRjjU5GAA--.52413S10
X-Coremail-Antispam: 1UD129KBjvJXoWxtw4UAFyUXw48KF4DWrWUtwb_yoWxAr1Dp3
        WfX3WjyF1kXF4aqrykKryIvFyagFZ8X343GasFv39rZa97Jw4xXw43ta15Wr9xtrWrXrWF
        v3W2kan7ua4UX37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1F6r1fM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20x
        vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
        3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIx
        AIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI
        42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
        80aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZo7tUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQANBF1jj4I6SwACsI
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Add verifier tests for bpf_lookup_*_key() and bpf_key_put(), to ensure that
acquired key references stored in the bpf_key structure are released, that
a non-NULL bpf_key pointer is passed to bpf_key_put(), and that key
references are not leaked.

Also, slightly modify test_verifier.c, to find the BTF ID of the attach
point for the LSM program type (currently, it is done only for TRACING).

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 tools/testing/selftests/bpf/config            |   1 +
 tools/testing/selftests/bpf/test_verifier.c   |   3 +-
 .../selftests/bpf/verifier/ref_tracking.c     | 139 ++++++++++++++++++
 3 files changed, 142 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 0fdd11e6b742..add5a5a919b4 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -30,6 +30,7 @@ CONFIG_IPV6_GRE=y
 CONFIG_IPV6_SEG6_BPF=y
 CONFIG_IPV6_SIT=y
 CONFIG_IPV6_TUNNEL=y
+CONFIG_KEYS=y
 CONFIG_LIRC=y
 CONFIG_LWTUNNEL=y
 CONFIG_MPLS=y
diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index f9d553fbf68a..2dbcbf363c18 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -1498,7 +1498,8 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 		opts.log_level = DEFAULT_LIBBPF_LOG_LEVEL;
 	opts.prog_flags = pflags;
 
-	if (prog_type == BPF_PROG_TYPE_TRACING && test->kfunc) {
+	if ((prog_type == BPF_PROG_TYPE_TRACING ||
+	     prog_type == BPF_PROG_TYPE_LSM) && test->kfunc) {
 		int attach_btf_id;
 
 		attach_btf_id = libbpf_find_vmlinux_btf_id(test->kfunc,
diff --git a/tools/testing/selftests/bpf/verifier/ref_tracking.c b/tools/testing/selftests/bpf/verifier/ref_tracking.c
index 57a83d763ec1..f18ce867271f 100644
--- a/tools/testing/selftests/bpf/verifier/ref_tracking.c
+++ b/tools/testing/selftests/bpf/verifier/ref_tracking.c
@@ -84,6 +84,145 @@
 	.errstr = "Unreleased reference",
 	.result = REJECT,
 },
+{
+	"reference tracking: acquire/release user key reference",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_1, -3),
+	BPF_MOV64_IMM(BPF_REG_2, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_LSM,
+	.kfunc = "bpf",
+	.expected_attach_type = BPF_LSM_MAC,
+	.flags = BPF_F_SLEEPABLE,
+	.fixup_kfunc_btf_id = {
+		{ "bpf_lookup_user_key", 2 },
+		{ "bpf_key_put", 5 },
+	},
+	.result = ACCEPT,
+},
+{
+	"reference tracking: acquire/release system key reference",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_1, 1),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_LSM,
+	.kfunc = "bpf",
+	.expected_attach_type = BPF_LSM_MAC,
+	.flags = BPF_F_SLEEPABLE,
+	.fixup_kfunc_btf_id = {
+		{ "bpf_lookup_system_key", 1 },
+		{ "bpf_key_put", 4 },
+	},
+	.result = ACCEPT,
+},
+{
+	"reference tracking: release user key reference without check",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_1, -3),
+	BPF_MOV64_IMM(BPF_REG_2, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_LSM,
+	.kfunc = "bpf",
+	.expected_attach_type = BPF_LSM_MAC,
+	.flags = BPF_F_SLEEPABLE,
+	.errstr = "arg#0 pointer type STRUCT bpf_key must point to scalar, or struct with scalar",
+	.fixup_kfunc_btf_id = {
+		{ "bpf_lookup_user_key", 2 },
+		{ "bpf_key_put", 4 },
+	},
+	.result = REJECT,
+},
+{
+	"reference tracking: release system key reference without check",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_1, 1),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_LSM,
+	.kfunc = "bpf",
+	.expected_attach_type = BPF_LSM_MAC,
+	.flags = BPF_F_SLEEPABLE,
+	.errstr = "arg#0 pointer type STRUCT bpf_key must point to scalar, or struct with scalar",
+	.fixup_kfunc_btf_id = {
+		{ "bpf_lookup_system_key", 1 },
+		{ "bpf_key_put", 3 },
+	},
+	.result = REJECT,
+},
+{
+	"reference tracking: release with NULL key pointer",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_1, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_LSM,
+	.kfunc = "bpf",
+	.expected_attach_type = BPF_LSM_MAC,
+	.flags = BPF_F_SLEEPABLE,
+	.errstr = "arg#0 pointer type STRUCT bpf_key must point to scalar, or struct with scalar",
+	.fixup_kfunc_btf_id = {
+		{ "bpf_key_put", 1 },
+	},
+	.result = REJECT,
+},
+{
+	"reference tracking: leak potential reference to user key",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_1, -3),
+	BPF_MOV64_IMM(BPF_REG_2, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_LSM,
+	.kfunc = "bpf",
+	.expected_attach_type = BPF_LSM_MAC,
+	.flags = BPF_F_SLEEPABLE,
+	.errstr = "Unreleased reference",
+	.fixup_kfunc_btf_id = {
+		{ "bpf_lookup_user_key", 2 },
+	},
+	.result = REJECT,
+},
+{
+	"reference tracking: leak potential reference to system key",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_1, 1),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_LSM,
+	.kfunc = "bpf",
+	.expected_attach_type = BPF_LSM_MAC,
+	.flags = BPF_F_SLEEPABLE,
+	.errstr = "Unreleased reference",
+	.fixup_kfunc_btf_id = {
+		{ "bpf_lookup_system_key", 1 },
+	},
+	.result = REJECT,
+},
 {
 	"reference tracking: release reference without check",
 	.insns = {
-- 
2.25.1

