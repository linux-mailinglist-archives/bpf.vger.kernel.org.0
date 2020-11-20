Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C81292BB6ED
	for <lists+bpf@lfdr.de>; Fri, 20 Nov 2020 21:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730762AbgKTUaX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Nov 2020 15:30:23 -0500
Received: from mga07.intel.com ([134.134.136.100]:10351 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731028AbgKTUaF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Nov 2020 15:30:05 -0500
IronPort-SDR: otZFfCoVRRW2Uo5wohzoHrfbawoByO9UYV5ROVaAZQipW3OuxU4ER+Uh6dOe3RYnGjnJWg9bIB
 IXE7Hf17yNrA==
X-IronPort-AV: E=McAfee;i="6000,8403,9811"; a="235683307"
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="235683307"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 12:30:04 -0800
IronPort-SDR: U72t0mwZ0fnOScOzQ+Cap1KnJJ99WrXmxF1BTKUleIlNidw12qKWyWmE3jcq71e92pPJ/C0z1M
 wXnoMBoRm+QA==
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="342163315"
Received: from rpedgeco-mobl.amr.corp.intel.com (HELO localhost.intel.com) ([10.209.105.214])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 12:30:03 -0800
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     akpm@linux-foundation.org, jeyu@kernel.org, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, luto@kernel.org,
        dave.hansen@linux.intel.com, peterz@infradead.org, x86@kernel.org,
        rppt@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com
Cc:     elena.reshetova@intel.com, ira.weiny@intel.com,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH RFC 07/10] x86/unwind: Unwind orc at module writable address
Date:   Fri, 20 Nov 2020 12:24:23 -0800
Message-Id: <20201120202426.18009-8-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201120202426.18009-1-rick.p.edgecombe@intel.com>
References: <20201120202426.18009-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Since modules can have a separate writable address during loading,
do the orc unwind at the writable address.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/kernel/unwind_orc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 73f800100066..41f9022a10cc 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -238,8 +238,8 @@ static int orc_sort_cmp(const void *_a, const void *_b)
 void unwind_module_init(struct module *mod, void *_orc_ip, size_t orc_ip_size,
 			void *_orc, size_t orc_size)
 {
-	int *orc_ip = _orc_ip;
-	struct orc_entry *orc = _orc;
+	int *orc_ip = module_adjust_writable_addr(_orc_ip);
+	struct orc_entry *orc = module_adjust_writable_addr(_orc);
 	unsigned int num_entries = orc_ip_size / sizeof(int);
 
 	WARN_ON_ONCE(orc_ip_size % sizeof(int) != 0 ||
@@ -257,8 +257,8 @@ void unwind_module_init(struct module *mod, void *_orc_ip, size_t orc_ip_size,
 	sort(orc_ip, num_entries, sizeof(int), orc_sort_cmp, orc_sort_swap);
 	mutex_unlock(&sort_mutex);
 
-	mod->arch.orc_unwind_ip = orc_ip;
-	mod->arch.orc_unwind = orc;
+	mod->arch.orc_unwind_ip = _orc_ip;
+	mod->arch.orc_unwind = _orc;
 	mod->arch.num_orcs = num_entries;
 }
 #endif
-- 
2.20.1

