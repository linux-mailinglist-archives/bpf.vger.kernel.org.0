Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC03512A5D
	for <lists+bpf@lfdr.de>; Thu, 28 Apr 2022 06:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242667AbiD1ET2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 28 Apr 2022 00:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239945AbiD1ET2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Apr 2022 00:19:28 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2136331376
        for <bpf@vger.kernel.org>; Wed, 27 Apr 2022 21:16:15 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 23RLlOx8015530
        for <bpf@vger.kernel.org>; Wed, 27 Apr 2022 21:16:14 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3fprrt9skf-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 27 Apr 2022 21:16:14 -0700
Received: from twshared6447.05.prn5.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Apr 2022 21:15:38 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 9FFEC192F88C6; Wed, 27 Apr 2022 21:15:24 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 0/4] libbpf: allow to opt-out from BPF map creation
Date:   Wed, 27 Apr 2022 21:15:19 -0700
Message-ID: <20220428041523.4089853-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 0VGemi6thNSDc1A_EMmHYpo4BoWyGej6
X-Proofpoint-ORIG-GUID: 0VGemi6thNSDc1A_EMmHYpo4BoWyGej6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-27_04,2022-04-27_01,2022-02-23_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add bpf_map__set_autocreate() API which is a BPF map counterpart of
bpf_program__set_autoload() and serves similar goal of allowing to build more
flexible CO-RE applications. See patch #3 for example scenarios in which the
need for such API came up previously.

Patch #1 is a follow-up patch to previous patch set adding verifier log fixup
logic, making sure bpf_core_format_spec()'s return result is used for
something useful.

Patch #2 is a small refactoring to avoid unnecessary verbose memory management
around obj->maps array.

Patch #3 adds and API and corresponding BPF verifier log fix up logic to
provide human-comprehensible error message with useful details.

Patch #4 adds a simple selftest validating both the API itself and libbpf's
log fixup logic for it.

Andrii Nakryiko (4):
  libbpf: append "..." in fixed up log if CO-RE spec is truncated
  libbpf: use libbpf_mem_ensure() when allocating new map
  libbpf: allow to opt-out from creating BPF maps
  selftests/bpf: test bpf_map__set_autocreate() and related log fixup
    logic

 tools/lib/bpf/libbpf.c                        | 169 +++++++++++++-----
 tools/lib/bpf/libbpf.h                        |  22 +++
 tools/lib/bpf/libbpf.map                      |   4 +-
 .../selftests/bpf/prog_tests/log_fixup.c      |  37 +++-
 .../selftests/bpf/progs/test_log_fixup.c      |  26 +++
 5 files changed, 209 insertions(+), 49 deletions(-)

-- 
2.30.2

