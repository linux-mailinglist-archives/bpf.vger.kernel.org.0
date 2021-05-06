Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAF9374E11
	for <lists+bpf@lfdr.de>; Thu,  6 May 2021 05:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbhEFDqT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 May 2021 23:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbhEFDqQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 May 2021 23:46:16 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BA3C0613ED
        for <bpf@vger.kernel.org>; Wed,  5 May 2021 20:45:16 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id d10so3755659pgf.12
        for <bpf@vger.kernel.org>; Wed, 05 May 2021 20:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n2RjWMYAO5iIDg2VJ348LHvtsRegR2feMc3MAzsS5l4=;
        b=XRDsVIRUzm8H2hqcGbLhjjXhPAXKdTz8uT0J+TtAuNvHyXRhKJP3roPyCtXaCMzRQY
         //elDUWwXiH+iM+a7uqjEtd1+XPbepyV8jHddgNiNddOTo+NhHkd1ybN82cHOUNVQiCL
         /Fz7SItLl0AKZIRtCg/oDSTx/GlWC9XJlBR8BWseovqTXN7RxZrvc3OdwMUiHa2M58Ri
         OWiF7j9ZVVuMgi9OTCRXCKDuuTBt5xHFp5K2QuXRYUqlxXeMTNOZaVGirJJzt+wF4tVb
         nvoPl4KTgO0wU98UcUCnrVmtJ/wQUYs042vN4BdxCjTWLslrROMuWwh9DuZKFh4EZ9vD
         f8Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n2RjWMYAO5iIDg2VJ348LHvtsRegR2feMc3MAzsS5l4=;
        b=qkRnXC16I9OEefBrQDlys0F5gAIOvVwCwfZMxXc3BH+mRBoGGzz301Fy2GsINRJNms
         wsHd+AaTfuJbjOdorvH41QfU7KdXfNcS3h2ufZseEByIs8AjZfzf0EgntfHgrxXIWKcd
         +gLJsnsgwu1d7khmu4WodFJe7d7n+mNS9KYnOXCZMUtSn65cD3H4tujGopvmhhCzAbf3
         owozoDTnNXpJEz46MYxCUfTeJoTUCSvjwbsvQXhI4PB6aNDrEksKaVXBxz0rX/7Hvx13
         t3fKrhIDoDZbD39ve9t9N9TgLlX32Cgeu+Eo6kxyk1PwK3oqLmARPDkCT/Ri6wyqLPyr
         gB9Q==
X-Gm-Message-State: AOAM533VpIgYxmhydO2k5xXigWsKJ+7uQcKbEjQcMoaNed3hHAHBbqnr
        4E4goz5mcQzLsUN/eY/HpOk=
X-Google-Smtp-Source: ABdhPJyHNqiKlabFsTzl7pwIs5Y0tQIkQeKlC3XhZ1Xx7GZPzjz6b3KRuqnAqcra6ENSnasf70kJAQ==
X-Received: by 2002:a62:1cc9:0:b029:28e:e318:976b with SMTP id c192-20020a621cc90000b029028ee318976bmr2446544pfc.8.1620272716078;
        Wed, 05 May 2021 20:45:16 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id r22sm578997pgr.1.2021.05.05.20.45.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 May 2021 20:45:15 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 bpf-next 06/17] bpf: Make btf_load command to be bpfptr_t compatible.
Date:   Wed,  5 May 2021 20:44:54 -0700
Message-Id: <20210506034505.25979-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210506034505.25979-1-alexei.starovoitov@gmail.com>
References: <20210506034505.25979-1-alexei.starovoitov@gmail.com>
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

