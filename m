Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416DF4CE1C6
	for <lists+bpf@lfdr.de>; Sat,  5 Mar 2022 02:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiCEBC1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 4 Mar 2022 20:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiCEBC1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Mar 2022 20:02:27 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16541AD963
        for <bpf@vger.kernel.org>; Fri,  4 Mar 2022 17:01:38 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 224HQk3C007091
        for <bpf@vger.kernel.org>; Fri, 4 Mar 2022 17:01:38 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ek4hrscjf-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 04 Mar 2022 17:01:38 -0800
Received: from twshared27297.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Mar 2022 17:01:35 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 24ED7132C992B; Fri,  4 Mar 2022 17:01:30 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v5 bpf-next 0/3] libbpf: support custom SEC() handlers
Date:   Fri, 4 Mar 2022 17:01:26 -0800
Message-ID: <20220305010129.1549719-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: EINGEuE73GL0y0qQR0zY8c24vd-roZIz
X-Proofpoint-ORIG-GUID: EINGEuE73GL0y0qQR0zY8c24vd-roZIz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-04_09,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 impostorscore=0 mlxscore=0 spamscore=0 phishscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203050002
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

v4->v5:
  - API documentation improvements (Daniel);
v3->v4:
  - init_fn -> prog_setup_fn, preload_fn -> prog_prepare_load_fn (Alexei);
v2->v3:
  - moved callbacks and cookie into OPTS struct (Alan);
  - added more test scenarios (Alan);
  - address most of Alan's feedback, but kept API name;
v1->v2:
  - resubmitting due to git send-email screw up.

Cc: Alan Maguire <alan.maguire@oracle.com>

Andrii Nakryiko (3):
  libbpf: allow BPF program auto-attach handlers to bail out
  libbpf: support custom SEC() handlers
  selftests/bpf: add custom SEC() handling selftest

 tools/lib/bpf/libbpf.c                        | 332 ++++++++++++------
 tools/lib/bpf/libbpf.h                        | 109 ++++++
 tools/lib/bpf/libbpf.map                      |   6 +
 tools/lib/bpf/libbpf_version.h                |   2 +-
 .../bpf/prog_tests/custom_sec_handlers.c      | 176 ++++++++++
 .../bpf/progs/test_custom_sec_handlers.c      |  63 ++++
 6 files changed, 586 insertions(+), 102 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/custom_sec_handlers.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_custom_sec_handlers.c

-- 
2.30.2

