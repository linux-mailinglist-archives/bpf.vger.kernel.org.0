Return-Path: <bpf+bounces-54793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CC4A72B60
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 09:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E01B3B8626
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 08:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF57D205AA6;
	Thu, 27 Mar 2025 08:23:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E95420550C
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743063783; cv=none; b=UT2Ia3Ja6eVFidAQjpBaZ4LipAX09hwWcxGh34kpZxLCZXVbqim+VmtCp+8oJ0y1zu+UHGH2M7bEQ5d7ZFiasdCE/6lVtI5EPL50oNdeAnmLuUIJmhlkMTQUBvYo8L2SgcMBprAAdyUOHx4al6kcFaydU5aBDupbRBlnnuEAIr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743063783; c=relaxed/simple;
	bh=3Tq+ed5Zbr9kviCfTKcg4d6tfz28BG8aSvWjUR294ns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jFSvIwGP87uUzMxtwNpjsodSolhJ4TV/9KFoGIHESUjTou+L6EX83Bxu3qhBdJUoQThSNUqkws+u+QMvvbJc/TfSmS0f2KdRhGh+2Ze0ACElI9MZ6OOyKwI7q5lKQEM893yDj8BwBDEbwcATghbAgt8GZACaNMZ00YmbLGz6BjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZNc8p4GtPz4f3lfp
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 16:22:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 11FAE1A1195
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 16:22:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgAXe1_XCuVnluzSHg--.7420S18;
	Thu, 27 Mar 2025 16:22:58 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	houtao1@huawei.com
Subject: [PATCH bpf-next v3 14/16] selftests/bpf: Add bpf_dynptr_user_init() helper
Date: Thu, 27 Mar 2025 16:34:53 +0800
Message-Id: <20250327083455.848708-15-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20250327083455.848708-1-houtao@huaweicloud.com>
References: <20250327083455.848708-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXe1_XCuVnluzSHg--.7420S18
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw1kuw15WFykGr18Zry3twb_yoWkWFXE9F
	W0gF93Jr4DuF17Kr1jkrn8urZ5Cw45Gr48XrWDXry3Gr18Xa15XF4kCrs5Zas7W398Gay3
	tF4kZry3Jr4UKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbgxYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s
	0DM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
	AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07UZTmfUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Add bpf_dynptr_user_init() to initialize a bpf_dynptr object. It will be
used by test_progs and bench. User can dereference the {data|size}
fields directly to get the address and length of the dynptr object.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 tools/testing/selftests/bpf/testing_helpers.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/bpf/testing_helpers.h b/tools/testing/selftests/bpf/testing_helpers.h
index 46d7f7089f636..d93ee5bfa7f6f 100644
--- a/tools/testing/selftests/bpf/testing_helpers.h
+++ b/tools/testing/selftests/bpf/testing_helpers.h
@@ -58,4 +58,13 @@ int get_xlated_program(int fd_prog, struct bpf_insn **buf, __u32 *cnt);
 int testing_prog_flags(void);
 bool is_jit_enabled(void);
 
+/* sys_bpf() will check the validity of data and size */
+static inline void bpf_dynptr_user_init(void *data, __u32 size,
+					struct bpf_dynptr *dynptr)
+{
+	dynptr->data = data;
+	dynptr->size = size;
+	dynptr->reserved = 0;
+}
+
 #endif /* __TESTING_HELPERS_H */
-- 
2.29.2


