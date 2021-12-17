Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3274D47927E
	for <lists+bpf@lfdr.de>; Fri, 17 Dec 2021 18:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237090AbhLQRM0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 17 Dec 2021 12:12:26 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:17952 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239675AbhLQRMZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 17 Dec 2021 12:12:25 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BHHBNsE002276
        for <bpf@vger.kernel.org>; Fri, 17 Dec 2021 09:12:25 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3d0xqrg09s-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 17 Dec 2021 09:12:25 -0800
Received: from twshared13036.24.prn2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 17 Dec 2021 09:12:13 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 0AF1CD737499; Fri, 17 Dec 2021 09:12:04 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v2 bpf-next 0/3] Revamp and fix libbpf's feature-probing APIs
Date:   Fri, 17 Dec 2021 09:11:59 -0800
Message-ID: <20211217171202.3352835-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: nRYVjmCMhX3Xl5Yl6Ve3L2J7oKzlGeJf
X-Proofpoint-GUID: nRYVjmCMhX3Xl5Yl6Ve3L2J7oKzlGeJf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-17_07,2021-12-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 adultscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=835 lowpriorityscore=0 mlxscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112170099
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix and improve libbpf feature-probing APIs. Name them consistently and
deprecated previous inconsistently named APIs.

v1->v2:
  - fixed misleading comment and added acks (Dave).

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

