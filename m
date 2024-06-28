Return-Path: <bpf+bounces-33338-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D1291BA5F
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 10:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D498A284626
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 08:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A13B14E2DA;
	Fri, 28 Jun 2024 08:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0L/aaEke";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="87XDwh3K"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C16F14B952
	for <bpf@vger.kernel.org>; Fri, 28 Jun 2024 08:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719564546; cv=none; b=Y+FOrB7Zsd5BGXFpbgUcSB3ULRYokpnf31zP+d4Ydq/rV4Uq0wU9HLn10SRDpNkbE1MFWbZgyQqZuOIpGuu8AZ1PkEQ8SVjGBFpYf3r6p0057e9RhQJ8ThBsI96kcIerJQ5RUb9RAy2W/a0cpp3bEfsXP4m6uvenXPLaJSaVdlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719564546; c=relaxed/simple;
	bh=I3uOl4cDbnhxozovBfnc/iAY8w4Qu+WZ3mDXJZRgUtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZXFA7fy7yOYSUKUohZuXKbmMJA+Rs4X4Pft66JAZgsWQjQvmWJcTXBPJloY9QFlfIrrbT9B4Rfd3XAh1Rod3oJjcbcS8jZDQeTpIBj2B9Ty2usWeVE73wohBK2zsYxR/3bBO9O/j0LhiQsg+Hxo5T0V1A8PyAL5+U+whBGu2HJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0L/aaEke; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=87XDwh3K; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719564542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JplfBwznUpua9J2/WRPUveXnK3sjto8+qhgTRlfPCcc=;
	b=0L/aaEkeFtN84GH1Sb1xCP1zN8GFtSYYzQMKAwTL3a5tl1yHHG6jfE/NJtUmmYgmuqoSEO
	0DklkzxyAtHCdfLqV3fcGK4GNqUa7pD6trlGK+Pjylif4bkwFaSWphUEJ+uTUESbdRu2h1
	gkBkFAZLWhLmYxQmsZDPlF6crHwVDkQ6GT5rGtqacS3BWZG0VTM/F9B5Qkdr+iGidD/UQO
	OQniurWYG3MmRiQ1HHbEFERh8j9q339sWPooj/wj0/4aXnuWsIT1MmH/j2lgugCXmOfCP3
	k0ph1DgoUBQlhzb5EEv3q8A0MPgar/tDoxSkAaMYEQ0/jc5TTUBmcvWzzRBJ/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719564542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JplfBwznUpua9J2/WRPUveXnK3sjto8+qhgTRlfPCcc=;
	b=87XDwh3Ke80fDJXML/qqYTehulo22zEi320DuIxODN5qRIzEzK/8pBPQlJPOVpcRpF0rGC
	mj+BrUPkxttxyNBQ==
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
Subject: [PATCH bpf-next 2/3] bpf: Move a few bpf_func_proto declarations.
Date: Fri, 28 Jun 2024 10:41:00 +0200
Message-ID: <20240628084857.1719108-3-bigeasy@linutronix.de>
In-Reply-To: <20240628084857.1719108-1-bigeasy@linutronix.de>
References: <20240628084857.1719108-1-bigeasy@linutronix.de>
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
index a834f4b761bc5..50074009d0860 100644
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


