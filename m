Return-Path: <bpf+bounces-64174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01458B0F5B7
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 16:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C097C3A2224
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 14:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87862E92DE;
	Wed, 23 Jul 2025 14:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c7q3w663"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4770A280CE5
	for <bpf@vger.kernel.org>; Wed, 23 Jul 2025 14:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753281935; cv=none; b=lPd8mbKMztbYglLfR43Xr02hxS4r4G2LkebZ8Yn7F5r9WFXNqH9rlR1nTMQukF3i/4FW+aoigsHy66KMlWahAhiy0A5XwQ/ySyRVHoD7zuGtt1ZjbkDeydI5KA9R3hU/XnMhCDmhHlXR71oharSPG1yyKK0+Djie+WExzgpTMCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753281935; c=relaxed/simple;
	bh=M3nihTIT40z3oIjYiP0GIe8UPkVySJK1u08zFyLxoWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hGI/4sWFVITp8ZVYciJFyyu0U9KA2OMtn0g9UMs2vKPKHgM8Tuu66SxG2pVonkqO/XCxHDgeia8Vrjh6Rmj1wnSoSBSsXLPRU23m3hBSCdr533+LmrsS0BNxCgwepAgjmfHU6yzl6ApliDEPdXdy8eVk97oEDhs7PvBcVp+3VGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c7q3w663; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753281930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6d60Wr2Pbx/3WpAhV8k2HNDgAcvgcbADa5+vV1Vw27Q=;
	b=c7q3w663P6pMqQZQ79RubktjjWMqhUmDZ6+hA1jGsAA5FHsSDDJzShLRUHmvjPkF0SJx90
	33ECFl8SSakdpF1xxXFWayhKuCAFpwFO2eHh+bhSl4MV2uGZZZZAdRawwaz3pnyqCdXGWN
	zsPe+G112LECTcE3k6Wbg0zphb7HBYI=
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
Subject: [PATCH bpf-next v4 2/3] bpftool: Add bpftool-token manpage
Date: Wed, 23 Jul 2025 22:44:41 +0800
Message-ID: <20250723144442.1427943-2-chen.dylane@linux.dev>
In-Reply-To: <20250723144442.1427943-1-chen.dylane@linux.dev>
References: <20250723144442.1427943-1-chen.dylane@linux.dev>
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

Suggested-by: Quentin Monnet <qmo@kernel.org>
Reviewed-by: Quentin Monnet <qmo@kernel.org>
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 .../bpftool/Documentation/bpftool-token.rst   | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 tools/bpf/bpftool/Documentation/bpftool-token.rst

diff --git a/tools/bpf/bpftool/Documentation/bpftool-token.rst b/tools/bpf/bpftool/Documentation/bpftool-token.rst
new file mode 100644
index 00000000000..d082c499cfe
--- /dev/null
+++ b/tools/bpf/bpftool/Documentation/bpftool-token.rst
@@ -0,0 +1,64 @@
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
+    List BPF token information for each *bpffs* mount point containing token
+    information on the system. Information include mount point path, allowed
+    **bpf**\ () system call commands, maps, programs, and attach types for the
+    token.
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


