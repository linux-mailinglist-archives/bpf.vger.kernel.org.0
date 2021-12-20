Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1D447A4AC
	for <lists+bpf@lfdr.de>; Mon, 20 Dec 2021 06:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbhLTFmA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Dec 2021 00:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbhLTFl7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Dec 2021 00:41:59 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A65C061574
        for <bpf@vger.kernel.org>; Sun, 19 Dec 2021 21:41:59 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id kc16so8429753qvb.3
        for <bpf@vger.kernel.org>; Sun, 19 Dec 2021 21:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZV5uObsvtrxLZxfTMll9Ebuk5DfmDGt+yb0wvC/T3iw=;
        b=Az2pd55FLEXj5tc/6VrnplnJDeAL8r7THnm77Uwg7GO7qiFxwq6/xTDJL3w3qV+jBb
         v8jFt2KrhLicMtLh8lIqxv2iTF/J1bymQ6XqDLpuljpUZXgRibxEJA302YS810ErXRQ0
         29D7GeDXSfP3w86XmPsONGH+fRjVHA05LNWPS549h0EqWjYw2tsJz9nl81wHzDyUKCfC
         FVarM/E9c0aPnAm1iHnTTxz0nzCXXR/fxO/UE9fgKjgDEN1BlACjmwop+sLwQUiZctmH
         6kFt+GmMN/BknPATo7pMdaFf6E570lIFqX8xN2k+oauzyLbqS3GfjV8427zoeOXWjr/U
         IrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZV5uObsvtrxLZxfTMll9Ebuk5DfmDGt+yb0wvC/T3iw=;
        b=0aDSInzSSXL+m7loSniuY+gpxernqa9dNPjhtyizkH4BroP/0stNk9yEbSKSooKG0x
         NXpDKwPHy0G+i7pldgG9B4iZjkrd2xG3P3sBeDOaesc190Jgjvd8CAslHllBvzrtbsZQ
         VIjonAH7cYN2aKFvp9dO+L875m8inTztQNhoRBM+6pSZFJ2Hn6AVtYLECmlHQ/ecQfdI
         +vrhb1GQWHLEzNTYNaaOa55KSwSnLUBOtwk/JT9z+sUJ35IP5snmOXN3rx/E3gJDRjFc
         XCgkYdzey+flakX5fGRpD1OKmRB4bK2MQMKvmqXBbQpqqW+H+B+ob/POeXTyBX4HQuqU
         RF4Q==
X-Gm-Message-State: AOAM531Fqehh3o8OzispQ3oC27B7tCjr5wkT8ygos0blmEHd+7RNhqMZ
        Q0B3s08ckMUcSXyV9DZk0XUqKEkvjl9arQ==
X-Google-Smtp-Source: ABdhPJzo2VH1Tsln/CyAXhSt4wnsNzX6bFVeNu4kwGsel1wkfvTFAtzwSHS4NhrW3i0gF9axs1+rrw==
X-Received: by 2002:a05:6214:d0c:: with SMTP id 12mr2671065qvh.104.1639978918212;
        Sun, 19 Dec 2021 21:41:58 -0800 (PST)
Received: from localhost.localdomain (cpe-104-162-105-43.nyc.res.rr.com. [104.162.105.43])
        by smtp.gmail.com with ESMTPSA id bq36sm10952060qkb.6.2021.12.19.21.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Dec 2021 21:41:57 -0800 (PST)
From:   grantseltzer <grantseltzer@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, grantseltzer@gmail.com
Subject: [PATCH bpf-next] libbpf: Add documentation for bpf_map batch operations
Date:   Mon, 20 Dec 2021 00:40:48 -0500
Message-Id: <20211220054048.54845-1-grantseltzer@gmail.com>
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

Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
---
 tools/lib/bpf/bpf.h | 93 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 00619f64a040..b1a2ac9ca9c7 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -254,20 +254,113 @@ struct bpf_map_batch_opts {
 };
 #define bpf_map_batch_opts__last_field flags
 
+
+/**
+ * @brief **bpf_map_delete_batch()** allows for batch deletion of multiple
+ * elements in a BPF map.
+ *
+ * The parameter *keys* points to a memory address large enough to hold
+ * *count* keys of elements in the map *fd*.
+ *
+ * @param fd BPF map file descriptor
+ * @param keys memory address large enough to hold *count* * *key_size*
+ * @param count number of elements in the map to sequentially delete
+ * @param opts options for configuring the way the batch deletion works
+ * @return  int error code, 0 if no error (errno is also set to error)
+ */
 LIBBPF_API int bpf_map_delete_batch(int fd, void *keys,
 				    __u32 *count,
 				    const struct bpf_map_batch_opts *opts);
+
+/**
+ * @brief **bpf_map_lookup_batch()** allows for iteration of BPF map elements.
+ *
+ * The parameter *in_batch* is the address of the first element in the batch to read.
+ * *out_batch* is an output parameter that should be passed as *in_batch* to subsequent
+ * calls to **bpf_map_lookup_batch()**. NULL can be passed for *in_batch* to set
+ * *out_batch* as the first element of the map.
+ *
+ * The *keys* and *values* are output parameters which must point to memory large enough to
+ * hold *count* items based on the key and value size of the map *map_fd*. The *keys*
+ * buffer must be of *key_size* * *count*. The *values* buffer must be of
+ * *value_size* * *count*.
+ *
+ * @param fd BPF map file descriptor
+ * @param in_batch address of the first element in batch to read, can pass NULL to
+ * get address of the first element in *out_batch*
+ * @param out_batch output parameter that should be passed to next call as *in_batch*
+ * @param keys memory address large enough to hold *count* * *key_size*
+ * @param values memory address large enough to hold *count* * *value_size*
+ * @param count number of elements in the map to read in batch
+ * @param opts options for configuring the way the batch lookup works
+ * @return int error code, 0 if no error (errno is also set to error)
+ */
 LIBBPF_API int bpf_map_lookup_batch(int fd, void *in_batch, void *out_batch,
 				    void *keys, void *values, __u32 *count,
 				    const struct bpf_map_batch_opts *opts);
+
+/**
+ * @brief **bpf_map_lookup_and_delete_batch()** allows for iteration of BPF map
+ * elements where each element is deleted after being retrieved.
+ *
+ * Note that *count* is an input and output parameter, where on output it
+ * represents how many elements were succesfully deleted. Also note that if
+ * **EFAULT** is returned up to *count* elements may have been deleted without
+ * being returned via the *keys* and *values* output parameters.
+ *
+ * @param fd BPF map file descriptor
+ * @param in_batch address of the first element in batch to read, can pass NULL to
+ * get address of the first element in *out_batch*
+ * @param out_batch output parameter that should be passed to next call as *in_batch*
+ * @param keys memory address large enough to hold *count* * *key_size*
+ * @param values memory address large enough to hold *count* * *value_size*
+ * @param count number of elements in the map to read and delete in batch
+ * @param opts options for configuring the way the batch lookup and delete works
+ * @return int error code, 0 if no error (errno is also set to error)
+ * See note on EFAULT.
+ */
 LIBBPF_API int bpf_map_lookup_and_delete_batch(int fd, void *in_batch,
 					void *out_batch, void *keys,
 					void *values, __u32 *count,
 					const struct bpf_map_batch_opts *opts);
+
+/**
+ * @brief **bpf_map_update_batch()** updates multiple elements in a map
+ * by specifiying keys and their corresponding values.
+ *
+ * The *keys* and *values* paremeters must point to memory large enough
+ * to hold *count* items based on the key and value size of the map.
+ *
+ * The *opts* parameter can be used to control how *bpf_map_update_batch()*
+ * should handle keys that either do or do not already exist in the map.
+ * In particular the *flags* field of *bpf_map_batch_opts* can be
+ * one of the following:
+ *
+ * **BPF_ANY**
+ * 	Create new elements or update a existing elements.
+ *
+ * **BPF_NOEXIST**
+ * 	Create new elements only if they do not exist.
+ *
+ * **BPF_EXIST**
+ * 	Update existing elements.
+ *
+ * **BPF_F_LOCK**
+ * 	Update spin_lock-ed map elements. This must be
+ * 	specified if the map value contains a spinlock.
+ *
+ * @param fd BPF map file descriptor
+ * @param keys memory address large enough to hold *count* * *key_size*
+ * @param values memory address large enough to hold *count* * *value_size*
+ * @param count number of elements in the map to update in batch
+ * @param opts options for configuring the way the batch update works
+ * @return int error code, 0 if no error (errno is also set to error)
+ */
 LIBBPF_API int bpf_map_update_batch(int fd, void *keys, void *values,
 				    __u32 *count,
 				    const struct bpf_map_batch_opts *opts);
 
+
 LIBBPF_API int bpf_obj_pin(int fd, const char *pathname);
 LIBBPF_API int bpf_obj_get(const char *pathname);
 
-- 
2.33.1

