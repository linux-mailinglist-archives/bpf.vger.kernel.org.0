Return-Path: <bpf+bounces-72398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6528EC11FD2
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 00:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A93F4FBC33
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 23:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4BD32F773;
	Mon, 27 Oct 2025 23:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XScDR66j"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856FB32E15C
	for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 23:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761607351; cv=none; b=IyWieKYjEOjp2i8ve1zmU2THBqvUGJpYZCMEgfddxUOKL6KzyUgOn6AfbKsDw9h12sZDDTb/p1bF5Ga2GPJ0T9bnaHq036BiieV8n91SUsaCJMBC23krK1cBu0DXholdjOYeNUpCFgPvxZwKhmx2ExKHbmvSUB6KSi7J+ayJJ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761607351; c=relaxed/simple;
	bh=CDyGtWCoQ33h7zf8zCT5L6wXnYxarIaWaohQBfVt4VQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ajFwg/GAYrrpUH3RDCUI7Ex1P8y977I5vVs0ljxFg5PO/JieCnsxTKiYnGk9EQKeBL/0xboX4tNxhPONxCtrR2/k2ImWWYgv9KperpvyO7MHpxgAkvsdcChupMfkHJERwM+fg+j/urRZtP+uzQ2SWRR4hM5mofzdA5joQP4LGno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XScDR66j; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761607347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+abN6iitn2yfinJo1jnZ+CHI4w7IGfOgtbnQsSctr0o=;
	b=XScDR66j+a3Uh1LJC+kDO2Y4ZAhtZtfxUeNRyzppoM/lkQDv71BgJWp3YFfQCGWsfagatF
	d/tHEQT6khGeiuJpSp9NrugoLmrdV51jpcXbHTlsJTJMYF3N9+ennLsNQNL/I30UEbI0g7
	xq/ub5nLqljSIW9djzibhtEWEhSS4ao=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v2 13/23] mm: introduce bpf_out_of_memory() BPF kfunc
Date: Mon, 27 Oct 2025 16:21:56 -0700
Message-ID: <20251027232206.473085-3-roman.gushchin@linux.dev>
In-Reply-To: <20251027232206.473085-1-roman.gushchin@linux.dev>
References: <20251027232206.473085-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Introduce bpf_out_of_memory() bpf kfunc, which allows to declare
an out of memory events and trigger the corresponding kernel OOM
handling mechanism.

It takes a trusted memcg pointer (or NULL for system-wide OOMs)
as an argument, as well as the page order.

If the BPF_OOM_FLAGS_WAIT_ON_OOM_LOCK flag is not set, only one OOM
can be declared and handled in the system at once, so if the function
is called in parallel to another OOM handling, it bails out with -EBUSY.
This mode is suited for global OOM's: any concurrent OOMs will likely
do the job and release some memory. In a blocking mode (which is
suited for memcg OOMs) the execution will wait on the oom_lock mutex.

The function is declared as sleepable. It guarantees that it won't
be called from an atomic context. It's required by the OOM handling
code, which shouldn't be called from a non-blocking context.

Handling of a memcg OOM almost always requires taking of the
css_set_lock spinlock. The fact that bpf_out_of_memory() is sleepable
also guarantees that it can't be called with acquired css_set_lock,
so the kernel can't deadlock on it.

Please, note that this function will be inaccessible as of now.
Calling bpf_out_of_memory() from a random context is dangerous
because e.g. it's easy to deadlock the system on oom_lock.
The following commit in the series will provide one safe context
where this kfunc can be used.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/oom.h |  5 ++++
 mm/oom_kill.c       | 63 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/include/linux/oom.h b/include/linux/oom.h
index 721087952d04..3cbdcd013274 100644
--- a/include/linux/oom.h
+++ b/include/linux/oom.h
@@ -21,6 +21,11 @@ enum oom_constraint {
 	CONSTRAINT_MEMCG,
 };
 
+enum bpf_oom_flags {
+	BPF_OOM_FLAGS_WAIT_ON_OOM_LOCK = 1 << 0,
+	BPF_OOM_FLAGS_LAST = 1 << 1,
+};
+
 /*
  * Details of the page allocation that triggered the oom killer that are used to
  * determine what should be killed.
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 3c86cd755371..d7fca4bf575b 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -1330,15 +1330,78 @@ __bpf_kfunc int bpf_oom_kill_process(struct oom_control *oc,
 	return 0;
 }
 
+/**
+ * bpf_out_of_memory - declare Out Of Memory state and invoke OOM killer
+ * @memcg__nullable: memcg or NULL for system-wide OOMs
+ * @order: order of page which wasn't allocated
+ * @flags: flags
+ * @constraint_text__nullable: custom constraint description for the OOM report
+ *
+ * Declares the Out Of Memory state and invokes the OOM killer.
+ *
+ * OOM handlers are synchronized using the oom_lock mutex. If wait_on_oom_lock
+ * is true, the function will wait on it. Otherwise it bails out with -EBUSY
+ * if oom_lock is contended.
+ *
+ * Generally it's advised to pass wait_on_oom_lock=false for global OOMs
+ * and wait_on_oom_lock=true for memcg-scoped OOMs.
+ *
+ * Returns 1 if the forward progress was achieved and some memory was freed.
+ * Returns a negative value if an error occurred.
+ */
+__bpf_kfunc int bpf_out_of_memory(struct mem_cgroup *memcg__nullable,
+				  int order, u64 flags)
+{
+	struct oom_control oc = {
+		.memcg = memcg__nullable,
+		.order = order,
+	};
+	int ret;
+
+	if (flags & ~(BPF_OOM_FLAGS_LAST - 1))
+		return -EINVAL;
+
+	if (oc.order < 0 || oc.order > MAX_PAGE_ORDER)
+		return -EINVAL;
+
+	if (flags & BPF_OOM_FLAGS_WAIT_ON_OOM_LOCK) {
+		ret = mutex_lock_killable(&oom_lock);
+		if (ret)
+			return ret;
+	} else if (!mutex_trylock(&oom_lock))
+		return -EBUSY;
+
+	ret = out_of_memory(&oc);
+
+	mutex_unlock(&oom_lock);
+	return ret;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_oom_kfuncs)
 BTF_ID_FLAGS(func, bpf_oom_kill_process, KF_SLEEPABLE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_out_of_memory, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(bpf_oom_kfuncs)
 
+BTF_SET_START(bpf_oom_declare_oom_kfuncs)
+BTF_ID(func, bpf_out_of_memory)
+BTF_SET_END(bpf_oom_declare_oom_kfuncs)
+
+extern struct bpf_struct_ops bpf_psi_bpf_ops;
+
+static int bpf_oom_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	if (!btf_id_set_contains(&bpf_oom_declare_oom_kfuncs, kfunc_id))
+		return 0;
+
+	return -EACCES;
+}
+
 static const struct btf_kfunc_id_set bpf_oom_kfunc_set = {
 	.owner          = THIS_MODULE,
 	.set            = &bpf_oom_kfuncs,
+	.filter         = bpf_oom_kfunc_filter,
 };
 
 static int __init bpf_oom_init(void)
-- 
2.51.0


