Return-Path: <bpf+bounces-46436-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4497D9EA318
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 00:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5786B282B37
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 23:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E0122836A;
	Mon,  9 Dec 2024 23:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="REbop1AF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EdhC7kKL"
X-Original-To: bpf@vger.kernel.org
Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C177226189;
	Mon,  9 Dec 2024 23:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733787918; cv=none; b=IaiZy5LTcGheNekGtLRDiyfnn8S9v0ZvQsdZIMdZ6UHPvhx7R5APqzDPQP2KCSu6Gqtvnlb+tt4NOrY4A4vToYpCskYZXnXmMzhpWbbDlnwOOJHw6YXAv/wRmQEDgBfgTARaAXuAjO11n79gW3vo2y1mFAX951icbtUPj1fiG3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733787918; c=relaxed/simple;
	bh=t6YWqjuBpOzJUcv0KgUUnzgurGW+EY/nB39y3RsCwOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W0qDvc+5ldHH13vSucgSZhiCRa7XMFOOPRfj99ffavbRAmB4JNyP8DWe5XMBsAxhZm+ONuSEZZ7Fzot+pLbagDaYz0J4swqlyX0bNZdduXCYKYoqtyfTe2NWsE++epeLViVJCISzJRFE8emQWB8ZfRYhJp633qim/taB+4tS+CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=REbop1AF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EdhC7kKL; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailflow.stl.internal (Postfix) with ESMTP id 9E7E21D409B6;
	Mon,  9 Dec 2024 18:45:14 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 09 Dec 2024 18:45:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1733787914; x=
	1733795114; bh=FNe66ehp1D+ELVvV3anO9UW46My6FNIb3T/hz9ka5zM=; b=R
	Ebop1AF08yI84fnOa7VIWRotXfPWJLNdvRmwUD48/VG/PtwI5ldOXFZmiyoXeiSR
	FGaTCngVYwNYeNddogKCmHiY3/u1Jn4otabP/in5DQPSi3jb0adL8PGBVs7pZWDr
	m0983Wm5zcao7JcA+aJaJ/Zv8pKhfRoN/ClVUD67NesebF+Z+KZqc+cvH4ubnSuO
	G/QVQny4+iaE1C1D8KUPkB+G7grf9ksmFG72lE9Q9QNiqCrL29Fl4T9aEKXfvMFy
	9a2OJRB2UJUGHiNmuPkYd/aQcduZEUXC9E8gOezLW+EpG77OmUOuiN66TnqPjHCb
	DB2TXLM4XNpDkPTrrC44w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1733787914; x=1733795114; bh=F
	Ne66ehp1D+ELVvV3anO9UW46My6FNIb3T/hz9ka5zM=; b=EdhC7kKLxQW/SKzT8
	oyGkhopL4IrN0ZLbBhHoCDQRNADR1IEv/8UnByMrKql8Xm+QcvOsL2jVKpv0R2us
	P7PoRjTMusypO2pk4yKMd6LIKf2RBoh9v/E5eirD9nm1CEezlo1f5HU3nJbMJB1S
	3tvvOxuNRYH3gO3XXu+NoF2pFxdzrrNyVEobxnYQZ6w5yvbBobJI8RAGq0USYw3N
	aheO4BSrCpguhaTLRvGXmI4+ociaby+K7kiHAs1vY5AtNAK5VTrGDBE2KPaQOFkq
	P8yp0VrSew+HwFPWFtWq6bw0w/hHwhacrC3I1A2raJcVdjwccoD3KHQ+CSWeREhe
	crMnQ==
X-ME-Sender: <xms:CYFXZ2FeGSvzVNRtOWwuNJk4KZuuRwE0l_zVvVXuqgSI1kFYa8qTaQ>
    <xme:CYFXZ3Vx-ovWo0RY6ZNzRlfq7Q9o1HmAR4TJpycJm-1xZ7_GkHGRzGCDRLBFw3tU6
    WXQtG6QrHsc9Emm_g>
X-ME-Received: <xmr:CYFXZwLFzaBt8Ewm82g715ymyvg_-wy-Tb-mCFyS5-PfK5tG1tQl8PlpDFgud2vsXGFOOnDphkLDtWVx4qkLhsWU0PC9uJmQ8YQlbX1043ldUN9malHi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeejgddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhe
    dmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgr
    nhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpe
    evtdekjeffkefgfefhvefffeetgfeuueeutdetjeduudehheeiffdvgefhhfevhfenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihiidpnhgspghrtghpthht
    ohepvddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehhrgifkheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgt
    ohhmpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepqhhmoh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdr
    nhgvthdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtph
    htthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggrsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehmrghrthhinhdrlhgruheslhhinhhugidrug
    gvvh
X-ME-Proxy: <xmx:CYFXZwEaWPWhjA8mlb697hiz0cZBPksWNJFuox3nXlI2UE4_vYT11Q>
    <xmx:CYFXZ8W8D7Fl5MebZmFF4pwzqW6BKai5j_wKH3QFhu4wQj3CfR3l1w>
    <xmx:CYFXZzP6zuOpDWIfCET--0H3y4BPVN1K1toFMGmtVQNbKYOxieO2qA>
    <xmx:CYFXZz3ri0e5cTbmzK7lDaeDyZXfNNg3BJsKto3R705s1SXnw9y2SA>
    <xmx:CoFXZzPTsQF8idrlhRRjkl5pyrL5KdOL7VcjIkI0Jx4sGply-nCSD8NV>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Dec 2024 18:45:11 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: hawk@kernel.org,
	john.fastabend@gmail.com,
	ast@kernel.org,
	qmo@kernel.org,
	davem@davemloft.net,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kuba@kernel.org
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
	antony@phenome.org,
	toke@kernel.org
Subject: [PATCH bpf-next v3 3/4] bpftool: btf: Support dumping a single type from file
Date: Mon,  9 Dec 2024 16:44:34 -0700
Message-ID: <3bc17d33161961409dc77a5de29761bf2bed4980.1733787798.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1733787798.git.dxu@dxuuu.xyz>
References: <cover.1733787798.git.dxu@dxuuu.xyz>
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

This commit teaches bpftool to do a minimized dump of a single type by
providing an optional root_id argument.

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
 .../bpf/bpftool/Documentation/bpftool-btf.rst |  7 +++++--
 tools/bpf/bpftool/btf.c                       | 21 ++++++++++++++++++-
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
index 245569f43035..4899b2c10777 100644
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
@@ -67,6 +67,9 @@ bpftool btf dump *BTF_SRC* [format *FORMAT*]
     formatting, the output is sorted by default. Use the **unsorted** option
     to avoid sorting the output.
 
+    **root_id** option can be used to filter a dump to a single type and all
+    its dependent types. It cannot be used with any other types of filtering.
+
 bpftool btf help
     Print short help message.
 
diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 3e995faf9efa..18b037a1414b 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -993,6 +993,25 @@ static int do_dump(int argc, char **argv)
 				goto done;
 			}
 			NEXT_ARG();
+		} else if (is_prefix(*argv, "root_id")) {
+			__u32 root_id;
+			char *end;
+
+			if (root_type_cnt) {
+				p_err("cannot use root_id with other type filtering");
+				err = -EINVAL;
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
+			root_type_ids[root_type_cnt++] = root_id;
+			NEXT_ARG();
 		} else if (is_prefix(*argv, "unsorted")) {
 			sort_dump_c = false;
 			NEXT_ARG();
@@ -1403,7 +1422,7 @@ static int do_help(int argc, char **argv)
 
 	fprintf(stderr,
 		"Usage: %1$s %2$s { show | list } [id BTF_ID]\n"
-		"       %1$s %2$s dump BTF_SRC [format FORMAT]\n"
+		"       %1$s %2$s dump BTF_SRC [format FORMAT] [root_id ROOT_ID]\n"
 		"       %1$s %2$s help\n"
 		"\n"
 		"       BTF_SRC := { id BTF_ID | prog PROG | map MAP [{key | value | kv | all}] | file FILE }\n"
-- 
2.46.0


