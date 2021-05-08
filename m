Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7B9376F35
	for <lists+bpf@lfdr.de>; Sat,  8 May 2021 05:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhEHDty (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 May 2021 23:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbhEHDtx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 May 2021 23:49:53 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AA6C061574
        for <bpf@vger.kernel.org>; Fri,  7 May 2021 20:48:52 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id m12so8764326pgr.9
        for <bpf@vger.kernel.org>; Fri, 07 May 2021 20:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n2RjWMYAO5iIDg2VJ348LHvtsRegR2feMc3MAzsS5l4=;
        b=q3tU2RtZEyItt2HzM6f2VVoc3u+GT2brxI5AU64odkm6j86GajNp7H/5JbCfRmeFL0
         y3Ib7ikEulYZduW0Xh9iMODGNiuh6G5R55q87yQ4KodARe1FWoShrfHQ/mleK/OTqUJ9
         kpHiFQEMTs+Q0U5WSllN+EuTjTwDB+lpnpnfYNXpkQ/BPW5EWLIs5899JY1/D1RiPpnF
         VUgiz3kZ/pZBXU6vm6pKGwk3cd91aeYJSoaZzoTv3AgGtoVUOhDej72wvFkbmRbkqwkT
         MwEnm0CwxD0pXYvfDjJefzVpta3lDQ8hH7Bveq/nHKk3L9+sR05VwXzArpDMmkW0wp2e
         wnkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n2RjWMYAO5iIDg2VJ348LHvtsRegR2feMc3MAzsS5l4=;
        b=mZdax8TeR5lOnlvwiaq2pDIxmaxTYHvxXYQcEERQ29gBGST/KkPn5DG9nTNdfF2zUK
         N4wWtCRBxPVuQNYRErSu4b2CJiGC+t7SJ6Lvh2mXNMDuow9ZyHo0XnxD6Mv8D9gAETpD
         u1caKYVzQDmHrAWr+pVQEaHwSsaev2AkH5Rlt2Yh+W5/XKxG/dI8tt8GZPfQIYIbGZzq
         utTJaULz714mvrAwyUS4OaUCgS8l47eof0WLKtoH9+0ywb0RownWX7yPoLywFOA2DPLM
         uujK452tuo61b6EDk2m+/e7w84/HMLkxZFgr1eNdPzvz4bUTzCaRb+BUXgltbW5UkR0/
         2pnA==
X-Gm-Message-State: AOAM532/xPPmjtZ7BkAYX6FFSzRz+8I1G5THNTQkSyo2l0QsjDVvZGXr
        CHoWXKYmSUcBU6oyzS4eMH4=
X-Google-Smtp-Source: ABdhPJzUelU4IVka4wYG6bZ8E/hVd0LPfNfydtEbG0CZWnWeqosp058YQW979ZbOaVVqW9PQmpY7Ag==
X-Received: by 2002:aa7:8d84:0:b029:1f8:3449:1bc6 with SMTP id i4-20020aa78d840000b02901f834491bc6mr13288950pfr.76.1620445732027;
        Fri, 07 May 2021 20:48:52 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.1])
        by smtp.gmail.com with ESMTPSA id u12sm5784606pfh.122.2021.05.07.20.48.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 May 2021 20:48:51 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 bpf-next 06/22] bpf: Make btf_load command to be bpfptr_t compatible.
Date:   Fri,  7 May 2021 20:48:21 -0700
Message-Id: <20210508034837.64585-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210508034837.64585-1-alexei.starovoitov@gmail.com>
References: <20210508034837.64585-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Similar to prog_load make btf_load command to be availble to
bpf_prog_type_syscall program.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/btf.h  | 2 +-
 kernel/bpf/btf.c     | 8 ++++----
 kernel/bpf/syscall.c | 7 ++++---
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 3bac66e0183a..94a0c976c90f 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -21,7 +21,7 @@ extern const struct file_operations btf_fops;
 
 void btf_get(struct btf *btf);
 void btf_put(struct btf *btf);
-int btf_new_fd(const union bpf_attr *attr);
+int btf_new_fd(const union bpf_attr *attr, bpfptr_t uattr);
 struct btf *btf_get_by_fd(int fd);
 int btf_get_info_by_fd(const struct btf *btf,
 		       const union bpf_attr *attr,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0600ed325fa0..fbf6c06a9d62 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4257,7 +4257,7 @@ static int btf_parse_hdr(struct btf_verifier_env *env)
 	return 0;
 }
 
-static struct btf *btf_parse(void __user *btf_data, u32 btf_data_size,
+static struct btf *btf_parse(bpfptr_t btf_data, u32 btf_data_size,
 			     u32 log_level, char __user *log_ubuf, u32 log_size)
 {
 	struct btf_verifier_env *env = NULL;
@@ -4306,7 +4306,7 @@ static struct btf *btf_parse(void __user *btf_data, u32 btf_data_size,
 	btf->data = data;
 	btf->data_size = btf_data_size;
 
-	if (copy_from_user(data, btf_data, btf_data_size)) {
+	if (copy_from_bpfptr(data, btf_data, btf_data_size)) {
 		err = -EFAULT;
 		goto errout;
 	}
@@ -5780,12 +5780,12 @@ static int __btf_new_fd(struct btf *btf)
 	return anon_inode_getfd("btf", &btf_fops, btf, O_RDONLY | O_CLOEXEC);
 }
 
-int btf_new_fd(const union bpf_attr *attr)
+int btf_new_fd(const union bpf_attr *attr, bpfptr_t uattr)
 {
 	struct btf *btf;
 	int ret;
 
-	btf = btf_parse(u64_to_user_ptr(attr->btf),
+	btf = btf_parse(make_bpfptr(attr->btf, uattr.is_kernel),
 			attr->btf_size, attr->btf_log_level,
 			u64_to_user_ptr(attr->btf_log_buf),
 			attr->btf_log_size);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 28387fe149ba..415865c49dd4 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3842,7 +3842,7 @@ static int bpf_obj_get_info_by_fd(const union bpf_attr *attr,
 
 #define BPF_BTF_LOAD_LAST_FIELD btf_log_level
 
-static int bpf_btf_load(const union bpf_attr *attr)
+static int bpf_btf_load(const union bpf_attr *attr, bpfptr_t uattr)
 {
 	if (CHECK_ATTR(BPF_BTF_LOAD))
 		return -EINVAL;
@@ -3850,7 +3850,7 @@ static int bpf_btf_load(const union bpf_attr *attr)
 	if (!bpf_capable())
 		return -EPERM;
 
-	return btf_new_fd(attr);
+	return btf_new_fd(attr, uattr);
 }
 
 #define BPF_BTF_GET_FD_BY_ID_LAST_FIELD btf_id
@@ -4471,7 +4471,7 @@ static int __sys_bpf(int cmd, bpfptr_t uattr, unsigned int size)
 		err = bpf_raw_tracepoint_open(&attr);
 		break;
 	case BPF_BTF_LOAD:
-		err = bpf_btf_load(&attr);
+		err = bpf_btf_load(&attr, uattr);
 		break;
 	case BPF_BTF_GET_FD_BY_ID:
 		err = bpf_btf_get_fd_by_id(&attr);
@@ -4552,6 +4552,7 @@ BPF_CALL_3(bpf_sys_bpf, int, cmd, void *, attr, u32, attr_size)
 	case BPF_MAP_UPDATE_ELEM:
 	case BPF_MAP_FREEZE:
 	case BPF_PROG_LOAD:
+	case BPF_BTF_LOAD:
 		break;
 	/* case BPF_PROG_TEST_RUN:
 	 * is not part of this list to prevent recursive test_run
-- 
2.30.2

