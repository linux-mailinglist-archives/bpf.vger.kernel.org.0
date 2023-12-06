Return-Path: <bpf+bounces-16856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6A2806880
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 08:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9132B20FA1
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 07:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23FC1774C;
	Wed,  6 Dec 2023 07:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="akgJFUuk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD4112F
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 23:36:42 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3b8b782e142so2712315b6e.1
        for <bpf@vger.kernel.org>; Tue, 05 Dec 2023 23:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701848202; x=1702453002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=53xT+tACp9bpHBMupfbbNcF0fz1mPBkKr9Ih+WmgKHs=;
        b=akgJFUukuj/gpLAbGAhJMpmzOlv+II6Kmy5bHgz7D89Xyyf6//syVXewuG2Nd7mg/s
         1Uahz5KRLtjgFDR5ZrKIkB5Mo0bVe+1eYNkXhsyIaOsQJci0gt4AF+UhReSJklSy5sKt
         gSfkcYj9rSUYggtrvfRrMM0QdZCOSE4bl6Ic4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701848202; x=1702453002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=53xT+tACp9bpHBMupfbbNcF0fz1mPBkKr9Ih+WmgKHs=;
        b=cCurGfpZWYuGXR+8nW9M4wz2+kc1ozETuE8uRa7Kt5MSg7mgN5O9A8IEMQzh2oFawv
         hINODHLYkFwvyjYjjhiZpDcUSCBRn1rVsz8YraBTu+PS6oVSbKMc6FK0jhVGwl0v+GCm
         LonDQRQEMFo7ktAUuu98wOfiV8gHYz5WwRjmwJkE8J412kT5EMoE0f9hg1UM/z12+sJr
         KWPym4umKL2nJuzBnUZB15iqs75Rupj0FNJYUDLGDuOT1o5hStAITtoWQLgIpNA9yCgY
         wBiDWvAzFWg880rNCaaiFfRqYXKnDwtLMT2hSsvLafq+Rs1Hn3ZSpaioGZIF/Ozoz41u
         APig==
X-Gm-Message-State: AOJu0Yy64AORw5e9cFYp+g3y2rQ/8F8Eb2MQHeCXe+0UZgRmsoGt/vVt
	bQBVZsJL32p1SsuPTSXoE2Z6J7THtHkbU+fT+VD2Tg==
X-Google-Smtp-Source: AGHT+IFE4NmNEQQQlJ0+b/Jzlkz+gCIJ96U3CDpu7OFoA9cydGlVxHU0j62KilTOufc6C6dWjOkFnw==
X-Received: by 2002:a05:6808:1203:b0:3b8:b063:ae03 with SMTP id a3-20020a056808120300b003b8b063ae03mr812621oil.96.1701848202009;
        Tue, 05 Dec 2023 23:36:42 -0800 (PST)
Received: from jiejiang.c.googlers.com.com (148.175.199.104.bc.googleusercontent.com. [104.199.175.148])
        by smtp.gmail.com with ESMTPSA id q7-20020a056a0002a700b00688435a9915sm6224675pfs.189.2023.12.05.23.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 23:36:41 -0800 (PST)
From: Jie Jiang <jiejiang@chromium.org>
To: bpf@vger.kernel.org
Cc: jiejiang@chromium.org,
	vapier@chromium.org,
	brauner@kernel.org,
	andrii@kernel.org
Subject: [PATCH bpf-next v2] bpf: Support uid and gid when mounting bpffs
Date: Wed,  6 Dec 2023 07:36:24 +0000
Message-ID: <20231206073624.149124-1-jiejiang@chromium.org>
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
---
v1 -> v2: Add additional validation in bpf_parse_param() for if the
  requested uid/gid is representable in the fs's idmapping.

 kernel/bpf/inode.c | 52 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)


diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 1aafb2ff2e953..5bc79535d3357 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -599,8 +599,15 @@ EXPORT_SYMBOL(bpf_prog_get_type_path);
  */
 static int bpf_show_options(struct seq_file *m, struct dentry *root)
 {
-	umode_t mode = d_inode(root)->i_mode & S_IALLUGO & ~S_ISVTX;
-
+	struct inode *inode = d_inode(root);
+	umode_t mode = inode->i_mode & S_IALLUGO & ~S_ISVTX;
+
+	if (!uid_eq(inode->i_uid, GLOBAL_ROOT_UID))
+		seq_printf(m, ",uid=%u",
+			   from_kuid_munged(&init_user_ns, inode->i_uid));
+	if (!gid_eq(inode->i_gid, GLOBAL_ROOT_GID))
+		seq_printf(m, ",gid=%u",
+			   from_kgid_munged(&init_user_ns, inode->i_gid));
 	if (mode != S_IRWXUGO)
 		seq_printf(m, ",mode=%o", mode);
 	return 0;
@@ -625,15 +632,21 @@ static const struct super_operations bpf_super_ops = {
 };
 
 enum {
+	OPT_UID,
+	OPT_GID,
 	OPT_MODE,
 };
 
 static const struct fs_parameter_spec bpf_fs_parameters[] = {
+	fsparam_u32	("gid",				OPT_GID),
 	fsparam_u32oct	("mode",			OPT_MODE),
+	fsparam_u32	("uid",				OPT_UID),
 	{}
 };
 
 struct bpf_mount_opts {
+	kuid_t uid;
+	kgid_t gid;
 	umode_t mode;
 };
 
@@ -641,6 +654,8 @@ static int bpf_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
 	struct bpf_mount_opts *opts = fc->fs_private;
 	struct fs_parse_result result;
+	kuid_t uid;
+	kgid_t gid;
 	int opt;
 
 	opt = fs_parse(fc, bpf_fs_parameters, param, &result);
@@ -662,12 +677,43 @@ static int bpf_parse_param(struct fs_context *fc, struct fs_parameter *param)
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
 	}
 
 	return 0;
+
+bad_value:
+	return invalfc(fc, "Bad value for '%s'", param->key);
 }
 
 struct bpf_preload_ops *bpf_preload_ops;
@@ -750,6 +796,8 @@ static int bpf_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_op = &bpf_super_ops;
 
 	inode = sb->s_root->d_inode;
+	inode->i_uid = opts->uid;
+	inode->i_gid = opts->gid;
 	inode->i_op = &bpf_dir_iops;
 	inode->i_mode &= ~S_IALLUGO;
 	populate_bpffs(sb->s_root);
-- 
2.43.0.rc2.451.g8631bc7472-goog


