Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 630FD4A9F92
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 19:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiBDS75 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 4 Feb 2022 13:59:57 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:2278 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229457AbiBDS75 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Feb 2022 13:59:57 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 214IirLE010108
        for <bpf@vger.kernel.org>; Fri, 4 Feb 2022 10:59:57 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e0w2fv9jb-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 04 Feb 2022 10:59:56 -0800
Received: from twshared11487.23.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Feb 2022 10:59:56 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 9CDC5296C5722; Fri,  4 Feb 2022 10:57:49 -0800 (PST)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kernel-team@fb.com>, <peterz@infradead.org>, <x86@kernel.org>,
        <iii@linux.ibm.com>, Song Liu <song@kernel.org>
Subject: [PATCH v9 bpf-next 0/9] bpf_prog_pack allocator
Date:   Fri, 4 Feb 2022 10:57:33 -0800
Message-ID: <20220204185742.271030-1-song@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: CTnhYxwqtDMAbDkK9g2HZLYpfoP0NpEK
X-Proofpoint-ORIG-GUID: CTnhYxwqtDMAbDkK9g2HZLYpfoP0NpEK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-04_07,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 lowpriorityscore=0
 phishscore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=719
 impostorscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202040104
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Changes v8 => v9:
1. Fix an error with multi function program, in 4/9.

Changes v7 => v8:
1. Rebase and fix conflicts.
2. Lock text_mutex for text_poke_copy. (Daniel)

Changes v6 => v7:
1. Redesign the interface between generic and arch logic, based on feedback
   from Alexei and Ilya.
2. Split 6/7 of v6 to 7/9 and 8/9 in v7, for cleaner logic.
3. Add bpf_arch_text_copy in 6/9.

Changes v5 => v6:
1. Make jit_hole_buffer 128 byte long. Only fill the first and last 128
   bytes of header with INT3. (Alexei)
2. Use kvmalloc for temporary buffer. (Alexei)
3. Rename tmp_header/tmp_image => rw_header/rw_image. Remove tmp_image from
   x64_jit_data. (Alexei)
4. Change fall back round_up_to in bpf_jit_binary_alloc_pack() from
   BPF_PROG_MAX_PACK_PROG_SIZE to PAGE_SIZE.

Changes v4 => v5:
1. Do not use atomic64 for bpf_jit_current. (Alexei)

Changes v3 => v4:
1. Rename text_poke_jit() => text_poke_copy(). (Peter)
2. Change comment style. (Peter)

Changes v2 => v3:
1. Fix tailcall.

Changes v1 => v2:
1. Use text_poke instead of writing through linear mapping. (Peter)
2. Avoid making changes to non-x86_64 code.

Most BPF programs are small, but they consume a page each. For systems
with busy traffic and many BPF programs, this could also add significant
pressure to instruction TLB. High iTLB pressure usually causes slow down
for the whole system, which includes visible performance degradation for
production workloads.

This set tries to solve this problem with customized allocator that pack
multiple programs into a huge page.

Patches 1-6 prepare the work. Patch 7 contains key logic of bpf_prog_pack
allocator. Patch 8 contains bpf_jit_binary_pack_alloc logic on top of
bpf_prog_pack allocator. Patch 9 uses this allocator in x86_64 jit.

Song Liu (9):
  x86/Kconfig: select HAVE_ARCH_HUGE_VMALLOC with HAVE_ARCH_HUGE_VMAP
  bpf: use bytes instead of pages for bpf_jit_[charge|uncharge]_modmem
  bpf: use size instead of pages in bpf_binary_header
  bpf: use prog->jited_len in  bpf_prog_ksym_set_addr()
  x86/alternative: introduce text_poke_copy
  bpf: introduce bpf_arch_text_copy
  bpf: introduce bpf_prog_pack allocator
  bpf: introduce bpf_jit_binary_pack_[alloc|finalize|free]
  bpf, x86_64: use bpf_jit_binary_pack_alloc

 arch/x86/Kconfig                     |   1 +
 arch/x86/include/asm/text-patching.h |   1 +
 arch/x86/kernel/alternative.c        |  34 ++++
 arch/x86/net/bpf_jit_comp.c          |  65 ++++---
 include/linux/bpf.h                  |   7 +-
 include/linux/filter.h               |  27 +--
 kernel/bpf/core.c                    | 269 +++++++++++++++++++++++++--
 kernel/bpf/trampoline.c              |   6 +-
 kernel/bpf/verifier.c                |   1 +
 9 files changed, 349 insertions(+), 62 deletions(-)

--
2.30.2
