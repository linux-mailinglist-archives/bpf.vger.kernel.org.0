Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88CAA486AD3
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 21:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243552AbiAFUDc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 15:03:32 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:13868 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243558AbiAFUDc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 6 Jan 2022 15:03:32 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 206HVHYn007323
        for <bpf@vger.kernel.org>; Thu, 6 Jan 2022 12:03:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=ExiJ+FZgoWr29oL/n0m0aknMr0820ovZMGzMev+iIWg=;
 b=R4GDodo1Ac+cJwnOEcBnRznf6gboy3BOXqV3hK9CHfMf4XseLZUnawjQqRnP+SM56c4X
 WC0S270m1pXVppg4PQ0mgGq3Sh3kGb/P1mI30GW87LbAsOn6lAj3p+rmkFC4A3I+sRVc
 3jQF1FLJ4D9QJQS+sjpxAZsEn1acMRxF+YE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3de4vv907w-16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 06 Jan 2022 12:03:31 -0800
Received: from twshared13833.42.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 6 Jan 2022 12:03:26 -0800
Received: by devbig921.prn2.facebook.com (Postfix, from userid 132113)
        id 7C9C915AB148; Thu,  6 Jan 2022 12:00:43 -0800 (PST)
From:   Christy Lee <christylee@fb.com>
To:     <andrii@kernel.org>, <acme@kernel.org>, <jolsa@redhat.com>
CC:     <christylee@fb.com>, <christyc.y.lee@gmail.com>,
        <bpf@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <kernel-team@fb.com>, <wangnan0@huawei.com>,
        <bobo.shaobowang@huawei.com>, <yuehaibing@huawei.com>
Subject: [PATCH bpf-next v2 1/2] perf: stop using deprecated bpf_prog_load() API
Date:   Thu, 6 Jan 2022 12:00:31 -0800
Message-ID: <20220106200032.3067127-2-christylee@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220106200032.3067127-1-christylee@fb.com>
References: <20220106200032.3067127-1-christylee@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: gNhd7X1-Y1sSAFsKZiz9JMfXjV-72IrK
X-Proofpoint-ORIG-GUID: gNhd7X1-Y1sSAFsKZiz9JMfXjV-72IrK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-06_08,2022-01-06_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 bulkscore=0
 phishscore=0 spamscore=0 impostorscore=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201060126
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_prog_load() API is deprecated, remove perf's usage of the deprecated
function.

Signed-off-by: Christy Lee <christylee@fb.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/perf/tests/bpf.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

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
--=20
2.30.2

