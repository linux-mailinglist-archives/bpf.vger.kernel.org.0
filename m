Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A12584B4B
	for <lists+bpf@lfdr.de>; Fri, 29 Jul 2022 07:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbiG2FuH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jul 2022 01:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiG2FuG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jul 2022 01:50:06 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBFB20BEA;
        Thu, 28 Jul 2022 22:50:05 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id s206so3246356pgs.3;
        Thu, 28 Jul 2022 22:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=/j5fdDJlgBil0TLny5OkHt3tc5e9J0A1rlxb5AXkN8M=;
        b=jeg2ixUalqJ4OrQZJepDKPqnVDS74axJfggAu6NxWI4DGdaqomUxvgRvbK+i26YWfq
         PegEsMenQiYPraDkKtiWRYe7FO4HsbxLkh+Ca2U9AMt/H5MfYamAX4U17m1d4TsOd8Is
         8dDZMaRdCOkbyuPs6gX7vYbGM96sH9WM3XO1EEucTwY2Puw+rVwnZlRzW7dUJSs59p2Y
         ahYGZB5LCfyr2GMGWe6Cpmr7bKZqmj6cN96uS6ih76YTls5NGgPM10sWXqhLFS1JDOwU
         p3I5ExUC6MRJbEqVsTGZeG0TU/MymYm/Z5xG+o93ZMyeD1lnD7nlObnkHDzlR4QDWU22
         ak6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=/j5fdDJlgBil0TLny5OkHt3tc5e9J0A1rlxb5AXkN8M=;
        b=0ww20UV8Bb4zNaE81DJGMrTuRq37D4BPx26/IMdvqCKTc8dfFPTNAlkcnqzESlbSYt
         TgLxuNKz4AXp3pVkxMv5LDpMRxPxEuSEhC11zOtkQhUIINjB4aao/jSA6pacXEE5//au
         Wd87aMm77cIqUaD+jZI/VaRma9qQmrAzZsBaSWtsTA/XU8Jsq/QcMXd31E0xTSQG83Ul
         5KGFol3P8lIhF1CAo9vMoIY3VrUPEQqE4XbjVrPZltC45d8SDsG+0h5+MTRB38lrnglh
         e0mufTvvtZLNo8rrC0Hcu3AFy8rO9CAHdpW21zn+ugQxT9gveQNwrsJL57UtHL5cf/Gf
         Wacg==
X-Gm-Message-State: AJIora9Zn/3jk0b0IGQciZ8P44iWUBY9jpft69bLvApdNINc49+I3NJJ
        bmPayoTw3G1RCE7rK7xk7xA=
X-Google-Smtp-Source: AGRyM1s/U0o/e/oaJOjx1Lu7OIcYkxNUWrNivAWAVZrc489nn9ktxD9tgUHlh5SbMjCmFd8mP02s4w==
X-Received: by 2002:a63:314a:0:b0:412:b42c:693d with SMTP id x71-20020a63314a000000b00412b42c693dmr1706365pgx.20.1659073805333;
        Thu, 28 Jul 2022 22:50:05 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.4])
        by smtp.gmail.com with ESMTPSA id t2-20020a625f02000000b0052ab764fa78sm1776430pfb.185.2022.07.28.22.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 22:50:05 -0700 (PDT)
From:   Zeng Jingxiang <zengjx95@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeng Jingxiang <linuszeng@tencent.com>
Subject: [PATCH] bpf/verifier: fix control flow issues in __reg64_bound_u32()
Date:   Fri, 29 Jul 2022 13:49:58 +0800
Message-Id: <20220729054958.2151520-1-zengjx95@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Zeng Jingxiang <linuszeng@tencent.com>

This greater-than-or-equal-to-zero comparison of an unsigned value
is always true. "a >= U32_MIN".
1632	return a >= U32_MIN && a <= U32_MAX;

Fixes: b9979db83401 ("bpf: Fix propagation of bounds from 64-bit min/max into 32-bit and var_off.")
Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0efbac0fd126..dd67108fb1d7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1629,7 +1629,7 @@ static bool __reg64_bound_s32(s64 a)
 
 static bool __reg64_bound_u32(u64 a)
 {
-	return a >= U32_MIN && a <= U32_MAX;
+	return a <= U32_MAX;
 }
 
 static void __reg_combine_64_into_32(struct bpf_reg_state *reg)
-- 
2.27.0

