Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB188655108
	for <lists+bpf@lfdr.de>; Fri, 23 Dec 2022 14:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiLWNgf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Dec 2022 08:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiLWNgd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Dec 2022 08:36:33 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED832379FA;
        Fri, 23 Dec 2022 05:36:31 -0800 (PST)
Received: from dggpeml500010.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ndp8Q0yCJzmWBp;
        Fri, 23 Dec 2022 21:35:18 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500010.china.huawei.com
 (7.185.36.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 23 Dec
 2022 21:36:28 +0800
From:   Xin Liu <liuxin350@huawei.com>
To:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <haoluo@google.com>, <jolsa@kernel.org>
CC:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yanan@huawei.com>, <wuchangye@huawei.com>,
        <xiesongyang@huawei.com>, <kongweibin2@huawei.com>,
        <liuxin350@huawei.com>, <zhangmingyi5@huawei.com>
Subject: [PATCH bpf-next] libbpf: fix errno is overwritten after being closed.
Date:   Fri, 23 Dec 2022 21:36:18 +0800
Message-ID: <20221223133618.10323-1-liuxin350@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500010.china.huawei.com (7.185.36.155)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In the ensure_good_fd function, if the fcntl function succeeds but
the close function fails, ensure_good_fd returns a normal fd and
sets errno, which may cause users to misunderstand. The close
failure is not a serious problem, and the correct FD has been
handed over to the upper-layer application. Let's restore errno here.

Signed-off-by: Xin Liu <liuxin350@huawei.com>
---
 tools/lib/bpf/libbpf_internal.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 377642ff51fc..98333a6c38e9 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -543,10 +543,9 @@ static inline int ensure_good_fd(int fd)
 		fd = fcntl(fd, F_DUPFD_CLOEXEC, 3);
 		saved_errno = errno;
 		close(old_fd);
-		if (fd < 0) {
+		errno = saved_errno;
+		if (fd < 0)
 			pr_warn("failed to dup FD %d to FD > 2: %d\n", old_fd, -saved_errno);
-			errno = saved_errno;
-		}
 	}
 	return fd;
 }
-- 
2.33.0

