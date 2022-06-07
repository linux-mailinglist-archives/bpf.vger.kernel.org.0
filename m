Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E2953F614
	for <lists+bpf@lfdr.de>; Tue,  7 Jun 2022 08:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236977AbiFGG0z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Jun 2022 02:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236973AbiFGG0y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Jun 2022 02:26:54 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68A2C967B
        for <bpf@vger.kernel.org>; Mon,  6 Jun 2022 23:26:53 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 257651hE015199
        for <bpf@vger.kernel.org>; Mon, 6 Jun 2022 23:26:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=omhOly/JR+wQpeqJeZRWo3DIBiJzQKrss9f8zlTM+z0=;
 b=Q1uyNhz231lmgDR19fYV8wKwDEdIVoWHZsv3pYjGeDs18Ubm8H7UdUriMMyVnk/QCtWi
 ZdBWm7zVipsCelckniaD/rXHA/w9q9oBFlC9jfSHCUh8KTOXzui/RbfTIwQx6pbFxJDh
 tXc56qDMXC4OsyYgFKBsUCq8Qr58jx7Tsf4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gj13cg2fp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 06 Jun 2022 23:26:53 -0700
Received: from twshared8508.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 6 Jun 2022 23:26:52 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 394B4B52115B; Mon,  6 Jun 2022 23:26:42 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v5 09/17] libbpf: Add enum64 support for bpf linking
Date:   Mon, 6 Jun 2022 23:26:42 -0700
Message-ID: <20220607062642.3721494-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220607062554.3716237-1-yhs@fb.com>
References: <20220607062554.3716237-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Ly3A0pSE95VVlyW4LscD68Zdws-jT5kO
X-Proofpoint-ORIG-GUID: Ly3A0pSE95VVlyW4LscD68Zdws-jT5kO
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

Add BTF_KIND_ENUM64 support for bpf linking, which is
very similar to BTF_KIND_ENUM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/lib/bpf/linker.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 85c0fddf55d1..4ac02c28e152 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -1335,6 +1335,7 @@ static bool glob_sym_btf_matches(const char *sym_na=
me, bool exact,
 	case BTF_KIND_STRUCT:
 	case BTF_KIND_UNION:
 	case BTF_KIND_ENUM:
+	case BTF_KIND_ENUM64:
 	case BTF_KIND_FWD:
 	case BTF_KIND_FUNC:
 	case BTF_KIND_VAR:
@@ -1357,6 +1358,7 @@ static bool glob_sym_btf_matches(const char *sym_na=
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

