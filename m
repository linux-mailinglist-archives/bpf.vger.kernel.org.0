Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D63444C048
	for <lists+bpf@lfdr.de>; Wed, 10 Nov 2021 12:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhKJLt0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Nov 2021 06:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbhKJLtZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Nov 2021 06:49:25 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3748EC061764
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 03:46:38 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id n29so3464350wra.11
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 03:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P1MDAXqBUvRJAO6xX7CxMMNI+Qac5fxw54rz9pUhfVg=;
        b=Waqi7E8BLBXjAbSCNLrpy/QjzH1mUJi3N0z8KUKzealmkdypPGa1wtdTf8qmF0MmP7
         yOAFklIeu5pkqc9e2svZca+riQZf7/V4NcIYUag+jh7SGHxCV3iH+GlOjG1OETK/oIb+
         gaRCcmgeGBrhxUu6zQScXIy61b3bi/6g+3e2T7gEOSxgwo8oh0uO0Q+hWRgTHTSWVzUl
         X5B7k2smSMFrqIvIk7MzvP0I6NxNllmJur3Qg922yFLPpImmMsfrZWwDRnoWDXVBilgL
         IiCQyANraaB9poiQdtl0wDsrKbwhU3iGW2HSdijUer/TCNmmi3kSqNI+tPx/IZVjCgBR
         jJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P1MDAXqBUvRJAO6xX7CxMMNI+Qac5fxw54rz9pUhfVg=;
        b=liyM8KK+Q54P8+To+HYXubw+mk0mixUg+EHFvj5SIv8/7o1sdDrDRn7pZFI5dAYb+z
         2EpD9FQyVCn6q8lYA3SzZkJ74y632S3v9l29rzloP5k+8KDbZOqtpybr5oIyrB2HqAQF
         Z3zpchCxoSCFT4Z/GXR7PpbEBpyskP1YngGI4cjKu6eOaL62qyH2X7WnY7x1jaXN8/LT
         daRzjXEJxF6lmIwkbt1pzf4sVO53IUkxGxLgFrZIl97XdQJCj5Yu6yrIs/sbDLzFbEKa
         y/uSgEg6TCbK5T2R7abB0oPRp4TSyJ+ao6oj+paUnSZ/YJgczN6tIumAU/tmmrct6u5F
         cMbQ==
X-Gm-Message-State: AOAM5310ch0wAKrgBoulmbbaxNtMTGIkZ0B02ZY4/kGNV2ZCZTyrzwpZ
        R5BIRQ5+4i+hDmsIU4A6uAqzVQ==
X-Google-Smtp-Source: ABdhPJw5T27/A7hBYtGaWe4tAQY+JwONJqYBBWhWVyo7CT0DHN22IUT0sj3hZH856ktz3z+wMFpfCg==
X-Received: by 2002:adf:fc88:: with SMTP id g8mr19361660wrr.334.1636544796828;
        Wed, 10 Nov 2021 03:46:36 -0800 (PST)
Received: from localhost.localdomain ([149.86.79.190])
        by smtp.gmail.com with ESMTPSA id i15sm6241152wmq.18.2021.11.10.03.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 03:46:36 -0800 (PST)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 2/6] bpftool: Remove inclusion of utilities.mak from Makefiles
Date:   Wed, 10 Nov 2021 11:46:28 +0000
Message-Id: <20211110114632.24537-3-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211110114632.24537-1-quentin@isovalent.com>
References: <20211110114632.24537-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bpftool's Makefile, and the Makefile for its documentation, both include
scripts/utilities.mak, but they use none of the items defined in this
file. Remove the includes.

Fixes: 71bb428fe2c1 ("tools: bpf: add bpftool")
Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/Documentation/Makefile | 1 -
 tools/bpf/bpftool/Makefile               | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/Makefile b/tools/bpf/bpftool/Documentation/Makefile
index c49487905ceb..f89929c7038d 100644
--- a/tools/bpf/bpftool/Documentation/Makefile
+++ b/tools/bpf/bpftool/Documentation/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 include ../../../scripts/Makefile.include
-include ../../../scripts/utilities.mak
 
 INSTALL ?= install
 RM ?= rm -f
diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index c0c30e56988f..2a846cb92120 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 include ../../scripts/Makefile.include
-include ../../scripts/utilities.mak
 
 ifeq ($(srctree),)
 srctree := $(patsubst %/,%,$(dir $(CURDIR)))
-- 
2.32.0

