Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 668F04186EF
	for <lists+bpf@lfdr.de>; Sun, 26 Sep 2021 09:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhIZHTu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 26 Sep 2021 03:19:50 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:20152 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbhIZHTr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 26 Sep 2021 03:19:47 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HHHBt1JtLz1DDBG;
        Sun, 26 Sep 2021 15:16:54 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Sun, 26 Sep 2021 15:18:09 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Sun, 26 Sep 2021 15:18:08 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <arnd@arndb.de>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <rostedt@goodmis.org>, <mingo@redhat.com>, <davem@davemloft.net>,
        <ast@kernel.org>, <ryabinin.a.a@gmail.com>,
        <akpm@linux-foundation.org>
CC:     <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <bpf@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 3/9] sections: Move and rename core_kernel_data() to is_kernel_core_data()
Date:   Sun, 26 Sep 2021 15:20:42 +0800
Message-ID: <20210926072048.190336-4-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210926072048.190336-1-wangkefeng.wang@huawei.com>
References: <20210926072048.190336-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Move core_kernel_data() into sections.h and rename it to
is_kernel_core_data(), also make it return bool value, then
update all the callers.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/asm-generic/sections.h | 16 ++++++++++++++++
 include/linux/kernel.h         |  1 -
 kernel/extable.c               | 18 ------------------
 kernel/trace/ftrace.c          |  2 +-
 net/sysctl_net.c               |  2 +-
 5 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index 817309e289db..24780c0f40b1 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -142,6 +142,22 @@ static inline bool init_section_intersects(void *virt, size_t size)
 	return memory_intersects(__init_begin, __init_end, virt, size);
 }
 
+/**
+ * is_kernel_core_data - checks if the pointer address is located in the
+ *			 .data section
+ *
+ * @addr: address to check
+ *
+ * Returns: true if the address is located in .data, false otherwise.
+ * Note: On some archs it may return true for core RODATA, and false
+ *       for others. But will always be true for core RW data.
+ */
+static inline bool is_kernel_core_data(unsigned long addr)
+{
+	return addr >= (unsigned long)_sdata &&
+	       addr < (unsigned long)_edata;
+}
+
 /**
  * is_kernel_rodata - checks if the pointer address is located in the
  *                    .rodata section
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 2776423a587e..e5a9af8a4e20 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -230,7 +230,6 @@ extern char *next_arg(char *args, char **param, char **val);
 
 extern int core_kernel_text(unsigned long addr);
 extern int init_kernel_text(unsigned long addr);
-extern int core_kernel_data(unsigned long addr);
 extern int __kernel_text_address(unsigned long addr);
 extern int kernel_text_address(unsigned long addr);
 extern int func_ptr_is_kernel_text(void *ptr);
diff --git a/kernel/extable.c b/kernel/extable.c
index b0ea5eb0c3b4..da26203841d4 100644
--- a/kernel/extable.c
+++ b/kernel/extable.c
@@ -82,24 +82,6 @@ int notrace core_kernel_text(unsigned long addr)
 	return 0;
 }
 
-/**
- * core_kernel_data - tell if addr points to kernel data
- * @addr: address to test
- *
- * Returns true if @addr passed in is from the core kernel data
- * section.
- *
- * Note: On some archs it may return true for core RODATA, and false
- *  for others. But will always be true for core RW data.
- */
-int core_kernel_data(unsigned long addr)
-{
-	if (addr >= (unsigned long)_sdata &&
-	    addr < (unsigned long)_edata)
-		return 1;
-	return 0;
-}
-
 int __kernel_text_address(unsigned long addr)
 {
 	if (kernel_text_address(addr))
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 7efbc8aaf7f6..f15badf31f52 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -323,7 +323,7 @@ int __register_ftrace_function(struct ftrace_ops *ops)
 	if (!ftrace_enabled && (ops->flags & FTRACE_OPS_FL_PERMANENT))
 		return -EBUSY;
 
-	if (!core_kernel_data((unsigned long)ops))
+	if (!is_kernel_core_data((unsigned long)ops))
 		ops->flags |= FTRACE_OPS_FL_DYNAMIC;
 
 	add_ftrace_ops(&ftrace_ops_list, ops);
diff --git a/net/sysctl_net.c b/net/sysctl_net.c
index f6cb0d4d114c..4b45ed631eb8 100644
--- a/net/sysctl_net.c
+++ b/net/sysctl_net.c
@@ -144,7 +144,7 @@ static void ensure_safe_net_sysctl(struct net *net, const char *path,
 		addr = (unsigned long)ent->data;
 		if (is_module_address(addr))
 			where = "module";
-		else if (core_kernel_data(addr))
+		else if (is_kernel_core_data(addr))
 			where = "kernel";
 		else
 			continue;
-- 
2.26.2

