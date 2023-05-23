Return-Path: <bpf+bounces-1109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9CC70E28C
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 19:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE7BE1C20D31
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 17:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE732206B6;
	Tue, 23 May 2023 17:00:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5A320683
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 17:00:33 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D45C120
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 10:00:32 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34NDbfq2005062
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 10:00:31 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qrds401wd-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 10:00:31 -0700
Received: from twshared58712.02.prn6.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 10:00:27 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id B3CBD3136533F; Tue, 23 May 2023 10:00:16 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <cyphar@cyphar.com>, <brauner@kernel.org>, <lennart@poettering.net>,
        <linux-fsdevel@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v4 bpf-next 1/4] bpf: Validate BPF object in BPF_OBJ_PIN before calling LSM
Date: Tue, 23 May 2023 10:00:10 -0700
Message-ID: <20230523170013.728457-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523170013.728457-1-andrii@kernel.org>
References: <20230523170013.728457-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: NOZx1_8fWtrB44hg-EBO6bOfsLCctQIB
X-Proofpoint-GUID: NOZx1_8fWtrB44hg-EBO6bOfsLCctQIB
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_10,2023-05-23_02,2023-05-22_02
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Do a sanity check whether provided file-to-be-pinned is actually a BPF
object (prog, map, btf) before calling security_path_mknod LSM hook. If
it's not, LSM hook doesn't have to be triggered, as the operation has no
chance of succeeding anyways.

Suggested-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Link: https://lore.kernel.org/bpf/20230522232917.2454595-2-andrii@kernel.org
---
 kernel/bpf/inode.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 9948b542a470..329f27d5cacf 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -448,18 +448,17 @@ static int bpf_obj_do_pin(const char __user *pathname=
, void *raw,
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
=20
-	mode =3D S_IFREG | ((S_IRUSR | S_IWUSR) & ~current_umask());
-
-	ret =3D security_path_mknod(&path, dentry, mode, 0);
-	if (ret)
-		goto out;
-
 	dir =3D d_inode(path.dentry);
 	if (dir->i_op !=3D &bpf_dir_iops) {
 		ret =3D -EPERM;
 		goto out;
 	}
=20
+	mode =3D S_IFREG | ((S_IRUSR | S_IWUSR) & ~current_umask());
+	ret =3D security_path_mknod(&path, dentry, mode, 0);
+	if (ret)
+		goto out;
+
 	switch (type) {
 	case BPF_TYPE_PROG:
 		ret =3D vfs_mkobj(dentry, mode, bpf_mkprog, raw);
--=20
2.34.1


