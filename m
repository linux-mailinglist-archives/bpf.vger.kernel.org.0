Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78224779A6
	for <lists+bpf@lfdr.de>; Thu, 16 Dec 2021 17:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbhLPQuv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Dec 2021 11:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239727AbhLPQuu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Dec 2021 11:50:50 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F6BC061747
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 08:50:49 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id j9so13196062wrc.0
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 08:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pJRqVurWv/xPXVPfg9RJJPd9MELUol7kDVQDIoB29M4=;
        b=j11Nk8Sqnke5x2cKuVDNGRjjHdUv65mw61hzMSDPnxhKxKjz9QpmvRbTOAP7PT0Qj4
         lRXxMRjip+9dtbSJwULLTlpd8uQFObXQRsWQK8/SkwknGd8VnKGckm/sWIgoysHaC/Z8
         HdC4fr9IHtl+IEBfF+F9+H/3xJPYuVVbF95I7BezfRE6DXptsOftO9AhzQ6zL24dejmq
         jSJY9DN376cNEDYkyJoBYBC9NY7VYUdMQyBdZH/81RjvIU84Yl1ebNqL7SVO3KFoofjN
         8moq9RwIwng4+LkWkIyMunWctj6e/4mQi717khuAB1ziYwlG6OJGS4YONFdZQtSx0VUB
         j5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pJRqVurWv/xPXVPfg9RJJPd9MELUol7kDVQDIoB29M4=;
        b=4WmlszaWVPcw60Jgur6ewe6n2LkXXvexUFo2qTf0D1CRQbUAnuN1pygcsEPXkDqVyF
         M/d+EfGbM1x+j4HAZiOy1DEOXqsusmoPrgKOZfR75OdiePVAEZJ3k7TgphDtI/x/3jyb
         ozIjmpvETnceP6USvPu6qPmMqXHgIXuMSrDbnz3UOBZjlOZOSb9CqGrM0QU+Hsw/Nus0
         +e9cQybmui3DXC8IKXzyqOE8diAStGyJfJx1djggOhlthbmUXHz2AcNTJpAKvVy4q8B3
         CIswPEpzLn7oyeuMHcknitGRMltWq91wfzsw7eILVFwMKt/H/y7ZngWm0lqT1QjS6f9R
         pXzg==
X-Gm-Message-State: AOAM530IIop3dVvhEJ7nbrYHjCjEp0zUtIinNItlbVyTTNQF3YNuJixr
        sSDsl1VKT04iqVIFiE2GhPzhdg==
X-Google-Smtp-Source: ABdhPJxzwdAAnWi1SsHBCOcf33UW6I563gS8lB7I43K9co91J+vPwBcD4O7ZqVJpBGGrEwajiLNvbw==
X-Received: by 2002:adf:f708:: with SMTP id r8mr10213612wrp.198.1639673448266;
        Thu, 16 Dec 2021 08:50:48 -0800 (PST)
Received: from localhost.localdomain (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id y15sm7438906wry.72.2021.12.16.08.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 08:50:47 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        shuah@kernel.org, nathan@kernel.org, ndesaulniers@google.com
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        quentin@isovalent.com, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next v2 2/6] tools/resolve_btfids: Support cross-building the kernel with clang
Date:   Thu, 16 Dec 2021 16:38:39 +0000
Message-Id: <20211216163842.829836-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211216163842.829836-1-jean-philippe@linaro.org>
References: <20211216163842.829836-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The CROSS_COMPILE variable may be present during resolve_btfids build if
the kernel is being cross-built. Since resolve_btfids is always executed
on the host, we set CC to HOSTCC in order to use the host toolchain when
cross-building with GCC. But instead of a toolchain prefix, cross-build
with clang uses a "-target" parameter, which Makefile.include deduces
from the CROSS_COMPILE variable. In order to avoid cross-building
libbpf, clear CROSS_COMPILE before building resolve_btfids.

Acked-by: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 tools/bpf/resolve_btfids/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
index 751643f860b2..9ddeca947635 100644
--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -19,6 +19,7 @@ CC       = $(HOSTCC)
 LD       = $(HOSTLD)
 ARCH     = $(HOSTARCH)
 RM      ?= rm
+CROSS_COMPILE =
 
 OUTPUT ?= $(srctree)/tools/bpf/resolve_btfids/
 
-- 
2.34.1

