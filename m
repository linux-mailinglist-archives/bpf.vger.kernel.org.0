Return-Path: <bpf+bounces-11612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 379727BC7C9
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 14:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCFB828220F
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 12:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843B920B23;
	Sat,  7 Oct 2023 12:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lt1pN9oS"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5C11A59C
	for <bpf@vger.kernel.org>; Sat,  7 Oct 2023 12:46:05 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3C6123
	for <bpf@vger.kernel.org>; Sat,  7 Oct 2023 05:45:57 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3af6cd01323so2010115b6e.3
        for <bpf@vger.kernel.org>; Sat, 07 Oct 2023 05:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1696682756; x=1697287556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aEInOcrGpkkZm6SAXLwwS2bVGzjJWfEHqZIWggTzZdM=;
        b=lt1pN9oSAchsyy093FP5ZOcQ2yMfSher/wmsKlW79c4uuFOeXShVWcHpR7pn27MWGq
         pqULeaLgMLK1PZGZx6NVqDNCHodwCWM3V/CIjir3geDO8tjKw2e0SYKZIWpSMOD42KSA
         TIeFF1diX/BYrJG/7S9rj4JRAKkHy1vRCQgY0ltE/zBHUgGcdL6lKMN1HZvz72DlZVJR
         2hRfBXTLIkmZk0Dr4qwF1tQ9V8zzWkDK0nDuxJ4Vd63md2dxp5d6uLBMVsl03gakxq3X
         X2br2IkPt6PY0+kgaTcAF0uR3+ez9lcWuTgNlMP1HGhMlGcpaCcI7eS6PjNn8FZfzLmF
         seKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696682756; x=1697287556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aEInOcrGpkkZm6SAXLwwS2bVGzjJWfEHqZIWggTzZdM=;
        b=oV7eHtctv/ndlc97tjpRXPGn/MfJHmgrkJ9yK+KvN9UObEDnMQ5MLBrY/18OQDqZtt
         MLQRdv0VO5hsW8tPO38sESXZ/QnoOoXUdpuTX25LXx8wpSe4Pvt4NSU6esDtvPOqO4p5
         JZTOzAvUQdBOuekBBFGK6+yahqoz5TsKnoL8ZqwAnexvq5XPvWpEp4hzMD05fjbFmZi6
         xBdflF6LoPyeDhah18+G0ccV1ftvA9geaznlpm3/YlnxhCFTBReTL+bkAiITKCdfIDz8
         TIGNIVOi93kq98xfCXQEjoahhH6ZQa65SnWt9lBGQq/7HPyl1DwsNmNaKIoTygUTKbqm
         h+Xg==
X-Gm-Message-State: AOJu0YwxHeYLI81M8hQ2WO0oAZDyBbhkGEiWas8skLjV+xLB91uSS3jC
	aqXpdh4nHwKOEHzIkSv/Ot9x4VfEN8JG/wbw+fU=
X-Google-Smtp-Source: AGHT+IErZkhi1ojiL9EmPTxnkqSpiVELwiL0y4y+/c/yuYI24EQNbUpxybr7hAkyjGoC7XVC5ri1Jw==
X-Received: by 2002:a05:6358:9494:b0:15a:bd9e:a301 with SMTP id i20-20020a056358949400b0015abd9ea301mr11513089rwb.21.1696682756117;
        Sat, 07 Oct 2023 05:45:56 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.134])
        by smtp.gmail.com with ESMTPSA id d6-20020a17090ad3c600b00256799877ffsm5095388pjw.47.2023.10.07.05.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 05:45:55 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	tj@kernel.org,
	linux-kernel@vger.kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH bpf-next v4 7/8] selftests/bpf: rename bpf_iter_task.c to bpf_iter_tasks.c
Date: Sat,  7 Oct 2023 20:45:21 +0800
Message-Id: <20231007124522.34834-8-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231007124522.34834-1-zhouchuyi@bytedance.com>
References: <20231007124522.34834-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The newly-added struct bpf_iter_task has a name collision with a selftest
for the seq_file task iter's bpf skel, so the selftests/bpf/progs file is
renamed in order to avoid the collision.

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 .../selftests/bpf/prog_tests/bpf_iter.c        | 18 +++++++++---------
 .../{bpf_iter_task.c => bpf_iter_tasks.c}      |  0
 2 files changed, 9 insertions(+), 9 deletions(-)
 rename tools/testing/selftests/bpf/progs/{bpf_iter_task.c => bpf_iter_tasks.c} (100%)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index 1f02168103dd..dc60e8e125cd 100644
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
 #include "bpf_iter_task_vma.skel.h"
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


