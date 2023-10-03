Return-Path: <bpf+bounces-11252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E65F37B6490
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 10:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 44958281779
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 08:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D632DDB2;
	Tue,  3 Oct 2023 08:44:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EE33FC2
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 08:44:34 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC78BD;
	Tue,  3 Oct 2023 01:44:31 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c3d8fb23d9so4974435ad.0;
        Tue, 03 Oct 2023 01:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696322671; x=1696927471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=forSh8N1C+dIxQ58h4NORFcN5/NjK9xQ8ABzqSG+rNM=;
        b=NJAGUNoVcJNaeAwDna4NgzMGoWB3GrKUg+O5PWYUQubi9uW/VjX4RmQpC1yduKfCbU
         YTQ0MPTCETnKanfKsdMApaxow1SNbvwRDGwJmzr7OkFHoavrcndMAhA8bgBnVlXQ33qj
         8I1wIXC/MqB2nKDqPh3Afb7jyLx4rmBd5fCmZnn6+ed1vVoVXYCGWD7tlUlGUvhxZ6hr
         leelOHUMH8bGJX386eQVJq36Yzm8UdNCxsePEPf/FkCEVsf7uTUdbx8aUaEUI07wzjEr
         jOe8hTtxtNhwOy6mVS1LESZytcyRDtXmc20T6ktMOQq6IP2LFKMYJvbr6oBNoTMmXin0
         El1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696322671; x=1696927471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=forSh8N1C+dIxQ58h4NORFcN5/NjK9xQ8ABzqSG+rNM=;
        b=tcPZUtEJG/EH8YRhMrnbn8QzF/qddqK9RogBxo46EYUFYBba4/g6RwKWpfgK7/ge+Z
         m14eIRaxdla3Ch5lA2B1NANhxNtpb3f8GNpkQAWQrMV+u+sk4lfkUARjNEHNkfVc+TRI
         0kKeuu9ShW2q2Fbcr/bI45TqWMfCmVEmasDMHW8m23Bt6OD4MZy1eddYhCVNtMYgEdgk
         AHEffwTcTzxNzAuvQ/VDMiea2jN0iyRNHucKizG6afNt/zYCFnZ1i1jGTBlY2A6aF6gN
         82YxuKBEZV1j0NtWdj4EcmKHU1nsH/G2J1SOTHQrk4XM1MjxYlFLSkDqThxCAksQ9z67
         wX8w==
X-Gm-Message-State: AOJu0YzB/8A3GGq2VSGA/iBBsxYKSVedChOcqQw0Q/UC0QSxYypyRVB1
	dO3O+Ly28I+CEk1ObdDKcs06jScHfLJus87J
X-Google-Smtp-Source: AGHT+IFo/Pi6n52UCpOx4cMFE5zKGL02SvDWoMpLVCQ5/h+3VZqRzeDV3OWHjgHoH22pX5leWe5PFw==
X-Received: by 2002:a17:902:ea0c:b0:1c6:3157:29f3 with SMTP id s12-20020a170902ea0c00b001c6315729f3mr12748250plg.36.1696322670713;
        Tue, 03 Oct 2023 01:44:30 -0700 (PDT)
Received: from ubuntu.. ([113.64.184.44])
        by smtp.googlemail.com with ESMTPSA id y16-20020a17090322d000b001bc445e249asm902876plg.124.2023.10.03.01.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 01:44:30 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: keescook@chromium.org,
	luto@amacapital.net,
	wad@chromium.org,
	alexyonghe@tencent.com,
	hengqi.chen@gmail.com
Subject: [RFC PATCH 2/2] seccomp: Introduce SECCOMP_ATTACH_FILTER operation
Date: Tue,  3 Oct 2023 08:38:36 +0000
Message-Id: <20231003083836.100706-3-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003083836.100706-1-hengqi.chen@gmail.com>
References: <20231003083836.100706-1-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The SECCOMP_ATTACH_FILTER operation is used to attach
a loaded filter to the current process. The loaded filter
is represented by a fd which is either returned by the
SECCOMP_LOAD_FILTER operation or obtained from bpffs using
bpf syscall.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 include/uapi/linux/seccomp.h |  1 +
 kernel/seccomp.c             | 74 ++++++++++++++++++++++++++++++++++--
 2 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
index ee2c83697810..fbe30262fdfc 100644
--- a/include/uapi/linux/seccomp.h
+++ b/include/uapi/linux/seccomp.h
@@ -17,6 +17,7 @@
 #define SECCOMP_GET_ACTION_AVAIL	2
 #define SECCOMP_GET_NOTIF_SIZES		3
 #define SECCOMP_LOAD_FILTER		4
+#define SECCOMP_ATTACH_FILTER		5
 
 /* Valid flags for SECCOMP_SET_MODE_FILTER */
 #define SECCOMP_FILTER_FLAG_TSYNC		(1UL << 0)
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 7aff22f56a91..adfafee4c3da 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -862,7 +862,7 @@ static void seccomp_cache_prepare(struct seccomp_filter *sfilter)
 #endif /* SECCOMP_ARCH_NATIVE */
 
 /**
- * seccomp_attach_filter: validate and attach filter
+ * seccomp_do_attach_filter: validate and attach filter
  * @flags:  flags to change filter behavior
  * @filter: seccomp filter to add to the current process
  *
@@ -873,8 +873,8 @@ static void seccomp_cache_prepare(struct seccomp_filter *sfilter)
  *     seccomp mode or did not have an ancestral seccomp filter
  *   - in NEW_LISTENER mode: the fd of the new listener
  */
-static long seccomp_attach_filter(unsigned int flags,
-				  struct seccomp_filter *filter)
+static long seccomp_do_attach_filter(unsigned int flags,
+				     struct seccomp_filter *filter)
 {
 	unsigned long total_insns;
 	struct seccomp_filter *walker;
@@ -1969,7 +1969,7 @@ static long seccomp_set_mode_filter(unsigned int flags,
 		goto out;
 	}
 
-	ret = seccomp_attach_filter(flags, prepared);
+	ret = seccomp_do_attach_filter(flags, prepared);
 	if (ret)
 		goto out;
 	/* Do not free the successfully attached filter. */
@@ -2050,6 +2050,62 @@ static long seccomp_load_filter(const char __user *filter)
 out:
 	return ret;
 }
+
+static long seccomp_attach_filter(const char __user *ufd)
+{
+	const unsigned long seccomp_mode = SECCOMP_MODE_FILTER;
+	struct seccomp_filter *sfilter;
+	struct bpf_prog *prog;
+	struct file *filp;
+	int flags = 0;
+	int fd, ret;
+
+	if (copy_from_user(&fd, ufd, sizeof(fd)))
+		return -EFAULT;
+
+	filp = fget(fd);
+	if (!filp)
+		return -EBADF;
+
+	if (filp->f_op != &bpf_prog_fops) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	prog = filp->private_data;
+
+	sfilter = kzalloc(sizeof(*sfilter), GFP_KERNEL | __GFP_NOWARN);
+	if (!sfilter) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	sfilter->prog = prog;
+	refcount_set(&sfilter->refs, 1);
+	refcount_set(&sfilter->users, 1);
+	mutex_init(&sfilter->notify_lock);
+	init_waitqueue_head(&sfilter->wqh);
+
+	spin_lock_irq(&current->sighand->siglock);
+
+	ret = -EINVAL;
+	if (!seccomp_may_assign_mode(seccomp_mode))
+		goto out_unlock;
+
+	ret = seccomp_do_attach_filter(flags, sfilter);
+	if (ret)
+		goto out_unlock;
+
+	sfilter = NULL;
+	seccomp_assign_mode(current, seccomp_mode, flags);
+
+out_unlock:
+	spin_unlock_irq(&current->sighand->siglock);
+	seccomp_filter_free(sfilter);
+out:
+	fput(filp);
+	return ret;
+}
 #else
 static inline long seccomp_set_mode_filter(unsigned int flags,
 					   const char __user *filter)
@@ -2061,6 +2117,11 @@ static inline long seccomp_load_filter(const char __user *filter)
 {
 	return -EINVAL;
 }
+
+static inline long seccomp_attach_filter(const char __user *ufd)
+{
+	return -EINVAL;
+}
 #endif
 
 static long seccomp_get_action_avail(const char __user *uaction)
@@ -2127,6 +2188,11 @@ static long do_seccomp(unsigned int op, unsigned int flags,
 			return -EINVAL;
 
 		return seccomp_load_filter(uargs);
+	case SECCOMP_ATTACH_FILTER:
+		if (flags != 0)
+			return -EINVAL;
+
+		return seccomp_attach_filter(uargs);
 	default:
 		return -EINVAL;
 	}
-- 
2.34.1


