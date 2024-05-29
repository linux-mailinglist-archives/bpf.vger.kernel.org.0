Return-Path: <bpf+bounces-30835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DD98D36A2
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 14:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEC701F229F4
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 12:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508C2181BA5;
	Wed, 29 May 2024 12:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iqNl/+Bd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DYq/FcCE"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425D0181B82
	for <bpf@vger.kernel.org>; Wed, 29 May 2024 12:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716986662; cv=none; b=t5uK/lS8VnjgimgqNfFWBJf8Tx5jx43KSo+8k7B0GYN1jra6XxWdGdph19wpJ6b2ijwbpCDoyW/0Wlg+yT9rnlm2lS6BJaUmilxODYTBaigvY9F/4zci0K2v6op2IBeza0ZjdsD+LG7gi+3jKSnRi+4C393Q1+hX6g/AW2J4Jw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716986662; c=relaxed/simple;
	bh=k0+X8DSEYZeUu+h+HLB2+ehNSeP3e+YfPV24rZpk1UM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EEnZYqoqAfJZTBtPRtFSc7Vuep/k6fBKJ5wC1CylRdj0o8Xdfrn/J2xKyt9C/Bj8qfrLn1QfPMowIlEeLPjjW0VKC/6CNXSLAr9qVqhAJJLcgU89vx/BEf4wiE+kQss6+Lott2bJpD8yrFWiZEYK3DLogKS94p+AJsjUvDO2vMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iqNl/+Bd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DYq/FcCE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 May 2024 14:44:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716986654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=gLLIEachEdqTGsIFBVlebD4/PQtwzb/ZyQJWvjG7luE=;
	b=iqNl/+Bd6kHqJbd34ff67yV96DpJS3Nw+f+EnXgnxnqBbGjTuBOvILh4v3vCAUv51meqvV
	9d7+U35Ugdtb+T8kLfmGAsfw6FNYb76apm+pPbYJIvtxW0eW3r3oNwPW+MffxXk8sfVDh/
	FyhGzqiJB4ZpJPZOSpdc7kGtAte6kRXi7CwvY9tUrPWbBEhWtkRmGPiKdMxAc6FOK7cbM5
	It5kj3VzrDLgy6PIZKfRh2AoC/q7AELLAGk7Td6yl8siDxIKdFuJhRW9M5t5RzK/1GrVJ0
	EplBKMKUKa3MLz/3bhi2+6vZjgs/dj0Hs4w26BwWoJ93BXkUwD0M+B/1dE9cHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716986654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=gLLIEachEdqTGsIFBVlebD4/PQtwzb/ZyQJWvjG7luE=;
	b=DYq/FcCE5VxbsK2SYF4nQ80i/DmtATW3BFymiE2Ma3A/9sPuC/9bpm0DdL2Ue5fGcXW8S6
	/WkNyCqlKieoFuCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: bpf@vger.kernel.org
Cc: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Viktor Malik <vmalik@redhat.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] bpf: Use an UNUSED id for bpf_session_cookie without FPROBE
Message-ID: <20240529124412.VZAF98oL@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

bpf_session_cookie() is only available with CONFIG_FPROBE=y leading to
an unresolved symbol otherwise.

Use BTF_ID_UNUSED instead of bpf_session_cookie for CONFIG_FPROBE=n.

Fixes: 5c919acef8514 ("bpf: Add support for kprobe session cookie")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 77da1f438becc..436f72bfcb9b9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11124,7 +11124,11 @@ BTF_ID(func, bpf_iter_css_task_new)
 #else
 BTF_ID_UNUSED
 #endif
+#ifdef CONFIG_FPROBE
 BTF_ID(func, bpf_session_cookie)
+#else
+BTF_ID_UNUSED
+#endif
 
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
-- 
2.45.1


