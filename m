Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC3B6B2C82
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 19:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjCISBb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Mar 2023 13:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjCISBa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 13:01:30 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A632FCBCC
        for <bpf@vger.kernel.org>; Thu,  9 Mar 2023 10:01:29 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 329CjYqt013792
        for <bpf@vger.kernel.org>; Thu, 9 Mar 2023 10:01:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=a39i4zGg8gUbtwHvrRdNi6WzgHX8t98ugAqwV2SgAYA=;
 b=Q1YlglypD9g2PY8UfhEjJl/jkNGwgPD0+OVmkCOoFmG1RQuwFz2o7HQb2lbShOVSyMYi
 JSZJQku0gsPIzp4/eIYFMQqkyxnVxIvjXsZryuuPLqd9fbRxCtug7zHQosHLVUK/JF3n
 nfw4P+F+L+RvesNaZ6uKv8OTpZVU/mAPp0s= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p7be33d65-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 09 Mar 2023 10:01:28 -0800
Received: from twshared52565.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 9 Mar 2023 10:01:23 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 0AE3C18E84D3F; Thu,  9 Mar 2023 10:01:16 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v1 bpf-next 3/6] bpf: Change btf_record_find enum parameter to field_mask
Date:   Thu, 9 Mar 2023 10:01:08 -0800
Message-ID: <20230309180111.1618459-4-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230309180111.1618459-1-davemarchevsky@fb.com>
References: <20230309180111.1618459-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: hamuTA7JY1bMV-I4sKjYlSVgyuqyinFd
X-Proofpoint-GUID: hamuTA7JY1bMV-I4sKjYlSVgyuqyinFd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_09,2023-03-09_01,2023-02-09_01
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

btf_record_find's 3rd parameter can be multiple enum btf_field_type's
masked together. The function is called with BPF_KPTR in two places in
verifier.c, so it works with masked values already.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 include/linux/bpf.h  | 2 +-
 kernel/bpf/syscall.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e64ff1e89fb2..3a38db315f7f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1925,7 +1925,7 @@ void bpf_prog_free_id(struct bpf_prog *prog);
 void bpf_map_free_id(struct bpf_map *map);
=20
 struct btf_field *btf_record_find(const struct btf_record *rec,
-				  u32 offset, enum btf_field_type type);
+				  u32 offset, u32 field_mask);
 void btf_record_free(struct btf_record *rec);
 void bpf_map_free_record(struct bpf_map *map);
 struct btf_record *btf_record_dup(const struct btf_record *rec);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index f406dfa13792..cc4b7684910c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -520,14 +520,14 @@ static int btf_field_cmp(const void *a, const void =
*b)
 }
=20
 struct btf_field *btf_record_find(const struct btf_record *rec, u32 offs=
et,
-				  enum btf_field_type type)
+				  u32 field_mask)
 {
 	struct btf_field *field;
=20
-	if (IS_ERR_OR_NULL(rec) || !(rec->field_mask & type))
+	if (IS_ERR_OR_NULL(rec) || !(rec->field_mask & field_mask))
 		return NULL;
 	field =3D bsearch(&offset, rec->fields, rec->cnt, sizeof(rec->fields[0]=
), btf_field_cmp);
-	if (!field || !(field->type & type))
+	if (!field || !(field->type & field_mask))
 		return NULL;
 	return field;
 }
--=20
2.34.1

