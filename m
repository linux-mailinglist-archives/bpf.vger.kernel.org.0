Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3E164ABD2
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 00:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbiLLXyV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 18:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbiLLXyU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 18:54:20 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C135417886;
        Mon, 12 Dec 2022 15:54:19 -0800 (PST)
Received: by mail-qt1-f177.google.com with SMTP id g7so10522254qts.1;
        Mon, 12 Dec 2022 15:54:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=noGFwDjUHBLfUSIIxv927Be+1JlbaOUfDbfux21yM8Q=;
        b=NboE11xuiihF4dSLCFJwN985SvkF9ZEZo4Bg/o3oDML0+eZe7JlGjKDIhEMrpQuJkm
         79v9J+M4D1rXx+2e7bH+8bWddDAJd/h1OHKPugCxo90f4ZKxRnJS32XntOEEcOtJFWeC
         IDj1feNBIVqS4NPGOGsHKS2jiw4uFmwuVUVwotzW8e0Lxo7qSZq8s0kw4qZlbVZWij+d
         wgcBpg9WuSQqJHy/7KwrB9yOZUxKhxRNr0qNbTN2ddFJzyU2GqqSg1OcOLCD/odFwNjQ
         PJh0ImNZ23JZmyg9uXkCY6WBilu9Tf0/a85EctnLKWCgo+vEvOWRUjQj4EXdo/NZ9gZY
         a6Sw==
X-Gm-Message-State: ANoB5pkBj7cx+de5wuTZHUxw/UKTPyVE8GrnOg86V9ELdb8Yf6om9gzx
        gBJM9k0ZKiTqkLDgky0f9X/CE7dMAfxdwt8r
X-Google-Smtp-Source: AA0mqf4BGMAglophcO5ZNIdtUqjG8vAsrapRhP/B9bf5ovqpHX75MbowHSMJB7pdKLpOnXvOkw1Yqw==
X-Received: by 2002:a05:622a:11c3:b0:3a7:f424:3ef9 with SMTP id n3-20020a05622a11c300b003a7f4243ef9mr32212052qtk.13.1670889258382;
        Mon, 12 Dec 2022 15:54:18 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:6a51])
        by smtp.gmail.com with ESMTPSA id p13-20020a05620a112d00b006f87d28ea3asm6489672qkk.54.2022.12.12.15.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 15:54:18 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, kernel test robot <lkp@intel.com>
Subject: [PATCH bpf-next] bpf/selftests: Use parent instead of last_wakee in task kfunc test
Date:   Mon, 12 Dec 2022 17:53:44 -0600
Message-Id: <20221212235344.1563280-1-void@manifault.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit fe147956fca4 ("bpf/selftests: Add selftests for new task kfuncs")
added a negative selftest called task_kfunc_acquire_trusted_walked which
ensures that a BPF program that gets a struct task_struct * pointer from
walking a struct is properly rejected by the verifier if it tries to
pass that pointer to a task kfunc. In order to do this, it uses
task->last_wakee, but unfortunately that's not defined on UP builds.
Just use task->parent instead.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: fe147956fca4 ("bpf/selftests: Add selftests for new task kfuncs")
Signed-off-by: David Vernet <void@manifault.com>
---
 tools/testing/selftests/bpf/progs/task_kfunc_failure.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
index 87fa1db9d9b5..60508c20041f 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
@@ -73,7 +73,7 @@ int BPF_PROG(task_kfunc_acquire_trusted_walked, struct task_struct *task, u64 cl
 	struct task_struct *acquired;
 
 	/* Can't invoke bpf_task_acquire() on a trusted pointer obtained from walking a struct. */
-	acquired = bpf_task_acquire(task->last_wakee);
+	acquired = bpf_task_acquire(task->parent);
 	bpf_task_release(acquired);
 
 	return 0;
-- 
2.38.1

