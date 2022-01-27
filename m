Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C54A49EF16
	for <lists+bpf@lfdr.de>; Fri, 28 Jan 2022 00:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiA0X6a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jan 2022 18:58:30 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54170 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240891AbiA0X63 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 27 Jan 2022 18:58:29 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20RNaeM9000428
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 15:58:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=ad8wP4yvqMIRKFFilt5FhXe5ktbTbsDuyNVIffXtrfQ=;
 b=VF2wu3OJwTmp8tDHIvGERxQz/qohqu9T0lc6/+mcWjngCY3PRMGqpnkD+j3LKUlC0NCS
 OtxtXfvnmcHpt9XS2+JYzv0NQWYCQqej5SQ2HJGjFXXrBOkBpLKZ2Yp1rrlhhoQTkNYp
 7ONI7NMvDTRBEWZ6ZOZLpcdqphwmDFMl+QE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dukpkpadg-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 15:58:29 -0800
Received: from twshared2974.18.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 27 Jan 2022 15:58:28 -0800
Received: by devvm3278.frc0.facebook.com (Postfix, from userid 8598)
        id 715E41C1147ED; Thu, 27 Jan 2022 15:58:18 -0800 (PST)
From:   Delyan Kratunov <delyank@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC:     Delyan Kratunov <delyank@fb.com>, <lmb@cloudflare.com>
Subject: [PATCH bpf-next 0/3] migrate from bpf_prog_test_run{,_xattr}
Date:   Thu, 27 Jan 2022 15:58:02 -0800
Message-ID: <20220127235805.1608540-1-delyank@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: wnOnCQ2Pgb2Zgk3BdPyn6t_0QIEY6sO-
X-Proofpoint-GUID: wnOnCQ2Pgb2Zgk3BdPyn6t_0QIEY6sO-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_06,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 suspectscore=0
 phishscore=0 spamscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1011 bulkscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201270133
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fairly straight-forward mechanical transformation from bpf_prog_test_run
and bpf_prog_test_run_xattr to the bpf_prog_test_run_opts goodness.
Most of the changes are in tests, though bpftool and libbpf (xsk.c) have =
one
call site each as well.

The only aspect that's still a bit RFC is that prog_run_xattr is testing
behavior specific to bpf_prog_test_run_xattr, which does not exist in pro=
g_run_opts.
Namely, -EINVAL return on data_out =3D=3D NULL && data_size_out > 0.
Adding this behavior to prog_test_run_opts is one option, keeping the tes=
t as-is
and cloning it to use bpf_prog_test_run_opts is another possibility.
The current version just suppresses the deprecation warning.

As an aside, checkpatch really doesn't like that LIBBPF_OPTS looks like
a function call but is formatted like a struct declaration. If anyone
cares about formatting, now would be a good time to mention it.

Delyan Kratunov (3):
  selftests: bpf: migrate from bpf_prog_test_run{,_xattr}
  bpftool: migrate from bpf_prog_test_run_xattr
  libbpf: Deprecate bpf_prog_test_run_xattr and bpf_prog_test_run

 tools/bpf/bpftool/prog.c                      |  55 ++--
 tools/lib/bpf/bpf.h                           |   8 +-
 tools/lib/bpf/xsk.c                           |  11 +-
 .../selftests/bpf/prog_tests/atomics.c        |  86 +++---
 .../testing/selftests/bpf/prog_tests/bpf_nf.c |  10 +-
 .../selftests/bpf/prog_tests/check_mtu.c      |  47 ++--
 .../selftests/bpf/prog_tests/cls_redirect.c   |  30 +--
 .../selftests/bpf/prog_tests/dummy_st_ops.c   |  31 +--
 .../selftests/bpf/prog_tests/fentry_fexit.c   |  33 ++-
 .../selftests/bpf/prog_tests/fentry_test.c    |   9 +-
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  |  33 ++-
 .../selftests/bpf/prog_tests/fexit_stress.c   |  26 +-
 .../selftests/bpf/prog_tests/fexit_test.c     |   9 +-
 .../selftests/bpf/prog_tests/flow_dissector.c |  75 +++---
 .../prog_tests/flow_dissector_load_bytes.c    |  27 +-
 .../selftests/bpf/prog_tests/for_each.c       |  32 ++-
 .../bpf/prog_tests/get_func_args_test.c       |  14 +-
 .../bpf/prog_tests/get_func_ip_test.c         |  12 +-
 .../selftests/bpf/prog_tests/global_data.c    |  25 +-
 .../bpf/prog_tests/global_func_args.c         |  13 +-
 .../selftests/bpf/prog_tests/kfree_skb.c      |  16 +-
 .../selftests/bpf/prog_tests/kfunc_call.c     |  46 ++--
 .../selftests/bpf/prog_tests/ksyms_module.c   |  23 +-
 .../selftests/bpf/prog_tests/l4lb_all.c       |  35 ++-
 .../selftests/bpf/prog_tests/map_lock.c       |  15 +-
 .../selftests/bpf/prog_tests/map_ptr.c        |  18 +-
 .../selftests/bpf/prog_tests/modify_return.c  |  38 +--
 .../selftests/bpf/prog_tests/pkt_access.c     |  27 +-
 .../selftests/bpf/prog_tests/pkt_md_access.c  |  15 +-
 .../selftests/bpf/prog_tests/prog_run_xattr.c |   5 +
 .../bpf/prog_tests/queue_stack_map.c          |  43 +--
 .../bpf/prog_tests/raw_tp_test_run.c          |  85 +++---
 .../bpf/prog_tests/raw_tp_writable_test_run.c |  16 +-
 .../selftests/bpf/prog_tests/signal_pending.c |  24 +-
 .../selftests/bpf/prog_tests/skb_ctx.c        |  93 +++----
 .../selftests/bpf/prog_tests/skb_helpers.c    |  16 +-
 .../selftests/bpf/prog_tests/sockmap_basic.c  |  19 +-
 .../selftests/bpf/prog_tests/spinlock.c       |  15 +-
 .../selftests/bpf/prog_tests/syscall.c        |  12 +-
 .../selftests/bpf/prog_tests/tailcalls.c      | 245 ++++++++++--------
 .../selftests/bpf/prog_tests/test_profiler.c  |  16 +-
 .../bpf/prog_tests/test_skb_pkt_end.c         |  15 +-
 .../testing/selftests/bpf/prog_tests/timer.c  |   9 +-
 .../selftests/bpf/prog_tests/timer_mim.c      |   9 +-
 .../selftests/bpf/prog_tests/trace_ext.c      |  28 +-
 tools/testing/selftests/bpf/prog_tests/xdp.c  |  35 ++-
 .../bpf/prog_tests/xdp_adjust_frags.c         |  34 ++-
 .../bpf/prog_tests/xdp_adjust_tail.c          | 148 ++++++-----
 .../selftests/bpf/prog_tests/xdp_bpf2bpf.c    |  16 +-
 .../selftests/bpf/prog_tests/xdp_noinline.c   |  45 ++--
 .../selftests/bpf/prog_tests/xdp_perf.c       |  19 +-
 tools/testing/selftests/bpf/test_lru_map.c    |  11 +-
 tools/testing/selftests/bpf/test_progs.h      |   2 +
 tools/testing/selftests/bpf/test_verifier.c   |  16 +-
 54 files changed, 993 insertions(+), 802 deletions(-)

--
2.30.2
