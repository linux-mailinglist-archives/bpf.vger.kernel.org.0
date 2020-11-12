Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2862B01CF
	for <lists+bpf@lfdr.de>; Thu, 12 Nov 2020 10:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgKLJMg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Nov 2020 04:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbgKLJMf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Nov 2020 04:12:35 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04C8C0613D1
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2020 01:12:34 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id d142so4567927wmd.4
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2020 01:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wrdXvSmyLYGyjM8h8f5iEdTxEAMQIb+aCyxv+fa4Wno=;
        b=YN696fptFxcEcS3No1Ibw6Pn7hOsqnV3QtJi9eQVTmTbGoTjXOZlIQlPlYzfUZ/L98
         RmEvLR44j9M5C4PUc/pxSZVyIjAlG+ZKS3jhtNsMlzOUgHZVA/i9LBn3Mx5YNHwIdUsi
         qWQIyR1LGRPdc8fCki14bK0JNleiz3/3V6HfYtYII7D75o0Fx4+GFS0ru1DomJ10epSF
         2Ty0/BcjNkKYtRA13y0XAjYbkrEaiCM/jrjDa+yASYFRenB5YKXJzKIdsCMxABvtrUWv
         /FS33r3RtTDxFpoBrUmZEXg5PcRs3u5nSNSltlWf+OK4B1H9hjQZdxeUn5hP0UiJ2Itf
         C4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wrdXvSmyLYGyjM8h8f5iEdTxEAMQIb+aCyxv+fa4Wno=;
        b=qhh8+aykjZ8aWwLef/2o4k6u0mZ3IBB/OqXrL93toJCnpRzH4QowDUv3C3kNdOnhTf
         4ZQ4HRqhZZJABJkZHEtcG2DfE5hz10DFfB7sxZcbQMt78MUuk1/63Q5EzHCPabvYOFoM
         LSjIrXdnz73r9c+CWYxJfT6XQi6lgf7zt6ohR1TIBBCtxqzm60Vfjt06sUGL4KR7LATy
         VQsFSBZgfxNyHqCp+QVRkmdsfck2aGckASP1KwFUF0Fsqo+IlEfxXfBWdJU6y0w2+xMc
         30bjxDaFmgr4pgf5gc0/9kDQO37+J/4QGgBJafAq8M1DO8ddFFwp/g9c1WPxASi4DKwa
         WrWg==
X-Gm-Message-State: AOAM530Zt0iRqOXb+pqHB+W6S41ai1HCxAj8lztri9AF+QO303gIIvyG
        hAALSgFpkF9UPSQyivG8ujAnEw==
X-Google-Smtp-Source: ABdhPJysMFIPCxWHHEuIFyOE14bu5Tt1jO8eM1ng4XTz/lsXX4UpPucVUhJPw+LPSsHzI91UXMAlnw==
X-Received: by 2002:a1c:7418:: with SMTP id p24mr8372233wmc.36.1605172353374;
        Thu, 12 Nov 2020 01:12:33 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id p4sm5945118wrm.51.2020.11.12.01.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 01:12:32 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     andrii@kernel.org
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next 1/2] tools/bpf: Add bootstrap/ to .gitignore
Date:   Thu, 12 Nov 2020 10:10:50 +0100
Message-Id: <20201112091049.3159055-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 8859b0da5aac ("tools/bpftool: Fix cross-build") added a
build-time bootstrap/ directory for bpftool, and removed
bpftool-bootstrap. Update .gitignore accordingly.

Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
See https://lore.kernel.org/bpf/CAEf4BzbYcgzbrwS2uH0NDa+0O48BUXvZ0ySV+xcw6-inrro-UA@mail.gmail.com/
---
 tools/bpf/bpftool/.gitignore | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/.gitignore b/tools/bpf/bpftool/.gitignore
index 3e601bcfd461..944cb4b7c95d 100644
--- a/tools/bpf/bpftool/.gitignore
+++ b/tools/bpf/bpftool/.gitignore
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 *.d
-/bpftool-bootstrap
+/bootstrap/
 /bpftool
 bpftool*.8
 bpf-helpers.*
-- 
2.29.1

