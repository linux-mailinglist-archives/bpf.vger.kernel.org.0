Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28FA4AA547
	for <lists+bpf@lfdr.de>; Sat,  5 Feb 2022 02:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344364AbiBEB1P convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 4 Feb 2022 20:27:15 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53666 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239745AbiBEB1P (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Feb 2022 20:27:15 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2150pRNV007023
        for <bpf@vger.kernel.org>; Fri, 4 Feb 2022 17:27:15 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e1dgb8k2b-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 04 Feb 2022 17:27:15 -0800
Received: from twshared13036.24.prn2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Feb 2022 17:27:14 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 625541051D27C; Fri,  4 Feb 2022 17:27:09 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next 0/3] libbpf: support custom SEC() handlers
Date:   Fri, 4 Feb 2022 17:27:01 -0800
Message-ID: <20220205012705.1077708-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: GYgC849xD8iYaCyG0BTReUFd2fkhl4MS
X-Proofpoint-GUID: GYgC849xD8iYaCyG0BTReUFd2fkhl4MS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-04_07,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 mlxlogscore=967
 impostorscore=0 bulkscore=0 spamscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202050004
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add ability for user applications and libraries to register custom BPF program
SEC() handlers. See patch #2 for examples where this is useful.

Patch #1 does some preliminary refactoring to allow exponsing program
init, preload, and attach callbacks as public API. It also establishes
a protocol to allow optional auto-attach behavior. This will also help the
case of sometimes auto-attachable uprobes.

Cc: Alan Maguire <alan.maguire@oracle.com>

Andrii Nakryiko (3):
  libbpf: allow BPF program auto-attach handlers to bail out
  libbpf: support custom SEC() handlers
  selftests/bpf: add custom SEC() handling selftest

 tools/lib/bpf/libbpf.c                        | 299 ++++++++++++------
 tools/lib/bpf/libbpf.h                        |  81 +++++
 tools/lib/bpf/libbpf.map                      |   2 +
 .../bpf/prog_tests/custom_sec_handlers.c      | 136 ++++++++
 .../bpf/progs/test_custom_sec_handlers.c      |  51 +++
 5 files changed, 480 insertions(+), 89 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/custom_sec_handlers.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_custom_sec_handlers.c

-- 
2.30.2

