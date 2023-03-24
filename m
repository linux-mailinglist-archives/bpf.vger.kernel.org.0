Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DC36C8871
	for <lists+bpf@lfdr.de>; Fri, 24 Mar 2023 23:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbjCXWe5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 24 Mar 2023 18:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbjCXWet (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 18:34:49 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8E41BACB
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 15:34:30 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32OJFBxC029243
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 15:33:30 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3phhut9006-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 15:33:30 -0700
Received: from twshared58712.02.prn6.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 24 Mar 2023 15:33:29 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 623B82BC804E3; Fri, 24 Mar 2023 15:33:15 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 0/3] veristat: add better support of freplace programs
Date:   Fri, 24 Mar 2023 15:33:10 -0700
Message-ID: <20230324223314.3294345-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: MecIlNi0FQFlnCWZTu8E2X1ZRsnHwnHP
X-Proofpoint-GUID: MecIlNi0FQFlnCWZTu8E2X1ZRsnHwnHP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Spam-Status: No, score=-0.5 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Teach veristat how to deal with freplace BPF programs. As they can't be
directly loaded by veristat without custom user-space part that sets correct
target program FD, veristat always fails freplace programs. This patch set
teaches veristat to guess target program type that will be inherited by
freplace program itself, and subtitute it for BPF_PROG_TYPE_EXT (freplace) one
for the purposes of BPF verification.

Patch #1 fixes bug in libbpf preventing overriding freplace with specific
program type.

Patch #2 adds convenient -d flag to request veristat to emit libbpf debug
logs. It help debugging why a specific BPF program fails to load, if the
problem is not due to BPF verification itself.

Andrii Nakryiko (3):
  libbpf: disassociate section handler on explicit
    bpf_program__set_type() call
  veristat: add -d debug mode option to see debug libbpf log
  veristat: guess and substitue underlying program type for freplace
    (EXT) progs

 tools/lib/bpf/libbpf.c                 |   1 +
 tools/testing/selftests/bpf/veristat.c | 125 ++++++++++++++++++++++++-
 2 files changed, 121 insertions(+), 5 deletions(-)

-- 
2.34.1

