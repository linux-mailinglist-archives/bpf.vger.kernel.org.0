Return-Path: <bpf+bounces-31669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0509013A4
	for <lists+bpf@lfdr.de>; Sat,  8 Jun 2024 23:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F6241F21C54
	for <lists+bpf@lfdr.de>; Sat,  8 Jun 2024 21:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2BC84DE7;
	Sat,  8 Jun 2024 21:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="WuBB9Y7F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R7sjC7lx"
X-Original-To: bpf@vger.kernel.org
Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BFE7F48A;
	Sat,  8 Jun 2024 21:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717881431; cv=none; b=hQ+ZrpMZAiBVOVzPGWDElERF+dM4DJ8KjdNxBQ/EVjHDR0NywOEmKiRiDBfLvhJ7IQqsGTJrjFooykhT2DF0qeAvOV155vpvyBo6+JFcvOPT39ZBCjnvP2SaFpds5pT9U+ktzngJ/v5/qTKsv0UM1/YFpsGYgoZT7VXu0ZmGQBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717881431; c=relaxed/simple;
	bh=6au7MrpBu+3ErejQVoP0KkTLYnpWyNJm4OKAyEDW7OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JJUjDdnNwBlV1QBkSARy6Zn+x4JIHiAXCtOEheZZkx8+XT7DL/L8Iw5tHhp7DR442ZJf5NcAu9ZBNwfZsTekSdqk3wxRr52uKX5qp2sHcj760My1vGaPg5P7G8fpM/vJHCwJCSWFjw8M7xGLRiOr2mmzaDaCSrqkIvvPNH7wtUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=WuBB9Y7F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R7sjC7lx; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 6061E1C000AA;
	Sat,  8 Jun 2024 17:17:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 08 Jun 2024 17:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1717881427; x=
	1717967827; bh=mh+C4m8zbjflVRUrybyCTLThOPeoG/8/+kC3qdHEVEE=; b=W
	uBB9Y7FYg2TsNitZUzgB3sx7Vfqx3QQanUHl+EC8U3d0rtv+QqpIfYUSy6b3pe1h
	Coif7LyLQbMy77PdQHw4OmH288qGQAGNHjczl7/g3IF8+XVQ2swdEB9zGNXeRJLa
	bUDllyD/eafZa8YT+cewkpBHTXOTw1AKABwLb7jrua1HmwPfsvNmp+jOQioutsMU
	CXaT2pdRLnh3NAexomy32oWy9FXyihmWhunvPhpdKVR8CN5HmatuzFY+5vnnjBjK
	9tE0b0PgjGUNQifCr0Wnb/Ump7NtHAxHog6S9Iayz1nkktQVwMMSZCwntkMtEmUk
	C7hlbmcpoTQxqand4I0Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717881427; x=
	1717967827; bh=mh+C4m8zbjflVRUrybyCTLThOPeoG/8/+kC3qdHEVEE=; b=R
	7sjC7lxLxt5usQzHZxlbqAANKgr1NiBssYpZXNgSoTuXfxDz8yxLFst4f9aJ+yWA
	EUuXFpn9PnI1cgJZa47ecM6kc8/tS87/BmulyXxvNDdavL8v5A2FbH2kIaf/8FZt
	Zip8FrVi91vhB1/J1hoQHY6lbeZ5/ywm2Yivmqi7HJoso+SxNjPcTxOn3zqUmS/O
	Hh35+PjOfn6/mOLoyAtpjhWXKVKaX342GWV8jmTIY95EVTc5lXKjkkoydd62g3HL
	HAdmH5ey2RBqmNPlHZtELenDhusE6TVCDig7ik1q1T53ga38Xyh0lm/ymevPNoLL
	Y9RqC+AMXoHhRWT8VuGwQ==
X-ME-Sender: <xms:UspkZpro0FNUMcu1RqTi8IGU3P30a-Q3cDY5YIuXuLubbYqRO20ujg>
    <xme:UspkZrqB26Iegeffe5kZeZt9Y9or0nYbTJAhNXgg_t6IMkMvcgnjz5rz9I4haJfsL
    Pu9jXrEnRjinm5k6Q>
X-ME-Received: <xmr:UspkZmOw22gEguo1Hm9dAP9K9TYqRrk2ZJ7zswlMQes3akYuvFkRcIPewzqSaKXZr_iwNgeTqVowjO2FNmORcSaOxPgHkEleIGwp0d6U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtgedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:UspkZk54KsC7ZxXF7sDUeWisRKRMJdw5Lu8CtWWvzN5fUg6t1dgbPw>
    <xmx:UspkZo4RV8KXnGcmvO4yTBauhK5a_5F4y1Zx3aUWjt6SaWL_-8Wkyg>
    <xmx:UspkZsippsyRV25sfmPoPWqdm0TWEV6Nrlh9nfbSccmtua1E6u8zDw>
    <xmx:UspkZq6LfUYawy3vKTyNbQLkl0F0AVKgYlzL2FYEX7p4oZHziPJWFw>
    <xmx:U8pkZu7LzqkUVFgY8EVhfcCoE2cq1QaZTp6pWCLlYlGO30lpzYc3bsy8>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 8 Jun 2024 17:17:05 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: qmo@kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
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
Subject: [PATCH bpf-next v4 12/12] bpftool: Support dumping kfunc prototypes from BTF
Date: Sat,  8 Jun 2024 15:16:08 -0600
Message-ID: <3239f6e074620ba61e9cb180d2f44420d142c182.1717881178.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1717881178.git.dxu@dxuuu.xyz>
References: <cover.1717881178.git.dxu@dxuuu.xyz>
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


