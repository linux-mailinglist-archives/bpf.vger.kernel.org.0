Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F1C476AC2
	for <lists+bpf@lfdr.de>; Thu, 16 Dec 2021 08:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbhLPHEv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 16 Dec 2021 02:04:51 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46872 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231981AbhLPHEv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 16 Dec 2021 02:04:51 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BG4O71n021405
        for <bpf@vger.kernel.org>; Wed, 15 Dec 2021 23:04:51 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3cyga3y081-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 15 Dec 2021 23:04:51 -0800
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 23:04:49 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 34CE5D51C02C; Wed, 15 Dec 2021 23:04:43 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next 0/3] Revamp and fix libbpf's feature-probing APIs
Date:   Wed, 15 Dec 2021 23:04:39 -0800
Message-ID: <20211216070442.1492204-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: DS0PgyyMKhjZft2mvbr35x4ShNNKCMVJ
X-Proofpoint-GUID: DS0PgyyMKhjZft2mvbr35x4ShNNKCMVJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-16_02,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 lowpriorityscore=0
 mlxlogscore=787 impostorscore=0 phishscore=0 mlxscore=0 adultscore=0
 clxscore=1034 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112160040
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix and improve libbpf feature-probing APIs. Name them consistently and
deprecated previous inconsistently named APIs.

Cc: Dave Marchevsky <davemarchevsky@fb.com>

Andrii Nakryiko (3):
  libbpf: rework feature-probing APIs
  selftests/bpf: add libbpf feature-probing API selftests
  bpftool: reimplement large insn size limit feature probing

 tools/bpf/bpftool/feature.c                   |  26 +-
 tools/lib/bpf/libbpf.h                        |  52 +++-
 tools/lib/bpf/libbpf.map                      |   3 +
 tools/lib/bpf/libbpf_probes.c                 | 235 ++++++++++++++----
 tools/testing/selftests/bpf/config            |   2 +
 .../selftests/bpf/prog_tests/libbpf_probes.c  | 124 +++++++++
 6 files changed, 385 insertions(+), 57 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/libbpf_probes.c

-- 
2.30.2

