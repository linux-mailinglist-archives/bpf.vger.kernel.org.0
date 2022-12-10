Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07212648D93
	for <lists+bpf@lfdr.de>; Sat, 10 Dec 2022 09:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiLJIUx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Dec 2022 03:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiLJIUw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Dec 2022 03:20:52 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489AC178AE;
        Sat, 10 Dec 2022 00:20:51 -0800 (PST)
Received: from dggpeml100010.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NTgmX2wHgz15NDB;
        Sat, 10 Dec 2022 16:19:56 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml100010.china.huawei.com
 (7.185.36.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 10 Dec
 2022 16:20:48 +0800
From:   Xin Liu <liuxin350@huawei.com>
To:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <haoluo@google.com>, <jolsa@kernel.org>
CC:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yanan@huawei.com>, <wuchangye@huawei.com>,
        <xiesongyang@huawei.com>, <kongweibin2@huawei.com>,
        <liuxin350@huawei.com>, <zhangmingyi5@huawei.com>
Subject: [PATCH bpf-next v3] libbpf: Optimized return value in libbpf_strerror when errno is libbpf errno
Date:   Sat, 10 Dec 2022 16:20:45 +0800
Message-ID: <20221210082045.233697-1-liuxin350@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml100010.china.huawei.com (7.185.36.14)
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

v3:
Simplify the code and remove the processing that snprintf returns
negative numbers.

v2:
Check the return value of snprintf to determine whether the buffer is
too small.
https://lore.kernel.org/bpf/20221209110502.231677-1-liuxin350@huawei.com/T/#t

v1:
https://lore.kernel.org/bpf/20221209084047.229525-1-liuxin350@huawei.com/T/#t

 tools/lib/bpf/libbpf_errno.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf_errno.c b/tools/lib/bpf/libbpf_errno.c
index 96f67a772a1b..71da6e5e70da 100644
--- a/tools/lib/bpf/libbpf_errno.c
+++ b/tools/lib/bpf/libbpf_errno.c
@@ -39,14 +39,14 @@ static const char *libbpf_strerror_table[NR_ERRNO] = {
 
 int libbpf_strerror(int err, char *buf, size_t size)
 {
+	int ret;
+
 	if (!buf || !size)
 		return libbpf_err(-EINVAL);
 
 	err = err > 0 ? err : -err;
 
 	if (err < __LIBBPF_ERRNO__START) {
-		int ret;
-
 		ret = strerror_r(err, buf, size);
 		buf[size - 1] = '\0';
 		return libbpf_err_errno(ret);
@@ -56,12 +56,20 @@ int libbpf_strerror(int err, char *buf, size_t size)
 		const char *msg;
 
 		msg = libbpf_strerror_table[ERRNO_OFFSET(err)];
-		snprintf(buf, size, "%s", msg);
+		ret = snprintf(buf, size, "%s", msg);
 		buf[size - 1] = '\0';
+		/* The length of the buf and msg is positive.
+		 * A negative number may be returned only when the
+		 * size exceeds INT_MAX. Not likely to appear.
+		 */
+		if (ret >= size)
+			return libbpf_err(-ERANGE);
 		return 0;
 	}
 
-	snprintf(buf, size, "Unknown libbpf error %d", err);
+	ret = snprintf(buf, size, "Unknown libbpf error %d", err);
 	buf[size - 1] = '\0';
+	if (ret >= size)
+		return libbpf_err(-ERANGE);
 	return libbpf_err(-ENOENT);
 }
-- 
2.33.0

