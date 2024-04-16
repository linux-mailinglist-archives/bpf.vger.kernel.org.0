Return-Path: <bpf+bounces-26910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 594928A6424
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 08:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F1111F2115C
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 06:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F1E6DCE3;
	Tue, 16 Apr 2024 06:39:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046476D1AE
	for <bpf@vger.kernel.org>; Tue, 16 Apr 2024 06:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713249561; cv=none; b=UmzSQWpQ32mZzDQMCtYVT1R3uQqOKhqD6hcpp8FZRse6Oy0jvcUmV7xwZsycQjO6t26S7yBz5EW/AUx22HGzhs4zTR7AY0tiBBbnftCRtp+wsGCrIg4uNwH5NfIiwxI56fuFyRE506DinakMrn+dqv+MJ8Wfyzuw+aAkyHyQ9XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713249561; c=relaxed/simple;
	bh=AomlvGvlRsETiYaq2LU0GwcGirGgOgaiQIiZP91sblU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W/HnJRHYUnlJMTT9ix+QmhwfV5TyL+iYsDOybFa6bZWHrTP7A143dt7nHkmszowmGkLwrCbsWMSPtGJ6pj6wFD8wEPy1ydsm4fwSZwQ4spIhHbLkvJLZdO/WJ6SvGNNonaALWaLwAo/A3S0DsLeUXpKHrnJBaKWr9B87BvSwFz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VJZBd5xN3z4f3nTX
	for <bpf@vger.kernel.org>; Tue, 16 Apr 2024 14:39:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id AF7801A016E
	for <bpf@vger.kernel.org>; Tue, 16 Apr 2024 14:39:14 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP1 (Coremail) with SMTP id cCh0CgDnAQsRHR5mMjd4KA--.14140S4;
	Tue, 16 Apr 2024 14:39:14 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Cc: Ivan Babrou <ivan@cloudflare.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>
Subject: [PATCH bpf-next 2/2] riscv, bpf: Fix incorrect runtime stats
Date: Tue, 16 Apr 2024 14:42:08 +0800
Message-Id: <20240416064208.2919073-3-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240416064208.2919073-1-xukuohai@huaweicloud.com>
References: <20240416064208.2919073-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDnAQsRHR5mMjd4KA--.14140S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyfJFWxuryDWr1kXw4kXrb_yoW8JFyrpa
	1UG39xAFWv9F4DXws7JF17Xry5tF4qqr13CF42yrWrAan0qrWUuwn3Kws0yry5CryrZr18
	Xr1j9Fna93WDZ37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvGb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjxU2GYLDUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

When __bpf_prog_enter() returns zero, the s1 register is not set to zero,
resulting in incorrect runtime stats. Fix it by setting s1 immediately upon
the return of __bpf_prog_enter().

Fixes: 49b5e77ae3e2 ("riscv, bpf: Add bpf trampoline support for RV64")
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 arch/riscv/net/bpf_jit_comp64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 15e482f2c657..e713704be837 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -730,6 +730,9 @@ static int invoke_bpf_prog(struct bpf_tramp_link *l, int args_off, int retval_of
 	if (ret)
 		return ret;
 
+	/* store prog start time */
+	emit_mv(RV_REG_S1, RV_REG_A0, ctx);
+
 	/* if (__bpf_prog_enter(prog) == 0)
 	 *	goto skip_exec_of_prog;
 	 */
@@ -737,9 +740,6 @@ static int invoke_bpf_prog(struct bpf_tramp_link *l, int args_off, int retval_of
 	/* nop reserved for conditional jump */
 	emit(rv_nop(), ctx);
 
-	/* store prog start time */
-	emit_mv(RV_REG_S1, RV_REG_A0, ctx);
-
 	/* arg1: &args_off */
 	emit_addi(RV_REG_A0, RV_REG_FP, -args_off, ctx);
 	if (!p->jited)
-- 
2.40.1


