Return-Path: <bpf+bounces-68367-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B6BB56ED3
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 05:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E026C3BC5B1
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 03:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732A9256C71;
	Mon, 15 Sep 2025 03:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFk4FHcf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4517D2A1BA
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 03:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757906785; cv=none; b=tRNucWWpWdLzLY9vpriFQRz7GwKyp3Zo2ebbsWKOlp4Nnk57qqpHJwSTkpyV5gltn2oML1NOGVBpd62unRoHGkRF9TdVm82Y1iXd3XVSzVv5YnCY9xXAH8XjkwjYdkedHKRYrzOmVarb4Aj/WNtzlI3apYwH3LsZSQ6WiPU3jlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757906785; c=relaxed/simple;
	bh=Mj+12UdoMTDFbNV6bA3CkPVL7LH+CXJWKQeuYHTH9rU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lwhC4E/TfUDFjyVY5mnvT1Hel7QWG2k+iu8cqtLSOfIt36txWCREkSbJjPrQQITNqQ+WxMRTa5YRYE3Pqh2jFGYKH0YAGgMGp1RODG574aAy82eWf8Vx5LEdMFm7ramVmf7LIFoCZc7QSbczFvtct5sWBbNivHsyQZep3riNYb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFk4FHcf; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-3e7636aa65fso3103166f8f.1
        for <bpf@vger.kernel.org>; Sun, 14 Sep 2025 20:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757906781; x=1758511581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pCPyDFkthuTiuqPTfEdz0Ipni8Q6EAOu+tfy8kJ2J7E=;
        b=aFk4FHcfBB1fWXV7xqntYDnBnAbLNCDvEBGcuQvmg/tSSLfdddmoVInioOtJcxshsz
         j3GjhvxzXIm1yfV2+JWi/Ae76xa8r3YxwWqnwaLun+s5CJT+xewpVArK4hA8NjJ28xsW
         e1WVttkow/KOrS84PCW5u1cfLRv6AlokldjQMumbNxKscORv95sT7unvCsnqDbotlij/
         7BHlfcJZP6zH+kDxxdqcfE4frqwoT0KXvwevQmTwDFfjoLnSYIPj4S5U9UvPyim5Hral
         GwxvIPpoeG6+LoLZXKzxavn6zcEiqpMa0MCRXFYgb3mQA4sjRM7bksL3mWkJ9zIsghZv
         6SBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757906781; x=1758511581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pCPyDFkthuTiuqPTfEdz0Ipni8Q6EAOu+tfy8kJ2J7E=;
        b=vHMJT0D+gc2X/6A8PzePuPlMt3d9F2eFngyieiIvZH7UVIozJuE3uoZtSg2lIrNwGx
         jyi+FXUnO4TeLDCGnfMUWt1x0Lzb5kIJLXXykTb/U/ObNCJXsVTqTgEUxHVVv6EImP7V
         QOR80MWiwj614dgvhLRR42GEyKHPoMOpDp2z+3Nzw+y9hZsDqG+Pqkx++q0/0LTDsqna
         Lh0R0c/L/Aw7UoilJ6GthHza9Xjt2wWYrnUhr8nVikyNuNpHiNv3fQgzm5SHRg/qQF+/
         /h2Ju3rCIbnk15O+SqT3aoyRN/c9gU1gpw3KGCDa8IUxMOhwsgeV2IAC5SOdSeHw2hmy
         z7UA==
X-Gm-Message-State: AOJu0Yxtc0O6l5xDzPnUDSeHY5gKnFL6Wfl96R8HWpcFhLEDKTkg3IHn
	gd7RwdvmcT8mzWZnC+bVPqfgzVCAUdZBKxSYwTDqXazLC6l06rBas/STktJ8a1hG
X-Gm-Gg: ASbGncsLXxeolMFA5jv0izTGAgywxq/J7fN6WonCwV5vo0wKBalsbAyeEALOYvEHjAi
	DRPNYAZbm67+DYUWdVAM8JsxdzYak3QEsC8uMSJAa1Xr+8kGVxN6RCSteFLcFdYNNwTs84UtH4B
	OlAxCgld+ZGbfUZU/aIoC1BvXVAME0AN+fXUiMNeRXvoiseyhHIt4WdUBSBAHeg8hiiYjmjeC25
	2AGNU1k4TFvCsQwg0JqsAL25smf6MIz4tjgEUnYCVJ2SsacSqJA/uQWD6XSD0IOqSZjhY7yYFcW
	E2pxHD4gn7SYIOSNpjGl+TmSI8HYbGCuH9zGodQu/W3XPDrYa67Ik98mowpB7p1qKZTo8NLovdq
	IeeTP2Qvx1R61AuHMDIrHsLnI7efflESBfhXByrwRFRUi0YVmdDj6zZ4=
X-Google-Smtp-Source: AGHT+IHXDR1de/7TNg6bs2kSdl+iW1SlaW1kBbOJdex1vDW67oc1TNk7wMuF+2BPYv92MgWSzRPohA==
X-Received: by 2002:a05:6000:2885:b0:3ca:4b59:2714 with SMTP id ffacd0b85a97d-3e7658bc84emr9670328f8f.10.1757906781151;
        Sun, 14 Sep 2025 20:26:21 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45f28c193f9sm76769715e9.2.2025.09.14.20.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 20:26:20 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Dan Schatzberg <dschatzberg@meta.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 1/2] bpf: Do not limit bpf_cgroup_from_id to current's namespace
Date: Mon, 15 Sep 2025 03:26:17 +0000
Message-ID: <20250915032618.1551762-2-memxor@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915032618.1551762-1-memxor@gmail.com>
References: <20250915032618.1551762-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3456; i=memxor@gmail.com; h=from:subject; bh=Mj+12UdoMTDFbNV6bA3CkPVL7LH+CXJWKQeuYHTH9rU=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBox4bp7zliyDnQJ2T4aZjd2Pu6EVxHikNAU3VL9 wtG1u005DiJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaMeG6QAKCRBM4MiGSL8R yu+SD/938t6OBtBXHzYIgeIw10r7Cz8Au3K8lhF0LNXlDpLTsQmLPSpQzt3AVZO7yEFJEaU1C9/ HEkcHBCpCZmD1Ozzj3KIP3GVY1WeTszbPsK16CMDpGvHoGNUbk6vaWh+Iavz+u0i97IsOxPN13W F0VJkROh6/9TqmNjCGZWkjt7A+qYeSagy2jtG5rAB2C6v5DX9bAMB1E1YapduOm6OywGjDQ/Rfu 3qW6NNMkQFgYYBDTOR0obHFZNLY8n7vUS7dTu6iPi0xA8pw1ajyRG03hnRnMm+nWu3sBbFUwERF gHxo1YRW2JAcgEbuVscpYsqrrsBa9FU9rvtmQULkijt6mzoBjAqtC8kc9LHsAWhnrKZYcG4PDr+ Vfvjb2qqTJw9uYetLN2bQPuLmGLAqIyeBaGdiiH9E36hF7+7u1PhD/prQypLg9tocFA8dOqVI8n mTR2quXXNh1fMsiyYGYtB1F1opkMPNyyxHYS7UdHhVGEFduSmoT1oKDoHDPcSFIppFqB79E2zvN XZzPh979gx6D6b4TKMRTVPjS9gQ/Sq9Nr6zmbFHSVtnZYivqv+A3degliZgkNwAIftKwpmVPGf8 7vc1pUMMpigCpxddn3y7X+adaZUy//MA8MFyCdgBfIrSw3SkjvbY3BM+zhg1r8PZUdX1bZ5/AOW zOoMMNf74PIWC6A==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

The bpf_cgroup_from_id kfunc relies on cgroup_get_from_id to obtain the
cgroup corresponding to a given cgroup ID. This helper can be called in
a lot of contexts where the current thread can be random. A recent
example was its use in sched_ext's ops.tick(), to obtain the root cgroup
pointer. Since the current task can be whatever random user space task
preempted by the timer tick, this makes the behavior of the helper
unreliable.

Refactor out __cgroup_get_from_id as the non-namespace aware version of
cgroup_get_from_id, and change bpf_cgroup_from_id to make use of it.

There is no compatibility breakage here, since changing the namespace
against which the lookup is being done to the root cgroup namespace only
permits a wider set of lookups to succeed now. The cgroup IDs across
namespaces are globally unique, and thus don't need to be retranslated.

Reported-by: Dan Schatzberg <dschatzberg@meta.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/cgroup.h |  1 +
 kernel/bpf/helpers.c   |  2 +-
 kernel/cgroup/cgroup.c | 24 ++++++++++++++++++++----
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index b18fb5fcb38e..b08c8e62881c 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -650,6 +650,7 @@ static inline void cgroup_kthread_ready(void)
 }
 
 void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen);
+struct cgroup *__cgroup_get_from_id(u64 id);
 struct cgroup *cgroup_get_from_id(u64 id);
 #else /* !CONFIG_CGROUPS */
 
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index c0c0764a2025..51229aba5318 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2546,7 +2546,7 @@ __bpf_kfunc struct cgroup *bpf_cgroup_from_id(u64 cgid)
 {
 	struct cgroup *cgrp;
 
-	cgrp = cgroup_get_from_id(cgid);
+	cgrp = __cgroup_get_from_id(cgid);
 	if (IS_ERR(cgrp))
 		return NULL;
 	return cgrp;
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 312c6a8b55bb..6c2d20ac697c 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6343,15 +6343,15 @@ void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen)
 }
 
 /*
- * cgroup_get_from_id : get the cgroup associated with cgroup id
+ * __cgroup_get_from_id : get the cgroup associated with cgroup id
  * @id: cgroup id
  * On success return the cgrp or ERR_PTR on failure
- * Only cgroups within current task's cgroup NS are valid.
+ * There are no cgroup NS restrictions.
  */
-struct cgroup *cgroup_get_from_id(u64 id)
+struct cgroup *__cgroup_get_from_id(u64 id)
 {
 	struct kernfs_node *kn;
-	struct cgroup *cgrp, *root_cgrp;
+	struct cgroup *cgrp;
 
 	kn = kernfs_find_and_get_node_by_id(cgrp_dfl_root.kf_root, id);
 	if (!kn)
@@ -6373,6 +6373,22 @@ struct cgroup *cgroup_get_from_id(u64 id)
 
 	if (!cgrp)
 		return ERR_PTR(-ENOENT);
+	return cgrp;
+}
+
+/*
+ * cgroup_get_from_id : get the cgroup associated with cgroup id
+ * @id: cgroup id
+ * On success return the cgrp or ERR_PTR on failure
+ * Only cgroups within current task's cgroup NS are valid.
+ */
+struct cgroup *cgroup_get_from_id(u64 id)
+{
+	struct cgroup *cgrp, *root_cgrp;
+
+	cgrp = __cgroup_get_from_id(id);
+	if (IS_ERR(cgrp))
+		return cgrp;
 
 	root_cgrp = current_cgns_cgroup_dfl();
 	if (!cgroup_is_descendant(cgrp, root_cgrp)) {
-- 
2.51.0


