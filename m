Return-Path: <bpf+bounces-64033-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A7BB0D8B2
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 13:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8D1188BB79
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 11:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397B32E4984;
	Tue, 22 Jul 2025 11:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZDBwDnEH"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6592E4248
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 11:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753185543; cv=none; b=oHjOeew2lrFzVf5mU5sWBc/4cUawE3seJurhV07sQEmEfCCc0zQRU9nWHLSni681digTdP7EalCdR1wZhHQ3QWWhsnR8itvO+c4xpnr31RTaXUO2DeOAKDiZKXnTujVIoFJ52j7N5WKGpYjP9umCwx3qj+Rce2PKoB1hoKsZ9gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753185543; c=relaxed/simple;
	bh=yL2d/9IXy4X1vzcvklpYsN0CYWqiKrn9MOHEPX0zopk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hy4VjsgykZbAies62dQjzspEfBk7mKpSFXqbppq4/qlW3yeKkUGE7mcmM3VHBwutH7IGUVmiTy998B8d0bBKahAOmLHmkynvAh+ySGA5fAzRpMU7AdrQctxMaTf5XN13n9Y8mg11l5EulLeOqoKuGNbpdr7BbA33Vpej3iU6be8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZDBwDnEH; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753185539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NOi+8KHVkjaz3TIe+vlIT+Tt0tHI/hRTrBNBmnrIfVI=;
	b=ZDBwDnEH6ZF6X45/ldSLpLzAbKbx/n2EiovqL7bqkJDIXefUeDIDchXtwU2V8gX8i0BKAp
	Aa/eRBVrQ1Fmuf+/t3B6jWZMkt0xDWJJIwQ6A+ZuOXDMFAc9mu+0l59LKIkJUHx1anVP4r
	1OKoWfZBtUxwV9skKs9/69y1rNELeZo=
From: Tao Chen <chen.dylane@linux.dev>
To: qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next v2 2/3] bpftool: Add bpftool-token manpage
Date: Tue, 22 Jul 2025 19:58:14 +0800
Message-ID: <20250722115815.1390761-2-chen.dylane@linux.dev>
In-Reply-To: <20250722115815.1390761-1-chen.dylane@linux.dev>
References: <20250722115815.1390761-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add bpftool-token manpage with information and examples of token-related
commands.

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 .../bpftool/Documentation/bpftool-token.rst   | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 tools/bpf/bpftool/Documentation/bpftool-token.rst

diff --git a/tools/bpf/bpftool/Documentation/bpftool-token.rst b/tools/bpf/bpftool/Documentation/bpftool-token.rst
new file mode 100644
index 00000000000..c5fe9292258
--- /dev/null
+++ b/tools/bpf/bpftool/Documentation/bpftool-token.rst
@@ -0,0 +1,63 @@
+.. SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+================
+bpftool-token
+================
+-------------------------------------------------------------------------------
+tool for inspection and simple manipulation of eBPF tokens
+-------------------------------------------------------------------------------
+
+:Manual section: 8
+
+.. include:: substitutions.rst
+
+SYNOPSIS
+========
+
+**bpftool** [*OPTIONS*] **token** *COMMAND*
+
+*OPTIONS* := { |COMMON_OPTIONS| }
+
+*COMMANDS* := { **show** | **list** | **help** }
+
+TOKEN COMMANDS
+===============
+
+| **bpftool** **token** { **show** | **list** }
+| **bpftool** **token help**
+|
+
+DESCRIPTION
+===========
+bpftool token { show | list }
+    List all the speciafic allowed types for **bpf**\ () system call
+    commands, maps, programs, and attach types, as well as the
+    *bpffs* mount point used to set the token information.
+
+bpftool prog help
+    Print short help message.
+
+OPTIONS
+========
+.. include:: common_options.rst
+
+EXAMPLES
+========
+|
+| **# mkdir -p /sys/fs/bpf/token**
+| **# mount -t bpf bpffs /sys/fs/bpf/token** \
+|         **-o delegate_cmds=prog_load:map_create** \
+|         **-o delegate_progs=kprobe** \
+|         **-o delegate_attachs=xdp**
+| **# bpftool token list**
+
+::
+
+    token_info  /sys/fs/bpf/token
+            allowed_cmds:
+              map_create          prog_load
+            allowed_maps:
+            allowed_progs:
+              kprobe
+            allowed_attachs:
+              xdp
-- 
2.48.1


