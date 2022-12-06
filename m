Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83EBD644F56
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 00:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiLFXKS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 18:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiLFXKQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 18:10:16 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B50B42998
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 15:10:16 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B6LhDGv023764
        for <bpf@vger.kernel.org>; Tue, 6 Dec 2022 15:10:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=fl2kr2icsrEhwxHZenPSpliFcBg8UqVUB4c472SshEA=;
 b=K0tw5aKyuqlS5m2dwvbgHXXSII2lY32L+h0AJv/Qo46sq9/R+4VBnITFiEyR9gM5GuDT
 OIdKVDQiYTj0jBV49cEeGyzObgGUF/IAghd8Np/FFiroVsdwEE3sLVaawYfmjeSnaMZT
 8MxWIsn1eLaSQMuciYx6IVBgycyAB+R5BeE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m9sbt8bwm-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 06 Dec 2022 15:10:15 -0800
Received: from twshared8047.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 6 Dec 2022 15:10:10 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id A868B120B3760; Tue,  6 Dec 2022 15:10:02 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next 01/13] bpf: Loosen alloc obj test in verifier's reg_btf_record
Date:   Tue, 6 Dec 2022 15:09:48 -0800
Message-ID: <20221206231000.3180914-2-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221206231000.3180914-1-davemarchevsky@fb.com>
References: <20221206231000.3180914-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 2uQjib2Cq-d_bpD9sSdJg2kf2X_Qx9Xw
X-Proofpoint-ORIG-GUID: 2uQjib2Cq-d_bpD9sSdJg2kf2X_Qx9Xw
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

btf->struct_meta_tab is populated by btf_parse_struct_metas in btf.c.
There, a BTF record is created for any type containing a spin_lock or
any next-gen datastructure node/head.

Currently, for non-MAP_VALUE types, reg_btf_record will only search for
a record using struct_meta_tab if the reg->type exactly matches
(PTR_TO_BTF_ID | MEM_ALLOC). This exact match is too strict: an
"allocated obj" type - returned from bpf_obj_new - might pick up other
flags while working its way through the program.

Loosen the check to be exact for base_type and just use MEM_ALLOC mask
for type_flag.

This patch is marked Fixes as the original intent of reg_btf_record was
unlikely to have been to fail finding btf_record for valid alloc obj
types with additional flags, some of which (e.g. PTR_UNTRUSTED)
are valid register type states for alloc obj independent of this series.
However, I didn't find a specific broken repro case outside of this
series' added functionality, so it's possible that nothing was
triggering this logic error before.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Fixes: 4e814da0d599 ("bpf: Allow locking bpf_spin_lock in allocated objec=
ts")
---
 kernel/bpf/verifier.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1d51bd9596da..67a13110bc22 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -451,6 +451,11 @@ static bool reg_type_not_null(enum bpf_reg_type type=
)
 		type =3D=3D PTR_TO_SOCK_COMMON;
 }
=20
+static bool type_is_ptr_alloc_obj(u32 type)
+{
+	return base_type(type) =3D=3D PTR_TO_BTF_ID && type_flag(type) & MEM_AL=
LOC;
+}
+
 static struct btf_record *reg_btf_record(const struct bpf_reg_state *reg=
)
 {
 	struct btf_record *rec =3D NULL;
@@ -458,7 +463,7 @@ static struct btf_record *reg_btf_record(const struct=
 bpf_reg_state *reg)
=20
 	if (reg->type =3D=3D PTR_TO_MAP_VALUE) {
 		rec =3D reg->map_ptr->record;
-	} else if (reg->type =3D=3D (PTR_TO_BTF_ID | MEM_ALLOC)) {
+	} else if (type_is_ptr_alloc_obj(reg->type)) {
 		meta =3D btf_find_struct_meta(reg->btf, reg->btf_id);
 		if (meta)
 			rec =3D meta->record;
--=20
2.30.2

