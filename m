Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3648494356
	for <lists+bpf@lfdr.de>; Wed, 19 Jan 2022 23:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiASW6O convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 19 Jan 2022 17:58:14 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:61464 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1343965AbiASW6J (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 19 Jan 2022 17:58:09 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 20JIs02K002061
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 14:58:09 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3dp960xw6w-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 14:58:08 -0800
Received: from twshared21922.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 19 Jan 2022 14:57:59 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id CAD5AFB3389F; Wed, 19 Jan 2022 14:57:47 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 0/4] libbpf: deprecate legacy BPF map definitions
Date:   Wed, 19 Jan 2022 14:57:37 -0800
Message-ID: <20220119225741.2944240-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: XeZ7M6WZEL74vrP6sti1jOaIFwRyp5nm
X-Proofpoint-GUID: XeZ7M6WZEL74vrP6sti1jOaIFwRyp5nm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-19_12,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 impostorscore=0 clxscore=1015 mlxlogscore=743 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201190122
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Officially deprecate legacy BPF map definitions in libbpf. They've been slated
for deprecation for a while in favor of more powerful BTF-defined map
definitions and this patch set adds warnings and a way to enforce this in
libbpf through LIBBPF_STRICT_MAP_DEFINITIONS strict mode flag.

Selftests are fixed up and updated, BPF documentation is updated, bpftool's
strict mode usage is adjusted to avoid breaking users unnecessarily.

Andrii Nakryiko (4):
  selftests/bpf: fail build on compilation warning
  selftests/bpf: convert remaining legacy map definitions
  libbpf: deprecate legacy BPF map definitions
  docs/bpf: update BPF map definition example

 Documentation/bpf/btf.rst                     | 21 +++++++---------
 tools/bpf/bpftool/main.c                      |  9 ++++++-
 tools/lib/bpf/bpf_helpers.h                   |  2 +-
 tools/lib/bpf/libbpf.c                        |  8 +++++++
 tools/lib/bpf/libbpf_legacy.h                 |  5 ++++
 tools/testing/selftests/bpf/Makefile          |  4 ++--
 tools/testing/selftests/bpf/prog_tests/btf.c  |  4 ++++
 .../bpf/progs/freplace_cls_redirect.c         | 12 +++++-----
 .../selftests/bpf/progs/sample_map_ret0.c     | 24 +++++++++----------
 .../selftests/bpf/progs/test_btf_haskv.c      |  3 +++
 .../selftests/bpf/progs/test_btf_newkv.c      |  3 +++
 .../selftests/bpf/progs/test_btf_nokv.c       | 12 +++++-----
 .../bpf/progs/test_skb_cgroup_id_kern.c       | 12 +++++-----
 .../testing/selftests/bpf/progs/test_tc_edt.c | 12 +++++-----
 .../bpf/progs/test_tcp_check_syncookie_kern.c | 12 +++++-----
 15 files changed, 85 insertions(+), 58 deletions(-)

-- 
2.30.2

