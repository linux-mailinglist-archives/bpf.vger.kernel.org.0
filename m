Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD58644F55
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 00:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiLFXKN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 18:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiLFXKM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 18:10:12 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AF14298E
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 15:10:11 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B6LhDGo023764
        for <bpf@vger.kernel.org>; Tue, 6 Dec 2022 15:10:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=UPfqMIeSSu1MikIa77B5XLfGlxDRi8Svjkb+c38YdQ8=;
 b=hiFmp+2IqrJND/CVvEbf7ARRs7v7dYzQ/7hwc6Vxx7dzAPvfAEX2hFU5okaCT6Ml04On
 c4gLzh5eC4mYHCkskoVObbZrctP8H5/lsG09JGe/W8qXoISg38xo7KMr9711dN7KniJV
 Mksn7xHxXwAzgE0hMiy6ZUB6pxCYZrGV5PI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m9sbt8bwm-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 06 Dec 2022 15:10:11 -0800
Received: from twshared8047.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 6 Dec 2022 15:10:08 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 52EFE120B3762; Tue,  6 Dec 2022 15:10:03 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next 02/13] bpf: map_check_btf should fail if btf_parse_fields fails
Date:   Tue, 6 Dec 2022 15:09:49 -0800
Message-ID: <20221206231000.3180914-3-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221206231000.3180914-1-davemarchevsky@fb.com>
References: <20221206231000.3180914-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 3irBWWqr4eRC1PvLL3gEo35BPFNJ_Hf_
X-Proofpoint-ORIG-GUID: 3irBWWqr4eRC1PvLL3gEo35BPFNJ_Hf_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_12,2022-12-06_01,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

map_check_btf calls btf_parse_fields to create a btf_record for its
value_type. If there are no special fields in the value_type
btf_parse_fields returns NULL, whereas if there special value_type
fields but they are invalid in some way an error is returned.

An example invalid state would be:

  struct node_data {
    struct bpf_rb_node node;
    int data;
  };

  private(A) struct bpf_spin_lock glock;
  private(A) struct bpf_list_head ghead __contains(node_data, node);

groot should be invalid as its __contains tag points to a field with
type !=3D "bpf_list_node".

Before this patch, such a scenario would result in btf_parse_fields
returning an error ptr, subsequent !IS_ERR_OR_NULL check failing,
and btf_check_and_fixup_fields returning 0, which would then be
returned by map_check_btf.

After this patch's changes, -EINVAL would be returned by map_check_btf
and the map would correctly fail to load.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Fixes: aa3496accc41 ("bpf: Refactor kptr_off_tab into btf_record")
---
 kernel/bpf/syscall.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 35972afb6850..c3599a7902f0 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1007,7 +1007,10 @@ static int map_check_btf(struct bpf_map *map, cons=
t struct btf *btf,
 	map->record =3D btf_parse_fields(btf, value_type,
 				       BPF_SPIN_LOCK | BPF_TIMER | BPF_KPTR | BPF_LIST_HEAD,
 				       map->value_size);
-	if (!IS_ERR_OR_NULL(map->record)) {
+	if (IS_ERR(map->record))
+		return -EINVAL;
+
+	if (map->record) {
 		int i;
=20
 		if (!bpf_capable()) {
--=20
2.30.2

