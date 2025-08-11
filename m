Return-Path: <bpf+bounces-65377-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2098FB21616
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 22:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7D027B508A
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 19:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDF62E2DD0;
	Mon, 11 Aug 2025 19:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Upg5dBKR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8082E0923
	for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 19:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754942349; cv=none; b=oIbGL1lN7mfCeJ+F9OP1KR7nlPqz0PtssiK86A3zVu5REceI9CMbQGaXgfNyLkd6sLtonRhpoCV+DHtWAaGB4cmR27mF3BtLjptvzUuIQzH4wep1qoAck3m/7FO743y/cQ9iBaXaY1TZRFpZBEE5dQrqTf1rJGr1haMSl4CU5Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754942349; c=relaxed/simple;
	bh=jMR28ilfVHX+SUo1t67GUqKWDExmrZqZsurm2GV0UP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tInliAz0jCk0biYBRrCD5AiLHRO14okBaQEL02ui8mvS1gzZsve7ilIXZAOBRi8GZf95QFR0sPAmXLGnoS50eFVjHe8cCpJf9gSAwBFfDR2tCfBl212XrY76dnQ7Fr5fou1qp2bEr5TD7/kX6MzOyfRz+CLrLVUkS+VGMYpZBhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Upg5dBKR; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-61813e2fc73so3661660a12.0
        for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 12:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754942346; x=1755547146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZLiYGpQTcPldgV2fAzKZJgc9xMXTEjax1sfKa7l3SA=;
        b=Upg5dBKRLdLH+wBdZ5xRiN7sicVwaJVxMaSp4Apgk7OqPL1QaFTL7H9Lr18uSHLcIQ
         B0GaSFex/MNRopoMHFbqyGfHbEt031H5rseBydNV0S006jfmPQKCvBV7UzxSBND1Hiq2
         57KxCVxlWrECV3w3Imkm0btu76pWmYW5Sxvlhz9OLH4J/0R7eNXPDzVpwKImZqOKNNhf
         5iXVmlrb9KIuL/Jtfu6BzhxcV0W1wttS5mxEtdi/LutcvEqJHkxJz+bw+3JxmgTiMCoW
         SiO27TrpX3LWn9f3yKQPAKF2Atyt52WmfOZYZVj7nzd0VcTB+FZw8xq2BQ8k+yoJeB7s
         cCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754942346; x=1755547146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZLiYGpQTcPldgV2fAzKZJgc9xMXTEjax1sfKa7l3SA=;
        b=Lym7+iShhiC9A2qWLjOhl6v7KGZ/wf/01qQvztkBIhjGCYdwjJUSLglAZw5tPzjkas
         9u3iK+7XMpWgaSfwlTtOMaZW+LjOXIS8uZ3agZ8vmKwyqOLRD1LwJap5toLsqxwkdQaG
         6fgOVwla4CR/uYdMS08F/EF4rQmXnNctCq5CwvoQwWWVgg8wNQUN4cIt+nWy5qHLrH1/
         JOu0gdyvgEwx0NNWyPkMZnTRH8nrJHrf8idYD3Vpjdje5vVvW9j1useqXJcohbz2sUGv
         ysJyQM7FPEBA/n/A7mn7efez9gaHyf3tWjxajTDLjhcFL+cHg49ktbWZli2hIl+Uc60v
         amuA==
X-Gm-Message-State: AOJu0YxUyFUjt6GRltcPVK4qI0zDk6+P5DgOOeJntrgacvNscDTnhcXC
	H/RBPzciT1d3FKK+yZYl/kGTPUXbdWhqXaRCvEOZ/wCt186wTx0R/IePWyH4p/iuXq0=
X-Gm-Gg: ASbGncs+mhhth0lWMIJu4XD4cE+/2m7Dsp5RdtMmxApTESwbsTZW7fC/rthnMux1IuC
	KUacyW99dTPJqoRolEfrinWb+CWsJ1f1tbKuGKGY6UEDNBtmywmEhfM6SqxhpnBOy6AU9C6NWE8
	pKQw6ji52MPInv1m5xJ0hipzvmosZpOka3AGYyyItoCtEttYimnqsz5Zp1XUx9asyPsp9vJVtgs
	Yo4RGkxO7H6W3tCKrTD4K5y6i9P49iU6ypaf1p+YmYuV9KswVX0uZFRhyR13qV2AwCPv0wl2F+u
	ZM7UjqBQL5+y+1sWVmbFW0gnBoPtIID16jefuqhhtsVFzJt+7COmfeSMzbfN64ZfuEJeXiW6E4H
	sMJC/FPsA52k=
X-Google-Smtp-Source: AGHT+IEFoV0Zr60tHzfRSnxr1GUVN/ZQzxx2sBPUqB4K6ZY0LBGvlfqz8q2LJIw2H4N2AxODZff0Vw==
X-Received: by 2002:a05:6402:274e:b0:615:d142:70 with SMTP id 4fb4d7f45d1cf-6184ea37811mr512633a12.11.1754942345510;
        Mon, 11 Aug 2025 12:59:05 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8ffbc39sm19250080a12.51.2025.08.11.12.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 12:59:04 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	tj@kernel.org
Cc: Dan Schatzberg <dschatzberg@meta.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 1/2] bpf: Do not limit bpf_cgroup_from_id to current's namespace
Date: Mon, 11 Aug 2025 12:59:00 -0700
Message-ID: <20250811195901.1651800-2-memxor@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250811195901.1651800-1-memxor@gmail.com>
References: <20250811195901.1651800-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3641; h=from:subject; bh=jMR28ilfVHX+SUo1t67GUqKWDExmrZqZsurm2GV0UP0=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBomkt7NK/JLoEgFs1W8Vh2CRRWSD3Lx351x3REjW99 Xn1kuY+JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaJpLewAKCRBM4MiGSL8RygnhD/ 0WlQkyOnMv/UKGMZM4RC9beqF5NwSQHqOxUygWZkhIYIKT7r5rp6NadbGuqh9+tNOGMi49RVKcnUMA TVU/P1elvHz/4g3dy6XBZlctiAJI+fI83ZDmyxNo8jl1o4WjFCIVGX+0i5bBGoORj38TByAN/0GDKH Yrn7WG+/qTAKTDJ7EgTBDcehR3LReDWdAc6hlS0kLPGMWnNfdvPUQc5/GmBsY5w2XL1s3oFSI4HHHj siMXC3vfCMmsMEboadwspz3la5Yuz2idrSO8movmpMQ/FXt7DLQRqYpSTru1VzjYkVsYw/B5AbgMx8 IWszXIV3vTPb/gw576fe5EjUrvOsD4Ef4w71dTM3WsQvMxrGX7kXuhTs4/XERi9NxIzJy2yDVv5iGU 08Svh4SSnLYW5dtQnTyuUOxGlWJ1Xja6XRhKA5EV4vUlqw33u8FQAmX3+L/nTL3R6r6ZWozDg7VArb n8mv+ojOAt+f/yYQUJdCw5DuVKVroir9wc5d0jPWaAnD/nqf0/Ip2i+5yRaRKu4pRT92gm3Sz/435a VZgSR2l63fT5dkZ8rfPz3aXvHjaNwswQj8oeFs9xWF/OY75IGomBMAqM6KeTvSsrg6PHV2Cx6UbF3J Cfd+lW0oH8j6wFADQHyTrxlcWDkH1X1mb1p2s/n5kfDC9XG9MpRZiFqm194w==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

The bpf_cgroup_from_id kfunc relies on cgroup_get_from_id to obtain the
cgroup corresponding to a given cgroup ID. This helper can be called in
a lot of contexts where the current thread can be random. A recent
example was its use in sched_ext's ops.tick(), to obtain the root cgroup
pointer. Since the current task can be whatever random user space task
preempted by the timer tick, this makes the behavior of the helper
unreliable.

Resolve this by refactoring cgroup_get_from_id to take a parameter to
elide the cgroup_is_descendant check when root_cgns parameter is set to
true.

There is no compatibility breakage here, since changing the namespace
against which the lookup is being done to the root cgroup namespace only
permits a wider set of lookups to succeed now. The cgroup IDs across
namespaces are globally unique, and thus don't need to be retranslated.

Reported-by: Dan Schatzberg <dschatzberg@meta.com>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/cgroup.h   | 2 +-
 kernel/bpf/cgroup_iter.c | 2 +-
 kernel/bpf/helpers.c     | 2 +-
 kernel/cgroup/cgroup.c   | 7 ++++++-
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index b18fb5fcb38e..da757a496fbe 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -650,7 +650,7 @@ static inline void cgroup_kthread_ready(void)
 }
 
 void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen);
-struct cgroup *cgroup_get_from_id(u64 id);
+struct cgroup *cgroup_get_from_id(u64 id, bool root_cgns);
 #else /* !CONFIG_CGROUPS */
 
 struct cgroup_subsys_state;
diff --git a/kernel/bpf/cgroup_iter.c b/kernel/bpf/cgroup_iter.c
index f04a468cf6a7..49234d035583 100644
--- a/kernel/bpf/cgroup_iter.c
+++ b/kernel/bpf/cgroup_iter.c
@@ -212,7 +212,7 @@ static int bpf_iter_attach_cgroup(struct bpf_prog *prog,
 	if (fd)
 		cgrp = cgroup_v1v2_get_from_fd(fd);
 	else if (id)
-		cgrp = cgroup_get_from_id(id);
+		cgrp = cgroup_get_from_id(id, false);
 	else /* walk the entire hierarchy by default. */
 		cgrp = cgroup_get_from_path("/");
 
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6b4877e85a68..12466103917f 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2537,7 +2537,7 @@ __bpf_kfunc struct cgroup *bpf_cgroup_from_id(u64 cgid)
 {
 	struct cgroup *cgrp;
 
-	cgrp = cgroup_get_from_id(cgid);
+	cgrp = cgroup_get_from_id(cgid, true);
 	if (IS_ERR(cgrp))
 		return NULL;
 	return cgrp;
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 312c6a8b55bb..b490e1e0d2c4 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6345,10 +6345,11 @@ void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen)
 /*
  * cgroup_get_from_id : get the cgroup associated with cgroup id
  * @id: cgroup id
+ * @root_cgns: Select root cgroup namespace instead of current's.
  * On success return the cgrp or ERR_PTR on failure
  * Only cgroups within current task's cgroup NS are valid.
  */
-struct cgroup *cgroup_get_from_id(u64 id)
+struct cgroup *cgroup_get_from_id(u64 id, bool root_cgns)
 {
 	struct kernfs_node *kn;
 	struct cgroup *cgrp, *root_cgrp;
@@ -6374,6 +6375,10 @@ struct cgroup *cgroup_get_from_id(u64 id)
 	if (!cgrp)
 		return ERR_PTR(-ENOENT);
 
+	/* We don't need to namespace this operation against current. */
+	if (root_cgns)
+		return cgrp;
+
 	root_cgrp = current_cgns_cgroup_dfl();
 	if (!cgroup_is_descendant(cgrp, root_cgrp)) {
 		cgroup_put(cgrp);
-- 
2.47.3


