Return-Path: <bpf+bounces-43304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 024469B31E2
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 14:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EBF31F22447
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 13:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6521DC06B;
	Mon, 28 Oct 2024 13:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VOaEv2PQ"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2771DA636
	for <bpf@vger.kernel.org>; Mon, 28 Oct 2024 13:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730122861; cv=none; b=UEo/VqrCI3GvFo0H23pi1CVjTXVkHXqL4jZONK/MW6JKqWJD8gAgjWbPt5TCAiKAoEEAxMltcVN1Lvken0QEUgvt8+i65h/9b0DpYm1zVWLjh7caDIkIkuHvSs8tIr3Lie/nD50Iv1S0dmlW19anNQYJqoVg+40TnUTe71lG+eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730122861; c=relaxed/simple;
	bh=V6zHtq9mop+qm1qA0wIlrInjPq6pOZUIXph54OQEDT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Isqe6NQqD2Va9/ty5MX21W9WP/uC4yJr6w3ZhEZQrDOiWmFqHjMDQbPCtOA90yTcZHknVft6HVCWFbXEhQC3UP2sK9MGW9bwP5pBQeWc+iz2tmqjRiRwTuEz/9xVdekREk0kvNlK1NNlsBO+gg3vpNUM+2mGRa1/IbfCEhyY5/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VOaEv2PQ; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730122856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JxZsp+juY5eKmUQaTTp4fwAs/SdSr/IsGBvHa5tNrkQ=;
	b=VOaEv2PQzCS+Rl7gQhYcbkceHupwMqOsUFGXct8zVkKXpqYKFFrwacDzx/kn8quLhJ5q4r
	nbT6wfpvo9y413X13CNqUVlCzHTlKkxRe0i9b1s1DK7B68m94Vn2DbLXLZDJyI8XUq1CjK
	+1zHe9VOcENWyn4NqLlpwaWqJeWa0Pc=
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
Subject: [PATCH bpf-next 2/2] bpf, verifier: Check trampoline target is tail_call_reachable subprog
Date: Mon, 28 Oct 2024 21:40:41 +0800
Message-ID: <20241028134041.94098-3-leon.hwang@linux.dev>
In-Reply-To: <20241028134041.94098-1-leon.hwang@linux.dev>
References: <20241028134041.94098-1-leon.hwang@linux.dev>
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
index c3ba4d4751747..0c3b147c84af9 100644
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
index 797cf3ed32e0f..2e2f027b86375 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21946,6 +21946,8 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			bpf_log(log, "Subprog %s doesn't exist\n", tname);
 			return -EINVAL;
 		}
+		tgt_info->tgt_tail_call_reachable = subprog &&
+						    aux->func[subprog]->aux->tail_call_reachable;
 		if (aux->func && aux->func[subprog]->aux->exception_cb) {
 			bpf_log(log,
 				"%s programs cannot attach to exception callback\n",
@@ -22315,7 +22317,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	if (!tr)
 		return -ENOMEM;
 
-	if (tgt_prog && tgt_prog->aux->tail_call_reachable)
+	if (tgt_prog && tgt_info.tgt_tail_call_reachable)
 		tr->flags = BPF_TRAMP_F_TAIL_CALL_CTX;
 
 	prog->aux->dst_trampoline = tr;
-- 
2.44.0


