Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28B9427BC12
	for <lists+bpf@lfdr.de>; Tue, 29 Sep 2020 06:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725379AbgI2EdS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Sep 2020 00:33:18 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44454 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725355AbgI2EdS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 29 Sep 2020 00:33:18 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08T4TjUT017200
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2020 21:33:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Zybn+Goq4YZYpN7stdOZ32uTqxyqicZsFw8oFmPKqRk=;
 b=l6QDkT6NLVdBOp/M+IcM2xW0y481JiAaGdrRXTdFwGcoQPjr5v2xLPKdJzzPxYA6aVZB
 D6Po/4GkKQyCTdPl7/OLIXaOemFX8tnVkL2xMwSCbuqcsiSTsIUK/OK+PycB2HxX1jv3
 sgVo27pn5QccQiXbjttC7gcfKBz11EttgMw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33t3cpb18y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2020 21:33:17 -0700
Received: from intmgw002.03.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 28 Sep 2020 21:33:16 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 84D132EC7750; Mon, 28 Sep 2020 21:31:00 -0700 (PDT)
From:   Andrii Nakryiko <andriin@fb.com>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Tony Ambardar <tony.ambardar@gmail.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Luka Perkov <luka.perkov@sartura.hr>
Subject: [PATCH bpf-next 3/3] selftests/bpf: test BTF's handling of endianness
Date:   Mon, 28 Sep 2020 21:30:46 -0700
Message-ID: <20200929043046.1324350-4-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200929043046.1324350-1-andriin@fb.com>
References: <20200929043046.1324350-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-29_01:2020-09-28,2020-09-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 mlxlogscore=999
 suspectscore=25 priorityscore=1501 lowpriorityscore=0 spamscore=0
 adultscore=0 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009290045
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add selftests juggling endianness back and forth to validate BTF's handli=
ng of
endianness convertions internally.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 .../selftests/bpf/prog_tests/btf_endian.c     | 101 ++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_endian.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_endian.c b/tools/=
testing/selftests/bpf/prog_tests/btf_endian.c
new file mode 100644
index 000000000000..8c52d72c876e
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_endian.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2020 Facebook */
+#define _GNU_SOURCE
+#include <string.h>
+#include <byteswap.h>
+#include <test_progs.h>
+#include <bpf/btf.h>
+
+static int duration =3D 0;
+
+void test_btf_endian() {
+#if __BYTE_ORDER =3D=3D __LITTLE_ENDIAN
+	enum btf_endianness endian =3D BTF_LITTLE_ENDIAN;
+#elif __BYTE_ORDER =3D=3D __BIG_ENDIAN
+	enum btf_endianness endian =3D BTF_BIG_ENDIAN;
+#else
+#error "Unrecognized __BYTE_ORDER"
+#endif
+	enum btf_endianness swap_endian =3D 1 - endian;
+	struct btf *btf =3D NULL, *swap_btf =3D NULL;
+	const void *raw_data, *swap_raw_data;
+	const struct btf_type *t;
+	const struct btf_header *hdr;
+	__u32 raw_sz, swap_raw_sz;
+	int var_id;
+
+	/* Load BTF in native endianness */
+	btf =3D btf__parse_elf("btf_dump_test_case_syntax.o", NULL);
+	if (!ASSERT_OK_PTR(btf, "parse_native_btf"))
+		goto err_out;
+
+	ASSERT_EQ(btf__endianness(btf), endian, "endian");
+	btf__set_endianness(btf, swap_endian);
+	ASSERT_EQ(btf__endianness(btf), swap_endian, "endian");
+
+	/* Get raw BTF data in non-native endianness... */
+	raw_data =3D btf__get_raw_data(btf, &raw_sz);
+	if (!ASSERT_OK_PTR(raw_data, "raw_data_inverted"))
+		goto err_out;
+
+	/* ...and open it as a new BTF instance */
+	swap_btf =3D btf__new(raw_data, raw_sz);
+	if (!ASSERT_OK_PTR(swap_btf, "parse_swap_btf"))
+		goto err_out;
+
+	ASSERT_EQ(btf__endianness(swap_btf), swap_endian, "endian");
+	ASSERT_EQ(btf__get_nr_types(swap_btf), btf__get_nr_types(btf), "nr_type=
s");
+
+	swap_raw_data =3D btf__get_raw_data(swap_btf, &swap_raw_sz);
+	if (!ASSERT_OK_PTR(swap_raw_data, "swap_raw_data"))
+		goto err_out;
+
+	/* both raw data should be identical (with non-native endianness) */
+	ASSERT_OK(memcmp(raw_data, swap_raw_data, raw_sz), "mem_identical");
+
+	/* make sure that at least BTF header data is really swapped */
+	hdr =3D swap_raw_data;
+	ASSERT_EQ(bswap_16(hdr->magic), BTF_MAGIC, "btf_magic_swapped");
+	ASSERT_EQ(raw_sz, swap_raw_sz, "raw_sizes");
+
+	/* swap it back to native endianness */
+	btf__set_endianness(swap_btf, endian);
+	swap_raw_data =3D btf__get_raw_data(swap_btf, &swap_raw_sz);
+	if (!ASSERT_OK_PTR(swap_raw_data, "swap_raw_data"))
+		goto err_out;
+
+	/* now header should have native BTF_MAGIC */
+	hdr =3D swap_raw_data;
+	ASSERT_EQ(hdr->magic, BTF_MAGIC, "btf_magic_native");
+	ASSERT_EQ(raw_sz, swap_raw_sz, "raw_sizes");
+
+	/* now modify original BTF */
+	var_id =3D btf__add_var(btf, "some_var", BTF_VAR_GLOBAL_ALLOCATED, 1);
+	CHECK(var_id <=3D 0, "var_id", "failed %d\n", var_id);
+
+	btf__free(swap_btf);
+	swap_btf =3D NULL;
+
+	btf__set_endianness(btf, swap_endian);
+	raw_data =3D btf__get_raw_data(btf, &raw_sz);
+	if (!ASSERT_OK_PTR(raw_data, "raw_data_inverted"))
+		goto err_out;
+
+	/* and re-open swapped raw data again */
+	swap_btf =3D btf__new(raw_data, raw_sz);
+	if (!ASSERT_OK_PTR(swap_btf, "parse_swap_btf"))
+		goto err_out;
+
+	ASSERT_EQ(btf__endianness(swap_btf), swap_endian, "endian");
+	ASSERT_EQ(btf__get_nr_types(swap_btf), btf__get_nr_types(btf), "nr_type=
s");
+
+	/* the type should appear as if it was stored in native endianness */
+	t =3D btf__type_by_id(swap_btf, var_id);
+	ASSERT_STREQ(btf__str_by_offset(swap_btf, t->name_off), "some_var", "va=
r_name");
+	ASSERT_EQ(btf_var(t)->linkage, BTF_VAR_GLOBAL_ALLOCATED, "var_linkage")=
;
+	ASSERT_EQ(t->type, 1, "var_type");
+
+err_out:
+	btf__free(btf);
+	btf__free(swap_btf);
+}
--=20
2.24.1

