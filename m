Return-Path: <bpf+bounces-2188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 438B8728CAB
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 02:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 985C71C20FA4
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 00:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5F3A4C;
	Fri,  9 Jun 2023 00:54:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FD87E9
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 00:54:56 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122521FD6
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 17:54:54 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 358Gmlsk011180
	for <bpf@vger.kernel.org>; Thu, 8 Jun 2023 17:54:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=0Zy5fDK8ZPz0TFRwdEY/sU4F39fDAWeUznTmmD207t8=;
 b=E2AfdKoXrS2Bwnb9xxUa7w9seumK9FYnh9Rpfib1uBOHbuA69GfX8pntiRuGvbY1A972
 GjZcC66YO6J8WVNbXKA9rdde6iYVR9irXygxrxzWvtuBCJXM8jUfbPXktt+6lpDWV/ZD
 9uHvk2OhvKcWq/H5QtSsHe2LN8SWwdyTdvA= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r2w6bkupa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 08 Jun 2023 17:54:53 -0700
Received: from twshared52565.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 8 Jun 2023 17:54:53 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 3550220FFCC07; Thu,  8 Jun 2023 17:54:39 -0700 (PDT)
From: Yonghong Song <yhs@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai
 Lau <martin.lau@kernel.org>
Subject: [PATCH bpf] bpf: Fix a bpf_jit_dump issue for x86_64 with sysctl bpf_jit_enable.
Date: Thu, 8 Jun 2023 17:54:39 -0700
Message-ID: <20230609005439.3173569-1-yhs@fb.com>
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
X-Proofpoint-GUID: Sj70BrRfaQ76X2P8R_CCn4tFElpyO4Yt
X-Proofpoint-ORIG-GUID: Sj70BrRfaQ76X2P8R_CCn4tFElpyO4Yt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_18,2023-06-08_01,2023-05-22_02
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The sysctl net/core/bpf_jit_enable does not work now due to Commit
1022a5498f6f ("bpf, x86_64: Use bpf_jit_binary_pack_alloc").
The commit saved the jitted insns into 'rw_image' instead of 'image'
which caused bpf_jit_dump not dumping proper content.

With 'echo 2 > /proc/sys/net/core/bpf_jit_enable', run
'./test_progs -t fentry_test'. Without this patch, one of jitted
image for one particular prog is:
  flen=3D17 proglen=3D92 pass=3D4 image=3D0000000014c64883 from=3Dtest_pr=
ogs pid=3D1807
  00000000: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
  00000010: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
  00000020: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
  00000030: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
  00000040: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
  00000050: cc cc cc cc cc cc cc cc cc cc cc cc

With this patch, the jitte image for the same prog is:
  flen=3D17 proglen=3D92 pass=3D4 image=3D00000000b90254b7 from=3Dtest_pr=
ogs pid=3D1809
  00000000: f3 0f 1e fa 0f 1f 44 00 00 66 90 55 48 89 e5 f3
  00000010: 0f 1e fa 31 f6 48 8b 57 00 48 83 fa 07 75 2b 48
  00000020: 8b 57 10 83 fa 09 75 22 48 8b 57 08 48 81 e2 ff
  00000030: 00 00 00 48 83 fa 08 75 11 48 8b 7f 18 be 01 00
  00000040: 00 00 48 83 ff 0a 74 02 31 f6 48 bf 18 d0 14 00
  00000050: 00 c9 ff ff 48 89 77 00 31 c0 c9 c3

Fixes: 1022a5498f6f ("bpf, x86_64: Use bpf_jit_binary_pack_alloc")
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 arch/x86/net/bpf_jit_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 1056bbf55b17..438adb695daa 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2570,7 +2570,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_pro=
g *prog)
 	}
=20
 	if (bpf_jit_enable > 1)
-		bpf_jit_dump(prog->len, proglen, pass + 1, image);
+		bpf_jit_dump(prog->len, proglen, pass + 1, rw_image);
=20
 	if (image) {
 		if (!prog->is_func || extra_pass) {
--=20
2.34.1


