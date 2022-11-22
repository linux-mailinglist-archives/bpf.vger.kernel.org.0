Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9AD6334F0
	for <lists+bpf@lfdr.de>; Tue, 22 Nov 2022 06:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbiKVF4g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Nov 2022 00:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbiKVF4S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Nov 2022 00:56:18 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C832F03E;
        Mon, 21 Nov 2022 21:55:47 -0800 (PST)
Received: by mail-qt1-f172.google.com with SMTP id z6so8693925qtv.5;
        Mon, 21 Nov 2022 21:55:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vu6oCi48lK4LFBzFBf6DeUSRUKMcJZFM3TSHBmkTlQs=;
        b=KWQDccKowSqopbnL3QihIWf//7zwlnCSZv/Te+91GC264j9kbyZw+VWbPLBu9717qQ
         xSPSyDHPRrvApvE7hzkZtX50KOOCcrrNv0fLN4xgLqinD1zly7KVd1fXrt0UidYwJ6YL
         wyNEWb5rDaqLRymDprcVqN/DMSaQP8jsszgcgKSy2zCNaPe6wSORrb22o77QIyOpgYrF
         kIpMwkhP0+BqdsBuZxV73R2eu3rqpUbpND8MUSrMPGiQKazG8qnBvQ32cAUR7Vw4alMN
         CxcGvT2lnQYXXs0NeNPqiUWcoSvUKEzN2eHvQ8/xndboSMHzukpWUfqLe0AZay3xHFQi
         XPGw==
X-Gm-Message-State: ANoB5pklrMlKwtFT9HZyDZHR568ACrQ7pDVF6a2qqyOzTaYCNd0MTCtv
        bY4vyC/gTcYVEb2cKpSHFidt68/UZE8j2uxi
X-Google-Smtp-Source: AA0mqf5/k8xOlgbX/gamqo7OEyQDHxD2mcdfHIX5RrnUqNUG5lkN0ZrNKX/m72W3xfYIl3DA02lHww==
X-Received: by 2002:ac8:4e31:0:b0:3a5:d3d:2528 with SMTP id d17-20020ac84e31000000b003a50d3d2528mr20268306qtw.619.1669096545925;
        Mon, 21 Nov 2022 21:55:45 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:3170])
        by smtp.gmail.com with ESMTPSA id l21-20020a37f915000000b006fa7b5ea2d1sm9655368qkj.125.2022.11.21.21.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 21:55:45 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, yhs@fb.com, song@kernel.org, sdf@google.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
        haoluo@google.com, tj@kernel.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 1/4] bpf: Enable cgroups to be used as kptrs
Date:   Mon, 21 Nov 2022 23:54:55 -0600
Message-Id: <20221122055458.173143-2-void@manifault.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221122055458.173143-1-void@manifault.com>
References: <20221122055458.173143-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now that tasks can be used as kfuncs, and the PTR_TRUSTED flag is
available for us to easily add basic acquire / get / release kfuncs, we
can do the same for cgroups. This patch set adds the following kfuncs
which enable using cgroups as kptrs:

struct cgroup *bpf_cgroup_acquire(struct cgroup *cgrp);
struct cgroup *bpf_cgroup_kptr_get(struct cgroup **cgrpp);
void bpf_cgroup_release(struct cgroup *cgrp);

A follow-on patch will add a selftest suite which validates these
kfuncs.

Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/bpf/helpers.c | 83 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 80 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 9e8a5557ea8d..420a4251cccc 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4,6 +4,7 @@
 #include <linux/bpf.h>
 #include <linux/btf.h>
 #include <linux/bpf-cgroup.h>
+#include <linux/cgroup.h>
 #include <linux/rcupdate.h>
 #include <linux/random.h>
 #include <linux/smp.h>
@@ -1879,6 +1880,66 @@ void bpf_task_release(struct task_struct *p)
 	put_task_struct_rcu_user(p);
 }
 
+#ifdef CONFIG_CGROUPS
+/**
+ * bpf_cgroup_acquire - Acquire a reference to a cgroup. A cgroup acquired by
+ * this kfunc which is not stored in a map as a kptr, must be released by
+ * calling bpf_cgroup_release().
+ * @cgrp: The cgroup on which a reference is being acquired.
+ */
+struct cgroup *bpf_cgroup_acquire(struct cgroup *cgrp)
+{
+	cgroup_get(cgrp);
+	return cgrp;
+}
+
+/**
+ * bpf_cgroup_kptr_get - Acquire a reference on a struct cgroup kptr. A cgroup
+ * kptr acquired by this kfunc which is not subsequently stored in a map, must
+ * be released by calling bpf_cgroup_release().
+ * @cgrpp: A pointer to a cgroup kptr on which a reference is being acquired.
+ */
+struct cgroup *bpf_cgroup_kptr_get(struct cgroup **cgrpp)
+{
+	struct cgroup *cgrp;
+
+	rcu_read_lock();
+	/* Another context could remove the cgroup from the map and release it
+	 * at any time, including after we've done the lookup above. This is
+	 * safe because we're in an RCU read region, so the cgroup is
+	 * guaranteed to remain valid until at least the rcu_read_unlock()
+	 * below.
+	 */
+	cgrp = READ_ONCE(*cgrpp);
+
+	if (cgrp && !cgroup_tryget(cgrp))
+		/* If the cgroup had been removed from the map and freed as
+		 * described above, cgroup_tryget() will return false. The
+		 * cgroup will be freed at some point after the current RCU gp
+		 * has ended, so just return NULL to the user.
+		 */
+		cgrp = NULL;
+	rcu_read_unlock();
+
+	return cgrp;
+}
+
+/**
+ * bpf_cgroup_release - Release the reference acquired on a struct cgroup *.
+ * If this kfunc is invoked in an RCU read region, the cgroup is guaranteed to
+ * not be freed until the current grace period has ended, even if its refcount
+ * drops to 0.
+ * @cgrp: The cgroup on which a reference is being released.
+ */
+void bpf_cgroup_release(struct cgroup *cgrp)
+{
+	if (!cgrp)
+		return;
+
+	cgroup_put(cgrp);
+}
+#endif /* CONFIG_CGROUPS */
+
 void *bpf_cast_to_kern_ctx(void *obj)
 {
 	return obj;
@@ -1904,6 +1965,12 @@ BTF_ID_FLAGS(func, bpf_list_pop_back, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_task_kptr_get, KF_ACQUIRE | KF_KPTR_GET | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_release, KF_RELEASE)
+
+#ifdef CONFIG_CGROUPS
+BTF_ID_FLAGS(func, bpf_cgroup_acquire, KF_ACQUIRE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_cgroup_kptr_get, KF_ACQUIRE | KF_KPTR_GET | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_cgroup_release, KF_RELEASE)
+#endif
 BTF_SET8_END(generic_btf_ids)
 
 static const struct btf_kfunc_id_set generic_kfunc_set = {
@@ -1915,6 +1982,10 @@ static const struct btf_kfunc_id_set generic_kfunc_set = {
 BTF_ID_LIST(generic_dtor_ids)
 BTF_ID(struct, task_struct)
 BTF_ID(func, bpf_task_release)
+#ifdef CONFIG_CGROUPS
+BTF_ID(struct, cgroup)
+BTF_ID(func, bpf_cgroup_release)
+#endif
 
 BTF_SET8_START(common_btf_ids)
 BTF_ID_FLAGS(func, bpf_cast_to_kern_ctx)
@@ -1928,12 +1999,18 @@ static const struct btf_kfunc_id_set common_kfunc_set = {
 
 static int __init kfunc_init(void)
 {
-	int ret;
+	int ret, idx = 0;
 	const struct btf_id_dtor_kfunc generic_dtors[] = {
 		{
-			.btf_id       = generic_dtor_ids[0],
-			.kfunc_btf_id = generic_dtor_ids[1]
+			.btf_id       = generic_dtor_ids[idx++],
+			.kfunc_btf_id = generic_dtor_ids[idx++]
 		},
+#ifdef CONFIG_CGROUPS
+		{
+			.btf_id       = generic_dtor_ids[idx++],
+			.kfunc_btf_id = generic_dtor_ids[idx++]
+		},
+#endif
 	};
 
 	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &generic_kfunc_set);
-- 
2.38.1

