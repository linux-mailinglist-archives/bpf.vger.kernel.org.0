Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0B34E4843
	for <lists+bpf@lfdr.de>; Tue, 22 Mar 2022 22:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiCVV1p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Mar 2022 17:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiCVV1o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Mar 2022 17:27:44 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A03B33E15
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 14:26:16 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 22MII8Od003863
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 14:26:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=2BsB40yr/J1FwNuO//bw7j52xaPVzXNsUuDZWb9vF48=;
 b=Igw59n/56r/fTQsP5HhjKYQbPa33fExluWwINAuIpfFViVi8rVXwg7I1Ls0kzJ9BJgEX
 hmDtJo/0AZgKandbAmwgJ8VFZJvy2tlgbA4wV6FLIQ+/b/Ywd3BJACN8Fv5WhJ8U1wve
 99BV6rG3nqUCT9PuMrBTdq8GQms0xtdlqRQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3ey8q1ekj7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 14:26:15 -0700
Received: from twshared37304.07.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Mar 2022 14:26:14 -0700
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id EA12A9FE2D1B; Tue, 22 Mar 2022 14:26:08 -0700 (PDT)
From:   Joanne Koong <joannekoong@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <kafai@fb.com>, <kpsingh@kernel.org>,
        <daniel@iogearbox.net>, <andrii@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH bpf-next v1] bpf: bpf_local_storage_update fixes
Date:   Tue, 22 Mar 2022 14:15:13 -0700
Message-ID: <20220322211513.3994356-1-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: lF6a3Bs24XOuLjld8m-v-ll-K7mc0_E6
X-Proofpoint-ORIG-GUID: lF6a3Bs24XOuLjld8m-v-ll-K7mc0_E6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-22_08,2022-03-22_01,2022-02-23_01
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Joanne Koong <joannelkoong@gmail.com>

This fixes two things in bpf_local_storage_update:

1) A memory leak where if bpf_selem_alloc is called right before we
acquire the spinlock and we hit the case where we can copy the new
value into old_sdata directly, we need to free the selem allocation
and uncharge the memory before we return. This was reported by the
kernel test robot.

2) A charge leak where if bpf_selem_alloc is called right before we
acquire the spinlock and we hit the case where old_sdata exists and we
need to unlink the old selem, we need to make sure the old selem gets
uncharged.

Fixes: b00fa38a9c1c ("bpf: Enable non-atomic allocations in local storage=
")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 kernel/bpf/bpf_local_storage.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storag=
e.c
index 01aa2b51ec4d..2d33af0368ba 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -435,8 +435,12 @@ bpf_local_storage_update(void *owner, struct bpf_loc=
al_storage_map *smap,
 	if (old_sdata && (map_flags & BPF_F_LOCK)) {
 		copy_map_value_locked(&smap->map, old_sdata->data, value,
 				      false);
-		selem =3D SELEM(old_sdata);
-		goto unlock;
+		raw_spin_unlock_irqrestore(&local_storage->lock, flags);
+		if (selem) {
+			mem_uncharge(smap, owner, smap->elem_size);
+			kfree(selem);
+		}
+		return old_sdata;
 	}
=20
 	if (gfp_flags !=3D GFP_KERNEL) {
@@ -466,10 +470,9 @@ bpf_local_storage_update(void *owner, struct bpf_loc=
al_storage_map *smap,
 	if (old_sdata) {
 		bpf_selem_unlink_map(SELEM(old_sdata));
 		bpf_selem_unlink_storage_nolock(local_storage, SELEM(old_sdata),
-						false);
+						gfp_flags =3D=3D GFP_KERNEL);
 	}
=20
-unlock:
 	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
 	return SDATA(selem);
=20
--=20
2.30.2

