Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E69424EC8
	for <lists+bpf@lfdr.de>; Thu,  7 Oct 2021 10:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240580AbhJGIMl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Oct 2021 04:12:41 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52854 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240554AbhJGIMl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 7 Oct 2021 04:12:41 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1977pBJl022394
        for <bpf@vger.kernel.org>; Thu, 7 Oct 2021 01:10:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=LlkS+INbyTIUOHMsYGBp8TSkzoSh01NS6ugqXi2mfAM=;
 b=QwEv720eG4a1op6vEEcBuQ1KBKkVfXJ5mPPjL7y5LvglhU8oNTJdT3tsaXuq7CaovEWb
 8HUiLlmA7RGKaYjOvakOBJr+MUAnhHpeIaN+SDE9XdY6oVNoITKWN/q7T0CsGnOw5npS
 30wW7VHK02GnoreCcQ63zyllAJIWyhEx2d4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bhvv403hy-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 07 Oct 2021 01:10:47 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 7 Oct 2021 01:10:08 -0700
Received: by devbig030.frc3.facebook.com (Postfix, from userid 158236)
        id ED0557AA99B0; Thu,  7 Oct 2021 01:10:03 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: add verif_stats test
Date:   Thu, 7 Oct 2021 01:09:52 -0700
Message-ID: <20211007080952.1255615-3-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211007080952.1255615-1-davemarchevsky@fb.com>
References: <20211007080952.1255615-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: f79wh2K_v5HcQyHKCLgqvbGy7PBJ9XrZ
X-Proofpoint-GUID: f79wh2K_v5HcQyHKCLgqvbGy7PBJ9XrZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-06_04,2021-10-07_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=769
 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110070055
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

verif_insn_processed field was added to response of bpf_obj_get_info_by_f=
d
call on a prog. Confirm that it's being populated by loading a simple
program and asking for its info.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 .../selftests/bpf/prog_tests/verif_stats.c    | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/verif_stats.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verif_stats.c b/tools=
/testing/selftests/bpf/prog_tests/verif_stats.c
new file mode 100644
index 000000000000..53ed2239ecad
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/verif_stats.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+
+#include <test_progs.h>
+
+#include "trace_vprintk.lskel.h"
+
+void test_verif_stats(void)
+{
+	__u32 len =3D sizeof(struct bpf_prog_info);
+	struct bpf_prog_info info =3D {};
+	struct trace_vprintk *skel;
+	int err;
+
+	skel =3D trace_vprintk__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "trace_vprintk__open_and_load"))
+		goto cleanup;
+
+	if (!ASSERT_GT(skel->progs.sys_enter.prog_fd, 0, "sys_enter_fd > 0"))
+		goto cleanup;
+
+	err =3D bpf_obj_get_info_by_fd(skel->progs.sys_enter.prog_fd, &info, &l=
en);
+	if (!ASSERT_OK(err, "bpf_obj_get_info_by_fd"))
+		goto cleanup;
+
+	if (!ASSERT_GT(info.verif_insn_processed, 0, "verif_stats.insn_processe=
d"))
+		goto cleanup;
+
+cleanup:
+	trace_vprintk__destroy(skel);
+}
--=20
2.30.2

