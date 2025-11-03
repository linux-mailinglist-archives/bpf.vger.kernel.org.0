Return-Path: <bpf+bounces-73330-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D95BC2A9A1
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 09:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5C603A5771
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 08:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB192E093F;
	Mon,  3 Nov 2025 08:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e2llAf04"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48572DBF75
	for <bpf@vger.kernel.org>; Mon,  3 Nov 2025 08:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762159365; cv=none; b=gBNDOo0u3aYp5bZaNkqSlbdQrkzIi6ng+a7MDiWU3EbziqVRtVJoNQ6aTGDyOru5Pz9iGwLYHccbdlOXSnAKBxaonmchxyAq2bnEnWzTxsMgA98m1Eug8SKXfHlyCtVM/dBQdopHc9tOKMnSO9a/Mmcips1IMjxTLXSKmD5AU5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762159365; c=relaxed/simple;
	bh=pL6QkzO6ebFeaF3cWNBoKsDA3L6V2A3jJUIGwOM82Hs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JCnJpnw7Qi9giqf2Idr+HL6kBZZ8Op6QLY/NBWKc+CZYrTsS2Ap9sCOPcXPA4qU8xeVbYYIWpvZVKEd+vsKaYh3Y9bY6gWYqnmqW1ygY+D0jd11qe11HOOASvkwUuh/JydOuhW55rBiuDqh1afQKgYdvvKjex0Rn3ROFjvAR7I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e2llAf04; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762159350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FQsNfh1GGsfH4N7UPatGUlnLBDtyUYCePR7Ny0Amo+M=;
	b=e2llAf0407iTPU5zM/bNRIZWphIG7W5OPZgcRieYGV4z6ljt3aBx26CVYQRxpbiNxncQDv
	Hp659gj5seIIffH4Y+OLmoH+Z5x+Gj3Yj31t3Qpth8gjcA+ZpZbaTpZN2wmpHW31fbJeJk
	P+YtWKZmspXZwBBUF5ZYt5Wo5b+tgRE=
From: george <dongtai.guo@linux.dev>
Date: Mon, 03 Nov 2025 16:42:19 +0800
Subject: [PATCH] LoongArch: BPF: Fix sign extension for 12-bit immediates
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-1-v1-1-20e6641a57da@linux.dev>
X-B4-Tracking: v=1; b=H4sIAOpqCGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQwNjXUNdS7O0xEQjE4NUizQTJaC6gqLUtMwKsBnRsbW1ADnkze9TAAA
 A
X-Change-ID: 20251103-1-96faa240e8f4
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
 Hengqi Chen <hengqi.chen@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>, Youling Tang <tangyouling@loongson.cn>
Cc: bpf@vger.kernel.org, loongarch@lists.linux.dev, 
 linux-kernel@vger.kernel.org, George Guo <guodongtai@kylinos.cn>, 
 Bing Huang <huangbing@kylinos.cn>, george <dongtai.guo@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762159345; l=1770;
 i=dongtai.guo@linux.dev; s=20251103; h=from:subject:message-id;
 bh=r6iB+4QUzkiglp5aKNaGVGvpWZUg0I6p/aqNCFK0rKM=;
 b=b6fz9sckY6WVUreZ8Lba7h8hRBGk7JGTdKxLeSiwHsv/vtTZiTkhpyg0ZcPubLyabtVrI15zB
 q4+opYAPvg3BJqIiyqbVvRuTGYZx3+srGEKEZtP5sCqew+rPuNmcxb2
X-Developer-Key: i=dongtai.guo@linux.dev; a=ed25519;
 pk=yHUJPGx/kAXutP/NSHpj7hWW0KQNlv3w9H6ju4qUoTM=
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

When loading immediate values that fit within 12-bit signed range,
the move_imm function incorrectly used zero extension instead of
sign extension.

The bug was exposed when scx_simple scheduler failed with -EINVAL
in ops.init() after passing node = -1 to scx_bpf_create_dsq().
Due to incorrect sign extension, `node >= (int)nr_node_ids`
evaluated to true instead of false, causing BPF program failure.

Verified by testing with the scx_simple scheduler (located in
tools/sched_ext/). After building with `make` and running
./tools/sched_ext/build/bin/scx_simple, the scheduler now
initializes successfully with this fix.

Fix this by using sign extension (sext) instead of zero extension
for signed immediate values in move_imm.

Fixes: 5dc615520c4d ("LoongArch: Add BPF JIT support")
Reported-by: Bing Huang <huangbing@kylinos.cn>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
Signed-off-by: george <dongtai.guo@linux.dev>
---
 arch/loongarch/net/bpf_jit.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/net/bpf_jit.h b/arch/loongarch/net/bpf_jit.h
index 5697158fd1645fdc3d83f598b00a9e20dfaa8f6d..f1398eb135b69ae61a27ed81f80b4bb0788cf0a0 100644
--- a/arch/loongarch/net/bpf_jit.h
+++ b/arch/loongarch/net/bpf_jit.h
@@ -122,7 +122,8 @@ static inline void move_imm(struct jit_ctx *ctx, enum loongarch_gpr rd, long imm
 	/* addiw rd, $zero, imm_11_0 */
 	if (is_signed_imm12(imm)) {
 		emit_insn(ctx, addiw, rd, LOONGARCH_GPR_ZERO, imm);
-		goto zext;
+		emit_sext_32(ctx, rd, is32);
+		return;
 	}
 
 	/* ori rd, $zero, imm_11_0 */

---
base-commit: 6146a0f1dfae5d37442a9ddcba012add260bceb0
change-id: 20251103-1-96faa240e8f4

Best regards,
-- 
george <dongtai.guo@linux.dev>


