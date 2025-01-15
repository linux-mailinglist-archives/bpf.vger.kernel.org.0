Return-Path: <bpf+bounces-48919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51677A11EC1
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 11:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF77A188EC9F
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 10:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EAF20C499;
	Wed, 15 Jan 2025 10:00:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE8723F266
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 10:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736935205; cv=none; b=XVLArT2VuqXoM9yNlzVxX1bjjbNRTDaeILuUZnNal/0sfspIfFTlgt9Vnp0CL8yVXNP3sCh/KhGLeWOJkzglKuo9kxkDwqf/DswqHiu3BW/aX8oLve9hIu5ZAZeAZ9YIeTeac1BoNde9yGTv/sUzyiodacmOonBMaTsTM++UuDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736935205; c=relaxed/simple;
	bh=xNzR1HSqgC/cfKTYEyFca9J16QcLMcrVis6n0zVHffY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vGYzKCAKK8YPLir8096dYrr+a2pe9aAyIaB0v+IC5y8pJzXBtKWcRO9CY0OAYC9kViXpwLA4ga44W7WKPgtJ/8ee3i9CpCOY0/3zz6Y9k2Eyf8krb0VOjt4INh+AZI/EO7zHM3yMzYbFWTTlLSslfJGz5wxEZHHb+q4TCslAmXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YY1gZ6HXlz4f3jt5
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 17:59:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 19DF51A111F
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 17:59:54 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP3 (Coremail) with SMTP id _Ch0CgAHWcMYh4dnLOEBBA--.46150S5;
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
Subject: [PATCH bpf v2 4/4] selftests/bpf: Add distilled BTF test about marking BTF_IS_EMBEDDED
Date: Wed, 15 Jan 2025 10:02:41 +0000
Message-Id: <20250115100241.4171581-4-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250115100241.4171581-1-pulehui@huaweicloud.com>
References: <20250115100241.4171581-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAHWcMYh4dnLOEBBA--.46150S5
X-Coremail-Antispam: 1UD129KBjvJXoWxGr47tr13trWxJFy8GryfZwb_yoWrXr4fpr
	yDXw4fAr4fX3Z7Grn3ZrWrWryF9w48X343Gr9Fga48AFZ3JFyjqFs29Fy5Gas2grW8Zr43
	Zrs2ga15C3yUJr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjfUO_MaUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

When redirecting the split BTF to the vmlinux base BTF, we need to mark
the distilled base struct/union members of split BTF structs/unions in
id_map with BTF_IS_EMBEDDED. This indicates that these types must match
both name and size later. So if a needed composite type, which is the
member of composite type in the split BTF, has a different size in the
base BTF we wish to relocate with, btf__relocate() should error out.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
v2: Add test about marking BTF_IS_EMBEDDED.

 .../selftests/bpf/prog_tests/btf_distill.c    | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_distill.c b/tools/testing/selftests/bpf/prog_tests/btf_distill.c
index b72b966df77b..fb67ae195a73 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_distill.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_distill.c
@@ -601,6 +601,76 @@ static void test_distilled_endianness(void)
 	btf__free(base);
 }
 
+/* If a needed composite type, which is the member of composite type
+ * in the split BTF, has a different size in the base BTF we wish to
+ * relocate with, btf__relocate() should error out.
+ */
+static void test_distilled_base_embedded_err(void)
+{
+	struct btf *btf1 = NULL, *btf2 = NULL, *btf3 = NULL, *btf4 = NULL, *btf5 = NULL;
+
+	btf1 = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf1, "empty_main_btf"))
+		return;
+
+	btf__add_int(btf1, "int", 4, BTF_INT_SIGNED);   /* [1] int */
+	btf__add_struct(btf1, "s1", 4);                 /* [2] struct s1 { */
+	btf__add_field(btf1, "f1", 1, 0, 0);            /*      int f1; */
+							/* } */
+	VALIDATE_RAW_BTF(
+		btf1,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] STRUCT 's1' size=4 vlen=1\n"
+		"\t'f1' type_id=1 bits_offset=0");
+
+	btf2 = btf__new_empty_split(btf1);
+	if (!ASSERT_OK_PTR(btf2, "empty_split_btf"))
+		goto cleanup;
+
+	btf__add_struct(btf2, "with_embedded", 8);      /* [3] struct with_embedded { */
+	btf__add_field(btf2, "e1", 2, 0, 0);		/*      struct s1 e1; */
+							/* } */
+
+	VALIDATE_RAW_BTF(
+		btf2,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] STRUCT 's1' size=4 vlen=1\n"
+		"\t'f1' type_id=1 bits_offset=0",
+		"[3] STRUCT 'with_embedded' size=8 vlen=1\n"
+		"\t'e1' type_id=2 bits_offset=0");
+
+	if (!ASSERT_EQ(0, btf__distill_base(btf2, &btf3, &btf4),
+		       "distilled_base") ||
+	    !ASSERT_OK_PTR(btf3, "distilled_base") ||
+	    !ASSERT_OK_PTR(btf4, "distilled_split") ||
+	    !ASSERT_EQ(2, btf__type_cnt(btf3), "distilled_base_type_cnt"))
+		goto cleanup;
+
+	VALIDATE_RAW_BTF(
+		btf4,
+		"[1] STRUCT 's1' size=4 vlen=0",
+		"[2] STRUCT 'with_embedded' size=8 vlen=1\n"
+		"\t'e1' type_id=1 bits_offset=0");
+
+	btf5 = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf5, "empty_reloc_btf"))
+		goto cleanup;
+
+	btf__add_int(btf5, "int", 4, BTF_INT_SIGNED);   /* [1] int */
+	/* struct with the same name but different size */
+	btf__add_struct(btf5, "s1", 8);                 /* [2] struct s1 { */
+	btf__add_field(btf5, "f1", 1, 0, 0);            /*      int f1; */
+							/* } */
+
+	ASSERT_EQ(btf__relocate(btf4, btf5), -EINVAL, "relocate_split");
+cleanup:
+	btf__free(btf5);
+	btf__free(btf4);
+	btf__free(btf3);
+	btf__free(btf2);
+	btf__free(btf1);
+}
+
 void test_btf_distill(void)
 {
 	if (test__start_subtest("distilled_base"))
@@ -613,6 +683,8 @@ void test_btf_distill(void)
 		test_distilled_base_multi_err();
 	if (test__start_subtest("distilled_base_multi_err2"))
 		test_distilled_base_multi_err2();
+	if (test__start_subtest("distilled_base_embedded_err"))
+		test_distilled_base_embedded_err();
 	if (test__start_subtest("distilled_base_vmlinux"))
 		test_distilled_base_vmlinux();
 	if (test__start_subtest("distilled_endianness"))
-- 
2.34.1


