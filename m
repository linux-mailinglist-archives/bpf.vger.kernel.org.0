Return-Path: <bpf+bounces-37994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F2F95D935
	for <lists+bpf@lfdr.de>; Sat, 24 Aug 2024 00:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDD3A2847AA
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 22:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5526F1C8FBB;
	Fri, 23 Aug 2024 22:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="gtC86pVn"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FBC18661A
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 22:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724451652; cv=none; b=kZ46k4O6wkJeslevD1+QUBR0oTtLjtWaWEVPip8JD30EdgWS8sV2UZpTLEQZDxQb8QXhfj6rchlGgTGRHznUSEMHdkyaPOS5blsNNEVGebGYyeKxyPviDwmLSzaCvGwMGkkWnWUeCiltPfrtkXpMFwUxxoumdn2gs2/m/kHK+yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724451652; c=relaxed/simple;
	bh=I0AHQmtu1F98zoUHTpEp0EuFHgd26Lw+GozzVqCYMCM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lTN8I1Gfox20SixjHGCusb567j8L+E0agk+LidupY/am5FhUGY1RFD8g1SrxpzbguDy0PhpC209FaZIAetm4OlQEIm8KvBCq4+LSEY1Dsf/QZco990YdZEVgilGsU94cGJNTiu75HITIqBqbwlyden/SnFdvcaVYyFcDnxqQyig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=gtC86pVn; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=+8yRMhoousb1OYEQ09N9+qsc3KTlRjIGMm/BHYoKyok=; b=gtC86pVn+//XH4+N3xqXp97X/P
	mBnv9c/YwzoR4rM+0qjnWqocxEvZl2zxO97NOcNgXk+DLaUW/eIh75v3EteYzYgJPBQ8hlx+Y82Bz
	26fAuvPO7WfUaRu/Cm5Kd8H/3K0EA65IKftiCDsaoEdycmXdLBgszR2Cwhn79OHtyqlqOg+DCy3nY
	peVyqTWyWFvx0oXs73Vz8DoYPJR2QAnuDkCIXn37p3xe3T0eM0jNme9x37Ho3B+0uFEIoxk8guPFy
	Jak0YWPdR6NuwQ4xh2VCH2et77PUIDdxeco57xYnhgnh4XK1V+5AO7/70evBb0KYpWCoEY3U9XLbK
	CcipmK1w==;
Received: from 23.248.197.178.dynamic.cust.swisscom.net ([178.197.248.23] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1shceE-000FqE-Hc; Sat, 24 Aug 2024 00:20:46 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: kongln9170@gmail.com,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf 1/4] bpf: Fix helper writes to read-only maps
Date: Sat, 24 Aug 2024 00:20:30 +0200
Message-Id: <20240823222033.31006-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27376/Fri Aug 23 10:47:45 2024)

Lonial found an issue that despite user- and BPF-side frozen BPF map
(like in case of .rodata), it was still possible to write into it from
a BPF program side through specific helpers having ARG_PTR_TO_{LONG,INT}
as arguments.

In check_func_arg() when the argument is as mentioned, the meta->raw_mode
is never set. Later, check_helper_mem_access(), under the case of
PTR_TO_MAP_VALUE as register base type, it assumes BPF_READ for the
subsequent call to check_map_access_type() and given the BPF map is
read-only it succeeds.

The helpers really need to be annotated as ARG_PTR_TO_{LONG,INT} | MEM_UNINIT
when results are written into them as opposed to read out of them. The
latter indicates that it's okay to pass a pointer to uninitialized memory
as the memory is written to anyway.

Fixes: 57c3bb725a3d ("bpf: Introduce ARG_PTR_TO_{INT,LONG} arg types")
Reported-by: Lonial Con <kongln9170@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/helpers.c     | 4 ++--
 kernel/bpf/syscall.c     | 2 +-
 kernel/bpf/verifier.c    | 3 ++-
 kernel/trace/bpf_trace.c | 4 ++--
 net/core/filter.c        | 4 ++--
 5 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b5f0adae8293..356a58aeb79b 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -538,7 +538,7 @@ const struct bpf_func_proto bpf_strtol_proto = {
 	.arg1_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg2_type	= ARG_CONST_SIZE,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_LONG,
+	.arg4_type	= ARG_PTR_TO_LONG | MEM_UNINIT,
 };
 
 BPF_CALL_4(bpf_strtoul, const char *, buf, size_t, buf_len, u64, flags,
@@ -566,7 +566,7 @@ const struct bpf_func_proto bpf_strtoul_proto = {
 	.arg1_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg2_type	= ARG_CONST_SIZE,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_LONG,
+	.arg4_type	= ARG_PTR_TO_LONG | MEM_UNINIT,
 };
 
 BPF_CALL_3(bpf_strncmp, const char *, s1, u32, s1_sz, const char *, s2)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index bf6c5f685ea2..6d5942a6f41f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5952,7 +5952,7 @@ static const struct bpf_func_proto bpf_kallsyms_lookup_name_proto = {
 	.arg1_type	= ARG_PTR_TO_MEM,
 	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_LONG,
+	.arg4_type	= ARG_PTR_TO_LONG | MEM_UNINIT,
 };
 
 static const struct bpf_func_proto *
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d8520095ca03..70b0474e03a6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8877,8 +8877,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	case ARG_PTR_TO_INT:
 	case ARG_PTR_TO_LONG:
 	{
-		int size = int_ptr_type_to_size(arg_type);
+		int size = int_ptr_type_to_size(base_type(arg_type));
 
+		meta->raw_mode = arg_type & MEM_UNINIT;
 		err = check_helper_mem_access(env, regno, size, false, meta);
 		if (err)
 			return err;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index cd098846e251..95c3409ff374 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1226,7 +1226,7 @@ static const struct bpf_func_proto bpf_get_func_arg_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_PTR_TO_LONG,
+	.arg3_type	= ARG_PTR_TO_LONG | MEM_UNINIT,
 };
 
 BPF_CALL_2(get_func_ret, void *, ctx, u64 *, value)
@@ -1242,7 +1242,7 @@ static const struct bpf_func_proto bpf_get_func_ret_proto = {
 	.func		= get_func_ret,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_LONG,
+	.arg2_type	= ARG_PTR_TO_LONG | MEM_UNINIT,
 };
 
 BPF_CALL_1(get_func_arg_cnt, void *, ctx)
diff --git a/net/core/filter.c b/net/core/filter.c
index f3c72cf86099..2ff210cb068c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6346,7 +6346,7 @@ static const struct bpf_func_proto bpf_skb_check_mtu_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type      = ARG_PTR_TO_CTX,
 	.arg2_type      = ARG_ANYTHING,
-	.arg3_type      = ARG_PTR_TO_INT,
+	.arg3_type      = ARG_PTR_TO_INT | MEM_UNINIT,
 	.arg4_type      = ARG_ANYTHING,
 	.arg5_type      = ARG_ANYTHING,
 };
@@ -6357,7 +6357,7 @@ static const struct bpf_func_proto bpf_xdp_check_mtu_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type      = ARG_PTR_TO_CTX,
 	.arg2_type      = ARG_ANYTHING,
-	.arg3_type      = ARG_PTR_TO_INT,
+	.arg3_type      = ARG_PTR_TO_INT | MEM_UNINIT,
 	.arg4_type      = ARG_ANYTHING,
 	.arg5_type      = ARG_ANYTHING,
 };
-- 
2.43.0


