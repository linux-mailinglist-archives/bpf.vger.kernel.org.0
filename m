Return-Path: <bpf+bounces-16981-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2B4807F65
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 04:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC6711F21167
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 03:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEFB538F;
	Thu,  7 Dec 2023 03:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QGS4TxR3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB06BD73
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 19:57:49 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2866fe08b32so439648a91.2
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 19:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701921469; x=1702526269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yZXJV2JZaxuswUALccafvfhGXpBSrIE0Aux5jm8YJf0=;
        b=QGS4TxR3r2oEd+ZF0ZC+XAlHfCfMHTx1sbH1Zn0thIHWcwR/8tWipg9mRWqSRAsroK
         UH8dceE1OmcAnliFfPATM0fmhaFmcT7Hru/484oy39ynQRoz7puYf+uNxWO+RcpvXxWu
         RTJdUX89ncnn+8QOpyLvHM8W8nA1bITplOnDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701921469; x=1702526269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yZXJV2JZaxuswUALccafvfhGXpBSrIE0Aux5jm8YJf0=;
        b=HDUZQiYAwoFQ+14dIpINeOUYYuKO8pJS8FxboUEu5c52fxKFfvplpi8PqCPM8jSAW9
         dLzfuru4yETclpo8vXvTtS+W/fkg3NA8mY0KlIeSD2orFAc+izyiCQX9fWB5C2I9nrmo
         Qi8AgPtrazCduEGoopAAn/zRhVB6gt1f39apn3hW73+Xbr/MwOsK79HQkV2FlfIYlHVa
         pHd3d8AEuH555/F6hMEql1QqqjCRhzrx59JEOy5nVV2pSQU9fgqt+BnJ8F2v4Z4mwLW6
         xU20sTX9XtqQ+KWUbb7qZ6clzr7kcnsFRZ2a7A12SGZ95G7lSQNLgU1B+FfYXUwi8x31
         h0kA==
X-Gm-Message-State: AOJu0YyJiEhC+LRgPTjvLI1LDPsFbOwQWC4+G8pcuXCk9dW0senTUvG5
	aDsOLO0MK74rtCmDMKk/cWGba1O9fzIqOlur/SFw0Q==
X-Google-Smtp-Source: AGHT+IG0L9iYkbSPHwgJ73H2q3zaWyZDFzh3TG5EMqbqqO8VeXb8ao0p+D84i3OpWHwIJMas+b9Kdw==
X-Received: by 2002:a17:90a:1cd:b0:286:f3d8:de3f with SMTP id 13-20020a17090a01cd00b00286f3d8de3fmr1504852pjd.84.1701921469045;
        Wed, 06 Dec 2023 19:57:49 -0800 (PST)
Received: from jiejiang.c.googlers.com.com (148.175.199.104.bc.googleusercontent.com. [104.199.175.148])
        by smtp.gmail.com with ESMTPSA id ju1-20020a170903428100b001cfd35ec1d7sm228118plb.243.2023.12.06.19.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 19:57:48 -0800 (PST)
From: Jie Jiang <jiejiang@chromium.org>
To: bpf@vger.kernel.org
Cc: jiejiang@chromium.org,
	vapier@chromium.org,
	brauner@kernel.org,
	andrii@kernel.org,
	ast@kernel.org
Subject: [PATCH bpf-next v3] bpf: Support uid and gid when mounting bpffs
Date: Thu,  7 Dec 2023 03:57:06 +0000
Message-ID: <20231207035706.2797103-1-jiejiang@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
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
v2 -> v3: Rebase to resolve conflicts.
v1 -> v2: Add additional validation in bpf_parse_param() for if the
  requested uid/gid is representable in the fs's idmapping.

 include/linux/bpf.h |  2 ++
 kernel/bpf/inode.c  | 48 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 49 insertions(+), 1 deletion(-)

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
index 5359a0929c35d..273d7e0cfbde0 100644
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
-- 
2.43.0.rc2.451.g8631bc7472-goog


