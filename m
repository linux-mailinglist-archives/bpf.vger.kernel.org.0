Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3C73547AC
	for <lists+bpf@lfdr.de>; Mon,  5 Apr 2021 22:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240609AbhDEUlt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Apr 2021 16:41:49 -0400
Received: from mga02.intel.com ([134.134.136.20]:54275 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240500AbhDEUlr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Apr 2021 16:41:47 -0400
IronPort-SDR: voWszRK1kPU0fW71aDRKvntyJeSCnk2nuh//fZ3fG8zji9FeB4oeAimOm77I2MUXlSW25NOWtk
 yexhh16/bxqA==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="180051526"
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="180051526"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 13:41:33 -0700
IronPort-SDR: nWL2dehIuIdFpPZ4amo3hpqkP2l9cuMSirVmKkTi1KXid4RjuNI928X96mGKNQpFtU89t0LHmq
 2gfDbyTy7biw==
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="418078038"
Received: from rpedgeco-mobl3.amr.corp.intel.com (HELO localhost.intel.com) ([10.212.230.218])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 13:41:33 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org, bpf@vger.kernel.org,
        dave.hansen@linux.intel.com, peterz@infradead.org, luto@kernel.org,
        jeyu@kernel.org
Cc:     linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, hch@infradead.org, x86@kernel.org,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [RFC 3/3] x86/module: Use VM_GROUP_PAGES flag
Date:   Mon,  5 Apr 2021 13:37:11 -0700
Message-Id: <20210405203711.1095940-4-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210405203711.1095940-1-rick.p.edgecombe@intel.com>
References: <20210405203711.1095940-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Callers of module_alloc() will set permissions on the allocation. Use
the VM_GROUP_PAGES to reduce direct map breakage.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/kernel/module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index 34b153cbd4ac..9161ce0e987f 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -75,7 +75,7 @@ void *module_alloc(unsigned long size)
 	p = __vmalloc_node_range(size, MODULE_ALIGN,
 				    MODULES_VADDR + get_module_load_offset(),
 				    MODULES_END, GFP_KERNEL,
-				    PAGE_KERNEL, 0, NUMA_NO_NODE,
+				    PAGE_KERNEL, VM_GROUP_PAGES, NUMA_NO_NODE,
 				    __builtin_return_address(0));
 	if (p && (kasan_module_alloc(p, size) < 0)) {
 		vfree(p);
-- 
2.29.2

