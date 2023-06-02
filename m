Return-Path: <bpf+bounces-1640-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC06171F85E
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 04:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 976BE2819A5
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 02:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A9915BB;
	Fri,  2 Jun 2023 02:27:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138F015A3
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 02:27:07 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1405318D
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 19:27:01 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 351NtdPt019778
	for <bpf@vger.kernel.org>; Thu, 1 Jun 2023 19:27:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=+Q5M06ZRuB/Ny2GViAb654mq7R5hQJIac26GyJ/9MR8=;
 b=LZvlN1wsDekKs5vZUN9oAJi8orkk4eZ+Lp0P0qKyNgUcb7wGWhNyi0c4uqRFSdKMf1RS
 2Gv7pAobXmU3jrC0u2tVaZ2LorNY2KtsZb82llBDueZOPOUK8co4dVgDQZiKDlqejc2M
 jAEXlUfS0ZDctR0PNdtgJUHkOn3Lft0Ki2s= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qxt1s6cvt-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 01 Jun 2023 19:27:01 -0700
Received: from twshared35445.38.frc1.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 1 Jun 2023 19:27:00 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id C4AFC1EF7C8C0; Thu,  1 Jun 2023 19:26:53 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 3/9] bpf: Fix __bpf_{list,rbtree}_add's beginning-of-node calculation
Date: Thu, 1 Jun 2023 19:26:41 -0700
Message-ID: <20230602022647.1571784-4-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602022647.1571784-1-davemarchevsky@fb.com>
References: <20230602022647.1571784-1-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: DnI0TbZEndiWZRsVHIJkl87Bso9Tbmdb
X-Proofpoint-GUID: DnI0TbZEndiWZRsVHIJkl87Bso9Tbmdb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Given the pointer to struct bpf_{rb,list}_node within a local kptr and
the byte offset of that field within the kptr struct, the calculation cha=
nged
by this patch is meant to find the beginning of the kptr so that it can
be passed to bpf_obj_drop.

Unfortunately instead of doing

  ptr_to_kptr =3D ptr_to_node_field - offset_bytes

the calculation is erroneously doing

  ptr_to_ktpr =3D ptr_to_node_field - (offset_bytes * sizeof(struct bpf_r=
b_node))

or the bpf_list_node equivalent.

This patch fixes the calculation.

Fixes: d2dcc67df910 ("bpf: Migrate bpf_rbtree_add and bpf_list_push_{fron=
t,back} to possibly fail")
Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 kernel/bpf/helpers.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 4ef4c4f8a355..a4e437eabcb4 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1950,7 +1950,7 @@ static int __bpf_list_add(struct bpf_list_node *nod=
e, struct bpf_list_head *head
 		INIT_LIST_HEAD(h);
 	if (!list_empty(n)) {
 		/* Only called from BPF prog, no need to migrate_disable */
-		__bpf_obj_drop_impl(n - off, rec);
+		__bpf_obj_drop_impl((void *)n - off, rec);
 		return -EINVAL;
 	}
=20
@@ -2032,7 +2032,7 @@ static int __bpf_rbtree_add(struct bpf_rb_root *roo=
t, struct bpf_rb_node *node,
=20
 	if (!RB_EMPTY_NODE(n)) {
 		/* Only called from BPF prog, no need to migrate_disable */
-		__bpf_obj_drop_impl(n - off, rec);
+		__bpf_obj_drop_impl((void *)n - off, rec);
 		return -EINVAL;
 	}
=20
--=20
2.34.1


