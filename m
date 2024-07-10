Return-Path: <bpf+bounces-34374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C7592CE2F
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 11:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A9542875B3
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 09:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7B118FA1C;
	Wed, 10 Jul 2024 09:29:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6605218FA06
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720603770; cv=none; b=SBbeuNxLXSMtBcCmfqubFrHvlMVnN/IAgaKi3t3rSqKhdduGL09hzVS1LOqfRUZeJQzB5tHVEpZ3P2Gx21+TlCbL4H66dLtZh+VcFqaAu2euZ+8fy4b3Xch1stBuB9mj//F+Q2VEVMYTq83Qja0up51YUw+ykV6q4Ggo9T0RFI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720603770; c=relaxed/simple;
	bh=TrXDPiARWapreMQMIL736vR4V5YfQRXO0yWJ8MJwzTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q5pJd56eUXihjwOFQbj7skuG6lYU4wmkO/oCwZ7no5hsOyuWTuwUAv3G7EnNzQrh06EdMdMD7A9AuJ1ovMBir/2eqVmjcNxegBV0AtL2irsyL3H5Y9UJAFuthwbbKywhvTPLCKhf7APn9Z6nJeneU6nWP+A+4WrxwVHYvWHaOpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WJsxh5935z4f3jMB
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 17:29:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 911971A0181
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 17:29:25 +0800 (CST)
Received: from huawei.com (unknown [7.197.88.80])
	by APP3 (Coremail) with SMTP id _Ch0CgCXpF5jVI5mTxF_Bg--.1219S5;
	Wed, 10 Jul 2024 17:29:25 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	hffilwlqm@gmail.com
Subject: [PATCH bpf v3 3/3] selftests/bpf: Test for null-pointer-deref bugfix in resolve_prog_type()
Date: Wed, 10 Jul 2024 17:29:04 +0800
Message-Id: <20240710092904.3438141-4-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710092904.3438141-1-wutengda@huaweicloud.com>
References: <20240710092904.3438141-1-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCXpF5jVI5mTxF_Bg--.1219S5
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr4xArW3Zr1xuryUtFWUArb_yoW8JFWDp3
	WruasI9r4kZa4fWF17Cr42vFW5WF4kX34UGr12v3s8ZFWUXrWxJrW8K3yYyrn0g3yrJw4S
	vw1Skw1kuw1kX3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1c4S7UUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

This test verifies that resolve_prog_type() works as expected when
attach_prog_fd is not passed in.

prog->aux->dst_prog in resolve_prog_type() is aligned by attach_prog_fd,
and would be null if attach_prog_fd is not given. Loading EXT prog with
bpf_dynptr_from_skb kfunc call in this way will meet null-pointer-deref.

Verify that the null-pointer-deref bug in resolve_prog_type() is fixed.

Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 tools/testing/selftests/bpf/verifier/calls.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index ab25a81fd3a1..786201434d06 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -275,6 +275,19 @@
 	.result_unpriv = REJECT,
 	.result = ACCEPT,
 },
+{
+	"calls: invalid kfunc call: attach_prog_fd must be non-empty when freplace",
+	.insns = {
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_EXT,
+	.result = REJECT,
+	.errstr = "",
+	.fixup_kfunc_btf_id = {
+		{ "bpf_dynptr_from_skb", 0 },
+	},
+},
 {
 	"calls: basic sanity",
 	.insns = {
-- 
2.34.1


