Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE634F9E41
	for <lists+bpf@lfdr.de>; Fri,  8 Apr 2022 22:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbiDHUgt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 8 Apr 2022 16:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbiDHUgs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Apr 2022 16:36:48 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BA0105AAB
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 13:34:44 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 238JaCtF011188
        for <bpf@vger.kernel.org>; Fri, 8 Apr 2022 13:34:43 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fat3r96xn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 08 Apr 2022 13:34:43 -0700
Received: from twshared13315.14.prn3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 8 Apr 2022 13:34:43 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 7193116FC5A10; Fri,  8 Apr 2022 13:34:35 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 0/3] Add target-less tracing SEC() definitions
Date:   Fri, 8 Apr 2022 13:34:30 -0700
Message-ID: <20220408203433.2988727-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: zcJq9jebmP_g86Mj5sz58Nnd2kgpeAdC
X-Proofpoint-ORIG-GUID: zcJq9jebmP_g86Mj5sz58Nnd2kgpeAdC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-08_08,2022-04-08_01,2022-02-23_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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

