Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609BB446B51
	for <lists+bpf@lfdr.de>; Sat,  6 Nov 2021 00:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbhKEXpa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Nov 2021 19:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbhKEXpa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Nov 2021 19:45:30 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35862C061570
        for <bpf@vger.kernel.org>; Fri,  5 Nov 2021 16:42:50 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k4so11996350plx.8
        for <bpf@vger.kernel.org>; Fri, 05 Nov 2021 16:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2SeNb4k/4YBOHy+QmKmFWsHUMABAVKw3pqy2CSsibyg=;
        b=RTb+HMvn9TJsr1YUYE2JlXXwXGe4eg/4o5rUYF7PRoLipqmD9Vj09LKyV4+Dw2FcGD
         4NV2/Zaxmefow+mJ32h8qzFtXAue8QLtuskZ9pjBGN2RJGYsKJEZnBI0XnbDVoN8HHWz
         dPK4bq+4ENIIsZjx0T+me8yQgTmru4fK+BKZQ61u7wHgaYQqmBomyTnMK7HbFa41n7EC
         LGyT0la3JI41CoEI6xck1JYsEOkbALjmpyyDwzoRqDgq5m3cVQPNv+FEvOshglRjwDa6
         g7+KPv5TAe2SLOxTQUAr1dloWgKE2Bu1RxIy/q6D+zoBz6RZUMsCxk2HHHRUcWlYlU+C
         hd5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2SeNb4k/4YBOHy+QmKmFWsHUMABAVKw3pqy2CSsibyg=;
        b=YjTPO1it+FSO+KGSi45ZgfzKybwIHeu4Wi89rVaVBZkcs3+Lpg6cPmsZCod2C/LfRY
         5LhOv+cT4op75osmNVoJ+MHExq9Yz3Tnimn+0Qn0aV22G1NdGmAeSuPV/LpDQqs7xcyE
         qkK2RQyrAu7oudPn603K+qAWd0fddOUSMgKIjsfCw+7CK0I3XfffwiBLYWzQBiu3DoUN
         C5FbZLfx0GHQh9wTQbSf8S8UuLosu1uzYsmVvnIEsuJ8Rs4GuTZ9MKlqKH8EQUkNCYHi
         bVVJd9WDdtm0Tcs0GYhmSWsXS0iqXMfklnH/9DQ08Wl4dRWIbXj2bUO6J44n8ul1SmSS
         y97A==
X-Gm-Message-State: AOAM532nMxC/Hna3NfOFvuSma9KaDLPapCeQOrvNnTQ4FajqPTLi3Yvk
        3tUtmI5tB+oH355sZs4lmOHeE8rXMSRTww==
X-Google-Smtp-Source: ABdhPJxfFyHCwOgLCjR+h9YvX+HkPkO71AEO1+MdYKnmuxf9kB/1Pq8On3wByCeURoBZgfPUGv0lSg==
X-Received: by 2002:a17:90a:f182:: with SMTP id bv2mr33476840pjb.139.1636155769616;
        Fri, 05 Nov 2021 16:42:49 -0700 (PDT)
Received: from localhost ([2405:201:6014:d916:31fc:9e49:a605:b093])
        by smtp.gmail.com with ESMTPSA id 13sm7049194pjb.37.2021.11.05.16.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 16:42:49 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v1 1/6] bpftool: Compile using -std=gnu89
Date:   Sat,  6 Nov 2021 05:12:38 +0530
Message-Id: <20211105234243.390179-2-memxor@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211105234243.390179-1-memxor@gmail.com>
References: <20211105234243.390179-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=951; h=from:subject; bh=jjqhhJOqHI+re0/7VdKKBPTosygXpRDE9rJeGfUMKDQ=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBhhb9ASpPKhiRKyyov0zVlIXE0XesQ14LJiV0/D8z1 JW8ivfiJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYYW/QAAKCRBM4MiGSL8RymwiD/ 9gXKNswoGtVQjUDtadPcx/VF1ul0lHIaa4IjRDNhKrs/Ia3PMfqya+8ysI1dfDPgdhm80chiG8mU+n cInmpSyKsOro+GachfOctd9pG9BwO+gXwZu5DyWZeocAA/t9YYV/ZEraVs1k0icZHWZFxh/usx2cUz KBJ/Hdi8QTn6Z7aMM5Tv8uieb4QgMT0t7qrapYdXbGGD2laWZ9bVFsl6LU+RMnAVn1JF055wUAfI2Q PwnwZAApESUd87yVCJYmTaSsFYM/f4+aEb+cOaQpnEmdi9iwCPC+hLFDFhnirkTRErcaGxYRae64dx SWIHpt7noCgMu65idV/wwdtqh0Ay8BG78tjk0V2dTW+xRFGmdLPPTdwMSYaD5gg+aYP/J2oGRdL21M 72XXwTl210KYCCha3MNSufYYIUojl5NToMSQrZUOHn2kVw7cAb4fi597eSk1stN8yCrO2F4jvmAE56 NS38/TRVDWN15xpL1KbxN03pug5oNbXCoqERYGTHBUNQYviZmgaSZDSj5e2eyejzK3B5FxmhmIfjp0 CPbmnviVdUzX2UcCRfvg9zW5lXKKRBjxxJOQEbE5RJfkNRIKiwKA1E3Z3qKXvI3BAdTxj87pGcbYft BRiDMFojQ3LBo7QE/GYVQPVNoHg6iaiizFwwpK0B2U/GED4iXcVp7TdiNw3A==
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
 tools/bpf/bpftool/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index c0c30e56988f..71a7b7194c2c 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -65,7 +65,7 @@ $(LIBBPF_BOOTSTRAP)-clean: FORCE | $(LIBBPF_BOOTSTRAP_OUTPUT)
 prefix ?= /usr/local
 bash_compdir ?= /usr/share/bash-completion/completions
 
-CFLAGS += -O2
+CFLAGS += -std=gnu89 -O2
 CFLAGS += -W -Wall -Wextra -Wno-unused-parameter -Wno-missing-field-initializers
 CFLAGS += $(filter-out -Wswitch-enum -Wnested-externs,$(EXTRA_WARNINGS))
 CFLAGS += -DPACKAGE='"bpftool"' -D__EXPORTED_HEADERS__ \
-- 
2.33.1

