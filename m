Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626DC4659D7
	for <lists+bpf@lfdr.de>; Thu,  2 Dec 2021 00:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353782AbhLAXcV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 1 Dec 2021 18:32:21 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33500 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353778AbhLAXcK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 1 Dec 2021 18:32:10 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1LdIpb006034
        for <bpf@vger.kernel.org>; Wed, 1 Dec 2021 15:28:48 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3cp6tm5nj5-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 01 Dec 2021 15:28:48 -0800
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 1 Dec 2021 15:28:26 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id E6352B7A0AB0; Wed,  1 Dec 2021 15:28:24 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 0/9] Deprecate bpf_prog_load_xattr() API
Date:   Wed, 1 Dec 2021 15:28:15 -0800
Message-ID: <20211201232824.3166325-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: 1kkcpD-tHr1BF1YNdNmQ0sQ4gKD3H8zD
X-Proofpoint-GUID: 1kkcpD-tHr1BF1YNdNmQ0sQ4gKD3H8zD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_10,2021-12-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 spamscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=935 suspectscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010122
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Few lines in the last patch to mark bpf_prog_load_xattr() deprecated required
a decent amount of clean ups in all the other patches. samples/bpf is big part
of the clean up.

This patch set also bumps libbpf version to 0.7, as libbpf v0.6 release will
be cut shortly.

Andrii Nakryiko (9):
  libbpf: use __u32 fields in bpf_map_create_opts
  libbpf: add API to get/set log_level at per-program level
  bpftool: migrate off of deprecated bpf_create_map_xattr() API
  selftests/bpf: remove recently reintroduced legacy btf__dedup() use
  selftests/bpf: mute xdpxceiver.c's deprecation warnings
  selftests/bpf: remove all the uses of deprecated bpf_prog_load_xattr()
  samples/bpf: clean up samples/bpf build failes
  samples/bpf: get rid of deprecated libbpf API uses
  libbpf: deprecate bpf_prog_load_xattr() API

 samples/bpf/Makefile                          | 13 ++++-
 samples/bpf/Makefile.target                   | 11 ----
 samples/bpf/cookie_uid_helper_example.c       | 14 +++--
 samples/bpf/fds_example.c                     | 24 +++++---
 samples/bpf/hbm_kern.h                        |  2 -
 samples/bpf/lwt_len_hist_kern.c               |  7 ---
 samples/bpf/map_perf_test_user.c              | 15 +++--
 samples/bpf/sock_example.c                    | 12 ++--
 samples/bpf/sockex1_user.c                    | 15 ++++-
 samples/bpf/sockex2_user.c                    | 14 ++++-
 samples/bpf/test_cgrp2_array_pin.c            |  4 +-
 samples/bpf/test_cgrp2_attach.c               | 13 +++--
 samples/bpf/test_cgrp2_sock.c                 |  8 ++-
 samples/bpf/test_lru_dist.c                   | 11 ++--
 samples/bpf/trace_output_user.c               |  4 +-
 samples/bpf/xdp_sample_pkts_user.c            | 22 +++----
 samples/bpf/xdpsock_ctrl_proc.c               |  3 +
 samples/bpf/xdpsock_user.c                    |  3 +
 samples/bpf/xsk_fwd.c                         |  3 +
 tools/bpf/bpftool/map.c                       | 23 ++++----
 tools/lib/bpf/bpf.h                           |  8 +--
 tools/lib/bpf/libbpf.c                        | 14 +++++
 tools/lib/bpf/libbpf.h                        |  3 +
 tools/lib/bpf/libbpf.map                      |  6 ++
 tools/lib/bpf/libbpf_common.h                 |  5 ++
 tools/lib/bpf/libbpf_version.h                |  2 +-
 .../bpf/prog_tests/bpf_verif_scale.c          | 30 +++++++---
 .../bpf/prog_tests/btf_dedup_split.c          |  4 +-
 .../bpf/prog_tests/connect_force_port.c       | 17 +++---
 .../selftests/bpf/prog_tests/kfree_skb.c      | 58 ++++++-------------
 .../bpf/prog_tests/sockopt_inherit.c          | 12 ++--
 .../selftests/bpf/prog_tests/sockopt_multi.c  | 12 ++--
 .../selftests/bpf/prog_tests/tcp_rtt.c        | 21 +++----
 .../bpf/prog_tests/test_global_funcs.c        | 28 ++++++---
 tools/testing/selftests/bpf/test_sock_addr.c  | 33 +++++++----
 .../selftests/bpf/xdp_redirect_multi.c        | 15 ++---
 tools/testing/selftests/bpf/xdpxceiver.c      |  6 ++
 37 files changed, 293 insertions(+), 202 deletions(-)

-- 
2.30.2

