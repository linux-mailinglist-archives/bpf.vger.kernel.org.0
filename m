Return-Path: <bpf+bounces-28075-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D3B8B57A2
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 14:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 956462882C2
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 12:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9488A6CDBC;
	Mon, 29 Apr 2024 12:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j8u6Ry/C"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81ED5474D;
	Mon, 29 Apr 2024 12:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714392811; cv=none; b=GyDI2KQK0B3hLqzsqVgBXjq9IwhphvQTYdgwLcfYhF5HU8kd8AXFGZXnvPdKWJWvp+ZtTU5WIn0WdSxbp99d32y/ZF/T5/T6d8TMxXkbYavYPz56TYFy7svwTgiNZFshOgR97AYmZoNi9D+SFPRlfMezG6MIfLGZuzoNRCoPCUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714392811; c=relaxed/simple;
	bh=0IDV4wwXjhB7GAsTZK4UtfbDqgXcZqHx4iXcoFYyL98=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TS9X8pJR6x5DFnuolRv40z7zM7FuEkUELyMTWMoymacsfULxCB9OJKB9cK0VqdZxjbEGlpsKorW32Km3lv8zlYm/LM7nlsRsZYD9qF7Cb3NrLCr8gmhMfBAzQQtnuUrQdj4nsNhb+BZo8Ji3xtrQlevhnfAWnLAIdlsqG6gJCOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j8u6Ry/C; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714392810; x=1745928810;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0IDV4wwXjhB7GAsTZK4UtfbDqgXcZqHx4iXcoFYyL98=;
  b=j8u6Ry/Cd1X3xeoM9dPpMUPXf2MzXrN9NnTIhdxYeSha1g8xW5NVexew
   gzp5YZoNZxZdtYghF+N4FhU0BHSHCHTb5jMnSCyEMvy6DscOgdki5B4OD
   jtdeQbKJ4JgRtyijMrdzUQdbSFlCL3hDlP047sqJXyD+GvZZ2+Pz051DN
   oph6+n1PKzUcmsCccRzJdh7TH8lnAHBS7OEe8hXjq973YpPWLQjc4lVMk
   A9MVXrR//dLPUnB+km2770Ul8e4+PPL3m8PjO5pnWAghhlLgdkm3NeUy+
   lAHQPs0GHWfs6zZGxcVxFsDW7ClktpX1NgXxUl3ZQfUVA4URrW55FeTbc
   g==;
X-CSE-ConnectionGUID: nV1uzaFQQ/Gm3SBINfkdBA==
X-CSE-MsgGUID: vJSuUidrQFyG6KLVVYr92Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="35440894"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="35440894"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 05:13:29 -0700
X-CSE-ConnectionGUID: HP79hpQ0TC2blCYLTzid+g==
X-CSE-MsgGUID: iY5ZkRPpRS2Ky2XYZSEJfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26603701"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 29 Apr 2024 05:13:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 23FDA15B; Mon, 29 Apr 2024 15:13:24 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alexei Starovoitov <ast@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] bpf: Use struct_size()
Date: Mon, 29 Apr 2024 15:13:22 +0300
Message-ID: <20240429121323.3818497-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use struct_size() instead of hand writing it.
This is less verbose and more robust.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/bpf/core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 778775bdbb2e..6047979d5be6 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -25,6 +25,7 @@
 #include <linux/bpf.h>
 #include <linux/btf.h>
 #include <linux/objtool.h>
+#include <linux/overflow.h>
 #include <linux/rbtree_latch.h>
 #include <linux/kallsyms.h>
 #include <linux/rcupdate.h>
@@ -2455,13 +2456,14 @@ EXPORT_SYMBOL(bpf_empty_prog_array);
 
 struct bpf_prog_array *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags)
 {
-	if (prog_cnt)
-		return kzalloc(sizeof(struct bpf_prog_array) +
-			       sizeof(struct bpf_prog_array_item) *
-			       (prog_cnt + 1),
-			       flags);
+	struct bpf_prog_array *p;
 
-	return &bpf_empty_prog_array.hdr;
+	if (prog_cnt)
+		p = kzalloc(struct_size(p, items, prog_cnt + 1), flags);
+	else
+		p = &bpf_empty_prog_array.hdr;
+
+	return p;
 }
 
 void bpf_prog_array_free(struct bpf_prog_array *progs)
-- 
2.43.0.rc1.1336.g36b5255a03ac


