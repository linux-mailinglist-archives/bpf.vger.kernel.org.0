Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302AA63677C
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 18:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237811AbiKWRms (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 12:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238261AbiKWRmm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 12:42:42 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E39B1FD
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 09:42:38 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ANGTUxY015349;
        Wed, 23 Nov 2022 17:42:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=p7hc4poq3vBizw9PlTqG0mo8eICza6D7lYdVu9fFq/Y=;
 b=bsn/co7Kcnk0tkO8K0v9dpZCyDqvyPpB2mJp3jYuYgOxKQuzaAy0C7YULzAH/8QdsFP3
 sVVNYKu8D8Ay6WauaYtZvrawGuEtVyJsbi2bxKTPCr63C4wq31Qn6UAfJiR8uC9H7yUf
 zEtspHBDbpMrl817Si/uEUBnETlwhmfpMkxmH3zuysGbZZI199jkZTZceGirWzvnHzrt
 THtBLk7RdAmvi10laQUnMuY81oKMaDoMO/jq8bJ5iXJfngdFMV5yzCDDO270SWgec1eh
 e31fhR0sCFFJ1vDEoMfSLc/FlvZfd/2mtMb0iPIpwrIIqr/o716einofrFqCjUSj0sGB Bw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m1p5fgd4y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Nov 2022 17:42:18 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ANHJFZs015679;
        Wed, 23 Nov 2022 17:42:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnk74ajh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Nov 2022 17:42:16 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2ANHfvqK028233;
        Wed, 23 Nov 2022 17:42:16 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-201-76.vpn.oracle.com [10.175.201.76])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3kxnk74a4g-6;
        Wed, 23 Nov 2022 17:42:16 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        haiyue.wang@intel.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 5/5] selftests/bpf: test kind encoding/decoding
Date:   Wed, 23 Nov 2022 17:41:52 +0000
Message-Id: <1669225312-28949-6-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1669225312-28949-1-git-send-email-alan.maguire@oracle.com>
References: <1669225312-28949-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-23_10,2022-11-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211230130
X-Proofpoint-ORIG-GUID: fG4foOBT7iaCQjcNGs_6aIqhlF5cSS0f
X-Proofpoint-GUID: fG4foOBT7iaCQjcNGs_6aIqhlF5cSS0f
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

verify btf__add_kinds() adds kind encodings for all kinds supported,
and after adding kind-related types for unknown kinds, ensure that
parsing uses this info when those kinds are encountered rather than
giving up.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/testing/selftests/bpf/prog_tests/btf_kind.c | 234 ++++++++++++++++++++++
 1 file changed, 234 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_kind.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_kind.c b/tools/testing/selftests/bpf/prog_tests/btf_kind.c
new file mode 100644
index 0000000..e0865ab
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_kind.c
@@ -0,0 +1,234 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022, Oracle and/or its affiliates. */
+
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include <bpf/libbpf.h>
+
+/* verify kind encoding exists for each kind; ensure it consists of a
+ * typedef __BTF_KIND_<num> pointing at a struct __BTF_KIND_<name>,
+ * and the latter has a struct btf_type field and an optional metadata
+ * field.
+ */
+void test_btf_kind_encoding(struct btf *btf)
+{
+	int type_cnt;
+	__u16 i;
+
+	type_cnt = btf__type_cnt(btf);
+	if (!ASSERT_GT(type_cnt, 0, "check_type_cnt"))
+		return;
+
+	for (i = 0; i <= BTF_KIND_MAX; i++) {
+		const struct btf_type *t, *mt;
+		const struct btf_array *a;
+		struct btf_member *m;
+		char name[64];
+		__s32 tid;
+
+		snprintf(name, sizeof(name), BTF_KIND_PFX"%u", i);
+
+		tid = btf__find_by_name(btf, name);
+
+		if (!ASSERT_GT(tid, 0, "find_typedef"))
+			continue;
+
+		t = btf__type_by_id(btf, tid);
+		if (!ASSERT_OK_PTR(t, "typedef_ptr"))
+			continue;
+		t = btf__type_by_id(btf, t->type);
+		if (!ASSERT_OK_PTR(t, "struct_ptr"))
+			continue;
+		if (!ASSERT_EQ(strncmp(btf__name_by_offset(btf, t->name_off),
+				       BTF_KIND_PFX,
+				       strlen(BTF_KIND_PFX)),
+			      0, "check_struct_name"))
+			continue;
+		if (!ASSERT_GT(btf_vlen(t), 0, "check_struct_vlen"))
+			continue;
+		m = btf_members(t);
+		mt = btf__type_by_id(btf, m->type);
+		if (!ASSERT_EQ(btf_kind(mt), BTF_KIND_STRUCT, "member_kind"))
+			continue;
+		if (!ASSERT_EQ(strcmp(btf__name_by_offset(btf, mt->name_off),
+				      "__btf_type"), 0, "member_type_name"))
+			continue;
+		if (btf_vlen(t) == 1)
+			continue;
+		m++;
+		mt = btf__type_by_id(btf, m->type);
+		if (!ASSERT_EQ(btf_kind(mt), BTF_KIND_ARRAY, "member_kind"))
+			continue;
+		a = btf_array(mt);
+		mt = btf__type_by_id(btf, a->type);
+		if (!ASSERT_EQ(strncmp(btf__name_by_offset(btf, mt->name_off),
+				       BTF_KIND_META_PFX,
+				       strlen(BTF_KIND_META_PFX)), 0,
+			       "check_meta_name"))
+			continue;
+	}
+}
+
+static __s32 add_kind(struct btf *btf, __u16 unrec_kind, int nr_meta, int meta_size)
+{
+	__s32 btf_type_id, id, struct_id, array_id;
+	char name[64];
+	int ret;
+
+	/* fabricate unrecognized kind definitions that will be used
+	 * when we add a type using the unrecognized kind later.
+	 */
+	btf_type_id = btf__find_by_name_kind(btf, "__btf_type", BTF_KIND_STRUCT);
+	if (!ASSERT_GT(btf_type_id, 0, "check_btf_type_id"))
+		return btf_type_id;
+
+	if (meta_size > 0) {
+		__s32 __u32_id;
+
+		__u32_id = btf__find_by_name(btf, "__u32");
+		if (!ASSERT_GT(__u32_id, 0, "find_u32"))
+			return __u32_id;
+
+		array_id = btf__add_array(btf, __u32_id, btf_type_id, nr_meta);
+		if (!ASSERT_GT(array_id, 0, "btf__add_array"))
+			return array_id;
+	}
+
+	snprintf(name, sizeof(name), BTF_KIND_PFX "UNREC%d", unrec_kind);
+	struct_id = btf__add_struct(btf, name, sizeof(struct btf_type) + (nr_meta * meta_size));
+	if (!ASSERT_GT(struct_id, 0, "check_struct_id"))
+		return struct_id;
+
+	ret = btf__add_field(btf, "type", btf_type_id, 0, 0);
+	if (!ASSERT_EQ(ret, 0, "btf__add_field"))
+		return ret;
+	if (meta_size > 0) {
+		ret = btf__add_field(btf, "meta", array_id, 96, 0);
+		if (!ASSERT_EQ(ret, 0, "btf__add_field_meta"))
+			return ret;
+	}
+	snprintf(name, sizeof(name), BTF_KIND_PFX "%u", unrec_kind);
+	id = btf__add_typedef(btf, name, struct_id);
+	if (!ASSERT_GT(id, 0, "btf__add_typedef"))
+		return id;
+
+	return btf_type_id;
+}
+
+/* fabricate unrecognized kinds at BTF_KIND_MAX + 1/2/3, and after adding
+ * the appropriate struct/typedefs to the BTF such that it recognizes
+ * these kinds, ensure that parsing of BTF containing the unrecognized kinds
+ * can succeed.
+ */
+void test_btf_kind_decoding(struct btf *btf)
+{
+	const struct btf_type *old_unrecs[6];
+	__s32 id, btf_type_id, unrec_ids[6];
+	__u16 unrec_kind = BTF_KIND_MAX + 1;
+	struct btf_type *new_unrecs[6];
+	const void *raw_data;
+	struct btf *raw_btf;
+	char btf_path[64];
+	__u32 raw_size;
+	int i, fd;
+
+	/* fabricate unrecognized kind definitions that will be used
+	 * when we add a type using the unrecognized kind later.
+	 *
+	 * Kinds are created with
+	 * - no metadata;
+	 * - a single metadata object
+	 * - a vlen-determined number of metadata objects.
+	 */
+	btf_type_id = add_kind(btf, unrec_kind, 0, 0);
+	if (!ASSERT_GT(btf_type_id, 0, "add_kind1"))
+		return;
+	if (!ASSERT_GT(add_kind(btf, unrec_kind + 1, 1, sizeof(struct btf_type)), 0, "add_kind2"))
+		return;
+	if (!ASSERT_GT(add_kind(btf, unrec_kind + 2, 0, sizeof(struct btf_type)), 0, "add_kind3"))
+		return;
+
+	/* now create our types with unrecognized kinds by adding typedef kinds
+	 * and overwriting them with our unrecognized kind values.
+	 */
+	for (i = 0; i < ARRAY_SIZE(unrec_ids); i++) {
+		char name[64];
+
+		snprintf(name, sizeof(name), "unrec_kind%d", i);
+		unrec_ids[i] = btf__add_typedef(btf, name, btf_type_id);
+		if (!ASSERT_GT(unrec_ids[i], 0, "btf__add_typedef"))
+			return;
+		old_unrecs[i] = btf__type_by_id(btf, unrec_ids[i]);
+		if (!ASSERT_OK_PTR(old_unrecs[i], "check_unrec_ptr"))
+			return;
+		new_unrecs[i] = (struct btf_type *)old_unrecs[i];
+	}
+
+	/* add an id after it that we will look up to verify we can parse
+	 * beyond unrecognized kinds.
+	 */
+	id = btf__add_typedef(btf, "test_lookup", btf_type_id);
+	if (!ASSERT_GT(id, 0, "add_test_lookup_id"))
+		return;
+	/* ...but because we converted two BTF types into metadata, the id
+	 * for lookup after modification will be two less.
+	 */
+	id -= 2;
+
+	/* now modify typedefs added above to become unrecognized kinds */
+	new_unrecs[0]->info = (unrec_kind << 24);
+
+	/* unrecognized kind with 1 metadata object */
+	new_unrecs[1]->info = ((unrec_kind + 1) << 24);
+
+	/* unrecognized kind with vlen-determined number of metadata objects; vlen == 1 here */
+	new_unrecs[3]->info = ((unrec_kind + 2) << 24) | 0x1;
+
+	/* having another instance of the unrecognized kind allows us to test
+	 * the caching codepath; we store unrecognized kind data the
+	 * first time we encounter one to avoid the cost of typedef/struct
+	 * lookups each time an unrecognized kind is seen.
+	 */
+	new_unrecs[5]->info = (unrec_kind << 24);
+	/* now write our BTF to a raw file, ready for parsing. */
+	snprintf(btf_path, sizeof(btf_path), "/tmp/btf_kind.%d", getpid());
+	raw_data = btf__raw_data(btf, &raw_size);
+	if (!ASSERT_OK_PTR(raw_data, "check_raw_data"))
+		return;
+	fd = open(btf_path, O_WRONLY | O_CREAT);
+	write(fd, raw_data, raw_size);
+	close(fd);
+
+	/* verify parsing succeeds, and that we can read type info past
+	 * the unrecognized kind.
+	 */
+	raw_btf = btf__parse_raw(btf_path);
+	if (!ASSERT_OK_PTR(raw_btf, "btf__parse_raw"))
+		goto unlink;
+	ASSERT_EQ(btf__find_by_name_kind(raw_btf, "test_lookup",
+					 BTF_KIND_TYPEDEF), id,
+		  "verify_id_lookup");
+
+	/* finally, verify the kernel can handle unrecognized kinds. */
+	ASSERT_EQ(btf__load_into_kernel(raw_btf), 0, "btf_load_into_kernel");
+unlink:
+	unlink(btf_path);
+}
+
+void test_btf_kind(void)
+{
+	struct btf *btf = btf__new_empty();
+
+	if (!ASSERT_OK_PTR(btf, "btf_new"))
+		return;
+
+	if (!ASSERT_OK(btf__add_kinds(btf), "btf__add_kinds"))
+		goto cleanup;
+
+	if (test__start_subtest("btf_kind_encoding"))
+		test_btf_kind_encoding(btf);
+	if (test__start_subtest("btf_kind_decoding"))
+		test_btf_kind_decoding(btf);
+cleanup:
+	btf__free(btf);
+}
-- 
1.8.3.1

