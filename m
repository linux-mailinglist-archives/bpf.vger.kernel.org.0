Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4CA40FC34
	for <lists+bpf@lfdr.de>; Fri, 17 Sep 2021 17:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbhIQP1H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Sep 2021 11:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbhIQP1H (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Sep 2021 11:27:07 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E9EC061574
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 08:25:45 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id a66so18569003qkc.1
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 08:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jVUEelYalD49PkvgEAlzZ2QOJXUR+TuEpNoG41P85Mc=;
        b=c3SaSyVViZXKmAb4AHxishOpHHKiN85iFoiUPkUmCcaV7c0CP762eRNonwrPoAK57N
         9eYphDo1M8CiOGAvx2XfQbniCdKVpDrM9OZfLdDnH+WBrH1cK274FRWWiYimlwaNXU+p
         XUUcbvytlBhmfnD3cM27CfFImaqDP6imsWXW+K9UwGIOghhvxcoRvyM2WOtTfYudyp0D
         zfDNi1yLyep2LCmB82F1sBRHiivy4D8rHUKCQbWjHesf0wjJ8XyWzIqrJ3G7Xzr8WaqM
         15cTzZieqRvqxEAzDF0B+hg8z8PdcpXPUhTxcbtu64G9GQzDDmg/VMWj1ZkOuihQHuP/
         SAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jVUEelYalD49PkvgEAlzZ2QOJXUR+TuEpNoG41P85Mc=;
        b=5r0Cn5YwLNwPbq3DhYf9rb2c5M56baLfBcG0Ij8YV1ZK0KRVjDkQAqYtNZ2eeRHWSE
         xWXrQ1SgJV3PIPLgxwSvsXNKI4nd8/+t+Ss2UHsh4pjUfxGP0lsj8FTq9bn00vlMDw+t
         Wzs2Nj14ZyqG6Aot6/dOdkQhVI53ek5mDcJgkXX04NgkjKYr9U+S8AylpTUdpoWvcZMf
         Kxy4ipfBvqfHm2EflreZfmY4xQ111Rs53xoWGbDonr/2GyVnyODTogOgMQ5U10YTSzYU
         8T7QKssWNHyYhkFubM9ITmmP1xpkerVe1aOR2iOKg457LL9b3H6vCdLR+lOlMEllUoSh
         xgbA==
X-Gm-Message-State: AOAM531IoU31VJBlLQ1PGMNhNfwF6TzOtd6VFjgfKkY0tZmbT5V87OhU
        rdCg52vfwBkr7e+abg6G5uA=
X-Google-Smtp-Source: ABdhPJwIwJI1FNjOZbjT6mpSgrEKGxab6a8CpyFdBTPx01KHf/2RUFp2RDIpagrN24PD8ybnWW/rSw==
X-Received: by 2002:a05:620a:2e4:: with SMTP id a4mr10911572qko.288.1631892344115;
        Fri, 17 Sep 2021 08:25:44 -0700 (PDT)
Received: from localhost.localdomain (cpe-104-162-105-43.nyc.res.rr.com. [104.162.105.43])
        by smtp.gmail.com with ESMTPSA id r140sm4974757qke.15.2021.09.17.08.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 08:25:43 -0700 (PDT)
From:   grantseltzer <grantseltzer@gmail.com>
To:     andrii@kernel.org
Cc:     bpf@vger.kernel.org, grantseltzer@gmail.com
Subject: [PATCH bpf-next] libbpf: Add doc comments in libb.h
Date:   Fri, 17 Sep 2021 11:23:01 -0400
Message-Id: <20210917152300.13978-1-grantseltzer@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Grant Seltzer <grantseltzer@gmail.com>

This adds comments above functions in libbpf.h which document
their uses. These comments are of a format that doxygen and sphinx
can pick up and render. These are rendered by libbpf.readthedocs.org

These doc comments are for:
- bpf_object__find_map_by_name()
- bpf_map__fd()
- bpf_map__is_internal()
- libbpf_get_error()
- libbpf_num_possible_cpus()

Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
---
 tools/lib/bpf/libbpf.h | 58 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 50 insertions(+), 8 deletions(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 2f6f0e15d1e7..27a5ebf56d19 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -478,9 +478,14 @@ struct bpf_map_def {
 	unsigned int map_flags;
 };
 
-/*
- * The 'struct bpf_map' in include/linux/bpf.h is internal to the kernel,
- * so no need to worry about a name clash.
+/**
+ * @brief **bpf_object__find_map_by_name()** returns a pointer to the
+ * specified bpf map in the bpf object if that map exists, and returns
+ * NULL if not. It sets errno in case of error.
+ * @param obj bpf object
+ * @param name name of the bpf map
+ * @return the address of the map within the bpf object, or NULL if it
+ * does not exist
  */
 LIBBPF_API struct bpf_map *
 bpf_object__find_map_by_name(const struct bpf_object *obj, const char *name);
@@ -506,7 +511,15 @@ bpf_map__next(const struct bpf_map *map, const struct bpf_object *obj);
 LIBBPF_API struct bpf_map *
 bpf_map__prev(const struct bpf_map *map, const struct bpf_object *obj);
 
-/* get/set map FD */
+/**
+ * @brief **bpf_map__fd()** gets the file descriptor of the passed
+ * bpf map
+ * @param map the bpf map instance
+ * @return the file descriptor or in case of an error, EINVAL
+ *
+ * errno should be checked after this call, it will be EINVAL in
+ * case of error.
+ */
 LIBBPF_API int bpf_map__fd(const struct bpf_map *map);
 LIBBPF_API int bpf_map__reuse_fd(struct bpf_map *map, int fd);
 /* get map definition */
@@ -547,6 +560,15 @@ LIBBPF_API int bpf_map__set_initial_value(struct bpf_map *map,
 					  const void *data, size_t size);
 LIBBPF_API const void *bpf_map__initial_value(struct bpf_map *map, size_t *psize);
 LIBBPF_API bool bpf_map__is_offload_neutral(const struct bpf_map *map);
+
+/**
+ * @brief **bpf_map__is_internal()** tells the caller whether or not
+ * the passed map is a special internal map
+ * @param map reference to the bpf_map
+ * @return true if the map is an internal map, false if not
+ *
+ * See the enum `libbpf_map_type` for listing of the types
+ */
 LIBBPF_API bool bpf_map__is_internal(const struct bpf_map *map);
 LIBBPF_API int bpf_map__set_pin_path(struct bpf_map *map, const char *path);
 LIBBPF_API const char *bpf_map__get_pin_path(const struct bpf_map *map);
@@ -558,6 +580,24 @@ LIBBPF_API int bpf_map__unpin(struct bpf_map *map, const char *path);
 LIBBPF_API int bpf_map__set_inner_map_fd(struct bpf_map *map, int fd);
 LIBBPF_API struct bpf_map *bpf_map__inner_map(struct bpf_map *map);
 
+/**
+ * @brief **libbpf_get_error()** extracts the error code from the passed
+ * pointer
+ * @param ptr pointer returned from libbpf API function
+ * @return error code
+ *
+ * Many libbpf API functions which return pointers have logic to encode error
+ * codes as pointers, and do not return NULL. Meaning **libbpf_get_error()**
+ * should be used on the return value from these functions. Consult the
+ * individual functions documentation to verify if this logic applies.
+ *
+ * For these API functions, if `libbpf_set_strict_mode(LIBBPF_STRICT_CLEAN_PTRS)`
+ * is enabled, NULL is returned on error instead.
+ *
+ * If ptr == NULL, then errno should be already set by the failing
+ * API, because libbpf never returns NULL on success and it now always
+ * sets errno on error.
+ */
 LIBBPF_API long libbpf_get_error(const void *ptr);
 
 struct bpf_prog_load_attr {
@@ -822,9 +862,12 @@ bpf_program__bpil_addr_to_offs(struct bpf_prog_info_linear *info_linear);
 LIBBPF_API void
 bpf_program__bpil_offs_to_addr(struct bpf_prog_info_linear *info_linear);
 
-/*
- * A helper function to get the number of possible CPUs before looking up
- * per-CPU maps. Negative errno is returned on failure.
+/**
+ * @brief **libbpf_num_possible_cpus()** is helper function to get the
+ * number of possible CPUs before looking up per-CPU maps.
+ * @return number of possible CPUs
+ *
+ * Negative errno is returned on failure.
  *
  * Example usage:
  *
@@ -834,7 +877,6 @@ bpf_program__bpil_offs_to_addr(struct bpf_prog_info_linear *info_linear);
  *     }
  *     long values[ncpus];
  *     bpf_map_lookup_elem(per_cpu_map_fd, key, values);
- *
  */
 LIBBPF_API int libbpf_num_possible_cpus(void);
 
-- 
2.31.1

