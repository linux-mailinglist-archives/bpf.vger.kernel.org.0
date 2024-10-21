Return-Path: <bpf+bounces-42650-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7EE9A6E1A
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 17:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A01D31F242A7
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 15:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5237E13A89A;
	Mon, 21 Oct 2024 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="rQ2rFGAw"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5315A137742
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 15:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729524494; cv=none; b=E875pvLPu2JHwGhBgGg20Bv1CmsU0napiMY19h4u24rkCvFHXD6xd/JHEk2csibJPteZVzI+OI/5fPp518CD5Ufc926ZYDrDigTEoyYYh7YzhKJoWdSSKD60jQWFESyK0U7xgJmpV2svWW0zPVb4zuQPrbkuiH3TH0SUYV/0oUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729524494; c=relaxed/simple;
	bh=jV9Hz2B0iJupqkwv44O5pCLBtrmNrri/Ezmc44MN8rg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UxKhazft1GSnI4ugcj+03WCUCUGpqwU/zIw9u2oHLHC14rLM0NbWXdW5wJhAHuodSVTqW2uJeGeXJFoQFQZklFpmTo0BR1PAGvEN3GV/XKXS/2JlB2nDC8vFdx5Q+pJ1OqTxklPlFGTT2f62pPvcWHUbw1c8HNoFt+KBlKRPCoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=rQ2rFGAw; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=5hhkSCgE4/LyNAQwJu8XRllW706MD/kFZb6EStfO8ME=; b=rQ2rFGAwZnrBJhMdIaQ0e9he+c
	/R/0gsAtgRjUFntM1pudLA2rtiKtMiP/YpV6FPKcTve8CiRwa5hX7Zue+UkKOS3vd6cBFVE/2HuAn
	5wCaNeY3XRW+6fGn6kDkNFNB7IZ4cmA0uLIkXjGymHZotVXB6qtyqjxXrJVDFCWt77hpLutQdBzci
	ywlgjkyPpC9cqXlujwLoTj1ktVuSDkXwbijMHPpLM2kPCC22A9t1AsD8WqJgViyKfI2nE2z+5w/h8
	f8uJLOnxR8cLnmpvJkxzMEf8QUEOiIL86clHteWXq0nMe5xBXei8V/g2G7FJk9bF38/hITcWlo52B
	eLXQ7MIw==;
Received: from 43.248.197.178.dynamic.cust.swisscom.net ([178.197.248.43] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1t2uKI-000Myf-2U; Mon, 21 Oct 2024 17:28:10 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: andrii@kernel.org,
	kongln9170@gmail.com,
	memxor@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf 1/5] bpf: Add MEM_WRITE attribute
Date: Mon, 21 Oct 2024 17:28:05 +0200
Message-Id: <20241021152809.33343-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27434/Mon Oct 21 10:49:31 2024)

Add a MEM_WRITE attribute for BPF helper functions which can be used in
bpf_func_proto to annotate an argument type in order to let the verifier
know that the helper writes into the memory passed as an argument. In
the past MEM_UNINIT has been (ab)used for this function, but the latter
merely tells the verifier that the passed memory can be uninitialized.

There have been bugs with overloading the latter but aside from that
there are also cases where the passed memory is read + written which
currently cannot be expressed, see also 4b3786a6c539 ("bpf: Zero former
ARG_PTR_TO_{LONG,INT} args in case of error").

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 include/linux/bpf.h      | 14 +++++++++++---
 kernel/bpf/helpers.c     | 10 +++++-----
 kernel/bpf/ringbuf.c     |  2 +-
 kernel/bpf/syscall.c     |  2 +-
 kernel/trace/bpf_trace.c |  4 ++--
 net/core/filter.c        |  4 ++--
 6 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 19d8ca8ac960..bdadb0bb6cec 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -635,6 +635,7 @@ enum bpf_type_flag {
 	 */
 	PTR_UNTRUSTED		= BIT(6 + BPF_BASE_TYPE_BITS),
 
+	/* MEM can be uninitialized. */
 	MEM_UNINIT		= BIT(7 + BPF_BASE_TYPE_BITS),
 
 	/* DYNPTR points to memory local to the bpf program. */
@@ -700,6 +701,13 @@ enum bpf_type_flag {
 	 */
 	MEM_ALIGNED		= BIT(17 + BPF_BASE_TYPE_BITS),
 
+	/* MEM is being written to, often combined with MEM_UNINIT. Non-presence
+	 * of MEM_WRITE means that MEM is only being read. MEM_WRITE without the
+	 * MEM_UNINIT means that memory needs to be initialized since it is also
+	 * read.
+	 */
+	MEM_WRITE		= BIT(18 + BPF_BASE_TYPE_BITS),
+
 	__BPF_TYPE_FLAG_MAX,
 	__BPF_TYPE_LAST_FLAG	= __BPF_TYPE_FLAG_MAX - 1,
 };
@@ -758,10 +766,10 @@ enum bpf_arg_type {
 	ARG_PTR_TO_SOCKET_OR_NULL	= PTR_MAYBE_NULL | ARG_PTR_TO_SOCKET,
 	ARG_PTR_TO_STACK_OR_NULL	= PTR_MAYBE_NULL | ARG_PTR_TO_STACK,
 	ARG_PTR_TO_BTF_ID_OR_NULL	= PTR_MAYBE_NULL | ARG_PTR_TO_BTF_ID,
-	/* pointer to memory does not need to be initialized, helper function must fill
-	 * all bytes or clear them in error case.
+	/* Pointer to memory does not need to be initialized, since helper function
+	 * fills all bytes or clears them in error case.
 	 */
-	ARG_PTR_TO_UNINIT_MEM		= MEM_UNINIT | ARG_PTR_TO_MEM,
+	ARG_PTR_TO_UNINIT_MEM		= MEM_UNINIT | MEM_WRITE | ARG_PTR_TO_MEM,
 	/* Pointer to valid memory of size known at compile time. */
 	ARG_PTR_TO_FIXED_SIZE_MEM	= MEM_FIXED_SIZE | ARG_PTR_TO_MEM,
 
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 1a43d06eab28..ca3f0a2e5ed5 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -111,7 +111,7 @@ const struct bpf_func_proto bpf_map_pop_elem_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_CONST_MAP_PTR,
-	.arg2_type	= ARG_PTR_TO_MAP_VALUE | MEM_UNINIT,
+	.arg2_type	= ARG_PTR_TO_MAP_VALUE | MEM_UNINIT | MEM_WRITE,
 };
 
 BPF_CALL_2(bpf_map_peek_elem, struct bpf_map *, map, void *, value)
@@ -124,7 +124,7 @@ const struct bpf_func_proto bpf_map_peek_elem_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_CONST_MAP_PTR,
-	.arg2_type	= ARG_PTR_TO_MAP_VALUE | MEM_UNINIT,
+	.arg2_type	= ARG_PTR_TO_MAP_VALUE | MEM_UNINIT | MEM_WRITE,
 };
 
 BPF_CALL_3(bpf_map_lookup_percpu_elem, struct bpf_map *, map, void *, key, u32, cpu)
@@ -538,7 +538,7 @@ const struct bpf_func_proto bpf_strtol_proto = {
 	.arg1_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg2_type	= ARG_CONST_SIZE,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
+	.arg4_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_WRITE | MEM_ALIGNED,
 	.arg4_size	= sizeof(s64),
 };
 
@@ -566,7 +566,7 @@ const struct bpf_func_proto bpf_strtoul_proto = {
 	.arg1_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg2_type	= ARG_CONST_SIZE,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
+	.arg4_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_WRITE | MEM_ALIGNED,
 	.arg4_size	= sizeof(u64),
 };
 
@@ -1742,7 +1742,7 @@ static const struct bpf_func_proto bpf_dynptr_from_mem_proto = {
 	.arg1_type	= ARG_PTR_TO_UNINIT_MEM,
 	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL | MEM_UNINIT,
+	.arg4_type	= ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL | MEM_UNINIT | MEM_WRITE,
 };
 
 BPF_CALL_5(bpf_dynptr_read, void *, dst, u32, len, const struct bpf_dynptr_kern *, src,
diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index de3b681d1d13..e1cfe890e0be 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -632,7 +632,7 @@ const struct bpf_func_proto bpf_ringbuf_reserve_dynptr_proto = {
 	.arg1_type	= ARG_CONST_MAP_PTR,
 	.arg2_type	= ARG_ANYTHING,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_RINGBUF | MEM_UNINIT,
+	.arg4_type	= ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_RINGBUF | MEM_UNINIT | MEM_WRITE,
 };
 
 BPF_CALL_2(bpf_ringbuf_submit_dynptr, struct bpf_dynptr_kern *, ptr, u64, flags)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a8f1808a1ca5..161ac70e01d2 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5877,7 +5877,7 @@ static const struct bpf_func_proto bpf_kallsyms_lookup_name_proto = {
 	.arg1_type	= ARG_PTR_TO_MEM,
 	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
+	.arg4_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_WRITE | MEM_ALIGNED,
 	.arg4_size	= sizeof(u64),
 };
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index a582cd25ca87..ef954abe7d74 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1202,7 +1202,7 @@ static const struct bpf_func_proto bpf_get_func_arg_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
+	.arg3_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_WRITE | MEM_ALIGNED,
 	.arg3_size	= sizeof(u64),
 };
 
@@ -1219,7 +1219,7 @@ static const struct bpf_func_proto bpf_get_func_ret_proto = {
 	.func		= get_func_ret,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
+	.arg2_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_WRITE | MEM_ALIGNED,
 	.arg2_size	= sizeof(u64),
 };
 
diff --git a/net/core/filter.c b/net/core/filter.c
index 4e3f42cc6611..6be0c0b86049 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6368,7 +6368,7 @@ static const struct bpf_func_proto bpf_skb_check_mtu_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type      = ARG_PTR_TO_CTX,
 	.arg2_type      = ARG_ANYTHING,
-	.arg3_type      = ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
+	.arg3_type      = ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_WRITE | MEM_ALIGNED,
 	.arg3_size	= sizeof(u32),
 	.arg4_type      = ARG_ANYTHING,
 	.arg5_type      = ARG_ANYTHING,
@@ -6380,7 +6380,7 @@ static const struct bpf_func_proto bpf_xdp_check_mtu_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type      = ARG_PTR_TO_CTX,
 	.arg2_type      = ARG_ANYTHING,
-	.arg3_type      = ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
+	.arg3_type      = ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_WRITE | MEM_ALIGNED,
 	.arg3_size	= sizeof(u32),
 	.arg4_type      = ARG_ANYTHING,
 	.arg5_type      = ARG_ANYTHING,
-- 
2.43.0


