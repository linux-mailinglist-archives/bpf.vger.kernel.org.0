Return-Path: <bpf+bounces-48917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A56B3A11EBF
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 11:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D92F3B03A3
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 10:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EB7248182;
	Wed, 15 Jan 2025 10:00:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDF523F26F
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 10:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736935204; cv=none; b=Dr9dTm6GzUlD3dEcCFjtVB0g3gXGYfHQ68q1in7bL3wJXRF/iKu7N/rzV+Oe/HTzrjx0CVDoPv/wTwyZA7ROFGiUvz1qlPvPa9mBD5J0bOpp9BkCzCQ6CwxDByHc3ZkAzD97Y16iImZta8N3IOqBUlunX8U6ciWPyAcbO1uxITs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736935204; c=relaxed/simple;
	bh=VBwtW4jlSdS8/uOjiy8I6xnOiaNeu0ecqA+PHNu+7b4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fK/A5Q+Md37o8uUkUf9OtP+vo8j6zwAdVcyHvq3qEcR8q63cEJcCdfkfM2cP5DV/bjAEAssBxsqguRXAodTZxDYTKeeFQMp0UFQthG/vI9cP8b/ABmk+/HCs8OlGXwobxup/w2Y290uUWNUKSfCNe1ekUS5yVgRmj2fVcdL+RAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YY1gZ4RN1z4f3jss
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 17:59:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id CD1491A0CC2
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 17:59:53 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP3 (Coremail) with SMTP id _Ch0CgAHWcMYh4dnLOEBBA--.46150S2;
	Wed, 15 Jan 2025 17:59:53 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf v2 1/4] selftests/bpf: Fix btf leak on new btf alloc failure in btf_distill test
Date: Wed, 15 Jan 2025 10:02:38 +0000
Message-Id: <20250115100241.4171581-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAHWcMYh4dnLOEBBA--.46150S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr1rAw4xZrWfGr1DGrWkCrg_yoW8Xr48pa
	y0q34akFySg3W7tay8ZFWIgFW8WF1kX3yakF17Kwn5ArWrJFykXrs7Kay5G3ZagrWFvr45
	Zw1xKFs5Aw48Cw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

Fix btf leak on new btf alloc failure in btf_distill test.

Fixes: affdeb50616b ("selftests/bpf: Extend distilled BTF tests to cover BTF relocation")
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
v2: newly discovered bugfix.

 tools/testing/selftests/bpf/prog_tests/btf_distill.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_distill.c b/tools/testing/selftests/bpf/prog_tests/btf_distill.c
index ca84726d5ac1..b72b966df77b 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_distill.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_distill.c
@@ -385,7 +385,7 @@ static void test_distilled_base_missing_err(void)
 		"[2] INT 'int' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED");
 	btf5 = btf__new_empty();
 	if (!ASSERT_OK_PTR(btf5, "empty_reloc_btf"))
-		return;
+		goto cleanup;
 	btf__add_int(btf5, "int", 4, BTF_INT_SIGNED);   /* [1] int */
 	VALIDATE_RAW_BTF(
 		btf5,
@@ -478,7 +478,7 @@ static void test_distilled_base_multi_err2(void)
 		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED");
 	btf5 = btf__new_empty();
 	if (!ASSERT_OK_PTR(btf5, "empty_reloc_btf"))
-		return;
+		goto cleanup;
 	btf__add_int(btf5, "int", 4, BTF_INT_SIGNED);   /* [1] int */
 	btf__add_int(btf5, "int", 4, BTF_INT_SIGNED);   /* [2] int */
 	VALIDATE_RAW_BTF(
-- 
2.34.1


