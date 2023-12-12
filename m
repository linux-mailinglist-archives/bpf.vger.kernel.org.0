Return-Path: <bpf+bounces-17496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B7D80E7DF
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 10:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42E3B1C21182
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 09:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E3D58AAE;
	Tue, 12 Dec 2023 09:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k1ncdBpO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920F5CE
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 01:39:30 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5c21e185df5so4534023a12.1
        for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 01:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702373970; x=1702978770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bI5FBjSWOx0LovLK9PpF76ZXF00kLflF5hzTLKW0TM0=;
        b=k1ncdBpOA6kd+QoQHtBxjzzTduD7+usG6L/jGHCDOf8EsdeQIu0TqTYkdqqrD4Myuy
         gRrKrVKmcN+dfE8IMoGiGFuzVg2+gbRSw+YyAEprm4riGTuR4Qi+IrKMCWMZ0I86q5gR
         DHE8PoyhWzC9SGVxL3PPiVqgMDyXshTEBjr+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702373970; x=1702978770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bI5FBjSWOx0LovLK9PpF76ZXF00kLflF5hzTLKW0TM0=;
        b=lekVqnqY5KnUdz3d95OC9oLK9TL48+6V9tBsiXjj216pfslaD2HJOQCjOCTGTrnurt
         LTcPACSv/BK8conkO6b5mXU8v1VgkO195dfSi8+wjWMawClx8Fd6DQ1lP05ffj5mmEMP
         /7/G8TDQrIE69bUVcZhvt33NH8bEidpr+AF2nFgff5e3hFcr5Z0xIUWmKoh9NB4ewOFB
         r41vzcA3avvFTKPY62yYY9Wdj4vCnnj0OFzBOZ2Or8KPvYHC8wNNurORGDDgnFKpiJ4K
         n47vgbKsoRPILOstDuL6ACjSCNdNCS/27m4BGHfqaU7mexCgf2XT31mlkTCNYkFgzhcM
         0Nmw==
X-Gm-Message-State: AOJu0Yyb7J2AR8RTUtEaB2iJFlFQsqkuMNCgrBswHWU8ABBhNVDDKWtf
	BdSTdXInQ5XokDm9H7cjaz/ZY3NouK+cDju/ukg=
X-Google-Smtp-Source: AGHT+IGyiUsA0kht5Mlx7r+BtyME5GcQDJA0lYRMXdZcyrte4FRvsmulRUsJHfKZwKKKguNGzaLVcw==
X-Received: by 2002:a05:6a20:3ca6:b0:18b:246a:d43d with SMTP id b38-20020a056a203ca600b0018b246ad43dmr8157829pzj.15.1702373969918;
        Tue, 12 Dec 2023 01:39:29 -0800 (PST)
Received: from jiejiang.c.googlers.com.com (148.175.199.104.bc.googleusercontent.com. [104.199.175.148])
        by smtp.gmail.com with ESMTPSA id u17-20020aa78491000000b006cb98a269f1sm7707921pfn.125.2023.12.12.01.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 01:39:29 -0800 (PST)
From: Jie Jiang <jiejiang@chromium.org>
To: bpf@vger.kernel.org
Cc: jiejiang@chromium.org,
	vapier@chromium.org,
	brauner@kernel.org,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net
Subject: [PATCH bpf-next v4] bpf: Support uid and gid when mounting bpffs
Date: Tue, 12 Dec 2023 09:39:23 +0000
Message-ID: <20231212093923.497838-1-jiejiang@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parse uid and gid in bpf_parse_param() so that they can be passed in as
the `data` parameter when mount() bpffs. This will be useful when we
want to control which user/group has the control to the mounted bpffs,
otherwise a separate chown() call will be needed.

Signed-off-by: Jie Jiang <jiejiang@chromium.org>
Acked-by: Mike Frysinger <vapier@chromium.org>
Acked-by: Christian Brauner <brauner@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
v3 -> v4: Initialize opts->uid and opts->gid in bpf_init_fs_context().
v2 -> v3: Rebase to resolve conflicts.
v1 -> v2: Add additional validation in bpf_parse_param() for if the
  requested uid/gid is representable in the fs's idmapping.

 include/linux/bpf.h |  2 ++
 kernel/bpf/inode.c  | 50 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index c1a06263a4f36..eab1f991c440b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1595,6 +1595,8 @@ struct bpf_link_primer {
 };
 
 struct bpf_mount_opts {
+	kuid_t uid;
+	kgid_t gid;
 	umode_t mode;
 
 	/* BPF token-related delegation options */
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 5359a0929c35d..0a8e1188ea46e 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -601,9 +601,16 @@ EXPORT_SYMBOL(bpf_prog_get_type_path);
 static int bpf_show_options(struct seq_file *m, struct dentry *root)
 {
 	struct bpf_mount_opts *opts = root->d_sb->s_fs_info;
-	umode_t mode = d_inode(root)->i_mode & S_IALLUGO & ~S_ISVTX;
+	struct inode *inode = d_inode(root);
+	umode_t mode = inode->i_mode & S_IALLUGO & ~S_ISVTX;
 	u64 mask;
 
+	if (!uid_eq(inode->i_uid, GLOBAL_ROOT_UID))
+		seq_printf(m, ",uid=%u",
+			   from_kuid_munged(&init_user_ns, inode->i_uid));
+	if (!gid_eq(inode->i_gid, GLOBAL_ROOT_GID))
+		seq_printf(m, ",gid=%u",
+			   from_kgid_munged(&init_user_ns, inode->i_gid));
 	if (mode != S_IRWXUGO)
 		seq_printf(m, ",mode=%o", mode);
 
@@ -652,6 +659,8 @@ const struct super_operations bpf_super_ops = {
 };
 
 enum {
+	OPT_UID,
+	OPT_GID,
 	OPT_MODE,
 	OPT_DELEGATE_CMDS,
 	OPT_DELEGATE_MAPS,
@@ -660,6 +669,8 @@ enum {
 };
 
 static const struct fs_parameter_spec bpf_fs_parameters[] = {
+	fsparam_u32	("uid",				OPT_UID),
+	fsparam_u32	("gid",				OPT_GID),
 	fsparam_u32oct	("mode",			OPT_MODE),
 	fsparam_string	("delegate_cmds",		OPT_DELEGATE_CMDS),
 	fsparam_string	("delegate_maps",		OPT_DELEGATE_MAPS),
@@ -672,6 +683,8 @@ static int bpf_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
 	struct bpf_mount_opts *opts = fc->s_fs_info;
 	struct fs_parse_result result;
+	kuid_t uid;
+	kgid_t gid;
 	int opt, err;
 	u64 msk;
 
@@ -694,6 +707,34 @@ static int bpf_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	}
 
 	switch (opt) {
+	case OPT_UID:
+		uid = make_kuid(current_user_ns(), result.uint_32);
+		if (!uid_valid(uid))
+			goto bad_value;
+
+		/*
+		 * The requested uid must be representable in the
+		 * filesystem's idmapping.
+		 */
+		if (!kuid_has_mapping(fc->user_ns, uid))
+			goto bad_value;
+
+		opts->uid = uid;
+		break;
+	case OPT_GID:
+		gid = make_kgid(current_user_ns(), result.uint_32);
+		if (!gid_valid(gid))
+			goto bad_value;
+
+		/*
+		 * The requested gid must be representable in the
+		 * filesystem's idmapping.
+		 */
+		if (!kgid_has_mapping(fc->user_ns, gid))
+			goto bad_value;
+
+		opts->gid = gid;
+		break;
 	case OPT_MODE:
 		opts->mode = result.uint_32 & S_IALLUGO;
 		break;
@@ -722,6 +763,9 @@ static int bpf_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	}
 
 	return 0;
+
+bad_value:
+	return invalfc(fc, "Bad value for '%s'", param->key);
 }
 
 struct bpf_preload_ops *bpf_preload_ops;
@@ -808,6 +852,8 @@ static int bpf_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_op = &bpf_super_ops;
 
 	inode = sb->s_root->d_inode;
+	inode->i_uid = opts->uid;
+	inode->i_gid = opts->gid;
 	inode->i_op = &bpf_dir_iops;
 	inode->i_mode &= ~S_IALLUGO;
 	populate_bpffs(sb->s_root);
@@ -843,6 +889,8 @@ static int bpf_init_fs_context(struct fs_context *fc)
 		return -ENOMEM;
 
 	opts->mode = S_IRWXUGO;
+	opts->uid = current_fsuid();
+	opts->gid = current_fsgid();
 
 	/* start out with no BPF token delegation enabled */
 	opts->delegate_cmds = 0;
-- 
2.43.0.472.g3155946c3a-goog


