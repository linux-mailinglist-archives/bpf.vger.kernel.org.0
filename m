Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0911321D677
	for <lists+bpf@lfdr.de>; Mon, 13 Jul 2020 15:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbgGMNF0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jul 2020 09:05:26 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50711 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729523AbgGMNF0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Jul 2020 09:05:26 -0400
Received: by mail-wm1-f66.google.com with SMTP id l17so13257975wmj.0;
        Mon, 13 Jul 2020 06:05:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mYPVA3/IWlt5/iqZ14/INuvJMoGowNHfOcbfoeDX1w4=;
        b=Z8+SOk+ddRMOxuGvqY//U2agvdda/z2FjAQsjbM7y8jpNdzw3pWsvFkBMdtXmJ3bU0
         nRNLnnI0yqw/5V3OEaQhtI9fkp4P3f9FvPM2v/WneUA7T//pUg6+497e6OJfZJzcqYrd
         yRI5A5P6QNTUIeWtKCNT8xM91/ejFHdD/2DVWhja3mrnNUlWKBiP92qY6uuS4BGWX/qx
         AVgKRVdFGvPaJIg9SV3yjnEjJpK7c9cv7nNUMelw8tADlBliFV351UTOAMFQ8suF0gRN
         PHOmwrF7YfY+YmtQsO3zHeA0xcVx2V0/2zwg83IdS4rnxfEq7s0U7Af9NXrTfYDBi4Ag
         Tobg==
X-Gm-Message-State: AOAM5304nFRzTRmv/rwnkS3zqaZlQcidBQqaLPy+DQXADeAEzyWkCbeV
        B2/SxJXQ2lSwkZLYK3Zw9quW3Z9RJic=
X-Google-Smtp-Source: ABdhPJz85xPwE/oBrRjnLqeI3v2s5MzJRWpQlOsdY+4ARsW45oGFKS9vsKmoCJp8fjwB/7owbWTW6g==
X-Received: by 2002:a7b:c952:: with SMTP id i18mr20098254wml.65.1594645522770;
        Mon, 13 Jul 2020 06:05:22 -0700 (PDT)
Received: from msft-t490s.lan ([2001:b07:5d26:7f46:d7c1:f090:1563:f81f])
        by smtp.gmail.com with ESMTPSA id g14sm24237208wrm.93.2020.07.13.06.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 06:05:21 -0700 (PDT)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     bpf@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next] bpf: allow loading instructions from a fd
Date:   Mon, 13 Jul 2020 15:05:11 +0200
Message-Id: <20200713130511.6942-1-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

Allow to load the BPF instructons from a file descriptor,
other than a pointer.

This is required by the Integrity Subsystem to validate the source of
the instructions.

In bpf_attr replace 'insns', which is an u64, to a union containing also
the file descriptor as int.
A new BPF_F_LOAD_BY_FD flag tells bpf_prog_load() to load
the instructions from file descriptor and ignore the pointer.

As BPF files usually are regular ELF files, start reading from the
current file position, so the userspace can skip the ELF header and jump
to the right section.

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 include/uapi/linux/bpf.h | 10 +++++-
 kernel/bpf/syscall.c     | 69 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 73 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 8bd33050b7bb..4ef75198db21 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -332,6 +332,11 @@ enum bpf_link_type {
 /* The verifier internal test flag. Behavior is undefined */
 #define BPF_F_TEST_STATE_FREQ	(1U << 3)
 
+/* The BPF is loaded by the file descriptor in `prog_bpf_fd`
+ * instead of the buffer pointed by `insns`.
+ */
+#define BPF_F_LOAD_BY_FD	(1U << 4)
+
 /* When BPF ldimm64's insn[0].src_reg != 0 then this can have
  * two extensions:
  *
@@ -482,7 +487,10 @@ union bpf_attr {
 	struct { /* anonymous struct used by BPF_PROG_LOAD command */
 		__u32		prog_type;	/* one of enum bpf_prog_type */
 		__u32		insn_cnt;
-		__aligned_u64	insns;
+		union {
+			__aligned_u64	insns;		/* BPF instructions */
+			__u32		prog_bpf_fd;	/* fd pointing to BPF program */
+		};
 		__aligned_u64	license;
 		__u32		log_level;	/* verbosity level of verifier */
 		__u32		log_size;	/* size of user buffer */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0fd80ac81f70..b6b1ce34a72b 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -24,6 +24,7 @@
 #include <linux/ctype.h>
 #include <linux/nospec.h>
 #include <linux/audit.h>
+#include <linux/stat.h>
 #include <uapi/linux/btf.h>
 #include <linux/pgtable.h>
 #include <linux/bpf_lsm.h>
@@ -2082,6 +2083,55 @@ static bool is_perfmon_prog_type(enum bpf_prog_type prog_type)
 /* last field in 'union bpf_attr' used by this command */
 #define	BPF_PROG_LOAD_LAST_FIELD attach_prog_fd
 
+static int bpf_load_from_fd(u32 fd, void *buf, loff_t insn_cnt)
+{
+	ssize_t bytes, total = 0;
+	struct fd f = fdget(fd);
+	int ret = 0;
+	loff_t pos;
+
+	if (!f.file)
+		return -EBADF;
+
+	if (!S_ISREG(file_inode(f.file)->i_mode)) {
+		ret = -EINVAL;
+		goto out_fd;
+	}
+
+	ret = deny_write_access(f.file);
+	if (ret)
+		goto out_fd;
+
+	ret = security_kernel_read_file(f.file, READING_UNKNOWN);
+	if (ret)
+		goto out;
+
+	pos = f.file->f_pos;
+
+	while (total < insn_cnt) {
+		bytes = kernel_read(f.file, buf + total, insn_cnt - total, &pos);
+		if (bytes < 0) {
+			ret = bytes;
+			goto out;
+		}
+
+		if (bytes == 0)
+			break;
+
+		total += bytes;
+		pos += bytes;
+	}
+
+	if (total != insn_cnt)
+		ret = -EIO;
+
+out:
+	allow_write_access(f.file);
+out_fd:
+	fdput(f);
+	return ret;
+}
+
 static int bpf_prog_load(union bpf_attr *attr, union bpf_attr __user *uattr)
 {
 	enum bpf_prog_type type = attr->prog_type;
@@ -2096,7 +2146,8 @@ static int bpf_prog_load(union bpf_attr *attr, union bpf_attr __user *uattr)
 	if (attr->prog_flags & ~(BPF_F_STRICT_ALIGNMENT |
 				 BPF_F_ANY_ALIGNMENT |
 				 BPF_F_TEST_STATE_FREQ |
-				 BPF_F_TEST_RND_HI32))
+				 BPF_F_TEST_RND_HI32 |
+				 BPF_F_LOAD_BY_FD))
 		return -EINVAL;
 
 	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) &&
@@ -2162,10 +2213,18 @@ static int bpf_prog_load(union bpf_attr *attr, union bpf_attr __user *uattr)
 
 	prog->len = attr->insn_cnt;
 
-	err = -EFAULT;
-	if (copy_from_user(prog->insns, u64_to_user_ptr(attr->insns),
-			   bpf_prog_insn_size(prog)) != 0)
-		goto free_prog;
+	if (attr->prog_flags & BPF_F_LOAD_BY_FD) {
+		err = bpf_load_from_fd(attr->prog_bpf_fd, (void *)prog->insns,
+				       bpf_prog_insn_size(prog));
+		if (err)
+			goto free_prog;
+	} else {
+		if (copy_from_user(prog->insns, u64_to_user_ptr(attr->insns),
+				   bpf_prog_insn_size(prog)) != 0) {
+			err = -EFAULT;
+			goto free_prog;
+		}
+	}
 
 	prog->orig_prog = NULL;
 	prog->jited = 0;
-- 
2.26.2

