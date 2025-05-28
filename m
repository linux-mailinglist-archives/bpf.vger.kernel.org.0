Return-Path: <bpf+bounces-59162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 145BAAC667B
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 11:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4350A1891AEE
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 09:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5B327A900;
	Wed, 28 May 2025 09:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C1AvsYpK"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C630627A12C;
	Wed, 28 May 2025 09:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748426316; cv=none; b=Hdku0InySd4uDvp+ua5aHhZdVIXb4cQ1uLn7MpW4HdMLH4YZshkEFmWmd/9vbBWt4pAMpOg62fww0MorFTtceOGACAuOYgsreBK1/G5CYzrFh9YrMyoCjMTOX//N5c6ZshMhMZB8oF1gzCX2gqxZfwGz/N0Q/WoveCondnobI44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748426316; c=relaxed/simple;
	bh=KMpoRaUXPD52a5uacGxKWBNpsYx4wH0JNE4jtN/sKyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nCQgxm9PEEaODsk7THtx/u59tx8cRqrAq9KD24Uy/cWaNDVYe421Z04clQnPCcnkwwcDH1YGiFJo3h1jXN4spe2Ed3wAjz4jf+TV46f5I/qkO/wKhE6yWjEBTzSUsgnhzmnEf+ShIXU8+QHcdNQ0W9GsYmRWig+rWVqEIvA1cAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C1AvsYpK; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S1iWPT005610;
	Wed, 28 May 2025 09:58:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=CVoxl
	4D4xxSQUhcXbLBR5vKaB421HHmUJCPqUGB4CZU=; b=C1AvsYpKztr9QWP2VqUVr
	odadgYs1ZYGxOGPK+3yZrPA3MD6HAcKrfc+ztdnUprEZgT8HxL2/B2V9qwmg/Cdx
	qwmvGzG/agvX8oa7LAR7I/NKqBzTzsPXYxKxjk3rbnIQO07HjETWLwT9DKZOHBaz
	rymdTrImU47LLZGyGTYdrv7YhYSg6DMRZs0t5qynX0gInk48zQbRp4qC6B1H+c1e
	fcsXbahUjk9stD4DpqrzK0CxOt+7Xv2q/Axf2uTMTm+G20t0jo9x+H3Y3i7vU3AG
	8VmixELFZziR17DqLb4HF0m7dwjndjfjFuDE6H5Fa1GXUzbwc6YpDxYN5uVyNW79
	w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v0ykwhgt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 09:58:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54S7W6j0024392;
	Wed, 28 May 2025 09:58:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jaev7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 09:58:06 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54S9qwW0007194;
	Wed, 28 May 2025 09:58:05 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-51-118.vpn.oracle.com [10.154.51.118])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 46u4jaeuw6-8;
	Wed, 28 May 2025 09:58:05 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, masahiroy@kernel.org, qmo@kernel.org,
        ihor.solodrai@linux.dev, dwarves@vger.kernel.org, bpf@vger.kernel.org,
        ttreyer@meta.com, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v5 bpf-next 7/9] selftests/bpf: test kind encoding/decoding
Date: Wed, 28 May 2025 10:57:41 +0100
Message-ID: <20250528095743.791722-8-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250528095743.791722-1-alan.maguire@oracle.com>
References: <20250528095743.791722-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_05,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505280086
X-Proofpoint-GUID: es94U__PKlGAxmZwWN83SDDOFAaN4Kdb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDA4NyBTYWx0ZWRfX6Wn7//u56dV9 VnLUJEY9lY+A9u/SjLhG7w73cGLA/Gh2PYJnnSvaCAfpyOR0HJcxnIA2M6bdbLcOkoHUXLH3De7 BAc7dW15HnVt3kyXOEYdGS5fF2lN6ahEsMhYrAgod6q1uQK7KMz5zM61OuU3E9Uvt9+I71uIX/x
 YDTUO7rNegSt+9zN4EpR27kOQS+hPiBXQ4F4C+LsCCxMw2+icFduETJwpwixMuMrdacXYd+09zT TBFariMR7lM/OoFBYbE0ckQv6r4Z2zRT6n0akbL8NbrOp1dRSR00V44oNuDWLbdORHsOoxj368b rvBpLEukAyEknd2metawjr/IPA6whKhIKYzYRXiJmKa9Ii2yq6trKk7M09QdgHt5dFkguY0f4vn
 NenWg3We7P4sNHkUiLohhwfX8OPGAtS/3Iy2otTOh9GmCqdE20WQia1RFwQZ5BNLtyXEMwJV
X-Proofpoint-ORIG-GUID: es94U__PKlGAxmZwWN83SDDOFAaN4Kdb
X-Authority-Analysis: v=2.4 cv=N7MpF39B c=1 sm=1 tr=0 ts=6836de2f b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=zm-fL-ZIduLWe7Znn4kA:9 cc=ntf awl=host:13206

verify btf__new_empty_opts() adds kind layouts for all kinds supported,
and after adding kind-related types for an unknown kind, ensure that
parsing uses this info when that kind is encountered rather than
giving up.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../selftests/bpf/prog_tests/btf_kind.c       | 176 ++++++++++++++++++
 1 file changed, 176 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_kind.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_kind.c b/tools/testing/selftests/bpf/prog_tests/btf_kind.c
new file mode 100644
index 000000000000..735ea0b588a5
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_kind.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025, Oracle and/or its affiliates. */
+
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include <bpf/libbpf.h>
+
+/* verify kind encoding exists for each kind */
+static void test_btf_kind_encoding(void)
+{
+	LIBBPF_OPTS(btf_new_opts, opts);
+	const struct btf_header *hdr;
+	const void *raw_btf;
+	struct btf *btf;
+	__u32 raw_size;
+
+	opts.add_kind_layout = true;
+	btf = btf__new_empty_opts(&opts);
+	if (!ASSERT_OK_PTR(btf, "btf_new"))
+		return;
+
+	raw_btf = btf__raw_data(btf, &raw_size);
+	if (!ASSERT_OK_PTR(raw_btf, "btf__raw_data"))
+		return;
+
+	hdr = raw_btf;
+
+	ASSERT_EQ(hdr->kind_layout_off % 4, 0, "kind_layout aligned");
+	ASSERT_EQ(hdr->kind_layout_len, sizeof(struct btf_kind_layout) * NR_BTF_KINDS,
+		  "kind_layout_len");
+	btf__free(btf);
+}
+
+static void write_raw_btf(const char *btf_path, void *raw_btf, size_t raw_size)
+{
+	int fd = open(btf_path, O_WRONLY | O_CREAT);
+
+	write(fd, raw_btf, raw_size);
+	close(fd);
+}
+
+/* fabricate an unrecognized kind at BTF_KIND_MAX + 1, and after adding
+ * the appropriate struct/typedefs to the BTF such that it recognizes
+ * this kind, ensure that parsing of BTF containing the unrecognized kind
+ * can succeed.
+ */
+void test_btf_kind_decoding(void)
+{
+	__s32 int_id, unrec_id, id, id2;
+	LIBBPF_OPTS(btf_new_opts, opts);
+	struct btf *btf, *new_btf;
+	struct btf_kind_layout *k;
+	struct btf_header *hdr;
+	const void *raw_btf;
+	struct btf_type *t;
+	char btf_path[64];
+	void *new_raw_btf;
+	__u32 raw_size;
+
+	opts.add_kind_layout = true;
+	btf = btf__new_empty_opts(&opts);
+	if (!ASSERT_OK_PTR(btf, "btf_new"))
+		return;
+
+	int_id = btf__add_int(btf, "test_char", 1, BTF_INT_CHAR);
+	if (!ASSERT_GT(int_id, 0, "add_int_id"))
+		return;
+
+	/* now create our type with unrecognized kind by adding a typedef kind
+	 * we will overwrite it with our unrecognized kind value.
+	 */
+	unrec_id = btf__add_typedef(btf, "unrec_kind", int_id);
+	if (!ASSERT_GT(unrec_id, 0, "add_unrec_id"))
+		return;
+
+	/* add an id after it that we will look up to verify we can parse
+	 * beyond unrecognized kinds.
+	 */
+	id = btf__add_typedef(btf, "test_lookup", int_id);
+	if (!ASSERT_GT(id, 0, "add_test_lookup_id"))
+		return;
+	id2 = btf__add_typedef(btf, "test_lookup2", int_id);
+	if (!ASSERT_GT(id2, 0, "add_test_lookup_id2"))
+		return;
+
+	raw_btf = (void *)btf__raw_data(btf, &raw_size);
+	if (!ASSERT_OK_PTR(raw_btf, "btf__raw_data"))
+		return;
+
+	new_raw_btf = calloc(1, raw_size + sizeof(*k));
+	memcpy(new_raw_btf, raw_btf, raw_size);
+
+	/* add new layout description */
+	hdr = new_raw_btf;
+	hdr->kind_layout_len += sizeof(*k);
+	k = new_raw_btf + hdr->hdr_len + hdr->kind_layout_off;
+	k[NR_BTF_KINDS].info_sz = 0;
+	k[NR_BTF_KINDS].elem_sz = 0;
+
+	/* now modify our typedef added above to be an unrecognized kind. */
+	t = (void *)hdr + hdr->hdr_len + hdr->type_off + sizeof(struct btf_type) +
+		sizeof(__u32);
+	t->info = (NR_BTF_KINDS << 24);
+
+	/* now write our BTF to a raw file, ready for parsing. */
+	snprintf(btf_path, sizeof(btf_path), "/tmp/btf_kind.%d", getpid());
+
+	write_raw_btf(btf_path, new_raw_btf, raw_size + sizeof(*k));
+
+	/* verify parsing succeeds, and that we can read type info past
+	 * the unrecognized kind.
+	 */
+	new_btf = btf__parse_raw(btf_path);
+	if (ASSERT_OK_PTR(new_btf, "btf__parse_raw")) {
+		ASSERT_EQ(btf__find_by_name_kind(new_btf, "test_lookup",
+						 BTF_KIND_TYPEDEF), id,
+			  "verify_id_lookup");
+		ASSERT_EQ(btf__find_by_name_kind(new_btf, "test_lookup2",
+						 BTF_KIND_TYPEDEF), id2,
+			  "verify_id2_lookup");
+	}
+	btf__free(new_btf);
+
+	/* next, change info_sz to equal sizeof(struct btf_type); this means the
+	 * "test_lookup" kind will be reinterpreted as a singular info element
+	 * following the unrecognized kind.
+	 */
+	k[NR_BTF_KINDS].info_sz = sizeof(struct btf_type);
+	write_raw_btf(btf_path, new_raw_btf, raw_size + sizeof(*k));
+
+	new_btf = btf__parse_raw(btf_path);
+	if (ASSERT_OK_PTR(new_btf, "btf__parse_raw")) {
+		ASSERT_EQ(btf__find_by_name_kind(new_btf, "test_lookup",
+						 BTF_KIND_TYPEDEF), -ENOENT,
+			  "verify_id_not_found");
+		/* id of "test_lookup2" will be id2 -1 as we have removed one type */
+		ASSERT_EQ(btf__find_by_name_kind(new_btf, "test_lookup2",
+						 BTF_KIND_TYPEDEF), id2 - 1,
+			  "verify_id_lookup2");
+
+	}
+	btf__free(new_btf);
+
+	/* next, change elem_sz to equal sizeof(struct btf_type)/2 and set
+	 * vlen associated with unrecognized type to 2; this allows us to verify
+	 * vlen-specified BTF can still be parsed.
+	 */
+	k[NR_BTF_KINDS].info_sz = 0;
+	k[NR_BTF_KINDS].elem_sz = sizeof(struct btf_type)/2;
+	t->info |= 2;
+	write_raw_btf(btf_path, new_raw_btf, raw_size + sizeof(*k));
+
+	new_btf = btf__parse_raw(btf_path);
+	if (ASSERT_OK_PTR(new_btf, "btf__parse_raw")) {
+		ASSERT_EQ(btf__find_by_name_kind(new_btf, "test_lookup",
+						 BTF_KIND_TYPEDEF), -ENOENT,
+			  "verify_id_not_found");
+		/* id of "test_lookup2" will be id2 -1 as we have removed one type */
+		ASSERT_EQ(btf__find_by_name_kind(new_btf, "test_lookup2",
+						 BTF_KIND_TYPEDEF), id2 - 1,
+			  "verify_id_lookup2");
+
+	}
+	btf__free(new_btf);
+	free(new_raw_btf);
+	unlink(btf_path);
+	btf__free(btf);
+}
+
+void test_btf_kind(void)
+{
+	if (test__start_subtest("btf_kind_encoding"))
+		test_btf_kind_encoding();
+	if (test__start_subtest("btf_kind_decoding"))
+		test_btf_kind_decoding();
+}
-- 
2.39.3


