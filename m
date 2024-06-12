Return-Path: <bpf+bounces-31955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A3790580D
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 18:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A034B269F7
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 16:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547DA176FA4;
	Wed, 12 Jun 2024 15:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="KJ9cHO8k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ecTm8V3J"
X-Original-To: bpf@vger.kernel.org
Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E0E1850AE;
	Wed, 12 Jun 2024 15:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718207982; cv=none; b=MVDZojRgprEASmalAyxhTiByg224nlyGG+MEuM533tB/uunfW2ZUd6NXJJ/CGnUjTkRemGR3mplsznAF5NQ5/9xRkFP2R1ma28yHeAquUUbdzCfL7/ozBtuycmUeGKdxjyEolivRFURBw2GRFSEX9D+zg2ZejSPU4GK0RfevkB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718207982; c=relaxed/simple;
	bh=6au7MrpBu+3ErejQVoP0KkTLYnpWyNJm4OKAyEDW7OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j8nAa+D2i2UhxdfE4EJE0uGAo1QN/AbXs1uraJcOff90l90sj3XKqcj8oWWIVVJXHdFFCXDwyrjIpJfL5VCdeGT55Oy+PUkohgqcgaC6VE/XW2ekuEAiZxwCzllKtVTXi+9eIGKwRIDCrusfDlJhukkXBnUI7SlvzxaCJyg0MK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=KJ9cHO8k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ecTm8V3J; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 547F51800084;
	Wed, 12 Jun 2024 11:59:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 12 Jun 2024 11:59:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1718207978; x=
	1718294378; bh=mh+C4m8zbjflVRUrybyCTLThOPeoG/8/+kC3qdHEVEE=; b=K
	J9cHO8kP2w/4Eo9OdJHwWgHu1ArVgmL94PBwKoXzlMuCr/vCm0O2frdKUeB1FwDQ
	wMiuYFyy/AG68vVXxY8woD6gpbJibjvsdqmHKxDURMJOexzvyh/RFNVRXLSqbQOT
	sJeLR8YvQHYZm8C5HBHxFQ28Y/DwfPz30i2fumLU5USlPGucG4l82DR7DNkp+hxV
	fpwYl+zy+Q/udQhmFPJSR5EhyYYVDdWojFHAvwctKA7iW2TbbPdaTwrDo+jRCI0W
	stHm/f6wIZWQ3n7Z6z6CXCucuwstfytjnha/Dormt+xkL6+9S1fAAueOo+5BcBmK
	ZyeQolSK8x7HaCia8nj7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718207978; x=
	1718294378; bh=mh+C4m8zbjflVRUrybyCTLThOPeoG/8/+kC3qdHEVEE=; b=e
	cTm8V3JlpSTqAYhiZFD5KDeM3T+O23QOR95AeD20YW0NbiHYkw57UWbl7EhFGLR4
	7CWBFhlMetld64SicYEdhlxoxg1izWJxOI+ZzJ9Nkm4KISqapMDp8h9KE+zmF3vU
	WeEUttAQWD9Rz0+PnrmSm1U/Yfqcv8KHvVg1EGa+zZYiM3MY020cJPIY+w13H0y2
	jGP74eBGxZ6CTf9Xj0EYilacwrYHUmGbcla+R3STK1NNOypx0fctaD8jEa5HIKFd
	/Pl7Ir22Q1z904qItZDUiA9lIEXu7CLE4Qw/dhOH1pjc4Gz6rJLTdrWv+3G+raK6
	SnVsGOo1sNZ2WW5ENqyXw==
X-ME-Sender: <xms:6sVpZkhhxJyI0XKPXmWwCgQRqDZ8YE-sHSM8mZdAyvkcC-jCBaMUxw>
    <xme:6sVpZtA3WpWJPH2ICYJQOzK8IaQwP8CQ6XNFqvaLvQ1LKo_g6-21JEzarvPqb8_mR
    B-qjhcBAGTdeZk0nQ>
X-ME-Received: <xmr:6sVpZsH7rnCTRK0-lf1l1TVmI2nPLHr724y6pBJ114y3ef8IKN-0LkLUiMraW1bjtNKoe_5e0DSjcYrHXcjjNyx6IrXOZhWylPFMgK9k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedugedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgepvdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:6sVpZlQDgOlXzYHeDJ2dWlZvTuMCMq6a2e0XfUV0775OaPlkQdTxIw>
    <xmx:6sVpZhynMpQFoFcBN2PJkfaFpviVOKF6bSktppqXWNEiJ_U2Zd1REg>
    <xmx:6sVpZj7ranKgMygbAXztxjCAsHTvhqr-bjtPeijkukRi_K7JkC7Prg>
    <xmx:6sVpZuxupdrycWHSoqXi11neOGqp7LYRXsN31DtqaniHwZbHMoNGbw>
    <xmx:6sVpZmzUMdFbPCJMbik2s78xgnP2fVCfqUgJDObVC25hNHVNegiPWMvf>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jun 2024 11:59:37 -0400 (EDT)
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
Subject: [PATCH bpf-next v5 12/12] bpftool: Support dumping kfunc prototypes from BTF
Date: Wed, 12 Jun 2024 09:58:36 -0600
Message-ID: <bf6c08f9263c4bd9d10a717de95199d766a13f61.1718207789.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1718207789.git.dxu@dxuuu.xyz>
References: <cover.1718207789.git.dxu@dxuuu.xyz>
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
 tools/bpf/bpftool/btf.c | 55 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index af047dedde38..6789c7a4d5ca 100644
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
@@ -461,6 +463,49 @@ static int dump_btf_raw(const struct btf *btf,
 	return 0;
 }
 
+static int dump_btf_kfuncs(struct btf_dump *d, const struct btf *btf)
+{
+	LIBBPF_OPTS(btf_dump_emit_type_decl_opts, opts);
+	int cnt = btf__type_cnt(btf);
+	int i;
+
+	printf("\n/* BPF kfuncs */\n");
+	printf("#ifndef BPF_NO_KFUNC_PROTOTYPES\n");
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
+	printf("#endif\n\n");
+
+	return 0;
+}
+
 static void __printf(2, 0) btf_dump_printf(void *ctx,
 					   const char *fmt, va_list args)
 {
@@ -596,6 +641,12 @@ static int dump_btf_c(const struct btf *btf,
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
@@ -615,6 +666,10 @@ static int dump_btf_c(const struct btf *btf,
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


