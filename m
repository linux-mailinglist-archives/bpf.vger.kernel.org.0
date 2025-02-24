Return-Path: <bpf+bounces-52466-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B23A43175
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 01:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46AE1173B9F
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 23:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8225B20CCEA;
	Mon, 24 Feb 2025 23:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fzwN+F8P"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B12120C492
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 23:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740441485; cv=none; b=S5GYMi5N4EFBSQXTCKvzQcKKlmgtqQ8GNnTi/n2IC1vVqc3ZTJ6vo3N1jfBqB1F4uOsguMSvEr8rMfSkUZ77OO2a+yrukEC528hJ+LCQykwkii6Wak1NR2RPh6lVyv8vcg9jH71VP5cCxDV2ynZ69mgv6pCCFKwUTwJ2vvib3xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740441485; c=relaxed/simple;
	bh=G5U3nUxp6F1nPpGWycPCJXYRUo6wvtDHjSI7ZKwT0RA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H0EIOwciNXODXdf3tpuvEVs8g83aCq66W/roDjiEWzx0jNq95T6tYpfLWXb9ZlQAs7U42WBcCdMiLAaeW/+g0n0CfnEUykQhovlDv5hg0gytyZRiszI5L45s3DZeg82O42xsU1uYa2GgBQBUmXw3ffkrzPP828BewIxAUgfIgJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fzwN+F8P; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740441481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G5k8VC+eh5D6kjHsJQ1e6pP0uVq4pCt42EyiwwV9iz0=;
	b=fzwN+F8PLDymzUi8HWD0gJsD/ayB9RRCNNHz7aRnh6J8IowjTkYs/2fkwawdbUsFq5uYSW
	yQDJ46lElCurTqNW/hhlcIsWPf+rL8Q9VKEdspt+ti5HVqPb2Y6lNkc7RyK3On2lB9I8QK
	RQzehUKo5v+vY8tXHAWpu9qvccz/TrY=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	mykolal@fb.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 1/2] libbpf: implement bpf_usdt_arg_size BPF function
Date: Mon, 24 Feb 2025 15:57:55 -0800
Message-ID: <20250224235756.2612606-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Information about USDT argument size is implicitly stored in
__bpf_usdt_arg_spec, but currently it's not accessbile to BPF programs
that use USDT.

Implement bpf_sdt_arg_size() that returns the size of an USDT argument
in bytes.

v1->v2:
  * do not add __bpf_usdt_arg_spec() helper

v1: https://lore.kernel.org/bpf/20250220215904.3362709-1-ihor.solodrai@linux.dev/

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/lib/bpf/usdt.bpf.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/lib/bpf/usdt.bpf.h b/tools/lib/bpf/usdt.bpf.h
index b811f754939f..2a7865c8e3fe 100644
--- a/tools/lib/bpf/usdt.bpf.h
+++ b/tools/lib/bpf/usdt.bpf.h
@@ -108,6 +108,38 @@ int bpf_usdt_arg_cnt(struct pt_regs *ctx)
 	return spec->arg_cnt;
 }
 
+/* Returns the size in bytes of the #*arg_num* (zero-indexed) USDT argument.
+ * Returns negative error if argument is not found or arg_num is invalid.
+ */
+static __always_inline
+int bpf_usdt_arg_size(struct pt_regs *ctx, __u64 arg_num)
+{
+	struct __bpf_usdt_arg_spec *arg_spec;
+	struct __bpf_usdt_spec *spec;
+	int spec_id;
+
+	spec_id = __bpf_usdt_spec_id(ctx);
+	if (spec_id < 0)
+		return -ESRCH;
+
+	spec = bpf_map_lookup_elem(&__bpf_usdt_specs, &spec_id);
+	if (!spec)
+		return -ESRCH;
+
+	if (arg_num >= BPF_USDT_MAX_ARG_CNT)
+		return -ENOENT;
+	barrier_var(arg_num);
+	if (arg_num >= spec->arg_cnt)
+		return -ENOENT;
+
+	arg_spec = &spec->args[arg_num];
+
+	/* arg_spec->arg_bitshift = 64 - arg_sz * 8
+	 * so: arg_sz = (64 - arg_spec->arg_bitshift) / 8
+	 */
+	return (unsigned int)(64 - arg_spec->arg_bitshift) / 8;
+}
+
 /* Fetch USDT argument #*arg_num* (zero-indexed) and put its value into *res.
  * Returns 0 on success; negative error, otherwise.
  * On error *res is guaranteed to be set to zero.
-- 
2.48.1


