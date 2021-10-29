Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97D043F77A
	for <lists+bpf@lfdr.de>; Fri, 29 Oct 2021 08:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbhJ2Gxd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Oct 2021 02:53:33 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:26205 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbhJ2Gx1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Oct 2021 02:53:27 -0400
Received: from dggeme762-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HgY226XsBz8tcK;
        Fri, 29 Oct 2021 14:49:30 +0800 (CST)
Received: from huawei.com (10.67.189.2) by dggeme762-chm.china.huawei.com
 (10.3.19.108) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.15; Fri, 29
 Oct 2021 14:50:54 +0800
From:   Lexi Shao <shaolexi@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <james.clark@arm.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <mark.rutland@arm.com>, <mingo@redhat.com>, <namhyung@kernel.org>,
        <nixiaoming@huawei.com>, <peterz@infradead.org>,
        <qiuxi1@huawei.com>, <shaolexi@huawei.com>, <wangbing6@huawei.com>,
        <jeyu@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kafai@fb.com>, <songliubraving@fb.com>,
        <yhs@fb.com>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
        <natechancellor@gmail.com>, <ndesaulniers@google.com>,
        <bpf@vger.kernel.org>, <clang-built-linux@googlegroups.com>
Subject: [PATCH v2 0/2] kallsyms: Ignore $a/$d symbols in kallsyms for ARM
Date:   Fri, 29 Oct 2021 14:50:36 +0800
Message-ID: <20211029065038.39449-1-shaolexi@huawei.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <cb7e9ef7-eda4-b197-df8a-0b54f9b56181@arm.com>
References: <cb7e9ef7-eda4-b197-df8a-0b54f9b56181@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.2]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On ARM machine, $a/$d symbols are used by the compiler to mark the beginning
of code/data part in code section. These symbols are filtered out when
linking vmlinux(see scripts/kallsyms.c ignored_prefixes), but are left on
modules. So there are $a symbols in /proc/kallsyms whose address overlap
with the actual module symbols and can confuse tools such as perf when
resolving kernel symbols.

A sample stacktrace shown by perf script:
c0f2e39c schedule_hrtimeout+0x14 ([kernel.kallsyms])
bf4a66d8 $a+0x78 ([test_module]) // $a is shown instead of actual sym name
c0a4f5f4 kthread+0x15c ([kernel.kallsyms])
c0a001f8 ret_from_fork+0x14 ([kernel.kallsyms])

This patch set contains 2 patches to fix such problem:
The 1st patch modifies perf userspace tools to ignore $a/$d symbols from
/proc/kallsyms. So people can use new perf tool to get correct kernel symbol
on arm machines instead of updating kernel image.

The 2nd patch modifies the logic of loading modules to ignore arm mapping
symbols in the first place. Being left out in vmlinux and kernelspace API
(e.g. module_kallsyms_on_each_symbol) means these symbols are not used
anywhere, so it should be safe to remove them from module kallsyms list.

v2:
 - Add 2nd patch as discussed with James Clark, see:
   https://lore.kernel.org/all/c7dfbd17-85fd-b914-b90f-082abc64c9d1@arm.com/

Lexi Shao (2):
  perf symbol: ignore $a/$d symbols for ARM modules
  kallsyms: ignore arm mapping symbols when loading module

 kernel/module.c          | 19 +++++++++++--------
 tools/perf/util/symbol.c |  4 ++++
 2 files changed, 15 insertions(+), 8 deletions(-)

-- 
2.12.3

