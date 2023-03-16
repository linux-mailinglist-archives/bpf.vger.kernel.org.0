Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333256BC5C9
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 06:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjCPFlA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Mar 2023 01:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjCPFkp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Mar 2023 01:40:45 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640BD6A41F;
        Wed, 15 Mar 2023 22:40:43 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id l13so651333qtv.3;
        Wed, 15 Mar 2023 22:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678945242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fujln5B4PJVc7FU0F2EjRjzV5VR7c7BJfqwtEXGQG30=;
        b=UPe4MoEo5xB90E7RYxvwYRMo9UawZ2jOG35bbNgk6IW3u5h+eHIewAzFJ9VWTsIZtK
         2ZdGdOcfEO4jzcCFLxPuZYLebUFQONfaNIifNYKk7p/8XVOmTA/zk/rsvxEAlCEmNxXO
         RD2AIF9soECGakncnUjj+zVOfYyGzF4VytBqcFXXVmK7kORMg3wqR1ENn+PvYbTtuxEi
         rwnJL6oQlMJNUH5JilYC0WrSDamZbn7+1gaC/MlroAcE4vMyWPa5pWIjtzQ7uWVUUVPL
         tPc8wJtLrEmAfj3gDYm2MtTf4p7EklNrcsiGafw+8/i+O5WOjkfAOMdh1fMA4pPy95Q6
         U/fA==
X-Gm-Message-State: AO0yUKXqh4tvvM0Rj1e6tcynDrv3/EdCHEU+4S8Xyf2/h8OkRu+VZfFb
        1LUyrPkev6sJqz5e4CqTEPh5Xc/yaON/0MwC
X-Google-Smtp-Source: AK7set8u14/TgtQFShFGqRVTwenRE0RKtyesci01OPUE3ndb1zjE42wihiabm2gZ0OZuPxV7bjRPUA==
X-Received: by 2002:ac8:58c2:0:b0:3bf:b6ba:1c1f with SMTP id u2-20020ac858c2000000b003bfb6ba1c1fmr4747926qta.10.1678945242097;
        Wed, 15 Mar 2023 22:40:42 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:7f57])
        by smtp.gmail.com with ESMTPSA id q8-20020a374308000000b0074589d41342sm5152303qka.17.2023.03.15.22.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 22:40:41 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH bpf-next v2 5/5] bpf,docs: Remove bpf_cpumask_kptr_get() from documentation
Date:   Thu, 16 Mar 2023 00:40:28 -0500
Message-Id: <20230316054028.88924-6-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230316054028.88924-1-void@manifault.com>
References: <20230316054028.88924-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now that the kfunc no longer exists, we can remove it and instead
describe how RCU can be used to get a struct bpf_cpumask from a map
value. This patch updates the BPF documentation accordingly.

Signed-off-by: David Vernet <void@manifault.com>
---
 Documentation/bpf/cpumasks.rst | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/Documentation/bpf/cpumasks.rst b/Documentation/bpf/cpumasks.rst
index 75344cd230e5..41efd8874eeb 100644
--- a/Documentation/bpf/cpumasks.rst
+++ b/Documentation/bpf/cpumasks.rst
@@ -117,12 +117,7 @@ For example:
 As mentioned and illustrated above, these ``struct bpf_cpumask *`` objects can
 also be stored in a map and used as kptrs. If a ``struct bpf_cpumask *`` is in
 a map, the reference can be removed from the map with bpf_kptr_xchg(), or
-opportunistically acquired with bpf_cpumask_kptr_get():
-
-.. kernel-doc:: kernel/bpf/cpumask.c
-  :identifiers: bpf_cpumask_kptr_get
-
-Here is an example of a ``struct bpf_cpumask *`` being retrieved from a map:
+opportunistically acquired using RCU:
 
 .. code-block:: c
 
@@ -144,7 +139,7 @@ Here is an example of a ``struct bpf_cpumask *`` being retrieved from a map:
 	/**
 	 * A simple example tracepoint program showing how a
 	 * struct bpf_cpumask * kptr that is stored in a map can
-	 * be acquired using the bpf_cpumask_kptr_get() kfunc.
+	 * be passed to kfuncs using RCU protection.
 	 */
 	SEC("tp_btf/cgroup_mkdir")
 	int BPF_PROG(cgrp_ancestor_example, struct cgroup *cgrp, const char *path)
@@ -158,26 +153,21 @@ Here is an example of a ``struct bpf_cpumask *`` being retrieved from a map:
 		if (!v)
 			return -ENOENT;
 
+		bpf_rcu_read_lock();
 		/* Acquire a reference to the bpf_cpumask * kptr that's already stored in the map. */
-		kptr = bpf_cpumask_kptr_get(&v->cpumask);
-		if (!kptr)
+		kptr = v->cpumask;
+		if (!kptr) {
 			/* If no bpf_cpumask was present in the map, it's because
 			 * we're racing with another CPU that removed it with
 			 * bpf_kptr_xchg() between the bpf_map_lookup_elem()
-			 * above, and our call to bpf_cpumask_kptr_get().
-			 * bpf_cpumask_kptr_get() internally safely handles this
-			 * race, and will return NULL if the cpumask is no longer
-			 * present in the map by the time we invoke the kfunc.
+			 * above, and our load of the pointer from the map.
 			 */
+			bpf_rcu_read_unlock();
 			return -EBUSY;
+		}
 
-		/* Free the reference we just took above. Note that the
-		 * original struct bpf_cpumask * kptr is still in the map. It will
-		 * be freed either at a later time if another context deletes
-		 * it from the map, or automatically by the BPF subsystem if
-		 * it's still present when the map is destroyed.
-		 */
-		bpf_cpumask_release(kptr);
+		bpf_cpumask_setall(kptr);
+		bpf_rcu_read_unlock();
 
 		return 0;
 	}
-- 
2.39.0

