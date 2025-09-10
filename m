Return-Path: <bpf+bounces-67978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED1FB50BBA
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 04:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 458561C64088
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 02:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5CE25A34D;
	Wed, 10 Sep 2025 02:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CG5M5fqU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B4A236A8B;
	Wed, 10 Sep 2025 02:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757472367; cv=none; b=ojhbMnVTwNhf2V4+BZkanj6zUAzNBV4Nn2vJWHXyvGzy81/AmRizIVTRvNqNMzHNztNXKVyCwZeFydYJbvLvEIu2z3u3lQo2GTg1NFoGb26lS8cbrQEgjPHdOVKqlIBe5tL45WTUU4J/yW4Nobp0xf54jd7/vtCDibynsbcsT2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757472367; c=relaxed/simple;
	bh=nITjIMN93m9d7QX9a8s3pwKfB9QGWk9pWBAgAG2u5dY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O7tvtFTBcuzmGKFOyvobJ+F5Ljl7m8rzm2NbR5ea4um7z5z3omf42CrxslNMFD8V85a0MgyA5fyU3jSLYcpEsqV0UmSs4WS+uhCWyivhOgCkhhrzpZuGm8oow2YQ83284L3E9YTN5HTSv5IfMjZtN8u05sRB3eBtxcC2yZsFjNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CG5M5fqU; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32b959b4895so4347356a91.1;
        Tue, 09 Sep 2025 19:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757472365; x=1758077165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H52BMjLyLco7XvI71nPQFltzBJVr7MnXzqkREPVvPkU=;
        b=CG5M5fqUU/Nh+sa7V+uIjqYFAPXbim+kfaq0r6WSfR0dGrkRLHGXXVyBaoVKT0YW+N
         u61gs9+2P5LxSO1KnKQx7oPPsSPDeoE1ZROwWTZywtfsODVdgOO9hrp8uoW3/PQdewW9
         oeXRwfHrvvDOC+5siRDI2TjFvTeeBrNQzjE8OgLKItUqoYqWU5mrwhvbyG/62iXmv19/
         g6Znn6feAzJFDmNaIpmZkZJU42SBaRXeycGNoH3qdzxMPZbTZpSMblWGH2hq0Q8ZgDvX
         blqXTWLs8m+qG53j6JuXrbNVRY1c6ocPRCjv1CJ/6RccENLry5FfsPN/5fA7YSE8fPp9
         7U7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757472365; x=1758077165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H52BMjLyLco7XvI71nPQFltzBJVr7MnXzqkREPVvPkU=;
        b=Jwft9fXGE+/wBpaFVW+32+BJebRLqGZHyYw+azsoRfQF716fwMgIGoeQNZbbXFGBxQ
         MD4S90mAJv1RS1ieTzsjGhgapKR/OWsIq1dHwEhBtjCSY9XUDoBqZLrSVgK4tBjFqcFQ
         pT8j0Bmh3nW6yvMeNH76Jj1tYC9+ZYLtLeKwSf5fDOX5MwM290rxOQGe6sLE4ZT+6Afk
         aiJNWl2cBbFE1qjCXZVhlRoKFF3yGYzasIZzEMS0jdnWjZqMLnxM4VSD6XLhKIWACOu6
         cVpd/os76YMZhD1WJjfYAeuSW/MUzLh+koDjtbTKKjfNKCQn3TIp62mdqIx41BH/++xw
         TpKA==
X-Forwarded-Encrypted: i=1; AJvYcCV3OhIBYaeFdlQaJqjwt2WLTw8lmRYVet9qAUdLGrxVy8l3R7BuCly91w1Ir9T6bUiSf+Vgmk3/XAI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq74lLNk9dd/Mbd7B7deFiChPCylBEQ9Goi7ylar0nm7Rx45W6
	wkn2a9JmTWLA96DJjZTulVJYI8smqjrEXwSoYzkAPb7oJfrm1PeiySBy
X-Gm-Gg: ASbGncsnhKZ6PFrqfGeRTbG7s+jTd0JMjs58293gvhG5d24KNWczfPNnBUX1smOzsgx
	i02acmLLkk7SMf4C4boorF2nwoGXGkR9jsqI8epgyknEAFT2XSMDb8GdMgql+WXwov6lys8+GrK
	uh5rorCJAzHhYJR7utVX5/l87iUxftiOmO8UCaV7RK/PvBPXWb0gr6f0VzEWFL0d7BH39NyzgKL
	D4wydCM3LdT+HYtJQ7eyznxNbvyVKAbzBc2AN4rj6z5tXiSizmPpziTz/iGdUVi4dtLnOhc1IEP
	nIT0qNN41+26/qsJzx9sbB1+OCLA2DkjKKXu4xyw+TD7FPmp0B/x36PLnU/0tTHpKioUxiGuYm+
	9xY3K7kIRa8Nug1pv33YC3oEPmYC+mGZOFkVk8irxvndsqkiSTSmjEoTEp6hi8uYcRfKR27nnkM
	W2WCesRqeOunKhQe/S7gISaeiE
X-Google-Smtp-Source: AGHT+IFlxlKSCMUqw8tmGfRinu2UgcuhU2GyAppxt8KkAQwwLR/IdUn4KXAoxACQUsO8Cs0cvPq5TA==
X-Received: by 2002:a17:90b:4b8d:b0:31e:eff1:71a5 with SMTP id 98e67ed59e1d1-32d43f7dd49mr17140406a91.29.1757472365388;
        Tue, 09 Sep 2025 19:46:05 -0700 (PDT)
Received: from localhost.localdomain ([101.82.183.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dbb314bcesm635831a91.12.2025.09.09.19.45.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 09 Sep 2025 19:46:04 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	hannes@cmpxchg.org,
	usamaarif642@gmail.com,
	gutierrez.asier@huawei-partners.com,
	willy@infradead.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	ameryhung@gmail.com,
	rientjes@google.com,
	corbet@lwn.net,
	21cnbao@gmail.com,
	shakeel.butt@linux.dev
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v7 mm-new 06/10] bpf: mark vma->vm_mm as __safe_trusted_or_null
Date: Wed, 10 Sep 2025 10:44:43 +0800
Message-Id: <20250910024447.64788-7-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250910024447.64788-1-laoar.shao@gmail.com>
References: <20250910024447.64788-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vma->vm_mm might be NULL and it can be accessed outside of RCU. Thus,
we can mark it as trusted_or_null. With this change, BPF helpers can safely
access vma->vm_mm to retrieve the associated mm_struct from the VMA.
Then we can make policy decision from the VMA.

The lsm selftest must be modified because it directly accesses vma->vm_mm
without a NULL pointer check; otherwise it will break due to this
change.

For the VMA based THP policy, the use case is as follows,

  @mm = @vma->vm_mm; // vm_area_struct::vm_mm is trusted or null
  if (!@mm)
      return;
  bpf_rcu_read_lock(); // rcu lock must be held to dereference the owner
  @owner = @mm->owner; // mm_struct::owner is rcu trusted or null
  if (!@owner)
    goto out;
  @cgroup1 = bpf_task_get_cgroup1(@owner, MEMCG_HIERARCHY_ID);

  /* make the decision based on the @cgroup1 attribute */

  bpf_cgroup_release(@cgroup1); // release the associated cgroup
out:
  bpf_rcu_read_unlock();

PSI memory information can be obtained from the associated cgroup to inform
policy decisions. Since upstream PSI support is currently limited to cgroup
v2, the following example demonstrates cgroup v2 implementation:

  @owner = @mm->owner;
  if (@owner) {
      // @ancestor_cgid is user-configured
      @ancestor = bpf_cgroup_from_id(@ancestor_cgid);
      if (bpf_task_under_cgroup(@owner, @ancestor)) {
          @psi_group = @ancestor->psi;

        /* Extract PSI metrics from @psi_group and
         * implement policy logic based on the values
         */

      }
  }

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 kernel/bpf/verifier.c                   | 5 +++++
 tools/testing/selftests/bpf/progs/lsm.c | 8 +++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d400e18ee31e..b708b98f796c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7165,6 +7165,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket) {
 	struct sock *sk;
 };
 
+BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct) {
+	struct mm_struct *vm_mm;
+};
+
 static bool type_is_rcu(struct bpf_verifier_env *env,
 			struct bpf_reg_state *reg,
 			const char *field_name, u32 btf_id)
@@ -7206,6 +7210,7 @@ static bool type_is_trusted_or_null(struct bpf_verifier_env *env,
 {
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry));
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct));
 
 	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id,
 					  "__safe_trusted_or_null");
diff --git a/tools/testing/selftests/bpf/progs/lsm.c b/tools/testing/selftests/bpf/progs/lsm.c
index 0c13b7409947..7de173daf27b 100644
--- a/tools/testing/selftests/bpf/progs/lsm.c
+++ b/tools/testing/selftests/bpf/progs/lsm.c
@@ -89,14 +89,16 @@ SEC("lsm/file_mprotect")
 int BPF_PROG(test_int_hook, struct vm_area_struct *vma,
 	     unsigned long reqprot, unsigned long prot, int ret)
 {
-	if (ret != 0)
+	struct mm_struct *mm = vma->vm_mm;
+
+	if (ret != 0 || !mm)
 		return ret;
 
 	__s32 pid = bpf_get_current_pid_tgid() >> 32;
 	int is_stack = 0;
 
-	is_stack = (vma->vm_start <= vma->vm_mm->start_stack &&
-		    vma->vm_end >= vma->vm_mm->start_stack);
+	is_stack = (vma->vm_start <= mm->start_stack &&
+		    vma->vm_end >= mm->start_stack);
 
 	if (is_stack && monitored_pid == pid) {
 		mprotect_count++;
-- 
2.47.3


