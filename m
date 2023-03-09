Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CD76B1AE1
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 06:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjCIFkc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 9 Mar 2023 00:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjCIFkb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 00:40:31 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A2385353
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 21:40:30 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3293CvML002206
        for <bpf@vger.kernel.org>; Wed, 8 Mar 2023 21:40:29 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p76y3rp8y-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 08 Mar 2023 21:40:29 -0800
Received: from twshared30317.05.prn5.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 8 Mar 2023 21:40:27 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 780CD29AA2045; Wed,  8 Mar 2023 21:40:16 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 0/4] selftests/bpf: make BPF_CFLAGS stricter with -Wall
Date:   Wed, 8 Mar 2023 21:40:11 -0800
Message-ID: <20230309054015.4068562-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: aiyS36Mu6G4GxAZU8H5-d52hRgjUuiDc
X-Proofpoint-ORIG-GUID: aiyS36Mu6G4GxAZU8H5-d52hRgjUuiDc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_02,2023-03-08_03,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make BPF-side compiler flags stricter by adding -Wall. Fix tons of small
issues pointed out by compiler immediately after that. That includes newly
added bpf_for(), bpf_for_each(), and bpf_repeat() macros.

Andrii Nakryiko (4):
  selftests/bpf: prevent unused variable warning in bpf_for()
  selftests/bpf: add __sink() macro to fake variable consumption
  selftests/bpf: fix lots of silly mistakes pointed out by compiler
  selftests/bpf: make BPF compiler flags stricter

 tools/testing/selftests/bpf/Makefile          |  4 +-
 .../selftests/bpf/progs/bpf_iter_ksym.c       |  1 -
 .../selftests/bpf/progs/bpf_iter_setsockopt.c |  1 -
 tools/testing/selftests/bpf/progs/bpf_loop.c  |  2 -
 tools/testing/selftests/bpf/progs/bpf_misc.h  | 12 ++++--
 tools/testing/selftests/bpf/progs/cb_refs.c   |  1 -
 .../bpf/progs/cgroup_skb_sk_lookup_kern.c     |  1 -
 .../selftests/bpf/progs/cgrp_kfunc_failure.c  |  1 +
 .../bpf/progs/cgrp_ls_attach_cgroup.c         |  1 -
 .../selftests/bpf/progs/cgrp_ls_sleepable.c   |  1 -
 tools/testing/selftests/bpf/progs/core_kern.c |  2 +-
 .../selftests/bpf/progs/cpumask_failure.c     |  3 ++
 .../selftests/bpf/progs/cpumask_success.c     |  1 -
 .../testing/selftests/bpf/progs/dynptr_fail.c |  5 ++-
 .../selftests/bpf/progs/dynptr_success.c      |  5 +--
 .../selftests/bpf/progs/fexit_bpf2bpf.c       |  2 -
 .../bpf/progs/freplace_attach_probe.c         |  2 +-
 tools/testing/selftests/bpf/progs/iters.c     | 11 +++--
 .../selftests/bpf/progs/linked_funcs1.c       |  3 ++
 .../selftests/bpf/progs/linked_funcs2.c       |  3 ++
 .../testing/selftests/bpf/progs/linked_list.c |  4 --
 .../selftests/bpf/progs/linked_list_fail.c    |  1 -
 .../selftests/bpf/progs/local_storage.c       |  1 -
 tools/testing/selftests/bpf/progs/map_kptr.c  |  3 --
 .../testing/selftests/bpf/progs/netcnt_prog.c |  1 -
 .../selftests/bpf/progs/netif_receive_skb.c   |  1 -
 .../selftests/bpf/progs/perfbuf_bench.c       |  1 -
 tools/testing/selftests/bpf/progs/pyperf.h    |  2 +-
 .../progs/rbtree_btf_fail__wrong_node_type.c  | 11 -----
 .../testing/selftests/bpf/progs/rbtree_fail.c |  3 +-
 .../selftests/bpf/progs/rcu_read_lock.c       |  4 --
 .../bpf/progs/read_bpf_task_storage_busy.c    |  1 -
 .../selftests/bpf/progs/recvmsg4_prog.c       |  2 -
 .../selftests/bpf/progs/recvmsg6_prog.c       |  2 -
 .../selftests/bpf/progs/sendmsg4_prog.c       |  2 -
 .../bpf/progs/sockmap_verdict_prog.c          |  4 ++
 .../testing/selftests/bpf/progs/strobemeta.h  |  1 -
 .../selftests/bpf/progs/tailcall_bpf2bpf3.c   | 11 +++++
 .../selftests/bpf/progs/tailcall_bpf2bpf6.c   |  3 ++
 .../selftests/bpf/progs/task_kfunc_failure.c  |  1 +
 .../selftests/bpf/progs/task_kfunc_success.c  |  6 ---
 .../testing/selftests/bpf/progs/test_bpf_nf.c |  1 -
 .../bpf/progs/test_cls_redirect_dynptr.c      |  1 -
 .../progs/test_core_reloc_bitfields_probed.c  |  1 -
 .../selftests/bpf/progs/test_global_func1.c   |  4 ++
 .../selftests/bpf/progs/test_global_func2.c   |  4 ++
 .../selftests/bpf/progs/test_hash_large_key.c |  2 +-
 .../bpf/progs/test_ksyms_btf_write_check.c    |  1 -
 .../selftests/bpf/progs/test_legacy_printk.c  |  2 +-
 .../selftests/bpf/progs/test_map_lock.c       |  2 +-
 .../testing/selftests/bpf/progs/test_obj_id.c |  2 +
 .../bpf/progs/test_parse_tcp_hdr_opt.c        |  1 -
 .../bpf/progs/test_parse_tcp_hdr_opt_dynptr.c |  2 +-
 .../selftests/bpf/progs/test_pkt_access.c     |  5 +++
 .../selftests/bpf/progs/test_ringbuf.c        |  1 -
 .../bpf/progs/test_ringbuf_map_key.c          |  1 +
 .../selftests/bpf/progs/test_ringbuf_multi.c  |  1 -
 .../bpf/progs/test_select_reuseport_kern.c    |  2 +-
 .../selftests/bpf/progs/test_sk_assign.c      |  4 +-
 .../selftests/bpf/progs/test_sk_lookup.c      |  9 +---
 .../selftests/bpf/progs/test_sk_lookup_kern.c |  2 -
 .../selftests/bpf/progs/test_sock_fields.c    |  2 +-
 .../selftests/bpf/progs/test_sockmap_kern.h   | 14 ++++--
 .../selftests/bpf/progs/test_spin_lock.c      |  3 ++
 .../selftests/bpf/progs/test_tc_dtime.c       |  4 +-
 .../selftests/bpf/progs/test_tc_neigh.c       |  4 +-
 .../selftests/bpf/progs/test_tcpbpf_kern.c    |  2 -
 .../selftests/bpf/progs/test_tunnel_kern.c    |  6 ---
 .../selftests/bpf/progs/test_usdt_multispec.c |  2 -
 .../selftests/bpf/progs/test_verif_scale1.c   |  2 +-
 .../selftests/bpf/progs/test_verif_scale2.c   |  2 +-
 .../selftests/bpf/progs/test_verif_scale3.c   |  2 +-
 .../bpf/progs/test_xdp_adjust_tail_grow.c     |  2 -
 .../selftests/bpf/progs/test_xdp_bpf2bpf.c    |  2 -
 .../selftests/bpf/progs/test_xdp_dynptr.c     |  2 -
 .../selftests/bpf/progs/test_xdp_noinline.c   | 43 -------------------
 .../selftests/bpf/progs/test_xdp_vlan.c       | 13 ------
 tools/testing/selftests/bpf/progs/type_cast.c |  1 -
 tools/testing/selftests/bpf/progs/udp_limit.c |  2 -
 .../bpf/progs/user_ringbuf_success.c          |  6 ---
 .../selftests/bpf/progs/xdp_features.c        |  1 -
 .../testing/selftests/bpf/progs/xdping_kern.c |  2 -
 tools/testing/selftests/bpf/progs/xdpwall.c   |  1 -
 83 files changed, 101 insertions(+), 192 deletions(-)

-- 
2.34.1

