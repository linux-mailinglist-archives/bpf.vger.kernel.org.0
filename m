Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5887F513BDE
	for <lists+bpf@lfdr.de>; Thu, 28 Apr 2022 20:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350770AbiD1S5N convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 28 Apr 2022 14:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348911AbiD1S5M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Apr 2022 14:57:12 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A2DB9F26
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 11:53:57 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23SIPHfK026723
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 11:53:57 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fprsrxuvx-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 11:53:57 -0700
Received: from twshared18213.14.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Apr 2022 11:53:54 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 1722E19360485; Thu, 28 Apr 2022 11:53:50 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Delyan Kratunov <delyank@fb.com>, Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH v2 bpf-next 0/3] Add target-less tracing SEC() definitions
Date:   Thu, 28 Apr 2022 11:53:46 -0700
Message-ID: <20220428185349.3799599-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: r9Inlc1ifrwJiyea1IQs0KLi3voHQown
X-Proofpoint-GUID: r9Inlc1ifrwJiyea1IQs0KLi3voHQown
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-28_03,2022-04-28_01,2022-02-23_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Allow specifying "target-less" SEC() definitions for tracing BPF programs,
both non-BTF-backed (kprobes, tracepoints, raw tracepoints) and BTF-backed
(fentry/fexit, iter, lsm, etc).

There are various situations where attach target cannot be known at
compilation time, so libbpf's insistence on specifying something leads to
users having to add random test like SEC("kprobe/whatever") and then
specifying correct target at runtime using APIs like
bpf_program__attach_kprobe().

So this patch set improves ergonomics by allowing simple SEC() definitions
that define BPF program type and nothing else. Such programs won't be
auto-attachable, of course, but they also won't fail skeleton auto-attachment,
just like we do this for uprobes.

v1->v2:
  - rebased and added Song's acks.

Cc: Delyan Kratunov <delyank@fb.com>
Cc: Jiri Olsa <jolsa@kernel.org>

Andrii Nakryiko (3):
  libbpf: allow "incomplete" basic tracing SEC() definitions
  libbpf: support target-less SEC() definitions for BTF-backed programs
  selftests/bpf: use target-less SEC() definitions in various tests

 tools/lib/bpf/libbpf.c                        | 118 ++++++++++++------
 .../selftests/bpf/prog_tests/attach_probe.c   |  10 ++
 .../bpf/prog_tests/kprobe_multi_test.c        |  14 +--
 .../selftests/bpf/progs/kprobe_multi.c        |  14 +++
 .../selftests/bpf/progs/test_attach_probe.c   |  23 +++-
 .../selftests/bpf/progs/test_module_attach.c  |   2 +-
 6 files changed, 135 insertions(+), 46 deletions(-)

-- 
2.30.2

