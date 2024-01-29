Return-Path: <bpf+bounces-20535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D023783FBDE
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 02:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D099B20BA9
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 01:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9848FDDCA;
	Mon, 29 Jan 2024 01:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="nsqj5BWt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X5HqALCg"
X-Original-To: bpf@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F1DDDA3;
	Mon, 29 Jan 2024 01:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706492145; cv=none; b=eOTs7cp+IYhKybO7v3W1verX+YjuTLHbN4b0i7QuYA0arSlAeigvtkBtOhF31DA0otRxi6/aV0ZZFiwWOgr5G8TjXQU6CMm1OSYcD6hiJ7GRQc1v2DaJm08VE0BGgjgI4c8oRYFfHBqKWCUkdovvbDn8otuE+e3XNgXVRgwIOgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706492145; c=relaxed/simple;
	bh=yQCZgd2Qk2Ec6YweCZlpltOIdBZaVavbWfLN6OWkRiU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lJFfa2OCngWbA2nYp0KI9VE8FN3dJEqqaEeC1rzaH3jTT18WQePtSTQqJQGxeOXJqrO50xtroMme+Ywj0Y8eTJbsff9ra4gZAXRpGBBU2q6JG5PzFHZhxsmqqEJ+EjhwPaT4G/bTQcI7FBJepildg5IoWeXK+Vk7sGd8zt+R9h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=nsqj5BWt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X5HqALCg; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 1FF363200AD6;
	Sun, 28 Jan 2024 20:35:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 28 Jan 2024 20:35:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1706492140; x=1706578540; bh=5RrKBen3ecUT2+C45mc1O
	UnV/0DQQEavRCRaQ5MXjHQ=; b=nsqj5BWtwzLtl9xZVg2Y3BT9cGbU8FC4DucY5
	qGnEEvenumapdnYGt6rz08KnHZSB3zjc/GEg+k/s/4ab21IgFuA4PqmwLnIlA1WB
	FVQs89Xa9/mCO7lfCkNNbFoawwaP33SYELx5+yrQgQL81W3usVi5Q/GMCXNI3Bh2
	9EZJ10zs5aI6bn3I7XWmc5x0e9SnuDNzzukPkJNsbTYbEOAxcCqQxdUrhyCXOPnl
	zYhkaaQ14uz1QikEYU79BHeV0y++pXzuMh1eCqvWpKHOASYA0m9Y6DifmiOlyd6K
	jKC+LHQ2I6nKitoHimknMezjc0xA/HuVrADC13vapdl1Tdjgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706492140; x=1706578540; bh=5RrKBen3ecUT2+C45mc1OUnV/0DQ
	QEavRCRaQ5MXjHQ=; b=X5HqALCgvahJvOxjpUnvkMICjskxvs8hxQsSq2pPSDKT
	s8GQzaNjUUK73zJsRs0Jv6UR+mAYj2UIoRxHEf6vNeEunbpSpsDjR3OOi/37v93N
	bWi9lWrT33I6WNP6AWbN2Vakp+9lIA1TpLLJNY0ydFHYY88ypGjA5xe2Sfdop1dg
	ZePx5xasGBG72W50DJ6RFWFB/gGWKchgS1m+LCBz7VNl03CswWI5VNeZdL1OiaX+
	yNI9l0S3VLAShTy+Md6JKeqhCVQFtCroo8XlTe74xAEpvE1fNTpO0Uzu3Bjw3/kF
	RgaoKAeCcUBZc+d1kUIn2kWswwUYDLd3IUY88xykyQ==
X-ME-Sender: <xms:7AC3ZX45QlXnKNK7XZYaKJJ5lvIih-KEnlTBV4BU-ReoEeWxi32PEw>
    <xme:7AC3Zc7K91ieBGSCllYwihonmnSP3IzEJxb37O6fSwVA2puoQuvS0b13sW-pVYYaP
    maOoAh1GISEH4jZ2A>
X-ME-Received: <xmr:7AC3ZefF_hI22x645wSgFufJVflschG-ZCP59yYr2hIxGwTBf3SagL0CLb011s79usRSfbw6MWDna3EB9q16LDAdDJnY0NOrqBaSaRCciFRDSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtfedgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvf
    evufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougig
    uhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepteeukedtuefhfeevgffgve
    egfffgkeefhfekkeetffehvedtvdehudekheffledtnecuffhomhgrihhnpehkvghrnhgv
    lhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:7AC3ZYI5HwQKrAUTwOOL_XMGaud7gcPP51Ib_G4v83RnU_Lste7GUA>
    <xmx:7AC3ZbIMEssWT3yYhTz2XM8S2KECOOOnV1YI2_reNX4-g8H7slftKA>
    <xmx:7AC3ZRzwFT8bHJxprn3YsG1AAJjbE01k6MP-vAfbYjqhYf-em4sUDA>
    <xmx:7AC3ZQdOHUXJoME2q0z3Hn7zFHytPFw9tsEXI9T4AVnBzWkn5I_3Bg>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Jan 2024 20:35:38 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: quentin@isovalent.com,
	daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	olsajiri@gmail.com,
	alan.maguire@oracle.com,
	memxor@gmail.com
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
Subject: [PATCH bpf-next] bpftool: Support dumping kfunc prototypes from BTF
Date: Sun, 28 Jan 2024 18:35:33 -0700
Message-ID: <373d86f4c26c0ebf5046b6627c8988fa75ea7a1d.1706492080.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
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
        extern void cgroup_rstat_updated(struct cgroup * cgrp, int cpu) __ksym;
        extern void cgroup_rstat_flush(struct cgroup * cgrp) __ksym;
        extern struct bpf_key * bpf_lookup_user_key(u32 serial, u64 flags) __ksym;

Note that this patch is only effective after enabling pahole [0]
and kernel [1] changes are merged.

[0]: https://lore.kernel.org/bpf/0f25134ec999e368478c4ca993b3b729c2a03383.1706491733.git.dxu@dxuuu.xyz/
[1]: https://lore.kernel.org/bpf/cover.1706491398.git.dxu@dxuuu.xyz/

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/bpf/bpftool/btf.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 91fcb75babe3..9ab26ed12733 100644
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
@@ -454,6 +456,28 @@ static int dump_btf_raw(const struct btf *btf,
 	return 0;
 }
 
+static void dump_btf_kfuncs(const struct btf *btf)
+{
+	int cnt = btf__type_cnt(btf);
+	int i;
+
+	for (i = 1; i < cnt; i++) {
+		const struct btf_type *t = btf__type_by_id(btf, i);
+		char kfunc_sig[1024];
+		const char *name;
+
+		if (!btf_is_decl_tag(t))
+			continue;
+
+		name = btf__name_by_offset(btf, t->name_off);
+		if (strncmp(name, KFUNC_DECL_TAG, sizeof(KFUNC_DECL_TAG)))
+			continue;
+
+		btf_dumper_type_only(btf, t->type, kfunc_sig, sizeof(kfunc_sig));
+		printf("extern %s __ksym;\n\n", kfunc_sig);
+	}
+}
+
 static void __printf(2, 0) btf_dump_printf(void *ctx,
 					   const char *fmt, va_list args)
 {
@@ -476,6 +500,9 @@ static int dump_btf_c(const struct btf *btf,
 	printf("#ifndef BPF_NO_PRESERVE_ACCESS_INDEX\n");
 	printf("#pragma clang attribute push (__attribute__((preserve_access_index)), apply_to = record)\n");
 	printf("#endif\n\n");
+	printf("#ifndef __ksym\n");
+	printf("#define __ksym __attribute__((section(\".ksyms\")))\n");
+	printf("#endif\n\n");
 
 	if (root_type_cnt) {
 		for (i = 0; i < root_type_cnt; i++) {
@@ -491,6 +518,8 @@ static int dump_btf_c(const struct btf *btf,
 			if (err)
 				goto done;
 		}
+
+		dump_btf_kfuncs(btf);
 	}
 
 	printf("#ifndef BPF_NO_PRESERVE_ACCESS_INDEX\n");
-- 
2.42.1


