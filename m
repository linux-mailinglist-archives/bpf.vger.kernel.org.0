Return-Path: <bpf+bounces-62762-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE2AAFE266
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 10:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC1F83A61C0
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 08:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDAB2690F9;
	Wed,  9 Jul 2025 08:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NRUohGkU"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152E023B617;
	Wed,  9 Jul 2025 08:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752049312; cv=none; b=XZI0J9s53Qsr2GUx3Bn1muZheAjmVsk3+nmeWe5J7YKUAKzRYOrjIu0/PaPRF4d1yPPrNOOeB8y3B6Zc0YV6Q8c3ENzY5W0SxQMYg3LxDvEcadG5g+A2DCfEUWsuTNubrwf+Wvw6yckxDHFf/BiJWStLngWSCZq7+Vc/a9zxPcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752049312; c=relaxed/simple;
	bh=fxdYfuHbUSY1YccG+Ky4lNz5iZeGY6rLjPTXrtRR0Mc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eXY3P9e5hvHgQvqByLMpOQto5knYf0AXXWspYygQ7jeGH39VfOqz0RLrbRwgBBoB1MzoVe09LQ3S3hcy+ErtxPEiQEQLzezW/5EVInHDqxP4ffW4tRnu7hKykSOkoc7uEIVxh95AgQELCkDSLy/yD8wRjeRM2rJCI6hTQwujgdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NRUohGkU; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ph
	GeD/kctk/OQIfTnacFO2E//+JNX8HZT1+i9hPFOPc=; b=NRUohGkUuVWxp2JoSJ
	sQWbCxGp3H1YiuIt0ziJTmgyiRdfl1g97SoJQuWRnRaYsh7ed/A5UNV/cvV6/eAq
	hMAQdAPe04Zb1i2VR16MjTGib4qYhPB8RBkYbGXnMevwPu3MQVlBp+jHGZHqRiw1
	/oyuui57E7q5/xmhaOXwg6gBc=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDHukpWJm5oDyoSDg--.32703S2;
	Wed, 09 Jul 2025 16:20:39 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpf: Clean up individual BTF_ID code
Date: Wed,  9 Jul 2025 16:20:38 +0800
Message-Id: <20250709082038.103249-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHukpWJm5oDyoSDg--.32703S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZryDJr48AFykZryDCF47XFb_yoW5JFy5pa
	yDZ3srCr40gw4YvF1UJr45uryaga10g3y3CF4DJw4fKr1UXw1kWF12gr13AF1aqryDKr9a
	qw109r9xtw4xurDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnYFAUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiYwiEeGhswHxPXwABs+

From: Feng Yang <yangfeng@kylinos.cn>

Use BTF_ID_LIST_SINGLE(a, b, c) instead of
BTF_ID_LIST(a)
BTF_ID(b, c)

Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 kernel/bpf/btf.c         | 3 +--
 kernel/bpf/link_iter.c   | 3 +--
 kernel/bpf/prog_iter.c   | 3 +--
 kernel/trace/bpf_trace.c | 3 +--
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 2dd13eea7b0e..0aff814cb53a 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6200,8 +6200,7 @@ int get_kern_ctx_btf_id(struct bpf_verifier_log *log, enum bpf_prog_type prog_ty
 	return kctx_type_id;
 }
 
-BTF_ID_LIST(bpf_ctx_convert_btf_id)
-BTF_ID(struct, bpf_ctx_convert)
+BTF_ID_LIST_SINGLE(bpf_ctx_convert_btf_id, struct, bpf_ctx_convert)
 
 static struct btf *btf_parse_base(struct btf_verifier_env *env, const char *name,
 				  void *data, unsigned int data_size)
diff --git a/kernel/bpf/link_iter.c b/kernel/bpf/link_iter.c
index fec8005a121c..8158e9c1af7b 100644
--- a/kernel/bpf/link_iter.c
+++ b/kernel/bpf/link_iter.c
@@ -78,8 +78,7 @@ static const struct seq_operations bpf_link_seq_ops = {
 	.show	= bpf_link_seq_show,
 };
 
-BTF_ID_LIST(btf_bpf_link_id)
-BTF_ID(struct, bpf_link)
+BTF_ID_LIST_SINGLE(btf_bpf_link_id, struct, bpf_link)
 
 static const struct bpf_iter_seq_info bpf_link_seq_info = {
 	.seq_ops		= &bpf_link_seq_ops,
diff --git a/kernel/bpf/prog_iter.c b/kernel/bpf/prog_iter.c
index 53a73c841c13..85d8fcb56fb7 100644
--- a/kernel/bpf/prog_iter.c
+++ b/kernel/bpf/prog_iter.c
@@ -78,8 +78,7 @@ static const struct seq_operations bpf_prog_seq_ops = {
 	.show	= bpf_prog_seq_show,
 };
 
-BTF_ID_LIST(btf_bpf_prog_id)
-BTF_ID(struct, bpf_prog)
+BTF_ID_LIST_SINGLE(btf_bpf_prog_id, struct, bpf_prog)
 
 static const struct bpf_iter_seq_info bpf_prog_seq_info = {
 	.seq_ops		= &bpf_prog_seq_ops,
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index e7f97a9a8bbd..c8162dc89dc3 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -781,8 +781,7 @@ BPF_CALL_1(bpf_task_pt_regs, struct task_struct *, task)
 	return (unsigned long) task_pt_regs(task);
 }
 
-BTF_ID_LIST(bpf_task_pt_regs_ids)
-BTF_ID(struct, pt_regs)
+BTF_ID_LIST_SINGLE(bpf_task_pt_regs_ids, struct, pt_regs)
 
 const struct bpf_func_proto bpf_task_pt_regs_proto = {
 	.func		= bpf_task_pt_regs,
-- 
2.43.0


