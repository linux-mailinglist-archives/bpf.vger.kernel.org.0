Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3057967C2E9
	for <lists+bpf@lfdr.de>; Thu, 26 Jan 2023 03:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjAZCsH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 21:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjAZCsG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 21:48:06 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121C911EB1
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 18:48:05 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id h10so552508qvq.7
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 18:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nzWrsH0yQtsVUMDhVGVL/SOqByOsk//tQmWvKw3fSEA=;
        b=oIax5OOOr/u8I7BdY6dPN7U2fvlMnwHoYjUiyg3yNO9oqPs4NvHkwUTXVHubQJKRbB
         owdI76Do00wTFe2791VAzUzqWLd6wSosKB5IXbdhl3X7ksXT2TK4Z+ayM1N3TBNOUolF
         wPxRN/GNkfy7bILm4fgoDOrRu6lpKuyse5dOtmLGEVqInU5AEaoKLnNBM/H00DM6q7DL
         8yTT4P8uHqvsA5Im1n77L1x75P7zyEVigOryybzGHHyKNryUNx2yBrte+FRIT3Zw7Zsi
         gJZmmVxe47OjbQvB+vxBbVU6zSC66adKzTcH7YGrt+u+jwbbnoKSUdxMmThdfbMJ7Z1b
         Nt4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nzWrsH0yQtsVUMDhVGVL/SOqByOsk//tQmWvKw3fSEA=;
        b=wRJcGFWgZafT+Y/BpEjSWoU+O641IyrdXOhHoi2TOYZsYO5yjXhkfvPLndLEM0jZx5
         GW72MEA1cVX0P3S4MtXjC3A0EJWsFHjsrd2gHhcwMQH2VTkXyY2hse4H1f+A/Dk6Em3E
         0/sfUV+LUpL5H7j1GQpUr8139/XN0QIAVUiy5Jsjh2JykEKEjpqIbRXB+GEIURpXcHBf
         WIg4tuRHSHMspCLCWiykxpCKDwmS4rVFmm+9SSOxyoS4XWtRXAnZsuwaqH2Eynr7wEWH
         mZdp04v8J1zns8BVkF6QyglOoGjpOa4x66MUVmQ6vOFP1H6ZjM+DU/pU82K7cojvH9Xa
         9Kkg==
X-Gm-Message-State: AFqh2krM4omLTG91OmOjFWNZOUj9RpP0JM24CfKSJnnCsq2vyNW8KBw1
        ZlVTCuj8mxf6/63oNiBVCV5I8iLaXj+l5Q==
X-Google-Smtp-Source: AMrXdXuHujjg6qNWYCfy7GRIGeFgqlK9exE3oc+H/ZtDC8gF6LmeIqRXmpKw375vcmPwv2BsW4wvTw==
X-Received: by 2002:a0c:ec92:0:b0:531:e436:8e92 with SMTP id u18-20020a0cec92000000b00531e4368e92mr53297486qvo.22.1674701283648;
        Wed, 25 Jan 2023 18:48:03 -0800 (PST)
Received: from grant-fedora.localdomain (cpe-104-162-105-43.nyc.res.rr.com. [104.162.105.43])
        by smtp.gmail.com with ESMTPSA id q29-20020a05620a025d00b006bbf85cad0fsm190309qkn.20.2023.01.25.18.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 18:48:03 -0800 (PST)
From:   Grant Seltzer <grantseltzer@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, grantseltzer@gmail.com
Subject: [PATCH bpf-next] Fix malformed documentation formatting
Date:   Wed, 25 Jan 2023 21:47:49 -0500
Message-Id: <20230126024749.522278-1-grantseltzer@gmail.com>
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

This fixes the doxygen format documentation above the
user_ring_buffer__* APIs. There has to be a newline
before the @brief, otherwise doxygen won't render them
for libbpf.readthedocs.org.

Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
---
 tools/lib/bpf/libbpf.h | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 28138579f162..8777ff21ea1d 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1130,7 +1130,8 @@ struct user_ring_buffer_opts {
 
 #define user_ring_buffer_opts__last_field sz
 
-/* @brief **user_ring_buffer__new()** creates a new instance of a user ring
+/**
+ * @brief **user_ring_buffer__new()** creates a new instance of a user ring
  * buffer.
  *
  * @param map_fd A file descriptor to a BPF_MAP_TYPE_USER_RINGBUF map.
@@ -1141,7 +1142,8 @@ struct user_ring_buffer_opts {
 LIBBPF_API struct user_ring_buffer *
 user_ring_buffer__new(int map_fd, const struct user_ring_buffer_opts *opts);
 
-/* @brief **user_ring_buffer__reserve()** reserves a pointer to a sample in the
+/**
+ * @brief **user_ring_buffer__reserve()** reserves a pointer to a sample in the
  * user ring buffer.
  * @param rb A pointer to a user ring buffer.
  * @param size The size of the sample, in bytes.
@@ -1161,7 +1163,8 @@ user_ring_buffer__new(int map_fd, const struct user_ring_buffer_opts *opts);
  */
 LIBBPF_API void *user_ring_buffer__reserve(struct user_ring_buffer *rb, __u32 size);
 
-/* @brief **user_ring_buffer__reserve_blocking()** reserves a record in the
+/**
+ * @brief **user_ring_buffer__reserve_blocking()** reserves a record in the
  * ring buffer, possibly blocking for up to @timeout_ms until a sample becomes
  * available.
  * @param rb The user ring buffer.
@@ -1205,7 +1208,8 @@ LIBBPF_API void *user_ring_buffer__reserve_blocking(struct user_ring_buffer *rb,
 						    __u32 size,
 						    int timeout_ms);
 
-/* @brief **user_ring_buffer__submit()** submits a previously reserved sample
+/**
+ * @brief **user_ring_buffer__submit()** submits a previously reserved sample
  * into the ring buffer.
  * @param rb The user ring buffer.
  * @param sample A reserved sample.
@@ -1215,7 +1219,8 @@ LIBBPF_API void *user_ring_buffer__reserve_blocking(struct user_ring_buffer *rb,
  */
 LIBBPF_API void user_ring_buffer__submit(struct user_ring_buffer *rb, void *sample);
 
-/* @brief **user_ring_buffer__discard()** discards a previously reserved sample.
+/**
+ * @brief **user_ring_buffer__discard()** discards a previously reserved sample.
  * @param rb The user ring buffer.
  * @param sample A reserved sample.
  *
@@ -1224,7 +1229,8 @@ LIBBPF_API void user_ring_buffer__submit(struct user_ring_buffer *rb, void *samp
  */
 LIBBPF_API void user_ring_buffer__discard(struct user_ring_buffer *rb, void *sample);
 
-/* @brief **user_ring_buffer__free()** frees a ring buffer that was previously
+/**
+ * @brief **user_ring_buffer__free()** frees a ring buffer that was previously
  * created with **user_ring_buffer__new()**.
  * @param rb The user ring buffer being freed.
  */
-- 
2.39.1

