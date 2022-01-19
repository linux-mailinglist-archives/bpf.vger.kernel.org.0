Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1F04943A5
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 00:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344637AbiASXJu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Jan 2022 18:09:50 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45730 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1357831AbiASXJX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 19 Jan 2022 18:09:23 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20JIs6mC031136
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 15:09:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=MWplQGYeg9+8KeyXZy1wwxq/Kc3s58dF1jBhGrkI5JU=;
 b=KbLcpVMtsmjBuqenMmq/YZCSQ0APjJOM/vOmHPBOou//NDJr+lc0WKnp7fBo/bDkRXIp
 dGjGoe24D3lITZ+IYqmGjjtPOrfEDy0tyaX6x/g3t+PpMjL4Irz2yC9Rwy/UFaU1553b
 o9hBxoeL2f/NXru0pDtB9/nx+4EHwpuhbS4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dp197t87j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 15:09:23 -0800
Received: from twshared13036.24.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 19 Jan 2022 15:09:21 -0800
Received: by devbig921.prn2.facebook.com (Postfix, from userid 132113)
        id 793981F0A176; Wed, 19 Jan 2022 15:06:42 -0800 (PST)
From:   Christy Lee <christylee@fb.com>
To:     <andrii@kernel.org>, <acme@kernel.org>, <jolsa@redhat.com>
CC:     <christylee@fb.com>, <christyc.y.lee@gmail.com>,
        <bpf@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <kernel-team@fb.com>, <wangnan0@huawei.com>,
        <bobo.shaobowang@huawei.com>, <yuehaibing@huawei.com>
Subject: [PATCH bpf-next v4 1/2] perf: stop using deprecated bpf_load_program() API
Date:   Wed, 19 Jan 2022 15:06:35 -0800
Message-ID: <20220119230636.1752684-2-christylee@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220119230636.1752684-1-christylee@fb.com>
References: <20220119230636.1752684-1-christylee@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: _Wr3h59YRJE_cb5cMqahlHg0Wq3JzEiM
X-Proofpoint-GUID: _Wr3h59YRJE_cb5cMqahlHg0Wq3JzEiM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-19_12,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 bulkscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201190122
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_load_program() API is deprecated, remove perf's usage of the
deprecated function. Add a __weak function declaration for libbpf
version compatibility.

Signed-off-by: Christy Lee <christylee@fb.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/perf/tests/bpf.c      | 14 ++++----------
 tools/perf/util/bpf-event.c | 16 ++++++++++++++++
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index 573490530194..57b9591f7cbb 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -281,8 +281,8 @@ static int __test__bpf(int idx)
=20
 static int check_env(void)
 {
+	LIBBPF_OPTS(bpf_prog_load_opts, opts);
 	int err;
-	unsigned int kver_int;
 	char license[] =3D "GPL";
=20
 	struct bpf_insn insns[] =3D {
@@ -290,19 +290,13 @@ static int check_env(void)
 		BPF_EXIT_INSN(),
 	};
=20
-	err =3D fetch_kernel_version(&kver_int, NULL, 0);
+	err =3D fetch_kernel_version(&opts.kern_version, NULL, 0);
 	if (err) {
 		pr_debug("Unable to get kernel version\n");
 		return err;
 	}
-
-/* temporarily disable libbpf deprecation warnings */
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
-	err =3D bpf_load_program(BPF_PROG_TYPE_KPROBE, insns,
-			       ARRAY_SIZE(insns),
-			       license, kver_int, NULL, 0);
-#pragma GCC diagnostic pop
+	err =3D bpf_prog_load(BPF_PROG_TYPE_KPROBE, NULL, license, insns,
+			    ARRAY_SIZE(insns), &opts);
 	if (err < 0) {
 		pr_err("Missing basic BPF support, skip this test: %s\n",
 		       strerror(errno));
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index a517eaa51eb3..48872276c0b7 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -33,6 +33,22 @@ struct btf * __weak btf__load_from_kernel_by_id(__u32 =
id)
        return err ? ERR_PTR(err) : btf;
 }
=20
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wunused-parameter"
+int __weak
+bpf_prog_load(enum bpf_prog_type prog_type,
+		const char *prog_name, const char *license,
+		const struct bpf_insn *insns, size_t insn_cnt,
+		const struct bpf_prog_load_opts *opts)
+{
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
+	return bpf_load_program(prog_type, insns, insn_cnt, license,
+				opts->kern_version, opts->log_buf, opts->log_size);
+#pragma GCC diagnostic pop
+}
+#pragma GCC diagnostic pop
+
 struct bpf_program * __weak
 bpf_object__next_program(const struct bpf_object *obj, struct bpf_progra=
m *prev)
 {
--=20
2.30.2

