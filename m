Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5E85EB57E
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 01:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbiIZXTx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Sep 2022 19:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbiIZXTG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 19:19:06 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B03D70FD
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 16:18:56 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id w14-20020a170902e88e00b00177ab7a12f6so5174105plg.16
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 16:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=X+V+rjagupOsGXK+w8MXna7CMidJPhkAi0fk+lgEZBA=;
        b=qv/E5vXFkhxR5QvPGwvWrChHYpzqYXWbpF5AvuxhD5oW4WHxmmI1OPCK+zVLccyxpQ
         70P8uKQVe9p+jjCPGgpYYluyB7Bs8yFtj7IiCTWYB8eN+RBfa/8JMPdDzn8RQ/JSWk6h
         bAFUWLI3gTXLm9A9xnGHDKGD4PXFm6Zabyn0X+K27UzGDN0+OSKnlGj/eEFTadNo3C8K
         49J1NwErtoUzVemb2sqAwCTQI/2Zwd5Ow4yP8MiEF3KXhFks30uWXD/KrpVQaGcaAxZs
         pPLLVaggu7osT/b8guwSgxWhd5j2+t2/PVd10x1ED46DEdwTvFngr4k7OGCcZvF3tuDq
         +JgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=X+V+rjagupOsGXK+w8MXna7CMidJPhkAi0fk+lgEZBA=;
        b=Gjy8j9t8phoYbhlj7XTmCJXClrKkRnvLnyDABPyLVvDj+nz2Jf0U9iPvTtpXfP3lQu
         WclmHNpecYDGPmYEwB3qcM8gRNPJfLdAu/2FsDxxwT7u+NL6cYP4TF2Zfi783OaujYJD
         FWa8p+ZRAz50Es2IzjvE7PhAzNvyRAG90qcBW/4ZpXgT4MgYPL6s+Rhou/rBMQ7jr6pF
         i/g2Qy9vjqpuVU9arCgaJUCLukDRfPXzh1JdutrHcLxlXDGKRV3YkjqicSix44B84j5Q
         L5xz0CDSIRzoBTd5QvCXqv4gYzt8h1jsaFBQLmm9VLPLi9fOr2NgMx8a222utVd1kgfJ
         yDfQ==
X-Gm-Message-State: ACrzQf1Qd1d+y1L/F9sYXl1VW5AZzbskC5qSttdWYFu5a0M+8oyCRaCr
        N9RpFA9nk1qJrSbG0UhEJaH4RbgbfyU=
X-Google-Smtp-Source: AMsMyM7OXl+IFw2HF4iotZxmOMrRMbE3M4zRYrR3Z0qM/C0QTbRpWqi6Mvvu2NO8Sm0yQmskBLjtHPmCpSk=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:200:4643:a68e:2b7:f873])
 (user=drosen job=sendgmr) by 2002:a62:1c8f:0:b0:537:2284:bd00 with SMTP id
 c137-20020a621c8f000000b005372284bd00mr26113356pfc.78.1664234336158; Mon, 26
 Sep 2022 16:18:56 -0700 (PDT)
Date:   Mon, 26 Sep 2022 16:18:06 -0700
In-Reply-To: <20220926231822.994383-1-drosen@google.com>
Mime-Version: 1.0
References: <20220926231822.994383-1-drosen@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220926231822.994383-11-drosen@google.com>
Subject: [PATCH 10/26] fuse-bpf: Partially add mapping support
From:   Daniel Rosenberg <drosen@google.com>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@google.com>,
        David Anderson <dvander@google.com>,
        Sandeep Patil <sspatil@google.com>,
        linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@android.com
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

This adds a backing implementation for mapping, but no bpf counterpart
yet.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/backing.c | 37 +++++++++++++++++++++++++++++++++++++
 fs/fuse/file.c    |  6 ++++++
 fs/fuse/fuse_i.h  |  3 +++
 3 files changed, 46 insertions(+)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index 51088701e7ad..fa8805e24061 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -77,6 +77,43 @@ int parse_fuse_entry_bpf(struct fuse_entry_bpf *feb)
 	return err;
 }
 
+ssize_t fuse_backing_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	int ret;
+	struct fuse_file *ff = file->private_data;
+	struct inode *fuse_inode = file_inode(file);
+	struct file *backing_file = ff->backing_file;
+	struct inode *backing_inode = file_inode(backing_file);
+
+	if (!backing_file->f_op->mmap)
+		return -ENODEV;
+
+	if (WARN_ON(file != vma->vm_file))
+		return -EIO;
+
+	vma->vm_file = get_file(backing_file);
+
+	ret = call_mmap(vma->vm_file, vma);
+
+	if (ret)
+		fput(backing_file);
+	else
+		fput(file);
+
+	if (file->f_flags & O_NOATIME)
+		return ret;
+
+	if ((!timespec64_equal(&fuse_inode->i_mtime, &backing_inode->i_mtime) ||
+	     !timespec64_equal(&fuse_inode->i_ctime,
+			       &backing_inode->i_ctime))) {
+		fuse_inode->i_mtime = backing_inode->i_mtime;
+		fuse_inode->i_ctime = backing_inode->i_ctime;
+	}
+	touch_atime(&file->f_path);
+
+	return ret;
+}
+
 /*******************************************************************************
  * Directory operations after here                                             *
  ******************************************************************************/
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 4fa2ebc068f0..138890eae07c 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2452,6 +2452,12 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 	if (FUSE_IS_DAX(file_inode(file)))
 		return fuse_dax_mmap(file, vma);
 
+#ifdef CONFIG_FUSE_BPF
+	/* TODO - this is simply passthrough, not a proper BPF filter */
+	if (ff->backing_file)
+		return fuse_backing_mmap(file, vma);
+#endif
+
 	if (ff->open_flags & FOPEN_DIRECT_IO) {
 		/* Can't provide the coherency needed for MAP_SHARED */
 		if (vma->vm_flags & VM_MAYSHARE)
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 30ddc298fb27..a9653f71c145 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1404,8 +1404,11 @@ struct fuse_entry_bpf {
 	struct bpf_prog *bpf;
 };
 
+
 int parse_fuse_entry_bpf(struct fuse_entry_bpf *feb);
 
+ssize_t fuse_backing_mmap(struct file *file, struct vm_area_struct *vma);
+
 struct fuse_lookup_io {
 	struct fuse_entry_out feo;
 	struct fuse_entry_bpf feb;
-- 
2.37.3.998.g577e59143f-goog

