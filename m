Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABB5271509
	for <lists+bpf@lfdr.de>; Sun, 20 Sep 2020 16:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgITOqC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Sep 2020 10:46:02 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:51300 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726306AbgITOqC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 20 Sep 2020 10:46:02 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U9V.p7K_1600613153;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0U9V.p7K_1600613153)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 20 Sep 2020 22:45:55 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     ast@kernel.org
Cc:     daniel@iogearbox.net, kafai@fb.com, andriin@fb.com,
        xhao@linux.alibaba.com, bpf@vger.kernel.org
Subject: [bpf-next 2/3] sample/bpf: Add log2 histogram function support
Date:   Sun, 20 Sep 2020 22:45:46 +0800
Message-Id: <20200920144547.56771-3-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200920144547.56771-1-xhao@linux.alibaba.com>
References: <20200920144547.56771-1-xhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The relative functions is copy from bcc tools
source code: libbpf-tools/trace_helpers.c.
URL: https://github.com/iovisor/bcc.git

Log2 histogram can display the change of the collected
data more conveniently.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 samples/bpf/common.h | 67 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 samples/bpf/common.h

diff --git a/samples/bpf/common.h b/samples/bpf/common.h
new file mode 100644
index 000000000000..ec60fb665544
--- /dev/null
+++ b/samples/bpf/common.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ */
+
+#define min(x, y) ({				 \
+	typeof(x) _min1 = (x);			 \
+	typeof(y) _min2 = (y);			 \
+	(void) (&_min1 == &_min2);		 \
+	_min1 < _min2 ? _min1 : _min2; })
+
+static void print_stars(unsigned int val, unsigned int val_max, int width)
+{
+	int num_stars, num_spaces, i;
+	bool need_plus;
+
+	num_stars = min(val, val_max) * width / val_max;
+	num_spaces = width - num_stars;
+	need_plus = val > val_max;
+
+	for (i = 0; i < num_stars; i++)
+		printf("*");
+	for (i = 0; i < num_spaces; i++)
+		printf(" ");
+	if (need_plus)
+		printf("+");
+}
+
+static void print_log2_hist(unsigned int *vals, int vals_size, char *val_type)
+{
+	int stars_max = 40, idx_max = -1;
+	unsigned int val, val_max = 0;
+	unsigned long long low, high;
+	int stars, width, i;
+
+	for (i = 0; i < vals_size; i++) {
+		val = vals[i];
+		if (val > 0)
+			idx_max = i;
+		if (val > val_max)
+			val_max = val;
+	}
+
+	if (idx_max < 0)
+		return;
+
+	printf("%*s%-*s : count    distribution\n", idx_max <= 32 ? 5 : 15, "",
+		idx_max <= 32 ? 19 : 29, val_type);
+	if (idx_max <= 32)
+		stars = stars_max;
+	else
+		stars = stars_max / 2;
+
+	for (i = 0; i <= idx_max; i++) {
+		low = (1ULL << (i + 1)) >> 1;
+		high = (1ULL << (i + 1)) - 1;
+		if (low == high)
+			low -= 1;
+		val = vals[i];
+		width = idx_max <= 32 ? 10 : 20;
+		printf("%*lld -> %-*lld : %-8d |", width, low, width, high, val);
+		print_stars(val, val_max, stars);
+		printf("|\n");
+	}
+}
-- 
2.28.0

