Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD406EEB13
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 01:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236876AbjDYXt3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 25 Apr 2023 19:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236694AbjDYXt3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 19:49:29 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3DDB219
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 16:49:27 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 33PLEboI023086
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 16:49:27 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3q6531ftvn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 16:49:27 -0700
Received: from twshared34392.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 25 Apr 2023 16:49:26 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id BC9022F2D8325; Tue, 25 Apr 2023 16:49:14 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 00/10] Add precision propagation for subprogs and callbacks
Date:   Tue, 25 Apr 2023 16:49:01 -0700
Message-ID: <20230425234911.2113352-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: EMFpVCkwYfXdDehHr5Bu8AkX9dbYOfMY
X-Proofpoint-ORIG-GUID: EMFpVCkwYfXdDehHr5Bu8AkX9dbYOfMY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_10,2023-04-25_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

As more and more real-world BPF programs become more complex
and increasingly use subprograms (both static and global), scalar precision
tracking and its (previously weak) support for BPF subprograms (and callbacks
as a special case of that) is becoming more and more of an issue and
limitation. Couple that with increasing reliance on state equivalence (BPF
open-coded iterators have a hard requirement for state equivalence to converge
and successfully validate loops), and it becomes pretty critical to address
this limitation and make precision tracking universally supported for BPF
programs of any complexity and composition.

This patch set teaches BPF verifier to support SCALAR precision
backpropagation across multiple frames (for subprogram calls and callback
simulations) and addresses most practical situations (SCALAR stack
loads/stores using registers other than r10 being the last remaining
limitation, though thankfully rarely used in practice).

Main logic is explained in details in patch #8. The rest are preliminary
preparations, refactorings, clean ups, and fixes. See respective patches for
details.

Patch #8 has also veristat comparison of results for selftests, Cilium, and
some of Meta production BPF programs before and after these changes.

Andrii Nakryiko (10):
  veristat: add -t flag for adding BPF_F_TEST_STATE_FREQ program flag
  bpf: mark relevant stack slots scratched for register read instructions
  bpf: encapsulate precision backtracking bookkeeping
  bpf: improve precision backtrack logging
  bpf: maintain bitmasks across all active frames in __mark_chain_precision
  bpf: fix propagate_precision() logic for inner frames
  bpf: fix mark_all_scalars_precise use in mark_chain_precision
  bpf: support precision propagation in the presence of subprogs
  selftests/bpf: add precision propagation tests in the presence of subprogs
  selftests/bpf: revert iter test subprog precision workaround

 include/linux/bpf_verifier.h                  |  28 +-
 kernel/bpf/verifier.c                         | 608 ++++++++++++++----
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   4 +
 tools/testing/selftests/bpf/progs/iters.c     |  26 +-
 .../bpf/progs/verifier_subprog_precision.c    | 536 +++++++++++++++
 .../testing/selftests/bpf/verifier/precise.c  | 107 +--
 tools/testing/selftests/bpf/veristat.c        |   9 +
 8 files changed, 1107 insertions(+), 213 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_subprog_precision.c

-- 
2.34.1

