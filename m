Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA936559EA
	for <lists+bpf@lfdr.de>; Sat, 24 Dec 2022 12:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiLXLVM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 24 Dec 2022 06:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiLXLVL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 24 Dec 2022 06:21:11 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69490208;
        Sat, 24 Dec 2022 03:21:10 -0800 (PST)
Received: from dggpeml500010.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NfM2l6RV7zJpMx;
        Sat, 24 Dec 2022 19:17:19 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500010.china.huawei.com
 (7.185.36.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 24 Dec
 2022 19:21:07 +0800
From:   Xin Liu <liuxin350@huawei.com>
To:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <haoluo@google.com>, <jolsa@kernel.org>
CC:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yanan@huawei.com>, <wuchangye@huawei.com>,
        <xiesongyang@huawei.com>, <kongweibin2@huawei.com>,
        <liuxin350@huawei.com>, <zhangmingyi5@huawei.com>
Subject: [PATCH] libbpf: Added the description of some API functions
Date:   Sat, 24 Dec 2022 19:20:58 +0800
Message-ID: <20221224112058.12038-1-liuxin350@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500010.china.huawei.com (7.185.36.155)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, many API functions are not described in the document.
I have tried to add the API description of the following four API
functions:
 libbpf_set_print
 bpf_object__open
 bpf_object__load
 bpf_object__close

Signed-off-by: Xin Liu <liuxin350@huawei.com>
---
 tools/lib/bpf/libbpf.h | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index eee883f007f9..bf3af52d42be 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -96,6 +96,12 @@ enum libbpf_print_level {
 typedef int (*libbpf_print_fn_t)(enum libbpf_print_level level,
 				 const char *, va_list ap);
 
+/**
+ * @brief **libbpf_set_print()** use the user-provided log print function.
+ * @param fn the log print function. Disable all print if the parameter
+ * is NULL.
+ * @return Pointer to old print function.
+ */
 LIBBPF_API libbpf_print_fn_t libbpf_set_print(libbpf_print_fn_t fn);
 
 /* Hide internal to user */
@@ -174,6 +180,14 @@ struct bpf_object_open_opts {
 };
 #define bpf_object_open_opts__last_field kernel_log_level
 
+/**
+ * @brief **bpf_object__open()** creates a bpf_object by opening
+ * the BPF ELF object file pointed to by the passed path and loading it
+ * into memory.
+ * @param path BPF object file path.
+ * @return pointer to the new bpf_object; or NULL is returned on error,
+ * error code is stored in errno
+ */
 LIBBPF_API struct bpf_object *bpf_object__open(const char *path);
 
 /**
@@ -204,9 +218,20 @@ bpf_object__open_mem(const void *obj_buf, size_t obj_buf_sz,
 		     const struct bpf_object_open_opts *opts);
 
 /* Load/unload object into/from kernel */
+/**
+ * @brief **bpf_object__load()** load bpf_object into kernel
+ * @param obj pointer to a valid bpf_object
+ * @return 0, on success; negative error code, otherwise, error code is
+ * stored in errno
+ */
 LIBBPF_API int bpf_object__load(struct bpf_object *obj);
 
-LIBBPF_API void bpf_object__close(struct bpf_object *object);
+/**
+ * @brief **bpf_object__close()** close a bpf_object and release all
+ * resources.
+ * @param obj pointer to a valid bpf_object
+ */
+LIBBPF_API void bpf_object__close(struct bpf_object *obj);
 
 /* pin_maps and unpin_maps can both be called with a NULL path, in which case
  * they will use the pin_path attribute of each map (and ignore all maps that
-- 
2.33.0

