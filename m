Return-Path: <bpf+bounces-54275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7DAA66A5D
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 07:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F2B37A9A12
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 06:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2F11DE2CB;
	Tue, 18 Mar 2025 06:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OVL5rrZK"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE66B1B85D1
	for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 06:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742279179; cv=none; b=rtmS/ecjeKEBW1XRStgNImOzhbwZEQKgER6C7/xOFQBU+U1LKJjGYGrR8Mv284Fv/4DaH870l7QeCXgucvLPhD3ClItE0kM6ZqkEFKB7Y87hSaPxY5LKiGFj9mpnTUPaz8FHIbUASoYJuO9z9WWiYjdDfbqq1V7Eu5AVyfpC7j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742279179; c=relaxed/simple;
	bh=QVQrDH1hlAa+TcHIQoHQD7uOP+VwNzlqveun99yp7GU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RypVGi4HuS8wsB1Z8/skSC/0ZcliYjjaRnkjDEDK7EidRxK8QFSZ9Zi5x2Y7uZw8xEfPWvWrPKhvcMZdNjbgQjk44ELJNljacRawittOCVAeIRIdDB9oXrzkxz5VPKZ40FyBe8f737AfrVBlDn5v4TEb2G2pCHhMsFZe0tFr5C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OVL5rrZK; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742279165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PXMMkhBcIWUZV4hOQTzv/pwmFi5A7eckeNFl/KW0KbY=;
	b=OVL5rrZKo1IHB5HIsnKz5PqW/eOM6nE1KeXIryhfIdfLLyQ24HBPda/1/lcjy2uRFjVw/k
	gRemcyxJhTqZJGs5OEx3XeBS/JveYqXKniC4PNq6aR5hfYdF7hpy98/2vRDDz/hjizcoLC
	XR9W5myPcTxnh0mpBD7uC0ggUeoUeNg=
From: Tao Chen <chen.dylane@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	brauner@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next] bpf: Define bpf_token_show_fdinfo with CONFIG_PROC_FS
Date: Tue, 18 Mar 2025 14:25:57 +0800
Message-Id: <20250318062557.3001333-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Protect bpf_token_show_fdinfo with CONFIG_PROC_FS check, follow the
pattern used with other *_show_fdinfo functions.

Fixes: 35f96de04127 ("bpf: Introduce BPF token object")
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/bpf/token.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
index 26057aa13..104ca37e9 100644
--- a/kernel/bpf/token.c
+++ b/kernel/bpf/token.c
@@ -65,6 +65,7 @@ static int bpf_token_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+#ifdef CONFIG_PROC_FS
 static void bpf_token_show_fdinfo(struct seq_file *m, struct file *filp)
 {
 	struct bpf_token *token = filp->private_data;
@@ -98,6 +99,7 @@ static void bpf_token_show_fdinfo(struct seq_file *m, struct file *filp)
 	else
 		seq_printf(m, "allowed_attachs:\t0x%llx\n", token->allowed_attachs);
 }
+#endif
 
 #define BPF_TOKEN_INODE_NAME "bpf-token"
 
@@ -105,7 +107,9 @@ static const struct inode_operations bpf_token_iops = { };
 
 static const struct file_operations bpf_token_fops = {
 	.release	= bpf_token_release,
+#ifdef CONFIG_PROC_FS
 	.show_fdinfo	= bpf_token_show_fdinfo,
+#endif
 };
 
 int bpf_token_create(union bpf_attr *attr)
-- 
2.43.0


