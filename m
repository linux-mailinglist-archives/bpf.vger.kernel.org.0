Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969C25B57EE
	for <lists+bpf@lfdr.de>; Mon, 12 Sep 2022 12:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiILKL2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Sep 2022 06:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiILKL2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Sep 2022 06:11:28 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D7D21267
        for <bpf@vger.kernel.org>; Mon, 12 Sep 2022 03:11:27 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28BNshg2010556
        for <bpf@vger.kernel.org>; Mon, 12 Sep 2022 03:11:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=iSJHrYgO1YQwW/7aNhppRPXZL6n4e0tJycWpz9g6w0o=;
 b=ehbyM0xRwQlFVpQvZUZpIR+09v53Y9vOvvpKuXapkKtyoeErZ4ElQ2eS85uUWPQdEKUR
 sTSUgNDj4/YGYngqGg50BUlgqw2VNSm6uAGHwCwsIHYYpAeQMacuW0AgLtCt52Yxo5L6
 TYRqz0m3U/Tzilxw0Wnga5MODYEVKZaLsXQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jgrb1gfhu-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 12 Sep 2022 03:11:26 -0700
Received: from twshared7509.08.ash8.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 12 Sep 2022 03:11:24 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id D35FDD5973F0; Mon, 12 Sep 2022 03:11:12 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Liam Wisehart <liamwisehart@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next 2/2] bpf: Consider all mem_types compatible for map_{key,value} args
Date:   Mon, 12 Sep 2022 03:11:06 -0700
Message-ID: <20220912101106.2765921-2-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220912101106.2765921-1-davemarchevsky@fb.com>
References: <20220912101106.2765921-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 1nV0x3KCmwYQQH01ngulR39VAweet4ZJ
X-Proofpoint-GUID: 1nV0x3KCmwYQQH01ngulR39VAweet4ZJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-12_06,2022-09-12_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

After the previous patch, which added PTR_TO_MEM types to
map_key_value_types, the only difference between map_key_value_types and
mem_types sets is PTR_TO_BUF, which is in the latter set but not the
former.

Helpers which expect ARG_PTR_TO_MAP_KEY or ARG_PTR_TO_MAP_VALUE
already effectively expect a valid blob of arbitrary memory that isn't
necessarily explicitly associated with a map. When validating a
PTR_TO_MAP_{KEY,VALUE} arg, the verifier expects meta->map_ptr to have
already been set, either by an earlier ARG_CONST_MAP_PTR arg, or custom
logic like that in process_timer_func or process_kptr_func.

So let's get rid of map_key_value_types and just use mem_types for those
args.

This has the effect of adding PTR_TO_BUF to the set of compatible types
for ARG_PTR_TO_MAP_KEY and ARG_PTR_TO_MAP_VALUE.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 kernel/bpf/verifier.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d093618aed99..ae2259d782bb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5619,18 +5619,6 @@ struct bpf_reg_types {
 	u32 *btf_id;
 };
=20
-static const struct bpf_reg_types map_key_value_types =3D {
-	.types =3D {
-		PTR_TO_STACK,
-		PTR_TO_PACKET,
-		PTR_TO_PACKET_META,
-		PTR_TO_MAP_KEY,
-		PTR_TO_MAP_VALUE,
-		PTR_TO_MEM,
-		PTR_TO_MEM | MEM_ALLOC,
-	},
-};
-
 static const struct bpf_reg_types sock_types =3D {
 	.types =3D {
 		PTR_TO_SOCK_COMMON,
@@ -5691,8 +5679,8 @@ static const struct bpf_reg_types timer_types =3D {=
 .types =3D { PTR_TO_MAP_VALUE }
 static const struct bpf_reg_types kptr_types =3D { .types =3D { PTR_TO_M=
AP_VALUE } };
=20
 static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_M=
AX] =3D {
-	[ARG_PTR_TO_MAP_KEY]		=3D &map_key_value_types,
-	[ARG_PTR_TO_MAP_VALUE]		=3D &map_key_value_types,
+	[ARG_PTR_TO_MAP_KEY]		=3D &mem_types,
+	[ARG_PTR_TO_MAP_VALUE]		=3D &mem_types,
 	[ARG_CONST_SIZE]		=3D &scalar_types,
 	[ARG_CONST_SIZE_OR_ZERO]	=3D &scalar_types,
 	[ARG_CONST_ALLOC_SIZE_OR_ZERO]	=3D &scalar_types,
--=20
2.30.2

