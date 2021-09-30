Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F87441D5D7
	for <lists+bpf@lfdr.de>; Thu, 30 Sep 2021 11:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349104AbhI3JBn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Sep 2021 05:01:43 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:24204 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348225AbhI3JBm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Sep 2021 05:01:42 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HKnGx42dMz8tXL;
        Thu, 30 Sep 2021 16:59:05 +0800 (CST)
Received: from dggpeml500025.china.huawei.com (7.185.36.35) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 30 Sep 2021 16:59:58 +0800
Received: from huawei.com (10.175.124.27) by dggpeml500025.china.huawei.com
 (7.185.36.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 30 Sep
 2021 16:59:58 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     Alexei Starovoitov <ast@kernel.org>
CC:     Yonghong Song <yhs@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
        "Andrii Nakryiko" <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <houtao1@huawei.com>
Subject: [PATCH bpf-next v4 0/3] add support for writable bare tracepoint
Date:   Thu, 30 Sep 2021 17:13:51 +0800
Message-ID: <20210930091355.2794601-1-houtao1@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

The patchset series supports writable context for bare tracepoint.

The main idea comes from patchset "writable contexts for bpf raw
tracepoints" [1], but it only supports normal tracepoint with
associated trace event under tracefs. Now we have one use case
in which we will add bare tracepoint in VFS layer, and update
file::f_mode for specific files. The reason using bare tracepoint
is that it doesn't form a ABI and we can change it freely. So
add support for it in BPF.

Comments are always welcome.

[1]: https://lore.kernel.org/lkml/20190426184951.21812-1-mmullins@fb.com

Change log:
v4:
 * rebased on bpf-next
 * update patch 2 to add support for writable raw tracepoint attachment
   in attach_raw_tp().
 * update patch 3 to add Acked-by tag

v3: https://www.spinics.net/lists/bpf/msg46824.html
  * use raw_tp.w instead of raw_tp_writable as section
    name of writable tp
  * use ASSERT_XXX() instead of CHECK()
  * define a common macro for "/sys/kernel/bpf_testmod"

v2: https://www.spinics.net/lists/bpf/msg46356.html 
  * rebase on bpf-next tree
  * address comments from Yonghong Song
  * rename bpf_testmode_test_writable_ctx::ret as early_ret to reflect
    its purpose better.

v1: https://www.spinics.net/lists/bpf/msg46221.html

Hou Tao (3):
  bpf: support writable context for bare tracepoint
  libbpf: support detecting and attaching of writable tracepoint program
  bpf/selftests: add test for writable bare tracepoint

 include/trace/bpf_probe.h                     | 19 +++++++---
 tools/lib/bpf/libbpf.c                        | 21 ++++++++---
 .../bpf/bpf_testmod/bpf_testmod-events.h      | 15 ++++++++
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 10 ++++++
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  5 +++
 .../selftests/bpf/prog_tests/module_attach.c  | 35 +++++++++++++++++++
 .../selftests/bpf/progs/test_module_attach.c  | 14 ++++++++
 tools/testing/selftests/bpf/test_progs.c      |  4 +--
 tools/testing/selftests/bpf/test_progs.h      |  2 ++
 9 files changed, 114 insertions(+), 11 deletions(-)

-- 
2.29.2

