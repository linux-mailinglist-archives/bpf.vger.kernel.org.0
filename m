Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFE86DD0BB
	for <lists+bpf@lfdr.de>; Tue, 11 Apr 2023 06:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjDKEQm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Apr 2023 00:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjDKEQl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Apr 2023 00:16:41 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE10EE74;
        Mon, 10 Apr 2023 21:16:40 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id ge18so3761643qtb.0;
        Mon, 10 Apr 2023 21:16:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681186600; x=1683778600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f8r9n+ovWuQwy53nYZcyLOjkE/UdHOnvkJQHdAE1iAk=;
        b=JZY+S84zh2AgwldcJGTKW7KuYjVH6MS8xoNv9hBAfPnYRWbDjVJYpGx3AChTmRVwg2
         GuuGta+B9rAb5hjXpdLYMb3a/VeRGB1wL0fhFENnqI50cE65QJidDOmoE/1FPA7XI7Np
         sOVMvwCw1MMM7e/HZvpYaKhCFPhauOsGvuw5VS4IcwI377b2RktPA9w7NNna9UbipUGD
         hk7Lzuubg+5dIyAg7O4pkkJsV30W1IR2ks9PzlysFJiOAIm4nKy7mVyccPWXXVTaHST7
         NjF5hPqKm5YTnpal7JLO5C8pHHmYbMiLHQffnBznNG9+FtJlaFh8vB7Fr0zjeg7/ewP3
         ve5g==
X-Gm-Message-State: AAQBX9doZCAP12EHOqtA1DI8U1eLT+55Th/iBWikPbJeW9qWhbcdvnZw
        DWH5lZ+KiqtKTHQyxMOfTBDz1lYsVhzFtacf
X-Google-Smtp-Source: AKy350btqlac7ZrP9R2ICxEcCNBoBLYonnNWTvqR/JvPs0K5+sO1mKnH6AegPBQJDMcAPZ4FPrTNvw==
X-Received: by 2002:a05:622a:130f:b0:3e6:720f:bad7 with SMTP id v15-20020a05622a130f00b003e6720fbad7mr19864719qtk.54.1681186599543;
        Mon, 10 Apr 2023 21:16:39 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:8681])
        by smtp.gmail.com with ESMTPSA id o76-20020a37414f000000b007486052d731sm3738297qka.10.2023.04.10.21.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 21:16:39 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH bpf-next 3/3] bpf,docs: Remove references to bpf_cgroup_kptr_get()
Date:   Mon, 10 Apr 2023 23:16:33 -0500
Message-Id: <20230411041633.179404-3-void@manifault.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230411041633.179404-1-void@manifault.com>
References: <20230411041633.179404-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The bpf_cgroup_kptr_get() kfunc has been removed, and
bpf_cgroup_acquire() / bpf_cgroup_release() now have the same semantics
as bpf_task_acquire() / bpf_task_release(). This patch updates the BPF
documentation to reflect this.

Signed-off-by: David Vernet <void@manifault.com>
---
 Documentation/bpf/kfuncs.rst | 68 ------------------------------------
 1 file changed, 68 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index d8a16c4bef7f..3b42cfe12437 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -572,74 +572,6 @@ bpf_task_release() respectively, so we won't provide examples for them.
 
 ----
 
-You may also acquire a reference to a ``struct cgroup`` kptr that's already
-stored in a map using bpf_cgroup_kptr_get():
-
-.. kernel-doc:: kernel/bpf/helpers.c
-   :identifiers: bpf_cgroup_kptr_get
-
-Here's an example of how it can be used:
-
-.. code-block:: c
-
-	/* struct containing the struct task_struct kptr which is actually stored in the map. */
-	struct __cgroups_kfunc_map_value {
-		struct cgroup __kptr * cgroup;
-	};
-
-	/* The map containing struct __cgroups_kfunc_map_value entries. */
-	struct {
-		__uint(type, BPF_MAP_TYPE_HASH);
-		__type(key, int);
-		__type(value, struct __cgroups_kfunc_map_value);
-		__uint(max_entries, 1);
-	} __cgroups_kfunc_map SEC(".maps");
-
-	/* ... */
-
-	/**
-	 * A simple example tracepoint program showing how a
-	 * struct cgroup kptr that is stored in a map can
-	 * be acquired using the bpf_cgroup_kptr_get() kfunc.
-	 */
-	 SEC("tp_btf/cgroup_mkdir")
-	 int BPF_PROG(cgroup_kptr_get_example, struct cgroup *cgrp, const char *path)
-	 {
-		struct cgroup *kptr;
-		struct __cgroups_kfunc_map_value *v;
-		s32 id = cgrp->self.id;
-
-		/* Assume a cgroup kptr was previously stored in the map. */
-		v = bpf_map_lookup_elem(&__cgroups_kfunc_map, &id);
-		if (!v)
-			return -ENOENT;
-
-		/* Acquire a reference to the cgroup kptr that's already stored in the map. */
-		kptr = bpf_cgroup_kptr_get(&v->cgroup);
-		if (!kptr)
-			/* If no cgroup was present in the map, it's because
-			 * we're racing with another CPU that removed it with
-			 * bpf_kptr_xchg() between the bpf_map_lookup_elem()
-			 * above, and our call to bpf_cgroup_kptr_get().
-			 * bpf_cgroup_kptr_get() internally safely handles this
-			 * race, and will return NULL if the task is no longer
-			 * present in the map by the time we invoke the kfunc.
-			 */
-			return -EBUSY;
-
-		/* Free the reference we just took above. Note that the
-		 * original struct cgroup kptr is still in the map. It will
-		 * be freed either at a later time if another context deletes
-		 * it from the map, or automatically by the BPF subsystem if
-		 * it's still present when the map is destroyed.
-		 */
-		bpf_cgroup_release(kptr);
-
-		return 0;
-        }
-
-----
-
 Other kfuncs available for interacting with ``struct cgroup *`` objects are
 bpf_cgroup_ancestor() and bpf_cgroup_from_id(), allowing callers to access
 the ancestor of a cgroup and find a cgroup by its ID, respectively. Both
-- 
2.40.0

