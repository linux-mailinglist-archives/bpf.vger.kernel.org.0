Return-Path: <bpf+bounces-43307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABA39B3219
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 14:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CFF81C21517
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 13:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7BE1DD0D4;
	Mon, 28 Oct 2024 13:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GLGz1qXO"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B534194080
	for <bpf@vger.kernel.org>; Mon, 28 Oct 2024 13:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730123190; cv=none; b=qOzI+4GO/mUuK9OFKGuIEkpkrqRIcGGeMBxPhGtWCNdGBXqu9ZPXzTfHZOE9Y1lQUoQYsQQzk/mtOocIiyuITCgrOxUOAPIzXr2WdLu4RXxDsbylZOEJgMd//l3RmiS3T2St/a5jpA4qQfpYeFsJFYGp6emP6lizjIfMFa5f63c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730123190; c=relaxed/simple;
	bh=V6zHtq9mop+qm1qA0wIlrInjPq6pOZUIXph54OQEDT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VCaT109ZoR+na76h38vm2dk/20qXxHfXUp06uGHtE5DNrVvaD7pWoGlUU34aN++8u5y7H0WUtbYHxuL1F6ScqxYfxqggVoBuTRxH+9dbojEJbzYtE2tllJ6eZt3uVEiXMHXKRIqU2B4oX2GYZT2Qcd7mNfsEYcH5qzNRM8BiYVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GLGz1qXO; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730123183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JxZsp+juY5eKmUQaTTp4fwAs/SdSr/IsGBvHa5tNrkQ=;
	b=GLGz1qXOfdeFBr8VuPSXBHghlXdF36YWCncupQZf2PbHYUV5TfjI/0b3P7onPRnDJe5gVj
	hgXhSdIY1tsrB6i6dqANkUAXavUGdwjH8gqUjGoDZWAt5x/xs7gEz4YStiQ4hKT1PznY8h
	3w9WSEDvgH4tI7u1YTsCc2rorTR+M3E=
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
Subject: [RESEND PATCH bpf-next v2 2/2] bpf, verifier: Check trampoline target is tail_call_reachable subprog
Date: Mon, 28 Oct 2024 21:46:00 +0800
Message-ID: <20241028134601.95448-3-leon.hwang@linux.dev>
In-Reply-To: <20241028134601.95448-1-leon.hwang@linux.dev>
References: <20241028134601.95448-1-leon.hwang@linux.dev>
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


