Return-Path: <bpf+bounces-15565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB1C7F34F8
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 18:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ABD8B213F3
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 17:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F3A5B1FC;
	Tue, 21 Nov 2023 17:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=epfl.ch header.i=@epfl.ch header.b="zOAWITTj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp5.epfl.ch (smtp5.epfl.ch [IPv6:2001:620:618:1e0:1:80b2:e034:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8B8A4
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 09:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epfl.ch;
      s=epfl; t=1700587966;
      h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Content-Type;
      bh=jvGH3NXa5GlWcCaBDaa8HWpUyA7/lGEVd6apye4g4uc=;
      b=zOAWITTjPTAyka5Sl6K/2XS0xYh3bAFZ36mU5Kc9H25xcgqsxSofP1qkAeZ2Htbbv
        o8skMXMqwR/zBcSKCA5t1MrCwwMl4xXQUHMCYZiqNRWxnrIkhB87FrCLuY5s0PTKQ
        w3Mwv1zDpaOKAFZ2dKyoEulNLAxeeTxAb+pBWv91E=
Received: (qmail 3237 invoked by uid 107); 21 Nov 2023 17:32:46 -0000
Received: from ax-snat-224-178.epfl.ch (HELO ewa07.intranet.epfl.ch) (192.168.224.178) (TLS, ECDHE-RSA-AES256-GCM-SHA384 (P-256 curve) cipher)
  by mail.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPS; Tue, 21 Nov 2023 18:32:46 +0100
X-EPFL-Auth: VRUgMN/hQcQlK1BLiy9zSVOoAsGGoPPzcQRUwI0cisOKrDksmp8=
Received: from rs3labsrv2.iccluster.epfl.ch (10.90.46.62) by
 ewa07.intranet.epfl.ch (128.178.224.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 21 Nov 2023 18:32:43 +0100
From: Tao Lyu <tao.lyu@epfl.ch>
To: <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<song@kernel.org>, <yonghong.song@linux.dev>, <haoluo@google.com>,
	<martin.lau@linux.dev>
CC: <bpf@vger.kernel.org>, <sanidhya.kashyap@epfl.ch>,
	<mathias.payer@nebelwelt.net>, <meng.xu.cs@uwaterloo.ca>, Tao Lyu
	<tao.lyu@epfl.ch>
Subject: max<min after jset
Date: Tue, 21 Nov 2023 18:32:06 +0100
Message-ID: <20231121173206.3594040-1-tao.lyu@epfl.ch>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.46.62]
X-ClientProxiedBy: ewa12.intranet.epfl.ch (128.178.224.187) To
 ewa07.intranet.epfl.ch (128.178.224.178)

Hi,

The eBPF program shown below leads to an reversed min and max
after insn 6 "if w0 & 0x894b6a55 goto +2",
whic means max < min.

Here is the introduction how it happens.

Before insn 6,
the range of r0 expressed by the min and max field is
min1 = 884670597, max1 = 900354100
And the range expressed by the var_off=(0x34000000; 0x1ff5fbf))
is min2=872415232, max2=905928639.

---min2-----------------------min1-----max1-----max2---

Here we can see that the range expressed by var_off is wider than that of min and max.

When verifying insn6,
it first uses the var_off and immediate "0x894b6a55" to
calculate the new var_off=(0x34b00000; 0x415aa).
The range expressed by the new var_off is:
min3=883949568, max3=884217258

---min2-----min3-----max3-----min1-----max1-----max2---

And then it will calculate the new min and max by:
(1) new-min = MAX(min3, min1) = min1
(2) new-max = MIN(max3, max1) = max3

---min2-----min3-----max3-----min1-----max1-----max2---
         "new-max"          "new-min" 

Now, the new-max becomes less than the new min.

Notably, [min1, max1] can never make "w0 & 0x894b6a55 == 0"
and thus cannot goes the fall-through branch.
In other words, actually the fall-trough branch is a dead path.

BTW, I cannot successfully compile this instruciton "if w0 != 0 goto +2;\"
in the c inline assembly code.
So I can only attach the bytecodes.

Signed-off-by: Tao Lyu <tao.lyu@epfl.ch>
---
 .../selftests/bpf/verifier/jset_reversed_range.c  | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/verifier/jset_reversed_range.c

diff --git a/tools/testing/selftests/bpf/verifier/jset_reversed_range.c b/tools/testing/selftests/bpf/verifier/jset_reversed_range.c
new file mode 100644
index 000000000000..734f492a2a96
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/jset_reversed_range.c
@@ -0,0 +1,15 @@
+{
+    "BPF_JSET: incorrect scalar range",
+    .insns = {
+    BPF_MOV64_IMM(BPF_REG_5, 100),
+    BPF_ALU64_IMM(BPF_DIV, BPF_REG_5, 3),
+    BPF_ALU32_IMM(BPF_RSH, BPF_REG_5, 7),
+    BPF_ALU64_IMM(BPF_AND, BPF_REG_5, -386969681),
+    BPF_ALU64_IMM(BPF_SUB, BPF_REG_5, -884670597),
+    BPF_MOV32_REG(BPF_REG_0, BPF_REG_5),
+    BPF_JMP32_IMM(BPF_JSET, BPF_REG_0, 0x894b6a55, 1),
+    BPF_MOV64_IMM(BPF_REG_0, 1),
+    BPF_MOV64_IMM(BPF_REG_0, 0),
+    BPF_EXIT_INSN(),
+    },
+},
-- 
2.25.1


