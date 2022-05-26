Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39355353A3
	for <lists+bpf@lfdr.de>; Thu, 26 May 2022 20:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348537AbiEZSz0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 May 2022 14:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348634AbiEZSzZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 May 2022 14:55:25 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A81CCC155
        for <bpf@vger.kernel.org>; Thu, 26 May 2022 11:55:24 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24QIo4dW028219
        for <bpf@vger.kernel.org>; Thu, 26 May 2022 11:55:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=o2hlnjCdwzIKFCAUI9mOsWpoqt0WDheZVAyYrF8Fx3E=;
 b=N0+eigZ/jNkxPasdBp8DC9TT0ud4/vKjse0J9Pqt38cpRLKNDnjtjEABbAth6SqxN8Bi
 4sOclSPMPO/gna1n1KXGD2zMGRqSgyEuWMKnwuPrtrVhiLhFFRjzpRJfRUGJ23e9QQ26
 /JM/h32gNueIqfc6VYQEzcpu7FEIIXlJZG8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g9bkychtr-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 26 May 2022 11:55:23 -0700
Received: from twshared26317.07.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 26 May 2022 11:55:21 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 9DF89AD83D61; Thu, 26 May 2022 11:55:19 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v3 09/18] libbpf: Add enum64 support for bpf linking
Date:   Thu, 26 May 2022 11:55:19 -0700
Message-ID: <20220526185519.2550219-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220526185432.2545879-1-yhs@fb.com>
References: <20220526185432.2545879-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 7dNire7gCC9qIscg0I8BmXOm4xFKhq-D
X-Proofpoint-ORIG-GUID: 7dNire7gCC9qIscg0I8BmXOm4xFKhq-D
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

Add BTF_KIND_ENUM64 support for bpf linking, which is
very similar to BTF_KIND_ENUM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/lib/bpf/linker.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 9aa016fb55aa..979b150affb9 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -1340,6 +1340,7 @@ static bool glob_sym_btf_matches(const char *sym_na=
me, bool exact,
 	case BTF_KIND_STRUCT:
 	case BTF_KIND_UNION:
 	case BTF_KIND_ENUM:
+	case BTF_KIND_ENUM64:
 	case BTF_KIND_FWD:
 	case BTF_KIND_FUNC:
 	case BTF_KIND_VAR:
@@ -1362,6 +1363,7 @@ static bool glob_sym_btf_matches(const char *sym_na=
me, bool exact,
 	case BTF_KIND_INT:
 	case BTF_KIND_FLOAT:
 	case BTF_KIND_ENUM:
+	case BTF_KIND_ENUM64:
 		/* ignore encoding for int and enum values for enum */
 		if (t1->size !=3D t2->size) {
 			pr_warn("global '%s': incompatible %s '%s' size %u and %u\n",
--=20
2.30.2

