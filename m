Return-Path: <bpf+bounces-706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA85705E88
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 06:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38C151C20A0B
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 04:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4364623D0;
	Wed, 17 May 2023 04:04:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E66F3C24
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 04:04:26 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC83C3A8B
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 21:04:24 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GMvO0A021081
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 21:04:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=9bpetnWWXoSZowAomlxadmRXhPi3TNJji4wpcyZZadg=;
 b=jd+2WUunUj7R8ZXx3gLGulplG56vct/UHjpZMERaFCSK5oEXtNecsHQcA3ymV9qm+tH4
 hzQO7f5NmFIElpnI6bpGMpiMa0k3Ui+ZjjQYexzlgWpPWTQkYV+ZeFLJCStAzViut4aT
 FLRK1Xl7KwKXN7W35PTCJBsvqUTdpsm6ZxE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qmk2x9c9u-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 21:04:23 -0700
Received: from twshared24695.38.frc1.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 21:04:23 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 1C4B21FB5DD47; Tue, 16 May 2023 21:04:10 -0700 (PDT)
From: Yonghong Song <yhs@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai
 Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Make bpf_dynptr_is_rdonly() prototyype consistent with kernel
Date: Tue, 16 May 2023 21:04:09 -0700
Message-ID: <20230517040409.4024618-1-yhs@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517040404.4023912-1-yhs@fb.com>
References: <20230517040404.4023912-1-yhs@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: R9uI0TdueWnzADST8rtf2_maLc-S7hGi
X-Proofpoint-ORIG-GUID: R9uI0TdueWnzADST8rtf2_maLc-S7hGi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_14,2023-05-16_01,2023-02-09_01
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently kernel kfunc bpf_dynptr_is_rdonly() has prototype:
  __bpf_kfunc bool bpf_dynptr_is_rdonly(struct bpf_dynptr_kern *ptr)
while selftests bpf_kfuncs.h has
  extern int bpf_dynptr_is_rdonly(const struct bpf_dynptr *ptr) __ksym;

Such a mismatch might cause problems although currently it is okay
in selftests. Fix it to prevent future potential surprise.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/bpf_kfuncs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/sel=
ftests/bpf/bpf_kfuncs.h
index 821c25b7d0df..642dda0e758a 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -37,7 +37,7 @@ extern void *bpf_dynptr_slice_rdwr(const struct bpf_dyn=
ptr *ptr, __u32 offset,
=20
 extern int bpf_dynptr_adjust(const struct bpf_dynptr *ptr, __u32 start, =
__u32 end) __ksym;
 extern bool bpf_dynptr_is_null(const struct bpf_dynptr *ptr) __ksym;
-extern int bpf_dynptr_is_rdonly(const struct bpf_dynptr *ptr) __ksym;
+extern bool bpf_dynptr_is_rdonly(const struct bpf_dynptr *ptr) __ksym;
 extern __u32 bpf_dynptr_size(const struct bpf_dynptr *ptr) __ksym;
 extern int bpf_dynptr_clone(const struct bpf_dynptr *ptr, struct bpf_dyn=
ptr *clone__init) __ksym;
=20
--=20
2.34.1


