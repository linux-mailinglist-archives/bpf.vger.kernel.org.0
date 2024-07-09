Return-Path: <bpf+bounces-34192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1717892AEDA
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 05:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D1441F22D52
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 03:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B8E839E4;
	Tue,  9 Jul 2024 03:45:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C17487BF;
	Tue,  9 Jul 2024 03:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720496705; cv=none; b=qdT6NOA2qd2X2dlMMma+ytK6XjdpAawUnUj9nOFB8uMt0DbX6aeysV9+nVU8d+0E9pYMay74Zw3SjwPI+oU53mV/2xc2LvPuZN44uU14n9PzUobQW3jQ4KYVxcnzMLgw1H8ockPG2/mW8w4zSY3a2FCkOdEcnswYnrozi6Og5AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720496705; c=relaxed/simple;
	bh=Pw4p8/KcbKYCtsHR85RU59eLYetIK69UMFr3IQeUTms=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FdChqc5gR+u3jSLEFOgD/GJE3kuPuWLmzMyg0bSDcr3yXsxKS5rJrditqwPj1xNXJeDmRKlgl7C148Cn418q4k5HqzBfrH4nKU0AQTpcsKCQ7ZoK4gAxiqNCGN938Bw85L+CsvHq8kNiU3FzOFzV9PTcCPfH1PmU7rnvqkqyOps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-01 (Coremail) with SMTP id qwCowABnbckxsoxmXAFdAg--.261S2;
	Tue, 09 Jul 2024 11:44:49 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: akpm@linux-foundation.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] test_bpf: Convert comma to semicolon
Date: Tue,  9 Jul 2024 11:43:23 +0800
Message-Id: <20240709034323.586185-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABnbckxsoxmXAFdAg--.261S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFy5WF4DZr48GrWfJF47urg_yoW8JFykpF
	n8GayDCr4UXr43tay5JrW2vw48uFW2y3sFgr9FyrW7Aay3AF15JayrK3yYyrn3ZayrWa1S
	vr17ur13Z3ZrJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7
	v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF
	7I0E8cxan2IY04v7MxkIecxEwVAFwVW8GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JU9XocUUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Replace a comma between expression statements by a semicolon.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 lib/test_bpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index b7acc29bcc3b..ca4b0eea81a2 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -1740,7 +1740,7 @@ static int __bpf_emit_cmpxchg32(struct bpf_test *self, void *arg,
 	/* Result unsuccessful */
 	insns[i++] = BPF_STX_MEM(BPF_W, R10, R1, -4);
 	insns[i++] = BPF_ATOMIC_OP(BPF_W, BPF_CMPXCHG, R10, R2, -4);
-	insns[i++] = BPF_ZEXT_REG(R0), /* Zext always inserted by verifier */
+	insns[i++] = BPF_ZEXT_REG(R0); /* Zext always inserted by verifier */
 	insns[i++] = BPF_LDX_MEM(BPF_W, R3, R10, -4);
 
 	insns[i++] = BPF_JMP32_REG(BPF_JEQ, R1, R3, 2);
@@ -1754,7 +1754,7 @@ static int __bpf_emit_cmpxchg32(struct bpf_test *self, void *arg,
 	/* Result successful */
 	i += __bpf_ld_imm64(&insns[i], R0, dst);
 	insns[i++] = BPF_ATOMIC_OP(BPF_W, BPF_CMPXCHG, R10, R2, -4);
-	insns[i++] = BPF_ZEXT_REG(R0), /* Zext always inserted by verifier */
+	insns[i++] = BPF_ZEXT_REG(R0); /* Zext always inserted by verifier */
 	insns[i++] = BPF_LDX_MEM(BPF_W, R3, R10, -4);
 
 	insns[i++] = BPF_JMP32_REG(BPF_JEQ, R2, R3, 2);
-- 
2.25.1


