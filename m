Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9625B621038
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 13:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbiKHMTh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 07:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233722AbiKHMTe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 07:19:34 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE532339E;
        Tue,  8 Nov 2022 04:19:32 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N66bd5nRmz4f3w16;
        Tue,  8 Nov 2022 20:19:25 +0800 (CST)
Received: from localhost.localdomain (unknown [10.67.175.61])
        by APP4 (Coremail) with SMTP id gCh0CgCH+dZQSWpjw668AA--.47234S2;
        Tue, 08 Nov 2022 20:19:28 +0800 (CST)
From:   Pu Lehui <pulehui@huaweicloud.com>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Pu Lehui <pulehui@huawei.com>,
        Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf] selftests/bpf: Fix casting error when cross-compiling test_verifier for 32-bit platforms
Date:   Tue,  8 Nov 2022 20:19:45 +0800
Message-Id: <20221108121945.4104644-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCH+dZQSWpjw668AA--.47234S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFykKF1UKw48KFyDCry5XFb_yoW8GryUpF
        WrG3sFgFy8X3W3Kr1UAF4UtrW8KF1qqa48Gry3tryDZF4DKF92gFyxKrWqvr93uFWrXwna
        y347Was8Xw1qyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
        n2kIc2xKxwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWU
        JwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
        nIWIevJa73UjIFyTuYvjfUr2-eDUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Pu Lehui <pulehui@huawei.com>

When cross-compiling test_verifier for 32-bit platforms, the casting error is shown below:

test_verifier.c:1263:27: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
 1263 |  info.xlated_prog_insns = (__u64)*buf;
      |                           ^
cc1: all warnings being treated as errors

Fix it by adding zero-extension for it.

Fixes: 933ff53191eb ("selftests/bpf: specify expected instructions in test_verifier tests")
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 tools/testing/selftests/bpf/test_verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 2dbcbf363c18..b605a70d4f6b 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -1260,7 +1260,7 @@ static int get_xlated_program(int fd_prog, struct bpf_insn **buf, int *cnt)
 
 	bzero(&info, sizeof(info));
 	info.xlated_prog_len = xlated_prog_len;
-	info.xlated_prog_insns = (__u64)*buf;
+	info.xlated_prog_insns = (__u64)(unsigned long)*buf;
 	if (bpf_obj_get_info_by_fd(fd_prog, &info, &info_len)) {
 		perror("second bpf_obj_get_info_by_fd failed");
 		goto out_free_buf;
-- 
2.25.1

