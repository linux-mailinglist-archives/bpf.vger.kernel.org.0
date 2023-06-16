Return-Path: <bpf+bounces-2743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E76733754
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 19:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC1E21C20AC0
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 17:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5C51D2C9;
	Fri, 16 Jun 2023 17:18:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BFE182D2
	for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 17:18:57 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4C0211D
	for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 10:18:55 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35GCicep024827;
	Fri, 16 Jun 2023 17:18:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=akngSeQCi7eQC9h7sjFDdQY3aUwi/ypDFyrgrnj0b8M=;
 b=ZA56iM3Q5oTHXvyiV5mAKMxgUjcCMMGIq3wzkmIrPYBcKDr4lkmdrG1mbD5pf7/e3itU
 or3lH+Rtby2DCcmXEftXA4KwhqsKhnRrkUSj/zfwG7GzqoiV2FZSWuDUwBnolGnKBqy0
 lhlTRSqQMfFRRsN5dG28o/7G0BbNt6+Kp01ii/lPi6ZwaZn9nP50KyRCwNAgDSyoJayC
 y2IDG+go400T4MY0TvatYp9oPnmGsTm1jNrJ+NfnWd/xrhiYEujaDnHWBH9kotKVAj6Z
 PCcRhOfxzRUa0mbVuATNbBWItFxlsmsWACbjfOUgidZyrcA4hCTac/yIPDUtZs+hv7fr Tg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4hquvr3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jun 2023 17:18:35 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35GGvW4p012400;
	Fri, 16 Jun 2023 17:18:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fmeru4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jun 2023 17:18:34 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35GHGqPo007608;
	Fri, 16 Jun 2023 17:18:33 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-209-206.vpn.oracle.com [10.175.209.206])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3r4fmert3d-10;
	Fri, 16 Jun 2023 17:18:33 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        quentin@isovalent.com, jolsa@kernel.org
Cc: martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 9/9] selftests/bpf: test kind encoding/decoding
Date: Fri, 16 Jun 2023 18:17:27 +0100
Message-Id: <20230616171728.530116-10-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230616171728.530116-1-alan.maguire@oracle.com>
References: <20230616171728.530116-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-16_11,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306160156
X-Proofpoint-ORIG-GUID: VFZHzMBx9dksu6-urX5Xjriy1Y9R86sE
X-Proofpoint-GUID: VFZHzMBx9dksu6-urX5Xjriy1Y9R86sE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

verify btf__new_empty_opts() adds kind layouts for all kinds supported,
and after adding kind-related types for an unknown kind, ensure that
parsing uses this info when that kind is encountered rather than
giving up.  Also verify that presence of a required kind will fail
parsing.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../selftests/bpf/prog_tests/btf_kind.c       | 187 ++++++++++++++++++
 1 file changed, 187 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_kind.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_kind.c b/tools/testing/selftests/bpf/prog_tests/btf_kind.c
new file mode 100644
index 000000000000..ff37126b6bc0
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_kind.c
@@ -0,0 +1,187 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023, Oracle and/or its affiliates. */
+
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include <bpf/libbpf.h>
+
+/* verify kind encoding exists for each kind */
+void test_btf_kind_encoding(struct btf *btf)
+{
+	const struct btf_header *hdr;
+	const void *raw_btf;
+	__u32 raw_size;
+
+	raw_btf = btf__raw_data(btf, &raw_size);
+	if (!ASSERT_OK_PTR(raw_btf, "btf__raw_data"))
+		return;
+
+	hdr = raw_btf;
+
+	ASSERT_GT(hdr->kind_layout_off, hdr->str_off, "kind layout off");
+	ASSERT_EQ(hdr->kind_layout_len, sizeof(struct btf_kind_layout) * NR_BTF_KINDS,
+		  "kind_layout_len");
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
+void test_btf_kind_decoding(struct btf *btf)
+{
+	__s32 int_id, unrec_id, id, id2;
+	struct btf_type *t;
+	char btf_path[64];
+	const void *raw_btf;
+	void *new_raw_btf;
+	struct btf *new_btf;
+	struct btf_header *hdr;
+	struct btf_kind_layout *k;
+	__u32 raw_size;
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
+	k[NR_BTF_KINDS].flags = BTF_KIND_LAYOUT_OPTIONAL;
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
+
+		/* verify the kernel can handle unrecognized kinds. */
+		ASSERT_EQ(btf__load_into_kernel(new_btf), 0, "btf_load_into_kernel");
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
+		/* verify the kernel can handle unrecognized kinds. */
+		ASSERT_EQ(btf__load_into_kernel(new_btf), 0, "btf_load_into_kernel");
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
+		/* verify the kernel can handle unrecognized kinds. */
+		ASSERT_EQ(btf__load_into_kernel(new_btf), 0, "btf_load_into_kernel");
+	}
+	btf__free(new_btf);
+
+	/* next, change kind to required (no optional flag) and ensure parsing fails. */
+	k[NR_BTF_KINDS].flags = 0;
+	write_raw_btf(btf_path, new_raw_btf, raw_size + sizeof(*k));
+
+	new_btf = btf__parse_raw(btf_path);
+	ASSERT_ERR_PTR(new_btf, "btf__parse_raw_required");
+
+	free(new_raw_btf);
+	unlink(btf_path);
+}
+
+void test_btf_kind(void)
+{
+	LIBBPF_OPTS(btf_new_opts, opts);
+
+	opts.add_kind_layout = true;
+
+	struct btf *btf = btf__new_empty_opts(&opts);
+
+	if (!ASSERT_OK_PTR(btf, "btf_new"))
+		return;
+
+	if (test__start_subtest("btf_kind_encoding"))
+		test_btf_kind_encoding(btf);
+	if (test__start_subtest("btf_kind_decoding"))
+		test_btf_kind_decoding(btf);
+	btf__free(btf);
+}
-- 
2.39.3


