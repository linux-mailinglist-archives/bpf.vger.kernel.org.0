Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD0B424654
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 20:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239069AbhJFS6g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 14:58:36 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52296 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231804AbhJFS6f (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 Oct 2021 14:58:35 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 196HxAxD028002
        for <bpf@vger.kernel.org>; Wed, 6 Oct 2021 11:56:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=twjHxQV+2bLXbthppnj6g2n+rOOpfs9G9r9v1QnrV0s=;
 b=TPtuxAAj0YiabKVDXZuTN89HYaVwG94soYvziiu8wDHRwP6kZWQ3QzuremgMWf5p8DEE
 zgsJCSEVpEzAziII6XSrkEAcMWIx7X9kmb8sWNDkLWjIZWvTYQouGazzDjy7fRXQ/5Hm
 vzyYtOpfihIIvqnnkCePwHB/Yn87RtvscIc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bhfw4rwvg-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 06 Oct 2021 11:56:42 -0700
Received: from intmgw002.48.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 6 Oct 2021 11:56:23 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id 12D544BDB5AB; Wed,  6 Oct 2021 11:56:20 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <sunyucong@gmail.com>,
        Yucong Sun <fallentree@fb.com>
Subject: [PATCH bpf-next v6 00/14] selftests/bpf: Add parallelism to test_progs
Date:   Wed, 6 Oct 2021 11:56:05 -0700
Message-ID: <20211006185619.364369-1-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: 6l9rAceJWhilIOU0S2dXafoWLYOJSJT8
X-Proofpoint-GUID: 6l9rAceJWhilIOU0S2dXafoWLYOJSJT8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-06_04,2021-10-06_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 mlxscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110060117
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch series adds "-j" parelell execution to test_progs, with "--deb=
ug" to
display server/worker communications. Also, some Tests that often fails i=
n
parallel are marked as serial test, and it will run in sequence after par=
allel
execution is done.

This patch series also adds a error summary after all tests execution fin=
ished.

V6 -> V5:
  * adding error summary logic for non parallel mode too.
  * changed how serial tests are implemented, use main process instead of=
 worker 0.
  * fixed a dozen broken test when running in parallel.

V5 -> V4:
  * change to SOCK_SEQPACKET for close notification.
  * move all debug output to "--debug" mode
  * output log as test finish, and all error logs again after summary lin=
e.
  * variable naming / style changes
  * adds serial_test_name() to replace serial test lists.


Yucong Sun (14):
  selftests/bpf: Add parallelism to test_progs
  selftests/bpf: Allow some tests to be executed in sequence
  selftests/bpf: disable perf rate limiting when running tests.
  selftests/bpf: add per worker cgroup suffix
  selftests/bpf: adding read_perf_max_sample_freq() helper
  selftests/bpf: fix race condition in enable_stats
  selftests/bpf: make cgroup_v1v2 use its own port
  selftests/bpf: adding a namespace reset for tc_redirect
  selftests/bpf: Make uprobe tests use different attach functions.
  selftests/bpf: adding pid filtering for atomics test
  selftests/bpf: adding random delay for send_signal test
  selftests/bpf: Fix pid check in fexit_sleep test
  selftests/bpf: increase loop count for perf_branches
  selfetest/bpf: make some tests serial

 tools/testing/selftests/bpf/cgroup_helpers.c  |   6 +-
 tools/testing/selftests/bpf/cgroup_helpers.h  |   2 +-
 .../selftests/bpf/prog_tests/atomics.c        |   1 +
 .../selftests/bpf/prog_tests/attach_probe.c   |   8 +-
 .../selftests/bpf/prog_tests/bpf_cookie.c     |  10 +-
 .../bpf/prog_tests/bpf_iter_setsockopt.c      |   2 +-
 .../selftests/bpf/prog_tests/bpf_obj_id.c     |   2 +-
 .../bpf/prog_tests/cg_storage_multi.c         |   2 +-
 .../bpf/prog_tests/cgroup_attach_autodetach.c |   2 +-
 .../bpf/prog_tests/cgroup_attach_multi.c      |   2 +-
 .../bpf/prog_tests/cgroup_attach_override.c   |   2 +-
 .../selftests/bpf/prog_tests/cgroup_link.c    |   2 +-
 .../selftests/bpf/prog_tests/cgroup_v1v2.c    |   2 +-
 .../selftests/bpf/prog_tests/check_mtu.c      |   2 +-
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  |   3 +-
 .../prog_tests/flow_dissector_load_bytes.c    |   2 +-
 .../bpf/prog_tests/flow_dissector_reattach.c  |   2 +-
 .../bpf/prog_tests/get_branch_snapshot.c      |   2 +-
 .../selftests/bpf/prog_tests/kfree_skb.c      |   3 +-
 .../bpf/prog_tests/migrate_reuseport.c        |   2 +-
 .../selftests/bpf/prog_tests/modify_return.c  |   3 +-
 .../bpf/prog_tests/ns_current_pid_tgid.c      |   3 +-
 .../selftests/bpf/prog_tests/perf_branches.c  |  10 +-
 .../selftests/bpf/prog_tests/perf_buffer.c    |   2 +-
 .../selftests/bpf/prog_tests/perf_link.c      |   5 +-
 .../selftests/bpf/prog_tests/probe_user.c     |   3 +-
 .../bpf/prog_tests/raw_tp_writable_test_run.c |   3 +-
 .../bpf/prog_tests/select_reuseport.c         |   2 +-
 .../selftests/bpf/prog_tests/send_signal.c    |   6 +-
 .../bpf/prog_tests/send_signal_sched_switch.c |   3 +-
 .../bpf/prog_tests/sk_storage_tracing.c       |   2 +-
 .../selftests/bpf/prog_tests/snprintf_btf.c   |   2 +-
 .../selftests/bpf/prog_tests/sock_fields.c    |   2 +-
 .../selftests/bpf/prog_tests/sockmap_listen.c |   2 +-
 .../bpf/prog_tests/stacktrace_build_id_nmi.c  |  19 +-
 .../selftests/bpf/prog_tests/task_pt_regs.c   |   8 +-
 .../selftests/bpf/prog_tests/tc_redirect.c    |  14 +
 .../testing/selftests/bpf/prog_tests/timer.c  |   3 +-
 .../selftests/bpf/prog_tests/timer_mim.c      |   2 +-
 .../bpf/prog_tests/tp_attach_query.c          |   2 +-
 .../selftests/bpf/prog_tests/trace_printk.c   |   2 +-
 .../selftests/bpf/prog_tests/trace_vprintk.c  |   2 +-
 .../bpf/prog_tests/trampoline_count.c         |   3 +-
 .../selftests/bpf/prog_tests/xdp_attach.c     |   2 +-
 .../selftests/bpf/prog_tests/xdp_bonding.c    |   2 +-
 .../bpf/prog_tests/xdp_cpumap_attach.c        |   2 +-
 .../bpf/prog_tests/xdp_devmap_attach.c        |   2 +-
 .../selftests/bpf/prog_tests/xdp_info.c       |   2 +-
 .../selftests/bpf/prog_tests/xdp_link.c       |   2 +-
 tools/testing/selftests/bpf/progs/atomics.c   |  16 +
 .../selftests/bpf/progs/connect4_dropper.c    |   2 +-
 .../testing/selftests/bpf/progs/fexit_sleep.c |   4 +-
 .../selftests/bpf/progs/test_enable_stats.c   |   2 +-
 tools/testing/selftests/bpf/test_progs.c      | 671 +++++++++++++++++-
 tools/testing/selftests/bpf/test_progs.h      |  37 +-
 55 files changed, 790 insertions(+), 116 deletions(-)

--=20
2.30.2

