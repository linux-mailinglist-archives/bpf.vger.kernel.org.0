Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 264CF5A22C
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2019 19:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbfF1RWU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Jun 2019 13:22:20 -0400
Received: from mga18.intel.com ([134.134.136.126]:17946 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbfF1RWU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Jun 2019 13:22:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2019 10:22:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,428,1557212400"; 
   d="scan'208";a="183727016"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 28 Jun 2019 10:22:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4575D130; Fri, 28 Jun 2019 20:22:16 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] tools: Keep list of tools in alphabetical order
Date:   Fri, 28 Jun 2019 20:22:09 +0300
Message-Id: <20190628172209.37290-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When `make help` is executed it lists the possible tools to build,
though couple of entries is kept unordered. Fix it here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 tools/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/Makefile b/tools/Makefile
index 3dfd72ae6c1a..02585735320c 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -10,6 +10,7 @@ help:
 	@echo 'Possible targets:'
 	@echo ''
 	@echo '  acpi                   - ACPI tools'
+	@echo '  bpf                    - misc BPF tools'
 	@echo '  cgroup                 - cgroup tools'
 	@echo '  cpupower               - a tool for all things x86 CPU power'
 	@echo '  debugging              - tools for debugging'
@@ -22,12 +23,11 @@ help:
 	@echo '  kvm_stat               - top-like utility for displaying kvm statistics'
 	@echo '  leds                   - LEDs  tools'
 	@echo '  liblockdep             - user-space wrapper for kernel locking-validator'
-	@echo '  bpf                    - misc BPF tools'
+	@echo '  objtool                - an ELF object analysis tool'
 	@echo '  pci                    - PCI tools'
 	@echo '  perf                   - Linux performance measurement and analysis tool'
 	@echo '  selftests              - various kernel selftests'
 	@echo '  spi                    - spi tools'
-	@echo '  objtool                - an ELF object analysis tool'
 	@echo '  tmon                   - thermal monitoring and tuning tool'
 	@echo '  turbostat              - Intel CPU idle stats and freq reporting tool'
 	@echo '  usb                    - USB testing tools'
-- 
2.20.1

