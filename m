Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3A553F60E
	for <lists+bpf@lfdr.de>; Tue,  7 Jun 2022 08:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiFGG00 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Jun 2022 02:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236971AbiFGG0Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Jun 2022 02:26:25 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4375FC9EC9
        for <bpf@vger.kernel.org>; Mon,  6 Jun 2022 23:26:24 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 25751Vlt022301
        for <bpf@vger.kernel.org>; Mon, 6 Jun 2022 23:26:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=rXTACrWXOtzIm3gt0Uw5uUy/Q5dse8SX457L7QzCwok=;
 b=mTTU+Rn/HgFumAgEoZvstiUdpjgRRYI1ELqV3DFHcexF1peFtaSN5rQMFPyM8MVdy/s0
 r+7GdNg+HqLN3wmyfYqIjyJzBI8/YcWs+RjN6hRFSFc6Qi41nQC4eK+tBpxdFTnJ2n9C
 16BvE3r01lJSTLUth6SeySCNcze8a/DDHU4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3ghy4srgpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 06 Jun 2022 23:26:23 -0700
Received: from twshared34609.14.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 6 Jun 2022 23:26:22 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id EFBE1B520FA8; Mon,  6 Jun 2022 23:26:15 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v5 04/17] libbpf: Refactor btf__add_enum() for future code sharing
Date:   Mon, 6 Jun 2022 23:26:15 -0700
Message-ID: <20220607062615.3718063-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220607062554.3716237-1-yhs@fb.com>
References: <20220607062554.3716237-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: rhIiMlyNX7aWNPDexv-mYMHqdKsNYJAb
X-Proofpoint-GUID: rhIiMlyNX7aWNPDexv-mYMHqdKsNYJAb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-07_02,2022-06-03_01,2022-02-23_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 2e9c23bcdc67..1972d0c65e0c 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -2129,20 +2129,8 @@ int btf__add_field(struct btf *btf, const char *na=
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
@@ -2167,12 +2155,30 @@ int btf__add_enum(struct btf *btf, const char *na=
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

