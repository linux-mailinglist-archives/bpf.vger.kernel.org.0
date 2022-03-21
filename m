Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8728B4E306E
	for <lists+bpf@lfdr.de>; Mon, 21 Mar 2022 20:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345447AbiCUTFd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Mar 2022 15:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352425AbiCUTFd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Mar 2022 15:05:33 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A48C1114E
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 12:04:07 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22LFOs7B012197
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 12:04:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=ol8hOzFSuFI+GzFXF21AgXDODnqqTwRV9dnV+NNVwq8=;
 b=EJWielqovgvoW2CTt+KoTHZJUWRL6m91Rz4MjqaaLy6ZuIW9blgOKOEAC7iA3yp2iw+Y
 XzhAOOSZA8TSdx874tsKm0GrmVYTbveskTtzupLUv3amb6cErCVg4e76aKgS19qx2c7R
 jL2ZXh/aQGkQDQQ82lgrHiffUuQkJSWszyQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ewc9tkynt-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 12:04:06 -0700
Received: from twshared37304.07.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Mar 2022 12:04:03 -0700
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id 031F99F13687; Mon, 21 Mar 2022 12:03:57 -0700 (PDT)
From:   Joanne Koong <joannekoong@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH bpf-next v1] bpf: Fix warning for cast from restricted gfp_t in verifier
Date:   Mon, 21 Mar 2022 11:58:02 -0700
Message-ID: <20220321185802.824223-1-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: hThBn23QxSwwqzTs2dU7AzrGn0L0LVfA
X-Proofpoint-GUID: hThBn23QxSwwqzTs2dU7AzrGn0L0LVfA
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-21_08,2022-03-21_01,2022-02-23_01
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Joanne Koong <joannelkoong@gmail.com>

This fixes the sparse warning reported by the kernel test robot:

kernel/bpf/verifier.c:13499:47: sparse: warning: cast from restricted gfp_t
kernel/bpf/verifier.c:13501:47: sparse: warning: cast from restricted gfp_t

This fix can be verified locally by running:
1) wget
https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
-O make.cross

2) chmod +x ~/bin/make.cross

3) COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-11.2.0 ./make.cross
C=3D1 CF=3D'-fdiagnostic-prefix -D__CHECK_ENDIAN__'

Fixes: b00fa38a9c1c ("bpf: Enable non-atomic allocations in local storage")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 kernel/bpf/verifier.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 571ccd7f04eb..d175b70067b3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13496,9 +13496,9 @@ static int do_misc_fixups(struct bpf_verifier_env *=
env)
 		    insn->imm =3D=3D BPF_FUNC_sk_storage_get ||
 		    insn->imm =3D=3D BPF_FUNC_inode_storage_get) {
 			if (env->prog->aux->sleepable)
-				insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_5, (__s32)GFP_KERNEL);
+				insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_5, (__force __s32)GFP_KERNEL);
 			else
-				insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_5, (__s32)GFP_ATOMIC);
+				insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_5, (__force __s32)GFP_ATOMIC);
 			insn_buf[1] =3D *insn;
 			cnt =3D 2;
=20
--=20
2.30.2

