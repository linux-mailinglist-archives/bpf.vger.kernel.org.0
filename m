Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F3E6D28EA
	for <lists+bpf@lfdr.de>; Fri, 31 Mar 2023 21:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbjCaT5r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Mar 2023 15:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbjCaT5n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Mar 2023 15:57:43 -0400
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AEC1FD1D;
        Fri, 31 Mar 2023 12:57:42 -0700 (PDT)
Received: by mail-qv1-f51.google.com with SMTP id on15so3931690qvb.7;
        Fri, 31 Mar 2023 12:57:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680292661; x=1682884661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2HAELiYxMwO28bC3+J9qfIMUXe3QPmftJ2DsQn4LZo=;
        b=PQ7lVnPGcbNzZg0/6kU45CcmI6Aejhiaoej7UykV11sRDjOLuvrM9EC75OJPk/joyM
         pYdVGHWdhMheMhXsrlEUuVYWvJ8V4qLweDS3z6LeZEMikUDSe0quDrhNa+vQugeCK1g9
         B95RqPPs22aFke5EEFPSOm/ucekTY3p7jYf4OAE1ubbObpINVgZZQ3/KmDcf7F92y/4A
         VxQZgaKkEHN61koT1KKwb2ce9ou4AIWqLjO/FPYY3SfJmkfjkthC9+h5Ny97uwWBf4k7
         F5KL1VVYUyS/6bovP7kfiQHtWlth4ID9+VQdqhICSZ4Zn6f2oI4ZGtLDhHt4FaQUBXjw
         DJXQ==
X-Gm-Message-State: AAQBX9fvpK9nkevXqMnYmnZutfVw/AYJJz5j9UXOPqXECibScSQo42Eo
        P7eu6mKhsVdHVofRpNQsN7NKu/8TBOquRnTS
X-Google-Smtp-Source: AKy350bVknUp+/NkDrxLlU6G03sK5FqC99zppNTV6idmFxeXEqyX8bKHclXoidgKfdSmDtvb4Vcbuw==
X-Received: by 2002:a05:6214:29e8:b0:5a3:79cd:8ef8 with SMTP id jv8-20020a05621429e800b005a379cd8ef8mr43581327qvb.32.1680292661266;
        Fri, 31 Mar 2023 12:57:41 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:2101])
        by smtp.gmail.com with ESMTPSA id mk14-20020a056214580e00b005dd8b9345e8sm806212qvb.128.2023.03.31.12.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 12:57:40 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH bpf-next v2 3/3] bpf,docs: Update documentation to reflect new task kfuncs
Date:   Fri, 31 Mar 2023 14:57:33 -0500
Message-Id: <20230331195733.699708-4-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230331195733.699708-1-void@manifault.com>
References: <20230331195733.699708-1-void@manifault.com>
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

