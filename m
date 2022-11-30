Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A3563E0B4
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 20:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiK3TZ2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 14:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiK3TZS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 14:25:18 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55151862C4
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 11:25:17 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AUD0HKr002620
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 11:25:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=c21/RxjJ+X/zCJbYrlHYzEi17+2XCtf38q7aL5Vgz00=;
 b=k34LSJcUZk0M0fcxjXabVyKNw0LvXCsR9gzUbs8MIWKgBPqPMAbBehpiB2HnmbhX9mEf
 zjk8t3KxRaF+PDiyY1iXQUrk2J4hkvyNW0bqFKq7m0liHnnlzI29dOIRcwtbpqNmT/z3
 y0eDUEL4h39lisgHAOzFhfHgeYDpQ7PhUD0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m67nvkfxt-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 11:25:16 -0800
Received: from twshared13940.35.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 30 Nov 2022 11:25:15 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id F3D4411AE2D56; Wed, 30 Nov 2022 11:25:12 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Validate multiple ref release_on_unlock logic
Date:   Wed, 30 Nov 2022 11:25:05 -0800
Message-ID: <20221130192505.914566-2-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221130192505.914566-1-davemarchevsky@fb.com>
References: <20221130192505.914566-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: W5MQFiYN1Pf9692Z88VZ26c6GcSKrRHW
X-Proofpoint-GUID: W5MQFiYN1Pf9692Z88VZ26c6GcSKrRHW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-30_04,2022-11-30_02,2022-06-22_01
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

