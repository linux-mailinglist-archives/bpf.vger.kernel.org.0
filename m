Return-Path: <bpf+bounces-69819-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 229A6BA32CF
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 11:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35BF71893CB8
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 09:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B4F2C0F7A;
	Fri, 26 Sep 2025 09:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVAJJBtW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D12A2BDC23
	for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 09:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758879297; cv=none; b=a14y6RL/L/J+lZFbhlRYCSgRSbwVI+LdD9PaO6e7H7X1VBTwfTopE5Qa+6gM4Oga+GFNmskcOyTV2pWGJEX4lM8NV+BUNoxUqA2ro/R4eeDtLbG6Dwk7vELi0e6Z5kQYbqJfCCbet29Q0/qJe7w+HDB/0wOSJLYGUAGJ7llbyEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758879297; c=relaxed/simple;
	bh=/PMdDC4FDfpJHwrfvPwAn92Vwj5QW0m0NvTBiXm9L2o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G2NMIBXBqEhN4Bu3EqWkLARLdd98QCmX7kw9k6F7kKi0r0snXtb3A50wxPiCv/RLOP86g8YD1iYjLp/wWhozHfDrbhuogvF3GCECkL7DTVp1d9ortaXLuTzzzmgnJKjsAR+Xcshe84qDOJnxTNWdaXaIwmmq+giFRGOWfsJvJlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVAJJBtW; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-27eed7bdfeeso9307285ad.0
        for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 02:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758879296; x=1759484096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/w5JYrEq/PCfn3Rwv8DsVtkgCdC0Y7Hm3GpSfLGEBg=;
        b=aVAJJBtWjTQ+0GQndpmuNF2CZ36PiGfUddnHBPKOJXlb8mHeEcN82YK0AdL3lfA25p
         N5YRuLx6MGzbtBoD2oKT4IBJlbO8ENgv8TW8I/imMhw0EujlCtNFrmKN68gooyFPwMPR
         D4lvZP7w202cNLitWn9LGyrbApxvaGgYNk7MW+osm0hwyQn2chzaxEtcypWl9lVEyyVW
         n57KEN5V8/DGdn+d3gY3hllJ33KlI630kTnV/JTWYXQ/axQgmOCRQYjAqXP3JRSSJFkQ
         JhD8xb1258KYV3P7DsreaJ568IUQUwwifOTg+sUgBgqO0L61lF1bH7GWl9GuN7lF1Hf1
         R6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758879296; x=1759484096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/w5JYrEq/PCfn3Rwv8DsVtkgCdC0Y7Hm3GpSfLGEBg=;
        b=bz8JeT4GFLWmjkbjOkJH8lONCV80qmVMMbZnX5bSmZfp16koqtPlHb3G9LkcGhfArI
         HWAgHguM9DY9KQTjll45cBO47B/nUwNXOyCF0yHbxk8k4YqsXgWmbCY93r0D8XNqkg64
         zrSv1Vtx7kw7DDU2aeuCzxiW5If9JyCVWM2vYShPRl2kuORedSVVosPaxOifHO9KQSn6
         xOI05sqI1teCOe4UEJaG53mUE612JF3zIeJaKWXfc4UDb6Y4N8XrdZ17vesS87ROpbFM
         e9Y1+/CQfkkVvhA4MU5+eMHXNW+nM8Tpz5LwVu9znAuymLsJUvMIoyC4dIHh1L6bvN91
         fqOw==
X-Gm-Message-State: AOJu0YxUEvTlhThC/oVQ4uhAiTQUcgZIiCCKBHesI+B3g+qN32h3jGWz
	4DW48batKf12+anY6CqfcronQ4H9xpk4Ww33J8iWu/CbzzZJ91yzCFb/
X-Gm-Gg: ASbGncsmILxfVOCAOcAGV9coyi+wytJg3z+/G6aLwO4pN+pM75BP0Lt2N2//N8N35q9
	Ac8eJePXq2LGtE5unaKC94nluECoSWegzbhaabhlcn4T9C6G+X/Iv5WHagaWtRYOQW+/rUEEUlo
	Bvdi/j4jBFrVhKHpkxBT9oPXTd5LP6HjKDyHSvbPo5KkldgLtELIkQyxPIE6XNfvbq/4xIq7OnM
	GbhGlFDTv2TJ893PWkXntzHFlz+QBT9VYCE+Itc7xrwOxodWEyV7zH35cP9u3xRV4V7p9IfAqAo
	X5tUgmr3LUSqpuVCsUaHRJD5vLReOqooRORcXqiJ8AMf62tHCi0rVLkDtU47y10ogPfKM+ee0N2
	NWSlFrQIN+MN8q0GtJ3wD3HO5ajeHN/VjHuDDMpG5gTjQdY5chaaASd8uMKyk8AXp1HMMUbWxEe
	eFCIJVPU4uDB31
X-Google-Smtp-Source: AGHT+IHrdjXmU7uWxKIA6T2fxuFhYbTSMB1I+H7KjcACH1uB/bPjPmFTLzfvYSiunLXewY8lMi00xQ==
X-Received: by 2002:a17:902:db11:b0:27c:3690:2c5d with SMTP id d9443c01a7336-27ed6780b92mr76951455ad.0.1758879295495;
        Fri, 26 Sep 2025 02:34:55 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1c21:566:e1d1:c082:790c:7be6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66cda43sm49247475ad.25.2025.09.26.02.34.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 26 Sep 2025 02:34:54 -0700 (PDT)
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
	shakeel.butt@linux.dev,
	tj@kernel.org,
	lance.yang@linux.dev
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v8 mm-new 08/12] bpf: mark vma->vm_mm as __safe_trusted_or_null
Date: Fri, 26 Sep 2025 17:33:39 +0800
Message-Id: <20250926093343.1000-9-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250926093343.1000-1-laoar.shao@gmail.com>
References: <20250926093343.1000-1-laoar.shao@gmail.com>
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

The "trusted" annotation enables direct access to vma->vm_mm within kfuncs
marked with KF_TRUSTED_ARGS or KF_RCU, such as bpf_task_get_cgroup1() and
bpf_task_under_cgroup(). Conversely, "null" enforcement requires all
callsites using vma->vm_mm to perform NULL checks.

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
Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
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


