Return-Path: <bpf+bounces-68363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DB7B56E6D
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 04:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B33C2189BD20
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 02:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4D3221FB2;
	Mon, 15 Sep 2025 02:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5nqjx3r"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F731D7E42
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 02:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757904459; cv=none; b=XnqOMia8JQ9FiFaB/hew9P7F8DnGsUi+UHgwucgMtJsiRNcpqwvI0qyHZJNrNsceAgmgjRbvhZ2aKlkANd2RpfuQVXJD/b1CUaKxFAFTT4//VbbpBwTB0yjv4H3J6kUh2j0VFeCFuQ4rtGbofYlEKQeUUhdVIomqpmg8lH2R1M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757904459; c=relaxed/simple;
	bh=5FjU7w8tmJr7fekbLIiC56K4sk/Cvk4MkeKEB+LHUEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BCzFAAqsYjZKYP2QelCnafxRiMMW22HxoilS9z8SPxm1vo3WEZKDy5ZY8AMPEmaSO/dM1EtYgjCY/F5V+DTMnoVV8NvlNOpALYBbpvdc3aQM4wRGSQcxKkQr3wJ9x/4dHB23dbhqg4oTQB0a53uD6CGBSaH4CWFClR8vvcV5Tpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5nqjx3r; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-45dfb8e986aso38916775e9.0
        for <bpf@vger.kernel.org>; Sun, 14 Sep 2025 19:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757904455; x=1758509255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zL4CkNXz/kx2nDX/xg7MfMJJpjj2LavKXbWvfwrbhb4=;
        b=J5nqjx3rBWPjlbWBKQIk9GWkEft/jhA9/YW4O+EALEvK54EcFXQhx3JRjj1BGrSbgm
         Fz1DS33f/u2bV7yBovTmyJ983DiSsmHhQLSKgN6qa6R7NoJx1wSL0Zzm6Uva20LNuxH6
         +k8Bq9xFWQ4N4xM/hpnlg5qeILkBXdcV0MxclDZqBrr+2m2qDmgAYewtooxmth3obj5q
         oI06xUIafhhjpl+pBzynGN5Or9OQOng/GFfYEfE458nAMRaX6TwMe75yfX42kfQrxLSy
         5yLsb54+NKz1ZMarH1mL4ocCFZHBnuJRM/v/JnG2LVsP/Vrr06F5E5Or0vqDdzhyIuIE
         EqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757904455; x=1758509255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zL4CkNXz/kx2nDX/xg7MfMJJpjj2LavKXbWvfwrbhb4=;
        b=Bsb5p7k+jYtZDSNKGR16wWa6QUgvW/F0y3ywe71HtaEPpDT8EYRjnB65wAXh3BJgKm
         y9q6D4oRxB0gF0/91YTHS3HodQnp7+ik/0iZxPXHA7eIpZXv8lLc74gfydfle/lo3WAY
         GGGDB0vSmTOVWZ4j1d4KzN9VW/MSK5flozuNjuCXGjtn77sOp2syYHbNvNcE99E5Umgh
         kDaavqCy3Yv4qvZ6vqjVsfPMR7RWuQ4A9fCOT0oeSXg95ndh0OYuKREOdfiVQtI11G5Y
         h2+Hha00ifxZAYKd2EyWu58NiW02u6kvc/Uw/XzkX2OwaO4evjlnFEbXuKHSqshUmbWA
         2AoQ==
X-Gm-Message-State: AOJu0YwjT/6Gb+fcdjStph775rH+ZqSg7BeJNKavqqY/JVs6NASsyPuz
	ft9hiLDOD0h6lO21fuGFr4ykH73N0v50htqKDb3Y5iqqkQSRyz/S4imFl2DJTbsR
X-Gm-Gg: ASbGnctgkGGgEBYe/BYFdcFaUYL/JJODp343DT5dR/fv5yy+ruqO3lTZPFfpY5KncYV
	YYRuMCGAew/4XkAQlMjamOdtYKxPt052Aq58z9aeYJZEUbGQjZ40vrW88mjritWJSjIlbLkEI0p
	eyCD3uX6DpAEQFcemG0sb1yQ1lYxguVJkQ+aR10inFv2NwOoqzzHbNajIL40OOa8FiEwf5AQtIq
	buT2yynUfq2hMV3Yqrp67HWkUV0vnivbAHw/R9nOtU11zw0a5KNLXBX+HYIpNFTBDGcyNCGJSSi
	OMEej/AZfTrKi/BFkDiJ6nvhPyAh4WDUBERYefqehM+Gt4KEh2Dk6+FdYUaK7DP1siSnP267t3K
	I6RwiJnLaGu+Ndb3+BblvGDOJlMENOERWzx91uQM5dHgZIshYc7WEq68=
X-Google-Smtp-Source: AGHT+IEUgivOUMJqwo1vsYtSXOyPEMlcWtcGjr1GD5a/GynHe+pwoNqyExLx+H+e32fNMcAmg969Ag==
X-Received: by 2002:a5d:5f94:0:b0:3d3:1ad0:e8b7 with SMTP id ffacd0b85a97d-3e765780aedmr10145506f8f.12.1757904454923;
        Sun, 14 Sep 2025 19:47:34 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3e7c778f764sm10274767f8f.57.2025.09.14.19.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 19:47:34 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/3] bpf: Enforce RCU protection for KF_RCU_PROTECTED
Date: Mon, 15 Sep 2025 02:47:29 +0000
Message-ID: <20250915024731.1494251-2-memxor@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915024731.1494251-1-memxor@gmail.com>
References: <20250915024731.1494251-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4814; i=memxor@gmail.com; h=from:subject; bh=5FjU7w8tmJr7fekbLIiC56K4sk/Cvk4MkeKEB+LHUEw=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBox34g/VIx34XukDLT7GM7xrAyIq6SesyHbMGGF 94sS4WREB+JAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaMd+IAAKCRBM4MiGSL8R yo0kEACfYdc8pNkCgT8vGPsW9+Z4V5dfQ+kBaj7fnY8kV+LzED1+HtqWuUMMjudqUXpH0MTchnf XSmqGgRYyGswMo9MmGatvVZqEIxiV4kqlLfmYo6Lhht+1WNDmzB2xmCilyWPXb6Iv7Ghp2njFXy OEl2r6FVKs/jUOUIF2FPy6R1lFs0F58VogXsaMei8D2usM6xYQ5xZ5fuLRELkyXMyegAzcieNSO rb8qhoyQbBVd7/xqvm2/HSen+847I0ARIWeWVUNDibNiCPVrL0uCNLqF8iQu7NstsYr9FmdOJG7 Un3uB2BEebO3qW/1FqcWBdOoiCkzDN0hzjtaPw+1/DSTLZcNRmi/DxrMQqQe9vAUeh+KOomMEns 0pITmHurSLgm227Bfz311oZvpeOydm1iq5+F7D1nkGTYIAj6wUalWcaF6EtF2vQAag7Zz1l3Hb7 npVb8JlnhEC0QeslT4G0k3HkU23L5wzk9FD/ak70OQp8bdqMkPfFEnSPtOj5nAO+87oAP+muLCF E0gsCvOJ0sjHzfE4vWdyNs9k2sCkTx7skZX5BXfWHkk/2YHitjAfu884ampP4Ze0sNt9E1S0FjI 22FcqkHu8X5PW8+AOFQHCXT2JXcWQSfQROnOIgrLe931JEN6RzvYbfkr4s+q8qT72Ez4U0Odiz0 Ur2HsBHJJTEGowQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Currently, KF_RCU_PROTECTED only applies to iterator APIs and that too
in a convoluted fashion: the presence of this flag on the kfunc is used
to set MEM_RCU in iterator type, and the lack of RCU protection results
in an error only later, once next() or destroy() methods are invoked on
the iterator. While there is no bug, this is certainly a bit
unintuitive, and makes the enforcement of the flag iterator specific.

In the interest of making this flag useful for other upcoming kfuncs,
e.g. scx_bpf_cpu_curr() [0][1], add enforcement for invoking the kfunc
in an RCU critical section in general.

This would also mean that iterator APIs using KF_RCU_PROTECTED will
error out earlier, instead of throwing an error for lack of RCU CS
protection when next() or destroy() methods are invoked.

  [0]: https://lore.kernel.org/all/20250903212311.369697-3-christian.loehle@arm.com
  [1]: https://lore.kernel.org/all/20250909195709.92669-1-arighi@nvidia.com

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 Documentation/bpf/kfuncs.rst                        | 13 ++++++++++++-
 kernel/bpf/verifier.c                               |  5 +++++
 .../testing/selftests/bpf/progs/cgroup_read_xattr.c |  2 +-
 .../selftests/bpf/progs/iters_task_failure.c        |  4 ++--
 4 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index ae468b781d31..18ba1f7c26b3 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -335,9 +335,20 @@ consider doing refcnt != 0 check, especially when returning a KF_ACQUIRE
 pointer. Note as well that a KF_ACQUIRE kfunc that is KF_RCU should very likely
 also be KF_RET_NULL.
 
+2.4.8 KF_RCU_PROTECTED flag
+---------------------------
+
+The KF_RCU_PROTECTED flag is used to indicate that the kfunc must be invoked in
+an RCU critical section. This is assumed by default in non-sleepable programs,
+and must be explicitly ensured by calling ``bpf_rcu_read_lock`` for sleepable
+ones. The flag is distinct from the ``KF_RCU`` flag, which only ensures that its
+arguments are at least RCU protected pointers. This may transitively imply that
+RCU protection is ensured, but it does not work in cases of kfuncs which require
+RCU protection but do not take RCU protected arguments.
+
 .. _KF_deprecated_flag:
 
-2.4.8 KF_DEPRECATED flag
+2.4.9 KF_DEPRECATED flag
 ------------------------
 
 The KF_DEPRECATED flag is used for kfuncs which are scheduled to be
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 17fe623400a5..aa7c82ab50b9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13916,6 +13916,11 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return -EACCES;
 	}
 
+	if (is_kfunc_rcu_protected(&meta) && !in_rcu_cs(env)) {
+		verbose(env, "kernel func %s requires RCU critical section protection\n", func_name);
+		return -EACCES;
+	}
+
 	/* In case of release function, we get register number of refcounted
 	 * PTR_TO_BTF_ID in bpf_kfunc_arg_meta, do the release now.
 	 */
diff --git a/tools/testing/selftests/bpf/progs/cgroup_read_xattr.c b/tools/testing/selftests/bpf/progs/cgroup_read_xattr.c
index 092db1d0435e..88e13e17ec9e 100644
--- a/tools/testing/selftests/bpf/progs/cgroup_read_xattr.c
+++ b/tools/testing/selftests/bpf/progs/cgroup_read_xattr.c
@@ -73,7 +73,7 @@ int BPF_PROG(use_css_iter_non_sleepable)
 }
 
 SEC("lsm.s/socket_connect")
-__failure __msg("expected an RCU CS")
+__failure __msg("kernel func bpf_iter_css_new requires RCU critical section protection")
 int BPF_PROG(use_css_iter_sleepable_missing_rcu_lock)
 {
 	u64 cgrp_id = bpf_get_current_cgroup_id();
diff --git a/tools/testing/selftests/bpf/progs/iters_task_failure.c b/tools/testing/selftests/bpf/progs/iters_task_failure.c
index 6b1588d70652..fe3663dedbe1 100644
--- a/tools/testing/selftests/bpf/progs/iters_task_failure.c
+++ b/tools/testing/selftests/bpf/progs/iters_task_failure.c
@@ -15,7 +15,7 @@ void bpf_rcu_read_lock(void) __ksym;
 void bpf_rcu_read_unlock(void) __ksym;
 
 SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
-__failure __msg("expected an RCU CS when using bpf_iter_task_next")
+__failure __msg("kernel func bpf_iter_task_new requires RCU critical section protection")
 int BPF_PROG(iter_tasks_without_lock)
 {
 	struct task_struct *pos;
@@ -27,7 +27,7 @@ int BPF_PROG(iter_tasks_without_lock)
 }
 
 SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
-__failure __msg("expected an RCU CS when using bpf_iter_css_next")
+__failure __msg("kernel func bpf_iter_css_new requires RCU critical section protection")
 int BPF_PROG(iter_css_without_lock)
 {
 	u64 cg_id = bpf_get_current_cgroup_id();
-- 
2.51.0


