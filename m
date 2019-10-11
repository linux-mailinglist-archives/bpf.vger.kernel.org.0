Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B528D35FE
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2019 02:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbfJKA21 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Oct 2019 20:28:27 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33872 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfJKA21 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Oct 2019 20:28:27 -0400
Received: by mail-lf1-f65.google.com with SMTP id r22so5733257lfm.1
        for <bpf@vger.kernel.org>; Thu, 10 Oct 2019 17:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X+OYdLBkIYv08X2eKXt3TCPXQ11so0VYCO7f1mswfR4=;
        b=YKc0wBOK5kw1DdbXCuiOee6bbytIkRtP7xcVtvuTLj4UdL6r5TUv6DcZgG/ZDsLP69
         ulWquw4+7tsUAsKSiFy2Cfty4cW+bXLlKps9odJRuCeWnw/lGdGvLR5rkISefH9Phe91
         /CAtfzmy5wtryrSDvREOHdPKvSRLjAPu5s7+k7zxv+jQtm2PN0fja1E8kM5N4INyKxLu
         /Vf7ncX5Q0YaTUYo17CjLST2nR75D+SCZ8tWLmJkPS9ENAAQArYJ0M+MYo6mSMcqEXu7
         Tnhwc+jAV+FrQNEWwOXtNudFWCGl6uLf0ZpPNG8Nqh7N9/l5U6zwHP+DruNqbB9COdF4
         akmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X+OYdLBkIYv08X2eKXt3TCPXQ11so0VYCO7f1mswfR4=;
        b=XmPhE/zSUfTjfW+dRWqXtGh3TF4zW4ZYkR/w9P6IkhEOM2DP1kiiCFzlRSl6B0nPSA
         hMW5mOSF1fpFpPdPlVCDufZvVKByFRseEZDXVbwNbbk4QfsZ29mwZ97hupT3/xaYjyN1
         Edm6+j138chuJPNJsBce00EtNP4WJwcKLH5Roa0YxUUzyyl/ifFeY+RLh7tF1ZrOLaxw
         IkuLI9LY2mnWozOM6kRZ4QMMLShC7mXizwI3dKvknvSr6wkHI0wVLNyMvRaJsxMg4odC
         i1IYx4jRVC00BS3wOETZpY+5rnBqzngZLY0Ib1eTenKwz+ytPxMy0C09CPqTjSGUUaXC
         O0LQ==
X-Gm-Message-State: APjAAAWJm+DjvZkPD96XjIs853XRiLaT6PsZxrs4rQq/IVUQztIpqj8i
        05PhUubSVMu3tRK/PQCWypeU4A==
X-Google-Smtp-Source: APXvYqzxfrVPEHNBW9hrD6Av/hCkqGzGXRR9boh0fDIihTSKCgluCdKMc7ty+RTqXr4lDuRPE/0FPQ==
X-Received: by 2002:ac2:41d4:: with SMTP id d20mr7390173lfi.24.1570753705056;
        Thu, 10 Oct 2019 17:28:25 -0700 (PDT)
Received: from localhost.localdomain (88-201-94-178.pool.ukrtel.net. [178.94.201.88])
        by smtp.gmail.com with ESMTPSA id 126sm2367010lfh.45.2019.10.10.17.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 17:28:24 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        ilias.apalodimas@linaro.org, sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v5 bpf-next 03/15] samples/bpf: use --target from cross-compile
Date:   Fri, 11 Oct 2019 03:27:56 +0300
Message-Id: <20191011002808.28206-4-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011002808.28206-1-ivan.khoronzhuk@linaro.org>
References: <20191011002808.28206-1-ivan.khoronzhuk@linaro.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

For cross compiling the target triple can be inherited from
cross-compile prefix as it's done in CLANG_FLAGS from kernel makefile.
So copy-paste this decision from kernel Makefile.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 045fa43842e6..9c8c9872004d 100644
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

