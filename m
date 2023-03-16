Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C530D6BC36C
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 02:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjCPBlm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Mar 2023 21:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjCPBlk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Mar 2023 21:41:40 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDACEB860D;
        Wed, 15 Mar 2023 18:41:32 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id l13so285742qtv.3;
        Wed, 15 Mar 2023 18:41:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678930891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fujln5B4PJVc7FU0F2EjRjzV5VR7c7BJfqwtEXGQG30=;
        b=fb9D9hLFXdrVtLcdhi5BPw8DzBQmDCcbu0PPRLD8eaUxDGZWBoM91Zo+X0RZwpvNLr
         C+X+iunwZu0DpWRzI0RA+HEs/zLlC3Lup/YbmPrvZcul1kNsxbBNp63dbgG3+bTM5vPD
         kGhOzsH7inIQVwfp2N+slHi4yuPVUV2wtlELX9nMPLHJg+Bh1Pmh0aJvU64TsE1nAxE0
         4LdDajy9Z9fCSkRQBWawFIMPGmWJzSytUtSP1t/vYJtCsZ4WQS0HIWB4Is7KCQLr4Gwm
         w5ssmj2KcymOhS1PzRE4uu1LrWXhSnEAQLd1v93m9Jmg7AT68beEEhDPKz9JmTuuwRZb
         O/+w==
X-Gm-Message-State: AO0yUKXj/PXGh556SY4JB384n7SbCHTJesYkQkTMSWGWlLiQp4s4gRUb
        6qxvylzL1sHtchtcCOuGjKawAiCRqahB4d62
X-Google-Smtp-Source: AK7set+RdTtIsY3zUnM14bUgfPDAx7kJsfU9mIvCdawhkU7qZ5kCOSCscrFjSTCMTRrTrAhMFE/28Q==
X-Received: by 2002:a05:622a:174c:b0:3bf:d0c7:12df with SMTP id l12-20020a05622a174c00b003bfd0c712dfmr3506016qtk.63.1678930891324;
        Wed, 15 Mar 2023 18:41:31 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:5c58])
        by smtp.gmail.com with ESMTPSA id x24-20020ac86b58000000b003bfa2c512e6sm4735074qts.20.2023.03.15.18.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 18:41:30 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH bpf-next 5/5] bpf,docs: Remove bpf_cpumask_kptr_get() from documentation
Date:   Wed, 15 Mar 2023 20:41:22 -0500
Message-Id: <20230316014122.678082-6-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230316014122.678082-1-void@manifault.com>
References: <20230316014122.678082-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
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

