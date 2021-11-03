Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59842444AA6
	for <lists+bpf@lfdr.de>; Wed,  3 Nov 2021 23:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhKCWLf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 3 Nov 2021 18:11:35 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:61606 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229698AbhKCWLe (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 3 Nov 2021 18:11:34 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A3KAesT008228
        for <bpf@vger.kernel.org>; Wed, 3 Nov 2021 15:08:57 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c3veb36qd-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 03 Nov 2021 15:08:57 -0700
Received: from intmgw001.27.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 3 Nov 2021 15:08:49 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 963F97D65E3E; Wed,  3 Nov 2021 15:08:47 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH v2 bpf-next 00/12] libbpf: add unified bpf_prog_load() low-level API
Date:   Wed, 3 Nov 2021 15:08:33 -0700
Message-ID: <20211103220845.2676888-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: pgHbgx_OTw8sBeY6gKionnfcAkKY-AzT
X-Proofpoint-GUID: pgHbgx_OTw8sBeY6gKionnfcAkKY-AzT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-03_06,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 spamscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111030116
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set adds unified OPTS-based low-level bpf_prog_load() API for
loading BPF programs directly into kernel without utilizing libbpf's
bpf_object abstractions. This OPTS-based interface allows for future
extensions without breaking backwards or forward API and ABI compatibility.
Similar approach will be used for other low-level APIs that require extensive
sets of parameters, like BPF_MAP_CREATE command.

First half of the patch set adds libbpf API, cleans up internal usage of
to-be-deprecated APIs, etc. Second half cleans up and converts selftests away
from using deprecated APIs. See individual patches for more details.

v1->v2:
  - dropped exposing sys_bpf() into public API (Alexei, Daniel);
  - also dropped bpftool/cgroup.c fix for unistd.h include because it's not
    necessary due to sys_bpf() staying as is.

Cc: Hengqi Chen <hengqi.chen@gmail.com>

Andrii Nakryiko (12):
  libbpf: rename DECLARE_LIBBPF_OPTS into LIBBPF_OPTS
  libbpf: pass number of prog load attempts explicitly
  libbpf: unify low-level BPF_PROG_LOAD APIs into bpf_prog_load()
  libbpf: remove internal use of deprecated bpf_prog_load() variants
  libbpf: stop using to-be-deprecated APIs
  bpftool: stop using deprecated bpf_load_program()
  libbpf: remove deprecation attribute from struct bpf_prog_prep_result
  selftests/bpf: fix non-strict SEC() program sections
  selftests/bpf: convert legacy prog load APIs to bpf_prog_load()
  selftests/bpf: merge test_stub.c into testing_helpers.c
  selftests/bpf: use explicit bpf_prog_test_load() calls everywhere
  selftests/bpf: use explicit bpf_test_load_program() helper calls

 tools/bpf/bpftool/feature.c                   |   2 +-
 tools/lib/bpf/bpf.c                           | 166 +++++++++-------
 tools/lib/bpf/bpf.h                           |  74 +++++++-
 tools/lib/bpf/bpf_gen_internal.h              |   8 +-
 tools/lib/bpf/gen_loader.c                    |  30 +--
 tools/lib/bpf/libbpf.c                        | 177 +++++++-----------
 tools/lib/bpf/libbpf.h                        |   6 +-
 tools/lib/bpf/libbpf.map                      |   2 +
 tools/lib/bpf/libbpf_common.h                 |  14 +-
 tools/lib/bpf/libbpf_internal.h               |  31 ---
 tools/lib/bpf/libbpf_legacy.h                 |   1 +
 tools/lib/bpf/libbpf_probes.c                 |  20 +-
 tools/lib/bpf/xsk.c                           |  34 ++--
 tools/testing/selftests/bpf/Makefile          |  38 ++--
 .../selftests/bpf/flow_dissector_load.h       |   3 +-
 .../selftests/bpf/get_cgroup_id_user.c        |   5 +-
 .../testing/selftests/bpf/prog_tests/align.c  |  11 +-
 .../selftests/bpf/prog_tests/bpf_obj_id.c     |   2 +-
 .../bpf/prog_tests/cgroup_attach_autodetach.c |   2 +-
 .../bpf/prog_tests/cgroup_attach_multi.c      |   2 +-
 .../bpf/prog_tests/cgroup_attach_override.c   |   2 +-
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  |   8 +-
 .../selftests/bpf/prog_tests/fexit_stress.c   |  33 ++--
 .../prog_tests/flow_dissector_load_bytes.c    |   2 +-
 .../bpf/prog_tests/flow_dissector_reattach.c  |   4 +-
 .../bpf/prog_tests/get_stack_raw_tp.c         |   4 +-
 .../selftests/bpf/prog_tests/global_data.c    |   2 +-
 .../bpf/prog_tests/global_func_args.c         |   2 +-
 .../selftests/bpf/prog_tests/kfree_skb.c      |   2 +-
 .../selftests/bpf/prog_tests/l4lb_all.c       |   2 +-
 .../bpf/prog_tests/load_bytes_relative.c      |   2 +-
 .../selftests/bpf/prog_tests/map_lock.c       |   4 +-
 .../selftests/bpf/prog_tests/pkt_access.c     |   2 +-
 .../selftests/bpf/prog_tests/pkt_md_access.c  |   2 +-
 .../bpf/prog_tests/queue_stack_map.c          |   2 +-
 .../raw_tp_writable_reject_nbd_invalid.c      |  14 +-
 .../bpf/prog_tests/raw_tp_writable_test_run.c |  29 ++-
 .../selftests/bpf/prog_tests/signal_pending.c |   2 +-
 .../selftests/bpf/prog_tests/skb_ctx.c        |   2 +-
 .../selftests/bpf/prog_tests/skb_helpers.c    |   2 +-
 .../selftests/bpf/prog_tests/sockopt.c        |  19 +-
 .../selftests/bpf/prog_tests/spinlock.c       |   4 +-
 .../selftests/bpf/prog_tests/stacktrace_map.c |   2 +-
 .../bpf/prog_tests/stacktrace_map_raw_tp.c    |   2 +-
 .../selftests/bpf/prog_tests/tailcalls.c      |  18 +-
 .../bpf/prog_tests/task_fd_query_rawtp.c      |   2 +-
 .../bpf/prog_tests/task_fd_query_tp.c         |   4 +-
 .../selftests/bpf/prog_tests/tcp_estats.c     |   2 +-
 .../bpf/prog_tests/tp_attach_query.c          |   2 +-
 tools/testing/selftests/bpf/prog_tests/xdp.c  |   2 +-
 .../bpf/prog_tests/xdp_adjust_tail.c          |   6 +-
 .../selftests/bpf/prog_tests/xdp_attach.c     |   6 +-
 .../selftests/bpf/prog_tests/xdp_info.c       |   2 +-
 .../selftests/bpf/prog_tests/xdp_perf.c       |   2 +-
 .../selftests/bpf/progs/fexit_bpf2bpf.c       |   2 +-
 tools/testing/selftests/bpf/progs/test_l4lb.c |   2 +-
 .../selftests/bpf/progs/test_l4lb_noinline.c  |   2 +-
 .../selftests/bpf/progs/test_map_lock.c       |   2 +-
 .../bpf/progs/test_queue_stack_map.h          |   2 +-
 .../selftests/bpf/progs/test_skb_ctx.c        |   2 +-
 .../selftests/bpf/progs/test_spin_lock.c      |   2 +-
 .../selftests/bpf/progs/test_tcp_estats.c     |   2 +-
 .../selftests/bpf/test_cgroup_storage.c       |   3 +-
 tools/testing/selftests/bpf/test_dev_cgroup.c |   3 +-
 .../selftests/bpf/test_lirc_mode2_user.c      |   6 +-
 tools/testing/selftests/bpf/test_lru_map.c    |   9 +-
 tools/testing/selftests/bpf/test_maps.c       |   7 +-
 tools/testing/selftests/bpf/test_sock.c       |  23 ++-
 tools/testing/selftests/bpf/test_sock_addr.c  |  13 +-
 tools/testing/selftests/bpf/test_stub.c       |  44 -----
 tools/testing/selftests/bpf/test_sysctl.c     |  23 +--
 tools/testing/selftests/bpf/test_tag.c        |   3 +-
 .../selftests/bpf/test_tcpnotify_user.c       |   3 +-
 tools/testing/selftests/bpf/test_verifier.c   |  38 ++--
 tools/testing/selftests/bpf/testing_helpers.c |  55 ++++++
 tools/testing/selftests/bpf/testing_helpers.h |   6 +
 tools/testing/selftests/bpf/xdping.c          |   3 +-
 77 files changed, 565 insertions(+), 513 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/test_stub.c

-- 
2.30.2

