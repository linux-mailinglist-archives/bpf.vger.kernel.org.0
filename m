Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0B67A94FE
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2019 23:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbfIDVXL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Sep 2019 17:23:11 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34326 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730447AbfIDVXK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Sep 2019 17:23:10 -0400
Received: by mail-lj1-f194.google.com with SMTP id x18so218968ljh.1
        for <bpf@vger.kernel.org>; Wed, 04 Sep 2019 14:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iQdFKRCdsWomZgjBMZ1BG8YTrJG1Rf0I+zDwJUFyFFw=;
        b=w9EqOn0YY7I/TacD6X6Vjc8n258l7Gc09N11miWY40kBi9+VSoXN++YMfJIjBwnOgK
         U3UYsWfJKg5xSFSiqtIdn4vm09vAxP+kColVZvJOAOebO8/IuymQKm31SLCXRQOaTCD2
         RQ504SX7sSFVdtdwg/+sjWtzgKM9iIoaVLhnL6YyxtwAEBniaR7JWdJ7xfs5miGI91St
         mWtVSdMkew7dInOa2/bLuyKOckX3QvgY72z4nrryE/Ox706S8eJcxRziKI+q9XvhULll
         rTMbm4Ywygv/OTteQSOBuv5RG7t75vFyKH3z9GaYJCB4IXyIJFSFqpi4UiXk/eIRbuga
         Vn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iQdFKRCdsWomZgjBMZ1BG8YTrJG1Rf0I+zDwJUFyFFw=;
        b=aeLvxh5PW+iCL9p9MRwBVDx/qK9ygaxwqwchTE/ZOVo7pfjhFTzhnv90VWQ6oclgBC
         nSivrSSEn7RyJ4hoTpSAnGfW+amp1b4oIxMSKiGqcNEXN1zU5P8K9KuUA1w62E128F4M
         zWNtbTKpyVjq0XlI85Y1aRKRMDI/Bb1nuTlBn4bkjDYxerU0QNTsKmKppGtnV+QLIHcD
         DZ9MfivqiVTiX39WhlBi46LfAwONOQXb4UUQSmz/6Y/oHM6Ai2XT8gxJOnhK1tvZ9uMl
         22gHMaBpSFyKjnnKfRRBCSdc6BnqocggFZawn7jQHkiuvR4zT9RvHT5C8GscT+HJ5Rmm
         zqKA==
X-Gm-Message-State: APjAAAV+wPFtBWJ2udUvWSBOFYfT/n5h0Juu5AVGqvVNBoTFug/6sZ4i
        R1G9JDbd5wAe7HjBlo/mNi1ASg==
X-Google-Smtp-Source: APXvYqxxy4yL+QE93HVS8HLmjXpSQ/FFB0MC9wJrZh2UpYDEdXKZCR1E3Ex7r84PkERchX1evfSypA==
X-Received: by 2002:a2e:5358:: with SMTP id t24mr15379944ljd.209.1567632188285;
        Wed, 04 Sep 2019 14:23:08 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id s8sm3540836ljd.94.2019.09.04.14.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 14:23:07 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH bpf-next 6/8] samples: bpf: makefile: fix HDR_PROBE "echo"
Date:   Thu,  5 Sep 2019 00:22:10 +0300
Message-Id: <20190904212212.13052-7-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904212212.13052-1-ivan.khoronzhuk@linaro.org>
References: <20190904212212.13052-1-ivan.khoronzhuk@linaro.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

echo should be replaced on echo -e to handle \n correctly, but instead,
replace it on printf as some systems can't handle echo -e.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 9232efa2b1b3..043f9cc14cdd 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -208,7 +208,7 @@ endif
 
 # Don't evaluate probes and warnings if we need to run make recursively
 ifneq ($(src),)
-HDR_PROBE := $(shell echo "\#include <linux/types.h>\n struct list_head { int a; }; int main() { return 0; }" | \
+HDR_PROBE := $(shell printf "\#include <linux/types.h>\n struct list_head { int a; }; int main() { return 0; }" | \
 	$(HOSTCC) $(KBUILD_HOSTCFLAGS) -x c - -o /dev/null 2>/dev/null && \
 	echo okay)
 
-- 
2.17.1

