Return-Path: <bpf+bounces-39854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 778389788C2
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 21:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F90E1F27277
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 19:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AAB14EC60;
	Fri, 13 Sep 2024 19:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="pZZt8veJ"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C881465BB
	for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 19:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726255089; cv=none; b=uVKYfhm65Deracfvm5yL5DnTfJ/ts2ouy8AQPxdj+sLtBniU6bemI2Iw6wGTL5fsRiOzhgDGLRefv5yXaSqLmWnsqiJJngQNBE3qdPSTdwAy74dwlI5MBmAUZA0dKRJrmtbCSSjEo9m/SHUF+P6/n1EDM4VMJuCpPTkooDmZqkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726255089; c=relaxed/simple;
	bh=tqVhCuKttfHGe1D8ATqnRxHcdKZ0g7rVW73pyF+nZmg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t7lEPym8H8Kz865P7Zm0nS0a8FL1kf0IHwAoq9mgvPIOR/jpuU1nkFAmTO9svtkZrC1P4TFzRVpBGYN919KjbCv3pkJzOQoMOkdXXOXloQt43M1RWuIC3Xi+Ip0CtPTrKF15XZqXSyaNQxXQS3LWjK4Rkashmu/JtOOoHRHYZWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=pZZt8veJ; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=AAtj9JLGDxtpcxaeY/2V71wLfkpscKXXsBJTDdgmJaw=; b=pZZt8veJbW5GSWcE79fFZOFAoS
	mhBdsnF55cGamRJG0vAniDILexJJIGKNqThF0hLEUKjihuvGKJFAeSXfoh0rdfeNx6WqcIkTSBXOu
	6EyTs7DpmjKYhUnNGt+AdTuZOLJ2/QBXm91FyWvXXRQoT/2wQd3E1TUVzsm1R+6nx4rMV6oiKW0m+
	ZqgRsBOMQUicdl9Csxx2xQiATf25z3fAMgjN+jzw8Yq9jT2OTV/9TWHMGSTsEZmlnqQ9hSKkdNvN+
	ZNuCgsIHOldRxw+A14D8RweTXZZRXy0yRvkseJCZaa1euaCGEgk4F2oEERn/+uK+WDQm/WXJxzAPl
	JPvDUJ+g==;
Received: from 43.249.197.178.dynamic.cust.swisscom.net ([178.197.249.43] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1spBnq-000Kt1-99; Fri, 13 Sep 2024 21:17:58 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: shung-hsi.yu@suse.com,
	andrii@kernel.org,
	ast@kernel.org,
	kongln9170@gmail.com,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v5 4/9] bpf: Improve check_raw_mode_ok test for MEM_UNINIT-tagged types
Date: Fri, 13 Sep 2024 21:17:49 +0200
Message-Id: <20240913191754.13290-4-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240913191754.13290-1-daniel@iogearbox.net>
References: <20240913191754.13290-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27397/Fri Sep 13 10:48:01 2024)

When checking malformed helper function signatures, also take other argument
types into account aside from just ARG_PTR_TO_UNINIT_MEM.

This concerns (formerly) ARG_PTR_TO_{INT,LONG} given uninitialized memory can
be passed there, too.

The func proto sanity check goes back to commit 435faee1aae9 ("bpf, verifier:
add ARG_PTR_TO_RAW_STACK type"), and its purpose was to detect wrong func protos
which had more than just one MEM_UNINIT-tagged type as arguments.

The reason more than one is currently not supported is as we mark stack slots with
STACK_MISC in check_helper_call() in case of raw mode based on meta.access_size to
allow uninitialized stack memory to be passed to helpers when they just write into
the buffer.

Probing for base type as well as MEM_UNINIT tagging ensures that other types do not
get missed (as it used to be the case for ARG_PTR_TO_{INT,LONG}).

Fixes: 57c3bb725a3d ("bpf: Introduce ARG_PTR_TO_{INT,LONG} arg types")
Reported-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 v1 -> v2:
 - new patch (Shung-Hsi)
 v2 -> v3:
 - base_type(type) was needed also

 kernel/bpf/verifier.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2d8af74994ae..6e61248e73a1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8291,6 +8291,12 @@ static bool arg_type_is_mem_size(enum bpf_arg_type type)
 	       type == ARG_CONST_SIZE_OR_ZERO;
 }
 
+static bool arg_type_is_raw_mem(enum bpf_arg_type type)
+{
+	return base_type(type) == ARG_PTR_TO_MEM &&
+	       type & MEM_UNINIT;
+}
+
 static bool arg_type_is_release(enum bpf_arg_type type)
 {
 	return type & OBJ_RELEASE;
@@ -9340,15 +9346,15 @@ static bool check_raw_mode_ok(const struct bpf_func_proto *fn)
 {
 	int count = 0;
 
-	if (fn->arg1_type == ARG_PTR_TO_UNINIT_MEM)
+	if (arg_type_is_raw_mem(fn->arg1_type))
 		count++;
-	if (fn->arg2_type == ARG_PTR_TO_UNINIT_MEM)
+	if (arg_type_is_raw_mem(fn->arg2_type))
 		count++;
-	if (fn->arg3_type == ARG_PTR_TO_UNINIT_MEM)
+	if (arg_type_is_raw_mem(fn->arg3_type))
 		count++;
-	if (fn->arg4_type == ARG_PTR_TO_UNINIT_MEM)
+	if (arg_type_is_raw_mem(fn->arg4_type))
 		count++;
-	if (fn->arg5_type == ARG_PTR_TO_UNINIT_MEM)
+	if (arg_type_is_raw_mem(fn->arg5_type))
 		count++;
 
 	/* We only support one arg being in raw mode at the moment,
-- 
2.43.0


