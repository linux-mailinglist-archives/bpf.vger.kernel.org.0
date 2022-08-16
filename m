Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF3E594F30
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 05:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiHPDws convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 15 Aug 2022 23:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiHPDwR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 23:52:17 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AC9338F8F
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 17:20:18 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27FIbxfi017213
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 17:19:35 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hx9fypf0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 17:19:35 -0700
Received: from twshared6447.05.prn5.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 15 Aug 2022 17:19:34 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 307D41DAC7D76; Mon, 15 Aug 2022 17:19:30 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 0/4] Preparatory libbpf fixes and clean ups
Date:   Mon, 15 Aug 2022 17:19:25 -0700
Message-ID: <20220816001929.369487-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: UNfJPMtlnAe_mKoz4GO9CSouxiFvivm5
X-Proofpoint-GUID: UNfJPMtlnAe_mKoz4GO9CSouxiFvivm5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_08,2022-08-15_01,2022-06-22_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Few fixes and clean up in preparation for finalizing libbpf 1.0.

Main change is switching libbpf to initializing only relevant portions of
union bpf_attr for any given BPF command. This has been on a wishlist for
a while, so finally this is done. While cleaning this up, I've also cleaned up
few other placed were we didn't use explicit memset() with kernel UAPI structs
(perf_event_attr, bpf_map_info, bpf_prog_info, etc).

Also few fixes to test_progs that came up while testing selftests in release
mode.


Andrii Nakryiko (4):
  libbpf: fix potential NULL dereference when parsing ELF
  libbpf: streamline bpf_attr and perf_event_attr initialization
  libbpf: clean up deprecated and legacy aliases
  selftests/bpf: few fixes for selftests/bpf built in release mode

 tools/lib/bpf/bpf.c                           | 178 ++++++++++--------
 tools/lib/bpf/btf.c                           |   2 -
 tools/lib/bpf/btf.h                           |   1 -
 tools/lib/bpf/libbpf.c                        |  47 +++--
 tools/lib/bpf/libbpf_legacy.h                 |   2 +
 tools/lib/bpf/netlink.c                       |   3 +-
 tools/lib/bpf/skel_internal.h                 |  10 +-
 .../selftests/bpf/prog_tests/attach_probe.c   |   6 +-
 .../selftests/bpf/prog_tests/bpf_cookie.c     |   2 +-
 .../selftests/bpf/prog_tests/task_pt_regs.c   |   2 +-
 tools/testing/selftests/bpf/xskxceiver.c      |   2 +-
 11 files changed, 147 insertions(+), 108 deletions(-)

-- 
2.30.2

