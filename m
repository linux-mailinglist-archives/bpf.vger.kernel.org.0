Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08A63E50DA
	for <lists+bpf@lfdr.de>; Tue, 10 Aug 2021 04:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237295AbhHJCFr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Aug 2021 22:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbhHJCFr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Aug 2021 22:05:47 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F0EC0613D3;
        Mon,  9 Aug 2021 19:05:25 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id m3so563866qvu.0;
        Mon, 09 Aug 2021 19:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KuVt9PHYRIz5+66SNd2Stv+PFCNrsJKcokgIDdxaj/c=;
        b=sQK2Z4zrycE7fEfrxK/jVE63b/zaJjsrNt6zBeRZIIDTMcUqVb2rAPICJQnPdBobH+
         c3I5y8GQ8WD4+WrjMKfTUvib+G7GL625o+nHfXqVRn8HdVQES0qPVyidfB4vDoQktPTJ
         CPoISarhGAhMPP8r7Etvdsd7TQ6SAkT0f3SQ3Q2XjkD/2zU4k7dZVrS08wQLnOLUvbAG
         8S1hjr+8jaUMBp/KjFIp4B+Dn5Xw+Kj9EzWSOcmyAyzCWxwBNX5Yf9/e4X91UGaEgbnS
         MBqXoXhIs6UVD3mFtIdvLDMpjKNeBJc+se4lK+rmmtxARfLdBCFLTvvZgDYjs787PxPT
         BRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KuVt9PHYRIz5+66SNd2Stv+PFCNrsJKcokgIDdxaj/c=;
        b=iNwaUVzSChvh7YIKZAdJ1MHxMDlD2eEol6WHjsJVyvjChjzjFyC18dOc0mb1/9x1Fx
         MgCoT2j4rYl4GwV1JBQgDF++HVMTPvsm/0rNOy1eD8AcN5+TDYU0vxx9QyfJfTOm+0j2
         GyOIWAJ0lBgZYE+Up1UnvYLEcGkwOYBONhOh7h3ZoSCoNhRXhlKIUhLfL82ER5IyewSi
         DcL6Zz2wM5C6gnZVqQFc0SG6uriAJcHv23hRj0nv7VKG1GMzCkkgjI9a1p1tcT3MJccD
         JmHPLxDqueRlDClfxGARj+2t6+looyVn5lOPP3Y2ha7WCwmaSXM1+roUf5+WN7PuFgF1
         977A==
X-Gm-Message-State: AOAM533v1XD8HccvsBSz6hBkxT7eAR4XDS1vo2iRVwj22MwqbnNOHozF
        V4eTj+t34/VhAKz1spDcaqo=
X-Google-Smtp-Source: ABdhPJwnDNjYD1TyHbf1fnY76k0BijNYuPSGpxkl1E+yvbdE9BKfS8Xeh4tF7tf3pLlkgeQr/SB0SA==
X-Received: by 2002:a0c:e84a:: with SMTP id l10mr4478059qvo.3.1628561125092;
        Mon, 09 Aug 2021 19:05:25 -0700 (PDT)
Received: from localhost.localdomain (cpe-104-162-105-43.nyc.res.rr.com. [104.162.105.43])
        by smtp.gmail.com with ESMTPSA id 70sm6353111qtb.20.2021.08.09.19.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 19:05:24 -0700 (PDT)
From:   grantseltzer <grantseltzer@gmail.com>
To:     andrii@kernel.org
Cc:     bpf@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org,
        grantseltzer <grantseltzer@gmail.com>
Subject: [PATCH bpf-next v1] bpf: Reconfigure libbpf docs to remove unversioned API
Date:   Mon,  9 Aug 2021 22:05:08 -0400
Message-Id: <20210810020508.280639-1-grantseltzer@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This removes the libbpf_api.rst file from the kernel documentation.
The intention for this file was to pull documentation from comments
above API functions in libbpf. However, due to limitations of the
kernel documentation system, this API documentation could not be
versioned, which is counterintuative to how users expect to use it.
There is also currently no doc comments, making this a blank page.

Once the kernel comment documentation is actually contributed, it
will still exist in the kernel repository, just in the code itself.

A seperate site is being spun up to generate documentaiton from those
comments in a way in which it can be versioned properly.

This also reconfigures the bpf documentation index page to make it
easier to sync to the previously mentioned documentaiton site.

Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
---
 Documentation/bpf/index.rst             | 10 +--------
 Documentation/bpf/libbpf/libbpf_api.rst | 27 -------------------------
 2 files changed, 1 insertion(+), 36 deletions(-)
 delete mode 100644 Documentation/bpf/libbpf/libbpf_api.rst

diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
index baea6c2abba5..1ceb5d704a97 100644
--- a/Documentation/bpf/index.rst
+++ b/Documentation/bpf/index.rst
@@ -15,15 +15,7 @@ that goes into great technical depth about the BPF Architecture.
 libbpf
 ======
 
-Libbpf is a userspace library for loading and interacting with bpf programs.
-
-.. toctree::
-   :maxdepth: 1
-
-   libbpf/libbpf
-   libbpf/libbpf_api
-   libbpf/libbpf_build
-   libbpf/libbpf_naming_convention
+Documentation/bpf/libbpf/libbpf.rst is a userspace library for loading and interacting with bpf programs.
 
 BPF Type Format (BTF)
 =====================
diff --git a/Documentation/bpf/libbpf/libbpf_api.rst b/Documentation/bpf/libbpf/libbpf_api.rst
deleted file mode 100644
index f07eecd054da..000000000000
--- a/Documentation/bpf/libbpf/libbpf_api.rst
+++ /dev/null
@@ -1,27 +0,0 @@
-.. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-
-API
-===
-
-This documentation is autogenerated from header files in libbpf, tools/lib/bpf
-
-.. kernel-doc:: tools/lib/bpf/libbpf.h
-   :internal:
-
-.. kernel-doc:: tools/lib/bpf/bpf.h
-   :internal:
-
-.. kernel-doc:: tools/lib/bpf/btf.h
-   :internal:
-
-.. kernel-doc:: tools/lib/bpf/xsk.h
-   :internal:
-
-.. kernel-doc:: tools/lib/bpf/bpf_tracing.h
-   :internal:
-
-.. kernel-doc:: tools/lib/bpf/bpf_core_read.h
-   :internal:
-
-.. kernel-doc:: tools/lib/bpf/bpf_endian.h
-   :internal:
\ No newline at end of file
-- 
2.31.1

