Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4A963F78C
	for <lists+bpf@lfdr.de>; Thu,  1 Dec 2022 19:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiLASf3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Dec 2022 13:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbiLASf1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Dec 2022 13:35:27 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67D0B90C9
        for <bpf@vger.kernel.org>; Thu,  1 Dec 2022 10:35:20 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B1IZCxJ017474
        for <bpf@vger.kernel.org>; Thu, 1 Dec 2022 10:35:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=FyxDG0tELAO3dBVdkMyGpq01rNquhcb1h6PzCWb1nlg=;
 b=ZbGLXO38J8H7IBdvNp/3ty8yqb2uR3ctgohrG7dfXbJVn6jpTXqVDzWFXSo1JPsbjUWo
 osChEoKYYVBuarZJvToDPlW8oODLQKffxDjNHGKw5HHZ7AeRp73m3EkHJg5OB0BEmYWP
 I3MEaW/nPaXaO9a/Ccu0E8BlRuRU2sieKeQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m65bcxvhj-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 01 Dec 2022 10:35:20 -0800
Received: from twshared24004.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Dec 2022 10:34:16 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 6AEE411BCBE15; Thu,  1 Dec 2022 10:34:08 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@meta.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Yonghong Song <yhs@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH v2 bpf-next 1/2] bpf: Fix release_on_unlock release logic for multiple refs
Date:   Thu, 1 Dec 2022 10:34:05 -0800
Message-ID: <20221201183406.1203621-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 07DMRD22qE8BonQiAMRyauXNlB3vEiQM
X-Proofpoint-ORIG-GUID: 07DMRD22qE8BonQiAMRyauXNlB3vEiQM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_12,2022-12-01_01,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Consider a verifier state with three acquired references, all with
release_on_unlock =3D true:

            idx  0 1 2
  state->refs =3D [2 4 6]

(with 2, 4, and 6 being the ref ids).

When bpf_spin_unlock is called, process_spin_lock will loop through all
acquired_refs and, for each ref, if it's release_on_unlock, calls
release_reference on it. That function in turn calls
release_reference_state, which removes the reference from state->refs by
swapping the reference state with the last reference state in
refs array and decrements acquired_refs count.

process_spin_lock's loop logic, which is essentially:

  for (i =3D 0; i < state->acquired_refs; i++) {
    if (!state->refs[i].release_on_unlock)
      continue;
    release_reference(state->refs[i].id);
  }

will fail to release release_on_unlock references which are swapped from
the end. Running this logic on our example demonstrates:

  state->refs =3D [2 4 6] (start of idx=3D0 iter)
    release state->refs[0] by swapping w/ state->refs[2]

  state->refs =3D [6 4]   (start of idx=3D1)
    release state->refs[1], no need to swap as it's the last idx

  state->refs =3D [6]     (start of idx=3D2, loop terminates)

ref_id 6 should have been removed but was skipped.

Fix this by looping from back-to-front, which results in refs that are
candidates for removal being swapped with refs which have already been
examined and kept.

If we modify our initial example such that ref 6 is replaced with ref 7,
which is _not_ release_on_unlock, and loop from the back, we'd see:

  state->refs =3D [2 4 7] (start of idx=3D2)

  state->refs =3D [2 4 7] (start of idx=3D1)

  state->refs =3D [2 7]   (start of idx=3D0, refs 7 and 4 swapped)

  state->refs =3D [7]     (after idx=3D0, 7 and 2 swapped, loop terminate=
s)

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Acked-by: Yonghong Song <yhs@fb.com>
cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Fixes: 534e86bc6c66 ("bpf: Add 'release on unlock' logic for bpf_list_pus=
h_{front,back}")
---
v1 -> v2 lore.kernel.org/bpf/b5d46fd5-2693-cd46-9515-700fef1a110b@meta.co=
m:

  * Update second example in patch summary to use a new ref_id for the
    non-release_on_unlock ref. (Yonghong)
  * Add Yonghong's ack

I noticed this while testing ng_ds version of rbtree. Submitting
separately so that this fix can be applied before the rest of rbtree
work, as the latter will likely need a few respins.

An alternative to this fix would be to modify or add new helper
functions which enable safe release_reference in a loop. The additional
complexity of this alternative seems unnecessary to me for now as this
is currently the only place in verifier where release_reference in a
loop is used.

 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d0ecc0b18b20..b0db9c10567b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5738,7 +5738,7 @@ static int process_spin_lock(struct bpf_verifier_en=
v *env, int regno,
 		cur->active_lock.ptr =3D NULL;
 		cur->active_lock.id =3D 0;
=20
-		for (i =3D 0; i < fstate->acquired_refs; i++) {
+		for (i =3D fstate->acquired_refs - 1; i >=3D 0; i--) {
 			int err;
=20
 			/* Complain on error because this reference state cannot
--=20
2.30.2

