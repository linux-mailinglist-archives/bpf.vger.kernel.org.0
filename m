Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5295A6AEC
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 19:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbiH3Rgb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 13:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbiH3RgG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 13:36:06 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7209163B4E
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 10:32:44 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UG2Hxw010065
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 10:31:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=wCvW/O2CjKKP6QQJwp4qzYhnTiB7xx+PP49P3exZYb4=;
 b=NfWlK1DnShkPY12VbZ/NH/TpGkThXP1L57RR5Xhj31jZsJig9639sSOmDRGYF8tod1Xj
 P9DZ7/qbe4myaRGBL8NCNGqObftMRJlDqE5PxrlTazxVVOJ2d2hGx/AnadXdZow4W5V5
 350bLDvYXOeTOS5Y3cBA6gXnsYeYupvW9Sk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j94gye2dm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 10:31:23 -0700
Received: from twshared25017.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 30 Aug 2022 10:31:22 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id CB421CAD07AA; Tue, 30 Aug 2022 10:28:10 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [RFCv2 PATCH bpf-next 18/18] selftests/bpf: Rbtree static lock verification test changes
Date:   Tue, 30 Aug 2022 10:27:59 -0700
Message-ID: <20220830172759.4069786-19-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220830172759.4069786-1-davemarchevsky@fb.com>
References: <20220830172759.4069786-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: POZU6oMc1vCgKr2HIJO73IdMlppZflSi
X-Proofpoint-GUID: POZU6oMc1vCgKr2HIJO73IdMlppZflSi
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

These are test chagnes corresponding to commit "bpf: Check rbtree lock
held during verification". They should be squashed with other test
changes, but are left unsquashed as part of RFCv2 to ease tossing them
piecemeal if associated functionality is dropped.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 .../selftests/bpf/prog_tests/rbtree_map.c     | 32 +------------------
 1 file changed, 1 insertion(+), 31 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/rbtree_map.c b/tools/=
testing/selftests/bpf/prog_tests/rbtree_map.c
index 7634a2d93f0b..07bc2780854c 100644
--- a/tools/testing/selftests/bpf/prog_tests/rbtree_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/rbtree_map.c
@@ -19,6 +19,7 @@ static struct {
 	{"rb_node__two_alloc_one_add", "Unreleased reference id=3D2 alloc_insn=3D=
3"},
 	{"rb_node__remove_no_free", "Unreleased reference id=3D6 alloc_insn=3D2=
6"},
 	{"rb_tree__add_wrong_type", "rbtree: R2 is of type task_struct but node=
_data is expected"},
+	{"add_node__no_lock", "lock associated with rbtree is not held"},
 	{"rb_tree__conditional_release_helper_usage",
 		"R2 type=3Dptr_cond_rel_ expected=3Dptr_"},
 };
@@ -96,37 +97,6 @@ void test_rbtree_map_alloc_node__size_too_small(void)
 	rbtree_map_fail__destroy(skel);
 }
=20
-void test_rbtree_map_add_node__no_lock(void)
-{
-	struct rbtree_map_fail *skel;
-	struct bpf_program *prog;
-	struct bpf_link *link;
-	int err;
-
-	skel =3D rbtree_map_fail__open();
-	if (!ASSERT_OK_PTR(skel, "rbtree_map_fail__open"))
-		goto cleanup;
-
-	prog =3D skel->progs.add_node__no_lock;
-	bpf_program__set_autoload(prog, true);
-
-	err =3D rbtree_map_fail__load(skel);
-	if (!ASSERT_OK(err, "unexpected load fail"))
-		goto cleanup;
-
-	link =3D bpf_program__attach(skel->progs.add_node__no_lock);
-	if (!ASSERT_OK_PTR(link, "link"))
-		goto cleanup;
-
-	syscall(SYS_getpgid);
-
-	ASSERT_EQ(skel->bss->no_lock_add__fail, 1, "alloc_fail");
-
-	bpf_link__destroy(link);
-cleanup:
-	rbtree_map_fail__destroy(skel);
-}
-
 void test_rbtree_map_prog_load_fail(void)
 {
 	int i;
--=20
2.30.2

