Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76381140F63
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2020 17:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbgAQQyO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Jan 2020 11:54:14 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:42177 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgAQQyO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Jan 2020 11:54:14 -0500
Received: by mail-io1-f67.google.com with SMTP id n11so26709757iom.9
        for <bpf@vger.kernel.org>; Fri, 17 Jan 2020 08:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uFIUVKsz4aPMvzp5H7zdGJcmUXpH7dHc5gmMJqmLGlg=;
        b=Ju3I1Jfs9dGT84Iy5fhqRFLUVMNJ2DaIdE+XAgBGJVq2WI7cBhYBPlKCVOfqs4VjMZ
         5ICq/oE45Eg7QmU2ztU/ugOzLpOvQ2sTLgH4W6CEG5igTtgl1kKoVhX3J3f1sfZ7fO+I
         JlYaxN8NlIaKixzCZBXnSUCbPBdtD6QReoBvllPp/KtRlRs4nS+7Hm4udEoIrUm8C0m7
         Bv5BGlkrns50GvcaB7Bf+XmCIptl1fNUe3m5b7HoaXRW5F86S/8vnDbb3AuiE2juhPi+
         5AJL6a9LVL5rapntmvKmiWEqM1aM55VyhUm/u1S9BHEP0VaaVuXAx4M5wkLazCr15Z/M
         67ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uFIUVKsz4aPMvzp5H7zdGJcmUXpH7dHc5gmMJqmLGlg=;
        b=iUpI3OdN7UyBTHeBcrvFDqOCYDlf9URASVX/Gq7DBkb/HRY2/Oh1gCxEsHaikzJtGA
         sqE0UXdKL0oP7jozEKZNUQc4qmdvMct6wN78Mt8Of6gqvZ4zB/jeqXTH/mEToc7r6vKj
         ibhL2Qf+BXCnMKfgdN5xJEfx1RuhESky4RPgwEgRYqILAzRcQZDULMlGbejq5S0zb/nD
         Zua6pOUt26E9prmO0sRSMsryUHwYlCsDqhYVKgJEcKusPHDweS9cX0h5R+xNnsfveaYU
         l+ZaVZKZgJTYNl9y4CuOxD7lRmgFJ50wb6J6nJk8jjLRG3AzTx5PIyp2lIpJ/Ds7VLj/
         DyFg==
X-Gm-Message-State: APjAAAXdOaNhfBb3IAdL7DbvNHkJwlMu6ER8DL+zcYbYmRU+w58z0dcs
        ghRqmN80y7egV2rWM2a1e1+enQ==
X-Google-Smtp-Source: APXvYqyb7lB/rV1ivpPHirD+5CsQ4f/jRvFS49kUJduVxa9UCt1nkgGP/tUwxXBNpRlOKcvyPaLpjg==
X-Received: by 2002:a5e:9748:: with SMTP id h8mr23496836ioq.121.1579280053465;
        Fri, 17 Jan 2020 08:54:13 -0800 (PST)
Received: from alago.cortijodelrio.net (CableLink-189-219-74-147.Hosts.InterCable.net. [189.219.74.147])
        by smtp.googlemail.com with ESMTPSA id f16sm8120662ilq.16.2020.01.17.08.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 08:54:12 -0800 (PST)
From:   =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>
To:     shuah@kernel.org
Cc:     =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        netdev@vger.kernel.org (open list:BPF (Safe dynamic programs and tools)),
        bpf@vger.kernel.org (open list:BPF (Safe dynamic programs and tools)),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] selftests/bpf: Build urandom_read with LDFLAGS and LDLIBS
Date:   Fri, 17 Jan 2020 10:53:28 -0600
Message-Id: <20200117165330.17015-3-daniel.diaz@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200117165330.17015-1-daniel.diaz@linaro.org>
References: <20200117165330.17015-1-daniel.diaz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

During cross-compilation, it was discovered that LDFLAGS and
LDLIBS were not being used while building binaries, leading
to defaults which were not necessarily correct.

OpenEmbedded reported this kind of problem:
  ERROR: QA Issue: No GNU_HASH in the ELF binary [...], didn't pass LDFLAGS?

Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index e2fd6f8d579c..f1740113d5dc 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -88,7 +88,7 @@ $(notdir $(TEST_GEN_PROGS)						\
 	 $(TEST_CUSTOM_PROGS)): %: $(OUTPUT)/% ;
 
 $(OUTPUT)/urandom_read: urandom_read.c
-	$(CC) -o $@ $< -Wl,--build-id
+	$(CC) $(LDFLAGS) -o $@ $< $(LDLIBS) -Wl,--build-id
 
 $(OUTPUT)/test_stub.o: test_stub.c
 	$(CC) -c $(CFLAGS) -o $@ $<
-- 
2.20.1

