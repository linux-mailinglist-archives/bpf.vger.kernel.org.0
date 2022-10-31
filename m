Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A3661409F
	for <lists+bpf@lfdr.de>; Mon, 31 Oct 2022 23:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiJaWZ4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 31 Oct 2022 18:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiJaWZ4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 31 Oct 2022 18:25:56 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766AF14082
        for <bpf@vger.kernel.org>; Mon, 31 Oct 2022 15:25:55 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29VMPHEP031035
        for <bpf@vger.kernel.org>; Mon, 31 Oct 2022 15:25:54 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kjn3f90wh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 31 Oct 2022 15:25:54 -0700
Received: from twshared13940.35.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 15:25:52 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 1D1CAF0CC5A7; Mon, 31 Oct 2022 15:25:48 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <akpm@linux-foundation.org>, <x86@kernel.org>,
        <peterz@infradead.org>, <hch@lst.de>, <rick.p.edgecombe@intel.com>,
        <dave.hansen@intel.com>, <mcgrof@kernel.org>,
        Song Liu <song@kernel.org>
Subject: [PATCH bpf-next v1 RESEND 0/5] vmalloc_exec for modules and BPF programs
Date:   Mon, 31 Oct 2022 15:25:36 -0700
Message-ID: <20221031222541.1773452-1-song@kernel.org>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: pNIGQPWWSyXnNfj3R6FHAG8QLrB99yTg
X-Proofpoint-GUID: pNIGQPWWSyXnNfj3R6FHAG8QLrB99yTg
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_21,2022-10-31_01,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Original email didn't make to lore, resend with a shorter CC list.

This set enables bpf programs and bpf dispatchers to share huge pages with
new API:
  vmalloc_exec()
  vfree_exec()
  vcopy_exec()

The idea is similar to Peter's suggestion in [1].

vmalloc_exec() manages a set of PMD_SIZE RO+X memory, and allocates these
memory to its users. vfree_exec() is used to free memory allocated by
vmalloc_exec(). vcopy_exec() is used to update memory allocated by
vmalloc_exec().

Memory allocated by vmalloc_exec() is RO+X, so this doesnot violate W^X.
The caller has to update the content with text_poke like mechanism.
Specifically, vcopy_exec() is provided to update memory allocated by
vmalloc_exec(). vcopy_exec() also makes sure the update stays in the
boundary of one chunk allocated by vmalloc_exec(). Please refer to patch
1/5 for more details of

Patch 3/5 uses these new APIs in bpf program and bpf dispatcher.

Patch 4/5 and 5/5 allows static kernel text (_stext to _etext) to share
PMD_SIZE pages with dynamic kernel text on x86_64. This is achieved by
allocating PMD_SIZE pages to roundup(_etext, PMD_SIZE), and then use
_etext to roundup(_etext, PMD_SIZE) for dynamic kernel text.

[1] https://lore.kernel.org/bpf/Ys6cWUMHO8XwyYgr@hirez.programming.kicks-ass.net/
[2] RFC v1: https://lore.kernel.org/linux-mm/20220818224218.2399791-3-song@kernel.org/T/

Changes RFC v2 => PATCH v1:
1. Add vcopy_exec(), which updates memory allocated by vmalloc_exec(). It
   also ensures vcopy_exec() is only used to update memory from one single
   vmalloc_exec() call. (Christoph Hellwig)
2. Add arch_vcopy_exec() and arch_invalidate_exec() as wrapper for the
   text_poke() like logic.
3. Drop changes for kernel modules and focus on BPF side changes.

Changes RFC v1 => RFC v2:
1. Major rewrite of the logic of vmalloc_exec and vfree_exec. They now
   work fine with BPF programs (patch 1, 2, 4). But module side (patch 3)
   still need some work.

Song Liu (5):
  vmalloc: introduce vmalloc_exec, vfree_exec, and vcopy_exec
  x86/alternative: support vmalloc_exec() and vfree_exec()
  bpf: use vmalloc_exec for bpf program and bpf dispatcher
  vmalloc: introduce register_text_tail_vm()
  x86: use register_text_tail_vm

 arch/x86/include/asm/pgtable_64_types.h |   1 +
 arch/x86/kernel/alternative.c           |  12 +
 arch/x86/mm/init_64.c                   |   4 +-
 arch/x86/net/bpf_jit_comp.c             |  23 +-
 include/linux/bpf.h                     |   3 -
 include/linux/filter.h                  |   5 -
 include/linux/vmalloc.h                 |   9 +
 kernel/bpf/core.c                       | 180 +-----------
 kernel/bpf/dispatcher.c                 |  11 +-
 mm/nommu.c                              |   7 +
 mm/vmalloc.c                            | 351 ++++++++++++++++++++++++
 11 files changed, 404 insertions(+), 202 deletions(-)

--
2.30.2
