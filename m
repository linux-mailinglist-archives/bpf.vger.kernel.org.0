Return-Path: <bpf+bounces-21170-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AD1849090
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 22:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 506BA1F228B8
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 21:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59530339BD;
	Sun,  4 Feb 2024 21:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="gtQxJm4k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vJZe1EsH"
X-Original-To: bpf@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27D532C9C;
	Sun,  4 Feb 2024 21:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707080821; cv=none; b=R7crLjqtx/396ByLciCf9D0Iu3D4np3LlRTD7VRbXqWpU6mZB1wllRy6c2seQ6n2zyGsD7JpnLObHo4aY3jnAHgetW0tI7nAfFe4Rsp0G8nkRjtz1lZbhfc5N9lxJe6ZZY49lbHw74WSdlgbsOaMMmI7BIgDN3Nzh1WW68rE7OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707080821; c=relaxed/simple;
	bh=YAsD/PAFWTIjhY4PrFZj7zLRMfr6sUXw/riMUTifiN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VFJ2vHGZgmtqYBfV8Bfaq6bZeFjNZsGowdHUWxh/JyixAnwfUTTFc9l8pDYK/CnVhxMb7wYJiG46YQN5QnoSsYBLuYRz/UOP31xIa6eMOe2SoC7Bh5UBS7t+q6MYNrHc9BBJIkOwjG83nVWe/73hPnbcuqVN8NamoV1tHSwEXxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=gtQxJm4k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vJZe1EsH; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 3A5423200A0A;
	Sun,  4 Feb 2024 16:06:56 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Sun, 04 Feb 2024 16:06:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1707080815; x=
	1707167215; bh=EFrOfStAu11VQIYVVSfiFO1xvDu+gV2R6+8jhfL5s5o=; b=g
	tQxJm4k0Sj763PETXN1Uzl2sXs2LMt+C+Vr98PxiG8kb4V6crVeuT0VD2tJC4GBk
	4aMdpZCArNVmFAHLOkoLMFCpexMdu7Z+5lCKhgfof1N9gLUNURVxXDerMxtMg4Tj
	tDwQ6iF++PEu6fEq9BsgKhrGn2h5HE9AmonRp42Wvtcfw7kiagSGP3iA+uIabYzt
	dKkEm3Ge7FA3IsHyhCvSwiJmaWasoFed3f9slCAy14GnONlolJxwz+wQjpEie0+J
	RLq7e4OS6RUg+D7Pyqysrw39wGyeTKVEBx5IcbPPNL+6p7QtON++uqKuZ1HM5gZ/
	aEj4CMFnoMa+F+uhjSGYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707080815; x=
	1707167215; bh=EFrOfStAu11VQIYVVSfiFO1xvDu+gV2R6+8jhfL5s5o=; b=v
	JZe1EsHKEPtaQ+cteY2V62aWGtSKOYBPH3vVtv93WFUt3z6RfxmkTz7Asv8pKy+3
	LBVZA2uRhZnzSH0xrTLWeL4GlT+RgKj0TIDHQcaPxIntAeBBJYllBXUixL2IrbfT
	Z2IJSf4sgyOf8CyJc3FM5Vb2GDJGpSoNgqQira/JSm4JL665ULVi4rVq8/bK23f+
	/PjDNwl19q8uTn6adHjJj2jdG82xP/AsIZGBUJy8pgUhYgMv/iiNJdAFmnLcKZCa
	4NH7RksWyE3NFs9Katt4gSmZxhp1AjzVfELJ28AlPO//NasIbfoeWhXPWYmHxu9p
	sLXeJ0ZqKiopGr9MQIsUA==
X-ME-Sender: <xms:b_y_ZQIArogJs48sibfel0f2VPWXnTUVEazCIuAP1HfBTuxh_mcFkA>
    <xme:b_y_ZQLp5YudTFi_Xf21UB53O2PzOyfggUzNWxQ4N1k_LMW7oo4IqNKB4sO7fX5lz
    KUG6zRC_ZOvhlw2_w>
X-ME-Received: <xmr:b_y_ZQtadKFe3c0oIaRKxrfl7OWCruWZqixA3ZCi_7v7j3VVpjoXmTWT2KMvnkqBnQ9xgmD-ts7R_joREdBsFg2ypx9ng5wAOhstTOBDvXBwoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedukedgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeelieduhefhteffie
    dutdejgfdutdekudelueelveekjeeitdefueeutdelhedvfeenucffohhmrghinhepkhgv
    rhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:b_y_ZdakdxiqjAt-sSjUi32LilLIgalL0XgNC5EzOU-b3Gt3-Kg74A>
    <xmx:b_y_ZXY3la5q8ln4CPYcss_Tq4etDlNI-1y9cFprxRLTnlU3ZE7r9A>
    <xmx:b_y_ZZA9C1vbAhdgHHtgyEvprHooJFvAZZjqE-ieWCMDghfN455AzQ>
    <xmx:b_y_ZYK9bRDGWnj2O0yEUlKUzU_ygaX04SzgtYGI2fBpyK63KTxnpA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Feb 2024 16:06:53 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: quentin@isovalent.com,
	daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	olsajiri@gmail.com,
	alan.maguire@oracle.com
Cc: martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 2/2] bpftool: Support dumping kfunc prototypes from BTF
Date: Sun,  4 Feb 2024 14:06:35 -0700
Message-ID: <9b8ebd13300e28bd92a2e6de4fb04f85c1b6ce7c.1707080349.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1707080349.git.dxu@dxuuu.xyz>
References: <cover.1707080349.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch enables dumping kfunc prototypes from bpftool. This is useful
b/c with this patch, end users will no longer have to manually define
kfunc prototypes. For the kernel tree, this also means we can drop
kfunc prototypes from:

        tools/testing/selftests/bpf/bpf_kfuncs.h
        tools/testing/selftests/bpf/bpf_experimental.h

Example usage:

        $ make PAHOLE=/home/dxu/dev/pahole/build/pahole -j30 vmlinux

        $ ./tools/bpf/bpftool/bpftool btf dump file ./vmlinux format c | rg "__ksym;" | head -3
        extern void cgroup_rstat_updated(struct cgroup *cgrp, int cpu) __weak __ksym;
        extern void cgroup_rstat_flush(struct cgroup *cgrp) __weak __ksym;
        extern struct bpf_key *bpf_lookup_user_key(u32 serial, u64 flags) __weak __ksym;

Note that this patch is only effective after the enabling pahole [0]
change is merged and the resulting feature enabled with
--btf_features=decl_tag_kfuncs.

[0]: https://lore.kernel.org/bpf/cover.1707071969.git.dxu@dxuuu.xyz/

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/bpf/bpftool/btf.c | 45 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 91fcb75babe3..0fd78a476286 100644
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
@@ -454,6 +456,39 @@ static int dump_btf_raw(const struct btf *btf,
 	return 0;
 }
 
+static int dump_btf_kfuncs(struct btf_dump *d, const struct btf *btf)
+{
+	DECLARE_LIBBPF_OPTS(btf_dump_emit_type_decl_opts, opts);
+	int cnt = btf__type_cnt(btf);
+	int i;
+
+	for (i = 1; i < cnt; i++) {
+		const struct btf_type *t = btf__type_by_id(btf, i);
+		const struct btf_type *kft;
+		const char *name;
+		int err;
+
+		if (!btf_is_decl_tag(t))
+			continue;
+
+		name = btf__name_by_offset(btf, t->name_off);
+		if (strncmp(name, KFUNC_DECL_TAG, sizeof(KFUNC_DECL_TAG)))
+			continue;
+
+		printf("extern ");
+
+		kft = btf__type_by_id(btf, t->type);
+		opts.field_name = btf__name_by_offset(btf, kft->name_off);
+		err = btf_dump__emit_type_decl(d, kft->type, &opts);
+		if (err)
+			return err;
+
+		printf(" __weak __ksym;\n\n");
+	}
+
+	return 0;
+}
+
 static void __printf(2, 0) btf_dump_printf(void *ctx,
 					   const char *fmt, va_list args)
 {
@@ -476,6 +511,12 @@ static int dump_btf_c(const struct btf *btf,
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
@@ -491,6 +532,10 @@ static int dump_btf_c(const struct btf *btf,
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
2.42.1


