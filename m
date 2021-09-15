Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 812AF40BDB9
	for <lists+bpf@lfdr.de>; Wed, 15 Sep 2021 04:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbhIOCW3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 22:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhIOCW2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 22:22:28 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1035C061574
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 19:21:10 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id a13so1011197qvo.9
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 19:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=af2ZP55SCHqXtAnfU98wK1vm1sp8pb5bzYELoTIoHUY=;
        b=hnRgAE7GiVSKmS5np8d3t3zlvXhAvkbRsXKHdDkTAab7XE30IuOjJ/fdQPk9cRTFwy
         9pu2iadmQSv/za8+yDqg/I+gHjA89kz9SbjmxiATlVwjxpWL+cgkLZlDMoi3vjtslw88
         yP/SazhMdibkzDwOu/c/0o5akuKTemsp5NXLX0G7PpJUrICBFR07OI6Fl+bFZIxm0C1r
         vPA86MOa3aoYpdiO5yccragyE/QTyctlPKZTiGkm7VxoN6Z5FKZxG7tFu52L4iMwpSKZ
         REI2OqJ4mhy6WQlV5HPWKLW7WfKYycT0ayXjRax0AvdGQmfdZQbCSrx8pfAUXadO7e+G
         gBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=af2ZP55SCHqXtAnfU98wK1vm1sp8pb5bzYELoTIoHUY=;
        b=QdJ3hrvx0zDrXcgAcJZdSLFJbBJU49DC2EiiC0CnJta4eapqTtM349S5APnWlAshei
         Ihmvqqx/IG8JcoMY5Q5/CBQKrssM8Nk/LNRvvR1fBAtegPPhlhslVfRvk1T84eLezDKB
         HCBn4wCGGPINiu1X/TrYwmpupUaSMsJnjnK02RKWDs1TQdcabOud+/OnYk7G12E9JnrF
         baWTnkL9JiZXpwmJpW+W5k9/t9jx0uP/YgYDTCcgTh2Eqi1gH9qe3aBde//jwEafKFui
         3vMMQ3PhtGo0S9vr2MOufb30JXFnneRrsS0GtwwX4GbisybzeqnuAGvFopSPHMS2MoN0
         /wCg==
X-Gm-Message-State: AOAM530X0+Ig7Ax9IYZ2V25R+h0/rTeoE9bAQ1Pn6iJcb8L8goDIR30p
        WZWMFSc+i+pupprPNXc1zXwZFdlZTOakDw==
X-Google-Smtp-Source: ABdhPJz/aTWAIpVP+X1F8xgU5x/qkgarFILHVVexZDUU1ZY9tXv1bjOFnwCtfXIV2DDT2aBZAxSutA==
X-Received: by 2002:a0c:e0c7:: with SMTP id x7mr8566122qvk.55.1631672469775;
        Tue, 14 Sep 2021 19:21:09 -0700 (PDT)
Received: from localhost.localdomain (cpe-104-162-105-43.nyc.res.rr.com. [104.162.105.43])
        by smtp.gmail.com with ESMTPSA id 187sm8978485qke.32.2021.09.14.19.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 19:21:09 -0700 (PDT)
From:   grantseltzer <grantseltzer@gmail.com>
To:     andrii@kernel.org
Cc:     bpf@vger.kernel.org, grantseltzer@gmail.com
Subject: [PATCH btf-next v3] libbpf: Add sphinx code documentation comments
Date:   Tue, 14 Sep 2021 22:19:52 -0400
Message-Id: <20210915021951.117186-1-grantseltzer@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Grant Seltzer <grantseltzer@gmail.com>

This adds comments above five functions in btf.h which document
their uses. These comments are of a format that doxygen and sphinx
can pick up and render. These are rendered by libbpf.readthedocs.org

Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
---
 tools/lib/bpf/btf.h | 67 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 4a711f990904..bfbc5e780e0f 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
 /* Copyright (c) 2018 Facebook */
+/*! \file */
 
 #ifndef __LIBBPF_BTF_H
 #define __LIBBPF_BTF_H
@@ -30,11 +31,77 @@ enum btf_endianness {
 	BTF_BIG_ENDIAN = 1,
 };
 
+/**
+ * @brief **btf__free()** frees all data of a BTF object
+ * @param btf BTF object to free
+ */
 LIBBPF_API void btf__free(struct btf *btf);
 
+/**
+ * @brief **btf__new()** creates a new instance of a BTF object
+ * from the raw bytes of an ELF's BTF section
+ * @param data raw bytes
+ * @param size number of bytes passed in `data`
+ * @return new instance of BTF object which has to be eventually freed
+ * with **btf__free()**
+ *
+ * On error, error-code-encoded-as-pointer is returned, not a NULL. To
+ * extract error code from such a pointer `libbpf_get_error()` should be
+ * used. If `libbpf_set_strict_mode(LIBBPF_STRICT_CLEAN_PTRS)` is
+ * enabled, NULL is returned on error instead. In both cases thread-local
+ * `errno` variable is always set to error code as well.
+ */
 LIBBPF_API struct btf *btf__new(const void *data, __u32 size);
+
+/**
+ * @brief **btf__new_split()** create a new instance of a BTF object from 
+ * the provided raw data bytes. It takes another BTF instance, **base_btf**, 
+ * which serves as a base BTF, which is extended by types in a newly created
+ * BTF instance
+ * @param data raw bytes
+ * @param size length of raw bytes
+ * @param base_btf the base btf object
+ * @return new instance of BTF object which has to be eventually freed
+ * with **btf__free()**
+ *
+ * On error, error-code-encoded-as-pointer is returned, not a NULL. To
+ * extract error code from such a pointer `libbpf_get_error()` should be
+ * used. If `libbpf_set_strict_mode(LIBBPF_STRICT_CLEAN_PTRS)` is
+ * enabled, NULL is returned on error instead. In both cases thread-local
+ * `errno` variable is always set to error code as well.
+ */
 LIBBPF_API struct btf *btf__new_split(const void *data, __u32 size, struct btf *base_btf);
+
+/**
+ * @brief **btf__new_empty()** creates an unpopulated BTF object
+ * Use `btf__add_*()` to populate such BTF object.
+ * @return new instance of BTF object which has to be eventually freed
+ * with **btf__free()**
+ *
+ * On error, error-code-encoded-as-pointer is returned, not a NULL. To
+ * extract error code from such a pointer `libbpf_get_error()` should be
+ * used. If `libbpf_set_strict_mode(LIBBPF_STRICT_CLEAN_PTRS)` is
+ * enabled, NULL is returned on error instead. In both cases thread-local
+ * `errno` variable is always set to error code as well.
+ */
 LIBBPF_API struct btf *btf__new_empty(void);
+
+/**
+ * @brief **btf__new_empty_split()** creates an unpopulated
+ * BTF object from an ELF BTF section except with a base BTF
+ * on top of which split BTF should be based
+ * @return new instance of BTF object which has to be eventually freed 
+ * with **btf__free()**
+ *
+ * If *base_btf* is NULL, `btf__new_empty_split()` is equivalent to
+ * `btf__new_empty()` and creates non-split BTF.
+ *
+ * On error, error-code-encoded-as-pointer is returned, not a NULL. To
+ * extract error code from such a pointer `libbpf_get_error()` should be
+ * used. If `libbpf_set_strict_mode(LIBBPF_STRICT_CLEAN_PTRS)` is
+ * enabled, NULL is returned on error instead. In both cases thread-local
+ * `errno` variable is always set to error code as well.
+ */
 LIBBPF_API struct btf *btf__new_empty_split(struct btf *base_btf);
 
 LIBBPF_API struct btf *btf__parse(const char *path, struct btf_ext **btf_ext);
-- 
2.31.1

