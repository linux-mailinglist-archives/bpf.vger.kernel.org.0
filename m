Return-Path: <bpf+bounces-50575-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D539A29DE0
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 01:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C2961888B53
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 00:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B77EB672;
	Thu,  6 Feb 2025 00:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oCuQbdrW"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F82423BB
	for <bpf@vger.kernel.org>; Thu,  6 Feb 2025 00:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738801923; cv=none; b=KzlC2dZEgSIQbJgsMWQ/uuidWoEJpTO3ctuGAv0BpwwRRHe8+04AY4w+5jC9PYh7d6ZHm1+6eb3rbAqryhmiZQnhgDIWbyNGJovO9CgsNcm2GxyMWTYiXT2dZBWmL75nFPME2klrPxlJlwHH1jN8XZcMOyZoFG5V5u4LtMevAow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738801923; c=relaxed/simple;
	bh=NuUY70wR2HMkTqbG89GLyyhKbNdpz9JOsnldCxChWMY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m8mYw1lF+O4ygq/nHhTgsHid5bJr1LohwRgQKPtGLvFNOCJZIQ7LU7vkxhEbryYtWQT7irLjCsPYlSLRo867KCXl+IWLq/ik6U5uaL6IMMt308lIsn8hf+r5Q13qtFHlsc8L18MQwmJRLqKrpgrCSUrRcwI2E0tmG/1iO4FAWP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oCuQbdrW; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738801912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eYASM34rgz8Ozo3B23pYeJnsJ1kpdIiwdTDByJl0VeE=;
	b=oCuQbdrWa5poZ8PGwcA7F6xoYNMVCSRWO0MYCKqj70r2KKk53iDA6KSGtXESxJJuy9y71X
	s668m+rIUZKHlKQyq1D4t3vrwQWlpKNzHxGmwNKJVAUrqe8yBhj+6oGDrqNHx2yy1hd6RZ
	E31F5ud3eP06A9WAzkePLO5IGIAnYxA=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	mykolal@fb.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next] bpf: define KF_ARENA_* flags for bpf_arena kfuncs
Date: Wed,  5 Feb 2025 16:31:48 -0800
Message-ID: <20250206003148.2308659-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

bpf_arena_alloc_pages() and bpf_arena_free_pages() work with the
bpf_arena pointers [1], which is indicated by the __arena macro in the
kernel source code:

    #define __arena __attribute__((address_space(1)))

However currently this information is absent from the debug data in
the vmlinux binary. As a consequence, bpf_arena_* kfuncs declarations
in vmlinux.h (produced by bpftool) do not match prototypes expected by
the BPF programs attempting to use these functions.

Introduce a set of kfunc flags to mark relevant types as bpf_arena
pointers. The flags then can be detected by pahole when generating BTF
from vmlinux's DWARF, allowing it to emit corresponding BTF type tags
for the marked kfuncs.

With recently proposed BTF extension [2], these type tags will be
processed by bpftool when dumping vmlinux.h, and corresponding
compiler attributes will be added to the declarations.

[1] https://lwn.net/Articles/961594/
[2] https://lore.kernel.org/bpf/20250130201239.1429648-1-ihor.solodrai@linux.dev/

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 include/linux/btf.h | 3 +++
 kernel/bpf/arena.c  | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 2a08a2b55592..ebc0c0c9b944 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -76,6 +76,9 @@
 #define KF_ITER_DESTROY (1 << 10) /* kfunc implements BPF iter destructor */
 #define KF_RCU_PROTECTED (1 << 11) /* kfunc should be protected by rcu cs when they are invoked */
 #define KF_FASTCALL     (1 << 12) /* kfunc supports bpf_fastcall protocol */
+#define KF_ARENA_RET    (1 << 13) /* kfunc returns an arena pointer */
+#define KF_ARENA_ARG1   (1 << 14) /* kfunc takes an arena pointer as its first argument */
+#define KF_ARENA_ARG2   (1 << 15) /* kfunc takes an arena pointer as its second argument */
 
 /*
  * Tag marking a kernel function as a kfunc. This is meant to minimize the
diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 870aeb51d70a..0975d7f22544 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -577,8 +577,8 @@ __bpf_kfunc void bpf_arena_free_pages(void *p__map, void *ptr__ign, u32 page_cnt
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(arena_kfuncs)
-BTF_ID_FLAGS(func, bpf_arena_alloc_pages, KF_TRUSTED_ARGS | KF_SLEEPABLE)
-BTF_ID_FLAGS(func, bpf_arena_free_pages, KF_TRUSTED_ARGS | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_arena_alloc_pages, KF_TRUSTED_ARGS | KF_SLEEPABLE | KF_ARENA_RET | KF_ARENA_ARG2)
+BTF_ID_FLAGS(func, bpf_arena_free_pages, KF_TRUSTED_ARGS | KF_SLEEPABLE | KF_ARENA_ARG2)
 BTF_KFUNCS_END(arena_kfuncs)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
-- 
2.48.1


