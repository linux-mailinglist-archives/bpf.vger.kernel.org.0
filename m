Return-Path: <bpf+bounces-76428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE707CB3F7D
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 21:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1BC6D3011EF9
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 20:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97BF32C926;
	Wed, 10 Dec 2025 20:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L+rBG2n7"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7793301704;
	Wed, 10 Dec 2025 20:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765398814; cv=none; b=BqvVAuGo8OGOArGxlDNy2LfWmS5ZK+T100xA8uMWJQPLGe2KQ7kxNZkbAOeNtInmH/N9WVFZ+pVYqTsOj7wIYosAg8ao3NSN5YqES9fUGFNq6b8uoxrFppp4QOxLiMqZ038GS0nwfIn22d9EpRHw8nwISVUXXvOIcU8ilQYlm/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765398814; c=relaxed/simple;
	bh=fANpw9+u24LjtciyTtySAvIo2t+zfPF/zpjHOXuT29M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=evzDuYFTYL4PMBoxBgZ2IoJbeau7MgXjmY11t2XUIJFJam0PNnopjno+4tzOT611fd7mZpywdsSJd5hmt7EGJ5ogJjmYj1PaTe5oo/SXsBN3CwTXA8+BZirXhKD5G90lyJO/N8MgxGDVf1BS0qmeKJszw33xwzJyDOqoWjOoyrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L+rBG2n7; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BAIYNDm3730102;
	Wed, 10 Dec 2025 20:33:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=GkYxY
	gQ0nV7R9tXZbFq45LAMFzYP8KFJjx0mdDZOrYk=; b=L+rBG2n7T5jiUjJPzEPsS
	5yWsB83sucU7fCgBLjW3RMVNWsI/2NBaKIWeqsuMsE7zAy0nnQ5+2XoznN1+vf4q
	5YE/oozVBJvPFhQNL6ooL5lWmTZtcAJnGgXefN7qXAFeP6PVg7d2vWQveBnuV7Zc
	Q2kbUN0nbtIY5f1HJ4gc229l9OhxmYg+NqtxeIuHVWE8R9/ptL+9Mn5V0UpvQioT
	ZdjGk4cdkUVTGhn58qmBdcwJjr9MI8Oyp3CIlsnl8nV8B9xBPU1rAfzbODDSlsV3
	+Xxk1bfQvXCU6CcmmVY5zN8Tbwi1z6j4pokKJX8w81POlHPiDyKFhfPcPKhaWBUj
	Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ayc9q0e46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 20:33:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BAK4DB3039892;
	Wed, 10 Dec 2025 20:33:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4avaxmrq2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 20:33:05 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BAKWkSh001635;
	Wed, 10 Dec 2025 20:33:05 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-60-41.vpn.oracle.com [10.154.60.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4avaxmrprn-8;
	Wed, 10 Dec 2025 20:33:04 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        dwarves@vger.kernel.org, bpf@vger.kernel.org, ttreyer@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v6 bpf-next 07/10] selftests/bpf: test kind encoding/decoding
Date: Wed, 10 Dec 2025 20:32:40 +0000
Message-ID: <20251210203243.814529-8-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251210203243.814529-1-alan.maguire@oracle.com>
References: <20251210203243.814529-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_03,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512100168
X-Proofpoint-GUID: VNPlSimkVJG-oVGssx7zYLDS5hnpaRhT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDE2OCBTYWx0ZWRfXzx9RqI9XYIwr
 WFtUkLpklOpwxJmgEEqnCQYYppsXspMMthFNyGa7BWhupImR/8GBN4t7nBJflSCaVvvrL3ECpTx
 X3kqreDclrnGvu2KWQTVFbDeTYDd4QTHDofEtoRzdzdhFoWwTffUMzA8qzOfupRb5qO6TudiZ16
 xxEtBPCU5EAuTAl7hiIEkYWZBYBrzK7LtSrwWVDzCVnMwELe5TejeTacmU4MS0mxBamvJXPqbvN
 y2tdfMv+c/ok9DMz3FU8aEElThR1Yziy2T8NOFE8SCdbDAnuQOcoQZekUyrqG3bgowR5G27eTpi
 c0pX9m/G48Wve/7BMQr8iLtg4bz7ty0ZA1HZotcLC2Q/UxqkDArOdanNlrkVjcyp9ugmRufqhz/
 qmmIt3RGFuJQUHwPtMQVvnyJJDtBoTbLl/Nwew6ewc3N3inN2qA=
X-Proofpoint-ORIG-GUID: VNPlSimkVJG-oVGssx7zYLDS5hnpaRhT
X-Authority-Analysis: v=2.4 cv=SYn6t/Ru c=1 sm=1 tr=0 ts=6939d902 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=zm-fL-ZIduLWe7Znn4kA:9 cc=ntf awl=host:12099

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
2.43.5


