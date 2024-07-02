Return-Path: <bpf+bounces-33639-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BEA9240BC
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 16:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 352C51F23440
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 14:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913A81BA06B;
	Tue,  2 Jul 2024 14:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oAPtcP0d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TtCNeu+j"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F8E86AFA
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 14:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719930350; cv=none; b=SS9fU6YZX3aqbI8MIwszhWVrlXZm+DJHc19C+TJkU5zmM5ToSg/WMRkW9yst4/jMlpz2HfnEaBvgeIsLBpIwdXXesjLpJCAzjniurt5xDWnfboe9BUmPWiyfRU0upYVQA+lHW1RuoyhHkRsi4nZbzUwu7KAhCgapzU/SnX8dXGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719930350; c=relaxed/simple;
	bh=8Zd+tw3LLn9o1iacRD8jLVIEXoSaa1oT64c4NzOjUe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBG9+jLl5lRf2MW7WbRVzGscBVYoZAvRHHHW7Os+8WFgpgskhabtaLd8xtGFhVR2Ic+1HWpJ7OmGW2uzHzFUQeQ6lgisrxu/JeHnBkSVy4ZpmVdk9f/MfP8iZh1IqvSc3n6JoQSAMppPL3wRZq7lBPede6XbR3tKRzTe7qxt91g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oAPtcP0d; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TtCNeu+j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719930346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n0ZGP2WxHWKK3MfmP0I5GYvKu7zq6rqevwGk2eCI6D4=;
	b=oAPtcP0dQM4CP8DUOk5N/aw+mS4eAS4iAdnkRYhNkfGvEUnE+vaDAs70wfCTublGMwmdec
	HQ1UgTZwJhheqYQvXY+rzYNn3ZQoYHOPbGWcsoz+8POnsIiT+7BvJ8YSpwgopESTaTxt9w
	Ct+RSspBJG5hBMwqFOh/adAQyfs9OEXly7UuYtXOkNIpV3XnfivAZcAkSsk+u3cbogxKVc
	1IXIXcbSNiHKjWGGaZwsYBiMQfqpVhLHtHJoVaCKY3Vx4fyyzJZ8YEun+M9koxS9PCrZrG
	mJO2nZeiTg9RoGpQbLFqi9t5AjuxRKSPLoyihamoCPHulEKBxlqfoogDGjEYcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719930346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n0ZGP2WxHWKK3MfmP0I5GYvKu7zq6rqevwGk2eCI6D4=;
	b=TtCNeu+j2lZOtdiwnmvbFhjZwz3oXBFiHYq1YNWARWOj/97KgToO0AZh9FPtCJ1D8E2q0o
	anboisq6bDY6w4Ag==
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yonghong Song <yonghong.song@linux.dev>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 bpf-next 2/3] bpf: Move a few bpf_func_proto declarations.
Date: Tue,  2 Jul 2024 16:21:42 +0200
Message-ID: <20240702142542.179753-3-bigeasy@linutronix.de>
In-Reply-To: <20240702142542.179753-1-bigeasy@linutronix.de>
References: <20240702142542.179753-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

sparse complains about missing declarations and a few of them are in
another .c file. One has no other declaration because it is used localy
and marked weak because it might be defined in another .c file.

Move the declarations from bpf_trace.c to a common place and add one for
bpf_sk_storage_get_cg_sock_proto.

After this change there are only a few missing declartions within the
__bpf_kfunc_start_defs() block which explictlty disables this kind of
warning for the compiler. I am not aware of something similar for sparse
so I guess are stuck with them unless we add them.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/bpf.h      | 5 +++++
 kernel/trace/bpf_trace.c | 4 ----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f5c6bc9093a6b..d411bf52910cc 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -840,6 +840,11 @@ struct bpf_func_proto {
 	bool (*allowed)(const struct bpf_prog *prog);
 };
=20
+extern const struct bpf_func_proto bpf_xdp_get_buff_len_trace_proto;
+extern const struct bpf_func_proto bpf_skb_output_proto;
+extern const struct bpf_func_proto bpf_xdp_output_proto;
+extern const struct bpf_func_proto bpf_sk_storage_get_cg_sock_proto;
+
 /* bpf_context is intentionally undefined structure. Pointer to bpf_contex=
t is
  * the first argument to eBPF programs.
  * For socket filters: 'struct bpf_context *' =3D=3D 'struct sk_buff *'
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index d1daeab1bbc14..d8d7ee6b06a6f 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1951,10 +1951,6 @@ static const struct bpf_func_proto bpf_perf_event_ou=
tput_proto_raw_tp =3D {
 	.arg5_type	=3D ARG_CONST_SIZE_OR_ZERO,
 };
=20
-extern const struct bpf_func_proto bpf_skb_output_proto;
-extern const struct bpf_func_proto bpf_xdp_output_proto;
-extern const struct bpf_func_proto bpf_xdp_get_buff_len_trace_proto;
-
 BPF_CALL_3(bpf_get_stackid_raw_tp, struct bpf_raw_tracepoint_args *, args,
 	   struct bpf_map *, map, u64, flags)
 {
--=20
2.45.2


