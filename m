Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C37606562
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 18:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiJTQHi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Oct 2022 12:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiJTQHh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Oct 2022 12:07:37 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD1652805
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 09:07:36 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 29K94FYT027213
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 09:07:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=1+bpa4WnGEBpq7c/NdxZohc7+q6jghBxXdoc0Pp+EkI=;
 b=C/uxuVnFiBbbH7CAJpDGCfIlRBej1Kbl+olqtElamse+a6yijuYqmCQcGWfIf+VR3P2A
 YoB4jsSWZ+NOpuopXHDp8tQfcm3sVD9HWJE77y+cKS2pPFAFvpXhF4dsnF67Q9AqwMCg
 VFkW7CzpPDZFcrUo86XD5MJsdx3gdL9Y5QE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3kb3cd42nr-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 09:07:35 -0700
Received: from twshared9269.07.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 09:07:33 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 88BDBF43AEDB; Thu, 20 Oct 2022 09:07:23 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v5 bpf-next 2/4] bpf: Consider all mem_types compatible for map_{key,value} args
Date:   Thu, 20 Oct 2022 09:07:19 -0700
Message-ID: <20221020160721.4030492-2-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221020160721.4030492-1-davemarchevsky@fb.com>
References: <20221020160721.4030492-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: MVM2WGc_qXlWlHuDY1viF3hXDnbotzso
X-Proofpoint-GUID: MVM2WGc_qXlWlHuDY1viF3hXDnbotzso
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_07,2022-10-20_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

After the previous patch, which added PTR_TO_MEM | MEM_ALLOC type
map_key_value_types, the only difference between map_key_value_types and
mem_types sets is PTR_TO_BUF and PTR_TO_MEM, which are in the latter set
but not the former.

Helpers which expect ARG_PTR_TO_MAP_KEY or ARG_PTR_TO_MAP_VALUE
already effectively expect a valid blob of arbitrary memory that isn't
necessarily explicitly associated with a map. When validating a
PTR_TO_MAP_{KEY,VALUE} arg, the verifier expects meta->map_ptr to have
already been set, either by an earlier ARG_CONST_MAP_PTR arg, or custom
logic like that in process_timer_func or process_kptr_func.

So let's get rid of map_key_value_types and just use mem_types for those
args.

This has the effect of adding PTR_TO_BUF and PTR_TO_MEM to the set of
compatible types for ARG_PTR_TO_MAP_KEY and ARG_PTR_TO_MAP_VALUE.

PTR_TO_BUF is used by various bpf_iter implementations to represent a
chunk of valid r/w memory in ctx args for iter prog.

PTR_TO_MEM is used by networking, tracing, and ringbuf helpers to
represent a chunk of valid memory. The PTR_TO_MEM | MEM_ALLOC
type added in previous commmit is specific to ringbuf helpers.
Presence or absence of MEM_ALLOC doesn't change the validity of using
PTR_TO_MEM as a map_{key,val} input.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
v1 -> v5: lore.kernel.org/bpf/20220912101106.2765921-2-davemarchevsky@fb.=
com

  * This patch was dropped in v2 as I had no concrete usecase for
    PTR_TO_BUF and PTR_TO_MEM w/o MEM_ALLOC. Andrii encouraged me to
    re-add the patch as we both share desire to eventually cleanup all
    these separate "valid chunk of memory" types. Starting to treat them
    similarly is a good step in that direction.
    * A usecase for PTR_TO_BUF is now demonstrated in patch 4 of this
      series.
    * PTR_TO_MEM w/o MEM_ALLOC is returned by bpf_{this,per}_cpu_ptr
      helpers via RET_PTR_TO_MEM_OR_BTF_ID, but in both cases the return
      type is also tagged MEM_RDONLY, which map helpers don't currently
      accept (see patch 4 summary). So no selftest for this specific
      case is added in the series, but by logic in this patch summary
      there's no reason to treat it differently.

 kernel/bpf/verifier.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 97351ae3e7a7..ddc1452cf023 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5634,17 +5634,6 @@ struct bpf_reg_types {
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
-		PTR_TO_MEM | MEM_ALLOC,
-	},
-};
-
 static const struct bpf_reg_types sock_types =3D {
 	.types =3D {
 		PTR_TO_SOCK_COMMON,
@@ -5711,8 +5700,8 @@ static const struct bpf_reg_types dynptr_types =3D =
{
 };
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

