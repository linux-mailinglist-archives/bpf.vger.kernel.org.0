Return-Path: <bpf+bounces-37296-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 581E3953C36
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 22:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0331F1F22386
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 20:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82C614A627;
	Thu, 15 Aug 2024 20:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMm5LVhj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FA97E110
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 20:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723755394; cv=none; b=uj4WZk9UrUIXWvEc4DjF4HK0+aL6c3dbp5daDXGUepwTZx3aw1dAUWJHh+nTpq45f5M4H5dH7+QgYNUYE3bzXrMceg3vP6nRWFai6kwXV38+Ha6q7+kpTT86hDeeGVisqP/ypXhhzL3XIPftcRh4/Y+RYrCIb1XNjCjS6qSAuE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723755394; c=relaxed/simple;
	bh=kkYykJQL9R/aZ19ho2YF1MNC9bP/lNQhK5xnq9vtxUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ISMCIBv3Ii4sCqJX/FpfDjgaVsnrVYZZRATlvlQMqRp7rOzBDwn1KtYQSalhpXZTlfBlZ/pEmqeH652LAsJcgnINODrRBae/oxJKEFFjrsnZMOxOY0k8gIOxsZaDc62E0yRVnwBacKr6q/39B/vmm5nNry43pzBfBe1YrzJhA10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMm5LVhj; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d3b595c18dso1336383a91.0
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 13:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723755392; x=1724360192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LT89j+dp+gUlp+EdN6Q/RK32F1udlyN11SN0eEj1uLc=;
        b=VMm5LVhj6rvaQf8og+VgotiMy6afBCo++FVMxrBgLMDcIu5ZFiUiy4zorDtATp5uV/
         MhNW/4lhAJRSPJZae+K7tDZFK4F8Knn0dTeBOVh93KhdwWweH8aWM04EQQCA2EEFx85V
         M/FgfsobNZIKSGGpJZK9aqy9r/uqfQtXOcen0eE48vUWTXvJGqtZhQEAeV6V96idiRYM
         0RJOY1N/QiutpSb/KU6mzZiU50KOwFmZ6twLJXN3g9h6sRVwos6qS1bJbNB5XVE6aIgb
         aDMfdb0w6b+LSnJrsG63Ys/m23M2cjnQwxKuU6Y5jCuH7eyWx7oxXvA1jm6ZmqKcA0+D
         JYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723755392; x=1724360192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LT89j+dp+gUlp+EdN6Q/RK32F1udlyN11SN0eEj1uLc=;
        b=a+CGu8zHxfIGEbk8iemWR9Bqa+69A7oquavgol2fNG6/9vGA8gVQX3iMZHoL10k895
         oQzrayi8Yra0lMy26uGRTv+elVoJldLExLUZUfy81VM0zgNqlXlrry7P8XztWhOks3Vz
         L8KfuMCZOtdrsFtJqJFq4rXqQJPZJV8XBs3995LHRAX/3LMjYoiwOFyBZDdkGmPJUB76
         QlpOMDh35TzapuWOtCDpjFUFkfZATS4/DnNuSAOvCfAxD3iBpDJubH8G9L+jiEq+B/2e
         xLyZVAFaNVwfYH8R49dtTxOHyP5c4tEhE47UlKB1c0ufLJ5lpw7z8f9Y4/muAmasYItd
         gF4A==
X-Gm-Message-State: AOJu0YwtIjBShR44HATKUOsir5YOEr+v5XO9h/XN6K/LHll8Q7uRp9KX
	S6fO3w7fXmmkVVugNJWU/SkT+wRha1ZNYVQs0ZtGhB2D7jhhE6oY0LFna8o2blY=
X-Google-Smtp-Source: AGHT+IH3QDl9vHehy0g7oE7cDZu8Br3m1IACUhodV/bgawPj5dU1i744pSh6Z/lt/+8nYjxzaMPI4A==
X-Received: by 2002:a17:90a:9ce:b0:2c9:36bf:ba6f with SMTP id 98e67ed59e1d1-2d3e4539feemr746473a91.3.1723755391676;
        Thu, 15 Aug 2024 13:56:31 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3ac7f2eb2sm4024364a91.26.2024.08.15.13.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 13:56:31 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	hffilwlqm@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 1/4] selftests/bpf: less spam in the log for message matching
Date: Thu, 15 Aug 2024 13:54:46 -0700
Message-ID: <20240815205449.242556-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240815205449.242556-1-eddyz87@gmail.com>
References: <20240815205449.242556-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running test_loader based tests in the verbose mode each matched
message leaves a trace in the stderr, e.g.:

    ./test_progs -vvv -t ...
    validate_msgs:PASS:expect_msg 0 nsec
    validate_msgs:PASS:expect_msg 0 nsec
    validate_msgs:PASS:expect_msg 0 nsec
    validate_msgs:PASS:expect_msg 0 nsec
    validate_msgs:PASS:expect_msg 0 nsec

This is not very helpful when debugging such tests and clobbers the
log a lot.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/test_loader.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 12b0c41e8d64..1b1290e090e7 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -531,7 +531,8 @@ static void validate_msgs(char *log_buf, struct expected_msgs *msgs,
 			}
 		}
 
-		if (!ASSERT_OK_PTR(match, "expect_msg")) {
+		if (!match) {
+			PRINT_FAIL("expect_msg\n");
 			if (env.verbosity == VERBOSE_NONE)
 				emit_fn(log_buf, true /*force*/);
 			for (j = 0; j <= i; j++) {
-- 
2.45.2


