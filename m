Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64FA45A6B43
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 19:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiH3RwB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 13:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiH3Rvl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 13:51:41 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F84A12E4C7
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 10:48:13 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UApEhV031288
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 10:35:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Kp7Gg9qS97Vp+LREyK38K5z0NO8den/G9Yf0ejc2J7g=;
 b=C4ZdScggXsYb7vzwpsCzP5ybmpXOK1hJTXhf5Q1MIgKae/0Kdg4bhtBHFUfooXs88y3T
 rQri01gww/oYKHaAW+OvUDb/79mC4+mx9osWd/rfmAKhBbYN1ZRkq6m9wYiGfDMN/PvL
 7LpthAtGgwV5txLgRIy88AY4Hx/o8CCoHeg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j9h5djsfe-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 10:35:18 -0700
Received: from twshared8288.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 30 Aug 2022 10:35:18 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 6F6C5CAD079F; Tue, 30 Aug 2022 10:28:10 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [RFCv2 PATCH bpf-next 16/18] selftests/bpf: Declarative lock definition test changes
Date:   Tue, 30 Aug 2022 10:27:57 -0700
Message-ID: <20220830172759.4069786-17-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220830172759.4069786-1-davemarchevsky@fb.com>
References: <20220830172759.4069786-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: ZlTbxFTYQ4RUHukQX92iamhu44OWxoY0
X-Proofpoint-ORIG-GUID: ZlTbxFTYQ4RUHukQX92iamhu44OWxoY0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_10,2022-08-30_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch contains test changes corresponding to the functional changes
in patch "bpf: Support declarative association of lock with rbtree map".
It will be squashed with other test patches, leaving in this state for
RFCv2 feedback.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 tools/testing/selftests/bpf/progs/rbtree_map.c       | 12 +++++++++---
 tools/testing/selftests/bpf/progs/rbtree_map_fail.c  |  9 ++++++++-
 .../selftests/bpf/progs/rbtree_map_load_fail.c       |  9 ++++++++-
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/rbtree_map.c b/tools/testi=
ng/selftests/bpf/progs/rbtree_map.c
index 0cd467838f6e..50f29b9a5b82 100644
--- a/tools/testing/selftests/bpf/progs/rbtree_map.c
+++ b/tools/testing/selftests/bpf/progs/rbtree_map.c
@@ -11,12 +11,18 @@ struct node_data {
 	__u32 two;
 };
=20
+long calls;
+struct bpf_spin_lock rbtree_lock SEC(".bss.private");
+
 struct {
 	__uint(type, BPF_MAP_TYPE_RBTREE);
 	__type(value, struct node_data);
-} rbtree SEC(".maps");
-
-long calls;
+	__array(lock, struct bpf_spin_lock);
+} rbtree SEC(".maps") =3D {
+	.lock =3D {
+		[0] =3D &rbtree_lock,
+	},
+};
=20
 static bool less(struct rb_node *a, const struct rb_node *b)
 {
diff --git a/tools/testing/selftests/bpf/progs/rbtree_map_fail.c b/tools/=
testing/selftests/bpf/progs/rbtree_map_fail.c
index 287c8db080d8..ab4002a8211c 100644
--- a/tools/testing/selftests/bpf/progs/rbtree_map_fail.c
+++ b/tools/testing/selftests/bpf/progs/rbtree_map_fail.c
@@ -11,10 +11,17 @@ struct node_data {
 	__u32 two;
 };
=20
+struct bpf_spin_lock rbtree_lock SEC(".bss.private");
+
 struct {
 	__uint(type, BPF_MAP_TYPE_RBTREE);
 	__type(value, struct node_data);
-} rbtree SEC(".maps");
+	__array(lock, struct bpf_spin_lock);
+} rbtree SEC(".maps") =3D {
+	.lock =3D {
+		[0] =3D &rbtree_lock,
+	},
+};
=20
 long calls;
=20
diff --git a/tools/testing/selftests/bpf/progs/rbtree_map_load_fail.c b/t=
ools/testing/selftests/bpf/progs/rbtree_map_load_fail.c
index 036558eedd66..5578769efa2f 100644
--- a/tools/testing/selftests/bpf/progs/rbtree_map_load_fail.c
+++ b/tools/testing/selftests/bpf/progs/rbtree_map_load_fail.c
@@ -14,11 +14,18 @@ struct node_data_no_rb_node {
 	__u64 seven;
 };
=20
+struct bpf_spin_lock rbtree_lock SEC(".bss.private");
+
 /* Should fail because value struct has no rb_node
  */
 struct {
 	__uint(type, BPF_MAP_TYPE_RBTREE);
 	__type(value, struct node_data_no_rb_node);
-} rbtree_fail_no_rb_node SEC(".maps");
+	__array(lock, struct bpf_spin_lock);
+} rbtree_fail_no_rb_node SEC(".maps") =3D {
+	.lock =3D {
+		[0] =3D &rbtree_lock,
+	},
+};
=20
 char _license[] SEC("license") =3D "GPL";
--=20
2.30.2

