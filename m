Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AED6EA51F
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 09:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjDUHoo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 03:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjDUHon (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 03:44:43 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BCC9E
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 00:44:41 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33L0bZLj028961
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 00:44:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=t39WmlztQWJ40GtgJXmHkCcNLcYVRXIdNJ2KzEDVzQA=;
 b=quDKSUlBEFvHBl+oxi7EqtsUhSUHJkBTqet/23EmsO7o0iXmJ8mM7yOrz1MSr5QggPco
 FmjkpM0YSPP314/XcNzrAFqZ+NF1pC8P3hHZjcg2m+DAwmKW2s3ug17L0HOn+koAFeIE
 uqISnCc4PihO9bz3lj7JwbtqfF3En/l9K4c= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q3g3p9nh0-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 00:44:40 -0700
Received: from twshared34392.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 00:44:39 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 0C5051C857B1D; Fri, 21 Apr 2023 00:44:32 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Florian Westphal <fw@strlen.de>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next] bpf: Fix bpf_refcount_acquire's refcount_t address calculation
Date:   Fri, 21 Apr 2023 00:44:31 -0700
Message-ID: <20230421074431.3548349-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: k1UYywY2FgrzpyTe3eNPPMHq3rTMmb9J
X-Proofpoint-ORIG-GUID: k1UYywY2FgrzpyTe3eNPPMHq3rTMmb9J
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-21_02,2023-04-20_01,2023-02-09_01
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When calculating the address of the refcount_t struct within a local
kptr, bpf_refcount_acquire_impl should add refcount_off bytes to the
address of the local kptr. Due to some missing parens, the function is
incorrectly adding sizeof(refcount_t) * refcount_off bytes. This patch
fixes the calculation.

Due to the incorrect calculation, bpf_refcount_acquire_impl was trying
to refcount_inc some memory well past the end of local kptrs, resulting
in kasan and refcount complaints, as reported in [0]. In that thread,
Florian and Eduard discovered that bpf selftests written in the new
style - with __success and an expected __retval, specifically - were not
actually being run. As a result, selftests added in bpf_refcount series
weren't really exercising this behavior, and thus didn't unearth the
bug.

With this fixed behavior it's safe to revert commit 7c4b96c00043
("selftests/bpf: disable program test run for progs/refcounted_kptr.c"),
this patch does so.

  [0]: https://lore.kernel.org/bpf/ZEEp+j22imoN6rn9@strlen.de/

Reported-by: Florian Westphal <fw@strlen.de>
Reported-by: Eduard Zingerman <eddyz87@gmail.com>
Fixes: 7c50b1cb76ac ("bpf: Add bpf_refcount_acquire kfunc")
Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 kernel/bpf/helpers.c                                | 2 +-
 tools/testing/selftests/bpf/progs/refcounted_kptr.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 00e5fb0682ac..8d368fa353f9 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1925,7 +1925,7 @@ __bpf_kfunc void *bpf_refcount_acquire_impl(void *p__=
refcounted_kptr, void *meta
 	/* Could just cast directly to refcount_t *, but need some code using
 	 * bpf_refcount type so that it is emitted in vmlinux BTF
 	 */
-	ref =3D (struct bpf_refcount *)p__refcounted_kptr + meta->record->refcoun=
t_off;
+	ref =3D (struct bpf_refcount *)(p__refcounted_kptr + meta->record->refcou=
nt_off);
=20
 	refcount_inc((refcount_t *)ref);
 	return (void *)p__refcounted_kptr;
diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tools/te=
sting/selftests/bpf/progs/refcounted_kptr.c
index b6b2d4f97b19..1d348a225140 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
@@ -219,7 +219,7 @@ static long __read_from_unstash(int idx)
 #define INSERT_READ_BOTH(rem_tree, rem_list, desc)			\
 SEC("tc")								\
 __description(desc)							\
-__success /* __retval(579) temporarily disabled */			\
+__success __retval(579)							\
 long insert_and_remove_tree_##rem_tree##_list_##rem_list(void *ctx)	\
 {									\
 	long err, tree_data, list_data;					\
@@ -258,7 +258,7 @@ INSERT_READ_BOTH(false, true, "insert_read_both: remove=
 from list");
 #define INSERT_READ_BOTH(rem_tree, rem_list, desc)			\
 SEC("tc")								\
 __description(desc)							\
-__success /* __retval(579) temporarily disabled */			\
+__success __retval(579)							\
 long insert_and_remove_lf_tree_##rem_tree##_list_##rem_list(void *ctx)	\
 {									\
 	long err, tree_data, list_data;					\
@@ -296,7 +296,7 @@ INSERT_READ_BOTH(false, true, "insert_read_both_list_fi=
rst: remove from list");
 #define INSERT_DOUBLE_READ_AND_DEL(read_fn, read_root, desc)		\
 SEC("tc")								\
 __description(desc)							\
-__success /* temporarily __retval(-1) disabled */			\
+__success __retval(-1)							\
 long insert_double_##read_fn##_and_del_##read_root(void *ctx)		\
 {									\
 	long err, list_data;						\
@@ -329,7 +329,7 @@ INSERT_DOUBLE_READ_AND_DEL(__read_from_list, head, "ins=
ert_double_del: 2x read-a
 #define INSERT_STASH_READ(rem_tree, desc)				\
 SEC("tc")								\
 __description(desc)							\
-__success /* __retval(84) temporarily disabled */			\
+__success __retval(84)							\
 long insert_rbtree_and_stash__del_tree_##rem_tree(void *ctx)		\
 {									\
 	long err, tree_data, map_data;					\
--=20
2.34.1

