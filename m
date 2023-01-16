Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E7666B56C
	for <lists+bpf@lfdr.de>; Mon, 16 Jan 2023 02:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbjAPB5f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 15 Jan 2023 20:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjAPB5N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 15 Jan 2023 20:57:13 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F89344A5
        for <bpf@vger.kernel.org>; Sun, 15 Jan 2023 17:56:47 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id s26so5212262ioa.11
        for <bpf@vger.kernel.org>; Sun, 15 Jan 2023 17:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ds1r+KmmHUgCF5Hl8qXNdg2lKbwGSUuWakRsXxC3TxU=;
        b=kjVGXCv+943HB8tOVSU8hXn3TcAIe2s88tz9mZbPRYZEwK+uKhVBFGsq+rE1fFhQ8c
         KlgPK/D6UnFK8EK2PfVwevi2869MCRmAl9E+FlgDMllF8aO0oyxYWcoAV1567xITB5zl
         bl7uZfL3yRRFJplzAeq/zBIYebMxbuAAujbbVVYaakD8lBw4fWNybBg+xtZjotEbdkZx
         vMz1LoVpP/7+uE/ohUALa04nn4oQBKa2HSOjp0nHf48c8jxTEiNweUDTshHOHURwXkvW
         9/sRSCTfEJbeF8qVlHoPOYy/yAABsjDBby0jmrO10ZfBEOw/qlRrs6DYfsPkPdNMLbAl
         1cVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ds1r+KmmHUgCF5Hl8qXNdg2lKbwGSUuWakRsXxC3TxU=;
        b=d9bjIoHSsocd6vU7KeF+KNMmjvTUnltgNW6ULrFbiv1tEh9MnXPNSHqm7Ypo8Jykp9
         VmviQ5eTstWpuBAex30DuSTkb4ueu+lBW3qxwrWNhxj86YzJ07YEJ+0u2exPMz9pobeL
         aXKVlCzJY+x2mXSVL7mj/3aPuP6PzmrL8ACkL+ZPfdJUy4UKkkXgRHgXH8z7+O36Aq/u
         bpyWGDvewQ1d1Rpb7+z2m3kIZn+n9BFojMy2El6RRTc6UE/pVf7/hw4GnXM0DgBTILcM
         Ci4Xm8Kj44BFZHpZ4GHQbJaRmTg5Ys8pW2UMBWgeaWI4+mvm7mPi15e6pgbHHSHcn6X8
         fNZQ==
X-Gm-Message-State: AFqh2kq3mnFB+HDebpVNzpOwiQGGNKPsRpjmcqMxr2lRiofJtjLzVAOH
        EiB3t9197vUhd+sVSM0thSbdEx7KjYk=
X-Google-Smtp-Source: AMrXdXvb2LUVzFm7g3XWWospjGiJRhgUz38rRlnyIx6SDmdnz0iUEFbSkGggajy5m5Zl1GzG50GHUg==
X-Received: by 2002:a6b:b7c2:0:b0:704:87dc:5b1f with SMTP id h185-20020a6bb7c2000000b0070487dc5b1fmr7438152iof.13.1673834206658;
        Sun, 15 Jan 2023 17:56:46 -0800 (PST)
Received: from thinkpad.. ([207.107.159.62])
        by smtp.gmail.com with ESMTPSA id i5-20020a02c605000000b003a4cb0863besm598583jan.60.2023.01.15.17.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 17:56:45 -0800 (PST)
From:   Roberto Valenzuela <valenzuelarober@gmail.com>
To:     andrii@kernel.org, mykolal@fb.com
Cc:     Roberto Valenzuela <valenzuelarober@gmail.com>, shuah@kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH] selftests/bpf: add missing SPDX license headers
Date:   Sun, 15 Jan 2023 20:56:23 -0500
Message-Id: <20230116015623.123395-1-valenzuelarober@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add the missing "SDPX-License-Identifier" license header
to the test_verifier_log.c and urandom_read.c.

These changes will resolve the following checkpatch.pl
script warning:

WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
Signed-off-by: Roberto Valenzuela <valenzuelarober@gmail.com>
---
 tools/testing/selftests/bpf/test_verifier_log.c | 2 ++
 tools/testing/selftests/bpf/urandom_read.c      | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_verifier_log.c b/tools/testing/selftests/bpf/test_verifier_log.c
index 70feda97cee5..efee9bc3e9b4 100644
--- a/tools/testing/selftests/bpf/test_verifier_log.c
+++ b/tools/testing/selftests/bpf/test_verifier_log.c
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
 #include <errno.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/bpf/urandom_read.c b/tools/testing/selftests/bpf/urandom_read.c
index e92644d0fa75..f019a6cdb536 100644
--- a/tools/testing/selftests/bpf/urandom_read.c
+++ b/tools/testing/selftests/bpf/urandom_read.c
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
 #include <stdbool.h>
 #include <stdio.h>
 #include <unistd.h>
-- 
2.34.1

