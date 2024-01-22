Return-Path: <bpf+bounces-19996-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7C2835C21
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 08:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32FD02886FA
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 07:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD651BC49;
	Mon, 22 Jan 2024 07:57:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2386A18C2A;
	Mon, 22 Jan 2024 07:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705910234; cv=none; b=TEGCY9zNccH79PgosIum7FJVk0SAbvL/aVJjlYUd0qI1518bCKeImTNqX+dgHZy3pdH033rLIAWHa9Ybdfw/GgNdulftnbmza1/E0i63/4/xzdh+4Nm85iB8k6VPe2tbgFqrWeUwQxdCJ1RT+uxAxOAU4f4VfR/y7gVBE42fTLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705910234; c=relaxed/simple;
	bh=5xOUQzMI3cF3quGn7LLDIkCU6YeMNa9MKn1b5kJuOQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JYnd7PajzCKkF27btJD3v07I9i/HQdOGQtLOD6ym+RaXBqN/LFP2fTzadtlMHTrDoQF5G4C2sfvXyyc+zCYLkTISyBVq/FUicWitu4j1HK5zzf2cm6TJykB611jVWI6gTN4wLWLpWYtXR6eE6D85GRcZ8avwqFM2rcD9G/CHOAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxTOnQH65lkW0DAA--.3984S3;
	Mon, 22 Jan 2024 15:57:04 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxf8_NH65lKSIRAA--.13989S4;
	Mon, 22 Jan 2024 15:57:03 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Hou Tao <houtao@huaweicloud.com>,
	Song Liu <song@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v6 2/3] selftests/bpf: Copy insn_is_pseudo_func() into testing_helpers
Date: Mon, 22 Jan 2024 15:56:59 +0800
Message-ID: <20240122075700.7120-3-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240122075700.7120-1-yangtiezhu@loongson.cn>
References: <20240122075700.7120-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Cxf8_NH65lKSIRAA--.13989S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZF4kGF1kuryfCF45Gr1rAFc_yoW8Xr4DpF
	WrGw40kr1jqFyxX3WUJa1qgFsagFWkZFW8Gryjq34UZr4DGF93XrWxKF40gasI939YvF1f
	Za1Iya4Y9F1xtacCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j2MKZUUUUU=

insn_is_pseudo_func() will be used in test_verifier, the original idea is
to move it from libbpf.c to libbpf_internal.h and then include the header
to reuse this function, this just adds more internal code of libbpf used
by selftests. While we have allowed it in some cases to avoid duplication
of more complex logic, it is not justified in this case.

Since insn_is_pseudo_func() and its helper is_ldimm64_insn() are trivial
enough, just copy into testing_helpers.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/testing/selftests/bpf/testing_helpers.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/bpf/testing_helpers.h b/tools/testing/selftests/bpf/testing_helpers.h
index d14de81727e6..cd77dce1b1da 100644
--- a/tools/testing/selftests/bpf/testing_helpers.h
+++ b/tools/testing/selftests/bpf/testing_helpers.h
@@ -54,4 +54,14 @@ int get_xlated_program(int fd_prog, struct bpf_insn **buf, __u32 *cnt);
 int testing_prog_flags(void);
 bool is_jit_enabled(void);
 
+static inline bool is_ldimm64_insn(struct bpf_insn *insn)
+{
+	return insn->code == (BPF_LD | BPF_IMM | BPF_DW);
+}
+
+static inline bool insn_is_pseudo_func(struct bpf_insn *insn)
+{
+	return is_ldimm64_insn(insn) && insn->src_reg == BPF_PSEUDO_FUNC;
+}
+
 #endif /* __TESTING_HELPERS_H */
-- 
2.42.0


