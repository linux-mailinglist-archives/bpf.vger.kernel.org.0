Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C103369E78
	for <lists+bpf@lfdr.de>; Sat, 24 Apr 2021 04:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbhDXCNI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Apr 2021 22:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbhDXCNH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Apr 2021 22:13:07 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A156BC061574;
        Fri, 23 Apr 2021 19:12:29 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id lr7so7871470pjb.2;
        Fri, 23 Apr 2021 19:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5E+FauaBN+WPrBc1GDMP2MArFJ6JUGv4pjzyyuwtNBQ=;
        b=PNplL1rXFigsbfDoZpb9ErxFVBZFMa90RlV5eCI0A39F2/PlZEVnBG2+udIeOel6OT
         NiCRUpUUlgNpO7CQxC8sovojQdC8t9kOAXLM3c0IYloVcl6esUsIADKZfFrazYzRBaHo
         Q+SIp4FSWwCGIMWjdKhCDbQjRpoe+hQlBOGnAJjhPvv1hWYI9/bAYyk15LROhA4mOwzz
         yzUN5DYrMkY7WIFM+SdEjJdR4S0/8jJEt0eZsbqzHypK70Kt4HOeF3DFREhy/+INBBhk
         eyD70wZmxGtzPJPbu0KG5tGa1jInLMNthFkKLPBhApx5unrbAUAVAC9PR+DciMYZf4w7
         7MFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5E+FauaBN+WPrBc1GDMP2MArFJ6JUGv4pjzyyuwtNBQ=;
        b=k6ohxc4E4faJ0O5BETulm4y9MGm9r3ZqTB9ffjWStn0orTUPxVTM0R+/HJuYdYC+ER
         G32kSB8p42C//IdVQ0mVJv2OEkKcs0DQWhQXuKDHNaasK01eIKH3qZKXH8j7BE0JT3Z3
         Xrfy/i3sjwNv7ixESwECRWQo9ELB9IWSP6937ltTcecxDLpkDC5Ji+I/SElX4b1tf4dV
         XZl8CBdyJOK7r2fpYE+J5AvG3oA7T2CcG6D2ZbCrLnvLoLuwmH6fkgNfQUDyuIUkeqBg
         9fC6Qf1Tl/V8KNPqeE0lrYDjd8UVCA+TTB0+2xm8KNabo4+nl4dF3m8FlE9rscV6EmtW
         91+w==
X-Gm-Message-State: AOAM5319DARtUg+bIIH39KdovtZMqcKbtqvkFcrGK9Ds5hUWQKKzO6eO
        5GoOFidE+dk6F41++ZHd52hsUJMTfTcVA4Bx
X-Google-Smtp-Source: ABdhPJxh21g0xYxoqx+gPDt8KVtsTxzFjpTvHMIC1vKFk89coiI79FHDo3/d5KmG9G9tmGjoEiOmzA==
X-Received: by 2002:a17:90a:f2ca:: with SMTP id gt10mr7874302pjb.231.1619230348888;
        Fri, 23 Apr 2021 19:12:28 -0700 (PDT)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id y8sm5940945pgr.48.2021.04.23.19.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 19:12:28 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, linux-doc@vger.kernel.org,
        hengqi.chen@gmail.com
Subject: [PATCH bpf-next] docs: bpf: Fix literal block
Date:   Sat, 24 Apr 2021 10:12:08 +0800
Message-Id: <20210424021208.832116-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a missing colon so that the code block followed can be rendered
properly.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 Documentation/networking/filter.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/filter.rst b/Documentation/networking/filter.rst
index 251c6bd73d15..3e2221f4abe4 100644
--- a/Documentation/networking/filter.rst
+++ b/Documentation/networking/filter.rst
@@ -327,7 +327,7 @@ Examples for low-level BPF:
   ret #-1
   drop: ret #0
 
-**icmp random packet sampling, 1 in 4**:
+**icmp random packet sampling, 1 in 4**::
 
   ldh [12]
   jne #0x800, drop
-- 
2.25.1

