Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193084A7BFA
	for <lists+bpf@lfdr.de>; Thu,  3 Feb 2022 00:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbiBBX4k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Feb 2022 18:56:40 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:8710 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1348201AbiBBX4i (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 2 Feb 2022 18:56:38 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 212LPvTi017028
        for <bpf@vger.kernel.org>; Wed, 2 Feb 2022 15:56:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=6plUwaNxIx2i9V0GAzrQbx8nUoyyz3llwNmOcFUWsDI=;
 b=D81HR4/pENq7iMxTA+g1BNlvMwBwWlfOdBmRiyxXapgNwQhOnGmvwoyUKOU1W4/Z6h2c
 MT0v0OvCuv+H6C7ZKk0f4snzl8z2vZYrQe4yf80qTNSuIECHlnJSvSEn93QHA52VVaMK
 FFve69VJeORSmpRDTQGdFM665JVQEiIljR0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3dyb3j0vc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 02 Feb 2022 15:56:37 -0800
Received: from twshared2974.18.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Feb 2022 15:56:36 -0800
Received: by devvm3278.frc0.facebook.com (Postfix, from userid 8598)
        id 28F731C61C184; Wed,  2 Feb 2022 15:56:24 -0800 (PST)
From:   Delyan Kratunov <delyank@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC:     Delyan Kratunov <delyank@fb.com>
Subject: [PATCH bpf-next v3 0/4] migrate from bpf_prog_test_run{,_xattr}
Date:   Wed, 2 Feb 2022 15:54:19 -0800
Message-ID: <20220202235423.1097270-1-delyank@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: wKWnHCifMeKU97aWO25d6WwhBLuPC8Q_
X-Proofpoint-ORIG-GUID: wKWnHCifMeKU97aWO25d6WwhBLuPC8Q_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-02_11,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202020130
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fairly straight-forward mechanical transformation from bpf_prog_test_run
and bpf_prog_test_run_xattr to the bpf_prog_test_run_opts goodness.

I did a fair amount of drive-by CHECK/CHECK_ATTR cleanups as well, though
certainly not everything possible. Primarily, I did not want to just chan=
ge
arguments to CHECK calls, though I had to do a bit more than that
in some cases (overall, -119 CHECK calls and all CHECK_ATTR calls).

v2 -> v3:
Don't introduce CHECK_OPTS, replace CHECK/CHECK_ATTR usages we need to to=
uch
with ASSERT_* calls instead.
Don't be prescriptive about the opts var name and keep old names where th=
at would
minimize unnecessary code churn.
Drop _xattr-specific checks in prog_run_xattr and rename accordingly.

v1 -> v2:
Split selftests/bpf changes into two commits to appease the mailing list.


Delyan Kratunov (4):
  selftests/bpf: migrate from bpf_prog_test_run
  selftests/bpf: migrate from bpf_prog_test_run_xattr
  bpftool: migrate from bpf_prog_test_run_xattr
  libbpf: Deprecate bpf_prog_test_run_xattr and bpf_prog_test_run

 tools/bpf/bpftool/prog.c                      |   5 +-
 tools/lib/bpf/bpf.h                           |   4 +-
 .../selftests/bpf/prog_tests/atomics.c        |  72 +++---
 .../testing/selftests/bpf/prog_tests/bpf_nf.c |  10 +-
 .../selftests/bpf/prog_tests/check_mtu.c      |  38 +--
 .../selftests/bpf/prog_tests/cls_redirect.c   |  10 +-
 .../selftests/bpf/prog_tests/dummy_st_ops.c   |  27 +-
 .../selftests/bpf/prog_tests/fentry_fexit.c   |  24 +-
 .../selftests/bpf/prog_tests/fentry_test.c    |   7 +-
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  |  32 ++-
 .../selftests/bpf/prog_tests/fexit_stress.c   |  22 +-
 .../selftests/bpf/prog_tests/fexit_test.c     |   7 +-
 .../selftests/bpf/prog_tests/flow_dissector.c |  31 ++-
 .../prog_tests/flow_dissector_load_bytes.c    |  24 +-
 .../selftests/bpf/prog_tests/for_each.c       |  32 ++-
 .../bpf/prog_tests/get_func_args_test.c       |  12 +-
 .../bpf/prog_tests/get_func_ip_test.c         |  10 +-
 .../selftests/bpf/prog_tests/global_data.c    |  24 +-
 .../bpf/prog_tests/global_func_args.c         |  13 +-
 .../selftests/bpf/prog_tests/kfree_skb.c      |  16 +-
 .../selftests/bpf/prog_tests/kfunc_call.c     |  46 ++--
 .../selftests/bpf/prog_tests/ksyms_module.c   |  23 +-
 .../selftests/bpf/prog_tests/l4lb_all.c       |  35 ++-
 .../selftests/bpf/prog_tests/map_lock.c       |  15 +-
 .../selftests/bpf/prog_tests/map_ptr.c        |  16 +-
 .../selftests/bpf/prog_tests/modify_return.c  |  33 +--
 .../selftests/bpf/prog_tests/pkt_access.c     |  26 +-
 .../selftests/bpf/prog_tests/pkt_md_access.c  |  14 +-
 .../selftests/bpf/prog_tests/prog_run_opts.c  |  77 ++++++
 .../selftests/bpf/prog_tests/prog_run_xattr.c |  83 ------
 .../bpf/prog_tests/queue_stack_map.c          |  46 ++--
 .../bpf/prog_tests/raw_tp_test_run.c          |  64 ++---
 .../bpf/prog_tests/raw_tp_writable_test_run.c |  16 +-
 .../selftests/bpf/prog_tests/signal_pending.c |  23 +-
 .../selftests/bpf/prog_tests/skb_ctx.c        |  81 +++---
 .../selftests/bpf/prog_tests/skb_helpers.c    |  16 +-
 .../selftests/bpf/prog_tests/sockmap_basic.c  |  20 +-
 .../selftests/bpf/prog_tests/spinlock.c       |  14 +-
 .../selftests/bpf/prog_tests/syscall.c        |  10 +-
 .../selftests/bpf/prog_tests/tailcalls.c      | 238 +++++++++---------
 .../selftests/bpf/prog_tests/test_profiler.c  |  14 +-
 .../bpf/prog_tests/test_skb_pkt_end.c         |  15 +-
 .../testing/selftests/bpf/prog_tests/timer.c  |   7 +-
 .../selftests/bpf/prog_tests/timer_mim.c      |   7 +-
 .../selftests/bpf/prog_tests/trace_ext.c      |  28 ++-
 tools/testing/selftests/bpf/prog_tests/xdp.c  |  34 ++-
 .../bpf/prog_tests/xdp_adjust_frags.c         |  32 ++-
 .../bpf/prog_tests/xdp_adjust_tail.c          | 122 +++++----
 .../selftests/bpf/prog_tests/xdp_bpf2bpf.c    |  14 +-
 .../selftests/bpf/prog_tests/xdp_noinline.c   |  44 ++--
 .../selftests/bpf/prog_tests/xdp_perf.c       |  19 +-
 tools/testing/selftests/bpf/test_lru_map.c    |  11 +-
 tools/testing/selftests/bpf/test_verifier.c   |  16 +-
 53 files changed, 872 insertions(+), 807 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/prog_run_opts.=
c
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/prog_run_xattr=
.c

--
2.30.2
