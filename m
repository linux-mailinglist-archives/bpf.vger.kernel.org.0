Return-Path: <bpf+bounces-20431-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5174383E475
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 23:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D50D31F2229A
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 22:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1964B250F6;
	Fri, 26 Jan 2024 22:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brycekahle.com header.i=@brycekahle.com header.b="adqzZacz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JxkPomI0"
X-Original-To: bpf@vger.kernel.org
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E6E25545
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 22:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706306655; cv=none; b=SbF3TY/gmA78ld+QgtH6DmMnaUVPkKABIE7/17ARtJKig/0rw1yL0OSAMopX30F2WRdSEdxR26x2GXzfyEcT0bCy75ks2nunKw9KyUzREMBrPWlhtTaFv/ZHD5/GasNJy+AV3ZdrQMPSDdaNOSxqpQHnmahJBNXmWOKaBjW8Egg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706306655; c=relaxed/simple;
	bh=hP+/AcfuEXqFD2rUvU6d3CCOaSHPcIoy3cu8fGYaAW4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CMPZAt/uioYegEBiBEL9GKgDN4tho8g5VwHik5KTQhWfGZ2iH/XaA7S5xC/oG1vLXBKM8WAQrSxN7CwWw5cEUaPpSK2irs87XF8YRbp8Bj+G3yPSf2XOJWFZaV5JM1znbGrEcizzGRQcJoa4MHgxOFRJpNPA+hrjJIUW1Lvn+ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brycekahle.com; spf=pass smtp.mailfrom=brycekahle.com; dkim=pass (2048-bit key) header.d=brycekahle.com header.i=@brycekahle.com header.b=adqzZacz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JxkPomI0; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brycekahle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brycekahle.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 2F0175C038A;
	Fri, 26 Jan 2024 17:04:12 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 26 Jan 2024 17:04:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=brycekahle.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1706306652; x=1706393052; bh=4EQD7JG9Td
	0EI/dprCgxbLCs8cPGSdueENEAX0KkXHU=; b=adqzZaczk+Bvsv6OaVzqNypHCY
	dkyZEl44DGHoQstknqbC8a9L9c+2cI0N9fKb+gD7nPyoOazqf/vlxSg88ILC3ag8
	k780wPJlILAizj0wWa4b5RIyTst9L52lPmhF0USyaoUk7s3YfUtIdTzqQxy0lNC1
	BiBHa0SOq+cXCwbz8fSURfMJhjrTI+4d/uRIQWQNCfR5gyirKXvQ8cAf+Wwh9onP
	CPCm9E5pQql0wUEy/GR7JLdiS0iY7Vc4uR6z4dvj0S+r42BCzu7iPrRaXPfFe5m5
	4jNL1DzCFbxf/2otPNX5XUVKTUoQrMFt2QJh+tMOT43wz+tDAsAVLUPdxJAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706306652; x=1706393052; bh=4EQD7JG9Td0EI/dprCgxbLCs8cPG
	SdueENEAX0KkXHU=; b=JxkPomI0lL/3hsT2wfVtAFEb5oqNNi+XXOTwcmt8ZXce
	f+IbMdVVRoTop7qy5PFe/cwo19s2chhOTA/6Nevh0fMa+AAbRSrsYnHVKCN9s2tI
	26lSp7Sh/Wo1Fdd2Ijb5j//Be1wFNGKOda0+L5vubAwy+ub0FJ7Atr7KWJqaWWJq
	siZSxdzibMdY8YYXo5Y91zdgy6l2zDKG6TgLDw2z0yBcxXjF83rRhYgVaLhk1B9C
	pNQpQcxF/ZUSXGVC5WZbUivNuTEb7sSkQVyIgBIjikDTFub0ZOYBJXqPD4pTaG5H
	oUuox04/zHHlRDTRjgpeCcCNdRbPfqq7PMcqfFnP1w==
X-ME-Sender: <xms:Wyy0ZalLzpbba_CPcc13W94Xb4QyhHjkl9VKt7ZN-fnlI9dK7AyKIw>
    <xme:Wyy0ZR0pkiObZ_bl4Z0S4mC_MC6F8Wdvn6nSuthh4gKvzxOE9vKTXJD8J8_hQgwO6
    yj8mSUe6coPbGxgKbo>
X-ME-Received: <xmr:Wyy0ZYrnR3rZ7gNcho4OTGIoX5zVq3luin4PldvfqfKrmZy_-X6rPbqSytffwLtOeDqDzRTr8MfM6NNIb0LOMSyAEFcB_yY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeljedgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekre
    dtredttdenucfhrhhomhepuehrhigtvgcumfgrhhhlvgcuoehgihhtsegsrhihtggvkhgr
    hhhlvgdrtghomheqnecuggftrfgrthhtvghrnhepjeehieffteekveetheekjefhtdefle
    euhefgveefjeehjeeijefgkeegkeethfdvnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithessghrhigtvghkrghhlhgvrdgtohhm
X-ME-Proxy: <xmx:XCy0Zen9vg5JMIYl9smMpPuq1pa8IRQksiSvQ1kloI442vGWUpxiYQ>
    <xmx:XCy0ZY02gTxJhN3jTQA2HP_LqbfwpOVbMcKOzJOuebXNoG_A6spwwg>
    <xmx:XCy0ZVuE6eoePfKkLrpyxrBbrnZ2vA8yUsDJTuOrEQ-llqQ-7j0ovA>
    <xmx:XCy0ZVz6Hd1ha9PCAy7LsXItPW9_hdyuHeQ4PvANMr_hOmTIuEbClQ>
Feedback-ID: ib4b944d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jan 2024 17:04:11 -0500 (EST)
From: Bryce Kahle <git@brycekahle.com>
To: bpf@vger.kernel.org
Cc: quentin@isovalent.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	Bryce Kahle <bryce.kahle@datadoghq.com>
Subject: [PATCH bpf-next v3] bpftool: add support for split BTF to gen min_core_btf
Date: Fri, 26 Jan 2024 14:04:07 -0800
Message-Id: <20240126220407.2424-1-git@brycekahle.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bryce Kahle <bryce.kahle@datadoghq.com>

Enables a user to generate minimized kernel module BTF.

If an eBPF program probes a function within a kernel module or uses
types that come from a kernel module, split BTF is required. The split
module BTF contains only the BTF types that are unique to the module.
It will reference the base/vmlinux BTF types and always starts its type
IDs at X+1 where X is the largest type ID in the base BTF.

Minimization allows a user to ship only the types necessary to do
relocations for the program(s) in the provided eBPF object file(s). A
minimized module BTF will still not contain vmlinux BTF types, so you
should always minimize the vmlinux file first, and then minimize the
kernel module file.

Example:

bpftool gen min_core_btf vmlinux.btf vm-min.btf prog.bpf.o
bpftool -B vm-min.btf gen min_core_btf mod.btf mod-min.btf prog.bpf.o

Signed-off-by: Bryce Kahle <bryce.kahle@datadoghq.com>
---
 .../bpf/bpftool/Documentation/bpftool-gen.rst  | 18 +++++++++++++++++-
 tools/bpf/bpftool/gen.c                        | 17 ++++++++++++-----
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-gen.rst b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
index 5006e724d..e067d3b05 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-gen.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
@@ -16,7 +16,7 @@ SYNOPSIS
 
 	**bpftool** [*OPTIONS*] **gen** *COMMAND*
 
-	*OPTIONS* := { |COMMON_OPTIONS| | { **-L** | **--use-loader** } }
+	*OPTIONS* := { |COMMON_OPTIONS| | { **-B** | **--base-btf** } | { **-L** | **--use-loader** } }
 
 	*COMMAND* := { **object** | **skeleton** | **help** }
 
@@ -202,6 +202,14 @@ OPTIONS
 =======
 	.. include:: common_options.rst
 
+	-B, --base-btf *FILE*
+		  Pass a base BTF object. Base BTF objects are typically used
+		  with BTF objects for kernel modules. To avoid duplicating
+		  all kernel symbols required by modules, BTF objects for
+		  modules are "split", they are built incrementally on top of
+		  the kernel (vmlinux) BTF object. So the base BTF reference
+		  should usually point to the kernel BTF.
+
 	-L, --use-loader
 		  For skeletons, generate a "light" skeleton (also known as "loader"
 		  skeleton). A light skeleton contains a loader eBPF program. It does
@@ -444,3 +452,11 @@ ones given to min_core_btf.
   obj = bpf_object__open_file("one.bpf.o", &opts);
 
   ...
+
+Kernel module BTF may also be minimized by using the -B option:
+
+**$ bpftool -B 5.4.0-smaller.btf gen min_core_btf 5.4.0-module.btf 5.4.0-module-smaller.btf one.bpf.o**
+
+A minimized module BTF will still not contain vmlinux BTF types, so you
+should always minimize the vmlinux file first, and then minimize the
+kernel module file.
diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index ee3ce2b80..634c809a5 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -1630,6 +1630,7 @@ static int do_help(int argc, char **argv)
 		"       %1$s %2$s help\n"
 		"\n"
 		"       " HELP_SPEC_OPTIONS " |\n"
+		"                    {-B|--base-btf} |\n"
 		"                    {-L|--use-loader} }\n"
 		"",
 		bin_name, "gen");
@@ -1695,14 +1696,14 @@ btfgen_new_info(const char *targ_btf_path)
 	if (!info)
 		return NULL;
 
-	info->src_btf = btf__parse(targ_btf_path, NULL);
+	info->src_btf = btf__parse_split(targ_btf_path, base_btf);
 	if (!info->src_btf) {
 		err = -errno;
 		p_err("failed parsing '%s' BTF file: %s", targ_btf_path, strerror(errno));
 		goto err_out;
 	}
 
-	info->marked_btf = btf__parse(targ_btf_path, NULL);
+	info->marked_btf = btf__parse_split(targ_btf_path, base_btf);
 	if (!info->marked_btf) {
 		err = -errno;
 		p_err("failed parsing '%s' BTF file: %s", targ_btf_path, strerror(errno));
@@ -2141,10 +2142,16 @@ static struct btf *btfgen_get_btf(struct btfgen_info *info)
 {
 	struct btf *btf_new = NULL;
 	unsigned int *ids = NULL;
+	const struct btf *base;
 	unsigned int i, n = btf__type_cnt(info->marked_btf);
+	int start_id = 1;
 	int err = 0;
 
-	btf_new = btf__new_empty();
+	base = btf__base_btf(info->src_btf);
+	if (base)
+		start_id = btf__type_cnt(base);
+
+	btf_new = btf__new_empty_split((struct btf *)base);
 	if (!btf_new) {
 		err = -errno;
 		goto err_out;
@@ -2157,7 +2164,7 @@ static struct btf *btfgen_get_btf(struct btfgen_info *info)
 	}
 
 	/* first pass: add all marked types to btf_new and add their new ids to the ids map */
-	for (i = 1; i < n; i++) {
+	for (i = start_id; i < n; i++) {
 		const struct btf_type *cloned_type, *type;
 		const char *name;
 		int new_id;
@@ -2213,7 +2220,7 @@ static struct btf *btfgen_get_btf(struct btfgen_info *info)
 	}
 
 	/* second pass: fix up type ids */
-	for (i = 1; i < btf__type_cnt(btf_new); i++) {
+	for (i = start_id; i < btf__type_cnt(btf_new); i++) {
 		struct btf_type *btf_type = (struct btf_type *) btf__type_by_id(btf_new, i);
 
 		err = btf_type_visit_type_ids(btf_type, btfgen_remap_id, ids);
-- 
2.25.1


