Return-Path: <bpf+bounces-1254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA11711A0E
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 00:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57EAF2815DF
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 22:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734FF261C5;
	Thu, 25 May 2023 22:13:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFA2FC16
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 22:13:43 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA071B3
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 15:13:41 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PKntZX003943
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 15:13:40 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qt9b0kdt6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 15:13:40 -0700
Received: from twshared52565.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 25 May 2023 15:13:39 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 59DDE31573609; Thu, 25 May 2023 15:13:26 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <lennart@poettering.net>, Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 2/2] libbpf: ensure FD >= 3 during bpf_map__reuse_fd()
Date: Thu, 25 May 2023 15:13:11 -0700
Message-ID: <20230525221311.2136408-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525221311.2136408-1-andrii@kernel.org>
References: <20230525221311.2136408-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: tttMG6SXSJT2RNuJ-9Pzs3d2POUiS6RR
X-Proofpoint-GUID: tttMG6SXSJT2RNuJ-9Pzs3d2POUiS6RR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_12,2023-05-25_03,2023-05-22_02
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Improve bpf_map__reuse_fd() logic and ensure that dup'ed map FD is
"good" (>=3D 3) and has O_CLOEXEC flags. Use fcntl(F_DUPFD_CLOEXEC) for
that, similarly to ensure_good_fd() helper we already use in low-level
APIs that work with bpf() syscall.

Suggested-by: Lennart Poettering <lennart@poettering.net>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 60ef4c5e3bee..47632606b06d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4414,18 +4414,17 @@ int bpf_map__reuse_fd(struct bpf_map *map, int fd=
)
 	if (!new_name)
 		return libbpf_err(-errno);
=20
-	new_fd =3D open("/", O_RDONLY | O_CLOEXEC);
+	/*
+	 * Like dup(), but make sure new FD is >=3D 3 and has O_CLOEXEC set.
+	 * This is similar to what we do in ensure_good_fd(), but without
+	 * closing original FD.
+	 */
+	new_fd =3D fcntl(fd, F_DUPFD_CLOEXEC, 3);
 	if (new_fd < 0) {
 		err =3D -errno;
 		goto err_free_new_name;
 	}
=20
-	new_fd =3D dup3(fd, new_fd, O_CLOEXEC);
-	if (new_fd < 0) {
-		err =3D -errno;
-		goto err_close_new_fd;
-	}
-
 	err =3D zclose(map->fd);
 	if (err) {
 		err =3D -errno;
--=20
2.34.1


