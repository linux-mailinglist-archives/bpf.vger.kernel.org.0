Return-Path: <bpf+bounces-29659-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDB98C4704
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 20:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BC721F21526
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 18:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F52843AB4;
	Mon, 13 May 2024 18:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="zmkxFfoM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PXkZHJU+"
X-Original-To: bpf@vger.kernel.org
Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D4E4122C;
	Mon, 13 May 2024 18:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715625562; cv=none; b=Q0j+d7vZpUcJBPvqY5D9Y/kGZRTf/UJwgc3QdUSyybeM7LFucQf25bqkG1gdBduGyWASPDsLood9YTqzpE9ESFSP7FhrFWYG8g0CxJQ9Gd2XfoMLEyu5Z8/7Z+cd1FGRi7+8RAvk4UqYf10ZmyUG8E6v+nfakR/ufv0jCJzZq98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715625562; c=relaxed/simple;
	bh=tKxiTZ7Piwzo+n8B9PvgH/MrVub9dU8oHMgoZXlPvhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yrj43UF5yXcNixSiIIFvTFZ9ZiZABMtkBC58uc7RfDtZ4eOJrSRuEyp4BVvDl4uJIjeWzq8rF7qmkx9Za1uvIisVtYpZgZ6NVQMcFFAyr7QNhxpuMDpAixKxAMKo1NC00DtfuDMFUSfBxNFENWMNl3bNUjEqKZ4OfImW1l/YD6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=zmkxFfoM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PXkZHJU+; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 3DE771C0011E;
	Mon, 13 May 2024 14:39:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 13 May 2024 14:39:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1715625557; x=
	1715711957; bh=ctZJO2jvzoYQqwAjIQezBewCGUnMWZUcctd5HrLkCsA=; b=z
	mkxFfoMabiP4sYpqC0/Yp1RU/b2gDpf9cpDfbNGmNenqHsQF/eHz9YPs9bZ7IThs
	jg4XA8rQAUxkqHjsZ3+KD7f178DhvDgkR/KJenhTksLeoKrgduyYiNQnduusoy/f
	PE5dtuvCiCioLTONOvB65FQKk8oR9m4IWXyWuecaiCAGZZDXHu3y23d+6y0VS2aV
	vqGl5WDFH2B2mAE029sSi6G35JHIh5eEz5Raj4MOiaVS7JfBJGzwA+XOsH/GLGC0
	vciu4R5w1ZNJQHRLe7IvzcOzWcrakGv8lEdZh1sZnXdrT+vhGTkDIg8b7jyHzYeT
	oUKAV+/qtKUYZS7sbq2xQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715625557; x=
	1715711957; bh=ctZJO2jvzoYQqwAjIQezBewCGUnMWZUcctd5HrLkCsA=; b=P
	XkZHJU+gPIBQ6ylUCMOfgeIxvyr8vQnTWmhXUhSpLWoNZsnIcgsNa6+IkbmHP9qU
	vdkIwPE6B31kysi3A5cK8suxVP/nzG+hli4fr8BGeyqbbu+daoUX0qC27gFt+8Zk
	O050553vD46XlNKmnKf6diN1AoZpn3ixAk1PGQ3yMUZa0ZEZVhN+eW2CnHCf0GhA
	Wt6Jb+OtFGPh6QzZSBDurbovq31wtIskbBvU1prsPp4DNvqlG1gx91n5mM5rkd1f
	2EkuN/qJALMpfOT7LqnqAKE5sv7e4858xewZ/6mqeWbrLm6oV/A32HTy1AXPH0Ji
	9G0OTNheJyymH9HzLGnSw==
X-ME-Sender: <xms:VV5CZmIWkXZDgIFChZayntBIrvzMDgxQ4rEnx8BNBsKGaRcIdVue3A>
    <xme:VV5CZuKvMLzEH3ChMsBy6lLcakUMLLmCx-L5TbHqaVY6i_KEnvX5Zm5Jfmt23pOu8
    Tv-xhEMtfn4nq7KOw>
X-ME-Received: <xmr:VV5CZmtHePZuB9zjew2UMdXYbDdCTTWkJD0E6WhYwG0saIek1NEZJGUgUnheIG9REfPBaI-NEokjy1VTloX_weLLFwi4oEewguQZWar1ItnW_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduie
    ekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:VV5CZrb25-YhldYWaDRJBzW7EjxBiwl3EnF_AtDaPThKmiOZgVMY1g>
    <xmx:VV5CZtZTdzhf0f1TkcGkA_mazeosdrsIZd_gpqFkWLTX4sqqOGAbTA>
    <xmx:VV5CZnCST56t9RHyd5oCRA3tPoEV077dGIdnLGPGRClD0L0kG1Z4SA>
    <xmx:VV5CZjaLT3f1Wdq8NUJ5DN3AEKb6ZrI8Uyv5Pg6WNa1dXiRx6Ct3_w>
    <xmx:VV5CZnZmieGZovbDVJ5OrlCNEizOjLEksltMrHwN5bHIM2_Nt95LGj_G>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 14:39:16 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: ast@kernel.org,
	daniel@iogearbox.net,
	qmo@kernel.org,
	andrii@kernel.org,
	olsajiri@gmail.com,
	quentin@isovalent.com,
	alan.maguire@oracle.com,
	acme@kernel.org,
	eddyz87@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 2/2] bpftool: Support dumping kfunc prototypes from BTF
Date: Mon, 13 May 2024 12:38:59 -0600
Message-ID: <6b16417c2c05019e83e420240c6d9796f9324a6c.1715625447.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1715625447.git.dxu@dxuuu.xyz>
References: <cover.1715625447.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch enables dumping kfunc prototypes from bpftool. This is useful
b/c with this patch, end users will no longer have to manually define
kfunc prototypes. For the kernel tree, this also means we can optionally
drop kfunc prototypes from:

        tools/testing/selftests/bpf/bpf_kfuncs.h
        tools/testing/selftests/bpf/bpf_experimental.h

Example usage:

        $ make PAHOLE=/home/dxu/dev/pahole/build/pahole -j30 vmlinux

        $ ./tools/bpf/bpftool/bpftool btf dump file ./vmlinux format c | rg "__ksym;" | head -3
        extern void cgroup_rstat_updated(struct cgroup *cgrp, int cpu) __weak __ksym;
        extern void cgroup_rstat_flush(struct cgroup *cgrp) __weak __ksym;
        extern struct bpf_key *bpf_lookup_user_key(u32 serial, u64 flags) __weak __ksym;

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/bpf/bpftool/btf.c | 54 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 91fcb75babe3..884af6589f0d 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -20,6 +20,8 @@
 #include "json_writer.h"
 #include "main.h"
 
+#define KFUNC_DECL_TAG		"bpf_kfunc"
+
 static const char * const btf_kind_str[NR_BTF_KINDS] = {
 	[BTF_KIND_UNKN]		= "UNKNOWN",
 	[BTF_KIND_INT]		= "INT",
@@ -454,6 +456,48 @@ static int dump_btf_raw(const struct btf *btf,
 	return 0;
 }
 
+static int dump_btf_kfuncs(struct btf_dump *d, const struct btf *btf)
+{
+	LIBBPF_OPTS(btf_dump_emit_type_decl_opts, opts);
+	int cnt = btf__type_cnt(btf);
+	int i;
+
+	printf("\n/* BPF kfuncs */\n");
+
+	for (i = 1; i < cnt; i++) {
+		const struct btf_type *t = btf__type_by_id(btf, i);
+		const char *name;
+		int err;
+
+		if (!btf_is_decl_tag(t))
+			continue;
+
+		if (btf_decl_tag(t)->component_idx != -1)
+			continue;
+
+		name = btf__name_by_offset(btf, t->name_off);
+		if (strncmp(name, KFUNC_DECL_TAG, sizeof(KFUNC_DECL_TAG)))
+			continue;
+
+		t = btf__type_by_id(btf, t->type);
+		if (!btf_is_func(t))
+			continue;
+
+		printf("extern ");
+
+		opts.field_name = btf__name_by_offset(btf, t->name_off);
+		err = btf_dump__emit_type_decl(d, t->type, &opts);
+		if (err)
+			return err;
+
+		printf(" __weak __ksym;\n");
+	}
+
+	printf("\n");
+
+	return 0;
+}
+
 static void __printf(2, 0) btf_dump_printf(void *ctx,
 					   const char *fmt, va_list args)
 {
@@ -476,6 +520,12 @@ static int dump_btf_c(const struct btf *btf,
 	printf("#ifndef BPF_NO_PRESERVE_ACCESS_INDEX\n");
 	printf("#pragma clang attribute push (__attribute__((preserve_access_index)), apply_to = record)\n");
 	printf("#endif\n\n");
+	printf("#ifndef __ksym\n");
+	printf("#define __ksym __attribute__((section(\".ksyms\")))\n");
+	printf("#endif\n\n");
+	printf("#ifndef __weak\n");
+	printf("#define __weak __attribute__((weak))\n");
+	printf("#endif\n\n");
 
 	if (root_type_cnt) {
 		for (i = 0; i < root_type_cnt; i++) {
@@ -491,6 +541,10 @@ static int dump_btf_c(const struct btf *btf,
 			if (err)
 				goto done;
 		}
+
+		err = dump_btf_kfuncs(d, btf);
+		if (err)
+			goto done;
 	}
 
 	printf("#ifndef BPF_NO_PRESERVE_ACCESS_INDEX\n");
-- 
2.44.0


