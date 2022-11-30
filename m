Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4482663E0B3
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 20:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiK3TZ3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 14:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiK3TZW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 14:25:22 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC5D862C3
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 11:25:21 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2AUG0s3h004606
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 11:25:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=fGHjDTwCXQs5a505HsJR5Kmp5sLU5IYj8Jwwjl960sE=;
 b=p77dHYUcQhET9FcvUqgEBBJcH4g0+3lCfeeGzc0RtDgJVYv/cO8onTivNYc1Lqpr+ufC
 7ZCZycTDyW5TYCRKEWyATwS4snz9Bq9J8w/V8qd5dhnaCczL7Hdd4c6mrV/mSLri/fPu
 AL8sXda11tLq7U2fyvgalkZQ5zUmH1NpP34= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3m5v7595wu-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 11:25:20 -0800
Received: from twshared8047.05.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 30 Nov 2022 11:25:18 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id A5DD211AE2CD1; Wed, 30 Nov 2022 11:25:08 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next 1/2] bpf: Fix release_on_unlock release logic for multiple refs
Date:   Wed, 30 Nov 2022 11:25:04 -0800
Message-ID: <20221130192505.914566-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 8Iyh87MekAo4IkqKBEStDqufhhDwNtHJ
X-Proofpoint-GUID: 8Iyh87MekAo4IkqKBEStDqufhhDwNtHJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-30_04,2022-11-30_02,2022-06-22_01
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
examined and kept. If we modify our initial example such that ref 6 is
not release_on_unlock and loop from the back, we'd see:

  state->refs =3D [2 4 6] (start of idx=3D2)

  state->refs =3D [2 4 6] (start of idx=3D1)

  state->refs =3D [2 6]   (start of idx=3D0)

  state->refs =3D [6]     (after idx=3D0, loop terminates)

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Fixes: 534e86bc6c66 ("bpf: Add 'release on unlock' logic for bpf_list_pus=
h_{front,back}")
---

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
index 4e7f1d085e53..ac3e1219a7a5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5726,7 +5726,7 @@ static int process_spin_lock(struct bpf_verifier_en=
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

