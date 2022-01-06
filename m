Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC8FC486AED
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 21:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243607AbiAFUNZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 15:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243604AbiAFUNY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Jan 2022 15:13:24 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58C2C061245
        for <bpf@vger.kernel.org>; Thu,  6 Jan 2022 12:13:23 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id f17so927958qtf.8
        for <bpf@vger.kernel.org>; Thu, 06 Jan 2022 12:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2hWFH/PhBgptdaVzEzBtWF8TQy3zG02gv3L2bvRoVek=;
        b=DHuAD62xxlK8lJgxxDc4RmXShKuA6rkWxSydJ+eQjjg+rU7ifI5tCAqxx6duEb16Ej
         T8PtmMApXP0qPH8ClqBbb44HCSlwW301W1u88NPrMQjmW6TOsfByEozX1H0MK3A842BV
         oNN18iLzLA4qnPDL420Cdl2HEhnJrjYfTEPzw03Tu+Vt1oN2NlxHYDHVl417YEhLevti
         tviX4Ju5g5y4OGV/wAaWB7lm+bgPuCbaLE7pLsWiTFUEU7rABtEXJC0DhUbaWu3QyOaS
         etYuCFxWHDL/XQ/HFRx3cyM+VV95mNs21gbvOn0Bn/AreemBQ6DP4gaH6umh+rEUuuII
         VAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2hWFH/PhBgptdaVzEzBtWF8TQy3zG02gv3L2bvRoVek=;
        b=iCEuC6KY5Gtdl1jijM4oCwFu53fVARKYUFg8ij2Ge81ZoRVTbgSAokt5cBWUIxH8XR
         JzgbImJmH44WWRx0SAHB3R4bI3/jBE3vu811OKTZkBhNQ19O8IK8sH66MWKfjONtrawJ
         H+JCFbv4O1IF7yBVKFYyFafQv9EJEj8TK33OPRkwyn5+kxMXgIkeK2A89uaXyVqvcLAx
         /kt2q+HabzHiWvHPdspa/WAcpu7FJ0BniEQ/EP/v3oDYlVm1S+rzl+/7/aqA7xcEBY61
         heFnjX+XB8UN3XBnji9ebppttM5GogbyvLZp3Hf3wfrL6JBmTVIhwls+Aj4DNXLBhqFh
         u8Ew==
X-Gm-Message-State: AOAM532ojwzqe56Jaa2wbHVlDK7sthCVP2aDramtRsMZOQM9zqWSNHb4
        grNb3bK0uDKY/OEYHT3K7+XWe84mv4c=
X-Google-Smtp-Source: ABdhPJwuojNqtE5ws3OGWl8OuIoYa7xsYFlCbaFEPPyoKtwHH8nVNWf2+YGLO2PwLhl7tPmugZJ0/w==
X-Received: by 2002:ac8:5b01:: with SMTP id m1mr52609073qtw.313.1641500002614;
        Thu, 06 Jan 2022 12:13:22 -0800 (PST)
Received: from localhost.localdomain (cpe-104-162-105-43.nyc.res.rr.com. [104.162.105.43])
        by smtp.gmail.com with ESMTPSA id d11sm2016323qtj.4.2022.01.06.12.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 12:13:22 -0800 (PST)
From:   grantseltzer <grantseltzer@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, grantseltzer@gmail.com
Subject: [PATCH bpf-next v3] libbpf: Add documentation for bpf_map batch operations
Date:   Thu,  6 Jan 2022 15:13:05 -0500
Message-Id: <20220106201304.112675-1-grantseltzer@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Grant Seltzer <grantseltzer@gmail.com>

This adds documention for:

- bpf_map_delete_batch()
- bpf_map_lookup_batch()
- bpf_map_lookup_and_delete_batch()
- bpf_map_update_batch()

This also updates the public API for the `keys` parameter
of `bpf_map_delete_batch()`, and both the
`keys` and `values` parameters of `bpf_map_update_batch()`
to be constants.

Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
---
 tools/lib/bpf/bpf.c |   8 +--
 tools/lib/bpf/bpf.h | 116 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 118 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 9b64eed2b003..550b4cbb6c99 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -691,11 +691,11 @@ static int bpf_map_batch_common(int cmd, int fd, void  *in_batch,
 	return libbpf_err_errno(ret);
 }
 
-int bpf_map_delete_batch(int fd, void *keys, __u32 *count,
+int bpf_map_delete_batch(int fd, const void *keys, __u32 *count,
 			 const struct bpf_map_batch_opts *opts)
 {
 	return bpf_map_batch_common(BPF_MAP_DELETE_BATCH, fd, NULL,
-				    NULL, keys, NULL, count, opts);
+				    NULL, (void *)keys, NULL, count, opts);
 }
 
 int bpf_map_lookup_batch(int fd, void *in_batch, void *out_batch, void *keys,
@@ -715,11 +715,11 @@ int bpf_map_lookup_and_delete_batch(int fd, void *in_batch, void *out_batch,
 				    count, opts);
 }
 
-int bpf_map_update_batch(int fd, void *keys, void *values, __u32 *count,
+int bpf_map_update_batch(int fd, const void *keys, const void *values, __u32 *count,
 			 const struct bpf_map_batch_opts *opts)
 {
 	return bpf_map_batch_common(BPF_MAP_UPDATE_BATCH, fd, NULL, NULL,
-				    keys, values, count, opts);
+				    (void *)keys, (void *)values, count, opts);
 }
 
 int bpf_obj_pin(int fd, const char *pathname)
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 00619f64a040..68f1da7e89c6 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -254,20 +254,132 @@ struct bpf_map_batch_opts {
 };
 #define bpf_map_batch_opts__last_field flags
 
-LIBBPF_API int bpf_map_delete_batch(int fd, void *keys,
+
+/**
+ * @brief **bpf_map_delete_batch()** allows for batch deletion of multiple
+ * elements in a BPF map.
+ *
+ * @param fd BPF map file descriptor
+ * @param keys pointer to an array of *count* keys
+ * @param count input and output parameter; on input **count** represents the
+ * number of  elements in the map to delete in batch;
+ * on output if a non-EFAULT error is returned, **count** represents the number of deleted
+ * elements if the output **count** value is not equal to the input **count** value
+ * If EFAULT is returned, **count** should not be trusted to be correct.
+ * @param opts options for configuring the way the batch deletion works
+ * @return 0, on success; negative error code, otherwise (errno is also set to
+ * the error code)
+ */
+LIBBPF_API int bpf_map_delete_batch(int fd, const void *keys,
 				    __u32 *count,
 				    const struct bpf_map_batch_opts *opts);
+
+/**
+ * @brief **bpf_map_lookup_batch()** allows for batch lookup of BPF map elements.
+ *
+ * The parameter *in_batch* is the address of the first element in the batch to read.
+ * *out_batch* is an output parameter that should be passed as *in_batch* to subsequent
+ * calls to **bpf_map_lookup_batch()**. NULL can be passed for *in_batch* to indicate
+ * that the batched lookup starts from the beginning of the map.
+ *
+ * The *keys* and *values* are output parameters which must point to memory large enough to
+ * hold *count* items based on the key and value size of the map *map_fd*. The *keys*
+ * buffer must be of *key_size* * *count*. The *values* buffer must be of
+ * *value_size* * *count*.
+ *
+ * @param fd BPF map file descriptor
+ * @param in_batch address of the first element in batch to read, can pass NULL to
+ * indicate that the batched lookup starts from the beginning of the map.
+ * @param out_batch output parameter that should be passed to next call as *in_batch*
+ * @param keys pointer to an array large enough for *count* keys
+ * @param values pointer to an array large enough for *count* values
+ * @param count input and output parameter; on input it's the number of elements
+ * in the map to read in batch; on output it's the number of elements that were
+ * successfully read.
+ * If a non-EFAULT error is returned, count will be set as the number of elements
+ * that were read before the error occurred.
+ * If EFAULT is returned, **count** should not be trusted to be correct.
+ * @param opts options for configuring the way the batch lookup works
+ * @return 0, on success; negative error code, otherwise (errno is also set to
+ * the error code)
+ */
 LIBBPF_API int bpf_map_lookup_batch(int fd, void *in_batch, void *out_batch,
 				    void *keys, void *values, __u32 *count,
 				    const struct bpf_map_batch_opts *opts);
+
+/**
+ * @brief **bpf_map_lookup_and_delete_batch()** allows for batch lookup and deletion
+ * of BPF map elements where each element is deleted after being retrieved.
+ *
+ * @param fd BPF map file descriptor
+ * @param in_batch address of the first element in batch to read, can pass NULL to
+ * get address of the first element in *out_batch*
+ * @param out_batch output parameter that should be passed to next call as *in_batch*
+ * @param keys pointer to an array of *count* keys
+ * @param values pointer to an array large enough for *count* values
+ * @param count input and output parameter; on input it's the number of elements
+ * in the map to read and delete in batch; on output it represents the number of
+ * elements that were successfully read and deleted
+ * If a non-**EFAULT** error code is returned and if the output **count** value
+ * is not equal to the input **count** value, up to **count** elements may
+ * have been deleted.
+ * if **EFAULT** is returned up to *count* elements may have been deleted without
+ * being returned via the *keys* and *values* output parameters.
+ * @param opts options for configuring the way the batch lookup and delete works
+ * @return 0, on success; negative error code, otherwise (errno is also set to
+ * the error code)
+ */
 LIBBPF_API int bpf_map_lookup_and_delete_batch(int fd, void *in_batch,
 					void *out_batch, void *keys,
 					void *values, __u32 *count,
 					const struct bpf_map_batch_opts *opts);
-LIBBPF_API int bpf_map_update_batch(int fd, void *keys, void *values,
+
+/**
+ * @brief **bpf_map_update_batch()** updates multiple elements in a map
+ * by specifying keys and their corresponding values.
+ *
+ * The *keys* and *values* parameters must point to memory large enough
+ * to hold *count* items based on the key and value size of the map.
+ *
+ * The *opts* parameter can be used to control how *bpf_map_update_batch()*
+ * should handle keys that either do or do not already exist in the map.
+ * In particular the *flags* parameter of *bpf_map_batch_opts* can be
+ * one of the following:
+ *
+ * Note that *count* is an input and output parameter, where on output it
+ * represents how many elements were successfully updated. Also note that if
+ * **EFAULT** then *count* should not be trusted to be correct.
+ *
+ * **BPF_ANY**
+ *    Create new elements or update existing.
+ *
+ * **BPF_NOEXIST**
+ *    Create new elements only if they do not exist.
+ *
+ * **BPF_EXIST**
+ *    Update existing elements.
+ *
+ * **BPF_F_LOCK**
+ *    Update spin_lock-ed map elements. This must be
+ *    specified if the map value contains a spinlock.
+ *
+ * @param fd BPF map file descriptor
+ * @param keys pointer to an array of *count* keys
+ * @param values pointer to an array of *count* values
+ * @param count input and output parameter; on input it's the number of elements
+ * in the map to update in batch; on output if a non-EFAULT error is returned,
+ * **count** represents the number of updated elements if the output **count**
+ * value is not equal to the input **count** value.
+ * If EFAULT is returned, **count** should not be trusted to be correct.
+ * @param opts options for configuring the way the batch update works
+ * @return 0, on success; negative error code, otherwise (errno is also set to
+ * the error code)
+ */
+LIBBPF_API int bpf_map_update_batch(int fd, const void *keys, const void *values,
 				    __u32 *count,
 				    const struct bpf_map_batch_opts *opts);
 
+
 LIBBPF_API int bpf_obj_pin(int fd, const char *pathname);
 LIBBPF_API int bpf_obj_get(const char *pathname);
 
-- 
2.33.1

