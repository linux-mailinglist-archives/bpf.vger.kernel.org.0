Return-Path: <bpf+bounces-10328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A6D7A54DB
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 23:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4C461C20AF8
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 21:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B5031A66;
	Mon, 18 Sep 2023 21:01:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDC5286BB
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 21:01:28 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07C010D
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 14:01:26 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38IKFr13017730
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 14:01:26 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3t57pjygr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 14:01:25 -0700
Received: from twshared51307.04.prn6.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 18 Sep 2023 14:01:22 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 11075384A98D8; Mon, 18 Sep 2023 14:01:15 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>, Chris Mason <clm@meta.com>
Subject: [PATCH bpf] bpf: unconditionally reset backtrack_state masks on global func exit
Date: Mon, 18 Sep 2023 14:01:10 -0700
Message-ID: <20230918210110.2241458-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: A-_giPGqtQ3hAkLLTlSrDf5-BP-neSDK
X-Proofpoint-ORIG-GUID: A-_giPGqtQ3hAkLLTlSrDf5-BP-neSDK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_10,2023-09-18_01,2023-05-22_02
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In mark_chain_precision() logic, when we reach the entry to a global
func, it is expected that R1-R5 might be still requested to be marked
precise. This would correspond to some integer input arguments being
tracked as precise. This is all expected and handled as a special case.

What's not expected is that we'll leave backtrack_state structure with
some register bits set. This is because for subsequent precision
propagations backtrack_state is reused without clearing masks, as all
code paths are carefully written in a way to leave empty backtrack_state
with zeroed out masks, for speed.

The fix is trivial, we always clear register bit in the register mask, an=
d
then, optionally, set reg->precise if register is SCALAR_VALUE type.

Reported-by: Chris Mason <clm@meta.com>
Fixes: be2ef8161572 ("bpf: allow precision tracking for programs with sub=
progs")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bb78212fa5b2..c0c7d137066a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4047,11 +4047,9 @@ static int __mark_chain_precision(struct bpf_verif=
ier_env *env, int regno)
 				bitmap_from_u64(mask, bt_reg_mask(bt));
 				for_each_set_bit(i, mask, 32) {
 					reg =3D &st->frame[0]->regs[i];
-					if (reg->type !=3D SCALAR_VALUE) {
-						bt_clear_reg(bt, i);
-						continue;
-					}
-					reg->precise =3D true;
+					bt_clear_reg(bt, i);
+					if (reg->type =3D=3D SCALAR_VALUE)
+						reg->precise =3D true;
 				}
 				return 0;
 			}
--=20
2.34.1


