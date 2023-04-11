Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4572D6DD0B8
	for <lists+bpf@lfdr.de>; Tue, 11 Apr 2023 06:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjDKEQk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Apr 2023 00:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjDKEQj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Apr 2023 00:16:39 -0400
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A8FE74;
        Mon, 10 Apr 2023 21:16:37 -0700 (PDT)
Received: by mail-qv1-f51.google.com with SMTP id om8so5591789qvb.3;
        Mon, 10 Apr 2023 21:16:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681186596; x=1683778596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+/NRCUh21EwSCHQTGMkg0JbDBsWfdCVqSK+6Bs3uOLY=;
        b=C27iSmbNBoZDtfI5DW380E6Veo8NgFB+WxJ9hGYdraHeApKdy6KImA3DHTmdlDFqq3
         b4mHr4Okki5JqMoN5tqok4zD0asyKlg4vwH2XHN+nS+UNoQAAzEfZIxSn64Pqqw2gqNQ
         Rn3hIrnlXjIGFSHh8hZjtd83qJaz9kX4oZP7igLx3VHqvLI4FPeRNrxL+itJYYpwUMm+
         mC5R99VhvWg/y2ByE/YIYU65Rdw9jTP7PsMaFxFh0EpjxoOhhAtptz4A3z+iu0E9DV7q
         zY1Z5hdFMJq74LxQ/zJEd2F8gIZUInlD17Q4/zdUTN/EKOIpQizDeuUaGSngy83PCMdh
         teNw==
X-Gm-Message-State: AAQBX9fDyt27sT5ZcOJN027qK+aDJUxvunvvWGFfrY9M5/cwF6uRGhEz
        o6AmAHWHmKByU7lp+I0MRgtz/dD9CMUIroAF
X-Google-Smtp-Source: AKy350ZNmWN4ftdjoIgUAj4L2KpIVN9ISqiVmUxWvAzY5eYXZk6RL7RPUGR6JJaauuaq2XBa3OtTqQ==
X-Received: by 2002:a05:6214:ac6:b0:577:5ffe:e0ce with SMTP id g6-20020a0562140ac600b005775ffee0cemr26837599qvi.25.1681186596414;
        Mon, 10 Apr 2023 21:16:36 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:8681])
        by smtp.gmail.com with ESMTPSA id u6-20020a0cfe46000000b005e2007584f1sm3855319qvs.24.2023.04.10.21.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 21:16:35 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH bpf-next 1/3] bpf: Make bpf_cgroup_acquire() KF_RCU | KF_RET_NULL
Date:   Mon, 10 Apr 2023 23:16:31 -0500
Message-Id: <20230411041633.179404-1-void@manifault.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

struct cgroup is already an RCU-safe type in the verifier. We can
therefore update bpf_cgroup_acquire() to be KF_RCU | KF_RET_NULL, and
subsequently remove bpf_cgroup_kptr_get(). This patch does the first of
these by updating bpf_cgroup_acquire() to be KF_RCU | KF_RET_NULL, and
also updates selftests accordingly.

Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/bpf/helpers.c                          |  5 ++-
 .../selftests/bpf/progs/cgrp_kfunc_common.h   |  5 +++
 .../selftests/bpf/progs/cgrp_kfunc_failure.c  | 35 +++++++++++++++----
 .../selftests/bpf/progs/cgrp_kfunc_success.c  |  5 ++-
 4 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b6a5cda5bb59..71f0604bdc97 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2037,8 +2037,7 @@ __bpf_kfunc void bpf_task_release(struct task_struct *p)
  */
 __bpf_kfunc struct cgroup *bpf_cgroup_acquire(struct cgroup *cgrp)
 {
-	cgroup_get(cgrp);
-	return cgrp;
+	return cgroup_tryget(cgrp) ? cgrp : NULL;
 }
 
 /**
@@ -2314,7 +2313,7 @@ BTF_ID_FLAGS(func, bpf_rbtree_add)
 BTF_ID_FLAGS(func, bpf_rbtree_first, KF_RET_NULL)
 
 #ifdef CONFIG_CGROUPS
-BTF_ID_FLAGS(func, bpf_cgroup_acquire, KF_ACQUIRE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_cgroup_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_cgroup_kptr_get, KF_ACQUIRE | KF_KPTR_GET | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_cgroup_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_cgroup_ancestor, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
diff --git a/tools/testing/selftests/bpf/progs/cgrp_kfunc_common.h b/tools/testing/selftests/bpf/progs/cgrp_kfunc_common.h
index d0b7cd0d09d7..b0e279f4652b 100644
--- a/tools/testing/selftests/bpf/progs/cgrp_kfunc_common.h
+++ b/tools/testing/selftests/bpf/progs/cgrp_kfunc_common.h
@@ -61,6 +61,11 @@ static inline int cgrps_kfunc_map_insert(struct cgroup *cgrp)
 	}
 
 	acquired = bpf_cgroup_acquire(cgrp);
+	if (!acquired) {
+		bpf_map_delete_elem(&__cgrps_kfunc_map, &id);
+		return -ENOENT;
+	}
+
 	old = bpf_kptr_xchg(&v->cgrp, acquired);
 	if (old) {
 		bpf_cgroup_release(old);
diff --git a/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c b/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c
index 48b2034cadb3..49347f12de39 100644
--- a/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c
+++ b/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c
@@ -41,6 +41,23 @@ int BPF_PROG(cgrp_kfunc_acquire_untrusted, struct cgroup *cgrp, const char *path
 
 	/* Can't invoke bpf_cgroup_acquire() on an untrusted pointer. */
 	acquired = bpf_cgroup_acquire(v->cgrp);
+	if (acquired)
+		bpf_cgroup_release(acquired);
+
+	return 0;
+}
+
+SEC("tp_btf/cgroup_mkdir")
+__failure __msg("Possibly NULL pointer passed to trusted arg0")
+int BPF_PROG(cgrp_kfunc_acquire_no_null_check, struct cgroup *cgrp, const char *path)
+{
+	struct cgroup *acquired;
+
+	acquired = bpf_cgroup_acquire(cgrp);
+	/*
+	 * Can't invoke bpf_cgroup_release() without checking the return value
+	 * of bpf_cgroup_acquire().
+	 */
 	bpf_cgroup_release(acquired);
 
 	return 0;
@@ -54,7 +71,8 @@ int BPF_PROG(cgrp_kfunc_acquire_fp, struct cgroup *cgrp, const char *path)
 
 	/* Can't invoke bpf_cgroup_acquire() on a random frame pointer. */
 	acquired = bpf_cgroup_acquire((struct cgroup *)&stack_cgrp);
-	bpf_cgroup_release(acquired);
+	if (acquired)
+		bpf_cgroup_release(acquired);
 
 	return 0;
 }
@@ -67,7 +85,8 @@ int BPF_PROG(cgrp_kfunc_acquire_unsafe_kretprobe, struct cgroup *cgrp)
 
 	/* Can't acquire an untrusted struct cgroup * pointer. */
 	acquired = bpf_cgroup_acquire(cgrp);
-	bpf_cgroup_release(acquired);
+	if (acquired)
+		bpf_cgroup_release(acquired);
 
 	return 0;
 }
@@ -80,7 +99,8 @@ int BPF_PROG(cgrp_kfunc_acquire_trusted_walked, struct cgroup *cgrp, const char
 
 	/* Can't invoke bpf_cgroup_acquire() on a pointer obtained from walking a trusted cgroup. */
 	acquired = bpf_cgroup_acquire(cgrp->old_dom_cgrp);
-	bpf_cgroup_release(acquired);
+	if (acquired)
+		bpf_cgroup_release(acquired);
 
 	return 0;
 }
@@ -93,9 +113,8 @@ int BPF_PROG(cgrp_kfunc_acquire_null, struct cgroup *cgrp, const char *path)
 
 	/* Can't invoke bpf_cgroup_acquire() on a NULL pointer. */
 	acquired = bpf_cgroup_acquire(NULL);
-	if (!acquired)
-		return 0;
-	bpf_cgroup_release(acquired);
+	if (acquired)
+		bpf_cgroup_release(acquired);
 
 	return 0;
 }
@@ -137,6 +156,8 @@ int BPF_PROG(cgrp_kfunc_get_non_kptr_acquired, struct cgroup *cgrp, const char *
 	struct cgroup *kptr, *acquired;
 
 	acquired = bpf_cgroup_acquire(cgrp);
+	if (!acquired)
+		return 0;
 
 	/* Cannot use bpf_cgroup_kptr_get() on a non-map-value, even if the kptr was acquired. */
 	kptr = bpf_cgroup_kptr_get(&acquired);
@@ -256,6 +277,8 @@ int BPF_PROG(cgrp_kfunc_release_null, struct cgroup *cgrp, const char *path)
 		return -ENOENT;
 
 	acquired = bpf_cgroup_acquire(cgrp);
+	if (!acquired)
+		return -ENOENT;
 
 	old = bpf_kptr_xchg(&v->cgrp, acquired);
 
diff --git a/tools/testing/selftests/bpf/progs/cgrp_kfunc_success.c b/tools/testing/selftests/bpf/progs/cgrp_kfunc_success.c
index 030aff700084..e9dbd1af05a7 100644
--- a/tools/testing/selftests/bpf/progs/cgrp_kfunc_success.c
+++ b/tools/testing/selftests/bpf/progs/cgrp_kfunc_success.c
@@ -38,7 +38,10 @@ int BPF_PROG(test_cgrp_acquire_release_argument, struct cgroup *cgrp, const char
 		return 0;
 
 	acquired = bpf_cgroup_acquire(cgrp);
-	bpf_cgroup_release(acquired);
+	if (!acquired)
+		err = 1;
+	else
+		bpf_cgroup_release(acquired);
 
 	return 0;
 }
-- 
2.40.0

