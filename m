Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFB5FA2BD9
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2019 02:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfH3Aus (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Aug 2019 20:50:48 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39190 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727521AbfH3Auq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Aug 2019 20:50:46 -0400
Received: by mail-lj1-f194.google.com with SMTP id x4so4815895ljj.6
        for <bpf@vger.kernel.org>; Thu, 29 Aug 2019 17:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LKaVdiULHZHeM3qmwqXGbS3W/6JSevNYH66TL2VqMJs=;
        b=FCvja2RR0Kl7bYsDQOOUQUjMRFvKXGR7eNe2NgdFDmbxw/n8dJHTjUoGSI+mau6Y+4
         Nur0MR6ogMXxJ5zfyi7m9Wy9jxTs0li83IAoNnO3od01GnS9Hqlng6pvxCjHf6xEnMyr
         augAVWdm8PjLCzmGgLHygy3NIRgFB7JySVZRBQN0s3ZKjzbUAEdFIJqIzM5lHjreRvGG
         snI7tdFTUKcqaa8IwauSlZkbGJE8QEkzS8ZNg5oOiKBIMrKDtwadtIdeZ6JwNYKeJIn3
         tKv1ox5CdWMtkIaJu0sJl+tRU4qXmxLrhXLswctpqbwRgon6CnOE9jLR+4q5IXCY6JhA
         KYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LKaVdiULHZHeM3qmwqXGbS3W/6JSevNYH66TL2VqMJs=;
        b=ms2i+vdG4cQO6cX3AQ3MxRQpCxYECfw/Tne8nsgKMs1stz0gOvBy9zhat65py2gDIf
         u+T3EH0PFuwIW3hgZOO33oaqFY0smSHOhLfOL9xFl0YmHQhwPGhbNER+yeuEmwvZazHA
         RV1I8aSy+lMsCqXYYoH49Ph3V6eeirBC+h/iWGmmv5Xpzf7xDnrVry9Jh5Y6d2Qka1DS
         CbjUaH/2Bn+yNL9bYBzFoJPplXvl63LCH3rndE8Dl69wtmBazR2UrdLiPB8g4I6yX1T5
         VS2XjBTGle8a7BGao/fIFr+V0GXIH9vYxIodOoDOFghJn7RChE3oHLUEmjcBJU6DzjOA
         /4zA==
X-Gm-Message-State: APjAAAXF2dmcXWE+fp0Rr2tCyDhQYOdFbYb4ghtvyHv8zfteqh70uBIJ
        i7CKYm/P3KtXdtpq2ODqK3lO83hW57w=
X-Google-Smtp-Source: APXvYqwr9VPhPuNlVvj3eJbScYt62A3rntuEmrXbOlRiE2Zq78tGV5NynWDZnJoUv/97mud2fxSftg==
X-Received: by 2002:a2e:970e:: with SMTP id r14mr6839936lji.204.1567126244471;
        Thu, 29 Aug 2019 17:50:44 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id f19sm628149lfk.43.2019.08.29.17.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 17:50:43 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     linux@armlinux.org.uk, ast@kernel.org, daniel@iogearbox.net,
        yhs@fb.com, davem@davemloft.net, jakub.kicinski@netronome.com,
        hawk@kernel.org, john.fastabend@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH RFC bpf-next 02/10] samples: bpf: Makefile: remove target for native build
Date:   Fri, 30 Aug 2019 03:50:29 +0300
Message-Id: <20190830005037.24004-3-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190830005037.24004-1-ivan.khoronzhuk@linaro.org>
References: <20190830005037.24004-1-ivan.khoronzhuk@linaro.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

No need to set --target for native build, at least for arm, the
default target will be used anyway. In case of arm, for at least
clang 5 - 10 it causes error like:

clang: warning: unknown platform, assuming -mfloat-abi=soft
LLVM ERROR: Unsupported calling convention
make[2]: *** [/home/root/snapshot/samples/bpf/Makefile:299:
/home/root/snapshot/samples/bpf/sockex1_kern.o] Error 1

To make the platform to be known, only set to real triple helps:
--target=arm-linux-gnueabihf
or just drop the target key to use default one. Decision to just drop
it and thus default target will be used, looks better.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 61b7394b811e..a2953357927e 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -197,8 +197,6 @@ BTF_PAHOLE ?= pahole
 ifdef CROSS_COMPILE
 HOSTCC = $(CROSS_COMPILE)gcc
 CLANG_ARCH_ARGS = --target=$(notdir $(CROSS_COMPILE:%-=%))
-else
-CLANG_ARCH_ARGS = -target $(ARCH)
 endif
 
 # Don't evaluate probes and warnings if we need to run make recursively
-- 
2.17.1

