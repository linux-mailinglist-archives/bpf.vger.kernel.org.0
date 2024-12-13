Return-Path: <bpf+bounces-46893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 574659F16AC
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 20:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1216E2857A2
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 19:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646651F4715;
	Fri, 13 Dec 2024 19:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="hh18jNMA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FDHqDf1x"
X-Original-To: bpf@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F461F4280;
	Fri, 13 Dec 2024 19:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734119073; cv=none; b=I3Q9U20FjuHEu1UCY82TcbOQ5l+hZrV8f4WwTq+Nl+ZsYnkgWpQK6TkbuY/b+OmKG/d64itE8xBuvoUNNrWtRKq5w0mnXLqw5/FtQRsUq02CMEnukaQ3waSVLpKq7S5Pj6HPnzvR2ovMeHCvO1PYkhb9tp3pNj81/NfDT+syURQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734119073; c=relaxed/simple;
	bh=G3agrlK21+2NjM3MigaoVGU0YXHc2phKcX4ht1E64Ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPv3nGYzQuhqyDfCxwbaPQnN+GXmjtnf18+ZgABf7yVccqQd9rO1HgycaUYN0GVTsS7FMy4poGO/iA3RbFD99CXpog0VnkOOL44lHCzT83rIhM5a5iD1NH8zySSbyTqosRH27M1BuXTMNKdYe11NhGksWsUSL2oVrlGb5PC9D3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=hh18jNMA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FDHqDf1x; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id B65742008D6;
	Fri, 13 Dec 2024 14:44:30 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 13 Dec 2024 14:44:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1734119070; x=
	1734126270; bh=pFCgMZCyhykBHY5GaSdQAkacUHmaYs+i9UHMe/ejd5I=; b=h
	h18jNMAQiw6VMhl4J3U7E8T3hwvoN9a0Y2THIirMVDMVA0ZXJMvkKzOgUp3wi7Hr
	ogIW8u3zEPxDA0FDH6ssRvcoMkamELkrUcFvp6hTqcbDbtssHo18/S/RDxvuw9sE
	GYB27kT9yM/w4gUAOyAxUqF5ph+BEi5HKfWZDUs9M67y86TiLtrKisKb3sHh0/jx
	QBf6J0r3hOEkGrPFxQeTGh110VBlsCheuf8eJ1927+Y+l6zW+Jw5gnolFvrMqW0H
	kQlR5oLIeWQPrn9n1phck3eJmsy/+QOerVjoTWhIvx0Ktq4utTJKZlNSaErfWZgq
	p2wMNC2DCQq19MyfJmlvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1734119070; x=1734126270; bh=p
	FCgMZCyhykBHY5GaSdQAkacUHmaYs+i9UHMe/ejd5I=; b=FDHqDf1x1D6AmDbex
	UU6L/64a2F7dlnMNWk4P+/UtmQN97Wj7NcbdHYHwDNHDDqVJ4khxqQK/N7VOoDad
	IGcJKqfJGwhQOh4Bk3FHwxbEJCconGB9pIQY2Fa3UDC1WNjEQxY0jEMNmd5ZM+yg
	FF9NWIG7ctFAsRokWRhuk40FDL3EVq/rz2adjsvXU8XvFB2eoJ2RUWpIT7MeUOm3
	i2zqjjcIS7KvQRrmj0P4Ld3Cql8SuEAcwdVZPyagSeGuOTDrUEW6dM+g6JIqk1Fg
	Wwyo6abRrMdgh0yBu/BwIJzyA4fRtH8+X4clYWSGtipQlnLk+OAKZO+9EBMhxMuM
	ICsOA==
X-ME-Sender: <xms:no5cZ7513tMaalY2OG_Sq2SaVwghPL_utjkk13EUo9TMDZ3V6NN6Zg>
    <xme:no5cZw7ynqqh3S_BBFZoOCnmuckNClHT8f1YFDgjxqihy3P3Bw91N5ibNeRRslB2t
    1TSrEKR3LcCHNP1bQ>
X-ME-Received: <xmr:no5cZyf8bbM13w7emmejFqEe8TYL_fF09siBM4is139kjjTwaK7Nj13ai3mseDoV3elHJlw4fKSfUMp3ttBw_otIU1AGHOa8Tfj51B3elrSdEZkB7Rh2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeejgdduvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfe
    ehmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeff
    rghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnh
    epvedtkeejffekgfefhfevffeftefgueeuuedtteejudduheehieffvdeghffhvefhnecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiipdhnsggprhgtphht
    thhopedvvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhgvmhesuggrvh
    gvmhhlohhfthdrnhgvthdprhgtphhtthhopehhrgifkheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepuggrnhhivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepkh
    husggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepqhhmoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghsthes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrd
    guvghv
X-ME-Proxy: <xmx:no5cZ8LSNsH40hLiWSAdokRb8OMwGs-wREJNXHg3kkFoMedI7TCjrw>
    <xmx:no5cZ_LMzUhAIuGPuJePeHIzYAmQk_heCAyWlAgep0WG6Q2pTMkPrA>
    <xmx:no5cZ1xLwDH8s6SpelB11XKManyjwYRrA8fKKihk83TvVsZIx9wnyQ>
    <xmx:no5cZ7JPAqadS8t1VlowNk6qkbfKA6CoWUaMC7ERQlWIguWdl9Cfvw>
    <xmx:no5cZ__FVtl4GXJDvRHibpTRZXtRR3-5Yqp7SKsjvwlBSmrH2bgbB2JS>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Dec 2024 14:44:28 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: davem@davemloft.net,
	hawk@kernel.org,
	daniel@iogearbox.net,
	kuba@kernel.org,
	andrii@kernel.org,
	john.fastabend@gmail.com,
	qmo@kernel.org,
	ast@kernel.org
Cc: martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	andrii.nakryiko@gmail.com,
	antony@phenome.org,
	toke@kernel.org
Subject: [PATCH bpf-next v5 3/4] bpftool: btf: Support dumping a specific types from file
Date: Fri, 13 Dec 2024 12:44:11 -0700
Message-ID: <04feb860c0a56a7da66f923551484e1483a72074.1734119028.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1734119028.git.dxu@dxuuu.xyz>
References: <cover.1734119028.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some projects, for example xdp-tools [0], prefer to check in a minimized
vmlinux.h rather than the complete file which can get rather large.

However, when you try to add a minimized version of a complex struct (eg
struct xfrm_state), things can get quite complex if you're trying to
manually untangle and deduplicate the dependencies.

This commit teaches bpftool to do a minimized dump of a specific types by
providing a optional root_id argument(s).

Example usage:

    $ ./bpftool btf dump file ~/dev/linux/vmlinux | rg "STRUCT 'xfrm_state'"
    [12643] STRUCT 'xfrm_state' size=912 vlen=58

    $ ./bpftool btf dump file ~/dev/linux/vmlinux root_id 12643 format c
    #ifndef __VMLINUX_H__
    #define __VMLINUX_H__

    [..]

    struct xfrm_type_offload;

    struct xfrm_sec_ctx;

    struct xfrm_state {
            possible_net_t xs_net;
            union {
                    struct hlist_node gclist;
                    struct hlist_node bydst;
            };
            union {
                    struct hlist_node dev_gclist;
                    struct hlist_node bysrc;
            };
            struct hlist_node byspi;
    [..]

[0]: https://github.com/xdp-project/xdp-tools/blob/master/headers/bpf/vmlinux.h

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 .../bpf/bpftool/Documentation/bpftool-btf.rst |  9 ++++-
 tools/bpf/bpftool/btf.c                       | 39 ++++++++++++++++++-
 2 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
index 245569f43035..d47dddc2b4ee 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-btf.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
@@ -24,7 +24,7 @@ BTF COMMANDS
 =============
 
 | **bpftool** **btf** { **show** | **list** } [**id** *BTF_ID*]
-| **bpftool** **btf dump** *BTF_SRC* [**format** *FORMAT*]
+| **bpftool** **btf dump** *BTF_SRC* [**format** *FORMAT*] [**root_id** *ROOT_ID*]
 | **bpftool** **btf help**
 |
 | *BTF_SRC* := { **id** *BTF_ID* | **prog** *PROG* | **map** *MAP* [{**key** | **value** | **kv** | **all**}] | **file** *FILE* }
@@ -43,7 +43,7 @@ bpftool btf { show | list } [id *BTF_ID*]
     that hold open file descriptors (FDs) against BTF objects. On such kernels
     bpftool will automatically emit this information as well.
 
-bpftool btf dump *BTF_SRC* [format *FORMAT*]
+bpftool btf dump *BTF_SRC* [format *FORMAT*] [root_id *ROOT_ID*]
     Dump BTF entries from a given *BTF_SRC*.
 
     When **id** is specified, BTF object with that ID will be loaded and all
@@ -67,6 +67,11 @@ bpftool btf dump *BTF_SRC* [format *FORMAT*]
     formatting, the output is sorted by default. Use the **unsorted** option
     to avoid sorting the output.
 
+    **root_id** option can be used to filter a dump to a single type and all
+    its dependent types. It cannot be used with any other types of filtering
+    (such as the "key", "value", or "kv" arguments when dumping BTF for a map).
+    It can be passed multiple times to dump multiple types.
+
 bpftool btf help
     Print short help message.
 
diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 3e995faf9efa..2636655ac180 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -27,6 +27,8 @@
 #define KFUNC_DECL_TAG		"bpf_kfunc"
 #define FASTCALL_DECL_TAG	"bpf_fastcall"
 
+#define MAX_ROOT_IDS		16
+
 static const char * const btf_kind_str[NR_BTF_KINDS] = {
 	[BTF_KIND_UNKN]		= "UNKNOWN",
 	[BTF_KIND_INT]		= "INT",
@@ -880,7 +882,8 @@ static int do_dump(int argc, char **argv)
 {
 	bool dump_c = false, sort_dump_c = true;
 	struct btf *btf = NULL, *base = NULL;
-	__u32 root_type_ids[2];
+	__u32 root_type_ids[MAX_ROOT_IDS];
+	bool have_id_filtering;
 	int root_type_cnt = 0;
 	__u32 btf_id = -1;
 	const char *src;
@@ -974,6 +977,8 @@ static int do_dump(int argc, char **argv)
 		goto done;
 	}
 
+	have_id_filtering = !!root_type_cnt;
+
 	while (argc) {
 		if (is_prefix(*argv, "format")) {
 			NEXT_ARG();
@@ -993,6 +998,36 @@ static int do_dump(int argc, char **argv)
 				goto done;
 			}
 			NEXT_ARG();
+		} else if (is_prefix(*argv, "root_id")) {
+			__u32 root_id;
+			char *end;
+
+			if (have_id_filtering) {
+				p_err("cannot use root_id with other type filtering");
+				err = -EINVAL;
+				goto done;
+			} else if (root_type_cnt == MAX_ROOT_IDS) {
+				p_err("only %d root_id are supported", MAX_ROOT_IDS);
+				err = -E2BIG;
+				goto done;
+			}
+
+			NEXT_ARG();
+			root_id = strtoul(*argv, &end, 0);
+			if (*end) {
+				err = -1;
+				p_err("can't parse %s as root ID", *argv);
+				goto done;
+			}
+			for (i = 0; i < root_type_cnt; i++) {
+				if (root_type_ids[i] == root_id) {
+					err = -EINVAL;
+					p_err("duplicate root_id %d supplied", root_id);
+					goto done;
+				}
+			}
+			root_type_ids[root_type_cnt++] = root_id;
+			NEXT_ARG();
 		} else if (is_prefix(*argv, "unsorted")) {
 			sort_dump_c = false;
 			NEXT_ARG();
@@ -1403,7 +1438,7 @@ static int do_help(int argc, char **argv)
 
 	fprintf(stderr,
 		"Usage: %1$s %2$s { show | list } [id BTF_ID]\n"
-		"       %1$s %2$s dump BTF_SRC [format FORMAT]\n"
+		"       %1$s %2$s dump BTF_SRC [format FORMAT] [root_id ROOT_ID]\n"
 		"       %1$s %2$s help\n"
 		"\n"
 		"       BTF_SRC := { id BTF_ID | prog PROG | map MAP [{key | value | kv | all}] | file FILE }\n"
-- 
2.46.0


