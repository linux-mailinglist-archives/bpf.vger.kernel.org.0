Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E77A410336
	for <lists+bpf@lfdr.de>; Sat, 18 Sep 2021 05:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbhIRDSm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Sep 2021 23:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233891AbhIRDSh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Sep 2021 23:18:37 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4497AC061574
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 20:17:14 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id jo30so7715215qvb.3
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 20:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CeGbC4FZecMn2s1qsrFRrraJQdXHC7WoP+tsLRitofo=;
        b=kxyDB0ULl6VD8cyRG0N7ZfJhO7b0xO/++STMyXTM+baciOQj9GoBjBDYJuDPb6TUSq
         pzh4wTFnjR9GeEZhNA+x1gpBUxenf+obxXMo5piupShcjqRpFZeMioFPAQqk43RTUHPt
         h0ooq0oIuB3LspFfRuI3FIdRJ5nHwIcs3x4+8Sx+43mTi9OrEybGiG3bv7dP+02fET6x
         7W1gCktpf1u96g8ph+fxKrQ68S/R/6V7YTNCN2YOJzaIG2WRP0KMZvLBxQcdaSP3sEp3
         I9XiRdpf6X/Czn+mk5Y8PJtiLWFli9kN3+9WItkNZ3Od+gJ7n0OK1uvL/yNuaxR1gso3
         uAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CeGbC4FZecMn2s1qsrFRrraJQdXHC7WoP+tsLRitofo=;
        b=Gwu38evbkwhya6wHOrLhEMAg+dGL1+USbbQCJhIt52SBAEz5a/c2w1s61EAtc+TTgv
         ZkVMD1W6LKb0XZUoPqpOB1UuCsQsXgHC6XhKcRlIHlXlKSTpA3ZRs+Ac3/RchdI9xsQL
         6SZ+yMioa2gE1R33nhJIGE9tl2tQxUQp8JyVj+58FB9QaMn5NhC4Z2Hlv3XMknSIH7fC
         GnCYjqm2oyxszrUYWbbj/NSxJrP40iRBSHqdC8+rjCr7XH1KMN6qsEy9SX7ia53fbX33
         4eE6UuQA2eCiFlhdlbv15y63VBbajKYL0ujBqj6g5W/ccAH+yVNM6rsZPIQQ7s+6pEwm
         cEFw==
X-Gm-Message-State: AOAM532aBY97xDxFWWaul3cPMzUkND+G+5wZ+nzkxrPzlVDpYcBM8KEW
        Gok3heXQ4Oy2Z+U6XZyICkQ=
X-Google-Smtp-Source: ABdhPJzwCJPXs1mhLZtQ5FJaT4LL3inOIWfhvPM2LxLtJGYF2HKTQr+RfXvQ+yjb4SovrrwvWKyeug==
X-Received: by 2002:ad4:4765:: with SMTP id d5mr5298504qvx.51.1631935033343;
        Fri, 17 Sep 2021 20:17:13 -0700 (PDT)
Received: from localhost.localdomain (cpe-104-162-105-43.nyc.res.rr.com. [104.162.105.43])
        by smtp.gmail.com with ESMTPSA id i16sm5064874qtq.52.2021.09.17.20.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 20:17:13 -0700 (PDT)
From:   grantseltzer <grantseltzer@gmail.com>
To:     andrii@kernel.org
Cc:     bpf@vger.kernel.org, grantseltzer@gmail.com
Subject: [PATCH bpf-next v2] libbpf: Add doc comments in libbpf.h
Date:   Fri, 17 Sep 2021 23:14:58 -0400
Message-Id: <20210918031457.36204-1-grantseltzer@gmail.com>
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
 tools/lib/bpf/libbpf.h | 66 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 58 insertions(+), 8 deletions(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 2f6f0e15d1e7..7fbe71e6d855 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -478,9 +478,13 @@ struct bpf_map_def {
 	unsigned int map_flags;
 };
 
-/*
- * The 'struct bpf_map' in include/linux/bpf.h is internal to the kernel,
- * so no need to worry about a name clash.
+/**
+ * @brief **bpf_object__find_map_by_name()** returns BPF map of
+ * the given name, if it exists within the passed BPF object
+ * @param obj BPF object
+ * @param name name of the BPF map
+ * @return BPF map instance, if such map exists within the BPF object;
+ * or NULL otherwise.
  */
 LIBBPF_API struct bpf_map *
 bpf_object__find_map_by_name(const struct bpf_object *obj, const char *name);
@@ -506,7 +510,12 @@ bpf_map__next(const struct bpf_map *map, const struct bpf_object *obj);
 LIBBPF_API struct bpf_map *
 bpf_map__prev(const struct bpf_map *map, const struct bpf_object *obj);
 
-/* get/set map FD */
+/**
+ * @brief **bpf_map__fd()** gets the file descriptor of the passed
+ * BPF map
+ * @param map the BPF map instance
+ * @return the file descriptor; or -EINVAL in case of an error
+ */
 LIBBPF_API int bpf_map__fd(const struct bpf_map *map);
 LIBBPF_API int bpf_map__reuse_fd(struct bpf_map *map, int fd);
 /* get map definition */
@@ -547,6 +556,17 @@ LIBBPF_API int bpf_map__set_initial_value(struct bpf_map *map,
 					  const void *data, size_t size);
 LIBBPF_API const void *bpf_map__initial_value(struct bpf_map *map, size_t *psize);
 LIBBPF_API bool bpf_map__is_offload_neutral(const struct bpf_map *map);
+
+/**
+ * @brief **bpf_map__is_internal()** tells the caller whether or not
+ * the passed map is a special map created by libbpf
+ * automatically for things like global variables, __ksym externs,
+ * Kconfig values, etc
+ * @param map the bpf_map
+ * @return true if the map is an internal map; or false otherwise
+ *
+ * See the enum `libbpf_map_type` for listing of the types
+ */
 LIBBPF_API bool bpf_map__is_internal(const struct bpf_map *map);
 LIBBPF_API int bpf_map__set_pin_path(struct bpf_map *map, const char *path);
 LIBBPF_API const char *bpf_map__get_pin_path(const struct bpf_map *map);
@@ -558,6 +578,36 @@ LIBBPF_API int bpf_map__unpin(struct bpf_map *map, const char *path);
 LIBBPF_API int bpf_map__set_inner_map_fd(struct bpf_map *map, int fd);
 LIBBPF_API struct bpf_map *bpf_map__inner_map(struct bpf_map *map);
 
+/**
+ * @brief **libbpf_get_error()** extracts the error code from the passed
+ * pointer
+ * @param ptr pointer returned from libbpf API function
+ * @return error code; or 0 if no error occured
+ *
+ * Many libbpf API functions which return pointers have logic to encode error
+ * codes as pointers, and do not return NULL. Meaning **libbpf_get_error()**
+ * should be used on the return value from these functions immediately after
+ * calling the API function, with no intervening calls that could clobber the
+ * `errno` variable. Consult the individual functions documentation to verify
+ * if this logic applies should be used.
+ *
+ * For these API functions, if `libbpf_set_strict_mode(LIBBPF_STRICT_CLEAN_PTRS)`
+ * is enabled, NULL is returned on error instead.
+ *
+ * If ptr is NULL, then errno should be already set by the failing
+ * API, because libbpf never returns NULL on success and it now always
+ * sets errno on error.
+ *
+ * Example usage:
+ *
+ *  perfBuffer = perf_buffer__new(bpf_map__fd(obj->maps.events), PERF_BUFFER_PAGES, &opts);
+ *  err = libbpf_get_error(perfBuffer);
+ *  if (err) {
+ *	  perfBuffer = NULL;
+ *	  fprintf(stderr, "failed to open perf buffer: %d\n", err);
+ *    goto cleanup;
+ *  }
+ */
 LIBBPF_API long libbpf_get_error(const void *ptr);
 
 struct bpf_prog_load_attr {
@@ -822,9 +872,10 @@ bpf_program__bpil_addr_to_offs(struct bpf_prog_info_linear *info_linear);
 LIBBPF_API void
 bpf_program__bpil_offs_to_addr(struct bpf_prog_info_linear *info_linear);
 
-/*
- * A helper function to get the number of possible CPUs before looking up
- * per-CPU maps. Negative errno is returned on failure.
+/**
+ * @brief **libbpf_num_possible_cpus()** is a helper function to get the
+ * number of possible CPUs that the host kernel supports and expects.
+ * @return number of possible CPUs; or error code on failure
  *
  * Example usage:
  *
@@ -834,7 +885,6 @@ bpf_program__bpil_offs_to_addr(struct bpf_prog_info_linear *info_linear);
  *     }
  *     long values[ncpus];
  *     bpf_map_lookup_elem(per_cpu_map_fd, key, values);
- *
  */
 LIBBPF_API int libbpf_num_possible_cpus(void);
 
-- 
2.31.1

