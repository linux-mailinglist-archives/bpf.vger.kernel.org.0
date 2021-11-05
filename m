Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 369BD446B55
	for <lists+bpf@lfdr.de>; Sat,  6 Nov 2021 00:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbhKEXpn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Nov 2021 19:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbhKEXpm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Nov 2021 19:45:42 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD419C061570
        for <bpf@vger.kernel.org>; Fri,  5 Nov 2021 16:43:02 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id m26so10226509pff.3
        for <bpf@vger.kernel.org>; Fri, 05 Nov 2021 16:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rlGRxPJS9wpE4HPUTRYoQun0WGMv1Fh8N+2am+AWBZM=;
        b=fhr4Zek0S4+bj4kai68RKFCm5Q+Ko5w8YOdFRyR6zxGg8p8PY0TyhVGeU4deUWT+Wj
         2i/LDR0jfBrPe8FVcdG1mx6OJUsVFoItKOx8VcQUlv+vXbZx4ZvNF24GSwDDDA5w4Oj9
         8nPIqXfEmmOsAke0hDQ3bTwTxz3asgLmGbFjTxkI4f9ioU6qVBeIc/iBgM2PxptlyhiY
         P7uxPUegmxNrLUaMxj2PyTxNKf97ltKsqzzV6JR3iFX8JFTyxs8PqRBiyxIQ3eIF97Iq
         fn9McUEiH3S/eJM9LPFR2snzU0yEHZS2XPb1ywBDngg0fZHZvflam57seuzxTtcqOLYx
         tTqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rlGRxPJS9wpE4HPUTRYoQun0WGMv1Fh8N+2am+AWBZM=;
        b=rvXNQn6jKQIPXRvrtHAyz9rkGPJnJxkM4MFsEtoRzhpQeO/VVNSBw6BMnmDTa+LCBQ
         VjwvvgKKas2bEy6tcXDouYAxOt0gi2vfsyoLkqd1Bd3CrHaCM4utAijwaPLPET/K0jfX
         QvsVtcTLIqxfWhoIEo0sy1bLX2clZshN52qQgrpN4HeodASLIVL7Pk4MoLpOoj9dIJuw
         f/EIF1imIn2hCnGk4eimWwhhqRavVGadQ+PJUYI9Xf3BWu5k2nbhykE34v+5U0iMzLzV
         m21QzoUVTVfwW+YWHfgZxDF3C+UDudvAWkPnNt8mvPGft8ZM2yQi+Ckw9kmt5YYzl41F
         V3zg==
X-Gm-Message-State: AOAM532Co7051WxReTMaSTonJRo3hZQQoHU1ZBRXnn6+7te9dGWfLQBP
        JwplQ/RI8iRZ8RYaNxYAfUPphw00JWT2ng==
X-Google-Smtp-Source: ABdhPJyuOTpwKNl+6bb/9moi1bUsiH+uYz0rDOhr/6+NKKyZtdgbs9ch9JgdGaBQ8QDSZdmkvzrUyg==
X-Received: by 2002:a65:460f:: with SMTP id v15mr11926495pgq.430.1636155782203;
        Fri, 05 Nov 2021 16:43:02 -0700 (PDT)
Received: from localhost ([2405:201:6014:d916:31fc:9e49:a605:b093])
        by smtp.gmail.com with ESMTPSA id i76sm6648995pgd.69.2021.11.05.16.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 16:43:01 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v1 5/6] selftests/bpf: Switch to non-unicode character in output
Date:   Sat,  6 Nov 2021 05:12:42 +0530
Message-Id: <20211105234243.390179-6-memxor@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211105234243.390179-1-memxor@gmail.com>
References: <20211105234243.390179-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1251; h=from:subject; bh=sWVGM/cgEVt6obywBtebfMquYECOMhAWqlkkvllMdA8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBhhb9BYcBURvsDExwzgvHEVoVR3QbPt1CmDUxT5N3N MLE5jgCJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYYW/QQAKCRBM4MiGSL8RymJLEA C689e4FdR9J/qWhvqgXB1468ZvhdlbUdDxnYKkAJtmj+bKKNx/OUVYyaI3Xh2RSUmCZ7z6Cej1Z5fo 1uFr3qxC8cUgIHgkmWFvL31mTSO/yJpTdsqyJzYOJncMdPaZGpZW9AxJY7ZzD8kopkBaDfAl1r4eWG R+Kb0Ue59TVN1ALoClepJVPQL4lu0vmuTtVZf9nHjuS1/cOwU742jsS6gHODKo2ZM1y2UXBwzgyJ4g 3a1RjJx2QDluJCr+I87f4gPWcdJ7BNBTT/4ElJqUxFJK8D0x9bCOiSKlml5u6pRhAJ0Adwi2OG85p0 xUWfxurXjniaTOHa+HHUnCqDfbiWTdN728m2GqCVFKJuBk5QGZUvgID4PUKH7eG+jeI4G8cj4UPuru NDQl2tayoliZPRB2ZRzv2fyii2SkeN+gSSunfgGx39gRk6ZK0oSmFOp8aE34z5kd4C8yhiFML/Z5iN 8kv7Y6oo4cd9dVPDwx1l/j3BDDkQLXZQBG3tuTZj2PFWWHTsxWVRUl1prQuJebvrOYqr3nEWu2hUJb xm3GsvR/Wsw7HIRMdzTIU+iXUmYgj16jlH5CtDP9t6TDnOSPGR6FplVYlbmRnhePFIooaTraurZ96b Fmn4mz673dU8Kb1t9AqwPlFNxgsGto6KS1P3t7NhQVOjsEuuAjkEYDeeefXQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

GNU89 doesn't allow unicode characters in printf output, and build gives
the following warning:

warning: universal character names are only valid in C++ and C99

Fix by using ASCII +/-.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/bench.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index cc4722f693e9..58a32ff2eb1b 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -126,11 +126,11 @@ void hits_drops_report_final(struct bench_res res[], int res_cnt)
 		drops_stddev = sqrt(drops_stddev);
 		total_ops_stddev = sqrt(total_ops_stddev);
 	}
-	printf("Summary: hits %8.3lf \u00B1 %5.3lfM/s (%7.3lfM/prod), ",
+	printf("Summary: hits %8.3lf +/- %5.3lfM/s (%7.3lfM/prod), ",
 	       hits_mean, hits_stddev, hits_mean / env.producer_cnt);
-	printf("drops %8.3lf \u00B1 %5.3lfM/s, ",
+	printf("drops %8.3lf +/- %5.3lfM/s, ",
 	       drops_mean, drops_stddev);
-	printf("total operations %8.3lf \u00B1 %5.3lfM/s\n",
+	printf("total operations %8.3lf +/- %5.3lfM/s\n",
 	       total_ops_mean, total_ops_stddev);
 }
 
-- 
2.33.1

