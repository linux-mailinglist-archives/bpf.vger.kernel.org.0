Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992F86C58CC
	for <lists+bpf@lfdr.de>; Wed, 22 Mar 2023 22:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjCVVbI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Mar 2023 17:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCVVbI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Mar 2023 17:31:08 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44F52A6C6
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 14:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=nKntcl0eXoSkp8wDEydAiPI5oRhhb5c05TRhqpny2bs=; b=Q9nDC2XPhhI3NWEmE5+l77q2Ma
        SGCkd+ic7YgZSXHMUCxJ1Ju2lzMXpDIVxRfQDho735Zk+pRjzrPX4ShfjO5YT/+tfZnvrEWv5fchs
        bDdgOMO8egUE8NUOGU5KFII6IqFBDwq9kxgCAOFYbfeZ/ejMycBzY4ZejGg3XeqEL29wlnTFYBzag
        PEJHJxkdK/ulJaNdAUK/zANb36uGyYA/P4EghPOTjCPYC35TOsge1SN9fmrGnS0WxNhhUCKui0KIf
        uJ07DesPR88jesmpqR5Gdm8yy/QoBmMdfkcxTqf3gnPkwFmpvdCXyI5/FEAerv61dE9MJNZPfjoQc
        C5JotbrQ==;
Received: from [81.6.34.132] (helo=localhost)
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pf62x-0000fs-0m; Wed, 22 Mar 2023 22:31:03 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     bpf@vger.kernel.org
Cc:     Xu Kuohai <xukuohai@huawei.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Check when bounds are not in the 32-bit range
Date:   Wed, 22 Mar 2023 22:30:56 +0100
Message-Id: <20230322213056.2470-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230322213056.2470-1-daniel@iogearbox.net>
References: <20230322213056.2470-1-daniel@iogearbox.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26851/Wed Mar 22 08:22:49 2023)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Xu Kuohai <xukuohai@huawei.com>

Add cases to check if bound is updated correctly when 64-bit value is
not in the 32-bit range.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: John Fastabend <john.fastabend@gmail.com>
---
 tools/testing/selftests/bpf/verifier/bounds.c | 121 ++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/bounds.c b/tools/testing/selftests/bpf/verifier/bounds.c
index 33125d5f6772..74b1917d4208 100644
--- a/tools/testing/selftests/bpf/verifier/bounds.c
+++ b/tools/testing/selftests/bpf/verifier/bounds.c
@@ -753,3 +753,124 @@
 	.result_unpriv = REJECT,
 	.result = ACCEPT,
 },
+{
+	"bound check with JMP_JLT for crossing 64-bit signed boundary",
+	.insns = {
+	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, offsetof(struct xdp_md, data)),
+	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data_end)),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
+	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 8),
+
+	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_2, 0),
+	BPF_LD_IMM64(BPF_REG_0, 0x7fffffffffffff10),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
+
+	BPF_LD_IMM64(BPF_REG_0, 0x8000000000000000),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
+	/* r1 unsigned range is [0x7fffffffffffff10, 0x800000000000000f] */
+	BPF_JMP_REG(BPF_JLT, BPF_REG_0, BPF_REG_1, -2),
+
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_XDP,
+},
+{
+	"bound check with JMP_JSLT for crossing 64-bit signed boundary",
+	.insns = {
+	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, offsetof(struct xdp_md, data)),
+	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data_end)),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
+	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 8),
+
+	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_2, 0),
+	BPF_LD_IMM64(BPF_REG_0, 0x7fffffffffffff10),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
+
+	BPF_LD_IMM64(BPF_REG_0, 0x8000000000000000),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
+	/* r1 signed range is [S64_MIN, S64_MAX] */
+	BPF_JMP_REG(BPF_JSLT, BPF_REG_0, BPF_REG_1, -2),
+
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.errstr = "BPF program is too large",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_XDP,
+},
+{
+	"bound check for loop upper bound greater than U32_MAX",
+	.insns = {
+	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, offsetof(struct xdp_md, data)),
+	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data_end)),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
+	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 8),
+
+	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_2, 0),
+	BPF_LD_IMM64(BPF_REG_0, 0x100000000),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
+
+	BPF_LD_IMM64(BPF_REG_0, 0x100000000),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
+	BPF_JMP_REG(BPF_JLT, BPF_REG_0, BPF_REG_1, -2),
+
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_XDP,
+},
+{
+	"bound check with JMP32_JLT for crossing 32-bit signed boundary",
+	.insns = {
+	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, offsetof(struct xdp_md, data)),
+	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data_end)),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
+	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 6),
+
+	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_2, 0),
+	BPF_MOV32_IMM(BPF_REG_0, 0x7fffff10),
+	BPF_ALU32_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
+
+	BPF_MOV32_IMM(BPF_REG_0, 0x80000000),
+	BPF_ALU32_IMM(BPF_ADD, BPF_REG_0, 1),
+	/* r1 unsigned range is [0, 0x8000000f] */
+	BPF_JMP32_REG(BPF_JLT, BPF_REG_0, BPF_REG_1, -2),
+
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_XDP,
+},
+{
+	"bound check with JMP32_JSLT for crossing 32-bit signed boundary",
+	.insns = {
+	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, offsetof(struct xdp_md, data)),
+	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data_end)),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
+	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 6),
+
+	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_2, 0),
+	BPF_MOV32_IMM(BPF_REG_0, 0x7fffff10),
+	BPF_ALU32_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
+
+	BPF_MOV32_IMM(BPF_REG_0, 0x80000000),
+	BPF_ALU32_IMM(BPF_ADD, BPF_REG_0, 1),
+	/* r1 signed range is [S32_MIN, S32_MAX] */
+	BPF_JMP32_REG(BPF_JSLT, BPF_REG_0, BPF_REG_1, -2),
+
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.errstr = "BPF program is too large",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_XDP,
+},
-- 
2.34.1

