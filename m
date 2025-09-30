Return-Path: <bpf+bounces-70003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC98DBAB9DF
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 08:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A6FA1925DD1
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 06:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256E728151E;
	Tue, 30 Sep 2025 06:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKxAC9SS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBAB27A929
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 05:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759212000; cv=none; b=RIBuOOGDCFIj3fgP2k+8jOUWsfHLRmlTomFcSKBdHSO3WMkkUJYSBKbkp2IuO5GsU047Ivu444CLBRYbQ8J7YxItIgLf5pLBCCd9aw0GAWmEQu1iTVxDfYa6xbWVOkfBlUVsBLiQLaPo8uZFTSyZdwMzxPnecvNxOVuzhLeFjqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759212000; c=relaxed/simple;
	bh=/PMdDC4FDfpJHwrfvPwAn92Vwj5QW0m0NvTBiXm9L2o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C/1PRSjA2OPatF+HiB0FYgMOoA1Ffz32+xUTlimb8+MfSW8GeHG0Ttg2nm5APSxIBLUcftUSp91jJUieFPUmj5KQnkmwe2YcCkUFUkNQnS+zqu4xiWFJV0/TJlMa+nLkYxxjWsi4q9K3WohCkEEKSbw2c2KfgoHAkXqCJjVQjOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKxAC9SS; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b55197907d1so4173008a12.0
        for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 22:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759211998; x=1759816798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/w5JYrEq/PCfn3Rwv8DsVtkgCdC0Y7Hm3GpSfLGEBg=;
        b=jKxAC9SSr5PpQCU4NI4dYxin5h1Ru0bOlUGNViEBSnJ0FUuVExjzi+D5UWedLVjTnj
         hwcA1w6HPBtE3MZKT8Dc9L3NhRCDa8ykZYueCh8Y6hNvgxvX/iSOA/fcBKWkRE71EAmC
         fyhWXxE7vROkgCcpS8hjbUK+MWJzWZtYyzJpZSRQX2uFI2cbWD5+3it1QP/5lEDlPLEL
         rUHEInGsLfiPCu/g0RIFtOoSKL4CBqJ6IuR4+Nsyg6ujC2VEkrVMhJLkSdI3ZF3gJEPd
         Utr10XWiZXLhu4wfJMoY5d39u/LssMpcUtj8U+Zdqn1q7IEiobYyhd2DEJhWfrbzabUm
         TlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759211998; x=1759816798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/w5JYrEq/PCfn3Rwv8DsVtkgCdC0Y7Hm3GpSfLGEBg=;
        b=Et3ZDwPg7OLG/7OzRhh2QdHDXOduTj9bf5O0ef9WvdQOA1RwXHv0Pio2nTuX02mD0P
         V6V5K8dpNrJCRoR0nIV0GEnl8nXkJFsqlVrJ7rrSczy65wNH5FqfDbmKniqWPvR5BHI7
         LqVPC9MobT0hN/4MJ397v2S2T6Su6C71S2qTy51i5cVaYrDFR523XfHUD/qjPMainMqR
         7yW3i2SHL3T1Ll1ZU/6VSa0q/PACqUMV1waY3fYGG18qBM4jPzQKXR4EB4tYdFZLMT6D
         BufcuVediZIDA5/tau9WrN7HcwjmJ+6bdpnVqaEe4d8bsA/ImdWhOIY+t8AcQsoLu9+g
         mSoQ==
X-Gm-Message-State: AOJu0YzgQNLA0xwsIg93QfOYUuNLAZTVn5vjIgTtIaEOQaJHL/7XxtJ5
	wubobn2zyjRj4Yp6ySN/IBIYWBtylh8xUlTcpVsT3B2/w6Hq3sQqmGZn
X-Gm-Gg: ASbGncuzsCy+fDM1tPAPbXE2/aAOtn2FsnelyaBsadWp73/BBmtL6Lu4e/ItsPZqrp7
	5DbBkKBFaYi2jWbx76PMzFuMd4t7Dy8CFXxtM0izJCRpF3Ku1R/vq9jmZJiyLLV7NsRN5qwvcE7
	txDTWX26Qnjld/tj+aBUrv+vbR1tMm2u+YTkGPSmEKfWjx77G45stYZoXxKzqJCtx/gYucZ1JQ2
	K/TQwtPn29cluF4WS5TLFOo4wMdF538qC8YpCFJCm1kOst60rVPKR+98hRQnnJr4LBG0/LDoYqV
	f86yWaH+pl/7NLSMx8gf6A3yQXoIp/OSiNEiumsYqHHRfyd6gZDObhZlTR99cp7qMSKd6alhzw/
	pPx8oq+1C2jfChT9BOu8eO2cAHezcEz6clDvyPBPgTcJagCsLsgg8XG3kt4pP1wDROfNUFs8mHP
	iwOBdfwumm+fu/EJODXctQKTl5i6ofhIFEsL/6Fg==
X-Google-Smtp-Source: AGHT+IE9k45OyD1zQ/sX5CO57YKwXTRytMKq5dOgl/BGR9iX74e3JrI32v11I5E6AD/8k/izN7MaGQ==
X-Received: by 2002:a17:903:13ce:b0:275:c2f:1b41 with SMTP id d9443c01a7336-27ed4ada760mr178958735ad.53.1759211998324;
        Mon, 29 Sep 2025 22:59:58 -0700 (PDT)
Received: from localhost.localdomain ([61.171.228.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d43b8sm148834065ad.9.2025.09.29.22.59.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Sep 2025 22:59:57 -0700 (PDT)
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
	lance.yang@linux.dev,
	rdunlap@infradead.org
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v9 mm-new 07/11] bpf: mark vma->vm_mm as __safe_trusted_or_null
Date: Tue, 30 Sep 2025 13:58:22 +0800
Message-Id: <20250930055826.9810-8-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250930055826.9810-1-laoar.shao@gmail.com>
References: <20250930055826.9810-1-laoar.shao@gmail.com>
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


