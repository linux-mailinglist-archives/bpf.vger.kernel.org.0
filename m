Return-Path: <bpf+bounces-40981-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AC1990B06
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 20:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFE5CB2685C
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 18:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29EA2141DA;
	Fri,  4 Oct 2024 18:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSwkhrYT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B1D2101BE;
	Fri,  4 Oct 2024 18:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065928; cv=none; b=b+NPBuCS73GMwwcH+eupBxFi4Jv2tIZi0KUM2VR5iB71Zu3trUGZ/L3FrEI5xuhC5mRp0P6ZGRrTAYn9Tnf7Yj/+SQkh3bbXaoU/esyzlrUyPI1pMkxTj3huvh4WQiqrlZEdCvHy4W2/F6az7R8Fl+vhd29TRlZn7JvlnF2AFm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065928; c=relaxed/simple;
	bh=2ahOnuwk7l3o0EEDnBU0EMIb5Yw7a5n5+yQc/ukKReY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MIbQghRmEqb+LYY97gRjUh5ZQORQIIJ92kjQmaVUlYZoc8qNgrlkfFH90Ensaw4RGhJBrtctX9JKa/k9dJzu9y63kZTkWEH1DNyfGtwtGPxFCEuyZB4eUu0zbCFuRJmqWv7BeuInEleOFwlYaTdRW+X7olaQzXm7BeMnYNwddGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSwkhrYT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8459AC4CECE;
	Fri,  4 Oct 2024 18:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728065928;
	bh=2ahOnuwk7l3o0EEDnBU0EMIb5Yw7a5n5+yQc/ukKReY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gSwkhrYT+dL/TYXGR7TJgDJn4Qbw/Z28su66ftIjuKsuRw/2xU74QimNkuxbD+Eeh
	 QoNpkmLX1RxO6ALi4H2lTVOXW4xXHDPKldZKyC3NGsMbWJ6bP1nV7T6A32D6qfIHRI
	 FhpPAuv0hR+/ONEu/WzgohGhxcTF0O9RXTAbP6L+rESs6MOXPC6M7y8KCMoC2BJKfx
	 nonpJn/z598hzMenttgc5ju1uQJuZFajRMTlUKJHyLpbcWua/TjsPQQzJWh0DEWbk6
	 ZznX4NOmTdJIgOeLF06CY6I1UTgbmzDPNYbGpe0293LPz+fdWYYrZ6uNLBi01zPUHl
	 E1uLXiNmKDo4A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yonghong Song <yonghong.song@linux.dev>,
	Daniel Hodges <hodgesd@meta.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	dsahern@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 10/76] bpf, x64: Fix a jit convergence issue
Date: Fri,  4 Oct 2024 14:16:27 -0400
Message-ID: <20241004181828.3669209-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004181828.3669209-1-sashal@kernel.org>
References: <20241004181828.3669209-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.2
Content-Transfer-Encoding: 8bit

From: Yonghong Song <yonghong.song@linux.dev>

[ Upstream commit c8831bdbfbab672c006a18006d36932a494b2fd6 ]

Daniel Hodges reported a jit error when playing with a sched-ext program.
The error message is:
  unexpected jmp_cond padding: -4 bytes

But further investigation shows the error is actual due to failed
convergence. The following are some analysis:

  ...
  pass4, final_proglen=4391:
    ...
    20e:    48 85 ff                test   rdi,rdi
    211:    74 7d                   je     0x290
    213:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
    ...
    289:    48 85 ff                test   rdi,rdi
    28c:    74 17                   je     0x2a5
    28e:    e9 7f ff ff ff          jmp    0x212
    293:    bf 03 00 00 00          mov    edi,0x3

Note that insn at 0x211 is 2-byte cond jump insn for offset 0x7d (-125)
and insn at 0x28e is 5-byte jmp insn with offset -129.

  pass5, final_proglen=4392:
    ...
    20e:    48 85 ff                test   rdi,rdi
    211:    0f 84 80 00 00 00       je     0x297
    217:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
    ...
    28d:    48 85 ff                test   rdi,rdi
    290:    74 1a                   je     0x2ac
    292:    eb 84                   jmp    0x218
    294:    bf 03 00 00 00          mov    edi,0x3

Note that insn at 0x211 is 6-byte cond jump insn now since its offset
becomes 0x80 based on previous round (0x293 - 0x213 = 0x80). At the same
time, insn at 0x292 is a 2-byte insn since its offset is -124.

pass6 will repeat the same code as in pass4. pass7 will repeat the same
code as in pass5, and so on. This will prevent eventual convergence.

Passes 1-14 are with padding = 0. At pass15, padding is 1 and related
insn looks like:

    211:    0f 84 80 00 00 00       je     0x297
    217:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
    ...
    24d:    48 85 d2                test   rdx,rdx

The similar code in pass14:
    211:    74 7d                   je     0x290
    213:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
    ...
    249:    48 85 d2                test   rdx,rdx
    24c:    74 21                   je     0x26f
    24e:    48 01 f7                add    rdi,rsi
    ...

Before generating the following insn,
  250:    74 21                   je     0x273
"padding = 1" enables some checking to ensure nops is either 0 or 4
where
  #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
  nops = INSN_SZ_DIFF - 2

In this specific case,
  addrs[i] = 0x24e // from pass14
  addrs[i-1] = 0x24d // from pass15
  prog - temp = 3 // from 'test rdx,rdx' in pass15
so
  nops = -4
and this triggers the failure.

To fix the issue, we need to break cycles of je <-> jmp. For example,
in the above case, we have
  211:    74 7d                   je     0x290
the offset is 0x7d. If 2-byte je insn is generated only if
the offset is less than 0x7d (<= 0x7c), the cycle can be
break and we can achieve the convergence.

I did some study on other cases like je <-> je, jmp <-> je and
jmp <-> jmp which may cause cycles. Those cases are not from actual
reproducible cases since it is pretty hard to construct a test case
for them. the results show that the offset <= 0x7b (0x7b = 123) should
be enough to cover all cases. This patch added a new helper to generate 8-bit
cond/uncond jmp insns only if the offset range is [-128, 123].

Reported-by: Daniel Hodges <hodgesd@meta.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
Link: https://lore.kernel.org/r/20240904221251.37109-1-yonghong.song@linux.dev
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 54 +++++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index d25d81c8ecc00..f609dc379be75 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -64,6 +64,56 @@ static bool is_imm8(int value)
 	return value <= 127 && value >= -128;
 }
 
+/*
+ * Let us limit the positive offset to be <= 123.
+ * This is to ensure eventual jit convergence For the following patterns:
+ * ...
+ * pass4, final_proglen=4391:
+ *   ...
+ *   20e:    48 85 ff                test   rdi,rdi
+ *   211:    74 7d                   je     0x290
+ *   213:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
+ *   ...
+ *   289:    48 85 ff                test   rdi,rdi
+ *   28c:    74 17                   je     0x2a5
+ *   28e:    e9 7f ff ff ff          jmp    0x212
+ *   293:    bf 03 00 00 00          mov    edi,0x3
+ * Note that insn at 0x211 is 2-byte cond jump insn for offset 0x7d (-125)
+ * and insn at 0x28e is 5-byte jmp insn with offset -129.
+ *
+ * pass5, final_proglen=4392:
+ *   ...
+ *   20e:    48 85 ff                test   rdi,rdi
+ *   211:    0f 84 80 00 00 00       je     0x297
+ *   217:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
+ *   ...
+ *   28d:    48 85 ff                test   rdi,rdi
+ *   290:    74 1a                   je     0x2ac
+ *   292:    eb 84                   jmp    0x218
+ *   294:    bf 03 00 00 00          mov    edi,0x3
+ * Note that insn at 0x211 is 6-byte cond jump insn now since its offset
+ * becomes 0x80 based on previous round (0x293 - 0x213 = 0x80).
+ * At the same time, insn at 0x292 is a 2-byte insn since its offset is
+ * -124.
+ *
+ * pass6 will repeat the same code as in pass4 and this will prevent
+ * eventual convergence.
+ *
+ * To fix this issue, we need to break je (2->6 bytes) <-> jmp (5->2 bytes)
+ * cycle in the above. In the above example je offset <= 0x7c should work.
+ *
+ * For other cases, je <-> je needs offset <= 0x7b to avoid no convergence
+ * issue. For jmp <-> je and jmp <-> jmp cases, jmp offset <= 0x7c should
+ * avoid no convergence issue.
+ *
+ * Overall, let us limit the positive offset for 8bit cond/uncond jmp insn
+ * to maximum 123 (0x7b). This way, the jit pass can eventually converge.
+ */
+static bool is_imm8_jmp_offset(int value)
+{
+	return value <= 123 && value >= -128;
+}
+
 static bool is_simm32(s64 value)
 {
 	return value == (s64)(s32)value;
@@ -2184,7 +2234,7 @@ st:			if (is_imm8(insn->off))
 				return -EFAULT;
 			}
 			jmp_offset = addrs[i + insn->off] - addrs[i];
-			if (is_imm8(jmp_offset)) {
+			if (is_imm8_jmp_offset(jmp_offset)) {
 				if (jmp_padding) {
 					/* To keep the jmp_offset valid, the extra bytes are
 					 * padded before the jump insn, so we subtract the
@@ -2266,7 +2316,7 @@ st:			if (is_imm8(insn->off))
 				break;
 			}
 emit_jmp:
-			if (is_imm8(jmp_offset)) {
+			if (is_imm8_jmp_offset(jmp_offset)) {
 				if (jmp_padding) {
 					/* To avoid breaking jmp_offset, the extra bytes
 					 * are padded before the actual jmp insn, so
-- 
2.43.0


