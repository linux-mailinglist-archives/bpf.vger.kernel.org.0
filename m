Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3502606560
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 18:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiJTQHe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Oct 2022 12:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiJTQHd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Oct 2022 12:07:33 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EE65B12F
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 09:07:32 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29KFchYQ021094
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 09:07:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=FIa3Yq6n+zpZVVx7wdnOb8Y0bW8rXKBDQLxFsBYeCqg=;
 b=n5kJSBPqiidiQUMSvlJc4BSMFX6U6oC4hv+HgftYk5GixftIM1j5FhFlVs12InBQTNC0
 18Z3c9COi2z10x2IzGRxw62rvsg/S7tHpRV3oFYmGNHViH5XeNwr3kqqg4Ehvf5nABRP
 zndKrjdCfbpEhSyJjV+J2E2TCl5lSQcYHZ4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kawj0722j-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 09:07:32 -0700
Received: from twshared9269.07.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 09:07:28 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id A306FF43AED7; Thu, 20 Oct 2022 09:07:22 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v5 bpf-next 1/4] bpf: Allow ringbuf memory to be used as map key
Date:   Thu, 20 Oct 2022 09:07:18 -0700
Message-ID: <20221020160721.4030492-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: FhsVLOpw7Xz82aSwG3-taynK2cn0fgvd
X-Proofpoint-ORIG-GUID: FhsVLOpw7Xz82aSwG3-taynK2cn0fgvd
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

This patch adds support for the following pattern:

  struct some_data *data =3D bpf_ringbuf_reserve(&ringbuf, sizeof(struct =
some_data, 0));
  if (!data)
    return;
  bpf_map_lookup_elem(&another_map, &data->some_field);
  bpf_ringbuf_submit(data);

Currently the verifier does not consider bpf_ringbuf_reserve's
PTR_TO_MEM | MEM_ALLOC ret type a valid key input to bpf_map_lookup_elem.
Since PTR_TO_MEM is by definition a valid region of memory, it is safe
to use it as a key for lookups.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
v2->v3: lore.kernel.org/bpf/20220914123600.927632-1-davemarchevsky@fb.com

  * Add Yonghong ack, rebase

v1->v2: lore.kernel.org/bpf/20220912101106.2765921-1-davemarchevsky@fb.co=
m

  * Move test changes into separate patch - patch 2 in this series.
    (Kumar, Yonghong). That patch's changelog enumerates specific
    changes from v1
  * Remove PTR_TO_MEM addition from this patch - patch 1 (Yonghong)
    * I don't have a usecase for PTR_TO_MEM w/o MEM_ALLOC
  * Add "if (!data)" error check to example pattern in this patch
    (Yonghong)
  * Remove patch 2 from v1's series, which removed map_key_value_types
    as it was more-or-less duplicate of mem_types
    * Now that PTR_TO_MEM isn't added here, more differences between
      map_key_value_types and mem_types, and no usecase for PTR_TO_BUF,
      so drop for now.

 kernel/bpf/verifier.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6f6d2d511c06..97351ae3e7a7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5641,6 +5641,7 @@ static const struct bpf_reg_types map_key_value_typ=
es =3D {
 		PTR_TO_PACKET_META,
 		PTR_TO_MAP_KEY,
 		PTR_TO_MAP_VALUE,
+		PTR_TO_MEM | MEM_ALLOC,
 	},
 };
=20
--=20
2.30.2

