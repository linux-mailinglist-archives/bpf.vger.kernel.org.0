Return-Path: <bpf+bounces-12513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653827CD433
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 08:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96CDE1C20AE0
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 06:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299A58F71;
	Wed, 18 Oct 2023 06:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FwW88olg"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59501FC5
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 06:18:48 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA84D19A9
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 23:18:19 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c9bca1d96cso44216355ad.3
        for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 23:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697609894; x=1698214694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQoEay4rhaVzIBrBvVhg11HsCpeS6HANzS4lkGBCuZ4=;
        b=FwW88olgJ5EWUU25m6KzuQ6R858GYT0Ra2cPUGTZ1aXWYsCvDvhXDm8o8rVYoKTPBO
         cL1bp9RR1NrR4Yrmr6bAhWa65Jw5Lm/dqivydvj4sIBy6HKRei2Axp/3sNBo3uMGw+Mf
         VXEnX7jM7x4BWA+QJhPZBKJYq3Dp8omZWV+EA4YGlBljDXex3jqHyCuAg+YcVHzViJ27
         hYXUj2SuaXJztjePmIJsU8CBievUhtZj7a3dcz4iI34lXhAco5vobbmRXjZ81hjgPuls
         TgFV6adRs5cqatgR68QofM/sD5ajefX8qR6RPEVDo1Xxe/jABtwLhJF2dSEMjeB6aNPb
         4g9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697609894; x=1698214694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bQoEay4rhaVzIBrBvVhg11HsCpeS6HANzS4lkGBCuZ4=;
        b=Ktlrja2hWRf/5FbwQAWwP3CyHK1YS9fFMK4YjmD8vZ1KKTdVe0EVemdT9AMwywmx4B
         Jkl1w3e852NStGrnHUaHtoO27OrpYfmy0zmqYq+0tJfYx6JVYod8bn1MztNmg8wVD8eS
         nTAZ1P7ZtQ3d81HZmf6XqRu2/GuOxJu3NcnOKr+FWcwN54BERf66atfp8mFQvFjH9OJV
         XckPoAXvnjRFhZniKIcmQDD9+3EaR2r4annrTvKHRNlfr7uAT8l8ox0ETVYotaxiDHeq
         9Y2bfJw+EAFkWd4eDmbB6RNGi6rTF8J/SIFxVAX+zBPuK0bL4harQAfMbmHaGznFLtX9
         aLBg==
X-Gm-Message-State: AOJu0YzwUJrQAPN2DKN8Es5y3+RxF2cEAFULNmusPwrf9na1S7DotFCf
	TuZ3CziBccYU67SkeN2F+9CIod4GKU0RBQlxIP2avg==
X-Google-Smtp-Source: AGHT+IHe5ZdVnEzS5tjxpfZ8uEPb9SiEMM/KwW0ztO0tbDERHa84ynxNWv4YWxXpeDJgGfrzjTyw3A==
X-Received: by 2002:a17:902:ecc9:b0:1ca:1af1:681d with SMTP id a9-20020a170902ecc900b001ca1af1681dmr4504438plh.67.1697609894426;
        Tue, 17 Oct 2023 23:18:14 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.103.200])
        by smtp.gmail.com with ESMTPSA id ix13-20020a170902f80d00b001c61acd5bd2sm2659116plb.112.2023.10.17.23.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 23:18:14 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	tj@kernel.org,
	linux-kernel@vger.kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [RESEND PATCH bpf-next v6 7/8] selftests/bpf: rename bpf_iter_task.c to bpf_iter_tasks.c
Date: Wed, 18 Oct 2023 14:17:45 +0800
Message-Id: <20231018061746.111364-8-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231018061746.111364-1-zhouchuyi@bytedance.com>
References: <20231018061746.111364-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The newly-added struct bpf_iter_task has a name collision with a selftest
for the seq_file task iter's bpf skel, so the selftests/bpf/progs file is
renamed in order to avoid the collision.

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/bpf_iter.c        | 18 +++++++++---------
 .../{bpf_iter_task.c => bpf_iter_tasks.c}      |  0
 2 files changed, 9 insertions(+), 9 deletions(-)
 rename tools/testing/selftests/bpf/progs/{bpf_iter_task.c => bpf_iter_tasks.c} (100%)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index 41aba139b20b..e3498f607b49 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -7,7 +7,7 @@
 #include "bpf_iter_ipv6_route.skel.h"
 #include "bpf_iter_netlink.skel.h"
 #include "bpf_iter_bpf_map.skel.h"
-#include "bpf_iter_task.skel.h"
+#include "bpf_iter_tasks.skel.h"
 #include "bpf_iter_task_stack.skel.h"
 #include "bpf_iter_task_file.skel.h"
 #include "bpf_iter_task_vmas.skel.h"
@@ -215,12 +215,12 @@ static void *do_nothing_wait(void *arg)
 static void test_task_common_nocheck(struct bpf_iter_attach_opts *opts,
 				     int *num_unknown, int *num_known)
 {
-	struct bpf_iter_task *skel;
+	struct bpf_iter_tasks *skel;
 	pthread_t thread_id;
 	void *ret;
 
-	skel = bpf_iter_task__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "bpf_iter_task__open_and_load"))
+	skel = bpf_iter_tasks__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_tasks__open_and_load"))
 		return;
 
 	ASSERT_OK(pthread_mutex_lock(&do_nothing_mutex), "pthread_mutex_lock");
@@ -239,7 +239,7 @@ static void test_task_common_nocheck(struct bpf_iter_attach_opts *opts,
 	ASSERT_FALSE(pthread_join(thread_id, &ret) || ret != NULL,
 		     "pthread_join");
 
-	bpf_iter_task__destroy(skel);
+	bpf_iter_tasks__destroy(skel);
 }
 
 static void test_task_common(struct bpf_iter_attach_opts *opts, int num_unknown, int num_known)
@@ -307,10 +307,10 @@ static void test_task_pidfd(void)
 
 static void test_task_sleepable(void)
 {
-	struct bpf_iter_task *skel;
+	struct bpf_iter_tasks *skel;
 
-	skel = bpf_iter_task__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "bpf_iter_task__open_and_load"))
+	skel = bpf_iter_tasks__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_tasks__open_and_load"))
 		return;
 
 	do_dummy_read(skel->progs.dump_task_sleepable);
@@ -320,7 +320,7 @@ static void test_task_sleepable(void)
 	ASSERT_GT(skel->bss->num_success_copy_from_user_task, 0,
 		  "num_success_copy_from_user_task");
 
-	bpf_iter_task__destroy(skel);
+	bpf_iter_tasks__destroy(skel);
 }
 
 static void test_task_stack(void)
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task.c b/tools/testing/selftests/bpf/progs/bpf_iter_tasks.c
similarity index 100%
rename from tools/testing/selftests/bpf/progs/bpf_iter_task.c
rename to tools/testing/selftests/bpf/progs/bpf_iter_tasks.c
-- 
2.20.1


