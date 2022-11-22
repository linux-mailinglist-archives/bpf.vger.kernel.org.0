Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF126334F2
	for <lists+bpf@lfdr.de>; Tue, 22 Nov 2022 06:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiKVF4h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Nov 2022 00:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbiKVF4S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Nov 2022 00:56:18 -0500
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBB72F03F;
        Mon, 21 Nov 2022 21:55:50 -0800 (PST)
Received: by mail-qv1-f42.google.com with SMTP id p8so8841226qvn.5;
        Mon, 21 Nov 2022 21:55:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wiOmKcYpqCsWdLOnesBEcBAxMPbH+8h/6qpIynHyMGs=;
        b=rqWPQWBlHMO70P9jNIqwLJtLTrbELDRwry7HZyTqPEAJW0QQe6MVvKJAU5/xIxPD+1
         Zhiuoms8rMN5xIL8RkKg0aUzm3WCP+O7qY7UgvzAd3v9574dTvDHj/jHXq/IzWMDyB6q
         bsk4x0wmCF99hV9vylz/nSoUekNQSjh3FFYzXiIkChYnEagUPvHKyxWulJYqldibNBSO
         iMPfoSWcb35izLv0CKr5U/q5XdAhMEG9dn7tEQ+22ScXfYQ3rFQdBBpuYo+WJOXSXdQQ
         kvBoH4J+PL49w0nD0jAz8k7Y26AfNKLUjkB+cXLScWsruWDmHixdnDh/Y1MO3TO7PJku
         G69A==
X-Gm-Message-State: ANoB5pkhcO+VAUs3SYCHBef46+CmN1aGrQfQLQbKkuSiKwESU+wFamY1
        2xGDzPKUWt67wNo8p0opHdYkqrI5qiL1qa0J
X-Google-Smtp-Source: AA0mqf5X3gi/aPnhUVTN9HZyf7esOx2cWEYu5veyIZ08wggaqU7Q1l1QOUrKxh6qHItMiwVNftqpYA==
X-Received: by 2002:a05:6214:102b:b0:4bb:6e51:f98d with SMTP id k11-20020a056214102b00b004bb6e51f98dmr4192654qvr.56.1669096548997;
        Mon, 21 Nov 2022 21:55:48 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:3170])
        by smtp.gmail.com with ESMTPSA id u18-20020a05620a455200b006cdd0939ffbsm9792962qkp.86.2022.11.21.21.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 21:55:48 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, yhs@fb.com, song@kernel.org, sdf@google.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
        haoluo@google.com, tj@kernel.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 3/4] bpf: Add bpf_cgroup_ancestor() kfunc
Date:   Mon, 21 Nov 2022 23:54:57 -0600
Message-Id: <20221122055458.173143-4-void@manifault.com>
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

struct cgroup * objects have a variably sized struct cgroup *ancestors[]
field which stores pointers to their ancestor cgroups. If using a cgroup
as a kptr, it can be useful to access these ancestors, but doing so
requires variable offset accesses for PTR_TO_BTF_ID, which is currently
unsupported.

This is a very useful field to access for cgroup kptrs, as programs may
wish to walk their ancestor cgroups when determining e.g. their
proportional cpu.weight. So as to enable this functionality with cgroup
kptrs before var_off is supported for PTR_TO_BTF_ID, this patch adds a
bpf_cgroup_ancestor() kfunc which accesses the cgroup node on behalf of
the caller, and acquires a reference on it. Once var_off is supported
for PTR_TO_BTF_ID, and fields inside a struct can be marked as trusted
so they retain the PTR_TRUSTED modifier when walked, this can be
removed.

Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/bpf/helpers.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 420a4251cccc..e4e9db301db5 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1938,6 +1938,25 @@ void bpf_cgroup_release(struct cgroup *cgrp)
 
 	cgroup_put(cgrp);
 }
+
+/**
+ * bpf_cgroup_ancestor - Perform a lookup on an entry in a cgroup's ancestor
+ * array. A cgroup returned by this kfunc which is not subsequently stored in a
+ * map, must be released by calling bpf_cgroup_release().
+ * @cgrp: The cgroup for which we're performing a lookup.
+ * @level: The level of ancestor to look up.
+ */
+struct cgroup *bpf_cgroup_ancestor(struct cgroup *cgrp, int level)
+{
+	struct cgroup *ancestor;
+
+	if (level > cgrp->level || level < 0)
+		return NULL;
+
+	ancestor = cgrp->ancestors[level];
+	cgroup_get(ancestor);
+	return ancestor;
+}
 #endif /* CONFIG_CGROUPS */
 
 void *bpf_cast_to_kern_ctx(void *obj)
@@ -1970,6 +1989,7 @@ BTF_ID_FLAGS(func, bpf_task_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_cgroup_acquire, KF_ACQUIRE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_cgroup_kptr_get, KF_ACQUIRE | KF_KPTR_GET | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_cgroup_release, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_cgroup_ancestor, KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_NULL)
 #endif
 BTF_SET8_END(generic_btf_ids)
 
-- 
2.38.1

