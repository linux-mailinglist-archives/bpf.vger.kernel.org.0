Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35E863F78B
	for <lists+bpf@lfdr.de>; Thu,  1 Dec 2022 19:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbiLASf1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Dec 2022 13:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiLASf0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Dec 2022 13:35:26 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697FDB847F
        for <bpf@vger.kernel.org>; Thu,  1 Dec 2022 10:35:16 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B1IZ8Mr015936
        for <bpf@vger.kernel.org>; Thu, 1 Dec 2022 10:35:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=c21/RxjJ+X/zCJbYrlHYzEi17+2XCtf38q7aL5Vgz00=;
 b=Sht788IMeurSYcibrkHKlXvvI4V+oukmKlhanba3HBH9IyXMaFvOk451QvCvRJkzPT4G
 PO8VNGz9N9USlpHJbSi4nc79ICPSxikPLsvQMt5+lKW/yDK0HMmM6DDyLuh8nG+t//K/
 39f18yLnx5CmVhW7vSONL3EKUrc4tuxjVQk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m6mbeemgx-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 01 Dec 2022 10:35:15 -0800
Received: from twshared2003.08.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Dec 2022 10:34:18 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id A81CA11BCBE46; Thu,  1 Dec 2022 10:34:10 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@meta.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH v2 bpf-next 2/2] selftests/bpf: Validate multiple ref release_on_unlock logic
Date:   Thu, 1 Dec 2022 10:34:06 -0800
Message-ID: <20221201183406.1203621-2-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221201183406.1203621-1-davemarchevsky@fb.com>
References: <20221201183406.1203621-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 2vegnSQ_Qo4L78W0dDOzLqgsXRqTeP8I
X-Proofpoint-GUID: 2vegnSQ_Qo4L78W0dDOzLqgsXRqTeP8I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_12,2022-12-01_01,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Modify list_push_pop_multiple to alloc and insert nodes 2-at-a-time.
Without the previous patch's fix, this block of code:

  bpf_spin_lock(lock);
  bpf_list_push_front(head, &f[i]->node);
  bpf_list_push_front(head, &f[i + 1]->node);
  bpf_spin_unlock(lock);

would fail check_reference_leak check as release_on_unlock logic would mi=
ss
a ref that should've been released.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/progs/linked_list.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/linked_list.c b/tools/test=
ing/selftests/bpf/progs/linked_list.c
index 2c7b615c6d41..4ad88da5cda2 100644
--- a/tools/testing/selftests/bpf/progs/linked_list.c
+++ b/tools/testing/selftests/bpf/progs/linked_list.c
@@ -99,13 +99,28 @@ int list_push_pop_multiple(struct bpf_spin_lock *lock=
, struct bpf_list_head *hea
 	struct foo *f[8], *pf;
 	int i;
=20
-	for (i =3D 0; i < ARRAY_SIZE(f); i++) {
+	/* Loop following this check adds nodes 2-at-a-time in order to
+	 * validate multiple release_on_unlock release logic
+	 */
+	if (ARRAY_SIZE(f) % 2)
+		return 10;
+
+	for (i =3D 0; i < ARRAY_SIZE(f); i +=3D 2) {
 		f[i] =3D bpf_obj_new(typeof(**f));
 		if (!f[i])
 			return 2;
 		f[i]->data =3D i;
+
+		f[i + 1] =3D bpf_obj_new(typeof(**f));
+		if (!f[i + 1]) {
+			bpf_obj_drop(f[i]);
+			return 9;
+		}
+		f[i + 1]->data =3D i + 1;
+
 		bpf_spin_lock(lock);
 		bpf_list_push_front(head, &f[i]->node);
+		bpf_list_push_front(head, &f[i + 1]->node);
 		bpf_spin_unlock(lock);
 	}
=20
--=20
2.30.2

