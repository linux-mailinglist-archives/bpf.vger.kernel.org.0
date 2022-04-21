Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF2850957D
	for <lists+bpf@lfdr.de>; Thu, 21 Apr 2022 05:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383970AbiDUDmt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 20 Apr 2022 23:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383981AbiDUDml (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Apr 2022 23:42:41 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C722625
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 20:39:53 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 23L2u9fL026902
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 20:39:52 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3fjvsvrnbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 20:39:52 -0700
Received: from twshared13315.14.prn3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 20 Apr 2022 20:39:51 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id C23B8186F5365; Wed, 20 Apr 2022 20:39:46 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next 0/3] LINK_CREATE support for fentry/tp_btf/lsm attachments
Date:   Wed, 20 Apr 2022 20:39:42 -0700
Message-ID: <20220421033945.3602803-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: oa_9yDrB0nDQ7ZCIfzRQ-ItvDaVyDOhO
X-Proofpoint-ORIG-GUID: oa_9yDrB0nDQ7ZCIfzRQ-ItvDaVyDOhO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-20_06,2022-04-20_01,2022-02-23_01
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Wire up ability to attach bpf_link-based fentry/fexit/fmod_ret, tp_btf
(BTF-aware raw tracepoints), and LSM programs through universal LINK_CREATE
command, in addition to current BPF_RAW_TRACEPOINT_OPEN.

Teach libbpf to handle this LINK_CREATE/BPF_RAW_TRACEPOINT_OPEN split on older
kernels transparently in universal low-level bpf_link_create() API for users
convenience.

Patch #3 converts fexit_stress selftest to bpf_link_create().

libbpf CI will be testing this fallback logic on older kernels.

Cc: Kui-Feng Lee <kuifeng@fb.com>

Andrii Nakryiko (3):
  bpf: allow attach TRACING programs through LINK_CREATE command
  libbpf: teach bpf_link_create() to fallback to
    bpf_raw_tracepoint_open()
  selftests/bpf: switch fexit_stress to bpf_link_create() API

 kernel/bpf/syscall.c                          | 110 +++++++++---------
 tools/lib/bpf/bpf.c                           |  34 +++++-
 tools/lib/bpf/libbpf.c                        |   3 +-
 .../selftests/bpf/prog_tests/fexit_stress.c   |   2 +-
 4 files changed, 91 insertions(+), 58 deletions(-)

-- 
2.30.2

