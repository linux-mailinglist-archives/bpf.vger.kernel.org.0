Return-Path: <bpf+bounces-1194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD0071012B
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 00:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A0F3281428
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 22:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC9C8498;
	Wed, 24 May 2023 22:55:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769AD848D
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 22:55:33 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F55FA9
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 15:55:31 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OHG3qK008390
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 15:55:31 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qsptc9uk1-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 15:55:31 -0700
Received: from twshared25760.37.frc1.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 15:55:07 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 604033149A855; Wed, 24 May 2023 15:54:48 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 1/3] bpf: drop unnecessary bpf_capable() check in BPF_MAP_FREEZE command
Date: Wed, 24 May 2023 15:54:19 -0700
Message-ID: <20230524225421.1587859-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230524225421.1587859-1-andrii@kernel.org>
References: <20230524225421.1587859-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ILNT2UBl_dMbvD_EevcvMlaXGYuv0v_c
X-Proofpoint-GUID: ILNT2UBl_dMbvD_EevcvMlaXGYuv0v_c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_15,2023-05-24_01,2023-05-22_02
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Seems like that extra bpf_capable() check in BPF_MAP_FREEZE handler was
unintentionally left when we switched to a model that all BPF map
operations should be allowed regardless of CAP_BPF (or any other
capabilities), as long as process got BPF map FD somehow.

This patch replaces bpf_capable() check in BPF_MAP_FREEZE handler with
writeable access check, given conceptually freezing the map is modifying
it: map becomes unmodifiable for subsequent updates.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/syscall.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index c7f6807215e6..c9a201e4c457 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1931,6 +1931,11 @@ static int map_freeze(const union bpf_attr *attr)
 		return -ENOTSUPP;
 	}
=20
+	if (!(map_get_sys_perms(map, f) & FMODE_CAN_WRITE)) {
+		err =3D -EPERM;
+		goto err_put;
+	}
+
 	mutex_lock(&map->freeze_mutex);
 	if (bpf_map_write_active(map)) {
 		err =3D -EBUSY;
@@ -1940,10 +1945,6 @@ static int map_freeze(const union bpf_attr *attr)
 		err =3D -EBUSY;
 		goto err_put;
 	}
-	if (!bpf_capable()) {
-		err =3D -EPERM;
-		goto err_put;
-	}
=20
 	WRITE_ONCE(map->frozen, true);
 err_put:
--=20
2.34.1


