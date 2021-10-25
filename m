Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC50438F66
	for <lists+bpf@lfdr.de>; Mon, 25 Oct 2021 08:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhJYG1b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 02:27:31 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14859 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhJYG1b (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Oct 2021 02:27:31 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Hd4gh6FKFz909f;
        Mon, 25 Oct 2021 14:25:04 +0800 (CST)
Received: from dggpeml500025.china.huawei.com (7.185.36.35) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 25 Oct 2021 14:25:06 +0800
Received: from huawei.com (10.175.124.27) by dggpeml500025.china.huawei.com
 (7.185.36.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 25 Oct
 2021 14:25:05 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     Alexei Starovoitov <ast@kernel.org>
CC:     Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <houtao1@huawei.com>
Subject: [PATCH bpf-next v4 0/4] introduce dummy BPF STRUCT_OPS
Date:   Mon, 25 Oct 2021 14:40:21 +0800
Message-ID: <20211025064025.2567443-1-houtao1@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

Currently the test of BPF STRUCT_OPS depends on the specific bpf
implementation (e.g, tcp_congestion_ops), but it can not cover all
basic functionalities (e.g, return value handling), so introduce
a dummy BPF STRUCT_OPS for test purpose.

Instead of loading a userspace-implemeted bpf_dummy_ops map into
kernel and calling the specific function by writing to sysfs provided
by bpf_testmode.ko, only loading bpf_dummy_ops related prog into
kernel and calling these prog by bpf_prog_test_run(). The latter
is more flexible and has no dependency on extra kernel module.

Now the return value handling is supported by test_1(...) ops,
and passing multiple arguments is supported by test_2(...) ops.
If more is needed, test_x(...) ops can be added afterwards.

Comments are always welcome.
Regards,
Hou

Change Log:
v4:
 * add Acked-by tags in patch 1~4
 * patch 2: remove unncessary comments and update commit message
            accordingly
 * patch 4: remove unnecessary nr checking in dummy_ops_init_args()

v3: https://www.spinics.net/lists/bpf/msg48303.html
 * rebase on bpf-next
 * address comments for Martin, mainly include: merge patch 3 &
   patch 4 in v2, fix names of btf ctx access check helpers,
   handle CONFIG_NET, fix leak in dummy_ops_init_args(), and
   simplify bpf_dummy_init()
 * patch 4: use a loop to check args in test_dummy_multiple_args()

v2: https://www.spinics.net/lists/bpf/msg47948.html
 * rebase on bpf-next
 * add test_2(...) ops to test the passing of multiple arguments
 * a new patch (patch #2) is added to factor out ctx access helpers
 * address comments from Martin & Andrii

v1: https://www.spinics.net/lists/bpf/msg46787.html

RFC: https://www.spinics.net/lists/bpf/msg46117.html


Hou Tao (4):
  bpf: factor out a helper to prepare trampoline for struct_ops prog
  bpf: factor out helpers for ctx access checking
  bpf: add dummy BPF STRUCT_OPS for test purpose
  selftests/bpf: add test cases for struct_ops prog

 include/linux/bpf.h                           |  43 ++++
 kernel/bpf/bpf_struct_ops.c                   |  32 ++-
 kernel/bpf/bpf_struct_ops_types.h             |   3 +
 kernel/trace/bpf_trace.c                      |  16 +-
 net/bpf/Makefile                              |   3 +
 net/bpf/bpf_dummy_struct_ops.c                | 200 ++++++++++++++++++
 net/ipv4/bpf_tcp_ca.c                         |   9 +-
 .../selftests/bpf/prog_tests/dummy_st_ops.c   | 115 ++++++++++
 .../selftests/bpf/progs/dummy_st_ops.c        |  50 +++++
 9 files changed, 439 insertions(+), 32 deletions(-)
 create mode 100644 net/bpf/bpf_dummy_struct_ops.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c
 create mode 100644 tools/testing/selftests/bpf/progs/dummy_st_ops.c

-- 
2.29.2

