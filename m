Return-Path: <bpf+bounces-32132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9061D907DF7
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 23:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C21F1F2427C
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 21:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0C513FD66;
	Thu, 13 Jun 2024 21:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="AFOmhv2G"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7594913D243
	for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 21:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718313535; cv=none; b=rEa9MN7UEkRLohTblVmVv/nyknaLkFG/JNnPTEagB9cdfx0yaHKJGvBSxWT7qfSPKNnL5TCOWi6IEbjnKij/sg/suX3gysHYSgpgdQIE6xFTfiPvTqMwAC+VhCOy2fumJg4f6R+e2YFAQ80/TLR0VIevw/dcZ+4sW02VBcFPeuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718313535; c=relaxed/simple;
	bh=2I/dlRzY/IW47jwH2VMQOLdzxKt68Gi572btkIcKBno=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hGbRrhUxlPv0b/lB/jEO/kEWNKaLj1H5Z23mDvZ5/M5LsLFvVRzXaJqy+v/Sfndo6VmyCvdeE7haSAGm0CLQi+sRE3307x0PIo7NadeYcu0lVtlHj9GNIJRQumAqvywlhlh19ajeYxZX2bb5fs9fwR9AV2qVwp3X7HFid4/gSyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=AFOmhv2G; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 45DJXbqG005405;
	Thu, 13 Jun 2024 14:18:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=s2048-2021-q4;
 bh=T+0SRLOw9ILFhpOYTYpYuVJy/G8X79tR/hhYFe1H8Ks=;
 b=AFOmhv2GzgRjLNG4CTgfuJgtokPoE+ta+/GQWPBIfSh3GhSHsvQjA2VoMu1h9KNfIKUd
 mepXwNSMW6v5m+86GRusxBJnwBcskcLGyqWbmqrpHkZizhCQHnKyTGE+Io8LWE5g6mZ9
 vuypXTQQAFaV4EuY8hf9WJJ37bqLEKvtaUUwSCpkB3cVsE82qG35GUVQjkt7yHxVbBhO
 giAwMrO5L0r7Wk9doy2FuuSjXL4rnvukgVu/Oo0sK7ZNJftwd4MGczCl8WxwjMyBp6K2
 EjBq3xzhRX3UZuCiAxutF6iiseqbnuhpr0eA3wLgxFKMvLDBbtp+UFA7h0iB8ufxHh7X 5Q== 
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3yqefqjctq-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 13 Jun 2024 14:18:38 -0700
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server id
 15.2.1544.11; Thu, 13 Jun 2024 21:18:36 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Martin KaFai Lau
	<martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman
	<eddyz87@gmail.com>
CC: <bpf@vger.kernel.org>, Vadim Fedorenko <vadfed@meta.com>,
        "Alexei
 Starovoitov" <ast@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        "Daniel
 Borkmann" <daniel@iogearbox.net>
Subject: [PATCH RESEND bpf-next v3 5/5] selftests: bpf: add testmod kfunc for nullable params
Date: Thu, 13 Jun 2024 14:18:17 -0700
Message-ID: <20240613211817.1551967-6-vadfed@meta.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240613211817.1551967-1-vadfed@meta.com>
References: <20240613211817.1551967-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: pBtoUxnqve0YxPEzl5fgVA5soaSsk86B
X-Proofpoint-ORIG-GUID: pBtoUxnqve0YxPEzl5fgVA5soaSsk86B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_13,2024-06-13_02,2024-05-17_01

Add special test to be sure that only __nullable BTF params can be
replaced by NULL. This patch adds fake kfuncs in bpf_testmod to
properly test different params.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  6 +++
 .../bpf/bpf_testmod/bpf_testmod_kfunc.h       |  1 +
 .../bpf/prog_tests/kfunc_param_nullable.c     | 11 +++++
 .../bpf/progs/test_kfunc_param_nullable.c     | 43 +++++++++++++++++++
 4 files changed, 61 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kfunc_param_nullable.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_kfunc_param_nullable.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 0a09732cde4b..49f9a311e49b 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -154,6 +154,11 @@ __bpf_kfunc void bpf_kfunc_common_test(void)
 {
 }
 
+__bpf_kfunc void bpf_kfunc_dynptr_test(struct bpf_dynptr *ptr,
+				       struct bpf_dynptr *ptr__nullable)
+{
+}
+
 struct bpf_testmod_btf_type_tag_1 {
 	int a;
 };
@@ -363,6 +368,7 @@ BTF_ID_FLAGS(func, bpf_iter_testmod_seq_new, KF_ITER_NEW)
 BTF_ID_FLAGS(func, bpf_iter_testmod_seq_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_testmod_seq_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_kfunc_common_test)
+BTF_ID_FLAGS(func, bpf_kfunc_dynptr_test)
 BTF_KFUNCS_END(bpf_testmod_common_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_testmod_common_kfunc_set = {
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
index b0d586a6751f..f9809517e7fa 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
@@ -134,4 +134,5 @@ int bpf_kfunc_call_sock_sendmsg(struct sendmsg_args *args) __ksym;
 int bpf_kfunc_call_kernel_getsockname(struct addr_args *args) __ksym;
 int bpf_kfunc_call_kernel_getpeername(struct addr_args *args) __ksym;
 
+void bpf_kfunc_dynptr_test(struct bpf_dynptr *ptr, struct bpf_dynptr *ptr__nullable) __ksym;
 #endif /* _BPF_TESTMOD_KFUNC_H */
diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_param_nullable.c b/tools/testing/selftests/bpf/prog_tests/kfunc_param_nullable.c
new file mode 100644
index 000000000000..c8f4dcaac7c7
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/kfunc_param_nullable.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Copyright (c) 2024 Meta Platforms, Inc */
+
+#include <test_progs.h>
+#include "test_kfunc_param_nullable.skel.h"
+
+void test_kfunc_param_nullable(void)
+{
+	RUN_TESTS(test_kfunc_param_nullable);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_kfunc_param_nullable.c b/tools/testing/selftests/bpf/progs/test_kfunc_param_nullable.c
new file mode 100644
index 000000000000..7c75e9b8f455
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_kfunc_param_nullable.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "bpf_kfuncs.h"
+#include "../bpf_testmod/bpf_testmod_kfunc.h"
+
+SEC("tc")
+int kfunc_dynptr_nullable_test1(struct __sk_buff *skb)
+{
+	struct bpf_dynptr data;
+
+	bpf_dynptr_from_skb(skb, 0, &data);
+	bpf_kfunc_dynptr_test(&data, NULL);
+
+	return 0;
+}
+
+SEC("tc")
+int kfunc_dynptr_nullable_test2(struct __sk_buff *skb)
+{
+	struct bpf_dynptr data;
+
+	bpf_dynptr_from_skb(skb, 0, &data);
+	bpf_kfunc_dynptr_test(&data, &data);
+
+	return 0;
+}
+
+SEC("tc")
+__failure __msg("expected pointer to stack or dynptr_ptr")
+int kfunc_dynptr_nullable_test3(struct __sk_buff *skb)
+{
+	struct bpf_dynptr data;
+
+	bpf_dynptr_from_skb(skb, 0, &data);
+	bpf_kfunc_dynptr_test(NULL, &data);
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0


