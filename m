Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8FC6C3B40
	for <lists+bpf@lfdr.de>; Tue, 21 Mar 2023 21:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjCUUJN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 16:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjCUUJM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 16:09:12 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52FE23861
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 13:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=FRzy+JU8J6I6w4NYT0F96m0Z/r0IBlgWhzpWmtbwv/g=; b=g8R0h1av2SeZq1i8F1PMksQK9o
        OQrQNE+uSKz2V3ZjInuQtBYrtn6hOsmr1AiiVWPsXuqCO3linccIAh68b20OwQ8htDgFUephHvI/Z
        43N46D/n5SaEiSe6gPQL+vqo3O96mKSdezTJXMC2NUlvgiSXInqS4sdMMxMM45m5icsZtKdAdAeqA
        g/2F5p2xtqgqxeAGsNFEUEOA7tn5tamO5HCUdIVi6aC/6JB6Bqq3K6uKRxKOCXh+IA3OIhfxoTf3T
        JeOB6zsq+NhQMXmOtWtEVH7f8udcnRdm6h8AkAVkV4sFJOgJ7hDLkn4G/xksKf88+/SEq4I0tOitb
        TGq8tBqw==;
Received: from [81.6.34.132] (helo=localhost)
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pehkG-000CQd-RR; Tue, 21 Mar 2023 20:34:08 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     bpf@vger.kernel.org
Cc:     Xu Kuohai <xukuohai@huawei.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Check when bounds are not in the 32-bit range
Date:   Tue, 21 Mar 2023 20:33:54 +0100
Message-Id: <20230321193354.10445-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230321193354.10445-1-daniel@iogearbox.net>
References: <20230321193354.10445-1-daniel@iogearbox.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26850/Tue Mar 21 08:22:52 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
2.27.0

