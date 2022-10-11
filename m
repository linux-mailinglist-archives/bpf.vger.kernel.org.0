Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646805FA957
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 02:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiJKAeJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Oct 2022 20:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiJKAeH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Oct 2022 20:34:07 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBAF748D6
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 17:34:05 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id v1-20020aa78081000000b005636d8a1947so1506247pff.0
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 17:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nt0hZpqjZYJlwAVjzUzDxwYteGmfv83PaANdrORvyzY=;
        b=ay7HauFPH8wegVHkBuk9+qrh+plSbcKcv5NaQwdc+wDJkt5E2xl7LGxvAe30oD7Tlm
         xfCsLbQUQSeZIATvCfTgpW1P+iAjX0UL8XYQ46/zB4U56Nk1gQh7Cl/RkSKLOi2aD/fJ
         WdwqcT+mythyJ/AN5hL6XCeJE8aylwW1z+fxMP9iNQU7LmOp9nPyITikDEc+QcNYPFe8
         CVVHriM88Vw34IT2rQvmF3uISMnQcPpkDTFSXsNr1kIIdrmqs7ulupf1ApUJbPYkj3Cp
         DfPpaK4zFvyq5PWTnUKpSL+bQNTxZmpnjH2T5Cz/+3E/44XnZJxI2wtC7O/Z/QyyknpT
         8mcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nt0hZpqjZYJlwAVjzUzDxwYteGmfv83PaANdrORvyzY=;
        b=il2XkkVOBIoGnOnS+zmaXuyL/tmo8a3AejwYPHReXDjwJMjRgjTSWabhbqAY4RUdMQ
         qwWFC444ithawWYeA1iSmd5qn1C+Gy78mJ6w5OSNIHN+mXgHbY4tQX9E210vPWOMSnFl
         GUAliw3cvMSamXIomoI1Gz6YF9hKOlX9OG7TfgE5zTNhj5f5BsBneH1UAtCiQkvc0q7l
         nd+D3hJIIcu1Sjbd/El8KAPnF673AbPSZ2ad01tb5KLi2SY41Mh+7C75ALCi/CJTGRAC
         O5eOzVt0eFEox+aQEk84OMBbuH/tofE/iV/AsQ2vDcdoaKuDy8PxbZ77O4mqtJNTkIw2
         DwpQ==
X-Gm-Message-State: ACrzQf1oDM1/c+Retz74wtyz+XVHJRto3DQU9P0pvh3E+vBv+PwtiLJ+
        zzLTmlIEKxjME6il3L59nqQbfnPqyAWqxI3J
X-Google-Smtp-Source: AMsMyM4Xu9gEvJAvFY+PEekqSUs7CxT5zdRa2B62bPjfBvI7OYtf4yJrksqef16M5Kr74IlieAi2TFf+Ih7IZcSo
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a05:6a00:24cb:b0:563:5499:b73 with SMTP
 id d11-20020a056a0024cb00b0056354990b73mr8992534pfv.44.1665448445285; Mon, 10
 Oct 2022 17:34:05 -0700 (PDT)
Date:   Tue, 11 Oct 2022 00:33:58 +0000
In-Reply-To: <20221011003359.3475263-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20221011003359.3475263-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221011003359.3475263-2-yosryahmed@google.com>
Subject: [PATCH v2 1/2] cgroup: add cgroup_v1v2_get_from_[fd/file]()
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
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

Add cgroup_v1v2_get_from_fd() and cgroup_v1v2_get_from_file() that
support both cgroup1 and cgroup2.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 include/linux/cgroup.h |  1 +
 kernel/cgroup/cgroup.c | 50 +++++++++++++++++++++++++++++++++++++-----
 2 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 398f0bce7c21..a88de5bdeaa9 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -106,6 +106,7 @@ struct cgroup_subsys_state *css_tryget_online_from_dir(struct dentry *dentry,
 
 struct cgroup *cgroup_get_from_path(const char *path);
 struct cgroup *cgroup_get_from_fd(int fd);
+struct cgroup *cgroup_v1v2_get_from_fd(int fd);
 
 int cgroup_attach_task_all(struct task_struct *from, struct task_struct *);
 int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from);
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 72e97422e9d9..be167e15ef1a 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6208,16 +6208,36 @@ void cgroup_fork(struct task_struct *child)
 	INIT_LIST_HEAD(&child->cg_list);
 }
 
-static struct cgroup *cgroup_get_from_file(struct file *f)
+/**
+ * cgroup_v1v2_get_from_file - get a cgroup pointer from a file pointer
+ * @f: file corresponding to cgroup_dir
+ *
+ * Find the cgroup from a file pointer associated with a cgroup directory.
+ * Returns a pointer to the cgroup on success. ERR_PTR is returned if the
+ * cgroup cannot be found.
+ */
+static struct cgroup *cgroup_v1v2_get_from_file(struct file *f)
 {
 	struct cgroup_subsys_state *css;
-	struct cgroup *cgrp;
 
 	css = css_tryget_online_from_dir(f->f_path.dentry, NULL);
 	if (IS_ERR(css))
 		return ERR_CAST(css);
 
-	cgrp = css->cgroup;
+	return css->cgroup;
+}
+
+/**
+ * cgroup_get_from_file - same as cgroup_v1v2_get_from_file, but only supports
+ * cgroup2.
+ */
+static struct cgroup *cgroup_get_from_file(struct file *f)
+{
+	struct cgroup *cgrp = cgroup_v1v2_get_from_file(f);
+
+	if (IS_ERR(cgrp))
+		return ERR_CAST(cgrp);
+
 	if (!cgroup_on_dfl(cgrp)) {
 		cgroup_put(cgrp);
 		return ERR_PTR(-EBADF);
@@ -6720,14 +6740,14 @@ EXPORT_SYMBOL_GPL(cgroup_get_from_path);
 
 /**
  * cgroup_get_from_fd - get a cgroup pointer from a fd
- * @fd: fd obtained by open(cgroup2_dir)
+ * @fd: fd obtained by open(cgroup_dir)
  *
  * Find the cgroup from a fd which should be obtained
  * by opening a cgroup directory.  Returns a pointer to the
  * cgroup on success. ERR_PTR is returned if the cgroup
  * cannot be found.
  */
-struct cgroup *cgroup_get_from_fd(int fd)
+struct cgroup *cgroup_v1v2_get_from_fd(int fd)
 {
 	struct cgroup *cgrp;
 	struct file *f;
@@ -6736,10 +6756,28 @@ struct cgroup *cgroup_get_from_fd(int fd)
 	if (!f)
 		return ERR_PTR(-EBADF);
 
-	cgrp = cgroup_get_from_file(f);
+	cgrp = cgroup_v1v2_get_from_file(f);
 	fput(f);
 	return cgrp;
 }
+
+/**
+ * cgroup_get_from_fd - same as cgroup_v1v2_get_from_fd, but only supports
+ * cgroup2.
+ */
+struct cgroup *cgroup_get_from_fd(int fd)
+{
+	struct cgroup *cgrp = cgroup_v1v2_get_from_fd(fd);
+
+	if (IS_ERR(cgrp))
+		return ERR_CAST(cgrp);
+
+	if (!cgroup_on_dfl(cgrp)) {
+		cgroup_put(cgrp);
+		return ERR_PTR(-EBADF);
+	}
+	return cgrp;
+}
 EXPORT_SYMBOL_GPL(cgroup_get_from_fd);
 
 static u64 power_of_ten(int power)
-- 
2.38.0.rc1.362.ged0d419d3c-goog

