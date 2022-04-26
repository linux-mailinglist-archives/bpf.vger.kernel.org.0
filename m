Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF76850EDB9
	for <lists+bpf@lfdr.de>; Tue, 26 Apr 2022 02:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240368AbiDZAsb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 25 Apr 2022 20:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240352AbiDZAs3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Apr 2022 20:48:29 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23514DFDE
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 17:45:23 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 23PHPI8s009671
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 17:45:22 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3fmcy4xw6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 17:45:22 -0700
Received: from twshared16308.14.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 17:45:21 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id CA5B318FD8EB5; Mon, 25 Apr 2022 17:45:15 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 00/10] Teach libbpf to "fix up" BPF verifier log
Date:   Mon, 25 Apr 2022 17:45:01 -0700
Message-ID: <20220426004511.2691730-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: T_UB1miNAUo_GOPOOuA2dgUcjkwb2ljm
X-Proofpoint-GUID: T_UB1miNAUo_GOPOOuA2dgUcjkwb2ljm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_10,2022-04-25_03,2022-02-23_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set teaches libbpf to enhance BPF verifier log with human-readable
and relevant information about failed CO-RE relocation. Patch #9 is the main
one with the new logic. See relevant commit messages for some more details.

All the other patches are either fixing various bugs detected
while working on this feature, most prominently a bug with libbpf not handling
CO-RE relocations for SEC("?...") programs, or are refactoring libbpf
internals to allow for easier reuse of CO-RE relo lookup and formatting logic.

Andrii Nakryiko (10):
  libbpf: fix anonymous type check in CO-RE logic
  libbpf: drop unhelpful "program too large" guess
  libbpf: fix logic for finding matching program for CO-RE relocation
  libbpf: avoid joining .BTF.ext data with BPF programs by section name
  selftests/bpf: add CO-RE relos and SEC("?...") to linked_funcs
    selftests
  libbpf: record subprog-resolved CO-RE relocations unconditionally
  libbpf: refactor CO-RE relo human description formatting routine
  libbpf: simplify bpf_core_parse_spec() signature
  libbpf: fix up verifier log for unguarded failed CO-RE relos
  selftests/bpf: add libbpf's log fixup logic selftests

 tools/lib/bpf/btf.c                           |   9 +-
 tools/lib/bpf/libbpf.c                        | 252 ++++++++++++++----
 tools/lib/bpf/libbpf_internal.h               |   7 +
 tools/lib/bpf/relo_core.c                     | 104 ++++----
 tools/lib/bpf/relo_core.h                     |   6 +
 .../selftests/bpf/prog_tests/linked_funcs.c   |   6 +
 .../selftests/bpf/prog_tests/log_fixup.c      | 114 ++++++++
 .../selftests/bpf/progs/linked_funcs1.c       |   7 +-
 .../selftests/bpf/progs/linked_funcs2.c       |   7 +-
 .../selftests/bpf/progs/test_log_fixup.c      |  38 +++
 tools/testing/selftests/bpf/test_progs.h      |  11 +
 11 files changed, 464 insertions(+), 97 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/log_fixup.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_log_fixup.c

-- 
2.30.2

