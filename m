Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30F0595E8B
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 16:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbiHPOs3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 10:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiHPOs2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 10:48:28 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE425B7AA;
        Tue, 16 Aug 2022 07:48:25 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M6YpQ4yc9zkWMp;
        Tue, 16 Aug 2022 22:45:02 +0800 (CST)
Received: from kwepemm600016.china.huawei.com (7.193.23.20) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 16 Aug 2022 22:48:22 +0800
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600016.china.huawei.com (7.193.23.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 16 Aug 2022 22:48:21 +0800
From:   Guangbin Huang <huangguangbin2@huawei.com>
To:     <pmladek@suse.com>, <rostedt@goodmis.org>,
        <senozhatsky@chromium.org>, <andriy.shevchenko@linux.intel.com>,
        <linux@rasmusvillemoes.dk>
CC:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <lipeng321@huawei.com>, <shenjian15@huawei.com>,
        <huangguangbin2@huawei.com>
Subject: [PATCH] lib/vnsprintf: add const modifier for param 'bitmap'
Date:   Tue, 16 Aug 2022 22:45:57 +0800
Message-ID: <20220816144557.30779-1-huangguangbin2@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600016.china.huawei.com (7.193.23.20)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

There is no modification for param bitmap in function
bitmap_string() and bitmap_list_string(), so add const
modifier for it.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Guangbin Huang <huangguangbin2@huawei.com>
---
 lib/vsprintf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 3c1853a9d1c0..07b36d8b29c3 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1189,7 +1189,7 @@ char *hex_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
 }
 
 static noinline_for_stack
-char *bitmap_string(char *buf, char *end, unsigned long *bitmap,
+char *bitmap_string(char *buf, char *end, const unsigned long *bitmap,
 		    struct printf_spec spec, const char *fmt)
 {
 	const int CHUNKSZ = 32;
@@ -1233,7 +1233,7 @@ char *bitmap_string(char *buf, char *end, unsigned long *bitmap,
 }
 
 static noinline_for_stack
-char *bitmap_list_string(char *buf, char *end, unsigned long *bitmap,
+char *bitmap_list_string(char *buf, char *end, const unsigned long *bitmap,
 			 struct printf_spec spec, const char *fmt)
 {
 	int nr_bits = max_t(int, spec.field_width, 0);
-- 
2.33.0

