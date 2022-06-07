Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658F453539C
	for <lists+bpf@lfdr.de>; Thu, 26 May 2022 20:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347549AbiEZSzH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 May 2022 14:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348643AbiEZSzG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 May 2022 14:55:06 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63F6C5DBD
        for <bpf@vger.kernel.org>; Thu, 26 May 2022 11:55:05 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24QIoAml007469
        for <bpf@vger.kernel.org>; Thu, 26 May 2022 11:55:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=hP7vab3XucXlSSWa1ouRRYC68wbPXsDW1MkLe9PrGH8=;
 b=VBJ8jI7oESeqFUgiJfbMi8U2pUhn/RouOvnd0FzUD6YrLtvKM7sS4i8zXdepAww7kQDo
 tcGiYwwtis0zWPFwYzgOrCEsKYtJBf/PQH109c8Gh7Rc+1SSfazB7AdQNPQNtvqEeY2C
 wUZQwm6Kotbp3wtI0MqDZF4jV3YArvFcTU8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g93upqamy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 26 May 2022 11:55:05 -0700
Received: from twshared26317.07.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 26 May 2022 11:55:03 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 65C28AD83CE5; Thu, 26 May 2022 11:54:53 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v3 04/18] libbpf: Refactor btf__add_enum() for future code sharing
Date:   Thu, 26 May 2022 11:54:53 -0700
Message-ID: <20220526185453.2547758-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220526185432.2545879-1-yhs@fb.com>
References: <20220526185432.2545879-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 9BfGitY6qiyypFuPQKEGt-hSiPsqIdAh
X-Proofpoint-ORIG-GUID: 9BfGitY6qiyypFuPQKEGt-hSiPsqIdAh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-26_10,2022-05-25_02,2022-02-23_01
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Refactor btf__add_enum() function to create a separate
function btf_add_enum_common() so later the common function
can be used to add enum64 btf type. There is no functionality
change for this patch.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/lib/bpf/btf.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index bb1e06eb1eca..9dd7f886732a 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -2115,20 +2115,8 @@ int btf__add_field(struct btf *btf, const char *na=
me, int type_id,
 	return 0;
 }
=20
-/*
- * Append new BTF_KIND_ENUM type with:
- *   - *name* - name of the enum, can be NULL or empty for anonymous enu=
ms;
- *   - *byte_sz* - size of the enum, in bytes.
- *
- * Enum initially has no enum values in it (and corresponds to enum forw=
ard
- * declaration). Enumerator values can be added by btf__add_enum_value()
- * immediately after btf__add_enum() succeeds.
- *
- * Returns:
- *   - >0, type ID of newly added BTF type;
- *   - <0, on error.
- */
-int btf__add_enum(struct btf *btf, const char *name, __u32 byte_sz)
+static int btf_add_enum_common(struct btf *btf, const char *name, __u32 =
byte_sz,
+			       bool is_signed, __u8 kind)
 {
 	struct btf_type *t;
 	int sz, name_off =3D 0;
@@ -2153,12 +2141,30 @@ int btf__add_enum(struct btf *btf, const char *na=
me, __u32 byte_sz)
=20
 	/* start out with vlen=3D0; it will be adjusted when adding enum values=
 */
 	t->name_off =3D name_off;
-	t->info =3D btf_type_info(BTF_KIND_ENUM, 0, 0);
+	t->info =3D btf_type_info(kind, 0, is_signed);
 	t->size =3D byte_sz;
=20
 	return btf_commit_type(btf, sz);
 }
=20
+/*
+ * Append new BTF_KIND_ENUM type with:
+ *   - *name* - name of the enum, can be NULL or empty for anonymous enu=
ms;
+ *   - *byte_sz* - size of the enum, in bytes.
+ *
+ * Enum initially has no enum values in it (and corresponds to enum forw=
ard
+ * declaration). Enumerator values can be added by btf__add_enum_value()
+ * immediately after btf__add_enum() succeeds.
+ *
+ * Returns:
+ *   - >0, type ID of newly added BTF type;
+ *   - <0, on error.
+ */
+int btf__add_enum(struct btf *btf, const char *name, __u32 byte_sz)
+{
+	return btf_add_enum_common(btf, name, byte_sz, false, BTF_KIND_ENUM);
+}
+
 /*
  * Append new enum value for the current ENUM type with:
  *   - *name* - name of the enumerator value, can't be NULL or empty;
--=20
2.30.2

