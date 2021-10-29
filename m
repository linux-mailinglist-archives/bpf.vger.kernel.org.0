Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE7CA43F77B
	for <lists+bpf@lfdr.de>; Fri, 29 Oct 2021 08:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbhJ2Gxe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Oct 2021 02:53:34 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14876 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbhJ2Gx1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Oct 2021 02:53:27 -0400
Received: from dggeme762-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HgY3Y6l10z90CJ;
        Fri, 29 Oct 2021 14:50:49 +0800 (CST)
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
Subject: [PATCH v2 1/2] perf symbol: ignore $a/$d symbols for ARM modules
Date:   Fri, 29 Oct 2021 14:50:37 +0800
Message-ID: <20211029065038.39449-2-shaolexi@huawei.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20211029065038.39449-1-shaolexi@huawei.com>
References: <cb7e9ef7-eda4-b197-df8a-0b54f9b56181@arm.com>
 <20211029065038.39449-1-shaolexi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.2]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On ARM machine, kernel symbols from modules can be resolved to $a
instead of printing the actual symbol name. Ignore symbols starting with
"$" when building kallsyms rbtree.

A sample stacktrace is shown as follows:

c0f2e39c schedule_hrtimeout+0x14 ([kernel.kallsyms])
bf4a66d8 $a+0x78 ([test_module])
c0a4f5f4 kthread+0x15c ([kernel.kallsyms])
c0a001f8 ret_from_fork+0x14 ([kernel.kallsyms])

On ARM machine, $a/$d symbols are used by the compiler to mark the
beginning of code/data part in code section. These symbols are filtered
out when linking vmlinux(see scripts/kallsyms.c ignored_prefixes), but
are left on modules. So there are $a symbols in /proc/kallsyms which
share the same addresses with the actual module symbols and confuses perf
when resolving symbols.

After this patch, the module symbol name is printed:

c0f2e39c schedule_hrtimeout+0x14 ([kernel.kallsyms])
bf4a66d8 test_func+0x78 ([test_module])
c0a4f5f4 kthread+0x15c ([kernel.kallsyms])
c0a001f8 ret_from_fork+0x14 ([kernel.kallsyms])

Signed-off-by: Lexi Shao <shaolexi@huawei.com>
Reviewed-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/symbol.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 0fc9a5410739..35116aed74eb 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -702,6 +702,10 @@ static int map__process_kallsym_symbol(void *arg, const char *name,
 	if (!symbol_type__filter(type))
 		return 0;
 
+	/* Ignore local symbols for ARM modules */
+	if (name[0] == '$')
+		return 0;
+
 	/*
 	 * module symbols are not sorted so we add all
 	 * symbols, setting length to 0, and rely on
-- 
2.12.3

