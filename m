Return-Path: <bpf+bounces-36746-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 336CC94C7DF
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 03:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6531F1C220C6
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 01:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6072E79DC;
	Fri,  9 Aug 2024 01:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVrKYGQ6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A235038B
	for <bpf@vger.kernel.org>; Fri,  9 Aug 2024 01:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723165552; cv=none; b=l0r479Yy+ihl/QIJADl1eyO1vCfFeV5rdjMLs0DuXHW2c/N/Zo0hghDmGDcZi42Cf8BIss0yeuaYICpVNwVvIZElmqcljfJuvEaQgMqatBjsbpKlfIvq6oq5VYcO7JPg4epdZvmUMVw4mzZpf0Fb0mm9uOPUH3gcAZUmE782Eoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723165552; c=relaxed/simple;
	bh=kkYykJQL9R/aZ19ho2YF1MNC9bP/lNQhK5xnq9vtxUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cncP9wkXrCR15xeCjn0IaH0VoIt+BoQoxpxOfGOXEuGlIxLDAIV2D5RSrseutbhrJVShH3xCPAbMCgCESfxsyTCXE8Yp/JF/MazvXDe7nuLl/XeEJl3+rhSDVhzJTD6Y7B5HnxLXAn57ng6Z9DnQ6o/tvIo4FjuTyWkf1YHTYKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVrKYGQ6; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7a130ae7126so1086345a12.0
        for <bpf@vger.kernel.org>; Thu, 08 Aug 2024 18:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723165550; x=1723770350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LT89j+dp+gUlp+EdN6Q/RK32F1udlyN11SN0eEj1uLc=;
        b=jVrKYGQ6QIlq5X69OMckB1snfBKZasggR8iReCfZOmbHxU6Db3QgZ8LmSjqR3GViS3
         hCDvysvK1GD7e0xg1YyX/lREKWNceEvo3n/JhKdl2x5H102iJMKVpGiAocQuWY3lNb+K
         8im/UeGpStLvc5+Jh0KnXqe6MSUpMz/fppJsUJrQ2ITSzm+M59jwub880ytUyB2d45bN
         JrP99iTg6qSPsatfqnrapLVpK1aVqHbi05Vi4ZoZRtIHZzUu4tGgeWZ/ELwsQXsesUqw
         f7XzFHOK5EAA4Am2NGK8DxSS6xJMSiihHFBKRoY4bMQC/cLQ2HSMcwC3YyaWYl/l3ck8
         cxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723165550; x=1723770350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LT89j+dp+gUlp+EdN6Q/RK32F1udlyN11SN0eEj1uLc=;
        b=LYNZ/FPZ+kLYT4I+o5HG1Bej3+Zuw4+vvJS8fKDDZR34r4lXVBGhymL5uzVROsgIuK
         6/qViSXKqUaRYHb/59W78XYh3HW42nDsniIU4459K3gmHWSq5wUlwt4cmZXn2hvhHQ9n
         sFDHuqTV6vFpGW14sQe+X6Yt+p7yyP96ZOD2UvlpiRVbPpGFSb7pFmgHF/aM2QsFZqwV
         y9K0T40JA5DMUABehRjv+0KGc764z5LL66wdzwOveqf8DM6NPjBcdA48pwBFEsg+5BZj
         EetdPI/dMOTRGkywZNmdjxNvKWVeylXcn9w2849riN73r7jdBdXDW4TQcusynqux7Qxr
         JEdg==
X-Gm-Message-State: AOJu0YzbF0GSDfx+UkcrU2cKyyK1yPEyhmVzN/11d8DL9Urx2/lXQ9zh
	Hkyv0qjh1pPxD/BkUjROd+AtgIq54d+GQUh6UJuMtN+q2Jf/z2ovo0DTymYAEeg=
X-Google-Smtp-Source: AGHT+IF5wnWxlaEnVacMPorZS7kl86uDM+Vica8NUVQ8eGLvtZOKox6JhAQ2n/eoJtjYU1kDZTAYkg==
X-Received: by 2002:a05:6a20:e617:b0:1c6:b099:6f8d with SMTP id adf61e73a8af0-1c89fce0482mr196615637.17.1723165549519;
        Thu, 08 Aug 2024 18:05:49 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb2fc0d8sm1678626b3a.205.2024.08.08.18.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 18:05:48 -0700 (PDT)
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
Subject: [PATCH bpf-next 1/4] selftests/bpf: less spam in the log for message matching
Date: Thu,  8 Aug 2024 18:05:15 -0700
Message-ID: <20240809010518.1137758-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240809010518.1137758-1-eddyz87@gmail.com>
References: <20240809010518.1137758-1-eddyz87@gmail.com>
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


