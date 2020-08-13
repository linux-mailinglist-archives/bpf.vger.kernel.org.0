Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56542434B8
	for <lists+bpf@lfdr.de>; Thu, 13 Aug 2020 09:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgHMHRm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Aug 2020 03:17:42 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:64204 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726632AbgHMHRk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 13 Aug 2020 03:17:40 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07D7EfbK021792
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2020 00:17:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=dZ/6d6r5sz9GcD0wgNaMearIT/YA7cjblJFShTofgT0=;
 b=QyCJI9deaynfrsKEOmOIv6c1v7S8AJm70YYFnx0XI+PC+7AgYrsEC1R9OnbNEqnmhCom
 1idu4dKL560McqjpZ8HnN63pEIQJSvMDH1jirD0AHF7dyFlqxGcGvAeVJtnl9OxLB4nb
 C3OvHADxobx0gR78jr2lpHWxYj5YSfCCnaI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 32v0kfghr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2020 00:17:39 -0700
Received: from intmgw005.03.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 13 Aug 2020 00:17:38 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 9F7732EC5928; Thu, 13 Aug 2020 00:17:35 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf 5/9] selftests/bpf: fix btf_dump test cases on 32-bit arches
Date:   Thu, 13 Aug 2020 00:17:18 -0700
Message-ID: <20200813071722.2213397-6-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200813071722.2213397-1-andriin@fb.com>
References: <20200813071722.2213397-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-13_04:2020-08-13,2020-08-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 adultscore=0 mlxscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 suspectscore=8 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008130055
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix btf_dump test cases by hard-coding BPF's pointer size of 8 bytes for =
cases
where it's impossible to deterimne the pointer size (no long type in BTF)=
. In
cases where it's known, validate libbpf correctly determines it as 8.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 .../selftests/bpf/prog_tests/btf_dump.c       | 27 ++++++++++++++-----
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/te=
sting/selftests/bpf/prog_tests/btf_dump.c
index cb33a7ee4e04..39fb81d9daeb 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -12,15 +12,16 @@ void btf_dump_printf(void *ctx, const char *fmt, va_l=
ist args)
 static struct btf_dump_test_case {
 	const char *name;
 	const char *file;
+	bool known_ptr_sz;
 	struct btf_dump_opts opts;
 } btf_dump_test_cases[] =3D {
-	{"btf_dump: syntax", "btf_dump_test_case_syntax", {}},
-	{"btf_dump: ordering", "btf_dump_test_case_ordering", {}},
-	{"btf_dump: padding", "btf_dump_test_case_padding", {}},
-	{"btf_dump: packing", "btf_dump_test_case_packing", {}},
-	{"btf_dump: bitfields", "btf_dump_test_case_bitfields", {}},
-	{"btf_dump: multidim", "btf_dump_test_case_multidim", {}},
-	{"btf_dump: namespacing", "btf_dump_test_case_namespacing", {}},
+	{"btf_dump: syntax", "btf_dump_test_case_syntax", true, {}},
+	{"btf_dump: ordering", "btf_dump_test_case_ordering", false, {}},
+	{"btf_dump: padding", "btf_dump_test_case_padding", true, {}},
+	{"btf_dump: packing", "btf_dump_test_case_packing", true, {}},
+	{"btf_dump: bitfields", "btf_dump_test_case_bitfields", true, {}},
+	{"btf_dump: multidim", "btf_dump_test_case_multidim", false, {}},
+	{"btf_dump: namespacing", "btf_dump_test_case_namespacing", false, {}},
 };
=20
 static int btf_dump_all_types(const struct btf *btf,
@@ -62,6 +63,18 @@ static int test_btf_dump_case(int n, struct btf_dump_t=
est_case *t)
 		goto done;
 	}
=20
+	/* tests with t->known_ptr_sz have no "long" or "unsigned long" type,
+	 * so it's impossible to determine correct pointer size; but if they
+	 * do, it should be 8 regardless of host architecture, becaues BPF
+	 * target is always 64-bit
+	 */
+	if (!t->known_ptr_sz) {
+		btf__set_pointer_size(btf, 8);
+	} else {
+		CHECK(btf__pointer_size(btf) !=3D 8, "ptr_sz", "exp %d, got %zu\n",
+		      8, btf__pointer_size(btf));
+	}
+
 	snprintf(out_file, sizeof(out_file), "/tmp/%s.output.XXXXXX", t->file);
 	fd =3D mkstemp(out_file);
 	if (CHECK(fd < 0, "create_tmp", "failed to create file: %d\n", fd)) {
--=20
2.24.1

