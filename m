Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8ED54C5225
	for <lists+bpf@lfdr.de>; Sat, 26 Feb 2022 00:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239523AbiBYXo3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Feb 2022 18:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239481AbiBYXoW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Feb 2022 18:44:22 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AED3187BAF
        for <bpf@vger.kernel.org>; Fri, 25 Feb 2022 15:43:49 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id k7-20020a255607000000b00621afc793b8so4978011ybb.1
        for <bpf@vger.kernel.org>; Fri, 25 Feb 2022 15:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uFPxHpKM1wpN11u3R15gkkPUUa85utV+YA3orSMAaMQ=;
        b=jGGYR7+JlJhz+u/oapTmhLOpMRP4r7XNM0dqrGXqjl9Og9VMXbKrCKYt/9JKLsr8q1
         a6yOKUHWJUf2Lmor+BTC5wQfPvoz09O0YY/IPHq0mncxa3brxguarta8UGQvem8MYqbl
         mqrC+JaFJRxXCA+L5oZcbpqKmC2CH0DG1Zis1U728AlI3TxC2Y8kVbs2+IECcgkAkUOn
         shIYrlgazgjuocB9EhfMgYSxHylqm8eQ9Q+u8e4dnek+skbidW+ACdvZ0jRkMVID6kam
         j30pSbzqLM2vckx/tAHDNk7I7fI/6JXEJy3mnJYc6kde4FHYp5GxJ5Fla4X0D00Or+vE
         Xm1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uFPxHpKM1wpN11u3R15gkkPUUa85utV+YA3orSMAaMQ=;
        b=Sw6Z+vvDX7ocxMRQ3d05ZKo61efhZAvk3cM2aq5PS28vYUZzXxklCO+aaHEGQHu30h
         PVJ7N25EPN8wglvSqz2I2tKXU3A2N5pSg9OkE7U0NIzJ/v/3NP0X9ohiFPEmcyG2rrji
         rrIKjydtpyZd4XHJzgBcXxXFhAZgOCXEPkWVrhHnRC/AktojsqccwjOOpUfYSgUY5DkV
         o7JN87ix2GUvpSEpsXbWWjtOCqPVgQB+u3PLCMKP4J0ncNmvuM9DoHkKmWTDvMDCxk/6
         XEUkmx2OPQl59IIkweao45EfM6MhDZt9XI506ZlX+l1s1QV+SlFNoziY9Gx0AQGNJbkH
         dGRg==
X-Gm-Message-State: AOAM532jnjmlWaM6ryvkTeZsEy9rWnDtWrlmi6qhPOSQ1LszhSMVMRtD
        KHgQFgQ4xGcJkL130rTnPGdb9SHSk8Y=
X-Google-Smtp-Source: ABdhPJy+r5NcA4n55DFecrVbqxpsO0btN/dh4PxHGww5fNUy03ZbrhBM+V2jd7zdFN7r8nz2R/bkcIa8r84=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:378d:645d:49ad:4f8b])
 (user=haoluo job=sendgmr) by 2002:a25:9a44:0:b0:622:4e:958c with SMTP id
 r4-20020a259a44000000b00622004e958cmr9880165ybo.566.1645832628657; Fri, 25
 Feb 2022 15:43:48 -0800 (PST)
Date:   Fri, 25 Feb 2022 15:43:32 -0800
In-Reply-To: <20220225234339.2386398-1-haoluo@google.com>
Message-Id: <20220225234339.2386398-3-haoluo@google.com>
Mime-Version: 1.0
References: <20220225234339.2386398-1-haoluo@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH bpf-next v1 2/9] bpf: Add BPF_OBJ_PIN and BPF_OBJ_GET in the
 bpf_sys_bpf helper
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Tejun Heo <tj@kernel.org>, joshdon@google.com, sdf@google.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now bpf syscall prog is able to pin bpf objects into bpffs and get
a pinned object from file system. Combining the previous patch that
introduced the helpers for creating and deleting directories in bpffs,
syscall prog can now persist bpf objects and organize them in a
directory hierarchy.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 include/linux/bpf.h  |  4 ++--
 kernel/bpf/inode.c   | 24 ++++++++++++++++++------
 kernel/bpf/syscall.c | 21 ++++++++++++++-------
 3 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index fce5e26179f5..c36eeced3838 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1585,8 +1585,8 @@ struct file *bpf_link_new_file(struct bpf_link *link, int *reserved_fd);
 struct bpf_link *bpf_link_get_from_fd(u32 ufd);
 
 bool bpf_path_is_bpf_dir(const struct path *path);
-int bpf_obj_pin_user(u32 ufd, const char __user *pathname);
-int bpf_obj_get_user(const char __user *pathname, int flags);
+int bpf_obj_pin_path(u32 ufd, bpfptr_t pathname);
+int bpf_obj_get_path(bpfptr_t pathname, int flags);
 
 #define BPF_ITER_FUNC_PREFIX "bpf_iter_"
 #define DEFINE_BPF_ITER_FUNC(target, args...)			\
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 3aca00e9e950..6c2db54a2ff9 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -440,7 +440,7 @@ static int bpf_iter_link_pin_kernel(struct dentry *parent,
 	return ret;
 }
 
-static int bpf_obj_do_pin(const char __user *pathname, void *raw,
+static int bpf_obj_do_pin(bpfptr_t pathname, void *raw,
 			  enum bpf_type type)
 {
 	struct dentry *dentry;
@@ -448,7 +448,13 @@ static int bpf_obj_do_pin(const char __user *pathname, void *raw,
 	umode_t mode;
 	int ret;
 
-	dentry = user_path_create(AT_FDCWD, pathname, &path, 0);
+	if (bpfptr_is_null(pathname))
+		return -EINVAL;
+
+	if (bpfptr_is_kernel(pathname))
+		dentry = kern_path_create(AT_FDCWD, pathname.kernel, &path, 0);
+	else
+		dentry = user_path_create(AT_FDCWD, pathname.user, &path, 0);
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
@@ -481,7 +487,7 @@ static int bpf_obj_do_pin(const char __user *pathname, void *raw,
 	return ret;
 }
 
-int bpf_obj_pin_user(u32 ufd, const char __user *pathname)
+int bpf_obj_pin_path(u32 ufd, bpfptr_t pathname)
 {
 	enum bpf_type type;
 	void *raw;
@@ -498,7 +504,7 @@ int bpf_obj_pin_user(u32 ufd, const char __user *pathname)
 	return ret;
 }
 
-static void *bpf_obj_do_get(const char __user *pathname,
+static void *bpf_obj_do_get(bpfptr_t pathname,
 			    enum bpf_type *type, int flags)
 {
 	struct inode *inode;
@@ -506,7 +512,13 @@ static void *bpf_obj_do_get(const char __user *pathname,
 	void *raw;
 	int ret;
 
-	ret = user_path_at(AT_FDCWD, pathname, LOOKUP_FOLLOW, &path);
+	if (bpfptr_is_null(pathname))
+		return ERR_PTR(-EINVAL);
+
+	if (bpfptr_is_kernel(pathname))
+		ret = kern_path(pathname.kernel, LOOKUP_FOLLOW, &path);
+	else
+		ret = user_path_at(AT_FDCWD, pathname.user, LOOKUP_FOLLOW, &path);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -530,7 +542,7 @@ static void *bpf_obj_do_get(const char __user *pathname,
 	return ERR_PTR(ret);
 }
 
-int bpf_obj_get_user(const char __user *pathname, int flags)
+int bpf_obj_get_path(bpfptr_t pathname, int flags)
 {
 	enum bpf_type type = BPF_TYPE_UNSPEC;
 	int f_flags;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 07683b791733..9e6d8d0c8af5 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2402,22 +2402,27 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr)
 
 #define BPF_OBJ_LAST_FIELD file_flags
 
-static int bpf_obj_pin(const union bpf_attr *attr)
+static int bpf_obj_pin(const union bpf_attr *attr, bpfptr_t uattr)
 {
+	bpfptr_t pathname;
+
 	if (CHECK_ATTR(BPF_OBJ) || attr->file_flags != 0)
 		return -EINVAL;
 
-	return bpf_obj_pin_user(attr->bpf_fd, u64_to_user_ptr(attr->pathname));
+	pathname = make_bpfptr(attr->pathname, bpfptr_is_kernel(uattr));
+	return bpf_obj_pin_path(attr->bpf_fd, pathname);
 }
 
-static int bpf_obj_get(const union bpf_attr *attr)
+static int bpf_obj_get(const union bpf_attr *attr, bpfptr_t uattr)
 {
+	bpfptr_t pathname;
+
 	if (CHECK_ATTR(BPF_OBJ) || attr->bpf_fd != 0 ||
 	    attr->file_flags & ~BPF_OBJ_FLAG_MASK)
 		return -EINVAL;
 
-	return bpf_obj_get_user(u64_to_user_ptr(attr->pathname),
-				attr->file_flags);
+	pathname = make_bpfptr(attr->pathname, bpfptr_is_kernel(uattr));
+	return bpf_obj_get_path(pathname, attr->file_flags);
 }
 
 void bpf_link_init(struct bpf_link *link, enum bpf_link_type type,
@@ -4648,10 +4653,10 @@ static int __sys_bpf(int cmd, bpfptr_t uattr, unsigned int size)
 		err = bpf_prog_load(&attr, uattr);
 		break;
 	case BPF_OBJ_PIN:
-		err = bpf_obj_pin(&attr);
+		err = bpf_obj_pin(&attr, uattr);
 		break;
 	case BPF_OBJ_GET:
-		err = bpf_obj_get(&attr);
+		err = bpf_obj_get(&attr, uattr);
 		break;
 	case BPF_PROG_ATTACH:
 		err = bpf_prog_attach(&attr);
@@ -4776,6 +4781,8 @@ BPF_CALL_3(bpf_sys_bpf, int, cmd, union bpf_attr *, attr, u32, attr_size)
 	case BPF_BTF_LOAD:
 	case BPF_LINK_CREATE:
 	case BPF_RAW_TRACEPOINT_OPEN:
+	case BPF_OBJ_PIN:
+	case BPF_OBJ_GET:
 		break;
 #ifdef CONFIG_BPF_JIT /* __bpf_prog_enter_sleepable used by trampoline and JIT */
 	case BPF_PROG_TEST_RUN:
-- 
2.35.1.574.g5d30c73bfb-goog

