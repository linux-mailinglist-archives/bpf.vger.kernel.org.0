Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3806D1488
	for <lists+bpf@lfdr.de>; Fri, 31 Mar 2023 02:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjCaA54 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 20:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjCaA5v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 20:57:51 -0400
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0E21287A;
        Thu, 30 Mar 2023 17:57:42 -0700 (PDT)
Received: by mail-qv1-f54.google.com with SMTP id on15so2200994qvb.7;
        Thu, 30 Mar 2023 17:57:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680224262; x=1682816262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2HAELiYxMwO28bC3+J9qfIMUXe3QPmftJ2DsQn4LZo=;
        b=TfD18HyLQtJeiv2iyc29Hb1AFGuW4AL1/YrVXkw6jjWgkUHaOG6ETfAYM3h/CmIz5G
         iregs9hK02ZpTGmFFBd57trMDHqxtwWLRzYYD6gjAg7d09TTIx7FBLXK6Qf1LI2/x6st
         KQuO7IqNIHTDxRVEbbGA3kdW/ZlbI/3AuL/XBG3bGSqTIV0Doke61eASSkutPZJDBrg1
         xGBSMuXBZEGm9KKpZ58QWaEWRDZdA5nqXwFn6IHF4hePMVrdVgbP4XE4iqvLySYmTR3r
         oP8YtDd4MiGvxRA9KMxvI1rZT0ppEGk6y1G7MilJH3Tu1Jv61+xD/A67POAwOJ0shH0x
         ftSw==
X-Gm-Message-State: AAQBX9flZfg+yb44vLzpe4uqGbqu64z5pOp9RuAVima6rW8qOmrjJN+f
        Dz4HvbGseik+re5djvMBqTDs8DEjDdREvblG
X-Google-Smtp-Source: AKy350bFoDhg0ywndRPXD1hgcLcVwfLGZIutGa9huWRoKqjC2CVyzg+C465z9zYd6rzX7TJswPmGfA==
X-Received: by 2002:ad4:5d6d:0:b0:5a6:1571:1eb with SMTP id fn13-20020ad45d6d000000b005a6157101ebmr46195371qvb.27.1680224261529;
        Thu, 30 Mar 2023 17:57:41 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:d9ee])
        by smtp.gmail.com with ESMTPSA id mh10-20020a056214564a00b005dd8b9345d7sm221514qvb.111.2023.03.30.17.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 17:57:40 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH bpf-next 3/3] bpf,docs: Update documentation to reflect new task kfuncs
Date:   Thu, 30 Mar 2023 19:57:33 -0500
Message-Id: <20230331005733.406202-4-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230331005733.406202-1-void@manifault.com>
References: <20230331005733.406202-1-void@manifault.com>
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

Now that struct task_struct objects are RCU safe, and bpf_task_acquire()
can return NULL, we should update the BPF task kfunc documentation to
reflect the current state of the API.

Signed-off-by: David Vernet <void@manifault.com>
---
 Documentation/bpf/kfuncs.rst | 49 +++++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 6 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index bf1b85941452..d8a16c4bef7f 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -471,13 +471,50 @@ struct_ops callback arg. For example:
 		struct task_struct *acquired;
 
 		acquired = bpf_task_acquire(task);
+		if (acquired)
+			/*
+			 * In a typical program you'd do something like store
+			 * the task in a map, and the map will automatically
+			 * release it later. Here, we release it manually.
+			 */
+			bpf_task_release(acquired);
+		return 0;
+	}
+
+
+References acquired on ``struct task_struct *`` objects are RCU protected.
+Therefore, when in an RCU read region, you can obtain a pointer to a task
+embedded in a map value without having to acquire a reference:
+
+.. code-block:: c
+
+	#define private(name) SEC(".data." #name) __hidden __attribute__((aligned(8)))
+	private(TASK) static struct task_struct *global;
+
+	/**
+	 * A trivial example showing how to access a task stored
+	 * in a map using RCU.
+	 */
+	SEC("tp_btf/task_newtask")
+	int BPF_PROG(task_rcu_read_example, struct task_struct *task, u64 clone_flags)
+	{
+		struct task_struct *local_copy;
+
+		bpf_rcu_read_lock();
+		local_copy = global;
+		if (local_copy)
+			/*
+			 * We could also pass local_copy to kfuncs or helper functions here,
+			 * as we're guaranteed that local_copy will be valid until we exit
+			 * the RCU read region below.
+			 */
+			bpf_printk("Global task %s is valid", local_copy->comm);
+		else
+			bpf_printk("No global task found");
+		bpf_rcu_read_unlock();
+
+		/* At this point we can no longer reference local_copy. */
 
-		/*
-		 * In a typical program you'd do something like store
-		 * the task in a map, and the map will automatically
-		 * release it later. Here, we release it manually.
-		 */
-		bpf_task_release(acquired);
 		return 0;
 	}
 
-- 
2.39.0

