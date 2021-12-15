Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54EE8476199
	for <lists+bpf@lfdr.de>; Wed, 15 Dec 2021 20:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbhLOTWt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Dec 2021 14:22:49 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55492 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234497AbhLOTWs (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 15 Dec 2021 14:22:48 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BFIA3fQ030297
        for <bpf@vger.kernel.org>; Wed, 15 Dec 2021 11:22:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=d5EvIozOcZEBn8N2xzH/mHHjdBKZ06xoIvAbP1NvHKg=;
 b=nT+qK8DMa6r8n4aDr9Dsi/RNUqxw1cfbuxsHB9uODD4GlLgkVrD+Qxk5W7keGHSbz1Vv
 oUpTDO9qUMZSQFkQc7RusDEY3vycGpD4w22MtnNCd2wVj+yTGPA3YDLX4FcER1aF3y7W
 iudHXcmnP+0Cys541FC7+CHQaKE+R3lbbZ4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3cybm7cydn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 15 Dec 2021 11:22:48 -0800
Received: from intmgw001.05.prn6.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 11:22:44 -0800
Received: by devbig921.prn2.facebook.com (Postfix, from userid 132113)
        id 0AA6C6B96B3; Wed, 15 Dec 2021 11:22:43 -0800 (PST)
From:   Christy Lee <christylee@fb.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>
CC:     <bpf@vger.kernel.org>, <kernel-team@fb.com>, <christylee@fb.com>,
        <christyc.y.lee@gmail.com>
Subject: [PATCH v2 bpf-next 0/3] Improve verifier log readability
Date:   Wed, 15 Dec 2021 11:22:22 -0800
Message-ID: <20211215192225.1278237-1-christylee@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: pHlKjHzJiRNMFWJIcJX4Uqwi0rOtWTX5
X-Proofpoint-ORIG-GUID: pHlKjHzJiRNMFWJIcJX4Uqwi0rOtWTX5
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-15_11,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=990
 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112150107
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Simplify verifier logs and improve readability.

Changelog:
----------
v1 -> v2:
v1: https://lore.kernel.org/bpf/20211213182117.682461-1-christylee@fb.com/

Patch 2/3:
* Verifier will skip insn_idx when the insn is longer than 8 bytes,
  example:
  0000000000000000 <good_prog>:
       0:	18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00	r2 =3D 0 ll
       2:	63 12 00 00 00 00 00 00	*(u32 *)(r2 + 0) =3D r1
       3:	61 20 04 00 00 00 00 00	r0 =3D *(u32 *)(r2 + 4)
       4:	95 00 00 00 00 00 00 00	exit
  It's incorrect to check that prev_insn_idx =3D insn_idx - 1, skip this
  check and print the verifier state on the correct line.
  Before:
  0: R1=3Dctx(id=3D0,off=3D0,imm=3D0) R10=3Dfp0
  ; a[0] =3D (int)(long)ctx;
  0: (18) r2 =3D 0xffffc900006de000
  2: R2_w=3Dmap_value(id=3D0,off=3D0,ks=3D4,vs=3D16,imm=3D0)
  2: (63) *(u32 *)(r2 +0) =3D r1
  After:
  0: R1=3Dctx(id=3D0,off=3D0,imm=3D0) R10=3Dfp0
  ; a[0] =3D (int)(long)ctx;
  0: (18) r2 =3D 0xffffc900006de000 ; R2_w=3Dmap_value(id=3D0,off=3D0,ks=3D=
4,vs=3D16,imm=3D0)
  2: (63) *(u32 *)(r2 +0) =3D r1
* Track previous line logging length in env, allow aligning intsruction
  from anywhere in the verifier
* Fixed bug where the verifier printed verifier state after checking
  source memory access but before check destination memory access,
  this ensures the aligned verifier state contains all scratched
  registers

Patch 3/3:
* Added one more case where we should only log in log_level=3D2

Christy Lee (3):
  Only print scratched registers and stack slots to verifier logs
  Right align verifier states in verifier logs
  Only output backtracking information in log level 2

 include/linux/bpf_verifier.h                  |  10 +
 kernel/bpf/verifier.c                         | 131 +++++++++--
 .../testing/selftests/bpf/prog_tests/align.c  | 214 +++++++++---------
 3 files changed, 232 insertions(+), 123 deletions(-)

--
2.30.2
