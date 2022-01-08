Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA204488043
	for <lists+bpf@lfdr.de>; Sat,  8 Jan 2022 01:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiAHA7g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Jan 2022 19:59:36 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:5294 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229530AbiAHA7g (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 7 Jan 2022 19:59:36 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 207NN8HZ031292
        for <bpf@vger.kernel.org>; Fri, 7 Jan 2022 16:59:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=9HnrAeW+GAL3VoHTbRk6dJfCkys9uKL2fjg6s1LmDPc=;
 b=DD0aac/EzaZeEX6HLY7sASzk+0TLveINyL0HpVGkvtij+M+Mlw0yQdX42htWv9B+sJA+
 z/b0FlY9aJnQjxf69qa8lKtTkEpzTvk0pho4Mq8TLW1+FD9lm9OQSsNhckqEFtZMg9os
 LV3w6IPnvZjctCjYzTxu9+Mk7iKjjJ3Ff3k= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dey530cmq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 07 Jan 2022 16:59:36 -0800
Received: from twshared14302.24.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 7 Jan 2022 16:59:34 -0800
Received: by devbig921.prn2.facebook.com (Postfix, from userid 132113)
        id 5647A1697BC2; Fri,  7 Jan 2022 16:59:29 -0800 (PST)
From:   Christy Lee <christylee@fb.com>
To:     <dan.carpenter@oracle.com>
CC:     <ast@kernel.org>, <christylee@fb.com>, <kbuild-all@lists.01.org>,
        <kbuild@lists.01.org>, <linux-mm@kvack.org>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>, <christyc.y.lee@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH bpf-next] Fix incorrect integer literal used for marking scratched registers in  verifier logs
Date:   Fri, 7 Jan 2022 16:58:54 -0800
Message-ID: <20220108005854.658596-1-christylee@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <202201060848.nagWejwv-lkp@intel.com>
References: <202201060848.nagWejwv-lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: rbcdxTEMvlGkmLpklEc4N6NxSg73wPuE
X-Proofpoint-GUID: rbcdxTEMvlGkmLpklEc4N6NxSg73wPuE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-07_10,2022-01-07_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201080003
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

env->scratched_stack_slots is a 64-bit value, we should use ULL
instead of UL literal values.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Christy Lee <christylee@fb.com>
---
 kernel/bpf/verifier.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bfb45381fb3f..a8587210907d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -616,7 +616,7 @@ static void mark_reg_scratched(struct bpf_verifier_en=
v *env, u32 regno)
=20
 static void mark_stack_slot_scratched(struct bpf_verifier_env *env, u32 =
spi)
 {
-	env->scratched_stack_slots |=3D 1UL << spi;
+	env->scratched_stack_slots |=3D 1ULL << spi;
 }
=20
 static bool reg_scratched(const struct bpf_verifier_env *env, u32 regno)
@@ -637,14 +637,14 @@ static bool verifier_state_scratched(const struct b=
pf_verifier_env *env)
 static void mark_verifier_state_clean(struct bpf_verifier_env *env)
 {
 	env->scratched_regs =3D 0U;
-	env->scratched_stack_slots =3D 0UL;
+	env->scratched_stack_slots =3D 0ULL;
 }
=20
 /* Used for printing the entire verifier state. */
 static void mark_verifier_state_scratched(struct bpf_verifier_env *env)
 {
 	env->scratched_regs =3D ~0U;
-	env->scratched_stack_slots =3D ~0UL;
+	env->scratched_stack_slots =3D ~0ULL;
 }
=20
 /* The reg state of a pointer or a bounded scalar was saved when
--=20
2.30.2

