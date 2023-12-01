Return-Path: <bpf+bounces-16371-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 062FF800772
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 10:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5F7A28180C
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 09:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13BA1DFC2;
	Fri,  1 Dec 2023 09:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a3ceOl66"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E894A170D
	for <bpf@vger.kernel.org>; Fri,  1 Dec 2023 01:48:18 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5c210e34088so258139a12.2
        for <bpf@vger.kernel.org>; Fri, 01 Dec 2023 01:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701424098; x=1702028898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uN9KYKY5fhdBjd1H99HmyFWifWzyjkzV7WnDNTXp3Z4=;
        b=a3ceOl66hJICU5j779t3Lh3SDRnMpAKSYWykhxhEqXNcRsfBkN8pvPMRaRI0l+msoW
         HdoGU1wzpTFojGS9ya+5ZKj9ipeJvWsHt0ZqvH6jfhUsdjwSdGU6vqIUgMBMFe84I2oV
         ChZ5FNc7gZGPPNboyKGJHfxmOhxqEphpd0yOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701424098; x=1702028898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uN9KYKY5fhdBjd1H99HmyFWifWzyjkzV7WnDNTXp3Z4=;
        b=LSODs/xUM2PVCaYzUoOUv2sLgw3xQnziebg5j6sd2d0CQyW4e7kro5ip2cU8aEZl8d
         Cs1wc4IjTPFAPPOT3zbwKhGhoibB/iWHy0jJcbgcz0+jmVAuanpAH8f7A1AYqfb044qC
         thifDri5rjdywORE0Ikgyja2uRIqcTp3jI+ulfDlnfEQBJrIM8XaiF2OZvpI5VwVzyBA
         9WPsaVJHtnwTSgSJlUj8D5WJzF5/4ANZpZN7a0zA4Io1wvQiNlua8JOyQt/WlrRNDvEB
         mXf1EkveV87RtHc3BwUYt6uyiiEFHllZG0p+PtDvXFx7R1Kds15dz5BYXnghlgAURthZ
         mu8w==
X-Gm-Message-State: AOJu0YxxakoDEftQwxWf6jN7Eb+P3b6ORDymIZxHAj4A073+qfkrqHIb
	ghT8B0uzrIwEjBlPg1ljxpghZKQkJjfCG5P7h7Bkdw==
X-Google-Smtp-Source: AGHT+IGtWMxDw5w/C2Ms3Mhcw1JA+H/+1uudeOSq0ptQ1nFgawY5EGmr9BWOvkJ/9YJVNPeiYxSarQ==
X-Received: by 2002:a05:6a21:7883:b0:187:932f:e249 with SMTP id bf3-20020a056a21788300b00187932fe249mr33124862pzc.4.1701424098299;
        Fri, 01 Dec 2023 01:48:18 -0800 (PST)
Received: from jiejiang.c.googlers.com.com (148.175.199.104.bc.googleusercontent.com. [104.199.175.148])
        by smtp.gmail.com with ESMTPSA id u17-20020a170902e81100b001bdb85291casm2873936plg.208.2023.12.01.01.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 01:48:18 -0800 (PST)
From: Jie Jiang <jiejiang@chromium.org>
To: bpf@vger.kernel.org
Cc: jiejiang@chromium.org,
	vapier@chromium.org
Subject: [PATCH bpf-next] bpf: Support uid and gid when mounting bpffs
Date: Fri,  1 Dec 2023 09:47:29 +0000
Message-ID: <20231201094729.1312133-1-jiejiang@chromium.org>
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
 kernel/bpf/inode.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 1aafb2ff2e953..826fe48745ee2 100644
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
@@ -662,6 +677,18 @@ static int bpf_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	}
 
 	switch (opt) {
+	case OPT_UID:
+		uid = make_kuid(current_user_ns(), result.uint_32);
+		if (!uid_valid(uid))
+			return invalf(fc, "Unknown uid");
+		opts->uid = uid;
+		break;
+	case OPT_GID:
+		gid = make_kgid(current_user_ns(), result.uint_32);
+		if (!gid_valid(gid))
+			return invalf(fc, "Unknown gid");
+		opts->gid = gid;
+		break;
 	case OPT_MODE:
 		opts->mode = result.uint_32 & S_IALLUGO;
 		break;
@@ -750,6 +777,8 @@ static int bpf_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_op = &bpf_super_ops;
 
 	inode = sb->s_root->d_inode;
+	inode->i_uid = opts->uid;
+	inode->i_gid = opts->gid;
 	inode->i_op = &bpf_dir_iops;
 	inode->i_mode &= ~S_IALLUGO;
 	populate_bpffs(sb->s_root);
-- 
2.43.0.rc2.451.g8631bc7472-goog


