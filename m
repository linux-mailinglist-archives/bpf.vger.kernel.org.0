Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 180C77FF5F
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2019 19:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391723AbfHBRRW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Aug 2019 13:17:22 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:38919 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391675AbfHBRRV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Aug 2019 13:17:21 -0400
Received: by mail-pg1-f201.google.com with SMTP id t19so47832904pgh.6
        for <bpf@vger.kernel.org>; Fri, 02 Aug 2019 10:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rxE5Xpol+bSg81z8GVrhZHBv2KTR5njlcPKT7JMdsjY=;
        b=vIgWqGxA5TzbNkCgNJ7AjhvVlQ1OYHAfUboYvrGQIcYN/MnoeCtnopbe5yExBspMr/
         Kddh5faIQApNOWwF4ZHRlXJ3FKuqz42YeHRYH+sO75xqkWQwGCr0Gz7Yr/ocDe52S+Lo
         bgMLtcXiO1qWcZZtO6PL8YZaV0vldl3Ysqn79IkNn/mgICwbLEl2vCYi56LZ/S4E8OsV
         10sujGadRe4z1lcoBwWqfkt3RNY8uZ+5lUzEgU37YtBjtlhfDjzQ/TXtZ9C3hWiJ7d9S
         i97/Kvlp0TZL5/eewvBsbsLpVhr88erLVb+denQH/UZeRtGLYVcrt6xMoV/f3xgib+8m
         pU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rxE5Xpol+bSg81z8GVrhZHBv2KTR5njlcPKT7JMdsjY=;
        b=r24AY0pUlpxRHc2lFAqEYZopxmi6mFaXksNuj5BJB8y+7AajvJre68ro2nsWnii72e
         0b8hG4H48WH/uE+ofPJb83rpPsAPgc1vzQyAlExm5BSyseuRW8ZF2k4zmGZnRXbNe+0G
         IiaHIXhPFr35kk7uZ4a3VhyD7xn6FBb1E33LyIyyac1+DEDKBCgU8lJaPQFlyxTnbmcv
         1V8ybbfO9SBFH2Fnxlh37hkcd6KrndZvv0Du6x6tsTAE/I2ddCt+3utmLrz30u3RrcEx
         93BW5s1n8GAcY4rhM2FDbd53qdwRnee7wuTbV2UlJOKdSH51fbTfCvD6S2u118/lVfEO
         IRTg==
X-Gm-Message-State: APjAAAXil/ZFhEppFiunQaD4bJDThGRp6tyN9EKKmvi+WoMx5wj7dnrR
        AHXnRDyNU++6Jy6VZJEr1f0MMs8=
X-Google-Smtp-Source: APXvYqxO/ZafbbZag2Yj0WDQMyucpwyEnB3HWRsqEL/aPzKBkTFO8+MeDhtc4p+6awaPSXOCxkAstK0=
X-Received: by 2002:a63:20a:: with SMTP id 10mr10632579pgc.226.1564766240192;
 Fri, 02 Aug 2019 10:17:20 -0700 (PDT)
Date:   Fri,  2 Aug 2019 10:17:10 -0700
In-Reply-To: <20190802171710.11456-1-sdf@google.com>
Message-Id: <20190802171710.11456-4-sdf@google.com>
Mime-Version: 1.0
References: <20190802171710.11456-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH bpf-next 3/3] selftests/bpf: test_progs: drop extra trailing tab
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Andrii Nakryiko <andriin@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Small (un)related cleanup.

Cc: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/test_progs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 71c717162ac8..477539d0adeb 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -279,7 +279,7 @@ enum ARG_KEYS {
 	ARG_VERIFIER_STATS = 's',
 	ARG_VERBOSE = 'v',
 };
-	
+
 static const struct argp_option opts[] = {
 	{ "num", ARG_TEST_NUM, "NUM", 0,
 	  "Run test number NUM only " },
-- 
2.22.0.770.g0f2c4a37fd-goog

