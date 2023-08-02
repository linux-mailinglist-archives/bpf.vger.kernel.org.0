Return-Path: <bpf+bounces-6690-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6AE76C7EB
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 10:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24808281D1D
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 08:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41FC53B2;
	Wed,  2 Aug 2023 08:05:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05E653A6
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 08:05:46 +0000 (UTC)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0103AC
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 01:05:44 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-4053d203c07so13062741cf.0
        for <bpf@vger.kernel.org>; Wed, 02 Aug 2023 01:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690963544; x=1691568344;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Qus0rMPZusRp3DkpBIap3bybcHsqs5bqRXlvNt8egpE=;
        b=W9ySPQa5meTVUGyIY3ARJsDY4OGW0wWBxw87LsLtAygbBLrLQ+RvomgwnGpC560qbM
         5giv6S5d3J5e31eLcHk2hM4/s4PdS3K1WCuPL3tIUkdGKBvLT9wa49uN2iLV0MYJ2KG9
         hGtrEAl/RIiUrQUatUvdRYCxyTd4xRSIjAofk3cTnO4+l7nXi60V0eTiV3Oo5cjh85gT
         eOeSQ5yPbwkId1Z97PY6EJ51VCPryzpcd/HJQC22n02NyBUsvfVBkg2fNl7IpszSPGKp
         WboWYjFzbAUQi6FltIK+5eTjgqVAR1cpCJMbP9Rz8WEEOFENZl8Vu7fPtHixOJC38k8a
         U5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690963544; x=1691568344;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qus0rMPZusRp3DkpBIap3bybcHsqs5bqRXlvNt8egpE=;
        b=XHBkieJU+MLTqZKYlruW1ExdkYPIqv4SGnXKCqiSy+Hgfne+Cov1DinRKmklWnAz7w
         6R1vspdz/7pTswOWThaYcPJZGBoBVQj2MViISTUsq+Zgpe2FW4qn8c1mYi1GUdrw2FLk
         XOTuywrkEcoGkndUYxKu0pqiD9ageUDzuqDBpP5GPpK14sBWcI0ICaay/ujamfnpI9Gf
         OAa/tADD7AOF8G3r/CmTfhcIrN3MVrGPOsvqDI3kK2i983IFk3iwCmyDS2wirLfht7RR
         VwgH5WGSjnr7fzYDPc2ibITa+rdQefbJ6WLKkHvh6KTMXsby8gQ9weGOYE8HMgug4fZf
         oCSg==
X-Gm-Message-State: ABy/qLb93GbHBE56kdE1h+pIxw6dVSEv3qWm6veDWJEHOtdJ/1Zu8CLg
	tIK/0CNpgy6j75fYpwn2i/M0moPFnsQZ5PE/pgPieDlYqX0=
X-Google-Smtp-Source: APBJJlG+uMpunrqvepKocBA5RmbWGy7J9u2mctNIHVDwq2VtuFq1iv2g92Ycnvf/lN7q6OndYMolmoVsrHHMlhqJjNw=
X-Received: by 2002:ac8:7d90:0:b0:40a:6359:2120 with SMTP id
 c16-20020ac87d90000000b0040a63592120mr15351155qtd.0.1690963543632; Wed, 02
 Aug 2023 01:05:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sergey Kacheev <s.kacheev@gmail.com>
Date: Wed, 2 Aug 2023 11:05:32 +0300
Message-ID: <CAJVhQqW6nvWFozMOVQ=_sUTRwVjsQL+G2yCyd91c0bjsc7PcGA@mail.gmail.com>
Subject: [PATCH v2 bpf-next] libbpf: Use local includes inside the library
To: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch makes it possible to import the header files of the bpf
part directly from the source tree.

Signed-off-by: Sergey Kacheev <s.kacheev@gmail.com>
---
Changes from v1:
- Replaced the patch for github/libpf with a patch for bpf-next Linux
source tree
Reference:
- v1: https://lore.kernel.org/bpf/CAJVhQqXomJeO_23DqNWO9KUU-+pwVFoae0Xj=8uH2V=N0mOUSg@mail.gmail.com/
---
 tools/lib/bpf/bpf_tracing.h | 2 +-
 tools/lib/bpf/usdt.bpf.h    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index be076a404..3803479db 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -2,7 +2,7 @@
 #ifndef __BPF_TRACING_H__
 #define __BPF_TRACING_H__

-#include <bpf/bpf_helpers.h>
+#include "bpf_helpers.h"

 /* Scan the ARCH passed in from ARCH env variable (see Makefile) */
 #if defined(__TARGET_ARCH_x86)
diff --git a/tools/lib/bpf/usdt.bpf.h b/tools/lib/bpf/usdt.bpf.h
index 0bd4c135a..f6763300b 100644
--- a/tools/lib/bpf/usdt.bpf.h
+++ b/tools/lib/bpf/usdt.bpf.h
@@ -4,8 +4,8 @@
 #define __USDT_BPF_H__

 #include <linux/errno.h>
-#include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
+#include "bpf_helpers.h"
+#include "bpf_tracing.h"

 /* Below types and maps are internal implementation details of libbpf's USDT
  * support and are subjects to change. Also, bpf_usdt_xxx() API helpers should
--
2.39.2

