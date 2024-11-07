Return-Path: <bpf+bounces-44243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC4B9C07EB
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 14:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D32FDB23A22
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 13:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB34D21219D;
	Thu,  7 Nov 2024 13:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UgpcwjKY"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3383220F5D5
	for <bpf@vger.kernel.org>; Thu,  7 Nov 2024 13:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730987179; cv=none; b=N5hekF9PdmbaMRHQgbjOl2MsR86dN9ajqOV3p4NcI/tnUY07P0blRMOLHBE9sK9uGxOf3EDSqklcAjtOiUiEyO2NZ1wEj1mTBgXoFFC4ByPh04mnWotylsXrlZS6lBZTGYiOYa+vyRt6g+Sgf7Q3BpY9jBvfHWmcGXRprYYcNuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730987179; c=relaxed/simple;
	bh=NMQSEYohCPGPzWLZHWg0lPzHGTFa8GAyUElxNFp4zSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZZop0u6gxfLi5Q+nzNa9tf12yuC/Ygp46H9uffmyjBsz2uL9GOclPF5/MfbEFcnaGLQwkget1dT+zWhLMFAKZls2a1dCROxgSQCErGGRHBngZTKi53MHdVZl8ll9xyVwjKTWHKFKBAfP9vGJXf8NkfPimUDLQUHHA7at5gv1w7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UgpcwjKY; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730987175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hXy75sbO/x8upd/ZA9cxqWXG/AZmYgyQpCX2syfhZlw=;
	b=UgpcwjKYmnmyUKv7TrAz7mRIZ78M/WRKXMOZXwF75VuQmQv3tRz3pC7sIgeg4hC3g9LmGy
	rDNyoC2ZDDzS2vBKuJsswHKrxSoqeUjC5aS8HKqsZeJk/yCWhTeEk8hu/8vg0nFoosZtr4
	D24oMnFPbb1GlJ9kqDAkZQw9NtqFChE=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	eddyz87@gmail.com,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v3 2/2] bpf, verifier: Check trampoline target is tail_call_reachable subprog
Date: Thu,  7 Nov 2024 21:45:29 +0800
Message-ID: <20241107134529.8602-3-leon.hwang@linux.dev>
In-Reply-To: <20241107134529.8602-1-leon.hwang@linux.dev>
References: <20241107134529.8602-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In the x86_64 JIT, tailcall info is propagated through the trampoline when
the target program is tail_call_reachable. However, this propagation is
unnecessary if the target is a main prog, or a subprog that is not
tail_call_reachable.

Since the verifier can determine if a subprog is tail_call_reachable, it
should only propagate tailcall info when the target is subprog and the
subprog is actually tail_call_reachable.

Acked-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h   | 1 +
 kernel/bpf/verifier.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1b84613b10ac7..1e5b439ab4c7d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1253,6 +1253,7 @@ struct bpf_attach_target_info {
 	struct module *tgt_mod;
 	const char *tgt_name;
 	const struct btf_type *tgt_type;
+	bool tgt_tail_call_reachable;
 };
 
 #define BPF_DISPATCHER_MAX 48 /* Fits in 2048B */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7958d6ff6b739..e5b9754a2f0be 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22004,6 +22004,8 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			bpf_log(log, "Subprog %s doesn't exist\n", tname);
 			return -EINVAL;
 		}
+		tgt_info->tgt_tail_call_reachable = subprog &&
+						    aux->func[subprog]->aux->tail_call_reachable;
 		if (aux->func && aux->func[subprog]->aux->exception_cb) {
 			bpf_log(log,
 				"%s programs cannot attach to exception callback\n",
@@ -22373,7 +22375,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	if (!tr)
 		return -ENOMEM;
 
-	if (tgt_prog && tgt_prog->aux->tail_call_reachable)
+	if (tgt_prog && tgt_info.tgt_tail_call_reachable)
 		tr->flags = BPF_TRAMP_F_TAIL_CALL_CTX;
 
 	prog->aux->dst_trampoline = tr;
-- 
2.44.0


