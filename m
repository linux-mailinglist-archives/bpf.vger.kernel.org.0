Return-Path: <bpf+bounces-5728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C09F575FCF1
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 19:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C6962813E0
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 17:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61F7F4F9;
	Mon, 24 Jul 2023 17:11:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8543F1FC4
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 17:11:23 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA7E1B5
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 10:11:21 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36OFESNY011155
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 10:11:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=s2doxZu+KIEBwoCaFyP6lbuI4a/vqiV4R1s1or79pIE=;
 b=OdABlV5QbpSfj7QPIFzmRIy4h4JOnu/lXqf3Su2sc+UjcBZAylMWtfeZG2iBY82zgy9z
 R+JKJkaKfqVK5bCm/gTXb96pDmOSqxwfEKMjmPO4pBdj56CG26Pu8cay7RlAhBLr+Iiq
 E524WYDhLu46Vee+PGSQfkKeIs0fT+qVg9U= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3s1urxs1ff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 10:11:21 -0700
Received: from twshared18891.17.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 24 Jul 2023 10:11:20 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id DB6EB23969356; Mon, 24 Jul 2023 10:11:02 -0700 (PDT)
From: Yonghong Song <yhs@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai
 Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next] MAINTAINERS: Replace my email address
Date: Mon, 24 Jul 2023 10:11:02 -0700
Message-ID: <20230724171102.3915336-1-yhs@fb.com>
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
X-Proofpoint-GUID: 1_FsBQdOkAd_qlIa2ZclRfom5qDjLZt7
X-Proofpoint-ORIG-GUID: 1_FsBQdOkAd_qlIa2ZclRfom5qDjLZt7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_13,2023-07-24_01,2023-05-22_02
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Switch from corporate email address to linux.dev address.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 990e3fce753c..b170081d6c3c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3703,7 +3703,7 @@ M:	Daniel Borkmann <daniel@iogearbox.net>
 M:	Andrii Nakryiko <andrii@kernel.org>
 R:	Martin KaFai Lau <martin.lau@linux.dev>
 R:	Song Liu <song@kernel.org>
-R:	Yonghong Song <yhs@fb.com>
+R:	Yonghong Song <yonghong.song@linux.dev>
 R:	John Fastabend <john.fastabend@gmail.com>
 R:	KP Singh <kpsingh@kernel.org>
 R:	Stanislav Fomichev <sdf@google.com>
@@ -3742,7 +3742,7 @@ F:	tools/lib/bpf/
 F:	tools/testing/selftests/bpf/
=20
 BPF [ITERATOR]
-M:	Yonghong Song <yhs@fb.com>
+M:	Yonghong Song <yonghong.song@linux.dev>
 L:	bpf@vger.kernel.org
 S:	Maintained
 F:	kernel/bpf/*iter.c
--=20
2.34.1


