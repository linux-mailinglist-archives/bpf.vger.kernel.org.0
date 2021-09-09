Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E303405E26
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 22:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345157AbhIIUoi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 16:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245195AbhIIUof (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Sep 2021 16:44:35 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67BCC061574
        for <bpf@vger.kernel.org>; Thu,  9 Sep 2021 13:43:25 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id ay33so3368726qkb.10
        for <bpf@vger.kernel.org>; Thu, 09 Sep 2021 13:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M3UFQorvVSo3/tUCryHPXj+x6ylAAB1KI4plMq+wx2Y=;
        b=f2w9HwLW1IDAlYW024ZPaUGks2+BkLC306ZVg5hSlKZTqib2hX0seUGddCmbcISMnm
         wN/BGAQFF/ev6R+XylSioVANBGCIkylt3f/TPVGis8T4CZ4mI2IxV7+Irtra2+r/GgYL
         wD5Y/wv/Z5jHC/HYAg4+pA2bSZEsUYcNZZX+wpzvBSd6mhBjKVL3sL2zUIWocQPuoSrZ
         QXTTweDYNVTQ5EFY2u1CEVEFAdxroOu++bUyBQEdBUQrWkiOwO2OSq3bCgADAKY4iO6N
         iBg9DD73OWsKfBKrmAmqT/p1ATP5ZkqoFHSZyeISxbKJkEHl0iVY9uVggLG6kIHpRJ1f
         wkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M3UFQorvVSo3/tUCryHPXj+x6ylAAB1KI4plMq+wx2Y=;
        b=6cIatYp1kksYnR8t7GCmCr0W6OxfHYcJc6KnmcHuF1IKlTu5SxfgbYRJ9CGFahMYWT
         a9eS9L15pEhOm8z7HAT/MZlEMs7u60Xvv5TkqLE1wk4T+QmVA7N7Yi0WYT4916rNZodV
         75CDHLg7ChTKo03DULB2wnroQ3O9992t82Pj49Au8QkagmfBC+AHO61i2PbJv+N9bc5m
         fS5qTVomvGzmddL6Ce2BVlPaqOBEEtLQCRwDMBTR62ozWUcu9c1wp4cmtL+HEJW4judJ
         Zxv4e4NXfgFXJlqNvSNOD7kvGRDbLb8w3RBy81T5HLLQ5JRKwD26PJS33yQqDumT9gwl
         7Eug==
X-Gm-Message-State: AOAM531b6a91kfO3ZvVg8Qxcn/PtX5vfJ3TdVoVEx3X+CyR2+iBqs3OS
        YadSiflUsYBWFFjNqmfyc11OLCdBSkcgig==
X-Google-Smtp-Source: ABdhPJwtwnujJAKfIZFPiJyhLFoCaYo31hIBpC/ZqvbP7kqkdDBB22ke2k0BOnI28xYZfLoyG/IwgQ==
X-Received: by 2002:a37:f90c:: with SMTP id l12mr4569224qkj.514.1631220205063;
        Thu, 09 Sep 2021 13:43:25 -0700 (PDT)
Received: from localhost.localdomain (cpe-104-162-105-43.nyc.res.rr.com. [104.162.105.43])
        by smtp.gmail.com with ESMTPSA id l13sm1772877qtr.67.2021.09.09.13.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 13:43:24 -0700 (PDT)
From:   grantseltzer <grantseltzer@gmail.com>
To:     andrii@kernel.org
Cc:     bpf@vger.kernel.org, grantseltzer@gmail.com
Subject: [PATCH bpf-next] libbpf: Add sphinx code documentation comments
Date:   Thu,  9 Sep 2021 16:43:12 -0400
Message-Id: <20210909204312.197814-1-grantseltzer@gmail.com>
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
 tools/lib/bpf/btf.h | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 4a711f990904..f928e57c238c 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -30,11 +30,47 @@ enum btf_endianness {
 	BTF_BIG_ENDIAN = 1,
 };
 
+/**
+ * @brief **btf__free** frees all data of the BTF representation
+ * @param btf
+ * @return void
+ */
 LIBBPF_API void btf__free(struct btf *btf);
 
+/**
+ * @brief **btf__new** creates a representation of a BTF section
+ * (struct btf) from the raw bytes of that section
+ * @param data raw bytes
+ * @param size length of raw bytes
+ * @return struct btf*
+ */
 LIBBPF_API struct btf *btf__new(const void *data, __u32 size);
+
+/**
+ * @brief **btf__new_split** creates a representation of a BTF section
+ * (struct btf) from a combination of raw bytes and a btf struct
+ * where the btf struct provides a basic set of types and strings,
+ * while the raw data adds its own new types and strings
+ * @param data raw bytes
+ * @param size length of raw bytes
+ * @param base_btf the base btf representation
+ * @return struct btf*
+ */
 LIBBPF_API struct btf *btf__new_split(const void *data, __u32 size, struct btf *base_btf);
+
+/**
+ * @brief **btf__new_empty** creates an unpopulated representation of
+ * a BTF section
+ * @return struct btf*
+ */
 LIBBPF_API struct btf *btf__new_empty(void);
+
+/**
+ * @brief **btf__new_empty_split** creates an unpopulated
+ * representation of a BTF section except with a base BTF
+ * ontop of which split BTF should be based
+ * @return struct btf*q
+ */
 LIBBPF_API struct btf *btf__new_empty_split(struct btf *base_btf);
 
 LIBBPF_API struct btf *btf__parse(const char *path, struct btf_ext **btf_ext);
-- 
2.31.1

