Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE905EB589
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 01:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbiIZXUU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Sep 2022 19:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiIZXTI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 19:19:08 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42572E10AC
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 16:19:02 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 206-20020a250dd7000000b006b4fea0741aso7064692ybn.4
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 16:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=nk1Zjkw1l6yLlzDwoCBLY+mbQh+AroT7f6mkSAjjfdw=;
        b=QKht7feMlhPM6NSkJs1ISW57evz9rQjOROOjcMn3ctgeEtST0kYj3gZBb1NaXz4Rkh
         ewW1HZmo6ML0vkqLIf6TPFcOMCTnUhpBTjk/UhDjQE6mcYDOyUc1210sLgidzBvmidyF
         qoHB7uPhaHu5D8fZIzQfaD/B+BXHWhdXVbj/IWIvLXB/MSgOoQmf7G62vet011zy+KJ5
         9xKxJufJFBaGjuhaXEMzy2SD3m6HXazT+3/rAFZWNuY5UMS63sHBzMWj8FUbys818H1D
         m/MG4pEHxo5C/UsIsFoQg4W/fOs54seJv4kZ6tyY0qb9bzyQV3xSissPyIkUt66gYRJo
         yyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=nk1Zjkw1l6yLlzDwoCBLY+mbQh+AroT7f6mkSAjjfdw=;
        b=uu3u+FPZgNI10VpedidUKAppfv+4Iv3rx9FUHgroZytTHE+ZyVNCFBUSpkCE8HKzgL
         Ibc789Ql61QuS61efvKPA8sFxZREVdDRSaKjN7qYNPgBxoC26P6zXxlj1KRH/R2WvoxI
         zaH/KfuezgoQj2UEX+vSKjueiKkFx+r8M44ZlKvKqbhgVt1N8BHpmyFLshlkI/IXmgg4
         lQqi+ywBg2fNeuY0vXjyrqbaiR1bYOypbh6UQSu0dcCoBEuJTCtnRou4N1qEIg6sc975
         fh7+HTDefnEkYuWIB+flMe7YMLA72LUJm+lFF5RGdUdFz75fZsMuiJbpuS1fYcwJ4cvg
         gk8Q==
X-Gm-Message-State: ACrzQf3tvTLoYNlAqTLgg5JxTPG/0wCOrEXSkYNW+82AvX7SHtq3lDvV
        hXOmlVT/knGQCWtpleLeac2TtvaenzI=
X-Google-Smtp-Source: AMsMyM6LqrMevZ36hDHWLICfUMT5+8bBIszZJdal6Zzw2ttCe0cz3Tdag4GAr4qwHEClXeJMSF1GimjUBu8=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:200:4643:a68e:2b7:f873])
 (user=drosen job=sendgmr) by 2002:a0d:c5c1:0:b0:350:8a38:7edf with SMTP id
 h184-20020a0dc5c1000000b003508a387edfmr12164057ywd.209.1664234341576; Mon, 26
 Sep 2022 16:19:01 -0700 (PDT)
Date:   Mon, 26 Sep 2022 16:18:08 -0700
In-Reply-To: <20220926231822.994383-1-drosen@google.com>
Mime-Version: 1.0
References: <20220926231822.994383-1-drosen@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220926231822.994383-13-drosen@google.com>
Subject: [PATCH 12/26] fuse-bpf: Add support for fallocate
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

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/backing.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/file.c    | 10 ++++++++++
 fs/fuse/fuse_i.h  | 11 +++++++++++
 3 files changed, 69 insertions(+)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index 97e92c633cfd..95c60d6d7597 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -188,6 +188,54 @@ ssize_t fuse_backing_mmap(struct file *file, struct vm_area_struct *vma)
 	return ret;
 }
 
+int fuse_file_fallocate_initialize_in(struct bpf_fuse_args *fa,
+				      struct fuse_fallocate_in *ffi,
+				      struct file *file, int mode, loff_t offset, loff_t length)
+{
+	struct fuse_file *ff = file->private_data;
+
+	*ffi = (struct fuse_fallocate_in) {
+		.fh = ff->fh,
+		.offset = offset,
+		.length = length,
+		.mode = mode,
+	};
+
+	*fa = (struct bpf_fuse_args) {
+		.opcode = FUSE_FALLOCATE,
+		.nodeid = ff->nodeid,
+		.in_numargs = 1,
+		.in_args[0].size = sizeof(*ffi),
+		.in_args[0].value = ffi,
+	};
+
+	return 0;
+}
+
+int fuse_file_fallocate_initialize_out(struct bpf_fuse_args *fa,
+				       struct fuse_fallocate_in *ffi,
+				       struct file *file, int mode, loff_t offset, loff_t length)
+{
+	return 0;
+}
+
+int fuse_file_fallocate_backing(struct bpf_fuse_args *fa, int *out,
+				struct file *file, int mode, loff_t offset, loff_t length)
+{
+	const struct fuse_fallocate_in *ffi = fa->in_args[0].value;
+	struct fuse_file *ff = file->private_data;
+
+	*out = vfs_fallocate(ff->backing_file, ffi->mode, ffi->offset,
+			     ffi->length);
+	return 0;
+}
+
+int fuse_file_fallocate_finalize(struct bpf_fuse_args *fa, int *out,
+				 struct file *file, int mode, loff_t offset, loff_t length)
+{
+	return 0;
+}
+
 /*******************************************************************************
  * Directory operations after here                                             *
  ******************************************************************************/
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index dd4485261cc7..ef6f6b0b3b59 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3002,6 +3002,16 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 
 	bool block_faults = FUSE_IS_DAX(inode) && lock_inode;
 
+#ifdef CONFIG_FUSE_BPF
+	if (fuse_bpf_backing(inode, struct fuse_fallocate_in, err,
+			       fuse_file_fallocate_initialize_in,
+			       fuse_file_fallocate_initialize_out,
+			       fuse_file_fallocate_backing,
+			       fuse_file_fallocate_finalize,
+			       file, mode, offset, length))
+		return err;
+#endif
+
 	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
 		     FALLOC_FL_ZERO_RANGE))
 		return -EOPNOTSUPP;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index fc3e8adf0422..0e4996766c6c 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1422,6 +1422,17 @@ int fuse_lseek_finalize(struct bpf_fuse_args *fa, loff_t *out, struct file *file
 
 ssize_t fuse_backing_mmap(struct file *file, struct vm_area_struct *vma);
 
+int fuse_file_fallocate_initialize_in(struct bpf_fuse_args *fa,
+				      struct fuse_fallocate_in *ffi,
+				      struct file *file, int mode, loff_t offset, loff_t length);
+int fuse_file_fallocate_initialize_out(struct bpf_fuse_args *fa,
+				       struct fuse_fallocate_in *ffi,
+				       struct file *file, int mode, loff_t offset, loff_t length);
+int fuse_file_fallocate_backing(struct bpf_fuse_args *fa, int *out,
+				struct file *file, int mode, loff_t offset, loff_t length);
+int fuse_file_fallocate_finalize(struct bpf_fuse_args *fa, int *out,
+				 struct file *file, int mode, loff_t offset, loff_t length);
+
 struct fuse_lookup_io {
 	struct fuse_entry_out feo;
 	struct fuse_entry_bpf feb;
-- 
2.37.3.998.g577e59143f-goog

