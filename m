Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15688415402
	for <lists+bpf@lfdr.de>; Thu, 23 Sep 2021 01:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhIVXmu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 22 Sep 2021 19:42:50 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48784 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230145AbhIVXmu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 22 Sep 2021 19:42:50 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18MN6i9M004151
        for <bpf@vger.kernel.org>; Wed, 22 Sep 2021 16:41:19 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b8dvdr52s-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 22 Sep 2021 16:41:19 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 22 Sep 2021 16:41:17 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 777A94B32F2F; Wed, 22 Sep 2021 16:41:15 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v3 bpf-next 0/9] libbpf: stricter BPF program section name handling
Date:   Wed, 22 Sep 2021 16:41:04 -0700
Message-ID: <20210922234113.1965663-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: mjlVd_HA9BRyu16WNYuwVmigwGZIxnBb
X-Proofpoint-ORIG-GUID: mjlVd_HA9BRyu16WNYuwVmigwGZIxnBb
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-22_09,2021-09-22_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 mlxscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109200000 definitions=main-2109220150
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Implement opt-in stricter BPF program section name (SEC()) handling logic. For
a lot of supported ELF section names, enforce exact section name match with no
arbitrary characters added at the end. See patch #8 for more details.

To allow this, first three patches clean up and preventively fix selftests,
normalizing existing SEC() usage across multiple selftests. While at it those
patches also reduce the amount of remaining bpf_object__find_program_by_title()
uses, which should be completely removed soon, given it's an API with
ambiguous semantics and will be deprecated and eventually removed in libbpf 1.0.

Last patch is also fixing "sk_lookup/" definition to not require and not allow
extra "/blah" parts after it, which serve no meaning.

All the other patches are gradual internal libbpf changes to:
  - allow this optional strict logic for ELF section name handling;
  - allow new use case (for now for "struct_ops", but that could be extended
    to, say, freplace definitions), in which it can be used stand-alone to
    specify just type (SEC("struct_ops")), or also accept extra parameters
    which can be utilized by libbpf to either get more data or double-check
    valid use (e.g., SEC("struct_ops/dctcp_init") to specify desired
    struct_ops operation that is supposed to be implemented);
  - get libbpf's internal logic ready to allow other libraries and
    applications to specify their custom handlers for ELF section name for BPF
    programs. All the pieces are in place, the only thing preventing making
    this as public libbpf API is reliance on internal type for specifying BPF
    program load attributes. The work is planned to revamp related low-level
    libbpf APIs, at which point it will be possible to just re-use such new
    types for coordination between libbpf and custom handlers.

These changes are a part of libbpf 1.0 effort ([0]). They are also intended to
be applied on top of the previous preparatory series [1], so currently CI will
be failing to apply them to bpf-next until that patch set is landed. Once it
is landed, kernel-patches daemon will automatically retest this patch set.

  [0] https://github.com/libbpf/libbpf/wiki/Libbpf:-the-road-to-v1.0#stricter-and-more-uniform-bpf-program-section-name-sec-handling
  [1] https://patchwork.kernel.org/project/netdevbpf/list/?series=547675&state=*

v2->v3:
  - applied acks, addressed most feedback, added comments to new flags (Dave);
v1->v2:
  - rebase onto latest bpf-next and resolve merge conflicts w/ Dave's changes.

Andrii Nakryiko (9):
  selftests/bpf: normalize XDP section names in selftests
  selftests/bpf: normalize SEC("classifier") usage
  selftests/bpf: normalize all the rest SEC() uses
  libbpf: refactor internal sec_def handling to enable pluggability
  libbpf: reduce reliance of attach_fns on sec_def internals
  libbpf: refactor ELF section handler definitions
  libbpf: complete SEC() table unification for
    BPF_APROG_SEC/BPF_EAPROG_SEC
  libbpf: add opt-in strict BPF program section name handling logic
  selftests/bpf: switch sk_lookup selftests to strict SEC("sk_lookup")
    use

 tools/lib/bpf/libbpf.c                        | 517 +++++++++---------
 tools/lib/bpf/libbpf_internal.h               |   7 +
 tools/lib/bpf/libbpf_legacy.h                 |   9 +
 .../selftests/bpf/prog_tests/flow_dissector.c |   4 +-
 .../bpf/prog_tests/reference_tracking.c       |  23 +-
 .../selftests/bpf/prog_tests/sk_assign.c      |   2 +-
 .../selftests/bpf/prog_tests/sockopt_multi.c  |  30 +-
 .../selftests/bpf/prog_tests/tailcalls.c      |  58 +-
 tools/testing/selftests/bpf/progs/bpf_flow.c  |   3 +-
 .../bpf/progs/cg_storage_multi_isolated.c     |   4 +-
 .../bpf/progs/cg_storage_multi_shared.c       |   4 +-
 .../testing/selftests/bpf/progs/skb_pkt_end.c |   2 +-
 .../selftests/bpf/progs/sockopt_multi.c       |   5 +-
 tools/testing/selftests/bpf/progs/tailcall1.c |   5 +-
 tools/testing/selftests/bpf/progs/tailcall2.c |  21 +-
 tools/testing/selftests/bpf/progs/tailcall3.c |   5 +-
 tools/testing/selftests/bpf/progs/tailcall4.c |   5 +-
 tools/testing/selftests/bpf/progs/tailcall5.c |   5 +-
 tools/testing/selftests/bpf/progs/tailcall6.c |   4 +-
 .../selftests/bpf/progs/tailcall_bpf2bpf1.c   |   5 +-
 .../selftests/bpf/progs/tailcall_bpf2bpf2.c   |   5 +-
 .../selftests/bpf/progs/tailcall_bpf2bpf3.c   |   9 +-
 .../selftests/bpf/progs/tailcall_bpf2bpf4.c   |  13 +-
 .../bpf/progs/test_btf_skc_cls_ingress.c      |   2 +-
 .../selftests/bpf/progs/test_cgroup_link.c    |   4 +-
 .../selftests/bpf/progs/test_cls_redirect.c   |   2 +-
 .../selftests/bpf/progs/test_global_data.c    |   2 +-
 .../selftests/bpf/progs/test_global_func1.c   |   2 +-
 .../selftests/bpf/progs/test_global_func3.c   |   2 +-
 .../selftests/bpf/progs/test_global_func5.c   |   2 +-
 .../selftests/bpf/progs/test_global_func6.c   |   2 +-
 .../selftests/bpf/progs/test_global_func7.c   |   2 +-
 .../selftests/bpf/progs/test_map_in_map.c     |   2 +-
 .../bpf/progs/test_misc_tcp_hdr_options.c     |   2 +-
 .../selftests/bpf/progs/test_pkt_access.c     |   2 +-
 .../selftests/bpf/progs/test_pkt_md_access.c  |   4 +-
 .../selftests/bpf/progs/test_sk_assign.c      |   3 +-
 .../selftests/bpf/progs/test_sk_lookup.c      |  44 +-
 .../selftests/bpf/progs/test_sk_lookup_kern.c |  37 +-
 .../selftests/bpf/progs/test_skb_helpers.c    |   2 +-
 .../selftests/bpf/progs/test_sockmap_listen.c |   2 +-
 .../progs/test_sockmap_skb_verdict_attach.c   |   2 +-
 .../selftests/bpf/progs/test_sockmap_update.c |   2 +-
 .../selftests/bpf/progs/test_tc_neigh.c       |   6 +-
 .../selftests/bpf/progs/test_tc_neigh_fib.c   |   6 +-
 .../selftests/bpf/progs/test_tc_peer.c        |  10 +-
 .../bpf/progs/test_tcp_check_syncookie_kern.c |   4 +-
 .../bpf/progs/test_tcp_hdr_options.c          |   2 +-
 tools/testing/selftests/bpf/progs/test_xdp.c  |   2 +-
 .../bpf/progs/test_xdp_adjust_tail_grow.c     |   2 +-
 .../bpf/progs/test_xdp_adjust_tail_shrink.c   |   4 +-
 .../bpf/progs/test_xdp_devmap_helpers.c       |   2 +-
 .../selftests/bpf/progs/test_xdp_link.c       |   2 +-
 .../selftests/bpf/progs/test_xdp_loop.c       |   2 +-
 .../selftests/bpf/progs/test_xdp_noinline.c   |   4 +-
 .../bpf/progs/test_xdp_with_cpumap_helpers.c  |   4 +-
 .../bpf/progs/test_xdp_with_devmap_helpers.c  |   4 +-
 tools/testing/selftests/bpf/progs/xdp_dummy.c |   2 +-
 .../bpf/progs/xdp_redirect_multi_kern.c       |   4 +-
 .../testing/selftests/bpf/progs/xdping_kern.c |   4 +-
 .../selftests/bpf/test_tcp_check_syncookie.sh |   4 +-
 .../selftests/bpf/test_xdp_redirect.sh        |   4 +-
 .../selftests/bpf/test_xdp_redirect_multi.sh  |   2 +-
 tools/testing/selftests/bpf/test_xdp_veth.sh  |   4 +-
 tools/testing/selftests/bpf/xdping.c          |   5 +-
 65 files changed, 473 insertions(+), 477 deletions(-)

-- 
2.30.2

