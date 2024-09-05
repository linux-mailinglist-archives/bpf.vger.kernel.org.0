Return-Path: <bpf+bounces-39007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BD396D7CC
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 14:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C83C1F242F1
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 12:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD292198A35;
	Thu,  5 Sep 2024 12:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="YCAPXtnT"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3E219538A
	for <bpf@vger.kernel.org>; Thu,  5 Sep 2024 12:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725537706; cv=none; b=rHfyqtt25aZhnQmfqIVTgvT6U/BoGkKhD4CxTz58d9Ff9HF4F6qr3RnY6G8cvOmRBFpn+6gQV1EhOQUauaB0YxcBf4xJd4aUuDTZsBSqzr+9aSGqoinnuzCbLGjm6C371PB1x9Rw7JXmkfwQVOEsybNCSqpQZriuSs8pGLXLmoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725537706; c=relaxed/simple;
	bh=SluZfd2RfXeuX5k2Fjq+WNkhS115c9wL9U0RNLNoShY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QecMYYX9zCn0uYXvvUfmDwpnZKVSOIADt3bk2z4sV1/AMNolDLx1YHVl8syaCKpjYz3D8FUl/ED404SCtloJA73Vf9Qv4HBp7Ratg6EQ5jcWGvctKtleftpktk7UhUjpKtXb2P0mSuGWNaZsjxJ1PPJADFS+Smyn5+xX/Vth0jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=YCAPXtnT; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=AGs0Uihc/tKWA6VMx9O9jm1S7rUw6g2Z8DEF6suPVz0=; b=YCAPXtnTtlZFPpBiSnvLLuubM6
	KBy4ecUIbPLJHsKpnj3AXpsdyptnTmfEJxdz3AEptyIM00SWk/OKulKqsq5U5cjbBfPYfvX+TpZLQ
	3NidDDNUxQiZyLwTotci2p9i6lUjErYW5XIyqvIuzfbO31XPE1QoX9tft6/bsL5vMYqNGFejX+tB+
	tiWGKqyMASU1VEIyTA5QmqFH2325YpPQ2z4YJNM/kq8anH5q1eBSD99X6IwuzDuH5Z4bbVS7ywbJT
	Zx1x4Mx3bA64a1wfpILKc5G4Ho2VyeTwZyV6/tZKKEitnpHYyiJtS+TNg7gweVMbGQcxVi0aOmbG9
	ZDFCkQmA==;
Received: from 23.248.197.178.dynamic.cust.swisscom.net ([178.197.248.23] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1smBB7-0001gO-Ni; Thu, 05 Sep 2024 14:01:33 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: shung-hsi.yu@suse.com,
	andrii@kernel.org,
	ast@kernel.org,
	kongln9170@gmail.com,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v2 2/6] bpf: Extend check_raw_mode_ok by just probing MEM_UNINIT
Date: Thu,  5 Sep 2024 14:01:24 +0200
Message-Id: <20240905120128.7322-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240905120128.7322-1-daniel@iogearbox.net>
References: <20240905120128.7322-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27389/Thu Sep  5 10:33:25 2024)

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

Probing for type & MEM_UNINIT ensures that other types do not get missed (as it
used to be the case for ARG_PTR_TO_{INT,LONG}).

Fixes: 57c3bb725a3d ("bpf: Introduce ARG_PTR_TO_{INT,LONG} arg types")
Reported-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 v1 -> v2:
 - new patch (Shung-Hsi)

 kernel/bpf/verifier.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index efd9c453399e..d076b4e5114f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8296,6 +8296,11 @@ static bool arg_type_is_mem_size(enum bpf_arg_type type)
 	       type == ARG_CONST_SIZE_OR_ZERO;
 }
 
+static bool arg_type_is_raw_mem(enum bpf_arg_type type)
+{
+	return type & MEM_UNINIT;
+}
+
 static bool arg_type_is_release(enum bpf_arg_type type)
 {
 	return type & OBJ_RELEASE;
@@ -9348,15 +9353,15 @@ static bool check_raw_mode_ok(const struct bpf_func_proto *fn)
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


