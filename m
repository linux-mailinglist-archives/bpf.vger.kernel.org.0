Return-Path: <bpf+bounces-28765-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2498BDB78
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 08:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC377B22F2E
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 06:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA63E6F08B;
	Tue,  7 May 2024 06:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MugYcY8m"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2AA6BB4E;
	Tue,  7 May 2024 06:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715063400; cv=none; b=DRx2KmrNdq5ZePBdLHslkyXUY7+WJ68kxEVTXecfSVZTK4Ntsv3+36qh+Sj2K+m+SgnL14VFIq8Q9Uu5Ojg048RpdqN10pjWgCtptdgHPQrXqIi0+1kC+rjn2EwYDqPUaQliljejyWBmn5g5uaUnvi8ZGjX0WIKtM3nWlfgrRO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715063400; c=relaxed/simple;
	bh=56e8bED4V6W28096yUKf8RNEXz6YOYzyF3VADr9TI8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ChSFIfwU1dwaR7373ajUWNJLdnH8zlzDN494BhDykZODwQfN/pG1/uABph05Zq7RW3xiLpkw/YdZM27uLaNpuDlephKjmLXg9G4Z3bwip6f0vh16dc6IJt3w6FrA/O6joyY1czA3iwYvjpj7gQvM6CfgkSrKTvEbCAtbWAt7MrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MugYcY8m; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715063399; x=1746599399;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=56e8bED4V6W28096yUKf8RNEXz6YOYzyF3VADr9TI8I=;
  b=MugYcY8moHc+6DetqGQuaudOjoD6JL70gK/mRj2Q79CAZn5b/g6OGEAW
   goNJeSs45qt4+2RiTGtd8Q0pqMJ2woWuq7P6Vc8J6iUTZFlZPxdAnWtRM
   Ip6xEjKSRGlpvPEfaN2yrqw/8vjvvN8c1sRwbAHf6zNA9iNBNEXbZYQ+S
   3CRgU5b0Fp493njPGjWzInecfM5PZqA7jy9FPN9VQllGG6FQ6tYgzjFqa
   9MTmtGOE0h7nj8SxsJPUeuhPbZmEtqQFv7jrdpgXyEseQ47XqDS3TW2xa
   phdwQIolbLztN3YdSvjAiLIF+IaYACg7zKbb+SQxyeRpQ3zhiQMdqwbu5
   w==;
X-CSE-ConnectionGUID: i1HkxT/OScufA5Ky3LnD3A==
X-CSE-MsgGUID: ANjC379ASXKR5Ghx/VFMMg==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="28310310"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="scan'208";a="28310310"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 23:29:58 -0700
X-CSE-ConnectionGUID: ZbdwN7B/QKOYWMvoqZTbhg==
X-CSE-MsgGUID: rhqLLXceR/WPYY+cor1KiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="scan'208";a="32872739"
Received: from unknown (HELO dcai-bmc-sherry-1.sh.intel.com) ([10.239.138.57])
  by fmviesa005.fm.intel.com with ESMTP; 06 May 2024 23:29:54 -0700
From: Haiyue Wang <haiyue.wang@intel.com>
To: bpf@vger.kernel.org
Cc: Haiyue Wang <haiyue.wang@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH bpf-next v1] bpf,arena: Remove redundant page mask of vmf->address
Date: Tue,  7 May 2024 14:33:39 +0800
Message-ID: <20240507063358.8048-1-haiyue.wang@intel.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the comment described in "struct vm_fault":
	".address"      : 'Faulting virtual address - masked'
	".real_address" : 'Faulting virtual address - unmasked'

The link [1] said: "Whatever the routes, all architectures end up to the
invocation of handle_mm_fault() which, in turn, (likely) ends up calling
__handle_mm_fault() to carry out the actual work of allocating the page
tables."

  __handle_mm_fault() does address assignment:
	.address = address & PAGE_MASK,
	.real_address = address,

This is debug dump by running `./test_progs -a "*arena*"`:

[   69.767494] arena fault: vmf->address = 10000001d000, vmf->real_address = 10000001d008
[   69.767496] arena fault: vmf->address = 10000001c000, vmf->real_address = 10000001c008
[   69.767499] arena fault: vmf->address = 10000001b000, vmf->real_address = 10000001b008
[   69.767501] arena fault: vmf->address = 10000001a000, vmf->real_address = 10000001a008
[   69.767504] arena fault: vmf->address = 100000019000, vmf->real_address = 100000019008
[   69.769388] arena fault: vmf->address = 10000001e000, vmf->real_address = 10000001e1e8

So we can use the value of 'vmf->address' to do BPF arena kernel address
space cast directly.

[1] https://docs.kernel.org/mm/page_tables.html

Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
---
 kernel/bpf/arena.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 343c3456c8dd..1876dc7ebb57 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -251,7 +251,7 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 	int ret;
 
 	kbase = bpf_arena_get_kern_vm_start(arena);
-	kaddr = kbase + (u32)(vmf->address & PAGE_MASK);
+	kaddr = kbase + (u32)(vmf->address);
 
 	guard(mutex)(&arena->lock);
 	page = vmalloc_to_page((void *)kaddr);
-- 
2.43.2


