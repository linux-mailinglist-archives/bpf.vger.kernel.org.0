Return-Path: <bpf+bounces-57071-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F50CAA51F7
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 18:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 132B51BA5305
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 16:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BC026560A;
	Wed, 30 Apr 2025 16:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="otrJNo1A"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94E4264A95
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 16:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746031635; cv=none; b=OA3M+nuZekdCb/7klanUVSx2YUTjogNI/1BaLqkVjRWBgqdBgSUOGpR3TPjvqG98HutcjDb63TRZPsJmOZmsXKyMqovbfSfrZ30Awc7p96a6I9s3QKp2JUvgVmesr9spdlPcwy9OJfqkDWGMBy3xDZpM3oQ7Rv6BYqi8jB8UUH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746031635; c=relaxed/simple;
	bh=q9ytZ2bqnS4AW5iOsrYAArh8ag5ZF0zJhleYllk09Tw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P4FFQ1BZie3zDrxDZ1R8LO/bjN5OwkTECDgDnUGTaPnplVdRK9xL9l9NkCd0fEdn4Br3uBIDppLomcdLHQjGdNue2NiIuhkgy/fNyB/mNTzbOIMCbWw+GVam4uZX08r0NAatuLH3TrbksGMRxio5V4H06ERDAtjDtluCFkSPceA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=otrJNo1A; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746031631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DZoAG17QbBV/4PAv7+P9YXWHmX6KfllOZqrH5JYkMPo=;
	b=otrJNo1AcYDrI0/AhSwcB4K20up9Ma9jsPFVr8QgJDLYZPBHJMsocjpyJu5pYC7+5iAh2l
	MowTfTwI3XJeWRSC5LtPu6KtW/kU2TffsYPra/INRbRQ7eplhEc6R82A9VqF02uWb1u0Bq
	KKgT4Yctyk6VaYze8jIb1R8QjDhsSco=
From: Tao Chen <chen.dylane@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	alan.maguire@oracle.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [RFC PATCH bpf-next 2/2] bpf: Get fentry func addr from user when BTF info invalid
Date: Thu,  1 May 2025 00:46:08 +0800
Message-Id: <20250430164608.3790552-3-chen.dylane@linux.dev>
In-Reply-To: <20250430164608.3790552-1-chen.dylane@linux.dev>
References: <20250430164608.3790552-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

If kernel function optimized by the compiler, the function name in
kallsyms will have suffix like ".isra.0" or others. And fentry uses
function name from BTF to find the function address in kallsyms, in this
situation, it will fail due to the inconsistency of function names.
If so, try to use the function address passed from the user.

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 include/linux/bpf.h      | 1 +
 include/uapi/linux/bpf.h | 1 +
 kernel/bpf/syscall.c     | 1 +
 kernel/bpf/verifier.c    | 9 +++++++++
 4 files changed, 12 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3f0cc89c06..fd53d1817f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1626,6 +1626,7 @@ struct bpf_prog_aux {
 		struct work_struct work;
 		struct rcu_head	rcu;
 	};
+	u64 fentry_func;
 };
 
 struct bpf_prog {
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 07ee73cdf9..7016e47a70 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1577,6 +1577,7 @@ union bpf_attr {
 		 * If provided, prog_flags should have BPF_F_TOKEN_FD flag set.
 		 */
 		__s32		prog_token_fd;
+		__aligned_u64	fentry_func;
 		/* The fd_array_cnt can be used to pass the length of the
 		 * fd_array array. In this case all the [map] file descriptors
 		 * passed in this array will be bound to the program, even if
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 9794446bc8..6c1e3572cc 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2892,6 +2892,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	prog->sleepable = !!(attr->prog_flags & BPF_F_SLEEPABLE);
 	prog->aux->attach_btf = attach_btf;
 	prog->aux->attach_btf_id = attr->attach_btf_id;
+	prog->aux->fentry_func = attr->fentry_func;
 	prog->aux->dst_prog = dst_prog;
 	prog->aux->dev_bound = !!attr->prog_ifindex;
 	prog->aux->xdp_has_frags = attr->prog_flags & BPF_F_XDP_HAS_FRAGS;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 54c6953a8b..507c281ddc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23304,6 +23304,15 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			} else {
 				addr = kallsyms_lookup_name(tname);
 			}
+
+			if (!addr && (prog->expected_attach_type == BPF_TRACE_FENTRY ||
+					prog->expected_attach_type == BPF_TRACE_FEXIT)) {
+				fname = kallsyms_lookup((unsigned long)prog->aux->fentry_func,
+							NULL, NULL, NULL, trace_symbol);
+				if (fname)
+					addr = (long)prog->aux->fentry_func;
+			}
+
 			if (!addr) {
 				module_put(mod);
 				bpf_log(log,
-- 
2.43.0


