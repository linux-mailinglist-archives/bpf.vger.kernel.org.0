Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B28F641553
	for <lists+bpf@lfdr.de>; Sat,  3 Dec 2022 10:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiLCJho (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 3 Dec 2022 04:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiLCJho (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 3 Dec 2022 04:37:44 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC5310063;
        Sat,  3 Dec 2022 01:37:42 -0800 (PST)
Received: from dggpeml500010.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NPPpd32B9z15Lxj;
        Sat,  3 Dec 2022 17:36:57 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500010.china.huawei.com
 (7.185.36.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 3 Dec
 2022 17:37:40 +0800
From:   Xin Liu <liuxin350@huawei.com>
To:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <haoluo@google.com>, <jolsa@kernel.org>
CC:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yanan@huawei.com>, <wuchangye@huawei.com>,
        <xiesongyang@huawei.com>, <kongweibin2@huawei.com>,
        <liuxin350@huawei.com>, <zhangmingyi5@huawei.com>
Subject: [PATCH bpf-next] libbpf: Optimized return value in libbpf_strerror when errno is libbpf errno
Date:   Sat, 3 Dec 2022 17:37:40 +0800
Message-ID: <20221203093740.218935-1-liuxin350@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500010.china.huawei.com (7.185.36.155)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is a small improvement in libbpf_strerror. When libbpf_strerror
is used to obtain the system error description, if the length of the
buf is insufficient, libbpf_sterror returns ERANGE and sets errno to
ERANGE.

However, this processing is not performed when the error code
customized by libbpf is obtained. Make some minor improvements here,
return -ERANGE and set errno to ERANGE when buf is not enough for
custom description.

Signed-off-by: Xin Liu <liuxin350@huawei.com>
---
 tools/lib/bpf/libbpf_errno.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/lib/bpf/libbpf_errno.c b/tools/lib/bpf/libbpf_errno.c
index 96f67a772a1b..48ce7d5b5bf9 100644
--- a/tools/lib/bpf/libbpf_errno.c
+++ b/tools/lib/bpf/libbpf_errno.c
@@ -54,10 +54,16 @@ int libbpf_strerror(int err, char *buf, size_t size)
 
 	if (err < __LIBBPF_ERRNO__END) {
 		const char *msg;
+		size_t msg_size;
 
 		msg = libbpf_strerror_table[ERRNO_OFFSET(err)];
 		snprintf(buf, size, "%s", msg);
 		buf[size - 1] = '\0';
+
+		msg_size = strlen(msg);
+		if (msg_size >= size)
+			return libbpf_err(-ERANGE);
+
 		return 0;
 	}
 
-- 
2.33.0

