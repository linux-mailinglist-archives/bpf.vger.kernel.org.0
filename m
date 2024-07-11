Return-Path: <bpf+bounces-34572-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD0B92EB1D
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 16:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 285DD284B4C
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 14:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B87616B38F;
	Thu, 11 Jul 2024 14:58:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF90512C549
	for <bpf@vger.kernel.org>; Thu, 11 Jul 2024 14:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720709927; cv=none; b=tRcQTR/8y1koWGHKHhQvkpMmP76mwevcVe1j19LLG0bwQH4xYWSfRuu9vWQrRTtPJgm2O9yhpxHgUznKVIwJF7biH0s4OEcvknVB1fJSAK9JhBHO/2MI+gdYH9EOiXMmuOXiYlOEgbId25cSVXCEdNDRhGLCVbeU/O81zBxqq50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720709927; c=relaxed/simple;
	bh=6YvrLoN3/UiWEa0lXKmVpDEzVVD8//qqgZykc27K61Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=USSnGEV8/0SOfldh8dp6urcla/+Eqdlk6ftj8ncHLQoVgiBMRpCOf7kknqL8kY9BXeb/Yxc9tbVxnR7wQQaRw5/IA0npeb/8ezhhCXc8GzSji4m9+4FUZ6wkwd2ZukcRp6n2Ot6XDsFX2eBdce8/zY5CtyiqCxaJpZgeQD7aKHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WKdCB4Fg2z4f3jrs
	for <bpf@vger.kernel.org>; Thu, 11 Jul 2024 22:58:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 4B0231A0185
	for <bpf@vger.kernel.org>; Thu, 11 Jul 2024 22:58:42 +0800 (CST)
Received: from huawei.com (unknown [7.197.88.80])
	by APP2 (Coremail) with SMTP id Syh0CgBXC4EQ849m425BBw--.32411S4;
	Thu, 11 Jul 2024 22:58:42 +0800 (CST)
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
Subject: [PATCH bpf v4 2/2] selftests/bpf: Test for null-pointer-deref bugfix in resolve_prog_type()
Date: Thu, 11 Jul 2024 22:58:19 +0800
Message-Id: <20240711145819.254178-3-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240711145819.254178-1-wutengda@huaweicloud.com>
References: <20240711145819.254178-1-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBXC4EQ849m425BBw--.32411S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr43tFWUXr4fWr43WF17Wrg_yoW8GrWxp3
	WF9as09F4kZ3y3GF47CrWI9FW5WF4kX347Gr17u345ZFW7ZryxJr4xKFWYkrnxW3yrJw4S
	v34Skw1Duw4kXaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFa9-UUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

This test verifies that resolve_prog_type() works as expected when
`attach_prog_fd` is not passed in.

`prog->aux->dst_prog` in resolve_prog_type() is assigned by
`attach_prog_fd`, and would be NULL if `attach_prog_fd` is not provided.
Loading EXT prog with bpf_dynptr_from_skb() kfunc call in this way will 
lead to null-pointer-deref.

Verify that the null-pointer-deref bug in resolve_prog_type() is fixed.

Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 tools/testing/selftests/bpf/verifier/calls.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index ab25a81fd3a1..f9d6023042d6 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -275,6 +275,19 @@
 	.result_unpriv = REJECT,
 	.result = ACCEPT,
 },
+{
+	"calls: invalid kfunc call: must provide (attach_prog_fd, btf_id) pair when freplace",
+	.insns = {
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_EXT,
+	.result = REJECT,
+	.errstr = "Tracing programs must provide btf_id",
+	.fixup_kfunc_btf_id = {
+		{ "bpf_dynptr_from_skb", 0 },
+	},
+},
 {
 	"calls: basic sanity",
 	.insns = {
-- 
2.34.1


