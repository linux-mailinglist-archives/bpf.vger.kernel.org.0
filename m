Return-Path: <bpf+bounces-13058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2147D427F
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 00:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EE27B20DE8
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 22:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BED2376C;
	Mon, 23 Oct 2023 22:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="OjTYUtp1"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58D71859
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 22:00:58 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD93DE
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 15:00:56 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39NGY97a005886
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 15:00:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=FO8cxAQ+MB4w4oWhkikOueJxnp7rHmIv83Wtph69K7s=;
 b=OjTYUtp1mlC6r16TOiHlbmIAfs83+bsdX2sB0p1zN7tTy6N9vXdIIhCuA4+cg2gM8JpT
 F76l46dskHYCxt3AaOZ9uwMBbUQV07zPxG5M2pM2lHNA0sYGzgOMg2+aE6IZOdRKtpLa
 OeHakiC4sp7P8bjlpQWYI7/nhN/REwy4ffk= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3twkuf5580-16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 15:00:55 -0700
Received: from twshared34392.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 23 Oct 2023 15:00:52 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id A8C3B2632D0F1; Mon, 23 Oct 2023 15:00:39 -0700 (PDT)
From: Dave Marchevsky <davemarchevsky@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky
	<davemarchevsky@fb.com>
Subject: [PATCH v1 bpf-next 4/4] selftests/bpf: Add tests exercising aggregate type BTF field search
Date: Mon, 23 Oct 2023 15:00:30 -0700
Message-ID: <20231023220030.2556229-5-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023220030.2556229-1-davemarchevsky@fb.com>
References: <20231023220030.2556229-1-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 9Ieb1Evzsu1ATJdkSBQA8LMCCTUmjeOg
X-Proofpoint-ORIG-GUID: 9Ieb1Evzsu1ATJdkSBQA8LMCCTUmjeOg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_21,2023-10-19_01,2023-05-22_02

The newly-added test file attempts to kptr_xchg a prog_test_ref_kfunc
kptr into a kptr field in a variety of nested aggregate types. If the
verifier recognizes that there's a kptr field where we're trying to
kptr_xchg, then the aggregate type digging logic works as expected.

Some of the refactoring changes in this series are tested as well.
Specifically:
  * BTF_FIELDS_MAX is now higher and represents the max size of the
    growable array. Confirm that btf_parse_fields fails for a type which
    contains too many fields.
  * If we've already seen BTF_FIELDS_MAX fields, we should continue
    looking for fields and fail if we find another one, otherwise the
    search should succeed and return BTF_FIELDS_MAX btf_field_infos.
    Confirm that this edge case works as expected.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 .../selftests/bpf/prog_tests/array_kptr.c     |  12 ++
 .../testing/selftests/bpf/progs/array_kptr.c  | 179 ++++++++++++++++++
 2 files changed, 191 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/array_kptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/array_kptr.c

diff --git a/tools/testing/selftests/bpf/prog_tests/array_kptr.c b/tools/=
testing/selftests/bpf/prog_tests/array_kptr.c
new file mode 100644
index 000000000000..9d088520bdfe
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/array_kptr.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+
+#include "array_kptr.skel.h"
+
+void test_array_kptr(void)
+{
+	if (env.has_testmod)
+		RUN_TESTS(array_kptr);
+}
diff --git a/tools/testing/selftests/bpf/progs/array_kptr.c b/tools/testi=
ng/selftests/bpf/progs/array_kptr.c
new file mode 100644
index 000000000000..f34872e74024
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/array_kptr.c
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include "../bpf_testmod/bpf_testmod_kfunc.h"
+#include "bpf_misc.h"
+
+struct val {
+	int d;
+	struct prog_test_ref_kfunc __kptr *ref_ptr;
+};
+
+struct val2 {
+	char c;
+	struct val v;
+};
+
+struct val_holder {
+	int e;
+	struct val2 first[2];
+	int f;
+	struct val second[2];
+};
+
+struct array_map {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct val);
+	__uint(max_entries, 10);
+} array_map SEC(".maps");
+
+struct array_map2 {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct val2);
+	__uint(max_entries, 10);
+} array_map2 SEC(".maps");
+
+__hidden struct val array[25];
+__hidden struct val double_array[5][5];
+__hidden struct val_holder double_holder_array[2][2];
+
+/* Some tests need their own section to force separate bss arraymap,
+ * otherwise above arrays wouldn't have btf_field_info either
+ */
+#define private(name) SEC(".bss." #name) __hidden __attribute__((aligned=
(8)))
+private(A) struct val array_too_big[300];
+
+private(B) struct val exactly_max_fields[256];
+private(B) int ints[50];
+
+SEC("tc")
+__success __retval(0)
+int test_arraymap(void *ctx)
+{
+	struct prog_test_ref_kfunc *p;
+	unsigned long dummy =3D 0;
+	struct val *v;
+	int idx =3D 0;
+
+	v =3D bpf_map_lookup_elem(&array_map, &idx);
+	if (!v)
+		return 1;
+
+	p =3D bpf_kfunc_call_test_acquire(&dummy);
+	if (!p)
+		return 2;
+
+	p =3D bpf_kptr_xchg(&v->ref_ptr, p);
+	if (p) {
+		bpf_kfunc_call_test_release(p);
+		return 3;
+	}
+
+	return 0;
+}
+
+SEC("tc")
+__success __retval(0)
+int test_arraymap2(void *ctx)
+{
+	struct prog_test_ref_kfunc *p;
+	unsigned long dummy =3D 0;
+	struct val2 *v;
+	int idx =3D 0;
+
+	v =3D bpf_map_lookup_elem(&array_map2, &idx);
+	if (!v)
+		return 1;
+
+	p =3D bpf_kfunc_call_test_acquire(&dummy);
+	if (!p)
+		return 2;
+
+	p =3D bpf_kptr_xchg(&v->v.ref_ptr, p);
+	if (p) {
+		bpf_kfunc_call_test_release(p);
+		return 3;
+	}
+
+	return 0;
+}
+
+/* elem must be contained within some mapval so it can be used as
+ * bpf_kptr_xchg's first param
+ */
+static __always_inline int test_array_xchg(struct val *elem)
+{
+	struct prog_test_ref_kfunc *p;
+	unsigned long dummy =3D 0;
+
+	p =3D bpf_kfunc_call_test_acquire(&dummy);
+	if (!p)
+		return 1;
+
+	p =3D bpf_kptr_xchg(&elem->ref_ptr, p);
+	if (p) {
+		bpf_kfunc_call_test_release(p);
+		return 2;
+	}
+
+	return 0;
+}
+
+SEC("tc")
+__success __retval(0)
+int test_array(void *ctx)
+{
+	return test_array_xchg(&array[10]);
+}
+
+SEC("tc")
+__success __retval(0)
+int test_double_array(void *ctx)
+{
+	/* array -> array -> struct -> kptr */
+	return test_array_xchg(&double_array[4][3]);
+}
+
+SEC("tc")
+__success __retval(0)
+int test_double_holder_array_first(void *ctx)
+{
+	/* array -> array -> struct -> array -> struct -> struct -> kptr */
+	return test_array_xchg(&double_holder_array[1][1].first[1].v);
+}
+
+SEC("tc")
+__success __retval(0)
+int test_double_holder_array_second(void *ctx)
+{
+	/* array -> array -> struct -> array -> struct -> kptr */
+	return test_array_xchg(&double_holder_array[1][1].second[1]);
+}
+
+SEC("tc")
+__success __retval(0)
+int test_exactly_max_fields(void *ctx)
+{
+	/* Edge case where verifier finds BTF_FIELDS_MAX fields. It should be
+	 * safe to examine .bss.B's other array, and .bss.B will have a valid
+	 * btf_record if no more fields are found
+	 */
+	return test_array_xchg(&exactly_max_fields[255]);
+}
+
+SEC("tc")
+__failure __msg("map '.bss.A' has no valid kptr")
+int test_array_fail__too_big(void *ctx)
+{
+	/* array_too_big's btf_record parsing will fail due to the
+	 * number of btf_field_infos being > BTF_FIELDS_MAX
+	 */
+	return test_array_xchg(&array_too_big[50]);
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.34.1


