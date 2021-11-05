Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7B0446B53
	for <lists+bpf@lfdr.de>; Sat,  6 Nov 2021 00:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhKEXpg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Nov 2021 19:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbhKEXpg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Nov 2021 19:45:36 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14887C061570
        for <bpf@vger.kernel.org>; Fri,  5 Nov 2021 16:42:56 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t11so11952029plq.11
        for <bpf@vger.kernel.org>; Fri, 05 Nov 2021 16:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y3qUN7Q6vHz1/cNFucwj2czWifJwk5nCJLMum+Tt9nQ=;
        b=i84S42fAeDPUxN30Ob/3alT0un319o3FOY9wlVB2mgyIz2Nlq8v7V6QS4/2J2DxWGi
         4Y90hgor+hVM/gnZSfc7qzOjmyY9E2i8DSvE32MbzGvKdmo9Ib3ZZOY9nn5v6WTcyU5x
         Oln8jlOg12OZxwh8onlRTc8Zy3uVdD1Qg/9ZvRwcBZgT2y22ArsleuMYaAZ0ZM7mU+C7
         tkQ5KmDvXJ+WJXWUfQI15pAlKxN3uUFr5N1xAWotRPMyiRcq57iQE5Lnlw0QM+j1UsVO
         YrroH6LKTWf3+MVt5xKqFPGjxVv/vEEqsLXl57VgYy1xJXhA3F/I8s/01ft2AEhvDIKT
         SV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y3qUN7Q6vHz1/cNFucwj2czWifJwk5nCJLMum+Tt9nQ=;
        b=w4a9WkkSyAb2YnQhBrf+ZsqkLtkyhItHjGBhcizMZKYrLrfhw+cIKd1uIgoBqu9Q4S
         4/iZC9302aBDS5ChXfL7Wm3VSELmO5vwqv7zu77uGmd0+k1zHb4+y5Wl6/R84VaOjyYT
         HaIoMUyqI6qZh/dwTiYgcfCKo2DUltOIPosF+U+yqkXq2/Vkzqc52qS5Gu5bMWgHlj7h
         3MxSaGJY9jYN6+Sb+h34+8yCev4Nfx7CX9t7ReslD26S/tHJVRO0Sr+GSytcf5ve4Xue
         TOIxsH94eQ/tfXEqUf17geiQDM+nlZB9wj3u+9xQw9j1zPsupQCWzlIDNafyOjuCj2le
         LL9g==
X-Gm-Message-State: AOAM531yVAMMO4XUrltbA9av/ZOUz9TVH7Sk0EcP0y4eLy2VrhZgqjmS
        WFGShcH3ZkIdakDvDqEdEkBJpuEmzQAzjg==
X-Google-Smtp-Source: ABdhPJyw1HiSXT8fblwbO2ljwYoClGJyFNpi3iPmh1s3zB7ikFcU4CwZWAwYu5sYsHE2sJvcvRpewg==
X-Received: by 2002:a17:902:7608:b0:141:9a53:ceff with SMTP id k8-20020a170902760800b001419a53ceffmr51718862pll.78.1636155775462;
        Fri, 05 Nov 2021 16:42:55 -0700 (PDT)
Received: from localhost ([2405:201:6014:d916:31fc:9e49:a605:b093])
        by smtp.gmail.com with ESMTPSA id f3sm159709pfg.167.2021.11.05.16.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 16:42:55 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v1 3/6] libbpf: Compile using -std=gnu89
Date:   Sat,  6 Nov 2021 05:12:40 +0530
Message-Id: <20211105234243.390179-4-memxor@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211105234243.390179-1-memxor@gmail.com>
References: <20211105234243.390179-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=709; h=from:subject; bh=kaZmcZxbO1LcThXofU2qQtWMmvcubBwOGn2qVhrVF1c=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBhhb9A+Og280rCTOInJOgGOL9xQSchgsqCp9OEIKtQ qMlwWvaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYYW/QAAKCRBM4MiGSL8RyizCD/ wMZIkm4IIXbXKE/rVVJXxtcthAT3bmCHEn1ghw2F2g4f7DmSlRN45mOCwEESHuyFTyphhgDbfhqVXS qeu9zwsXLA1MBRr/Kts+qelkve3xhJ5JBL5NhDhqW7A3XHCw7NtQULdlJJ/NvBG0HcG99IYAxWFdWl zSrPonk8ywFDrsAVLlSL53dp/oDGnrx/UjmiQVIAhk430Ie3loVNWJGD1BMC40u3OuZcgmQOl0EV4c pVhgFDI81Llk5Ju1t+a+XcezvLDhbNJUbqJEC19WMDQVYdFnogxfGjYYpCHr13omsIpi1vCdISg8GU BKLtl41ykfLYeR7UwXJLesA2B+gRWnSNd/KaYBLtgY5qiOl7b35qnjEqDmTt7azFZbPQmMAJop4y9b b4RsxXXPrZMQYrDzGb4F7YONv+wwzbryMx8u2v1rTq9AhXf9wTg6qhPigWQeMtGU/9yczxqwKi0nOa IRrMNp0wxeL8FRpYwycRIlwrABoknB+2iDDsF1Jp+/UB0viO9TIxGuXWQMNs4XoqZCWRKNQcSNamep s/V9UzzM57fqMybkmnEAhcUiK6nTMiU2dgWpCRqBWooz+cjfZ+pQcxwBPiK4Xjg9JZ622GIX+hRKYf nf/Vpzn6eJft3yx8DlaUcnlTaIUu2NZmCah8hzWnSGv8CwwIaFEgC4u7ZTig==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The minimum supported C standard version is C89, with use of GNU
extensions, hence make sure to catch any instances that would break
the build for this mode by passing -std=gnu89.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/lib/bpf/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index b393b5e82380..5f7086fae31c 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -84,6 +84,7 @@ else
 endif
 
 # Append required CFLAGS
+override CFLAGS += -std=gnu89
 override CFLAGS += $(EXTRA_WARNINGS) -Wno-switch-enum
 override CFLAGS += -Werror -Wall
 override CFLAGS += $(INCLUDES)
-- 
2.33.1

