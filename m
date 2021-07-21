Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3993D0DA0
	for <lists+bpf@lfdr.de>; Wed, 21 Jul 2021 13:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbhGUKr6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Jul 2021 06:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237973AbhGUJ7u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Jul 2021 05:59:50 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042B2C061767
        for <bpf@vger.kernel.org>; Wed, 21 Jul 2021 03:39:05 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id l1so1762353edr.11
        for <bpf@vger.kernel.org>; Wed, 21 Jul 2021 03:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=actVck42QEjdYfIC2+WRyto/8BTycoXWTekXEbzoZVY=;
        b=vdIkctQ8bh+DenGDuthoROL+xfsKQ933isnkdw0NIgFANFaT+yU0laI7XJef4GrAab
         4R/3QAwc4AQ1+NXpaPHXD6OcE7sFoWSYe03hpIVrWKbFtkjK75IJUIUPaghSLjVOx8Dv
         oaQsfbUNSVAun2u7Bb6pNgqsO62CDW8bfctHCu3ZNR8Aj4pBZ9V+Tu5LSUi5HwUik+Z5
         rl9EgXUzVLZO8/bc540l0mMivjk6sxuj6gfbaC2LN7/K6BpuxYvxI+b5ZXIkkxvFD5hA
         RPWlnz/swXiWkhd57TcDJ2ZijpLbDPly3tEU69bkjzmTttWpp5F0BxLfO33G6YaqY+nQ
         Ie5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=actVck42QEjdYfIC2+WRyto/8BTycoXWTekXEbzoZVY=;
        b=aVLed2U28aNtL8zppEN8M1KdcM7GjNkynOaz5txpjxfoe9IKcNAoE5014QCdL/k+gJ
         ZDE9gkXYhEIQYiJJ1MUj7KkRd33l/UpcjWkOGeXl0uiLGhB7kw7m4mGm8c2SXMRjDiBx
         i+n0vpfrk8CExN5LSXgC2hfSnRC3Ua1euzDZl04DJYst2SzLWR5lTuOnbr0Vo7842s3G
         W2dOJVzpvNmkUn5k63W/2LwAce6rgcj28GTJk4TNaAPFej5ATjiiJtXcbVhhWAaJqRuk
         rUcbVESPO5DPspJIhy/o2QN2uagDZawIZ2OlsGQ/AaTPRbhkfEfP9BZrzvVSC7RfBBCJ
         Iaow==
X-Gm-Message-State: AOAM5308HWhaclQ8mWJp5XeQwTMi9bn8TQZ45vQdhMEPGAAkP8fWvfFP
        jcK8suWGF7lvW937LB9X3O/G/A==
X-Google-Smtp-Source: ABdhPJwag9FutvMJfVZClejf5HjAnZCqP3cjfnDiTLA1sElmnKKBlw6YVJZ4X7yykilHHZq9GTFRRg==
X-Received: by 2002:a05:6402:10d9:: with SMTP id p25mr21492868edu.51.1626863943546;
        Wed, 21 Jul 2021 03:39:03 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id j21sm10559668edq.76.2021.07.21.03.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 03:39:03 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        Tony.Ambardar@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH] bpf/tests: do not PASS tests without actually testing the result
Date:   Wed, 21 Jul 2021 12:38:22 +0200
Message-Id: <20210721103822.3755111-1-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Each test case can have a set of sub-tests, where each sub-test can
run the cBPF/eBPF test snippet with its own data_size and expected
result. Before, the end of the sub-test array was indicated by both
data_size and result being zero. However, most or all of the internal
eBPF tests has a data_size of zero already. When such a test also had
an expected value of zero, the test was never run but reported as
PASS anyway.

Now the test runner always runs the first sub-test, regardless of the
data_size and result values. The sub-test array zero-termination only
applies for any additional sub-tests.

There are other ways fix it of course, but this solution at least
removes the surprise of eBPF tests with a zero result always succeeding.

Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
---
 lib/test_bpf.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index d500320778c7..baff847a02da 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -6659,7 +6659,14 @@ static int run_one(const struct bpf_prog *fp, struct bpf_test *test)
 		u64 duration;
 		u32 ret;
 
-		if (test->test[i].data_size == 0 &&
+		/*
+		 * NOTE: Several sub-tests may be present, in which case
+		 * a zero {data_size, result} tuple indicates the end of
+		 * the sub-test array. The first test is always run,
+		 * even if both data_size and result happen to be zero.
+		 */
+		if (i > 0 &&
+		    test->test[i].data_size == 0 &&
 		    test->test[i].result == 0)
 			break;
 
-- 
2.25.1

