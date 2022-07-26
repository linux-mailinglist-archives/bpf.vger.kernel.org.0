Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF53581834
	for <lists+bpf@lfdr.de>; Tue, 26 Jul 2022 19:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbiGZRON (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jul 2022 13:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiGZROM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jul 2022 13:14:12 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BBF1D0EF
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 10:14:11 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26QFHd0J009228
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 10:14:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=10bJF/UO+/WL/Rw/NKaUn84Rm8AdcfqOzjCswxW51pA=;
 b=HmxeBmLah2zs0hnaqYLNa3G2czaI7D7547RSByrwxJ89i9/Dl1GGUqPEd1QVTb8BoUEq
 A/EqXtIoLekA3LrFvP74UlLJT0QyLJjlUj85Ei9O0+4pwhG0h5xWfFIdIFuX34WPu9pF
 dHo56ZV0A5EJIupXcZxDF1ZU+CAGC9+tnaY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hj592mwev-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 10:14:11 -0700
Received: from snc-exhub201.TheFacebook.com (2620:10d:c085:21d::7) by
 snc-exhub104.TheFacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 26 Jul 2022 10:14:09 -0700
Received: from twshared33626.07.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 26 Jul 2022 10:14:08 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 046ACD40E7F2; Tue, 26 Jul 2022 10:11:35 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [RFC PATCH bpf-next 1/7] bpf: Always return corresponding btf_type in __get_type_size()
Date:   Tue, 26 Jul 2022 10:11:34 -0700
Message-ID: <20220726171134.709453-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220726171129.708371-1-yhs@fb.com>
References: <20220726171129.708371-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: dikgOw3oArLH37CUFnMsrhOJCB-9zM-_
X-Proofpoint-GUID: dikgOw3oArLH37CUFnMsrhOJCB-9zM-_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_05,2022-07-26_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently in funciton __get_type_size(), the corresponding
btf_type is returned only in invalid cases. Let us always
return btf_type regardless of valid or invalid cases.
Such a new functionality will be used in subsequent patches.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/btf.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 7ac971ea98d1..3bbcc985a651 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5864,26 +5864,25 @@ bool btf_struct_ids_match(struct bpf_verifier_log=
 *log,
 }
=20
 static int __get_type_size(struct btf *btf, u32 btf_id,
-			   const struct btf_type **bad_type)
+			   const struct btf_type **ret_type)
 {
 	const struct btf_type *t;
=20
+	*ret_type =3D btf_type_by_id(btf, 0);
 	if (!btf_id)
 		/* void */
 		return 0;
 	t =3D btf_type_by_id(btf, btf_id);
 	while (t && btf_type_is_modifier(t))
 		t =3D btf_type_by_id(btf, t->type);
-	if (!t) {
-		*bad_type =3D btf_type_by_id(btf, 0);
+	if (!t)
 		return -EINVAL;
-	}
+	*ret_type =3D t;
 	if (btf_type_is_ptr(t))
 		/* kernel size of pointer. Not BPF's size of pointer*/
 		return sizeof(void *);
 	if (btf_type_is_int(t) || btf_is_any_enum(t))
 		return t->size;
-	*bad_type =3D t;
 	return -EINVAL;
 }
=20
--=20
2.30.2

