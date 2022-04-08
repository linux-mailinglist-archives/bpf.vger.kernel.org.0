Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD4A4F9C4C
	for <lists+bpf@lfdr.de>; Fri,  8 Apr 2022 20:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbiDHSQl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 8 Apr 2022 14:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiDHSQk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Apr 2022 14:16:40 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA85DF9
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 11:14:36 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 238GqqC2022002
        for <bpf@vger.kernel.org>; Fri, 8 Apr 2022 11:14:36 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fad7yvyt1-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 08 Apr 2022 11:14:36 -0700
Received: from twshared27284.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 8 Apr 2022 11:14:33 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 9FBBE16F87342; Fri,  8 Apr 2022 11:14:26 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 0/3] Fix handling of CO-RE relos for __weak subprogs
Date:   Fri, 8 Apr 2022 11:14:22 -0700
Message-ID: <20220408181425.2287230-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: YoCWwrV4cChZdKzyV6VLKCYevJnIeKWD
X-Proofpoint-GUID: YoCWwrV4cChZdKzyV6VLKCYevJnIeKWD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-08_05,2022-04-08_01,2022-02-23_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix the issue accidentally discovered during libbpf USDT support testing.
Libbpf overzealously complained about CO-RE relocations belonging to the code
of a __weak subprog that got overriden by another instance of that function.

Fix the issue fixed, return back to __weak __hidden annotation for USDT
BPF-side APIs.

And add CO-RE relos to linked_funcs selftest to ensure such combo keeps
working going forward.

Andrii Nakryiko (3):
  libbpf: don't error out on CO-RE relos for overriden weak subprogs
  libbpf: use weak hidden modifier for USDT BPF-side API functions
  selftests/bpf: add CO-RE relos into linked_funcs selftests

 tools/lib/bpf/libbpf.c                            | 15 +++++++++++----
 tools/lib/bpf/usdt.bpf.h                          |  6 +++---
 tools/testing/selftests/bpf/progs/linked_funcs1.c |  8 ++++++++
 tools/testing/selftests/bpf/progs/linked_funcs2.c |  8 ++++++++
 4 files changed, 30 insertions(+), 7 deletions(-)

-- 
2.30.2

