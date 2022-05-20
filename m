Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA5952F674
	for <lists+bpf@lfdr.de>; Sat, 21 May 2022 02:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354161AbiEUAAm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 20 May 2022 20:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236380AbiEUAAk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 May 2022 20:00:40 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9098E1A0AE2
        for <bpf@vger.kernel.org>; Fri, 20 May 2022 17:00:39 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 24KMsAmE021874
        for <bpf@vger.kernel.org>; Fri, 20 May 2022 17:00:38 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3g5wkrg2ru-14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 20 May 2022 17:00:38 -0700
Received: from twshared8307.18.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 20 May 2022 17:00:35 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 1FA317E2217E; Fri, 20 May 2022 16:58:07 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-mm@kvack.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <peterz@infradead.org>,
        <mcgrof@kernel.org>, <torvalds@linux-foundation.org>,
        <rick.p.edgecombe@intel.com>, <kernel-team@fb.com>,
        Song Liu <song@kernel.org>
Subject: [PATCH v4 bpf-next 0/8] bpf_prog_pack followup
Date:   Fri, 20 May 2022 16:57:50 -0700
Message-ID: <20220520235758.1858153-1-song@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: n4z1ZKzl6ar-TiiZsxPNcp1p4ffEsagV
X-Proofpoint-ORIG-GUID: n4z1ZKzl6ar-TiiZsxPNcp1p4ffEsagV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-20_08,2022-05-20_02,2022-02-23_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Changes v3 => v4:
1. Shorten CC list on 4/8, so it is not dropped by the mail list.

Changes v2 => v3:
1. Fix issues reported by kernel test robot <lkp@intel.com>.

Changes v1 => v2:
1. Add WARN to set_vm_flush_reset_perms() on huge pages. (Rick Edgecombe)
2. Simplify select_bpf_prog_pack_size. (Rick Edgecombe)

As of 5.18-rc6, x86_64 uses bpf_prog_pack on 4kB pages. This set contains
a few followups:
  1/8 - 3/8 fills unused part of bpf_prog_pack with illegal instructions.
  4/8 - 5/8 enables bpf_prog_pack on 2MB pages.

The primary goal of bpf_prog_pack is to reduce iTLB miss rate and reduce
direct memory mapping fragmentation. This leads to non-trivial performance
improvements.

For our web service production benchmark, bpf_prog_pack on 4kB pages
gives 0.5% to 0.7% more throughput than not using bpf_prog_pack.
bpf_prog_pack on 2MB pages 0.6% to 0.9% more throughput than not using
bpf_prog_pack. Note that 0.5% is a huge improvement for our fleet. I
believe this is also significant for other companies with many thousand
servers.

bpf_prog_pack on 2MB pages may use slightly more memory for systems
without many BPF programs. However, such waste in memory (<2MB) is within
noisy for modern x86_64 systems.

Song Liu (8):
  bpf: fill new bpf_prog_pack with illegal instructions
  x86/alternative: introduce text_poke_set
  bpf: introduce bpf_arch_text_invalidate for bpf_prog_pack
  module: introduce module_alloc_huge
  bpf: use module_alloc_huge for bpf_prog_pack
  vmalloc: WARN for set_vm_flush_reset_perms() on huge pages
  vmalloc: introduce huge_vmalloc_supported
  bpf: simplify select_bpf_prog_pack_size

 arch/x86/include/asm/text-patching.h |  1 +
 arch/x86/kernel/alternative.c        | 67 +++++++++++++++++++++++-----
 arch/x86/kernel/module.c             | 21 +++++++++
 arch/x86/net/bpf_jit_comp.c          |  5 +++
 include/linux/bpf.h                  |  1 +
 include/linux/moduleloader.h         |  5 +++
 include/linux/vmalloc.h              |  7 +++
 kernel/bpf/core.c                    | 43 ++++++++++--------
 kernel/module.c                      |  8 ++++
 mm/vmalloc.c                         |  5 +++
 10 files changed, 134 insertions(+), 29 deletions(-)

--
2.30.2
