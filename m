Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B893EA2BCF
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2019 02:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbfH3AvX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Aug 2019 20:51:23 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33084 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbfH3Auu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Aug 2019 20:50:50 -0400
Received: by mail-lj1-f195.google.com with SMTP id z17so4856792ljz.0
        for <bpf@vger.kernel.org>; Thu, 29 Aug 2019 17:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jGmbuQhjfybpgV20Mr6h/vZA852gJhY9ROLsc2sx8l8=;
        b=pWeUz6Fu6QfaqIpkcQ5NkN8S1IH2Rw5H5SVVq3jN6Pe8GO4Z0AVQ8kjAJ1nWq/suUY
         iy5IGz6OJY/dKJgiOzw4G0pKMu1jIKXgSEsnZrYt8T+GOll/c7PoRUL0YOgbZSy9nloJ
         xQxd5OltyxyzW8UXtE9De6EMr0kC0GBlbZxjYBn+ldgJ4QDJW8JzaEcfhzz1wiSK9Dz5
         oXvnGjkb0/kodZDij7wbzY6bjZCsk+fZ1wdt4Hs8Okzlc+qRp1IHk7T8NLEWCvIR0xTc
         MloaK1lal5Wj6DiZQlLT3eOYVu3I68zMpgnlI+8rf0f0TnmBXaCq/zCKadOxwP6syzE7
         hEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jGmbuQhjfybpgV20Mr6h/vZA852gJhY9ROLsc2sx8l8=;
        b=DQntEKL6vrtJoxnJZlG7tn/oFzmJ5ztBIhGdd7jxvXhXKUZVCyuBdLXN0XPl+I2h3Q
         GCWIocls4+BbTn8P6Qr7nfelXrIEjf/SwfLPIBugXvJtXjnudJMJnuX6cdJOp86TdpZd
         fqHoNmhBSbLshz6CDUhVkQUsJlAC5WuiPMGgdSDQ0kzWSG5VQIlwnaf00SzXMsgkGnZH
         k9Oj+Z7nXyOIJQSzRhjfhByRM6TMB/2Bxor94RZizwTV1fMNrezDID12PDX+EHpXV+P2
         i/NwKtuAk9B5mCxc4cu1F0jqAg4baUg3oEp+AosOdhhc3TDcsboIbzqZ8hCKsPgkDVzq
         FN2g==
X-Gm-Message-State: APjAAAWLlFLxIgJfoQRBamDr7926Zw6/9mfHnq2WZQjPBCPny5mhltFy
        zQVFfccC4Mv73UQ8Eri0GW9dWg==
X-Google-Smtp-Source: APXvYqzI74aR/DPSKUQJi5BEbDzth7mLHwQxtSOpKT4d/woWDnrSZxBkUNITdgyD5sT4M1zqAQ6tfw==
X-Received: by 2002:a2e:b004:: with SMTP id y4mr6683248ljk.124.1567126249466;
        Thu, 29 Aug 2019 17:50:49 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id f19sm628149lfk.43.2019.08.29.17.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 17:50:48 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     linux@armlinux.org.uk, ast@kernel.org, daniel@iogearbox.net,
        yhs@fb.com, davem@davemloft.net, jakub.kicinski@netronome.com,
        hawk@kernel.org, john.fastabend@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH RFC bpf-next 06/10] samples: bpf: makefile: fix HDR_PROBE
Date:   Fri, 30 Aug 2019 03:50:33 +0300
Message-Id: <20190830005037.24004-7-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190830005037.24004-1-ivan.khoronzhuk@linaro.org>
References: <20190830005037.24004-1-ivan.khoronzhuk@linaro.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

echo should be replace on echo -e to handle \n correctly, but instead,
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

