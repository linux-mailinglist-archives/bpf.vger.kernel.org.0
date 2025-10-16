Return-Path: <bpf+bounces-71080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 126A7BE1C7D
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 08:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84536581276
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 06:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6F92DF3FD;
	Thu, 16 Oct 2025 06:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3fo1uhh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2272DF141
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 06:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760596803; cv=none; b=WkM95NR6sTlOrL5zr6Oz0NXLxtrUuFxs0+5J6lcvfTBn0pCOcDrTqWG2SRtgnGkXAdq8LuRXZLGycW9V8ezXkwQvtLrYS2wJZXvK1oM+j2sGoRqm6plmLacyib6gqqLfBK6rlARtyUq9bSc8vF+2RAjtZ5BpDNEgQfXFeOL89M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760596803; c=relaxed/simple;
	bh=EV3Y0wcxuAxC69UF4yw8OaByMPUzEwvM/cwyhCR44mU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b2+atnRSP2eCFPZ8BdYIa+GW80PbizcuiYB4C18/GGQg8BgTU/xn56vZ6fwmls8qUQ/zobYfedxSGjeLURrMUvKuZxnKxEQpX61bROEnyJl54h/ad1eFBfrdMTxHR8EL0iVG68WVh0ssIR/dIr7G6qcj54+EXr+sClaFpI2Jy/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3fo1uhh; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2907ba47f71so4944565ad.3
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 23:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760596801; x=1761201601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yv57AS0sud7udBU3VdeXqMkDWR8ZNIb3mkdGXwgT2dA=;
        b=J3fo1uhhQqxObGgzG9Ka2QRLrWdXNoJOYk8FO14PV2+vA+93cdGCNp+Qcm5drW5m5h
         aSGJDvVJlxf+K5kdwtBo6AO1b/YLrl2aThdZq6uDETX8R2F/lhYVU0RR+xbg3uf6e74w
         Hlg6VFcvwtOl1oZ4X3RJm1Zankb5FYELKctSXFmd83byjJYliQ7IIrRAaa83vPsHfI0d
         OalPR0tqg3j65XTVmryP4PmiCC9V44UnZ4lPRoRoEpXbwSlI05Twm5nzdpJAi1e3MW1+
         lQ3vrnqxORdEcw4PjUcIGaQRYECjne91EHevHV+juQLgKfEdbeSXWtdHqwIFVKjRELPs
         caZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760596801; x=1761201601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yv57AS0sud7udBU3VdeXqMkDWR8ZNIb3mkdGXwgT2dA=;
        b=eqGv0GklKaf6vnlH3iqbkThZobRZ8yK5f5KEwjnjT4IDxScseo1EfugQi4Tng6SiKm
         FhUsSRYkkowaXyXud6k36geEtb6zkblDyrQY+VmnaL/tfCVyKIkmHsQyJa7N7BGatjHV
         UbF8CpKL0RttiQsd1UHk5zgGfDDBSYhuVtZ4Gdme/aKwpr38Ti4zFEGiMhJ2TCe2RBeu
         C/8E4gbNbD7/YoV3Xa7ommi36P1/XdODMvwyjBWaMpSbmkch3lJb+cZyDu6wthHNG8Xq
         i4lRkzxjXd54buwKdveVty0ZB8ZFFZv5BiLq7GCuZCFO2NnmTohb0eJ8UkTmdKNNoNf4
         dKig==
X-Gm-Message-State: AOJu0YyTy1FRaJ4uOGxSXQP1T1+aa/5YEpTxVxkB9Vs52BRUHbT6nrEu
	BVLqt0sLAxtNM253ZMv4SzPnN5G+O4rvJ32iAnGRUn1nxNU84XOEXdap
X-Gm-Gg: ASbGncuQZuopeBtWVqq6a+GdorDqAKzj0NhWMpUunT8AljB8k03uh7uKUZRKYGNope7
	mj7I/drlcIJu5zlVPCXyidvICvrd9jmOFwVbsvZKW2Qslp+kyYyA1GRlRnnE0Oh6OhGKTimBPWj
	sNpOsNqKOEO/v969KLcKemfMRmNK6Gb7WFehiME6UROmXgPN3sA7Kt3/U3L77l9dIYL99o+Wajc
	AQK5xryiioe9+jEh+k4yDJcKjfL0919I0lAK7vu2jiyMQzeWXsUROSQbeB6HD2VK2Y/jCXe21PU
	bl/aPpH32VcCFiYNG2F5qrLPvLt9+aydOf3d5oFK2yuCGRCZI0ShZ1we4gGMc7mEHSlxngK7E9h
	xtxS4gtf8VYLA4Pf9ATU2/sGioHMCE2jhPNWNo4+vQXZ69i8gJ+ONBn6hjMWYyF8Gl0H4FRwdaD
	4uwuvCcYOnfv9YYbWlyuEi8H8PoGUQBo/5uLGQLUL9
X-Google-Smtp-Source: AGHT+IFjar0LDP3QaLq0VkbUnnA8EmyZ/Zc6YPKzikaNOKCl7VV/VudUH0vvoPaIiBRppfQWPBa4Mw==
X-Received: by 2002:a17:902:e550:b0:25f:fe5f:c927 with SMTP id d9443c01a7336-290272c0a06mr421392585ad.31.1760596800968;
        Wed, 15 Oct 2025 23:40:00 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1d64:636e:f4f7:9293:7b0c:3078])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099b0215esm17555295ad.112.2025.10.15.23.39.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Oct 2025 23:40:00 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH bpf-next 2/2] bpf: mark vma->{vm_mm,vm_file} as __safe_trusted_or_null
Date: Thu, 16 Oct 2025 14:39:29 +0800
Message-Id: <20251016063929.13830-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20251016063929.13830-1-laoar.shao@gmail.com>
References: <20251016063929.13830-1-laoar.shao@gmail.com>
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

The vma::vm_file can also be marked with __safe_trusted_or_null.

No additional selftests are required since vma->vm_file and vma->vm_mm are
already validated in the existing selftest suite.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
---
 kernel/bpf/verifier.c                   | 6 ++++++
 tools/testing/selftests/bpf/progs/lsm.c | 8 +++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d0adf5600c4d..9b4f6920f79b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7096,6 +7096,11 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket) {
 	struct sock *sk;
 };
 
+BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct) {
+	struct mm_struct *vm_mm;
+	struct file *vm_file;
+};
+
 static bool type_is_rcu(struct bpf_verifier_env *env,
 			struct bpf_reg_state *reg,
 			const char *field_name, u32 btf_id)
@@ -7137,6 +7142,7 @@ static bool type_is_trusted_or_null(struct bpf_verifier_env *env,
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


