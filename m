Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A68BCD19D8
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2019 22:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732041AbfJIUlw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Oct 2019 16:41:52 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:34779 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731792AbfJIUlt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Oct 2019 16:41:49 -0400
Received: by mail-lj1-f182.google.com with SMTP id j19so3921822lja.1
        for <bpf@vger.kernel.org>; Wed, 09 Oct 2019 13:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZXAfjdX+WvsCZ4Putv4iaBG542bdy+GxK4sst7rF5S0=;
        b=qkf+hcumHsQI6T6Bbst2NXrX6p/4qw3OeD4CpV1jU/++8iHkhW3cMYtNH9mREMkDZY
         dw0k847/GZ3RsBrIo6fLNuSBl+IS3TYL5uYngPA39KkRaREOxcb7fn1Lm8U6nxkyVzpp
         kKHLIGY97UeNipi308i0NGdVLMg6MXgyvQFiWlqCpjL61Pk2JwLpqqKnCIr76E8QFXcx
         IIO4JkEUcrZxZ2lYIBVT9plAKyNyRif7shOotjWAv8xJ5mPhfMT+HN9YA5uN/dcMnf6o
         S/Nk38iowj23/tgkQKaz6riDTwBDoyPL2cpRnWLh++wojn81jeid5itZbrGgJocTdlw/
         9LFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZXAfjdX+WvsCZ4Putv4iaBG542bdy+GxK4sst7rF5S0=;
        b=YZX7FXy2SI4t2Kfg50DYaRlWTeICf1EaZ4/lE9iMT4UNvdUTaPHvZXNVKitRndb/1d
         Lk/LKvGFt/2N9xx8djQOVQ5ucSEoKyqUCyh+E7dW0RrXn4AlxJyEtheWfvMmfaU8imMA
         fwQjhzlKxXOJf8MlxLXTMBF+dSEmeV2hUyEXbd8T2FhNxKpLMcD/5PLSZZI+H54f7khZ
         Pw0zCfwKa0WLDYQ8A1vWJpTMup4jhc9XCjvj9q663f0zQvkda7esuWQuWWA4jmdsX/0j
         913cyi7vdESDXMeRb18xHeb1wBGqUnbtfVmiMGWKBLwJH53Tj1FVituSIuP3qDQIvOjB
         uMAg==
X-Gm-Message-State: APjAAAXf5W5fsaqSW/Q0SCXFPU63TVEQIYWxrh4iRFG6sriv1rnJslO2
        guUZuR6rvuGPJSz9dq9GwcehHQ==
X-Google-Smtp-Source: APXvYqwoQocvSjKS7oIyjB8L3ej+KEEvnlN4wQufb6MKCMSUsbLGdy/ttUAn/yRstnBBD/dxNPpWEQ==
X-Received: by 2002:a2e:89c9:: with SMTP id c9mr3470319ljk.108.1570653707934;
        Wed, 09 Oct 2019 13:41:47 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id h3sm730871ljf.12.2019.10.09.13.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 13:41:47 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        ilias.apalodimas@linaro.org, sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v4 bpf-next 06/15] samples/bpf: drop unnecessarily inclusion for bpf_load
Date:   Wed,  9 Oct 2019 23:41:25 +0300
Message-Id: <20191009204134.26960-7-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191009204134.26960-1-ivan.khoronzhuk@linaro.org>
References: <20191009204134.26960-1-ivan.khoronzhuk@linaro.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Drop inclusion for bpf_load -I$(objtree)/usr/include as it is
included for all objects anyway, with above line:
KBUILD_HOSTCFLAGS += -I$(objtree)/usr/include

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 9b33e7395eac..bb2d976e824e 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -176,7 +176,7 @@ KBUILD_HOSTCFLAGS += -I$(srctree)/tools/testing/selftests/bpf/
 KBUILD_HOSTCFLAGS += -I$(srctree)/tools/lib/ -I$(srctree)/tools/include
 KBUILD_HOSTCFLAGS += -I$(srctree)/tools/perf
 
-HOSTCFLAGS_bpf_load.o += -I$(objtree)/usr/include -Wno-unused-variable
+HOSTCFLAGS_bpf_load.o += -Wno-unused-variable
 
 KBUILD_HOSTLDLIBS		+= $(LIBBPF) -lelf
 HOSTLDLIBS_tracex4		+= -lrt
-- 
2.17.1

