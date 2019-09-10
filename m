Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C13A5AE876
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2019 12:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392843AbfIJKji (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Sep 2019 06:39:38 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46587 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393848AbfIJKin (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Sep 2019 06:38:43 -0400
Received: by mail-lf1-f66.google.com with SMTP id t8so12996951lfc.13
        for <bpf@vger.kernel.org>; Tue, 10 Sep 2019 03:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HSB3pC6OCIzwVYGBAJ0R7QI4CKajD+8ovp0KUKhem8g=;
        b=BtxKUtJE9gTBoy7cQq768A85FEoTmttXAUMIXlqEYSl+FRdXX2kB5jdIbIAbVAuLka
         1fVCV27e42wBzxjb/Bhz1Gw0GCUdkfeC/sqN0we0OmZzldeKYdu/7oDDYhIOSqfPekKL
         DtzSpGrwCW9FbqNs4HCAnpo187xcVH9uoY9+8CKqcNB99tyVhAKXsK4mNdbA3YDLG/cf
         UnohngwVbieXHXNgn34avvAKimIBbSljiBS4vPo7O1JyK/LWiGdHLdDScFNNTr3o4A76
         o3YPptxKoKDvEn27JvOnnL7ymbXYrMZgR+KttC8F6NC7vu3bJXIHgLQhgZChos8nRSKs
         tuyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HSB3pC6OCIzwVYGBAJ0R7QI4CKajD+8ovp0KUKhem8g=;
        b=O9q4JL/WJhM6J99SHY98MuCc/Y5iAQyDSAPJG2KHgf2lH8RF7TmmgJTpWI2zOQLGrK
         hIiuuWuy7c+CYlOSsTNpTs2C1yCp+4vqpOuVV6LBltaDWYOFy2VTehawc3f8QjU7beWI
         zZcBQNBah8DDZ1/JdX0+razIzJBFA7UIq9XNY3gqrTDXeCtEHs+Vx8FcgWMglIAYkdp8
         YUqiQhGhE9KXuIQ0UKt/1dYPQ/wgzymgm4qHKSuHOhcYl8ffGsTGlfUav6d55x0+xC9G
         T9SId5VkL8B9jyvfv7yTS0g3cAHETuQWlZKUk5HDcDMD/dodgDanxiWlyreMsze9Cm0P
         WZ+g==
X-Gm-Message-State: APjAAAWOy6qQANdScOhojWjdE1EHiN+JqBtAiJtNvuO5DIjcK75ac27I
        5WtOajOfqCwP3BUB9MBnuMxPqg==
X-Google-Smtp-Source: APXvYqyP2wt3dd88SX1LP4al1No+BxgOchSEu2Fwn9TpSmUUc3EVd0laPnJKF+JrvyyJAnSxdzWXwA==
X-Received: by 2002:a19:4f07:: with SMTP id d7mr281498lfb.161.1568111921277;
        Tue, 10 Sep 2019 03:38:41 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id g5sm4005563lfh.2.2019.09.10.03.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 03:38:40 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH bpf-next 03/11] samples: bpf: makefile: use --target from cross-compile
Date:   Tue, 10 Sep 2019 13:38:22 +0300
Message-Id: <20190910103830.20794-4-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190910103830.20794-1-ivan.khoronzhuk@linaro.org>
References: <20190910103830.20794-1-ivan.khoronzhuk@linaro.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

For cross compiling the target triple can be inherited from
cross-compile prefix as it's done in CLANG_FLAGS from kernel makefile.
So copy-paste this decision from kernel Makefile.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 43dee90dffa4..b59e77e2250e 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -195,7 +195,7 @@ BTF_PAHOLE ?= pahole
 # Detect that we're cross compiling and use the cross compiler
 ifdef CROSS_COMPILE
 HOSTCC = $(CROSS_COMPILE)gcc
-CLANG_ARCH_ARGS = -target $(ARCH)
+CLANG_ARCH_ARGS = --target=$(notdir $(CROSS_COMPILE:%-=%))
 endif
 
 # Don't evaluate probes and warnings if we need to run make recursively
-- 
2.17.1

