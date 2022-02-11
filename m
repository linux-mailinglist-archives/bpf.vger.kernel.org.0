Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B194B2F27
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 22:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiBKVPR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 11 Feb 2022 16:15:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiBKVPQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Feb 2022 16:15:16 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DEAC52
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 13:15:14 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21BEk2AY003378
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 13:15:14 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e5sug362m-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 13:15:14 -0800
Received: from twshared45270.41.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Feb 2022 13:15:12 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id D41EC10BBA4F4; Fri, 11 Feb 2022 13:15:06 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next 0/3] libbpf: support custom SEC() handlers
Date:   Fri, 11 Feb 2022 13:14:47 -0800
Message-ID: <20220211211450.2224877-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 56gM_-Ur-ATSn_1ByZ2Zpoc3JUKJ87Lb
X-Proofpoint-GUID: 56gM_-Ur-ATSn_1ByZ2Zpoc3JUKJ87Lb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-11_05,2022-02-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 bulkscore=0 phishscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 clxscore=1015 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202110107
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add ability for user applications and libraries to register custom BPF program
SEC() handlers. See patch #2 for examples where this is useful.

Patch #1 does some preliminary refactoring to allow exponsing program
init, preload, and attach callbacks as public API. It also establishes
a protocol to allow optional auto-attach behavior. This will also help the
case of sometimes auto-attachable uprobes.

v1->v2:
  - moved callbacks and cookie into OPTS struct (Alan);
  - added more test scenarios (Alan);
  - address most of Alan's feedback, but kept API name.

Cc: Alan Maguire <alan.maguire@oracle.com>

Andrii Nakryiko (3):
  libbpf: allow BPF program auto-attach handlers to bail out
  libbpf: support custom SEC() handlers
  selftests/bpf: add custom SEC() handling selftest

 tools/lib/bpf/libbpf.c                        | 308 +++++++++++++-----
 tools/lib/bpf/libbpf.h                        |  87 +++++
 tools/lib/bpf/libbpf.map                      |   6 +
 tools/lib/bpf/libbpf_version.h                |   2 +-
 .../bpf/prog_tests/custom_sec_handlers.c      | 176 ++++++++++
 .../bpf/progs/test_custom_sec_handlers.c      |  63 ++++
 6 files changed, 552 insertions(+), 90 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/custom_sec_handlers.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_custom_sec_handlers.c

-- 
2.30.2

