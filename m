Return-Path: <bpf+bounces-46364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD819E82B8
	for <lists+bpf@lfdr.de>; Sun,  8 Dec 2024 00:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D580281DFC
	for <lists+bpf@lfdr.de>; Sat,  7 Dec 2024 23:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BD115D5B7;
	Sat,  7 Dec 2024 23:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="NKCaP4xB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1DWJbQky"
X-Original-To: bpf@vger.kernel.org
Received: from flow-a3-smtp.messagingengine.com (flow-a3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905571E505;
	Sat,  7 Dec 2024 23:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733613873; cv=none; b=tHYIHoJWUSePI2yE+45y5t+thSD7Wy9upkUAc53lGlZ1zRXv3wOkAGdGQpMIFRyRgxAaQvtOJLDJu4TkR4NVo7poW/q1QWUAStPpB9BnucRBV378xiFs12MmA00VFLfVcusHSSgGMYhnK8HiSFeu1yOMCAARZ4Zx/PaTxXUjy0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733613873; c=relaxed/simple;
	bh=5IFUFCiYtsai/07kVA3PfphOxOjYhSgOJ3PFXuaGdto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hXpKYYA6OwqNDSHj8un7cl6LjfCb7uNJ8cU+JnKRwY9iZYSRW99mP+c0nVEHfGc8K4ZSEqlbs1xhzXWDoS65K73tTk8sAm6lebiiI/6Nz+UaQ1mvLwqIUY7tGWWsDxqOR/Quh9ZnrYxKBm4t2GDOiCRMZbHCr5VdQJvWnoAikDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=NKCaP4xB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1DWJbQky; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailflow.phl.internal (Postfix) with ESMTP id 8F5D02005DE;
	Sat,  7 Dec 2024 18:24:30 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Sat, 07 Dec 2024 18:24:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1733613870; x=1733621070; bh=Wq6/yEYJvLYOrMEjDKkEb
	WlNkXH5vFnrMRy2imIzA8k=; b=NKCaP4xBJCwAwFDhvVZR5J/+bWRxm2PducfmB
	1BrMu4GES9AR2i7Wo0cWO8ePNaiw3H4CrerSTDVrcN9OsMkrj9oDTVAZHpM7H6l7
	cNbvC/n6jxPv2ehZ8yA2Eh1j4ab93v05Y7o2L81TuHxlZJ83XDFbehISI3I9Pvef
	Bx2U3HTWO3oBi33Y2JJ50TL0gyZx/vqGU3VfztwGaeIp7cjTL0Tj3wbrCSLt0mE9
	YCc4DGeBvwzA1LmfDW6rLunhhSuZTmjoURTPBI9yMzVP/8UiddjTSfKbU2BPqg3m
	Nsxy4PDJM3Ca2LbYic6HWY2pSn1XSUZFnsXWGcsUZV26LvCkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733613870; x=1733621070; bh=Wq6/yEYJvLYOrMEjDKkEbWlNkXH5vFnrMRy
	2imIzA8k=; b=1DWJbQkymYcB7St5r1awZaALu1jrfZ5uF/StikqCYA41oxG/4fa
	xzrFPfHQMXquUXbIP5jm89YE88zutMmk2HWOXSLWYgaL/KOgHL6nKRogM3E1ZKvk
	/H4gMymEdK6lk+QLCPLmW2z34HWhY3NtbaS22J6lS5Lsmueq9YWecUstHFA8ntdj
	p/y3kU9CXa0tyBYOPnBcRYRk7/s02sCa643q6q20QpjdxTfM2JtoC8UNwGxJhLIK
	kl9YoSjgDRqRq8ylAMtYg2tIr7Sfo5QhR+mo1alU0+lS6A5k8omDui2emfcppKku
	fBdXP+BehDMLI+qMy087rPKawBGbOBQXwDw==
X-ME-Sender: <xms:LtlUZ3RVDZ6u2oBfQUnmhcQfdtDPjOmw95fw8IoMAkRVGvxxUzVbfQ>
    <xme:LtlUZ4y2We0PL_xLtVS_g409Pf7ig5fxvtSzDAbbL3wDvOH1z5sj5PlTT6ziEC1Y_
    DJhEvKCOnOXNRcnCw>
X-ME-Received: <xmr:LtlUZ83ZpFFf9uijtsUnyUiSWLSSlQfRK79HRrsSW48ZkZ1HHRQL8sz9MmfmY-dBXR3ROEDuJLpDfDUIJsLUm18F-iwAVVqC_6bUhEINuWmWFAE71fLO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjedvgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhe
    dmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhi
    vghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeeitd
    ekgfduveetveevgfeuhfegieekleegheeftdekffefjefgteetfeeukefgkeenucffohhm
    rghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihiidpnhgspghrtghpthhtohep
    vddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehhrgifkheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrshhtse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhn
    vghtpdhrtghpthhtohepqhhmoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnh
    hivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtoheprghnughrihhisehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehmrghrthhinhdrlhgruheslhhinhhugidruggvvh
X-ME-Proxy: <xmx:LtlUZ3BWvrK6kSh95mb_TZDmwOoItPnSrEqFdHvXs3DTW5f5_q7yRA>
    <xmx:LtlUZwgyNyjIeqyIxW9A_FOGru-zDk_XwXyQiM4tEvdGnF0owbc0Cw>
    <xmx:LtlUZ7oZukZgq_MAT0c0ZOdgWWg2ER7VoRaUqSUcsBG9Sh6RcHxb7A>
    <xmx:LtlUZ7ihb8ZjuWbtOixQjxasoCimFvNfPRNUcmBUIBILZ83fbin-cg>
    <xmx:LtlUZ5Z8C7vCo5a6e3JH5zVNi_krY42X5MZQZ4pcm4Rpa054hG5OHeHz>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Dec 2024 18:24:28 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: hawk@kernel.org,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	ast@kernel.org,
	davem@davemloft.net,
	qmo@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
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
Subject: [PATCH bpf-next v2] bpftool: btf: Support dumping a single type from file
Date: Sat,  7 Dec 2024 16:24:17 -0700
Message-ID: <c8e6a2dfb64d76e61a20b1e2470fccbddf167499.1733613798.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.46.0
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
Changes in v2:
* Add early error check for invalid BTF ID

 .../bpf/bpftool/Documentation/bpftool-btf.rst |  5 +++--
 tools/bpf/bpftool/btf.c                       | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
index 3f6bca03ad2e..5abd0e99022f 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-btf.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
@@ -27,7 +27,7 @@ BTF COMMANDS
 | **bpftool** **btf dump** *BTF_SRC* [**format** *FORMAT*]
 | **bpftool** **btf help**
 |
-| *BTF_SRC* := { **id** *BTF_ID* | **prog** *PROG* | **map** *MAP* [{**key** | **value** | **kv** | **all**}] | **file** *FILE* }
+| *BTF_SRC* := { **id** *BTF_ID* | **prog** *PROG* | **map** *MAP* [{**key** | **value** | **kv** | **all**}] | **file** *FILE* [**root_id** *ROOT_ID*] }
 | *FORMAT* := { **raw** | **c** [**unsorted**] }
 | *MAP* := { **id** *MAP_ID* | **pinned** *FILE* }
 | *PROG* := { **id** *PROG_ID* | **pinned** *FILE* | **tag** *PROG_TAG* | **name** *PROG_NAME* }
@@ -60,7 +60,8 @@ bpftool btf dump *BTF_SRC*
 
     When specifying *FILE*, an ELF file is expected, containing .BTF section
     with well-defined BTF binary format data, typically produced by clang or
-    pahole.
+    pahole. You can choose to dump a single type and all its dependent types
+    by providing an optional *ROOT_ID*.
 
     **format** option can be used to override default (raw) output format. Raw
     (**raw**) or C-syntax (**c**) output formats are supported. With C-style
diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index d005e4fd6128..a75e17efaf5e 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -953,6 +953,8 @@ static int do_dump(int argc, char **argv)
 		NEXT_ARG();
 	} else if (is_prefix(src, "file")) {
 		const char sysfs_prefix[] = "/sys/kernel/btf/";
+		__u32 root_id;
+		char *end;
 
 		if (!base_btf &&
 		    strncmp(*argv, sysfs_prefix, sizeof(sysfs_prefix) - 1) == 0 &&
@@ -967,6 +969,23 @@ static int do_dump(int argc, char **argv)
 			goto done;
 		}
 		NEXT_ARG();
+
+		if (argc && is_prefix(*argv, "root_id")) {
+			NEXT_ARG();
+			root_id = strtoul(*argv, &end, 0);
+			if (*end) {
+				err = -1;
+				p_err("can't parse %s as root ID", *argv);
+				goto done;
+			}
+			if (root_id >= btf__type_cnt(btf)) {
+				err = -EINVAL;
+				p_err("invalid root ID: %u", root_id);
+				goto done;
+			}
+			root_type_ids[root_type_cnt++] = root_id;
+			NEXT_ARG();
+		}
 	} else {
 		err = -1;
 		p_err("unrecognized BTF source specifier: '%s'", src);
-- 
2.46.0


