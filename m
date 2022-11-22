Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6AB6332FF
	for <lists+bpf@lfdr.de>; Tue, 22 Nov 2022 03:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbiKVCRv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 21:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbiKVCRC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 21:17:02 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CB6E674E
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 18:16:15 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id p188-20020a2542c5000000b006ea37a57e20so6626860yba.13
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 18:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mBD6bGviTnQaNR8TlIrtDcNsv7AoSToN0hwSmPU39NM=;
        b=oKcvpaX8yBxVrqjzpCwp8hRJbcWcrVDPsDHSTtU/JumfrQNEB9LNqF2bZQDgm66L23
         ezgqXB2c8vNVR5Ss+f0VlAAkX7XbGHrjbnnMn7F2oqVZtP8ZWNt7oydnS1QJUerPmQrw
         wZlW7iK35Eki/V2aGDIyRlsqTBNDWVYquyeLToqnZuW5Dk/b7LAie/wJsfzS3DkKBD2Z
         UTRBDxexsXEWuJSNee5jmYV9WWIOxyhAQPI0DgGAvgfFII8jVxgE22HiU1GNrHiYDYUL
         1O33KGWuGc2xU5ucwwHWvW+lMdsOuhQ+wShSsdOzU36NkBFSAmPL0D30z2fGKF6c0j0K
         MJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mBD6bGviTnQaNR8TlIrtDcNsv7AoSToN0hwSmPU39NM=;
        b=xrop3iZeNv/XsOh6/u6HSVN524UcfexyGArxhKJs/40Po0KVzcBaBmTCcRVdvslPK9
         zSedd7ptAl5AHcmooFUHjT3Js7j8RXfPJLd1R32l2GhcScS1ZIS7PUdpShnymjd1Dffj
         O3+XsB6LnzHG/FeFA50yo0JF9CP3vR/ljqE4l5PE2Zp4+WaqXtnoK5DlLXtyl9U7ZdLd
         jwbdv3yWwgr7Pqf+rZKiZUuDQm/ei64vcKOyqfDL6BwvSc0Jr/UTLnbFqJeZfJ2bT3mo
         ztIoGIBDcSpYFPlweypGg8NLcNCXlNw6LXdXquQwBjwqu/w5Kos/fjnebMjYkSMGihs4
         C0gg==
X-Gm-Message-State: ACrzQf3AdevCPD3yrfWj3tZVhpJhX9ct7luDfimdAXi0XDDA6x59Jrcm
        EMlprnmhrvDz3y9rFpf9GSXWFES+DIM=
X-Google-Smtp-Source: AMsMyM4Kn48IaLW3aQ/ISb02XRlP+7K9GeYY53FXTg2JD7CCTW1NuBvn0mi2FPfdwt99RzojkrLJTecFwGg=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:200:8539:aadd:13be:6e82])
 (user=drosen job=sendgmr) by 2002:a81:86c2:0:b0:332:a104:f7e4 with SMTP id
 w185-20020a8186c2000000b00332a104f7e4mr66525980ywf.505.1669083374599; Mon, 21
 Nov 2022 18:16:14 -0800 (PST)
Date:   Mon, 21 Nov 2022 18:15:24 -0800
In-Reply-To: <20221122021536.1629178-1-drosen@google.com>
Mime-Version: 1.0
References: <20221122021536.1629178-1-drosen@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221122021536.1629178-10-drosen@google.com>
Subject: [RFC PATCH v2 09/21] fuse-bpf: Add lseek support
From:   Daniel Rosenberg <drosen@google.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/backing.c | 88 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/file.c    |  3 ++
 fs/fuse/fuse_i.h  |  6 ++++
 3 files changed, 97 insertions(+)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index 8d862bc64acd..76f48872ed35 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -205,6 +205,94 @@ static void fuse_stat_to_attr(struct fuse_conn *fc, struct inode *inode,
 	attr->blksize = 1 << blkbits;
 }
 
+struct fuse_lseek_io {
+	struct fuse_lseek_in fli;
+	struct fuse_lseek_out flo;
+};
+
+static int fuse_lseek_initialize_in(struct fuse_args *fa, struct fuse_lseek_io *flio,
+				    struct file *file, loff_t offset, int whence)
+{
+	struct fuse_file *fuse_file = file->private_data;
+
+	flio->fli = (struct fuse_lseek_in) {
+		.fh = fuse_file->fh,
+		.offset = offset,
+		.whence = whence,
+	};
+
+	*fa = (struct fuse_args) {
+		.nodeid = get_node_id(file->f_inode),
+		.opcode = FUSE_LSEEK,
+		.in_numargs = 1,
+		.in_args[0].size = sizeof(flio->fli),
+		.in_args[0].value = &flio->fli,
+	};
+
+	return 0;
+}
+
+static int fuse_lseek_initialize_out(struct fuse_args *fa, struct fuse_lseek_io *flio,
+				     struct file *file, loff_t offset, int whence)
+{
+	fa->out_numargs = 1;
+	fa->out_args[0].size = sizeof(flio->flo);
+	fa->out_args[0].value = &flio->flo;
+
+	return 0;
+}
+
+static int fuse_lseek_backing(struct fuse_args *fa, loff_t *out,
+			      struct file *file, loff_t offset, int whence)
+{
+	const struct fuse_lseek_in *fli = fa->in_args[0].value;
+	struct fuse_lseek_out *flo = fa->out_args[0].value;
+	struct fuse_file *fuse_file = file->private_data;
+	struct file *backing_file = fuse_file->backing_file;
+
+	/* TODO: Handle changing of the file handle */
+	if (offset == 0) {
+		if (whence == SEEK_CUR) {
+			flo->offset = file->f_pos;
+			*out = flo->offset;
+			return 0;
+		}
+
+		if (whence == SEEK_SET) {
+			flo->offset = vfs_setpos(file, 0, 0);
+			*out = flo->offset;
+			return 0;
+		}
+	}
+
+	inode_lock(file->f_inode);
+	backing_file->f_pos = file->f_pos;
+	*out = vfs_llseek(backing_file, fli->offset, fli->whence);
+	flo->offset = *out;
+	inode_unlock(file->f_inode);
+	return 0;
+}
+
+static int fuse_lseek_finalize(struct fuse_args *fa, loff_t *out,
+			       struct file *file, loff_t offset, int whence)
+{
+	struct fuse_lseek_out *flo = fa->out_args[0].value;
+
+	if (!fa->error_in)
+		file->f_pos = flo->offset;
+	*out = flo->offset;
+	return 0;
+}
+
+int fuse_bpf_lseek(loff_t *out, struct inode *inode, struct file *file, loff_t offset, int whence)
+{
+	return fuse_bpf_backing(inode, struct fuse_lseek_io, out,
+				fuse_lseek_initialize_in, fuse_lseek_initialize_out,
+				fuse_lseek_backing,
+				fuse_lseek_finalize,
+				file, offset, whence);
+}
+
 ssize_t fuse_backing_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	int ret;
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 24fd4f33105c..e90b3e2d5452 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2704,6 +2704,9 @@ static loff_t fuse_file_llseek(struct file *file, loff_t offset, int whence)
 	loff_t retval;
 	struct inode *inode = file_inode(file);
 
+	if (fuse_bpf_lseek(&retval, inode, file, offset, whence))
+		return retval;
+
 	switch (whence) {
 	case SEEK_SET:
 	case SEEK_CUR:
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 95d67afcff05..108c2ea15a49 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1400,11 +1400,17 @@ int parse_fuse_bpf_entry(struct fuse_bpf_entry *fbe, int num_entries);
 
 #ifdef CONFIG_FUSE_BPF
 
+int fuse_bpf_lseek(loff_t *out, struct inode *inode, struct file *file, loff_t offset, int whence);
 int fuse_bpf_lookup(struct dentry **out, struct inode *dir, struct dentry *entry, unsigned int flags);
 int fuse_bpf_access(int *out, struct inode *inode, int mask);
 
 #else
 
+static inline int fuse_bpf_lseek(loff_t *out, struct inode *inode, struct file *file, loff_t offset, int whence)
+{
+	return 0;
+}
+
 static inline int fuse_bpf_lookup(struct dentry **out, struct inode *dir, struct dentry *entry, unsigned int flags)
 {
 	return 0;
-- 
2.38.1.584.g0f3c55d4c2-goog

