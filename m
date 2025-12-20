Return-Path: <bpf+bounces-77220-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CC397CD26B6
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 05:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96F2F301EFC2
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 04:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98E228851E;
	Sat, 20 Dec 2025 04:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sWqi11Yi"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F382DC348
	for <bpf@vger.kernel.org>; Sat, 20 Dec 2025 04:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766203998; cv=none; b=HBa/aqA9RQaiTbh9uSi4TvZgn1YxgEtbWUWqfj7nVBPNq1x/5k1iluHQVURK0G1gjZQ4Dd9JFYACpyfXHiadX9I51zE9Caq2iIXch84b06wkD2NVA3GXrM71XPabqFDRntlCJ81wekrJHasYN58FN9rZbgPEQcUCyFHDrLhadvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766203998; c=relaxed/simple;
	bh=1hi3glfETAFDmWGNL3renLl9xfaf8AlnEKtPVTLuFOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OTeHlQRzZ/LAwmuo6J7aYg45MSPtyCSUbUzTRYUfvv/ldhdLCYmwWaa0KaM004DiysaQO5uVjJerDHqoJvWIrfvpnalLRzZX3C2gQzYK0NL84Mhxu4Zh93qGU9bPS5cRWXoyViYjZ0M+lwc4TByNW/h2ZRUdXArNBLFxKEVvJ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sWqi11Yi; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766203994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+QSJTSDVQWiKe8Yn9P+ThjPphZH9zD1eW5Vd3nR6fOA=;
	b=sWqi11YiqXfaC4q538Oi6YnjR2MSP8tTLim8jXiIFt4IKJJyXeziCX3dWTTdJK7u6wRacv
	DWZJ6jebb21kHCjYJ+tj+ageCL0XhRlOYpZhjjcBn9IdYm/zbE1cLIJOMjPomVt+PMw0Rh
	vpkVuj89b6hPDNdWFXf3NlxouB83tes=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: JP Kobryn <inwardvessel@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH bpf-next v2 2/7] mm: introduce BPF kfuncs to deal with memcg pointers
Date: Fri, 19 Dec 2025 20:12:45 -0800
Message-ID: <20251220041250.372179-3-roman.gushchin@linux.dev>
In-Reply-To: <20251220041250.372179-1-roman.gushchin@linux.dev>
References: <20251220041250.372179-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

To effectively operate with memory cgroups in BPF there is a need
to convert css pointers to memcg pointers. A simple container_of
cast which is used in the kernel code can't be used in BPF because
from the verifier's point of view that's a out-of-bounds memory access.

Introduce helper get/put kfuncs which can be used to get
a refcounted memcg pointer from the css pointer:
  - bpf_get_mem_cgroup,
  - bpf_put_mem_cgroup.

bpf_get_mem_cgroup() can take both memcg's css and the corresponding
cgroup's "self" css. It allows it to be used with the existing cgroup
iterator which iterates over cgroup tree, not memcg tree.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 mm/Makefile         |  3 ++
 mm/bpf_memcontrol.c | 88 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)
 create mode 100644 mm/bpf_memcontrol.c

diff --git a/mm/Makefile b/mm/Makefile
index 9175f8cc6565..79c39a98ff83 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -106,6 +106,9 @@ obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
 ifdef CONFIG_SWAP
 obj-$(CONFIG_MEMCG) += swap_cgroup.o
 endif
+ifdef CONFIG_BPF_SYSCALL
+obj-$(CONFIG_MEMCG) += bpf_memcontrol.o
+endif
 obj-$(CONFIG_CGROUP_HUGETLB) += hugetlb_cgroup.o
 obj-$(CONFIG_GUP_TEST) += gup_test.o
 obj-$(CONFIG_DMAPOOL_TEST) += dmapool_test.o
diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
new file mode 100644
index 000000000000..03d435fc4f10
--- /dev/null
+++ b/mm/bpf_memcontrol.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Memory Controller-related BPF kfuncs and auxiliary code
+ *
+ * Author: Roman Gushchin <roman.gushchin@linux.dev>
+ */
+
+#include <linux/memcontrol.h>
+#include <linux/bpf.h>
+
+__bpf_kfunc_start_defs();
+
+/**
+ * bpf_get_mem_cgroup - Get a reference to a memory cgroup
+ * @css: pointer to the css structure
+ *
+ * Returns a pointer to a mem_cgroup structure after bumping
+ * the corresponding css's reference counter.
+ *
+ * It's fine to pass a css which belongs to any cgroup controller,
+ * e.g. unified hierarchy's main css.
+ *
+ * Implements KF_ACQUIRE semantics.
+ */
+__bpf_kfunc struct mem_cgroup *
+bpf_get_mem_cgroup(struct cgroup_subsys_state *css)
+{
+	struct mem_cgroup *memcg = NULL;
+	bool rcu_unlock = false;
+
+	if (mem_cgroup_disabled() || !root_mem_cgroup)
+		return NULL;
+
+	if (root_mem_cgroup->css.ss != css->ss) {
+		struct cgroup *cgroup = css->cgroup;
+		int ssid = root_mem_cgroup->css.ss->id;
+
+		rcu_read_lock();
+		rcu_unlock = true;
+		css = rcu_dereference_raw(cgroup->subsys[ssid]);
+	}
+
+	if (css && css_tryget(css))
+		memcg = container_of(css, struct mem_cgroup, css);
+
+	if (rcu_unlock)
+		rcu_read_unlock();
+
+	return memcg;
+}
+
+/**
+ * bpf_put_mem_cgroup - Put a reference to a memory cgroup
+ * @memcg: memory cgroup to release
+ *
+ * Releases a previously acquired memcg reference.
+ * Implements KF_RELEASE semantics.
+ */
+__bpf_kfunc void bpf_put_mem_cgroup(struct mem_cgroup *memcg)
+{
+	css_put(&memcg->css);
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(bpf_memcontrol_kfuncs)
+BTF_ID_FLAGS(func, bpf_get_mem_cgroup, KF_TRUSTED_ARGS | KF_ACQUIRE | KF_RET_NULL | KF_RCU)
+BTF_ID_FLAGS(func, bpf_put_mem_cgroup, KF_TRUSTED_ARGS | KF_RELEASE)
+
+BTF_KFUNCS_END(bpf_memcontrol_kfuncs)
+
+static const struct btf_kfunc_id_set bpf_memcontrol_kfunc_set = {
+	.owner          = THIS_MODULE,
+	.set            = &bpf_memcontrol_kfuncs,
+};
+
+static int __init bpf_memcontrol_init(void)
+{
+	int err;
+
+	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
+					&bpf_memcontrol_kfunc_set);
+	if (err)
+		pr_warn("error while registering bpf memcontrol kfuncs: %d", err);
+
+	return err;
+}
+late_initcall(bpf_memcontrol_init);
-- 
2.52.0


