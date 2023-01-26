Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C0D67C2E6
	for <lists+bpf@lfdr.de>; Thu, 26 Jan 2023 03:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjAZCmq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 21:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjAZCmq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 21:42:46 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759792134
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 18:42:44 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id j9so368487qtv.4
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 18:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dbuoknow8HTNVd9RBR1rLRTOwqfwbZz6GsXXmzuuBuc=;
        b=qaYQDjmORR2SoXZjMYgM5o6jWVMRwEc48I6ZHldP0DJTDpVmCRtGQoBlgJgGmkgjQY
         vlKZd94BHxlqx0VqFN91YQNkMeJDLRio5vEunazMYH3T2bh/qaKaveGsdpAPFLZFTWGI
         /0qGBwgwuh1r1XX5I0V4z3+aTIqiS512eZjuRWhTHr6PwvRxGuw6huj3SFgx6YkI86j7
         HEV69R19i/39qrBdpHSn5LlgEYvOtcADH/cdH/RRul8MzLtTlWOqlYQjQUtMRhEV/igZ
         hsTQJwm/pCSG/xZLbxUTV34mmTjt1vmY5AEyYohLgYtTi/nYA5C7wGen+PHuIl6HCfyb
         O2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dbuoknow8HTNVd9RBR1rLRTOwqfwbZz6GsXXmzuuBuc=;
        b=3ZqNgDr44BK80zMdsaJD9yHs/3WnXp3M5/rv4/9MNABp2O9mCe/F0hOYXls/btds5s
         l2YBYH0WXGWgx79CRpXubR/6gL0nUyV5F1o0Otn4vqxVAsnV9ytNUgJUWxnEfrES+/Cu
         kxryVMQoaBJpECSYERzI38VUIHe5v/Tlf26WZU1Zjp9HkQsiL52590S2MKjnRDhWQbTM
         kkVEBzmMRi0z2xg78xhvqBhatzffKGsKKIRC8gmRC/Pxq1G2ozkaXR3MMVTZxvGtr3q1
         SB5XYpVX6R2Jg9Hi944wH38cf86TFPVmBSEEdCr0DywSPjDif7lkm6E3ULBvtf8k8WAC
         3rZA==
X-Gm-Message-State: AO0yUKUV6AlA7GKUtLpmJe0ueEfuIDD+nLgYbMcYblos6pLuTPevijgT
        ET4dgnL8Hcon7FuWtbVdgqh7wUbka6Cv0w==
X-Google-Smtp-Source: AK7set8ZiioyhjUyY1DgKm9/tGyoOjcR9q8hsne+mO4ycbH267zvjdk1z+TdRA/uKMpJ2SSMh7phpw==
X-Received: by 2002:a05:622a:591:b0:3b7:fe1c:d3a1 with SMTP id c17-20020a05622a059100b003b7fe1cd3a1mr1870610qtb.3.1674700963369;
        Wed, 25 Jan 2023 18:42:43 -0800 (PST)
Received: from grant-fedora.localdomain (cpe-104-162-105-43.nyc.res.rr.com. [104.162.105.43])
        by smtp.gmail.com with ESMTPSA id x7-20020ac81207000000b003995f6513b9sm4382533qti.95.2023.01.25.18.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 18:42:43 -0800 (PST)
From:   Grant Seltzer <grantseltzer@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, grantseltzer@gmail.com
Subject: [PATCH bpf-next] Add documentation to map pinning API functions
Date:   Wed, 25 Jan 2023 21:42:25 -0500
Message-Id: <20230126024225.520685-1-grantseltzer@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This adds documentation for the following API functions:
- bpf_map__set_pin_path()
- bpf_map__pin_path()
- bpf_map__is_pinned()
- bpf_map__pin()
- bpf_map__unpin()
- bpf_object__pin_maps()
- bpf_object__unpin_maps()

Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
---
 tools/lib/bpf/libbpf.h | 72 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 69 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 898db26e42e9..28138579f162 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -233,11 +233,30 @@ LIBBPF_API int bpf_object__load(struct bpf_object *obj);
  */
 LIBBPF_API void bpf_object__close(struct bpf_object *obj);
 
-/* pin_maps and unpin_maps can both be called with a NULL path, in which case
- * they will use the pin_path attribute of each map (and ignore all maps that
- * don't have a pin_path set).
+/**
+ * @brief **bpf_object__pin_maps()** pins each map contained within
+ * the BPF object at the passed directory.
+ * @param obj Pointer to a valid BPF object
+ * @param path A directory where maps should be pinned.
+ * @return 0, on success; negative error code, otherwise
+ *
+ * If `path` is NULL `bpf_map__pin` (which is being used on each map)
+ * will use the pin_path attribute of each map. In this case, maps that
+ * don't have a pin_path set will be ignored.
  */
 LIBBPF_API int bpf_object__pin_maps(struct bpf_object *obj, const char *path);
+
+/**
+ * @brief **bpf_object__unpin_maps()** unpins each map contained within
+ * the BPF object found in the passed directory.
+ * @param obj Pointer to a valid BPF object
+ * @param path A directory where pinned maps should be searched for.
+ * @return 0, on success; negative error code, otherwise
+ *
+ * If `path` is NULL `bpf_map__unpin` (which is being used on each map)
+ * will use the pin_path attribute of each map. In this case, maps that
+ * don't have a pin_path set will be ignored.
+ */
 LIBBPF_API int bpf_object__unpin_maps(struct bpf_object *obj,
 				      const char *path);
 LIBBPF_API int bpf_object__pin_programs(struct bpf_object *obj,
@@ -848,10 +867,57 @@ LIBBPF_API const void *bpf_map__initial_value(struct bpf_map *map, size_t *psize
  * @return true, if the map is an internal map; false, otherwise
  */
 LIBBPF_API bool bpf_map__is_internal(const struct bpf_map *map);
+
+/**
+ * @brief **bpf_map__set_pin_path()** sets the path attribute that tells where the
+ * BPF map should be pinned. This does not actually create the 'pin'.
+ * @param map The bpf_map
+ * @param path The path
+ * @return 0, on success; negative error, otherwise
+ */
 LIBBPF_API int bpf_map__set_pin_path(struct bpf_map *map, const char *path);
+
+/**
+ * @brief **bpf_map__pin_path()** gets the path attribute that tells where the
+ * BPF map should be pinned.
+ * @param map The bpf_map
+ * @return The path string; which can be NULL
+ */
 LIBBPF_API const char *bpf_map__pin_path(const struct bpf_map *map);
+
+/**
+ * @brief **bpf_map__is_pinned()** tells the caller whether or not the
+ * passed map has been pinned via a 'pin' file.
+ * @param map The bpf_map
+ * @return true, if the map is pinned; false, otherwise
+ */
 LIBBPF_API bool bpf_map__is_pinned(const struct bpf_map *map);
+
+/**
+ * @brief **bpf_map__pin()** creates a file that serves as a 'pin'
+ * for the BPF map. This increments the reference count on the
+ * BPF map which will keep the BPF map loaded even after the
+ * userspace process which loaded it has exited.
+ * @param map The bpf_map to pin
+ * @param path A file path for the 'pin'
+ * @return 0, on success; negative error, otherwise
+ *
+ * If `path` is NULL the maps `pin_path` attribute will be used. If this is
+ * also NULL, an error will be returned and the map will not be pinned.
+ */
 LIBBPF_API int bpf_map__pin(struct bpf_map *map, const char *path);
+
+/**
+ * @brief **bpf_map__unpin()** removes the file that serves as a
+ * 'pin' for the BPF map.
+ * @param map The bpf_map to unpin
+ * @param path A file path for the 'pin'
+ * @return 0, on success; negative error, otherwise
+ *
+ * The `path` parameter can be NULL, in which case the `pin_path`
+ * map attribute is unpinned. If both the `path` parameter and
+ * `pin_path` map attribute are set, they must be equal.
+ */
 LIBBPF_API int bpf_map__unpin(struct bpf_map *map, const char *path);
 
 LIBBPF_API int bpf_map__set_inner_map_fd(struct bpf_map *map, int fd);
-- 
2.39.0

