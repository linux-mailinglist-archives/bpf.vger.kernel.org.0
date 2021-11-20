Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C423457FAF
	for <lists+bpf@lfdr.de>; Sat, 20 Nov 2021 17:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhKTQ6e (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 20 Nov 2021 11:58:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:38232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230248AbhKTQ6e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 20 Nov 2021 11:58:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3CB0960E9B;
        Sat, 20 Nov 2021 16:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637427330;
        bh=RTeT79yElQusYDmhJbFnRvEJSbYhiimKujwcu/GXqHQ=;
        h=From:To:Cc:Subject:Date:From;
        b=ki5Acw6aMrrfdWh43qyIBRxWq2IEyrnd3mGQYJVz+VQKyguNmqVXuPqYrT0pbBgSe
         +Ss+HLBORi8JAS6Arl6vyjkJZaeZHipl+zhU8FwzzjWMCMy2KsEXB8xyrXJfSXqc7K
         jZ7P6zRPX+nnMwqPzXtHdTT8oGRTLsumDvZqYPhPm8uodg8jaXEwge81VeAjXrH1/3
         CcP4oiyTKfidiEksBV5nsE7FOSnnnp5qBDZW8VVY4lhUqbQb53y7uJwukMuuQ2MMCq
         gd0lC4yizl7BgGBGzPRHnNXRi5jRy2B1B2owNJ1yYcmfXCqgBtbE6gz8LEKuB2nfvh
         DLmk6wSxF+Kpg==
From:   Jakub Kicinski <kuba@kernel.org>
To:     fenghua.yu@intel.com, reinette.chatre@intel.com
Cc:     bpf@vger.kernel.org, james.morse@arm.com,
        Jakub Kicinski <kuba@kernel.org>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, peterz@infradead.org,
        will@kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH bpf] cacheinfo: move get_cpu_cacheinfo_id() back out
Date:   Sat, 20 Nov 2021 08:55:28 -0800
Message-Id: <20211120165528.197359-1-kuba@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This commit more or less reverts commit 709c4362725a ("cacheinfo:
Move resctrl's get_cache_id() to the cacheinfo header file").

There are no users of the static inline helper outside of resctrl/core.c
and cpu.h is a pretty heavy include, it pulls in device.h etc. This
trips up architectures like riscv which want to access cacheinfo
in low level headers like elf.h.

Link: https://lore.kernel.org/all/20211120035253.72074-1-kuba@kernel.org/
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: fenghua.yu@intel.com
CC: reinette.chatre@intel.com
CC: tglx@linutronix.de
CC: mingo@redhat.com
CC: bp@alien8.de
CC: dave.hansen@linux.intel.com
CC: x86@kernel.org
CC: hpa@zytor.com
CC: paul.walmsley@sifive.com
CC: palmer@dabbelt.com
CC: aou@eecs.berkeley.edu
CC: peterz@infradead.org
CC: will@kernel.org
CC: linux-riscv@lists.infradead.org

x86 resctrl folks, does this look okay?

I'd like to do some bpf header cleanups in -next which this is blocking.
How would you like to handle that? This change looks entirely harmless,
can I get an ack and take this via bpf/netdev to Linus ASAP so it
propagates to all trees?
---
 arch/x86/kernel/cpu/resctrl/core.c | 20 ++++++++++++++++++++
 include/linux/cacheinfo.h          | 21 ---------------------
 2 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index bb1c3f5f60c8..3c0b2c34be23 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -284,6 +284,26 @@ static void rdt_get_cdp_l2_config(void)
 	rdt_get_cdp_config(RDT_RESOURCE_L2);
 }
 
+/*
+ * Get the id of the cache associated with @cpu at level @level.
+ * cpuhp lock must be held.
+ */
+static int get_cpu_cacheinfo_id(int cpu, int level)
+{
+	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(cpu);
+	int i;
+
+	for (i = 0; i < ci->num_leaves; i++) {
+		if (ci->info_list[i].level == level) {
+			if (ci->info_list[i].attributes & CACHE_ID)
+				return ci->info_list[i].id;
+			return -1;
+		}
+	}
+
+	return -1;
+}
+
 static void
 mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)
 {
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index 2f909ed084c6..c8c71eea237d 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -3,7 +3,6 @@
 #define _LINUX_CACHEINFO_H
 
 #include <linux/bitops.h>
-#include <linux/cpu.h>
 #include <linux/cpumask.h>
 #include <linux/smp.h>
 
@@ -102,24 +101,4 @@ int acpi_find_last_cache_level(unsigned int cpu);
 
 const struct attribute_group *cache_get_priv_group(struct cacheinfo *this_leaf);
 
-/*
- * Get the id of the cache associated with @cpu at level @level.
- * cpuhp lock must be held.
- */
-static inline int get_cpu_cacheinfo_id(int cpu, int level)
-{
-	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(cpu);
-	int i;
-
-	for (i = 0; i < ci->num_leaves; i++) {
-		if (ci->info_list[i].level == level) {
-			if (ci->info_list[i].attributes & CACHE_ID)
-				return ci->info_list[i].id;
-			return -1;
-		}
-	}
-
-	return -1;
-}
-
 #endif /* _LINUX_CACHEINFO_H */
-- 
2.31.1

