Return-Path: <bpf+bounces-1547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B731718B10
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 22:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05BE41C20EF2
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 20:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633553D39B;
	Wed, 31 May 2023 20:22:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC0034CE2
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 20:22:03 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FF412C
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 13:21:59 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VKD3IW016261;
	Wed, 31 May 2023 20:21:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=hwXmierehEslNjthUkN9zGuafnuA9WBpaZA6VilAp00=;
 b=kLs23nhquP8STz8GrCAzESgTopPYV246XPlXfcx87L42GiunEFJBEhRo2W2Xg9n6m5xz
 C+oDiCRyqezvarZd4/cUz/6FhgUkcw71hiQmlCnFzFsFvXIsxTudb2nlc6eTwiP/P6PR
 c8B600hTxnGcBPRA8D0LRIoRdcjnfvCzVNESCKVYMV4TC232CMP0EthkWBVj0C4nfOXS
 Q0MMGraM8svNgzMazOHise9RTCM6Dm49PLIz+JFphkGPG8x8K8Y1YSlumk/RWGLE9ZzC
 sbmI2lSa7WTwnU788Rdl6FTH0LmPu6Qh/P7J1emiN4BvAYGgZbmfe+anj5hxWXMdPwXy kg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhmepwy6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 May 2023 20:21:11 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34VJPuoM019721;
	Wed, 31 May 2023 20:21:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a6dk3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 May 2023 20:21:10 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34VKKaEb000653;
	Wed, 31 May 2023 20:21:10 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-201-40.vpn.oracle.com [10.175.201.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3qu8a6djab-9;
	Wed, 31 May 2023 20:21:09 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, acme@kernel.org
Cc: martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, quentin@isovalent.com,
        mykolal@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 8/8] selftests/bpf: test kind encoding/decoding
Date: Wed, 31 May 2023 21:19:35 +0100
Message-Id: <20230531201936.1992188-9-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230531201936.1992188-1-alan.maguire@oracle.com>
References: <20230531201936.1992188-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_14,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305310172
X-Proofpoint-ORIG-GUID: kjB7IP50Drzt7RP2rbJvYgxyYuYK-3Nn
X-Proofpoint-GUID: kjB7IP50Drzt7RP2rbJvYgxyYuYK-3Nn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

verify btf__add_kinds() adds kind encodings for all kinds supported,
and after adding kind-related types for an unknown kind, ensure that
parsing uses this info when that kind is encountered rather than
giving up.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../selftests/bpf/prog_tests/btf_kind.c       | 138 ++++++++++++++++++
 1 file changed, 138 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_kind.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_kind.c b/tools/testing/selftests/bpf/prog_tests/btf_kind.c
new file mode 100644
index 000000000000..a928415c60ff
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_kind.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023, Oracle and/or its affiliates. */
+
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include <bpf/libbpf.h>
+
+/* verify kind encoding exists for each kind */
+void test_btf_kind_encoding(struct btf *btf, char *description)
+{
+	const struct btf_header *hdr;
+	const struct btf_metadata *meta;
+	const void *raw_btf;
+	__u32 raw_size;
+	__u16 i;
+
+	raw_btf = btf__raw_data(btf, &raw_size);
+	if (!ASSERT_OK_PTR(raw_btf, "btf__raw_data"))
+		return;
+
+	hdr = raw_btf;
+	meta = raw_btf + hdr->hdr_len + hdr->meta_header.meta_off;
+
+	if (!ASSERT_EQ(meta->kind_meta_cnt, NR_BTF_KINDS, "unexpected kind_meta_cnt"))
+		return;
+
+	if (!ASSERT_EQ(strcmp(description, btf__name_by_offset(btf, meta->description_off)),
+		       0, "check meta description"))
+		return;
+
+	for (i = 0; i <= BTF_KIND_MAX; i++) {
+		const struct btf_kind_meta *k = &meta->kind_meta[i];
+
+		if (ASSERT_OK_PTR(btf__name_by_offset(btf, k->name_off), "kind_name_valid"))
+			return;
+	}
+}
+
+/* fabricate an unrecognized kind at BTF_KIND_MAX + 1, and after adding
+ * the appropriate struct/typedefs to the BTF such that it recognizes
+ * this kind, ensure that parsing of BTF containing the unrecognized kind
+ * can succeed.
+ */
+void test_btf_kind_decoding(struct btf *btf)
+{
+	__s32 int_id, unrec_id, id;
+	struct btf_type *t;
+	char btf_path[64];
+	const void *raw_btf;
+	void *new_raw_btf;
+	struct btf *new_btf;
+	struct btf_header *hdr;
+	struct btf_metadata *meta;
+	struct btf_kind_meta *k;
+	__u32 raw_size;
+	int fd;
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
+
+	raw_btf = (void *)btf__raw_data(btf, &raw_size);
+	if (!ASSERT_OK_PTR(raw_btf, "btf__raw_data"))
+		return;
+
+	new_raw_btf = calloc(1, raw_size + sizeof(*k));
+	memcpy(new_raw_btf, raw_btf, raw_size);
+
+	/* add new metadata description */
+	hdr = new_raw_btf;
+	hdr->meta_header.meta_len += sizeof(*k);
+	meta = new_raw_btf + hdr->hdr_len + hdr->meta_header.meta_off;
+	meta->kind_meta_cnt += 1;
+	/* we will call our kinds UNKN, re-using the string offsets from BTF_KIND_UNKN */
+	k = &meta->kind_meta[NR_BTF_KINDS];
+	k->name_off = meta->kind_meta[0].name_off + strlen("BTF_KIND_");
+	k->flags = BTF_KIND_META_OPTIONAL;
+	k->info_sz = 0;
+	k->elem_sz = 0;
+
+	/* now modify our typedef added above to be an unrecognized kind. */
+	t = (void *)hdr + hdr->hdr_len + hdr->type_off + sizeof(struct btf_type) +
+		sizeof(__u32);
+	t->info = (NR_BTF_KINDS << 24);
+
+	/* now write our BTF to a raw file, ready for parsing. */
+	snprintf(btf_path, sizeof(btf_path), "/tmp/btf_kind.%d", getpid());
+	fd = open(btf_path, O_WRONLY | O_CREAT);
+	write(fd, new_raw_btf, raw_size + sizeof(*k));
+	close(fd);
+
+	/* verify parsing succeeds, and that we can read type info past
+	 * the unrecognized kind.
+	 */
+	new_btf = btf__parse_raw(btf_path);
+	if (ASSERT_OK_PTR(new_btf, "btf__parse_raw")) {
+		ASSERT_EQ(btf__find_by_name_kind(new_btf, "test_lookup",
+						 BTF_KIND_TYPEDEF), id,
+			  "verify_id_lookup");
+		/* verify the kernel can handle unrecognized kinds. */
+		ASSERT_EQ(btf__load_into_kernel(new_btf), 0, "btf_load_into_kernel");
+	}
+	unlink(btf_path);
+}
+
+void test_btf_kind(void)
+{
+	LIBBPF_OPTS(btf_new_opts, opts);
+	char *description = "testing metadata!";
+
+	opts.add_meta = true;
+	opts.description = description;
+
+	struct btf *btf = btf__new_empty_opts(&opts);
+
+	if (!ASSERT_OK_PTR(btf, "btf_new"))
+		return;
+
+	if (test__start_subtest("btf_kind_encoding"))
+		test_btf_kind_encoding(btf, description);
+	if (test__start_subtest("btf_kind_decoding"))
+		test_btf_kind_decoding(btf);
+	btf__free(btf);
+}
-- 
2.31.1


