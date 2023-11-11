Return-Path: <bpf+bounces-14877-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0ACE7E8A2B
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 11:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F285B20B9A
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 10:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA54125DD;
	Sat, 11 Nov 2023 10:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227E6125B6
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 10:12:32 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16C03862
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 02:12:28 -0800 (PST)
Received: from fsav312.sakura.ne.jp (fsav312.sakura.ne.jp [153.120.85.143])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 3ABACRBR036798;
	Sat, 11 Nov 2023 19:12:27 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav312.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp);
 Sat, 11 Nov 2023 19:12:27 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 3ABA7mvc035781
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 11 Nov 2023 19:12:26 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <360548d7-25b5-43e8-9d6d-d6afd31a1f49@I-love.SAKURA.ne.jp>
Date: Sat, 11 Nov 2023 19:12:26 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 5/5] LSM: A sample of dynamically appendable LSM module.
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: linux-security-module <linux-security-module@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, KP Singh <kpsingh@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>, song@kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, renauld@google.com,
        Paolo Abeni <pabeni@redhat.com>
References: <38b318a5-0a16-4cc2-878e-4efa632236f3@I-love.SAKURA.ne.jp>
In-Reply-To: <38b318a5-0a16-4cc2-878e-4efa632236f3@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This patch demonstrates how to use PATCH 4/5. This patch is not for merge.

By the way, should mod_lsm_dynamic_hooks be directly exported to LKM-based
LSMs rather than exporting mod_lsm_add_hooks() to LKM-based LSMs, so that
LKM-based LSMs can check whether hooks which need special considerations
(e.g. security_secid_to_secctx() and security_xfrm_state_pol_flow_match())
are in-use and decide what to do?

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 demo/Makefile |  1 +
 demo/demo.c   | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 demo/Makefile
 create mode 100644 demo/demo.c

diff --git a/demo/Makefile b/demo/Makefile
new file mode 100644
index 000000000000..9b2ef5f08392
--- /dev/null
+++ b/demo/Makefile
@@ -0,0 +1 @@
+obj-m = demo.o
diff --git a/demo/demo.c b/demo/demo.c
new file mode 100644
index 000000000000..6f6f603b8cd7
--- /dev/null
+++ b/demo/demo.c
@@ -0,0 +1,25 @@
+#include <linux/lsm_hooks.h>
+#include <uapi/linux/lsm.h>
+
+#define LSM_INT_HOOK(RET, DEFAULT, NAME, ...)				\
+	static RET test_##NAME(__VA_ARGS__) {				\
+		pr_info_once("Called %s\n", __func__);			\
+		return DEFAULT;						\
+	}
+#define LSM_VOID_HOOK(RET, DEFAULT, NAME, ...)				\
+	static RET test_##NAME(__VA_ARGS__) {				\
+		pr_info_once("Called %s\n", __func__);			\
+	}
+#include <linux/lsm_hook_defs.h>
+
+static const struct security_hook_mappings test_callbacks __initconst = {
+#define LSM_HOOK(RET, DEFAULT, NAME, ...) .NAME = test_##NAME,
+#include <linux/lsm_hook_defs.h>
+};
+
+static int __init test_init(void)
+{
+	return mod_lsm_add_hooks(&test_callbacks);
+}
+module_init(test_init);
+MODULE_LICENSE("GPL");
-- 
2.34.1



