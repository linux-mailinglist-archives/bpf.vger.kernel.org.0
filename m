Return-Path: <bpf+bounces-63861-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8793CB0B769
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 19:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C50BA1880610
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 17:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF09224254;
	Sun, 20 Jul 2025 17:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aIjo3aDO"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73E122422E
	for <bpf@vger.kernel.org>; Sun, 20 Jul 2025 17:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753032825; cv=none; b=H6u2a/QxWM15ZmzwlYwBWBoC0sKCEUxsJEaNTjg++uQS/YYxbnITxdt8wx8bqLtFGu3OIGbwUT3onqsETvLoQD44dtfV7wDRwlzHwa2kEtfK9rWL0fsd3j2D5Oq+3Gupd6f+IYC47TO+FGicOvkqcgkl87SBatacm0a+0nJ7XxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753032825; c=relaxed/simple;
	bh=7piDxZD+/6lcwjU8xio9RWhYkXfI1Gyrf6/YmVG2CK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k2ExTHbskVHVNyPDj/TOBRq5N4Ec28ouP6gkSDnYo0Dze1jrxEZpnpfAuxMsVUsBrVf6eO9Wbpi8yWbPLStdiojJsg5kA3WmYPUVKUbVBcbcEQEh83YyFu5cjPg4Ps0WoKFShMR//+LGs946jK+usUgi+/6fE8GrOiH/SY1c2i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aIjo3aDO; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753032822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7rQp/hhc364P4O7TzVu1yv6J14pY7HWjzO5ACGT64QA=;
	b=aIjo3aDOdds5kr0Um/5vmk9A7Mjy1qRLqCq34osvWJFzfmfU0lmj648FdEkXEmThVrX9Em
	ZgvXvoTbzHnRHlBLUUHOoLS7huXQtWJ/4ZI/ec0NoyftNMiOg57QcZjzP4ofoArtiN+IyI
	+xpnP5dfrncUm7mq1IvvUe6ZM8d69OI=
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
Subject: [PATCH bpf-next 2/2] bpftool: Add bpftool-token manpage
Date: Mon, 21 Jul 2025 01:33:10 +0800
Message-ID: <20250720173310.1334483-2-chen.dylane@linux.dev>
In-Reply-To: <20250720173310.1334483-1-chen.dylane@linux.dev>
References: <20250720173310.1334483-1-chen.dylane@linux.dev>
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
 .../bpftool/Documentation/bpftool-token.rst   | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 tools/bpf/bpftool/Documentation/bpftool-token.rst

diff --git a/tools/bpf/bpftool/Documentation/bpftool-token.rst b/tools/bpf/bpftool/Documentation/bpftool-token.rst
new file mode 100644
index 00000000000..177f93c0bc7
--- /dev/null
+++ b/tools/bpf/bpftool/Documentation/bpftool-token.rst
@@ -0,0 +1,68 @@
+.. SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+================
+bpftool-token
+================
+-------------------------------------------------------------------------------
+tool for inspection and simple manipulation of eBPF progs
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
+    List all the concrete allowed_types for cmds maps progs attachs
+    and the bpffs mount_point used to set the token info.
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
+    token_info:
+            /sys/fs/bpf/token
+
+    allowed_cmds:
+            map_create          prog_load
+
+    allowed_maps:
+
+    allowed_progs:
+            kprobe
+
+    allowed_attachs:
+            xdp
+
-- 
2.48.1


