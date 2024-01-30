Return-Path: <bpf+bounces-20781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EDA8430D5
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 00:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A67721C24100
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 23:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF537EF11;
	Tue, 30 Jan 2024 23:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brycekahle.com header.i=@brycekahle.com header.b="Lrsdb/Um";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kK/1LNuJ"
X-Original-To: bpf@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2FC14F61
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 23:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706655928; cv=none; b=GXzAGLKvxqkar6j6byPGeuYfFYxBUfiXWFpnn2B04d+yTZ9JKGpbV/saSQBIivPQDQopIMDF3ycbAjmNaB46ss2UqK3t5BVNEmE8497S2licCrwIkmz/tu4pk4/62ooey1xWKbocFoPII4SmsIHtj/mTgxcVRbWIj7Cc+g6sZu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706655928; c=relaxed/simple;
	bh=3wj8nkn3SiBiV11AJ5tE1YWwRKoWoacyqgXRQq15HlY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uPIbHelWHXoGrZEDNRRyT9CMS/FVQZck1b2lXk9Nl5dsK4cOi0n9V/PPvF96u36QUVb+DTZ2Ydn8vK1MLdy0fkpD8Tq+u4X0RAEtSmR/JVSeKZGsrtOjWCoYQBMRMh1O9wKu+DEA85UvAnqVFx8/zv3xIDPrIn4LvDPzulv3ueI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brycekahle.com; spf=pass smtp.mailfrom=brycekahle.com; dkim=pass (2048-bit key) header.d=brycekahle.com header.i=@brycekahle.com header.b=Lrsdb/Um; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kK/1LNuJ; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brycekahle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brycekahle.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id A14AF3200392;
	Tue, 30 Jan 2024 18:05:24 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 30 Jan 2024 18:05:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=brycekahle.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1706655924; x=1706742324; bh=FKlYA3R5+9
	lN/SmRuAz/R24nKnlH1jp86ZveswD+/2Q=; b=Lrsdb/Umvs39Eo/D1zdvbv+5ln
	OelPU/DSuvA2+jlL5+Yf7g4TZiYwZMV8gCggkkVGqpNJNeWzrY4MMvgLIkUKfSwx
	+8MrjQ12OMWxnv3Nl5IoiRgMLubmwVTKM32hRLwQm8akofSrOMPCvSMrqpPuZERw
	zfSjEO1Glusq2K3wfc5AxTA8DDnrqao2gmF6aP1CAR8NgyRdiT8KnBHO978xSPhv
	PCq35Tz83kMWbr5/qofJm8ymw1V4qV43tTXwu/OeWRaGG+pA8KevcwmGc24ux34j
	9z7PdgfEK4Ta9fw7hTMUbC9yOwSIP7vGR4aL6VwCzCfh7/QJ5YCupLYrYHJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706655924; x=1706742324; bh=FKlYA3R5+9lN/SmRuAz/R24nKnlH
	1jp86ZveswD+/2Q=; b=kK/1LNuJ5xDWemccrp0uwZf3bzmQGhvv2O/dzAU+ckVe
	B3VxtC1m97SvFFvpz+7VNbjVvnN+1yB9MDOoLMqYd2KPzK/VQU42BTbSlUVc16GL
	S4SgUNl0adBxcQ/PPGmRJjnW9YUdMIPiHKI2O8AML5OvHvkT9cQA5SCGLK2HobYg
	YCHV4WEWOaviIvbDxatcPflRfCVL9Aoc5HqTPvh80FXfrj49r31AqsKBoH0bhoQh
	C5A3V4qhKFFtmGjmKTEzmNpxBDy3WVOJRkS+QRaDhtoq8tzaK5SM4+CTJEB8jUsl
	9baxgA/IOJ6zQEEqJR5RZPEH17Ro2SL5hJWPVRgxnA==
X-ME-Sender: <xms:s4C5ZZV_LfUhBN4HlYB4H7Fg_vGX1Ir8O3M94sOk60b5tioYdp06tg>
    <xme:s4C5ZZlMUWDR5iN_RzZitW1p1RxYnfmlTICbkZcCOxaffmujYD74NWNds91Z019Se
    4I-RsMADBj9Qs2qkhs>
X-ME-Received: <xmr:s4C5ZVZr208HvA1hjsKHbd4DjmoDjfNEmCI8Bcy1NHi3VuoKrI3a_gPdDXcGQ3g0PfXm_wNsTE7ui-WC_XKP7Zn98pMJRHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtkedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeeurhihtggvucfmrghhlhgvuceoghhithessghrhigtvghkrghh
    lhgvrdgtohhmqeenucggtffrrghtthgvrhhnpeejheeiffetkeevteehkeejhfdtfeelue
    ehgfevfeejheejieejgfekgeektefhvdenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehgihhtsegsrhihtggvkhgrhhhlvgdrtghomh
X-ME-Proxy: <xmx:s4C5ZcVjB--bwntuP3zHe3bJIAEsV3hC4N1Po-n4Qb9oPrH-8eSS_A>
    <xmx:s4C5ZTk9qHV8oFZHpBwR2uQZVxZUa5gEfqVVgu9DrZvsu7R8_MB0kw>
    <xmx:s4C5ZZfjFZ9kS8erVsaVwZTYEKR2bv63EiouuhQVCdMS3bnLpKu3Mg>
    <xmx:tIC5ZRiFqK3KgJCjK_CPZeVfjMkflNRrAbYjPKUcjHKKCYxQIjERfQ>
Feedback-ID: ib4b944d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jan 2024 18:05:22 -0500 (EST)
From: Bryce Kahle <git@brycekahle.com>
To: bpf@vger.kernel.org
Cc: quentin@isovalent.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	Bryce Kahle <bryce.kahle@datadoghq.com>
Subject: [PATCH bpf-next v4] bpftool: add support for split BTF to gen min_core_btf
Date: Tue, 30 Jan 2024 15:05:10 -0800
Message-Id: <20240130230510.791-1-git@brycekahle.com>
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

v3->v4:
- address style nit about start_id initialization
- rename base to src_base_btf (base_btf is a global var)
- copy src_base_btf so new BTF is not modifying original vmlinux BTF

Signed-off-by: Bryce Kahle <bryce.kahle@datadoghq.com>
---
 .../bpf/bpftool/Documentation/bpftool-gen.rst | 18 ++++++++++-
 tools/bpf/bpftool/gen.c                       | 32 +++++++++++++++----
 2 files changed, 42 insertions(+), 8 deletions(-)

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
index ee3ce2b80..57691f766 100644
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
@@ -2139,12 +2140,29 @@ static int btfgen_remap_id(__u32 *type_id, void *ctx)
 /* Generate BTF from relocation information previously recorded */
 static struct btf *btfgen_get_btf(struct btfgen_info *info)
 {
-	struct btf *btf_new = NULL;
+	struct btf *btf_new = NULL, *src_base_btf_new = NULL;
 	unsigned int *ids = NULL;
+	const struct btf *src_base_btf;
 	unsigned int i, n = btf__type_cnt(info->marked_btf);
-	int err = 0;
+	int start_id, err = 0;
+
+	src_base_btf = btf__base_btf(info->src_btf);
+	start_id = src_base_btf ? btf__type_cnt(src_base_btf) : 1;
 
-	btf_new = btf__new_empty();
+	/* clone BTF to sanitize a copy and leave the original intact */
+	if (src_base_btf) {
+		const void *raw_data;
+		__u32 sz;
+
+		raw_data = btf__raw_data(src_base_btf, &sz);
+		src_base_btf_new = btf__new(raw_data, sz);
+		if (!src_base_btf_new) {
+			err = -errno;
+			goto err_out;
+		}
+	}
+
+	btf_new = btf__new_empty_split(src_base_btf_new);
 	if (!btf_new) {
 		err = -errno;
 		goto err_out;
@@ -2157,7 +2175,7 @@ static struct btf *btfgen_get_btf(struct btfgen_info *info)
 	}
 
 	/* first pass: add all marked types to btf_new and add their new ids to the ids map */
-	for (i = 1; i < n; i++) {
+	for (i = start_id; i < n; i++) {
 		const struct btf_type *cloned_type, *type;
 		const char *name;
 		int new_id;
@@ -2213,7 +2231,7 @@ static struct btf *btfgen_get_btf(struct btfgen_info *info)
 	}
 
 	/* second pass: fix up type ids */
-	for (i = 1; i < btf__type_cnt(btf_new); i++) {
+	for (i = start_id; i < btf__type_cnt(btf_new); i++) {
 		struct btf_type *btf_type = (struct btf_type *) btf__type_by_id(btf_new, i);
 
 		err = btf_type_visit_type_ids(btf_type, btfgen_remap_id, ids);
-- 
2.25.1


