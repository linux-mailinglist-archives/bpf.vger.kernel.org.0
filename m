Return-Path: <bpf+bounces-37617-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A54CA95845B
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 12:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B9561F26DF5
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 10:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963E518E74E;
	Tue, 20 Aug 2024 10:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9ktsqCW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7A718E757
	for <bpf@vger.kernel.org>; Tue, 20 Aug 2024 10:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724149455; cv=none; b=JCWumbk8cmAPmGku3wF4xGWPOBErdWQZHJd1DBjwQ+68zL+J+1RZV7nMDSPySSSmBWxMX4AYObbT7MQinwknvfF7mepp4s6/L09Odu10I26/bFh7fU8iTrulpqDBWOHmeFjiEhpdA7wg+xDEL6u+LA0HrnMfF0KkmXco9ZB1oxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724149455; c=relaxed/simple;
	bh=kkYykJQL9R/aZ19ho2YF1MNC9bP/lNQhK5xnq9vtxUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJa9LF3NUcDq2MRpgF/YprlsBRNh1PpHXAi2mccj6YlfpVmzQHPDtp2asucVZ1Nb7scjKFSJndAxgPQkM9I5Tyj84hgAJyaag5V50fnTOOAaJwgaHIN5mE7cNRWkGPSpgb9r2Ly7fJ5pohpCfPxQ1gNbaty2YTcXtbAWdQvdtiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9ktsqCW; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d427fb7c92so1538692a91.1
        for <bpf@vger.kernel.org>; Tue, 20 Aug 2024 03:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724149453; x=1724754253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LT89j+dp+gUlp+EdN6Q/RK32F1udlyN11SN0eEj1uLc=;
        b=a9ktsqCWxPDqQ1AcDnj0cQY0/j7/LKOp2+Hqj7WS8M641k6V+7kxUnZvLyaHPGj7Nm
         jq6HpuFmqyPw8QGX0/Wq7/wClOwYi5A+647jzPIBoI/uLX2ZjALtF4hG47ceuqAydWyJ
         O4N+idYkoPLjXKmBPNTMgT0kHbccJMFQ+/Ww6beInMertLHmwX5KdQuN0CQkFWyG9YZ/
         zLP2dPmU/5soER2faH68Dg1w6wGNHg2dDyTVpITV5WlSOrkcxi9m199Tcd7gkOHallQn
         4GbcLv2+87Qw+2NlP/uBngSZydIjtv9dL9tVF7AaQ6RfQ8mtJD5r/CtGnhvA1eIX3WPm
         EVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724149453; x=1724754253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LT89j+dp+gUlp+EdN6Q/RK32F1udlyN11SN0eEj1uLc=;
        b=h9QElnE6I1o/fb+gRsHEfiYHfL3CDLYrChTs4E/tGNJuY3bCFYhXni/SB1Bw78mVN8
         iaP1p7PBlYIMti8hz5krZANLfPB+4rjPnkKqjeIhQZblqWxSl9cvYOKvi2Q/dGNZ79Vh
         bY7y053J2O0EnmX4cmLpePbdaSAIlcYXJdopwNADOhwppNn2TYLH+/puRYDbsAmqFQlg
         hLaPcrh7yWAVjm0msq73YbalNMUPbqu2ppuTbNc6pkETm681Q/QAx2WmbgAwnQNC1niJ
         hVRSQOfP3xRFyFEhGBmsuY/WWUj0nf23qH4l8Rb6KbMPeuNAiMDEKTNgeDP/WiJlvfKi
         xY4A==
X-Gm-Message-State: AOJu0YzTcnPWs71uEQmtwOls7urnIqtPExiZBEFqNH7km3NmEJZPdCOE
	hU8VH2HjwtRIdAM+GLEmf2ZnsNTAVXhF5u+uQJcE7AU8GiUt+A/Rox2tP/Vo
X-Google-Smtp-Source: AGHT+IFBB2xRLWcRScLI3JN/nuTmNX4X1g8AinZ8dCvW0JNBlngozyhLXXsZuGGv4D69geKrjSQk2g==
X-Received: by 2002:a17:90a:de8b:b0:2c8:e888:26a2 with SMTP id 98e67ed59e1d1-2d3dfc6afa5mr13691121a91.13.1724149452761;
        Tue, 20 Aug 2024 03:24:12 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3174bfdsm8976166a91.27.2024.08.20.03.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 03:24:12 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 1/8] selftests/bpf: less spam in the log for message matching
Date: Tue, 20 Aug 2024 03:23:49 -0700
Message-ID: <20240820102357.3372779-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240820102357.3372779-1-eddyz87@gmail.com>
References: <20240820102357.3372779-1-eddyz87@gmail.com>
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


