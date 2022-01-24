Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B15C49961F
	for <lists+bpf@lfdr.de>; Mon, 24 Jan 2022 22:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357523AbiAXU7S convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 24 Jan 2022 15:59:18 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42508 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1443265AbiAXU4f (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 24 Jan 2022 15:56:35 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20OHVjbQ019539
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 11:43:03 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dswd8jg7j-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 11:43:03 -0800
Received: from twshared1259.42.prn1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 11:43:02 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 071A6FF02AF2; Mon, 24 Jan 2022 11:42:54 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 0/7] libbpf: deprecate some setter and getter APIs
Date:   Mon, 24 Jan 2022 11:42:47 -0800
Message-ID: <20220124194254.2051434-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 8wQDymPjrTqnKniXOIE8k9hfESwdpL3f
X-Proofpoint-ORIG-GUID: 8wQDymPjrTqnKniXOIE8k9hfESwdpL3f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-24_09,2022-01-24_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=885 malwarescore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201240129
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Another batch of simple deprecations. One of the last few, hopefully, as we
are getting close to deprecating all the planned APIs/features. See
individual patches for details.

v1->v2:
  - rebased on latest bpf-next, fixed Closes: reference.

Andrii Nakryiko (7):
  libbpf: hide and discourage inconsistently named getters
  libbpf: deprecate bpf_map__resize()
  libbpf: deprecate bpf_program__is_<type>() and
    bpf_program__set_<type>() APIs
  bpftool: use preferred setters/getters instead of deprecated ones
  selftests/bpf: use preferred setter/getter APIs instead of deprecated
    ones
  samples/bpf: use preferred getters/setters instead of deprecated ones
  perf: use generic bpf_program__set_type() to set BPF prog type

 samples/bpf/map_perf_test_user.c              |  2 +-
 samples/bpf/xdp_redirect_cpu_user.c           |  2 +-
 samples/bpf/xdp_sample_user.c                 |  2 +-
 samples/bpf/xdp_sample_user.h                 |  2 +-
 tools/bpf/bpftool/gen.c                       |  2 +-
 tools/bpf/bpftool/prog.c                      |  8 ++---
 tools/lib/bpf/btf.h                           |  5 +--
 tools/lib/bpf/libbpf.c                        | 21 ++++++------
 tools/lib/bpf/libbpf.h                        | 32 +++++++++++++++++--
 tools/lib/bpf/libbpf.map                      |  2 ++
 tools/lib/bpf/libbpf_internal.h               |  3 ++
 tools/lib/bpf/libbpf_legacy.h                 | 17 ++++++++++
 tools/perf/util/bpf-loader.c                  |  4 +--
 .../selftests/bpf/benchs/bench_ringbufs.c     |  2 +-
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  |  2 +-
 .../prog_tests/get_stackid_cannot_attach.c    |  2 +-
 .../bpf/prog_tests/stacktrace_build_id_nmi.c  |  2 +-
 17 files changed, 79 insertions(+), 31 deletions(-)

-- 
2.30.2

