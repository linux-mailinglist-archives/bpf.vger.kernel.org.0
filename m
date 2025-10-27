Return-Path: <bpf+bounces-72392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD0EC11FB7
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 00:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AD6956803B
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 23:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8613314A9;
	Mon, 27 Oct 2025 23:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ROkJHcpF"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EB832D43B
	for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 23:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761607090; cv=none; b=T4HUr5N52tx/3NyLkzmq1/XkDgqHIKHpmZE5ISKHsxT/yQ9jzQBCw15HXN0wz5tEn98fcKXuXBq3CXG1z/EPd6i78AhUQXA/QXJYD2XlbE5BpoGG5Bz0LdnV3giLHUXWedx4ka8RZ9jhmRHblLF8iEsnPnXunOTOY+fYJMWqRWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761607090; c=relaxed/simple;
	bh=0wr9FaY5hkvcsoBPQKkHj6hsLB0pubyUBlRM0QpcEWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MNoTK8Xvc6+Bl/8zxfWtXgrkd+F8w3CavAW5cSf21cu9OI8OS+/BRrt1OqGk6N6arCULCM2U5uYvrLIqBTdq3/7sK3+82kN+hjsuDkdtXyJPeXWIzNq+0Bkqn+LQWNJroF5NsDWf+N/fbERHNn8YxX39K4i4MrrlGtKgFyg43Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ROkJHcpF; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761607087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eRMoLOPHk0Zw/08DZLynFUa0w3uLlt8Rci/TaWmsNjU=;
	b=ROkJHcpFJxR287s1ClvLk0n/MitKV8WJh8dlnZNiqyODiF+DR+ny7u/TdxVPmSWMwOxXEA
	aG8phPsu61dTRGejYx6hsc27/+yhxZxEHIVm2FOjrHFgLToswrU8B8vcFnIZSlzRpdj6Yk
	eGBpTppxkOy3tz5kgupq5haQ1I+SjVg=
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
Subject: [PATCH v2 07/23] mm: introduce bpf_oom_kill_process() bpf kfunc
Date: Mon, 27 Oct 2025 16:17:10 -0700
Message-ID: <20251027231727.472628-8-roman.gushchin@linux.dev>
In-Reply-To: <20251027231727.472628-1-roman.gushchin@linux.dev>
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Introduce bpf_oom_kill_process() bpf kfunc, which is supposed
to be used by BPF OOM programs. It allows to kill a process
in exactly the same way the OOM killer does: using the OOM reaper,
bumping corresponding memcg and global statistics, respecting
memory.oom.group etc.

On success, it sets om_control's bpf_memory_freed field to true,
enabling the bpf program to bypass the kernel OOM killer.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 mm/oom_kill.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index d05ec0f84087..3c86cd755371 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -1288,3 +1288,70 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
 	return -ENOSYS;
 #endif /* CONFIG_MMU */
 }
+
+#ifdef CONFIG_BPF_SYSCALL
+
+__bpf_kfunc_start_defs();
+/**
+ * bpf_oom_kill_process - Kill a process as OOM killer
+ * @oc: pointer to oom_control structure, describes OOM context
+ * @task: task to be killed
+ * @message__str: message to print in dmesg
+ *
+ * Kill a process in a way similar to the kernel OOM killer.
+ * This means dump the necessary information to dmesg, adjust memcg
+ * statistics, leverage the oom reaper, respect memory.oom.group etc.
+ *
+ * bpf_oom_kill_process() marks the forward progress by setting
+ * oc->bpf_memory_freed. If the progress was made, the bpf program
+ * is free to decide if the kernel oom killer should be invoked.
+ * Otherwise it's enforced, so that a bad bpf program can't
+ * deadlock the machine on memory.
+ */
+__bpf_kfunc int bpf_oom_kill_process(struct oom_control *oc,
+				     struct task_struct *task,
+				     const char *message__str)
+{
+	if (oom_unkillable_task(task))
+		return -EPERM;
+
+	/* paired with put_task_struct() in oom_kill_process() */
+	task = tryget_task_struct(task);
+	if (!task)
+		return -EINVAL;
+
+	oc->chosen = task;
+
+	oom_kill_process(oc, message__str);
+
+	oc->chosen = NULL;
+	oc->bpf_memory_freed = true;
+
+	return 0;
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(bpf_oom_kfuncs)
+BTF_ID_FLAGS(func, bpf_oom_kill_process, KF_SLEEPABLE | KF_TRUSTED_ARGS)
+BTF_KFUNCS_END(bpf_oom_kfuncs)
+
+static const struct btf_kfunc_id_set bpf_oom_kfunc_set = {
+	.owner          = THIS_MODULE,
+	.set            = &bpf_oom_kfuncs,
+};
+
+static int __init bpf_oom_init(void)
+{
+	int err;
+
+	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					&bpf_oom_kfunc_set);
+	if (err)
+		pr_warn("error while registering bpf oom kfuncs: %d", err);
+
+	return err;
+}
+late_initcall(bpf_oom_init);
+
+#endif
-- 
2.51.0


