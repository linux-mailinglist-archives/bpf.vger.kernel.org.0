Return-Path: <bpf+bounces-1036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C56370CB2B
	for <lists+bpf@lfdr.de>; Mon, 22 May 2023 22:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36790280A6A
	for <lists+bpf@lfdr.de>; Mon, 22 May 2023 20:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB3F171AE;
	Mon, 22 May 2023 20:34:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18089154AF
	for <bpf@vger.kernel.org>; Mon, 22 May 2023 20:34:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC11C433EF;
	Mon, 22 May 2023 20:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684787669;
	bh=wU2N1BOhyNmMdvHXU/2VocFu1lHdohwPll/T20B+ryE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bvAxYlu5Q0RwXXod4VhvsywM0NXgCR44VayRB0M1gpt3A6LERtbk3mFI5hhO3w5PU
	 flixUhFphzdspyyEVMn0I6QHJ696bgaToVc3xyjcC4kmOK9yvhx3PqOBOWA2D2aFkF
	 8ytcYLfMLqqvfYUe4OuFiCPd4TynSPkMxnhswgkE7/niNtDl6mjYCUg7Tp5pLMp9wx
	 UR9zQpkB09m2STIPWImCiraooij2D52CkbHBJKcF5Wq/XBD+Bzjk1kgP+fFDtHXApH
	 7dD5myzKXsO7i9upbNvWN9nIuc1lzWAAriVD10AT8/69YaNunqgauei0EcVnj1MFuc
	 sfIWwB+xT/mNQ==
From: Jiri Olsa <jolsa@kernel.org>
To: stable@vger.kernel.org
Cc: Andrii Nakryiko <andriin@fb.com>,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Tsahee Zidenberg <tsahee@annapurnalabs.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Mah=C3=A9=20Tardy?= <mahe.tardy@isovalent.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH stable 5.4 2/8] bpf: Add probe_read_{user, kernel} and probe_read_{user, kernel}_str helpers
Date: Mon, 22 May 2023 22:33:46 +0200
Message-Id: <20230522203352.738576-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522203352.738576-1-jolsa@kernel.org>
References: <20230522203352.738576-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Borkmann <daniel@iogearbox.net>

commit 6ae08ae3dea2cfa03dd3665a3c8475c2d429ef47 upstream.

[Taking only hunks that are related to probe_read and probe_read_str
helpers, which we want to fix. Taking this patch/hunks as a base
for following changes and ommiting the new helpers and uapi changes.]

The current bpf_probe_read() and bpf_probe_read_str() helpers are broken
in that they assume they can be used for probing memory access for kernel
space addresses /as well as/ user space addresses.

However, plain use of probe_kernel_read() for both cases will attempt to
always access kernel space address space given access is performed under
KERNEL_DS and some archs in-fact have overlapping address spaces where a
kernel pointer and user pointer would have the /same/ address value and
therefore accessing application memory via bpf_probe_read{,_str}() would
read garbage values.

Lets fix BPF side by making use of recently added 3d7081822f7f ("uaccess:
Add non-pagefault user-space read functions"). Unfortunately, the only way
to fix this status quo is to add dedicated bpf_probe_read_{user,kernel}()
and bpf_probe_read_{user,kernel}_str() helpers. The bpf_probe_read{,_str}()
helpers are kept as-is to retain their current behavior.

The two *_user() variants attempt the access always under USER_DS set, the
two *_kernel() variants will -EFAULT when accessing user memory if the
underlying architecture has non-overlapping address ranges, also avoiding
throwing the kernel warning via 00c42373d397 ("x86-64: add warning for
non-canonical user access address dereferences").

Fixes: a5e8c07059d0 ("bpf: add bpf_probe_read_str helper")
Fixes: 2541517c32be ("tracing, perf: Implement BPF programs attached to kprobes")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Link: https://lore.kernel.org/bpf/796ee46e948bc808d54891a1108435f8652c6ca4.1572649915.git.daniel@iogearbox.net
---
 kernel/trace/bpf_trace.c | 103 ++++++++++++++++++++++-----------------
 1 file changed, 57 insertions(+), 46 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 1e1345cd21b4..9ac27d48cc8e 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -138,24 +138,70 @@ static const struct bpf_func_proto bpf_override_return_proto = {
 };
 #endif
 
-BPF_CALL_3(bpf_probe_read, void *, dst, u32, size, const void *, unsafe_ptr)
+static __always_inline int
+bpf_probe_read_kernel_common(void *dst, u32 size, const void *unsafe_ptr,
+			     const bool compat)
 {
-	int ret;
+	int ret = security_locked_down(LOCKDOWN_BPF_READ);
 
-	ret = security_locked_down(LOCKDOWN_BPF_READ);
-	if (ret < 0)
+	if (unlikely(ret < 0))
 		goto out;
-
-	ret = probe_kernel_read(dst, unsafe_ptr, size);
+	ret = compat ? probe_kernel_read(dst, unsafe_ptr, size) :
+	      probe_kernel_read_strict(dst, unsafe_ptr, size);
 	if (unlikely(ret < 0))
 out:
 		memset(dst, 0, size);
+	return ret;
+}
+
+BPF_CALL_3(bpf_probe_read_compat, void *, dst, u32, size,
+	   const void *, unsafe_ptr)
+{
+	return bpf_probe_read_kernel_common(dst, size, unsafe_ptr, true);
+}
+
+static const struct bpf_func_proto bpf_probe_read_compat_proto = {
+	.func		= bpf_probe_read_compat,
+	.gpl_only	= true,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_UNINIT_MEM,
+	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg3_type	= ARG_ANYTHING,
+};
 
+static __always_inline int
+bpf_probe_read_kernel_str_common(void *dst, u32 size, const void *unsafe_ptr,
+				 const bool compat)
+{
+	int ret = security_locked_down(LOCKDOWN_BPF_READ);
+
+	if (unlikely(ret < 0))
+		goto out;
+	/*
+	 * The strncpy_from_unsafe_*() call will likely not fill the entire
+	 * buffer, but that's okay in this circumstance as we're probing
+	 * arbitrary memory anyway similar to bpf_probe_read_*() and might
+	 * as well probe the stack. Thus, memory is explicitly cleared
+	 * only in error case, so that improper users ignoring return
+	 * code altogether don't copy garbage; otherwise length of string
+	 * is returned that can be used for bpf_perf_event_output() et al.
+	 */
+	ret = compat ? strncpy_from_unsafe(dst, unsafe_ptr, size) :
+	      strncpy_from_unsafe_strict(dst, unsafe_ptr, size);
+	if (unlikely(ret < 0))
+out:
+		memset(dst, 0, size);
 	return ret;
 }
 
-static const struct bpf_func_proto bpf_probe_read_proto = {
-	.func		= bpf_probe_read,
+BPF_CALL_3(bpf_probe_read_compat_str, void *, dst, u32, size,
+	   const void *, unsafe_ptr)
+{
+	return bpf_probe_read_kernel_str_common(dst, size, unsafe_ptr, true);
+}
+
+static const struct bpf_func_proto bpf_probe_read_compat_str_proto = {
+	.func		= bpf_probe_read_compat_str,
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_UNINIT_MEM,
@@ -583,41 +629,6 @@ static const struct bpf_func_proto bpf_current_task_under_cgroup_proto = {
 	.arg2_type      = ARG_ANYTHING,
 };
 
-BPF_CALL_3(bpf_probe_read_str, void *, dst, u32, size,
-	   const void *, unsafe_ptr)
-{
-	int ret;
-
-	ret = security_locked_down(LOCKDOWN_BPF_READ);
-	if (ret < 0)
-		goto out;
-
-	/*
-	 * The strncpy_from_unsafe() call will likely not fill the entire
-	 * buffer, but that's okay in this circumstance as we're probing
-	 * arbitrary memory anyway similar to bpf_probe_read() and might
-	 * as well probe the stack. Thus, memory is explicitly cleared
-	 * only in error case, so that improper users ignoring return
-	 * code altogether don't copy garbage; otherwise length of string
-	 * is returned that can be used for bpf_perf_event_output() et al.
-	 */
-	ret = strncpy_from_unsafe(dst, unsafe_ptr, size);
-	if (unlikely(ret < 0))
-out:
-		memset(dst, 0, size);
-
-	return ret;
-}
-
-static const struct bpf_func_proto bpf_probe_read_str_proto = {
-	.func		= bpf_probe_read_str,
-	.gpl_only	= true,
-	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_PTR_TO_UNINIT_MEM,
-	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
-	.arg3_type	= ARG_ANYTHING,
-};
-
 struct send_signal_irq_work {
 	struct irq_work irq_work;
 	struct task_struct *task;
@@ -700,8 +711,6 @@ tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_map_pop_elem_proto;
 	case BPF_FUNC_map_peek_elem:
 		return &bpf_map_peek_elem_proto;
-	case BPF_FUNC_probe_read:
-		return &bpf_probe_read_proto;
 	case BPF_FUNC_ktime_get_ns:
 		return &bpf_ktime_get_ns_proto;
 	case BPF_FUNC_tail_call:
@@ -728,8 +737,10 @@ tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_current_task_under_cgroup_proto;
 	case BPF_FUNC_get_prandom_u32:
 		return &bpf_get_prandom_u32_proto;
+	case BPF_FUNC_probe_read:
+		return &bpf_probe_read_compat_proto;
 	case BPF_FUNC_probe_read_str:
-		return &bpf_probe_read_str_proto;
+		return &bpf_probe_read_compat_str_proto;
 #ifdef CONFIG_CGROUPS
 	case BPF_FUNC_get_current_cgroup_id:
 		return &bpf_get_current_cgroup_id_proto;
-- 
2.40.1


