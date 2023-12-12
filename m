Return-Path: <bpf+bounces-17562-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B7180F572
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 19:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EBC21C20C35
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 18:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAA87E78C;
	Tue, 12 Dec 2023 18:26:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4287DBC
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 10:26:04 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCH1HMY013773
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 10:26:04 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ux30827bp-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 10:26:02 -0800
Received: from twshared2123.40.prn1.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 12 Dec 2023 10:26:00 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id E8B2F3D0588CE; Tue, 12 Dec 2023 10:25:51 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Christian Brauner
	<brauner@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH v2 bpf-next 1/8] bpf: fail BPF_TOKEN_CREATE if no delegation option was set on BPF FS
Date: Tue, 12 Dec 2023 10:25:40 -0800
Message-ID: <20231212182547.1873811-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212182547.1873811-1-andrii@kernel.org>
References: <20231212182547.1873811-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: vhF5dnjAdotgmm4DjYZ7Vjg3CaDBa2ac
X-Proofpoint-ORIG-GUID: vhF5dnjAdotgmm4DjYZ7Vjg3CaDBa2ac
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_12,2023-12-12_01,2023-05-22_02

It's quite confusing in practice when it's possible to successfully
create a BPF token from BPF FS that didn't have any of delegate_xxx
mount options set up. While it's not wrong, it's actually more
meaningful to reject BPF_TOKEN_CREATE with specific error code (-ENOENT)
to let user-space know that no token delegation is setup up.

So, instead of creating empty BPF token that will be always ignored
because it doesn't have any of the allow_xxx bits set, reject it with
-ENOENT. If we ever need empty BPF token to be possible, we can support
that with extra flag passed into BPF_TOKEN_CREATE.

Acked-by: Christian Brauner <brauner@kernel.org>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/token.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
index 17212efcde60..a86fccd57e2d 100644
--- a/kernel/bpf/token.c
+++ b/kernel/bpf/token.c
@@ -152,6 +152,15 @@ int bpf_token_create(union bpf_attr *attr)
 		goto out_path;
 	}
=20
+	mnt_opts =3D path.dentry->d_sb->s_fs_info;
+	if (mnt_opts->delegate_cmds =3D=3D 0 &&
+	    mnt_opts->delegate_maps =3D=3D 0 &&
+	    mnt_opts->delegate_progs =3D=3D 0 &&
+	    mnt_opts->delegate_attachs =3D=3D 0) {
+		err =3D -ENOENT; /* no BPF token delegation is set up */
+		goto out_path;
+	}
+
 	mode =3D S_IFREG | ((S_IRUSR | S_IWUSR) & ~current_umask());
 	inode =3D bpf_get_inode(path.mnt->mnt_sb, NULL, mode);
 	if (IS_ERR(inode)) {
@@ -181,7 +190,6 @@ int bpf_token_create(union bpf_attr *attr)
 	/* remember bpffs owning userns for future ns_capable() checks */
 	token->userns =3D get_user_ns(userns);
=20
-	mnt_opts =3D path.dentry->d_sb->s_fs_info;
 	token->allowed_cmds =3D mnt_opts->delegate_cmds;
 	token->allowed_maps =3D mnt_opts->delegate_maps;
 	token->allowed_progs =3D mnt_opts->delegate_progs;
--=20
2.34.1


