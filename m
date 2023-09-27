Return-Path: <bpf+bounces-10976-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 628747B07C0
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 17:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 11284281D0D
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 15:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF16338F98;
	Wed, 27 Sep 2023 15:09:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1F31170F
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 15:09:52 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DF2F4;
	Wed, 27 Sep 2023 08:09:49 -0700 (PDT)
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 38RF9ZRE033048;
	Thu, 28 Sep 2023 00:09:36 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Thu, 28 Sep 2023 00:09:35 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 38RF9Z8a033045
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 28 Sep 2023 00:09:35 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <9fccf6d7-4b1b-dd4e-5479-3c6d21d08d5a@I-love.SAKURA.ne.jp>
Date: Thu, 28 Sep 2023 00:09:31 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: [RFC PATCH 2/2] LSM: A sample of dynamically appendable LSM module.
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: linux-security-module <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        KP Singh <kpsingh@kernel.org>, Paul Moore <paul@paul-moore.com>,
        bpf <bpf@vger.kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <cc8e16bb-5083-01da-4a77-d251a76dc8ff@I-love.SAKURA.ne.jp>
In-Reply-To: <cc8e16bb-5083-01da-4a77-d251a76dc8ff@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This is an example of dynamically appendable LSM modules.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 demo/Makefile |  1 +
 demo/demo.c   | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)
 create mode 100644 demo/Makefile
 create mode 100644 demo/demo.c

diff --git a/demo/Makefile b/demo/Makefile
new file mode 100644
index 000000000000..8a6ab0945858
--- /dev/null
+++ b/demo/Makefile
@@ -0,0 +1 @@
+obj-m += demo.o
diff --git a/demo/demo.c b/demo/demo.c
new file mode 100644
index 000000000000..90b03d10bd72
--- /dev/null
+++ b/demo/demo.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/module.h>
+#include <linux/lsm_hooks.h>
+
+static int demo_task_alloc_security(struct task_struct *p,
+				    unsigned long clone_flags)
+{
+	static unsigned int count;
+
+	if (count++ < 5)
+		dump_stack();
+	return 0;
+}
+
+static void demo_task_free_security(struct task_struct *p)
+{
+	static unsigned int count;
+
+	if (count++ < 5)
+		dump_stack();
+}
+
+static struct security_hook_list demo_hooks[] __ro_after_init = {
+	LSM_HOOK_INIT(task_free, demo_task_free_security),
+	LSM_HOOK_INIT(task_alloc, demo_task_alloc_security),
+};
+
+static int __init demo_init(void)
+{
+	const int ret = register_loadable_lsm(demo_hooks,
+					      ARRAY_SIZE(demo_hooks), "demo");
+
+	pr_info("Registering demo LSM module returned %d.\n", ret);
+	return ret;
+}
+
+module_init(demo_init);
+MODULE_LICENSE("GPL");
-- 
2.18.4


