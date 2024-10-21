Return-Path: <bpf+bounces-42622-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D673D9A6A98
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 15:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 746D11F23E0D
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 13:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7B01F9A8A;
	Mon, 21 Oct 2024 13:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gjt8jVAz"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D351F9418
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 13:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729517986; cv=none; b=N7MdWkH+k9Nn0KJCW4M+dt+AX6AoToBz4+3423pqglTpfsO4E0+NLbde5Nh2/6MIIAVQndsd8y1Jgv3yIouTWPVOVV8FwIB+7uIQoNeknKu9kbgrSzXi57XThD1MiNpVcR97IA6T9UMYqyNeIzr2VaPFKo2AmTy4djeJSV9d0yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729517986; c=relaxed/simple;
	bh=H2A1+JYWKknofAA4jRCsvWtKXIjXKWUD6kTdfZtv0Cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jbcnYcGvfq+LxilBWonhB135wpaXl5KoMbSrrOnzSSjizKZ99Ncv5iBeI3TjRHxXawXR4Zvv0u7wn0JtuVY1Y0UAQZ4ClS7a16XGWpDY3+iiWQZv/Eg8RvmcLJPWE4+JD0lQVWgms+akf7aMrrG0UVmCCnYAw10iZAI8DnNzAOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gjt8jVAz; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729517982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PgLLvH0slcXFg5B1Nm6mKktt/JEYcQ52/xEyV27bsLg=;
	b=gjt8jVAzBxKRQSjHUsCV3GihIxXd8E4SMO7PDfESpxHlg98+ZG5dw0xTSZ0XBjUyKlG431
	HZ5v0MFrXnvA8Xh80xmH3O+7PYRquTUqXCVYgsCbxQkZkp/IT4PHOSO+9vjTJI0M7zYcUE
	RKgdEcVsHKCvF1H8t7/ZerZSCLlc3PU=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	jolsa@kernel.org,
	eddyz87@gmail.com,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 2/2] bpf, verifier: Check trampoline target is tail_call_reachable subprog
Date: Mon, 21 Oct 2024 21:39:29 +0800
Message-ID: <20241021133929.67782-3-leon.hwang@linux.dev>
In-Reply-To: <20241021133929.67782-1-leon.hwang@linux.dev>
References: <20241021133929.67782-1-leon.hwang@linux.dev>
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

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h   | 1 +
 kernel/bpf/verifier.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 0c216e71cec76..32b56a759d788 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1220,6 +1220,7 @@ struct bpf_attach_target_info {
 	struct module *tgt_mod;
 	const char *tgt_name;
 	const struct btf_type *tgt_type;
+	bool tgt_tail_call_reachable;
 };
 
 #define BPF_DISPATCHER_MAX 48 /* Fits in 2048B */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6e7e42c7bc7b1..9a09621a8832c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21916,6 +21916,8 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			bpf_log(log, "Subprog %s doesn't exist\n", tname);
 			return -EINVAL;
 		}
+		tgt_info->tgt_tail_call_reachable = subprog &&
+						    aux->func[subprog]->aux->tail_call_reachable;
 		if (aux->func && aux->func[subprog]->aux->exception_cb) {
 			bpf_log(log,
 				"%s programs cannot attach to exception callback\n",
@@ -22285,7 +22287,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	if (!tr)
 		return -ENOMEM;
 
-	if (tgt_prog && tgt_prog->aux->tail_call_reachable)
+	if (tgt_prog && tgt_info.tgt_tail_call_reachable)
 		tr->flags = BPF_TRAMP_F_TAIL_CALL_CTX;
 
 	prog->aux->dst_trampoline = tr;
-- 
2.44.0


