Return-Path: <bpf+bounces-46339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBC89E7C6B
	for <lists+bpf@lfdr.de>; Sat,  7 Dec 2024 00:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67F02284C96
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 23:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5423213E70;
	Fri,  6 Dec 2024 23:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="gf+/FHHz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OVzS+iU1"
X-Original-To: bpf@vger.kernel.org
Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB0B22C6DC;
	Fri,  6 Dec 2024 23:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733527770; cv=none; b=Gd31uSxrOZJqgenrhBXb0he+x5lZKWcG4dJm1Ga4fARoGm6+zQR/fSkYP6TQIwiINAVd1csqteMXxV99KxYs/mCZEsQrCkOE/NhbkuktQy8wlu2/j5WT/MjkXK3tlKj03LbIFbxbrazlSN560m+a+yB5tYq120vpsnMLwTUKCg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733527770; c=relaxed/simple;
	bh=aaHs+/FVHDqenhdg7T4nI5yOK8/n+euewdQ7Om2YbyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m7ZsIKPgTGHgyZlyig8LLCJHb1pWYC/KEJ5b50p104z4vPxvKUwz4A1gpkyOZz+N7SNjS4PvnQizzKIv6fvn3gWYXYgRiU9aGhFqYD3xnEAHps5TJ2FcqsS+nuym3wd4DbWgq7HMpe5pYWJyqKpiEpGhQ8HM4zqDGeJHAGctaNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=gf+/FHHz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OVzS+iU1; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailflow.phl.internal (Postfix) with ESMTP id AC9392005C9;
	Fri,  6 Dec 2024 18:29:26 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 06 Dec 2024 18:29:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1733527766; x=1733534966; bh=VZ7DcPvzZm5sbriZsVfMV
	gB1C0MK2Zkd7XQ82Brym+o=; b=gf+/FHHzRwPVEGlLp4+PpPxR8Gi/mhgfbipbn
	GTTig+wwVMmUz7ObwXVbYlI+AIOVvSQuVqO9zqkmzfEiLOLrsO9onqzSA0bDGjEE
	o9eHGO0T67ZHbIPLry3Yq3q9va77eWjgnzVR8w5r+53HILvWveanyd424a2ANAC2
	FwN90MG9cA39P5v/x/LoFiXvm7ydjQpUvmseijPCNeFtoCEhX/VuKsOSgse/8dqd
	lChYxWcTN13kegQ7CNlWNBnP9k1CGz+pPxVPdi4porV8jNZlrk/xvVyFfT8R2kDd
	uj9WObPWId/InRo+b9QLuDJ6jgKW/C30C8jwF1HokmieqaXaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733527766; x=1733534966; bh=VZ7DcPvzZm5sbriZsVfMVgB1C0MK2Zkd7XQ
	82Brym+o=; b=OVzS+iU1sw4A0NoDmyZ5imvExAZ0PhvYJWcoXzZz48vsrt5LbtB
	hHOYX4nr57p+IJoNeocMTcyE5v+rXkqHipTgcHmrEokxl5vRJPPzM9MPJ0LKtVz/
	4R/AJ2hxfOqcsxu+IN6AA2s29C+m/VHQAzZW1+ymxFFFQzUWB+tbMvInvp8o/wl8
	x8Xc7dYAGSB4EGjMRZyRLyUEE/J1h/7hxIkR1qvf5f94/G8bKIA1rBP/ZHyR56AO
	MQOETSSYIM9aNZO0/JAOlqSpgEnlTOBtuzo4pzXzEbZZncw6YFuq+2nOv9YHGCHR
	lhCBSIwg4ga6KJgZ+5qtKkXLQq09lPVBjcw==
X-ME-Sender: <xms:1YhTZ8lpH57SAHC406QR38k91WR1Sa65CSmdLODO6ehQBK4Vi79Lhw>
    <xme:1YhTZ728rKfUNF5l1HhoqpArzoTSKGRvy40EHqy7VMAOxv3XMJEKnAorBomoArO5o
    i3IL9Jn6ZTOr7l_mg>
X-ME-Received: <xmr:1YhTZ6qCunFnRJX7bAbRbaj13k9Uocv6I44pI4LebR2Kt2l9qX3tDNHRIR5afBcW-lDabKUtC3GYfUoMs6ILE3XItyW6fJfLdyaUP5rWpGk2mOXZ9zTF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjedtgddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhe
    dmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhi
    vghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeeitd
    ekgfduveetveevgfeuhfegieekleegheeftdekffefjefgteetfeeukefgkeenucffohhm
    rghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihiidpnhgspghrtghpthhtohep
    vddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrshhtsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghn
    ughrihhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhrgifkheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepqhhmoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhho
    hhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmh
    esuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegurghnihgvlhesihhoghgvrghr
    sghogidrnhgvthdprhgtphhtthhopehmrghrthhinhdrlhgruheslhhinhhugidruggvvh
X-ME-Proxy: <xmx:1YhTZ4nKaSOIgYV1PX0wT2iV0B9XGqbE0lspijtPsaIwzkKVni0mQQ>
    <xmx:1YhTZ60WkuB-iAfQvENb74Mew6qjGs0oFDtOjKbjSK9kNkV_tvmoLg>
    <xmx:1YhTZ_ux9UzLg1iGIVGPTzNCFmYcuVZfzK78gN2155_bO2EmYW6SGg>
    <xmx:1YhTZ2XbhbJpZWqcpjCHNeMfRS186Rnwb6fE03nBbtET-UXeeI44mw>
    <xmx:1ohTZxsMiNN84z5Kvzeyf7UVrk9C2JWY1hEWHNmpL8sqTscsI6fuF8WC>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 18:29:23 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: ast@kernel.org,
	kuba@kernel.org,
	andrii@kernel.org,
	hawk@kernel.org,
	qmo@kernel.org,
	john.fastabend@gmail.com,
	davem@davemloft.net,
	daniel@iogearbox.net
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
Subject: [PATCH bpf-next] bpftool: btf: Support dumping a single type from file
Date: Fri,  6 Dec 2024 16:29:08 -0700
Message-ID: <8ae2c1261be36f7594a7ba0ac2d1e0eeb10b457d.1733527691.git.dxu@dxuuu.xyz>
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
 tools/bpf/bpftool/Documentation/bpftool-btf.rst |  5 +++--
 tools/bpf/bpftool/btf.c                         | 12 ++++++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

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
index d005e4fd6128..668ff0d10469 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -953,6 +953,7 @@ static int do_dump(int argc, char **argv)
 		NEXT_ARG();
 	} else if (is_prefix(src, "file")) {
 		const char sysfs_prefix[] = "/sys/kernel/btf/";
+		char *end;
 
 		if (!base_btf &&
 		    strncmp(*argv, sysfs_prefix, sizeof(sysfs_prefix) - 1) == 0 &&
@@ -967,6 +968,17 @@ static int do_dump(int argc, char **argv)
 			goto done;
 		}
 		NEXT_ARG();
+
+		if (argc && is_prefix(*argv, "root_id")) {
+			NEXT_ARG();
+			root_type_ids[root_type_cnt++] = strtoul(*argv, &end, 0);
+			if (*end) {
+				err = -1;
+				p_err("can't parse %s as root ID", *argv);
+				goto done;
+			}
+			NEXT_ARG();
+		}
 	} else {
 		err = -1;
 		p_err("unrecognized BTF source specifier: '%s'", src);
-- 
2.46.0


