Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB0940B8D7
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 22:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbhINUSi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 16:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbhINUSi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 16:18:38 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD61C061574
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 13:17:20 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id u21so193453qtw.8
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 13:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kQFQy/KvGd2y0WYUINio473PFDIyYZyeyVoFb6izMr0=;
        b=jpcNq4pNyJP/N3IDIyRCb+v35s8NmMrFyXETzPAx939U+izFslEGpk+4O68JRyiOQ6
         i4E0Uw0nFQ/SjijFbQgBQ52elxSZiB3WaqV9sQwYr7hsTSAAIT1nxsTneEmd2CFssYAr
         BsPOVR7jFNpRWYqzh0w60tm4JHXaD6gQN+c46phWySFAqEbbWmmsgshaQo8jN+KhjBid
         szjLr0fqevKHujYrR0JjKBeVYnmKkdrWUvnwYgUc7WcfRZDw9pSnzDRfzF0h+Wg/N60D
         FkgWVz0XTBuwZszjJzyYvAmsYmuA2Yg9/b4X7FVf1TpUZ164JzvM1Veh1+OOSmBGDHxK
         JDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kQFQy/KvGd2y0WYUINio473PFDIyYZyeyVoFb6izMr0=;
        b=Z/LgXZW7DLBmwJrEml+BXlpYEv4sJMtKeaPuLMMXk+yp1E36h6sxofKkTr6utgLtJm
         RcTAOc4j42VsfsbSy4VflKqD+ngVU1Bs7E3k5TFJ6g7L+Kc4WOy7AcTrQ4zD8ofEnP2Q
         THn2kgg8z/i34+UyyiZf/ktBNs9F9tKnewn8pxI9j1jdngGtSPKh7qXxU2SwbaIETjnY
         hhdwQxYW33wP8PDpqa5iYhwxWlsYfcDU7cT2J1jkgYgQ1kXE6qP2X+7KhW8CK1LyK/Mb
         ELddtnTceHUWjWQnA+z1JBsHrJY0OnzfFDuEHWc+R5n9IPXuV+kHMx2ojlsIhAa87jum
         eq5A==
X-Gm-Message-State: AOAM531b7Uff5EMDCxFkL64m88mlrO880vc5ftLsqpL0c6hKMI2FUqua
        IMqUHG5XUTO2vFcnwuZQUE4=
X-Google-Smtp-Source: ABdhPJxo2TWLwh7dzv8lmE4XiUX2DF/aVQ5pwFkCvfiRzLr0XeEHayc3J7LgThrBNLMtU3wX16d3Zg==
X-Received: by 2002:ac8:6e88:: with SMTP id c8mr6710885qtv.241.1631650639581;
        Tue, 14 Sep 2021 13:17:19 -0700 (PDT)
Received: from localhost.localdomain (cpe-104-162-105-43.nyc.res.rr.com. [104.162.105.43])
        by smtp.gmail.com with ESMTPSA id g1sm8357311qkd.89.2021.09.14.13.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 13:17:19 -0700 (PDT)
From:   grantseltzer <grantseltzer@gmail.com>
To:     andrii@kernel.org
Cc:     bpf@vger.kernel.org, grantseltzer@gmail.com
Subject: [PATCH bpf-next v2] Add sphinx code documentation comments
Date:   Tue, 14 Sep 2021 16:16:43 -0400
Message-Id: <20210914201642.98734-1-grantseltzer@gmail.com>
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
 tools/lib/bpf/btf.h | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 4a711f990904..05e06f0136e3 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
 /* Copyright (c) 2018 Facebook */
+/*! \file */
 
 #ifndef __LIBBPF_BTF_H
 #define __LIBBPF_BTF_H
@@ -30,11 +31,47 @@ enum btf_endianness {
 	BTF_BIG_ENDIAN = 1,
 };
 
+/**
+ * @brief **btf__free()** frees all data of a BTF object.
+ * @param btf BTF object to free
+ * @return void
+ */
 LIBBPF_API void btf__free(struct btf *btf);
 
+/**
+ * @brief **btf__new()** creates a new instance of a BTF object.
+ * from the raw bytes of an ELF's BTF section
+ * @param data raw bytes
+ * @param size length of raw bytes
+ * @return new instance of BTF object which has to be eventually freed 
+ * with **btf__free()**
+ */
 LIBBPF_API struct btf *btf__new(const void *data, __u32 size);
+
+/**
+ * @brief **btf__new_split()** create a new instance of a BTF object from 
+ * the provided raw data bytes. It takes another BTF instance, **base_btf**, 
+ * which serves as a base BTF, which is extended by types in a newly created
+ * BTF instance.
+ * @param data raw bytes
+ * @param size length of raw bytes
+ * @param base_btf the base btf object
+ * @return struct btf *
+ */
 LIBBPF_API struct btf *btf__new_split(const void *data, __u32 size, struct btf *base_btf);
+
+/**
+ * @brief **btf__new_empty()** creates an unpopulated BTF object.
+ * @return struct btf *
+ */
 LIBBPF_API struct btf *btf__new_empty(void);
+
+/**
+ * @brief **btf__new_empty_split()** creates an unpopulated
+ * BTF object from an ELF BTF section except with a base BTF
+ * on top of which split BTF should be based.
+ * @return struct btf *
+ */
 LIBBPF_API struct btf *btf__new_empty_split(struct btf *base_btf);
 
 LIBBPF_API struct btf *btf__parse(const char *path, struct btf_ext **btf_ext);
-- 
2.31.1

