Return-Path: <bpf+bounces-12851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD5D7D14E5
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 19:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CBD21C20FBB
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 17:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A06420318;
	Fri, 20 Oct 2023 17:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=epfl.ch header.i=@epfl.ch header.b="Ou7r7lAe"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA98F200C7
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 17:30:34 +0000 (UTC)
Received: from smtp5.epfl.ch (smtp5.epfl.ch [IPv6:2001:620:618:1e0:1:80b2:e034:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16A1A3
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 10:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epfl.ch;
      s=epfl; t=1697823028;
      h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
      bh=hLgqwFP62+qPVs4Y2SYcrFyipjFouxQMG0w08IkRhBk=;
      b=Ou7r7lAeB+22WGtD3/0D8RmnvIZawDZe7NAEAd/6IHrCVDuVAwIfH8ssdeM0uYiw/
        X3YPwOJDwfl29wGY5kNnkPgrtKHiUv/JoFCp9Gce8GflERa5JEAe4Jz4CdtoJOsqE
        803S81tketRJt+sPuHRjwgSWHCGchLKhmQVT01gxw=
Received: (qmail 14039 invoked by uid 107); 20 Oct 2023 17:30:27 -0000
Received: from ax-snat-224-178.epfl.ch (HELO ewa07.intranet.epfl.ch) (192.168.224.178) (TLS, ECDHE-RSA-AES256-GCM-SHA384 (P-256 curve) cipher)
  by mail.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPS; Fri, 20 Oct 2023 19:30:27 +0200
X-EPFL-Auth: iVw3/adAjSkqwWsEg5Z1RGrLIs2lwbbrHxQLqmknN7ykTw1giuk=
Received: from rs3labsrv2.iccluster.epfl.ch (10.90.46.62) by
 ewa07.intranet.epfl.ch (128.178.224.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.31; Fri, 20 Oct 2023 19:30:27 +0200
From: Tao Lyu <tao.lyu@epfl.ch>
To: <ast@kernel.org>, <daniel@iogearbox.net>, <john.fastabend@gmail.com>,
	<andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>, <mykolal@fb.com>
CC: <bpf@vger.kernel.org>, <sanidhya.kashyap@epfl.ch>,
	<mathias.payer@nebelwelt.net>, <meng.xu.cs@uwaterloo.ca>, <tao.lyu@epfl.ch>
Subject: Incorrect atomic_exchg verification
Date: Fri, 20 Oct 2023 19:29:41 +0200
Message-ID: <20231020172941.155388-1-tao.lyu@epfl.ch>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.90.46.62]
X-ClientProxiedBy: ewa03.intranet.epfl.ch (128.178.224.169) To
 ewa07.intranet.epfl.ch (128.178.224.178)

Hi,

I found eBPF verifier is flawed
when checking the atomic64_xchg instruction,
which will cause usability issues.

For example, the program below is safe and correct in privileged mode.
However, it mis-rejects the program.
Moreover, the error string is misleading.

0: R1=ctx(off=0,imm=0) R10=fp0
0: (7a) *(u64 *)(r10 -8) = 272        ; R10=fp0 fp-8_w=272
1: (bf) r2 = r10                      ; R2_w=fp0 R10=fp0
2: (db) r2 = atomic64_xchg((u64 *)(r2 -8), r2)
misaligned access off (0x0; 0xffffffffffffffff)+0+-8 size 8

The root cause of this bug is described below:

When checking atomic exchange instructions in check_atomic(),
the verifier checks the read and write safety on the memory r2-8.

1) In the read check (first), it marks r2 as an unknown scalar, 
as the instruction will assign the value from r2-8 to r2,
and the value at r2-8 is unknown.

2) When it comes to the second check, that is the write check,
it checks whether the memory at r2-8 is writable.
However, at this time, r2 is marked as scalar instead of stack pointer,
thus, it reports this error.

Signed-off-by: Tao Lyu <tao.lyu@epfl.ch>
---
 tools/testing/selftests/bpf/verifier/atomic_exchg.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_exchg.c

diff --git a/tools/testing/selftests/bpf/verifier/atomic_exchg.c b/tools/testing/selftests/bpf/verifier/atomic_exchg.c
new file mode 100644
index 000000000000..f05ab5f45245
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/atomic_exchg.c
@@ -0,0 +1,12 @@
+{
+    "Incorrect atomic_exchg verification",
+    .insns = {
+		BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0x110),
+		BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+		BPF_ATOMIC_OP(BPF_DW, BPF_XCHG, BPF_REG_2, BPF_REG_2, -8),
+        BPF_MOV64_IMM(BPF_REG_0, 1),
+        BPF_EXIT_INSN(),
+    },
+    .result = ACCEPT,
+},
+
-- 
2.25.1


