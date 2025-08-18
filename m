Return-Path: <bpf+bounces-65911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCCAB2AEEE
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 19:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D0DB1BA3A77
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 17:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0456E2848AC;
	Mon, 18 Aug 2025 17:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bRVkX03N"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC88A284890
	for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 17:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755536560; cv=none; b=sSt+rU/wh91cb6rWVNMtgnIcFb4GNx9xuPBfxtz5gcotfZyJ4Pm4n9T5+XABNhlLaFbSpAr5ccmCMTGcd9QzyetqpSjrezRPb6+4N9LouF5qOTsgy6wLRFM96u/UOwvHgNw+wxPV7TlcnETbaGWyPWIeVRwTvK5rM+My+AF4q5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755536560; c=relaxed/simple;
	bh=vf2FgXUFW1hJGq8BrB8SWUGv/LfqjjuO0IlAyzrPQ0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCbJ1BvnM2FmZ9+t5BIHkp6wnQZbiQXoIvCo7ugkR9vBJfQ18XVoujI38voFEgWP+n7Dt34TKluqkeH/Km8a6b5qA3Gt6wU+Wk28GBbr8s5Meh2WJ52+W+4V/XssbcMve8eUcGUQY142RxIzAc8cz16AjFmy8mAMiHdZfnTW8Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bRVkX03N; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755536556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fR8USxErG1Ul1WpSShNEk/0fldDsW4tkEGeWyFTA9dE=;
	b=bRVkX03N8WwJPSb+ZZILgpbe4ubu++Z3SsDoJNbAOFhyp8e3kblkz8zFcSlnhQn1rguMK6
	Eq1DWH0U3jgeeCrmWHUvCjqQ4AqNEj0rXOn9z2e1USrwOrOMNKVohUmpz34K3IVVLwVlm5
	Qx0QCG6q1nKf6PJJUl8PNSFmr9hYeBw=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: linux-mm@kvack.org,
	bpf@vger.kernel.org
Cc: Suren Baghdasaryan <surenb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@suse.com>,
	David Rientjes <rientjes@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v1 13/14] sched: psi: implement bpf_psi_create_trigger() kfunc
Date: Mon, 18 Aug 2025 10:01:35 -0700
Message-ID: <20250818170136.209169-14-roman.gushchin@linux.dev>
In-Reply-To: <20250818170136.209169-1-roman.gushchin@linux.dev>
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Implement a new bpf_psi_create_trigger() bpf kfunc, which allows
to create new psi triggers and attach them to cgroups or be
system-wide.

Created triggers will exist until the struct ops is loaded and
if they are attached to a cgroup until the cgroup exists.

Due to a limitation of 5 arguments, the resource type and the "full"
bit are squeezed into a single u32.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 kernel/sched/bpf_psi.c | 84 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/kernel/sched/bpf_psi.c b/kernel/sched/bpf_psi.c
index 2ea9d7276b21..94b684221708 100644
--- a/kernel/sched/bpf_psi.c
+++ b/kernel/sched/bpf_psi.c
@@ -156,6 +156,83 @@ static const struct bpf_verifier_ops bpf_psi_verifier_ops = {
 	.is_valid_access = bpf_psi_ops_is_valid_access,
 };
 
+__bpf_kfunc_start_defs();
+
+/**
+ * bpf_psi_create_trigger - Create a PSI trigger
+ * @bpf_psi: bpf_psi struct to attach the trigger to
+ * @cgroup_id: cgroup Id to attach the trigger; 0 for system-wide scope
+ * @resource: resource to monitor (PSI_MEM, PSI_IO, etc) and the full bit.
+ * @threshold_us: threshold in us
+ * @window_us: window in us
+ *
+ * Creates a PSI trigger and attached is to bpf_psi. The trigger will be
+ * active unless bpf struct ops is unloaded or the corresponding cgroup
+ * is deleted.
+ *
+ * Resource's most significant bit encodes whether "some" or "full"
+ * PSI state should be tracked.
+ *
+ * Returns 0 on success and the error code on failure.
+ */
+__bpf_kfunc int bpf_psi_create_trigger(struct bpf_psi *bpf_psi,
+				       u64 cgroup_id, u32 resource,
+				       u32 threshold_us, u32 window_us)
+{
+	enum psi_res res = resource & ~BPF_PSI_FULL;
+	bool full = resource & BPF_PSI_FULL;
+	struct psi_trigger_params params;
+	struct cgroup *cgroup __maybe_unused = NULL;
+	struct psi_group *group;
+	struct psi_trigger *t;
+	int ret = 0;
+
+	if (res >= NR_PSI_RESOURCES)
+		return -EINVAL;
+
+#ifdef CONFIG_CGROUPS
+	if (cgroup_id) {
+		cgroup = cgroup_get_from_id(cgroup_id);
+		if (IS_ERR_OR_NULL(cgroup))
+			return PTR_ERR(cgroup);
+
+		group = cgroup_psi(cgroup);
+	} else
+#endif
+		group = &psi_system;
+
+	params.type = PSI_BPF;
+	params.bpf_psi = bpf_psi;
+	params.privileged = capable(CAP_SYS_RESOURCE);
+	params.res = res;
+	params.full = full;
+	params.threshold_us = threshold_us;
+	params.window_us = window_us;
+
+	t = psi_trigger_create(group, &params);
+	if (IS_ERR(t))
+		ret = PTR_ERR(t);
+	else
+		t->cgroup_id = cgroup_id;
+
+#ifdef CONFIG_CGROUPS
+	if (cgroup)
+		cgroup_put(cgroup);
+#endif
+
+	return ret;
+}
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(bpf_psi_kfuncs)
+BTF_ID_FLAGS(func, bpf_psi_create_trigger, KF_TRUSTED_ARGS)
+BTF_KFUNCS_END(bpf_psi_kfuncs)
+
+static const struct btf_kfunc_id_set bpf_psi_kfunc_set = {
+	.owner          = THIS_MODULE,
+	.set            = &bpf_psi_kfuncs,
+};
+
 static int bpf_psi_ops_reg(void *kdata, struct bpf_link *link)
 {
 	struct bpf_psi_ops *ops = kdata;
@@ -238,6 +315,13 @@ static int __init bpf_psi_struct_ops_init(void)
 	if (!bpf_psi_wq)
 		return -ENOMEM;
 
+	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					&bpf_psi_kfunc_set);
+	if (err) {
+		pr_warn("error while registering bpf psi kfuncs: %d", err);
+		goto err;
+	}
+
 	err = register_bpf_struct_ops(&bpf_psi_bpf_ops, bpf_psi_ops);
 	if (err) {
 		pr_warn("error while registering bpf psi struct ops: %d", err);
-- 
2.50.1


