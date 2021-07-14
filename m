Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBA53C7B26
	for <lists+bpf@lfdr.de>; Wed, 14 Jul 2021 03:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237241AbhGNBuS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Jul 2021 21:50:18 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:11297 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbhGNBuS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Jul 2021 21:50:18 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GPgHh6H3Zz8scx;
        Wed, 14 Jul 2021 09:42:56 +0800 (CST)
Received: from localhost.localdomain (10.175.103.91) by
 dggeme754-chm.china.huawei.com (10.3.19.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 14 Jul 2021 09:47:24 +0800
From:   Wei Li <liwei391@huawei.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>
CC:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>, <huawei.libin@huawei.com>
Subject: [PATCH] perf trace: Update cmd string table to decode sys_bpf first arg
Date:   Wed, 14 Jul 2021 09:50:00 +0800
Message-ID: <20210714015000.2844867-1-liwei391@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme754-chm.china.huawei.com (10.3.19.100)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

As 'enum bpf_cmd' has been extended a lot, update the cmd string table to
decode sys_bpf first arg clearly in perf-trace.

Signed-off-by: Wei Li <liwei391@huawei.com>
---
 tools/perf/builtin-trace.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 7ec18ff57fc4..17bc6284a93e 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -707,7 +707,15 @@ static size_t syscall_arg__scnprintf_char_array(char *bf, size_t size, struct sy
 
 static const char *bpf_cmd[] = {
 	"MAP_CREATE", "MAP_LOOKUP_ELEM", "MAP_UPDATE_ELEM", "MAP_DELETE_ELEM",
-	"MAP_GET_NEXT_KEY", "PROG_LOAD",
+	"MAP_GET_NEXT_KEY", "PROG_LOAD", "OBJ_PIN", "OBJ_GET", "PROG_ATTACH",
+	"PROG_DETACH", "PROG_TEST_RUN", "PROG_GET_NEXT_ID", "MAP_GET_NEXT_ID",
+	"PROG_GET_FD_BY_ID", "MAP_GET_FD_BY_ID", "OBJ_GET_INFO_BY_FD",
+	"PROG_QUERY", "RAW_TRACEPOINT_OPEN", "BTF_LOAD", "BTF_GET_FD_BY_ID",
+	"TASK_FD_QUERY", "MAP_LOOKUP_AND_DELETE_ELEM", "MAP_FREEZE",
+	"BTF_GET_NEXT_ID", "MAP_LOOKUP_BATCH", "MAP_LOOKUP_AND_DELETE_BATCH",
+	"MAP_UPDATE_BATCH", "MAP_DELETE_BATCH", "LINK_CREATE", "LINK_UPDATE",
+	"LINK_GET_FD_BY_ID", "LINK_GET_NEXT_ID", "ENABLE_STATS", "ITER_CREATE",
+	"LINK_DETACH", "PROG_BIND_MAP",
 };
 static DEFINE_STRARRAY(bpf_cmd, "BPF_");
 
-- 
2.25.1

