Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18DE711F8A2
	for <lists+bpf@lfdr.de>; Sun, 15 Dec 2019 16:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfLOPxi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 15 Dec 2019 10:53:38 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:47986 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbfLOPxi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 15 Dec 2019 10:53:38 -0500
X-Greylist: delayed 540 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Dec 2019 10:53:37 EST
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 47bTH916Phz9vcq8
        for <bpf@vger.kernel.org>; Sun, 15 Dec 2019 15:44:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hlo2wTeHv9Ia for <bpf@vger.kernel.org>;
        Sun, 15 Dec 2019 09:44:37 -0600 (CST)
Received: from mail-yw1-f69.google.com (mail-yw1-f69.google.com [209.85.161.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 47bTH872mPz9vcpt
        for <bpf@vger.kernel.org>; Sun, 15 Dec 2019 09:44:36 -0600 (CST)
Received: by mail-yw1-f69.google.com with SMTP id j137so3797861ywa.8
        for <bpf@vger.kernel.org>; Sun, 15 Dec 2019 07:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8MaXjt0FsXUXsO6312KufDDg3uo/7OWWPMETqU4hGeg=;
        b=cnNd13+MtvIB7XKLTmQwE4VJKaQjPQ8wtnZCXQsg33NjgkokHMxaaT5QCrTgssaHde
         POVQXccfXfAiF9O+b2ys327nAtgo48KwfPbgYIvTpe6B8IPeOhgiJanctpNfwK7v775X
         qk2EJ2OKcHECm5gPYILCmLyU99qG+xCJijZ7lBUzlyZwI+gIe9UmmGJW//jWfUsxakyc
         6es+JarwGukRoGu1J/Kiq1gdwfUgUVPfXTMi43KIqvtOzoC8G1GJ21bd3PikdG+QALT5
         wwyD3GZ8nHLMqxrLYwIJX9X7bYEdR1hhlWXiCwufFOhGlmvTvBUQTWUI2XkhGCXV//uU
         vA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8MaXjt0FsXUXsO6312KufDDg3uo/7OWWPMETqU4hGeg=;
        b=d2kQMiw0MJUC0uh/w75xyltvvDFQiv3VUZ7100PxI2A2IMDJNyfgaSPVzRQSZC4BM3
         BMX2KWY/2XIG4Df/of5x5l2b9TQ6Rd8qo/1MfMjkc/e1F92jhZL75b8KlinyhNuivq3d
         gxr20GG5NlownROHb+RJJ+zJFQRQHF25tqDOh113MYuJtb8fwn242jhznWYuRlwszHqc
         AcTw1v5aMUAVXTUovHhQnd88oU0Ofh7LI7QEqkEo8adiHdocBHUntxjymjm7LQlNUAQJ
         3VM6KixYhQoNXEqCainx44PFl0l8xf/q+xyEDaR5zMXP961NagUQSf64Gse9+L0hfvmB
         cvHA==
X-Gm-Message-State: APjAAAVTmFHpUT4FhcKKT6ARN8p6exm01xvfQZDkKs23WoC9wwZBaRcW
        Bkp+4i3rEi0oEjHgTh8wyLRp7HBN739KwAR+2xPbtjg6ePTwAoGA3VYStTw4kxrAVeFGga+ht6f
        6j0FjHb3kAk+MxOW+
X-Received: by 2002:a25:bdc5:: with SMTP id g5mr9032684ybk.206.1576424676491;
        Sun, 15 Dec 2019 07:44:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqxfT6IU9GI6GwDtKMoF1A0NCGhTTkrNK7he9FRqEQKmqPMb/HlUzknbmIsjfrz3L+8vuWgxiA==
X-Received: by 2002:a25:bdc5:: with SMTP id g5mr9032670ybk.206.1576424676248;
        Sun, 15 Dec 2019 07:44:36 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id s3sm7164142ywf.22.2019.12.15.07.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 07:44:35 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: Replace BUG_ON when fp_old is NULL
Date:   Sun, 15 Dec 2019 09:44:32 -0600
Message-Id: <20191215154432.22399-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If fp_old is NULL in bpf_prog_realloc, the program does an assertion
and crashes. However, we can continue execution by returning NULL to
the upper callers. The patch fixes this issue.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 kernel/bpf/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 49e32acad7d8..4b46654fb26b 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -222,7 +222,8 @@ struct bpf_prog *bpf_prog_realloc(struct bpf_prog *fp_old, unsigned int size,
 	u32 pages, delta;
 	int ret;
 
-	BUG_ON(fp_old == NULL);
+	if (!fp_old)
+		return NULL;
 
 	size = round_up(size, PAGE_SIZE);
 	pages = size / PAGE_SIZE;
-- 
2.20.1

