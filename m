Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869302DBE32
	for <lists+bpf@lfdr.de>; Wed, 16 Dec 2020 11:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgLPKEC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Dec 2020 05:04:02 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:33886 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgLPKEC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Dec 2020 05:04:02 -0500
Received: by mail-wr1-f52.google.com with SMTP id q18so15053994wrn.1;
        Wed, 16 Dec 2020 02:03:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g/Wzze2NIBSL2f+axZbs4XLUQ1J8xddIwrjpMIqAZg4=;
        b=cIRHMR4dUG/P9eO9xLSPSVyn8HTLp+ZI3PNSp6iLmjMppC3QhhzrCZWmiWL8rDqbXj
         xEvZIG0KIuTM0IzLPel7d+DAmMxojl4cFhtVhQ+zF0PGDq1lNiCDYRlsFrczY+eQSwWl
         smBwgiQur6rf3lPjTOaVBOPaw0RIwZEg+3j+MLw1E6zfVBwpGRYgMsSTJDUkufOg5Lrs
         /0rnepa8qMdP+yC2fUbHQLWoOIMbHYK9Z15g4kLXHcgeMR3c2HJBge9NxpNME/viBsPv
         YUk+o2EEzlTgc74UFA7aT+qdqr/vCbAgKzrKqCt1tRTZU8vbPV6V4j8Rg5PGWOq20HGf
         qF/w==
X-Gm-Message-State: AOAM531OmE3nosSnBWy8v9gdKL5dcYlvIW5K7/GALkoYVE1+H+YxXeD5
        6QK1w8Guo5R1kJ8Cvuk3v5yPBRHz5uWxcQ==
X-Google-Smtp-Source: ABdhPJxD1ueQpGR9/wck7OlgddXafTJE+ngtoIBX1JQ9dKcH54wv9WbaRfgT0MlTBjsXepkMheXDQQ==
X-Received: by 2002:adf:eb07:: with SMTP id s7mr37381501wrn.414.1608113000866;
        Wed, 16 Dec 2020 02:03:20 -0800 (PST)
Received: from rhea.home.vuxu.org ([2a01:4f8:c010:17cd:6824:5476:f6ff:db68])
        by smtp.gmail.com with ESMTPSA id l7sm2106047wme.4.2020.12.16.02.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 02:03:19 -0800 (PST)
Received: from localhost (rhea.home.vuxu.org [local])
        by rhea.home.vuxu.org (OpenSMTPD) with ESMTPA id 876ad974;
        Wed, 16 Dec 2020 10:03:17 +0000 (UTC)
From:   Leah Neukirchen <leah@vuxu.org>
To:     bpf@vger.kernel.org
Cc:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, leah@vuxu.org
Subject: [PATCH] bpf: Remove unnecessary <argp.h> include from preload/iterators
Date:   Wed, 16 Dec 2020 11:03:06 +0100
Message-Id: <20201216100306.30942-1-leah@vuxu.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This program does not use argp (which is a glibcism).
Instead include <errno.h> directly, which was pulled in by <argp.h>.

Signed-off-by: Leah Neukirchen <leah@vuxu.org>
---
 kernel/bpf/preload/iterators/iterators.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/preload/iterators/iterators.c b/kernel/bpf/preload/iterators/iterators.c
index b7ff8793917..5d872a70547 100644
--- a/kernel/bpf/preload/iterators/iterators.c
+++ b/kernel/bpf/preload/iterators/iterators.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
-#include <argp.h>
+#include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-- 
2.29.2

