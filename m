Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32D3E1A0620
	for <lists+bpf@lfdr.de>; Tue,  7 Apr 2020 07:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgDGFLa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Apr 2020 01:11:30 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42974 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726399AbgDGFLa (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 7 Apr 2020 01:11:30 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0375BS8W026500
        for <bpf@vger.kernel.org>; Mon, 6 Apr 2020 22:11:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=a8YM6assk3NxfE3+ekPhSI0ysUvfXI8Gd1mI32iwHtE=;
 b=NP++ywlNjStEI5auuFSA5PDr0UOy2DLjB0VYi0CRPmhN4L3SnCnzKv4AO7DRRaPu+hCo
 iOX6JA1tYV/vq3wXFjypvp93e1iYbbfepveWRwYist+ziidxQMV3v7etTN07olivHLKp
 PtJEtgaPtAPDg5U36KFVILJHVfuWtygS9Fo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 307a266yf5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2020 22:11:29 -0700
Received: from intmgw004.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Mon, 6 Apr 2020 22:11:24 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id 51FF83700D26; Mon,  6 Apr 2020 22:11:18 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kernel-team@fb.com>, <toke@redhat.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf 2/2] selftests/bpf: Add test for bpf_get_link_xdp_id
Date:   Mon, 6 Apr 2020 22:09:46 -0700
Message-ID: <2a9a6d1ce33b91ccc1aa3de6dba2d309f2062811.1586236080.git.rdna@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1586236080.git.rdna@fb.com>
References: <cover.1586236080.git.rdna@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-07_01:2020-04-07,2020-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=524
 malwarescore=0 suspectscore=15 priorityscore=1501 lowpriorityscore=0
 phishscore=0 spamscore=0 adultscore=0 impostorscore=0 clxscore=1015
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004070042
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add xdp_info selftest that makes sure that bpf_get_link_xdp_id returns
valid prog_id for different input modes:
* w/ and w/o flags when no program is attached;
* w/ and w/o flags when one program is attached.

Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 .../selftests/bpf/prog_tests/xdp_info.c       | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_info.c

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_info.c b/tools/te=
sting/selftests/bpf/prog_tests/xdp_info.c
new file mode 100644
index 000000000000..d2d7a283d72f
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_info.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/if_link.h>
+#include <test_progs.h>
+
+#define IFINDEX_LO 1
+
+void test_xdp_info(void)
+{
+	__u32 len =3D sizeof(struct bpf_prog_info), duration =3D 0, prog_id;
+	const char *file =3D "./xdp_dummy.o";
+	struct bpf_prog_info info =3D {};
+	struct bpf_object *obj;
+	int err, prog_fd;
+
+	/* Get prog_id for XDP_ATTACHED_NONE mode */
+
+	err =3D bpf_get_link_xdp_id(IFINDEX_LO, &prog_id, 0);
+	if (CHECK(err, "get_xdp_none", "errno=3D%d\n", errno))
+		return;
+	if (CHECK(prog_id, "prog_id_none", "unexpected prog_id=3D%u\n", prog_id=
))
+		return;
+
+	err =3D bpf_get_link_xdp_id(IFINDEX_LO, &prog_id, XDP_FLAGS_SKB_MODE);
+	if (CHECK(err, "get_xdp_none_skb", "errno=3D%d\n", errno))
+		return;
+	if (CHECK(prog_id, "prog_id_none_skb", "unexpected prog_id=3D%u\n",
+		  prog_id))
+		return;
+
+	/* Setup prog */
+
+	err =3D bpf_prog_load(file, BPF_PROG_TYPE_XDP, &obj, &prog_fd);
+	if (CHECK_FAIL(err))
+		return;
+
+	err =3D bpf_obj_get_info_by_fd(prog_fd, &info, &len);
+	if (CHECK(err, "get_prog_info", "errno=3D%d\n", errno))
+		goto out_close;
+
+	err =3D bpf_set_link_xdp_fd(IFINDEX_LO, prog_fd, XDP_FLAGS_SKB_MODE);
+	if (CHECK(err, "set_xdp_skb", "errno=3D%d\n", errno))
+		goto out_close;
+
+	/* Get prog_id for single prog mode */
+
+	err =3D bpf_get_link_xdp_id(IFINDEX_LO, &prog_id, 0);
+	if (CHECK(err, "get_xdp", "errno=3D%d\n", errno))
+		goto out;
+	if (CHECK(prog_id !=3D info.id, "prog_id", "prog_id not available\n"))
+		goto out;
+
+	err =3D bpf_get_link_xdp_id(IFINDEX_LO, &prog_id, XDP_FLAGS_SKB_MODE);
+	if (CHECK(err, "get_xdp_skb", "errno=3D%d\n", errno))
+		goto out;
+	if (CHECK(prog_id !=3D info.id, "prog_id_skb", "prog_id not available\n=
"))
+		goto out;
+
+	err =3D bpf_get_link_xdp_id(IFINDEX_LO, &prog_id, XDP_FLAGS_DRV_MODE);
+	if (CHECK(err, "get_xdp_drv", "errno=3D%d\n", errno))
+		goto out;
+	if (CHECK(prog_id, "prog_id_drv", "unexpected prog_id=3D%u\n", prog_id)=
)
+		goto out;
+
+out:
+	bpf_set_link_xdp_fd(IFINDEX_LO, -1, 0);
+out_close:
+	bpf_object__close(obj);
+}
--=20
2.24.1

