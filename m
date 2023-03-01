Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A176A747C
	for <lists+bpf@lfdr.de>; Wed,  1 Mar 2023 20:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjCATtQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Mar 2023 14:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCATtP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Mar 2023 14:49:15 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A8455BE;
        Wed,  1 Mar 2023 11:49:14 -0800 (PST)
Received: by mail-qt1-f179.google.com with SMTP id c19so15581495qtn.13;
        Wed, 01 Mar 2023 11:49:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677700153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SaoAu/dWkCaSTMzj2ZM4Jr76OIYgF7YKtHGbfgwEZcY=;
        b=PcuSxeoOuvcOKqPmSoPaUC8BLOHWeHtfTThR6hjDYjdOEJAxKT4pLXRmJk8ZIpIc4j
         PRSMysv5kMkG4LfvGf33QKKRXabJUf7lVAx9V4oi7x0++mzYvncHbPvjZ+aKwlocFFu4
         L8bXDS+CEd2WcnvL6WWZQQKamloRsNXMKB2lotX+/a0B6ywSbK/6TVdJ6sAXdswjM1BF
         uh3gYyoifApPzmYok/bEA0G/Ih1GkRZjPG6xCR8ZEM85PNYXRPtLaxUr2f0ZuUklwnKx
         5zmFqbAPiQruo0Co0yy1o2jrUMCoUsmUan3actEAdIBBQleOu5jJiG1fteXqAValliUM
         JCPA==
X-Gm-Message-State: AO0yUKWtwJ0jB9zZrqoUrYKlSroJ2EU85nluidetBghcdVB43IM1EZU0
        BH2cOCdm4o6GLrRGGhz0moz06dNUjqYIiB/f
X-Google-Smtp-Source: AK7set/7+vCHQpXjbxstN7OOi/XJk26Bu56wJ7t4gepq35FxOeX/vHsDrK6P4VDKvXm9kljWoQxFSA==
X-Received: by 2002:ac8:570d:0:b0:3bf:e364:1d19 with SMTP id 13-20020ac8570d000000b003bfe3641d19mr13175262qtw.54.1677700153237;
        Wed, 01 Mar 2023 11:49:13 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:9336])
        by smtp.gmail.com with ESMTPSA id y141-20020a376493000000b00706c1f7a608sm9473326qkb.89.2023.03.01.11.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 11:49:12 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH bpf-next 1/2] bpf: Fix doxygen comments for dynptr slice kfuncs
Date:   Wed,  1 Mar 2023 13:49:09 -0600
Message-Id: <20230301194910.602738-1-void@manifault.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In commit 66e3a13e7c2c ("bpf: Add bpf_dynptr_slice and
bpf_dynptr_slice_rdwr"), the bpf_dynptr_slice() and
bpf_dynptr_slice_rdwr() kfuncs were added to BPF. These kfuncs included
doxygen headers, but unfortunately those headers are not properly
formatted according to [0], and causes the following warnings during the
docs build:

./kernel/bpf/helpers.c:2225: warning: \
    Excess function parameter 'returns' description in 'bpf_dynptr_slice'
./kernel/bpf/helpers.c:2303: warning: \
    Excess function parameter 'returns' description in 'bpf_dynptr_slice_rdwr'
...

This patch fixes those doxygen comments.

[0]: https://docs.kernel.org/doc-guide/kernel-doc.html#function-documentation

Fixes: 66e3a13e7c2c ("bpf: Add bpf_dynptr_slice and bpf_dynptr_slice_rdwr")
Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/bpf/helpers.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 648b29e78b84..58431a92bb65 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2194,7 +2194,12 @@ __bpf_kfunc struct task_struct *bpf_task_from_pid(s32 pid)
 }
 
 /**
- * bpf_dynptr_slice - Obtain a read-only pointer to the dynptr data.
+ * bpf_dynptr_slice() - Obtain a read-only pointer to the dynptr data.
+ * @ptr: The dynptr whose data slice to retrieve
+ * @offset: Offset into the dynptr
+ * @buffer: User-provided buffer to copy contents into
+ * @buffer__szk: Size (in bytes) of the buffer. This is the length of the
+ *		 requested slice. This must be a constant.
  *
  * For non-skb and non-xdp type dynptrs, there is no difference between
  * bpf_dynptr_slice and bpf_dynptr_data.
@@ -2209,13 +2214,7 @@ __bpf_kfunc struct task_struct *bpf_task_from_pid(s32 pid)
  * bpf_dynptr_slice will not invalidate any ctx->data/data_end pointers in
  * the bpf program.
  *
- * @ptr: The dynptr whose data slice to retrieve
- * @offset: Offset into the dynptr
- * @buffer: User-provided buffer to copy contents into
- * @buffer__szk: Size (in bytes) of the buffer. This is the length of the
- * requested slice. This must be a constant.
- *
- * @returns: NULL if the call failed (eg invalid dynptr), pointer to a read-only
+ * Return: NULL if the call failed (eg invalid dynptr), pointer to a read-only
  * data slice (can be either direct pointer to the data or a pointer to the user
  * provided buffer, with its contents containing the data, if unable to obtain
  * direct pointer)
@@ -2258,7 +2257,12 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u32 offset
 }
 
 /**
- * bpf_dynptr_slice_rdwr - Obtain a writable pointer to the dynptr data.
+ * bpf_dynptr_slice_rdwr() - Obtain a writable pointer to the dynptr data.
+ * @ptr: The dynptr whose data slice to retrieve
+ * @offset: Offset into the dynptr
+ * @buffer: User-provided buffer to copy contents into
+ * @buffer__szk: Size (in bytes) of the buffer. This is the length of the
+ *		 requested slice. This must be a constant.
  *
  * For non-skb and non-xdp type dynptrs, there is no difference between
  * bpf_dynptr_slice and bpf_dynptr_data.
@@ -2287,13 +2291,7 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u32 offset
  * bpf_dynptr_slice_rdwr will not invalidate any ctx->data/data_end pointers in
  * the bpf program.
  *
- * @ptr: The dynptr whose data slice to retrieve
- * @offset: Offset into the dynptr
- * @buffer: User-provided buffer to copy contents into
- * @buffer__szk: Size (in bytes) of the buffer. This is the length of the
- * requested slice. This must be a constant.
- *
- * @returns: NULL if the call failed (eg invalid dynptr), pointer to a
+ * Return: NULL if the call failed (eg invalid dynptr), pointer to a
  * data slice (can be either direct pointer to the data or a pointer to the user
  * provided buffer, with its contents containing the data, if unable to obtain
  * direct pointer)
-- 
2.39.0

