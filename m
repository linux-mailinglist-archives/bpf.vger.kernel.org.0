Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F36494718
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 07:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358655AbiATGFx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 20 Jan 2022 01:05:53 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:15332 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230385AbiATGFx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 20 Jan 2022 01:05:53 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20K0eHYR012428
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 22:05:52 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dpafj8cna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 22:05:52 -0800
Received: from twshared13833.42.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 19 Jan 2022 22:05:51 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id C2C04FB9D572; Wed, 19 Jan 2022 22:05:41 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 0/4] libbpf: deprecate legacy BPF map definitions
Date:   Wed, 19 Jan 2022 22:05:25 -0800
Message-ID: <20220120060529.1890907-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: uu4oWo22cX_6G5C9XNcQ3cxGxeT07ens
X-Proofpoint-GUID: uu4oWo22cX_6G5C9XNcQ3cxGxeT07ens
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_02,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 suspectscore=0 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=770 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201200030
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

v1->v2:
  - replace missed bpf_map_def case in Documentation/bpf/btf.rst (Alexei).

Andrii Nakryiko (4):
  selftests/bpf: fail build on compilation warning
  selftests/bpf: convert remaining legacy map definitions
  libbpf: deprecate legacy BPF map definitions
  docs/bpf: update BPF map definition example

 Documentation/bpf/btf.rst                     | 32 ++++++++-----------
 tools/bpf/bpftool/main.c                      |  9 +++++-
 tools/lib/bpf/bpf_helpers.h                   |  2 +-
 tools/lib/bpf/libbpf.c                        |  8 +++++
 tools/lib/bpf/libbpf_legacy.h                 |  5 +++
 tools/testing/selftests/bpf/Makefile          |  4 +--
 tools/testing/selftests/bpf/prog_tests/btf.c  |  4 +++
 .../bpf/progs/freplace_cls_redirect.c         | 12 +++----
 .../selftests/bpf/progs/sample_map_ret0.c     | 24 +++++++-------
 .../selftests/bpf/progs/test_btf_haskv.c      |  3 ++
 .../selftests/bpf/progs/test_btf_newkv.c      |  3 ++
 .../selftests/bpf/progs/test_btf_nokv.c       | 12 +++----
 .../bpf/progs/test_skb_cgroup_id_kern.c       | 12 +++----
 .../testing/selftests/bpf/progs/test_tc_edt.c | 12 +++----
 .../bpf/progs/test_tcp_check_syncookie_kern.c | 12 +++----
 15 files changed, 90 insertions(+), 64 deletions(-)

-- 
2.30.2

