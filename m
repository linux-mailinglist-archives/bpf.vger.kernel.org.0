Return-Path: <bpf+bounces-46802-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 570939F0224
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 02:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFE3D16C0D1
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 01:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEFF18027;
	Fri, 13 Dec 2024 01:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="NsrHQO8W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m/bFB3BP"
X-Original-To: bpf@vger.kernel.org
Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11517082C;
	Fri, 13 Dec 2024 01:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734053081; cv=none; b=JNiDdGTW8v5k+1UXbOBmsc+rQC0QIzxiHHFMnvhIedj10ruh1tL4Y+ab02ez3IOFkBtQu56TPMQ0EsLGfgUWNyNNVT3FqKljHoeRDeuzysT2+Mds0uXrkLyE3KLFWQFiaJqHxfPuqUSzqybGzEwfS9oEt+HbBOgfE1bsid8/hLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734053081; c=relaxed/simple;
	bh=Xlr00EpboX3eZ9NN8BWfYhvPSIPU75I+cn8Uw0VlVoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j8d28mVsbqecWulh9LxxxwknoBe+YKhmaY2mG4Gp/WpH5iABMRI4M8biGSMjKlzWswAvrrOMSJMPMNzKWx8LRYMumlbFhhMrV5h9oS+oF7+l8gQPg7yYBtujj+FYgwGKXd9LvsOMMCs88xmG2/pFeTi1cn3zdpTvyOJT5rWQa60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=NsrHQO8W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m/bFB3BP; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailflow.phl.internal (Postfix) with ESMTP id BF984200804;
	Thu, 12 Dec 2024 20:24:38 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 12 Dec 2024 20:24:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1734053078; x=
	1734060278; bh=YccxXOXPERZDzs8A9WsRki084bV04s4hgsiDdgoqGtw=; b=N
	srHQO8W4eHslfAxnE8l2yicRucFK0rfFlNlXS3Dl6A7xRfQb1XPmJ+NkeuEXEwnM
	ZxpSqSZ6AjMSv22YZZFwgjjMu8gGgzqye6OVBp2VwTDC0/LsDJ8R+43M9pnXQaet
	5CnnI0K01YIv0vs4kOEJbMLDaAMsAY2uXg1JrQqDW1NoOWMrp6HqptOwI1Q5F4qp
	CxLuBDDXuyYSaK0zc+5SRdtFSaFs6VRfCKHT7WXhiRt7jf+Pr0UcV+TR3ZtwKvcr
	8/qUCxxO/eeYCTQlrlVSHs8p5iCSuHCJTl/1MwF3mGX29XS27MFYWcDO0yOOq9DD
	iLCZnk5t8uW4O4M4UZseA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1734053078; x=1734060278; bh=Y
	ccxXOXPERZDzs8A9WsRki084bV04s4hgsiDdgoqGtw=; b=m/bFB3BPfSX33QXqw
	oGpNtF5yGVagNMgUAt20QwUf3Dvv5MYS+L3raIGh13Ci94yvp0SFFICOi2b8Mp4q
	Du9LFL1dL38rRtE2mX66/c5msfLIxuxDHh8z4HlhYx1KlzWwFyeg49WCvqdLwGp8
	nmhlcnh2L8go6chyS+avnsrWef+OUNIzc2bdfiTUrTixNjNJYcsJTS0WT2/s/uam
	1YqSNWUOZqi8mPR203mLvE6q/ARWhbsLvT1ZoToDZ/bGx11ED48gkxn3Y1QCjwKu
	t5Oq34umlQEdiXclGqwhZoJQJFkQdmMFvSoznij/094eYDzLLMcM5TXBcGq6ZxDs
	Hhi5g==
X-ME-Sender: <xms:1oxbZxxpHOCCK-Ois-80mDD5RIIqU3jmHzL6QHzaBhRgYkjbNRjXGw>
    <xme:1oxbZxQFTmi0XxgN_V8IOQVJiybwmH9la3_6q4zVFI5v0Om8DOKPN0jCYltnEwEdR
    xUR9pUH7z0rLyLk0g>
X-ME-Received: <xmr:1oxbZ7V5mH-5dbe2sJrQjqWlQK4txk_itGtooi6Q33KnjOxuMTuDd4fFHct-981YVAHTB7qZXmFlZTdNu86tQLMVdWtD8kSS70IxPXizxfglcNEFWQGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeeigdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhe
    dmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgr
    nhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpe
    evtdekjeffkefgfefhvefffeetgfeuueeutdetjeduudehheeiffdvgefhhfevhfenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihiidpnhgspghrtghpthht
    ohepvddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehhrgifkheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhhnrdhfrghsth
    grsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghstheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepqhhmoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnh
    hivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepuggrvhgvmhesuggrvhgv
    mhhlohhfthdrnhgvthdprhgtphhtthhopehmrghrthhinhdrlhgruheslhhinhhugidrug
    gvvh
X-ME-Proxy: <xmx:1oxbZzjcA79T2FppZ1oGSD0JYT66PbmqVxuQQqFArFHguS2Q9xCsgA>
    <xmx:1oxbZzDYYpwf5VI3l4qoNxhAr9nuNNm-0RXnnKTfB362pQdIT0B-0w>
    <xmx:1oxbZ8LId9EUtJYtbQ788MNonyG0z5l8Z9SAMcdfYBkyI8J3agnkRA>
    <xmx:1oxbZyBY1I-eiXdc2rhDe2v7pxmOQZj1g68sHVvXauox7MZAc89x_g>
    <xmx:1oxbZ6Wfv2IxMblS0DGkHW63eB88msetgeTnA5w3qJRrIomJmOWmNAu9>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Dec 2024 20:24:35 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: hawk@kernel.org,
	kuba@kernel.org,
	andrii@kernel.org,
	john.fastabend@gmail.com,
	ast@kernel.org,
	qmo@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net
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
Subject: [PATCH bpf-next v4 3/4] bpftool: btf: Support dumping a specific types from file
Date: Thu, 12 Dec 2024 18:24:15 -0700
Message-ID: <5ec7617fd9c28ff721947aceb80937dc10fca770.1734052995.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1734052995.git.dxu@dxuuu.xyz>
References: <cover.1734052995.git.dxu@dxuuu.xyz>
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
 .../bpf/bpftool/Documentation/bpftool-btf.rst |  8 +++-
 tools/bpf/bpftool/btf.c                       | 39 ++++++++++++++++++-
 2 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
index 245569f43035..dbe6d6d94e4c 100644
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
@@ -67,6 +67,10 @@ bpftool btf dump *BTF_SRC* [format *FORMAT*]
     formatting, the output is sorted by default. Use the **unsorted** option
     to avoid sorting the output.
 
+    **root_id** option can be used to filter a dump to a single type and all
+    its dependent types. It cannot be used with any other types of filtering.
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


