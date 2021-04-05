Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 056083547AB
	for <lists+bpf@lfdr.de>; Mon,  5 Apr 2021 22:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240992AbhDEUls (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Apr 2021 16:41:48 -0400
Received: from mga02.intel.com ([134.134.136.20]:54260 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234188AbhDEUlq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Apr 2021 16:41:46 -0400
IronPort-SDR: oQ9xwH8mW8JA+RIY8Wo9Jal6l/rGmcU1lGGQMt/A3qsN6qjvnfmxEddopEYleG1yAwISoZBdJB
 DLjWKAQjTSmw==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="180051522"
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="180051522"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 13:41:32 -0700
IronPort-SDR: QFEDzoWXO1ygMicp1OeYto9bUwmZvOPj374kIoHYcrRxoffFr+5T26SS/8qXoJyO1fia6fCPJc
 OgSg/xsMC1tw==
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="418078025"
Received: from rpedgeco-mobl3.amr.corp.intel.com (HELO localhost.intel.com) ([10.212.230.218])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 13:41:32 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org, bpf@vger.kernel.org,
        dave.hansen@linux.intel.com, peterz@infradead.org, luto@kernel.org,
        jeyu@kernel.org
Cc:     linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, hch@infradead.org, x86@kernel.org,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [RFC 0/3] Group pages on the direct map for permissioned vmallocs
Date:   Mon,  5 Apr 2021 13:37:08 -0700
Message-Id: <20210405203711.1095940-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

This is a followup to the previous attempt to overhaul how vmalloc permissions
are done:
https://lore.kernel.org/lkml/20201120202426.18009-1-rick.p.edgecombe@intel.com/

In working on a next version it dawned on me that we can significantly reduce
direct map breakage on x86 with a much less invasive change, so I thought maybe
I would start there in the meantime.

In a test of booting fedora and running the BPF unit tests, this reduced 4k
direct map pages by 98%.

It simply uses pages for x86 module_alloc() mappings from a cache created out of
2MB pages. This results in all the later breakage clustering in 2MB blocks on
the direct map. The trade-off is colder pages are used for these allocations.
All module_alloc() users (modules, ebpf jit, ftrace, kprobes) get this behavior.

Potentially this behavior should be enabled for eBPF byte code allocations as
well in the case of !CONFIG_BPF_JIT_ALWAYS_ON.

The new APIs and invasive changes in the callers can happen after vmalloc huge
pages bring more benefits. Although, I can post shootdown reduction changes with
previous comments integrated if anyone disagrees.

Based on v5.11.

Thanks,

Rick


Rick Edgecombe (3):
  list: Support getting most recent element in list_lru
  vmalloc: Support grouped page allocations
  x86/module: Use VM_GROUP_PAGES flag

 arch/x86/Kconfig         |   1 +
 arch/x86/kernel/module.c |   2 +-
 include/linux/list_lru.h |  13 +++
 include/linux/vmalloc.h  |   1 +
 mm/Kconfig               |   9 ++
 mm/list_lru.c            |  28 +++++
 mm/vmalloc.c             | 215 +++++++++++++++++++++++++++++++++++++--
 7 files changed, 257 insertions(+), 12 deletions(-)

-- 
2.29.2

