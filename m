Return-Path: <bpf+bounces-19884-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FAC83279F
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 11:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 052FBB240F0
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 10:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B172C3CF65;
	Fri, 19 Jan 2024 10:24:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59D63CF4D
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 10:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705659879; cv=none; b=D+Z9xuJb7i9uPOYxvkuas07uJHodMXSoTnZIojNc7aikN39TWMC45+3TiGM6rBZqfctiM79VVULEFIlbWLDm/cXnZiegDOpKQb5qgxFldPnGaFRlbpEXuvdjgAJoC77PffJvxj56spgdcfYzUnlGwursSE+8EfQrJgMDqGsjvkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705659879; c=relaxed/simple;
	bh=stDQedbKdjVFV8FqfacxrEbr3uLqXi1WzEC19v5Vups=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ha4nIL5qgXn5pmMUsuWfKNLTA8iSQHf612474LWugKE4zU4Er+PszY8nt7t/W9E9lNIrBG6GEY0xd22NKXPfsw5Xlgml1k8D7BGMH6r/GihoXIIsmc1O2O4maLfA+sn931FfOnU+BNWIbZXpoE7mLvSGNqFgBAw0n/BWz7WQYUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TGbMJ5K86z4f3mHg
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 18:24:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E30941A0A7D
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 18:24:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBHfTapl+I07BQ--.50408S6;
	Fri, 19 Jan 2024 18:24:34 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Zi Shen Lim <zlim.lnx@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	houtao1@huawei.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: Enable kptr_xchg_inline test for arm64
Date: Fri, 19 Jan 2024 18:25:29 +0800
Message-Id: <20240119102529.99581-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20240119102529.99581-1-houtao@huaweicloud.com>
References: <20240119102529.99581-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXKBHfTapl+I07BQ--.50408S6
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw48WFW8uF4xAry8uF4fAFb_yoWfGwbE9r
	4jqr1DAFWkAF92qr18C3ZxWrWIkw4xWrZxJrWkWr12yw1aqw45JFWvk34DJayfurZxXFy2
	qF4DJayfAw42kjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfkYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r15M2
	8IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
	021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r
	4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUFa9-UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Now arm64 bpf jit has enable bpf_jit_supports_ptr_xchg(), so enable
the test for arm64 as well.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 tools/testing/selftests/bpf/prog_tests/kptr_xchg_inline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/kptr_xchg_inline.c b/tools/testing/selftests/bpf/prog_tests/kptr_xchg_inline.c
index 5a4bee1cf9707..15144943e88b7 100644
--- a/tools/testing/selftests/bpf/prog_tests/kptr_xchg_inline.c
+++ b/tools/testing/selftests/bpf/prog_tests/kptr_xchg_inline.c
@@ -13,7 +13,7 @@ void test_kptr_xchg_inline(void)
 	unsigned int cnt;
 	int err;
 
-#if !defined(__x86_64__)
+#if !(defined(__x86_64__) || defined(__aarch64__))
 	test__skip();
 	return;
 #endif
-- 
2.29.2


