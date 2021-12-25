Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A62447F468
	for <lists+bpf@lfdr.de>; Sat, 25 Dec 2021 21:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbhLYUhd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Dec 2021 15:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbhLYUhd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Dec 2021 15:37:33 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E69EC061401
        for <bpf@vger.kernel.org>; Sat, 25 Dec 2021 12:37:33 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id 69so11046360qkd.6
        for <bpf@vger.kernel.org>; Sat, 25 Dec 2021 12:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gd1UaFBLKXl6bUXZarqaIRFNmK+UFVtqrXncrUElU50=;
        b=FTJgB0V5S9s3NcNDX1JMK7Gx3G6R72zDa2XaVSP2JAmkX0ioq1n+KrpW2SwB2hYTVb
         Kh0mGFvSmAMMWYMsqpvwGzPXXW0+mgA3WHyVGzcBD+nRewxQjFKoMVi9+snowBpCaivw
         BsM5ws/vSHt5SHiwx+1QJWe7hErrvv4C27R8WfAqqt+qPJLDfrxelC7ck3QBTFRWLtIL
         czlkKsIk3+bR/OkLUi7JS+C6z7xvslsENaRRyhO97ZrUCy0tY+B+ohKLaczEZkCrGRn/
         lAKn7T3X7G8O5xngAu31Q0kUbO82B6vzw4fNrT/TZWuVwZ+Tm0NK1JytqbC3JTNjop3s
         H4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gd1UaFBLKXl6bUXZarqaIRFNmK+UFVtqrXncrUElU50=;
        b=MeV3rxiukq1rkwFBuDTD/iKBXK5v1LbGpf6SiOn0P+SvOHM0lPidgIWHJGLNkh0YUq
         6qnQu6lpt9Ex0mfgcbrrh++WNI8NgqVvZeajN8zZ09IWzqccfyQF9bPM/wVpTwrcItrG
         rlNG8jxAEafFt7fvxbnmAac/DJtPb5nQSdpjilCo5UCzMKuJOmiN6X+D8tJ6MAqaeV2u
         bbBbnSAEqDBNt8UcA9VBjBjpzEgKP4YaRQMk3TvSQuxCpVReaxMqc/06vhvEiCa3yMzF
         RHF+OWtCHpbaSVm57Cy41k5KXfZh03NCVWPfq57UuQJNEhulAbksWghmbYzj9yiqthDu
         1f3g==
X-Gm-Message-State: AOAM530ykgRJ6coHa4ggl7Tp8GUWdNeCDsQsoZd2o4m2zxHhLnsHxOxh
        Wz23b8SwlF2fsr5pr3M+UhFt7t+lJ5XMow==
X-Google-Smtp-Source: ABdhPJw8gl1GpCdq5n0EbOCBJ7iqa3EnwrPQYCtyEiz1s3j4Z8y5cEGygXpjgWwlrhMU+VyhXpX6EA==
X-Received: by 2002:a05:620a:294b:: with SMTP id n11mr7936151qkp.606.1640464652074;
        Sat, 25 Dec 2021 12:37:32 -0800 (PST)
Received: from localhost.localdomain ([4.31.27.193])
        by smtp.gmail.com with ESMTPSA id 137sm8118117qkm.69.2021.12.25.12.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Dec 2021 12:37:31 -0800 (PST)
From:   grantseltzer <grantseltzer@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, grantseltzer@gmail.com
Subject: [PATCH bpf-next v2] libbpf: Add documentation for bpf_map batch operations
Date:   Sat, 25 Dec 2021 15:37:17 -0500
Message-Id: <20211225203717.35718-1-grantseltzer@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Grant Seltzer <grantseltzer@gmail.com>

This adds documentation for:

- bpf_map_delete_batch()
- bpf_map_lookup_batch()
- bpf_map_lookup_and_delete_batch()
- bpf_map_update_batch()

Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
---
 tools/lib/bpf/bpf.c |   4 +-
 tools/lib/bpf/bpf.h | 112 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 112 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 9b64eed2b003..25f3d6f85fe5 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -691,7 +691,7 @@ static int bpf_map_batch_common(int cmd, int fd, void  *in_batch,
 	return libbpf_err_errno(ret);
 }
 
-int bpf_map_delete_batch(int fd, void *keys, __u32 *count,
+int bpf_map_delete_batch(int fd, const void *keys, __u32 *count,
 			 const struct bpf_map_batch_opts *opts)
 {
 	return bpf_map_batch_common(BPF_MAP_DELETE_BATCH, fd, NULL,
@@ -715,7 +715,7 @@ int bpf_map_lookup_and_delete_batch(int fd, void *in_batch, void *out_batch,
 				    count, opts);
 }
 
-int bpf_map_update_batch(int fd, void *keys, void *values, __u32 *count,
+int bpf_map_update_batch(int fd, const void *keys, const void *values, __u32 *count,
 			 const struct bpf_map_batch_opts *opts)
 {
 	return bpf_map_batch_common(BPF_MAP_UPDATE_BATCH, fd, NULL, NULL,
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 00619f64a040..01011747f127 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -254,20 +254,128 @@ struct bpf_map_batch_opts {
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
+ * @param count number of elements in the map to sequentially delete
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
+ * @param count number of elements in the map to read in batch. If ENOENT is
+ * returned, count will be set as the number of elements that were read before
+ * running out of entries in the map
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
+ * Note that *count* is an input and output parameter, where on output it
+ * represents how many elements were successfully deleted. Also note that if
+ * **EFAULT** is returned up to *count* elements may have been deleted without
+ * being returned via the *keys* and *values* output parameters. If **ENOENT**
+ * is returned then *count* will be set to the number of elements that were read
+ * before running out of entries in the map.
+ *
+ * @param fd BPF map file descriptor
+ * @param in_batch address of the first element in batch to read, can pass NULL to
+ * get address of the first element in *out_batch*
+ * @param out_batch output parameter that should be passed to next call as *in_batch*
+ * @param keys pointer to an array of *count* keys
+ * @param values pointer to an array large enough for *count* values
+ * @param count input and output parameter; on input it's the number of elements
+ * in the map to read and delete in batch; on output it represents number of elements
+ * that were successfully read and deleted
+ * If ENOENT is returned, count will be set as the number of elements that were
+ * read before running out of entries in the map
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
+ *     Create new elements or update existing.
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
+ * in the map to update in batch; on output it represents the number of elements
+ * that were successfully updated. If EFAULT is returned, *count* should not
+ * be trusted to be correct.
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

