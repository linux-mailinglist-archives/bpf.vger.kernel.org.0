Return-Path: <bpf+bounces-7684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B36977AFE0
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 05:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B5BB1C203AF
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 03:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A071D1FCE;
	Mon, 14 Aug 2023 03:08:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E751C3E
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 03:08:26 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBCE9B;
	Sun, 13 Aug 2023 20:08:24 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.53])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RPK5g3zp8z2Bd3M;
	Mon, 14 Aug 2023 11:05:27 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 14 Aug
 2023 11:08:22 +0800
From: Yipeng Zou <zouyipeng@huawei.com>
To: <ast@kernel.org>, <daniel@iogearbox.ne>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>, <mykolal@fb.com>,
	<shuah@kernel.org>, <linux-kselftest@vger.kernel.org>, <bpf@vger.kernel.org>,
	<toke@redhat.com>
CC: <zouyipeng@huawei.com>
Subject: [bpf-next] selftests/bpf: clean-up fmod_ret in bench_rename test script
Date: Mon, 14 Aug 2023 11:07:27 +0800
Message-ID: <20230814030727.3010390-1-zouyipeng@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

[root@localhost bpf]# ./benchs/run_bench_rename.sh
base      :    0.819 ± 0.012M/s
kprobe    :    0.538 ± 0.009M/s
kretprobe :    0.503 ± 0.004M/s
rawtp     :    0.779 ± 0.020M/s
fentry    :    0.726 ± 0.007M/s
fexit     :    0.691 ± 0.007M/s
benchmark 'rename-fmodret' not found

The bench_rename_fmod_ret has been removed in the commit [1], clean-up
it in test script.

[1] b000def2e052 ("selftests: Remove fmod_ret from test_overhead").

Fixes: b000def2e052 ("selftests: Remove fmod_ret from test_overhead")
Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>
---
 tools/testing/selftests/bpf/benchs/run_bench_rename.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/benchs/run_bench_rename.sh b/tools/testing/selftests/bpf/benchs/run_bench_rename.sh
index 16f774b1cdbe..7b281dbe4165 100755
--- a/tools/testing/selftests/bpf/benchs/run_bench_rename.sh
+++ b/tools/testing/selftests/bpf/benchs/run_bench_rename.sh
@@ -2,7 +2,7 @@
 
 set -eufo pipefail
 
-for i in base kprobe kretprobe rawtp fentry fexit fmodret
+for i in base kprobe kretprobe rawtp fentry fexit
 do
 	summary=$(sudo ./bench -w2 -d5 -a rename-$i | tail -n1 | cut -d'(' -f1 | cut -d' ' -f3-)
 	printf "%-10s: %s\n" $i "$summary"
-- 
2.34.1


