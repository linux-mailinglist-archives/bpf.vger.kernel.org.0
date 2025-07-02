Return-Path: <bpf+bounces-62176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C76AF6087
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 19:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DB335247EC
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 17:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDE4309DD2;
	Wed,  2 Jul 2025 17:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnfFbWvx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DB030112C
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 17:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751478992; cv=none; b=RqsiHqXIXVtL3U8VBIoISeJKW7BBRA35Gh9rTJRlSs2Am7n3DVWHQZZIvkzEd1FAEQHQWJQXJd/6kJdlMcpW5GwvTGA1KTDdStx6xRadsYBj09koIHSItPbiScAdyh45N4b6jG9Yc7whQS4rdPDmKwdsC6lmw0X0yU7Oeg5c8Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751478992; c=relaxed/simple;
	bh=wXNUwXC5UTF9qDhTcgFLFx15SrBjxue/2DFy+vZJu9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UHpK5l7kWiUirOA01bnuL7D3XmGsj3ZHVRZ8OOuchGNup49J/ke0l8RFoVhSisid0Id1x7Af3O4rbozgSFFkuu9Mo5xJ/rJAJakuzInTTMcwtjDIBjx7PEic5/7Ryc4dJdLgdyTUnl0/OwcmZ/xzHaI85bnxa+qjZrijzc0YuRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnfFbWvx; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60dffae17f3so6851345a12.1
        for <bpf@vger.kernel.org>; Wed, 02 Jul 2025 10:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751478989; x=1752083789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+4TuhYnVTqdp7EFcWrxLilOzFlaGRWDMcyQSUmA8XBo=;
        b=KnfFbWvxsWRmxqVtj9COgo130Cv4NnHoqT2LXS2tmSDGI7C6LpWI6QTzIihoMaf17N
         0FuJ4PHTLdKKN6wqQQqo0gjU1MSrlyA2v4a1fvcd4wJ5+KQhKb/2QV2P+WsLj87CabzY
         iuY/1h5EzmvoSQfFbFMa8y/M3MO0nbverbZXdJUHUtSOcdK5JpanJ6HNRhUPmwBQW3Mw
         zECcr+b0TKlplh2Xm8JBQN/8YJB63V2qeyrNkFWkKy3+KXPf5RmfWDE0N/bG/dTInaxI
         uA9RgvTmmySY7xk14paBnx7qQpPY2ZustgwfIohUIXIANs3UHm0BFN1ox84kyuEAKV1u
         5BNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751478989; x=1752083789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+4TuhYnVTqdp7EFcWrxLilOzFlaGRWDMcyQSUmA8XBo=;
        b=D/WdL4D2QNDZRKw6MD6FtSJ07PrKgUSCjWK0JrLUOZadpNvLhxApjLmEO1bbeski9m
         T1uipZlszXJkHPwEXQGcuIofArX2Mpqk3ktOv1ecbHcJCQnI+EMGlsCZGO3bDdD3Zfod
         KzBgkQUlK15b4xzmtmN/Z3bSwL6q3AR8ZNAwXHh8WPd07B5l2UC9dNDvunoik+nUoMNR
         govkSguagKnj3+ytqy1SwIxI5DjjlyMpQK7RErcWxQhDlNge2VyCF3e6KXSG5JmOgP/+
         00cAqSxozDFFUIBheZi7ikSPuV3DjuCHT5PClWW6y7pL+CC/OHUvjYHg4x72yXd19DAC
         vE4Q==
X-Gm-Message-State: AOJu0YzEWzpJi6cnfutA8/bBnoBFqjxBYeUmnN1HQDdq8JL1m9gqm8Li
	LdpBuc0QLrJEO9WzMnp5E7aoxydL8xE5/rMYLxkIV10jtPhIAJoJi7RLqzbcdw==
X-Gm-Gg: ASbGncvG1RAAU9YFLIfJ17VUthCdYs7LEQgT3wYtzrNnmygyPQXmeSAJfQ6SV4HyCFm
	y+O36gkcD3AXBDLX3PMUDZdU2QOHz3r//c6h5c3yeTGZKhNCPOkeJaNXEP2AlhcJhiIhFBe6fzM
	deShGw+aWB1sVfod2MHtcNN2mYpufmNGmOwxUJTDkytoZnQekkwWObdZnx6JLOWAhLNU7VwRxZ9
	7jw3A0np3cdCWa2tjaI35UmpnceEXhZj3sc7kM9TdkOyDw6mIbApdP8YhWwae+iqZS5uxq0Fd4L
	ylTCn1Aw0ZZlJhMD3F3Ay9KyrvENAm2AyVaLmJx4tQ==
X-Google-Smtp-Source: AGHT+IE1Nz6SVh1JDEWLVq9TdPxZdK3RDS4dNpBTUE5NsFEVwY17+shYdlAFO7ydycLSOjUHOjIguQ==
X-Received: by 2002:a17:906:794b:b0:ae0:d011:c185 with SMTP id a640c23a62f3a-ae3c2a95b20mr426235266b.18.1751478988852;
        Wed, 02 Jul 2025 10:56:28 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::4:1bc3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3c7606786sm139207966b.60.2025.07.02.10.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 10:56:28 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v2] selftests/bpf: allow veristat compile standalone
Date: Wed,  2 Jul 2025 18:56:22 +0100
Message-ID: <20250702175622.358405-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Veristat is synced into the standalone repo, where it compiles without
kernel private dependencies. This patch fixes compilation errors in
standalone veristat.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/veristat.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 09cfbd486f92..d532dd82a3a8 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -23,6 +23,7 @@
 #include <float.h>
 #include <math.h>
 #include <limits.h>
+#include <assert.h>
 
 #ifndef ARRAY_SIZE
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
@@ -239,7 +240,7 @@ static int libbpf_print_fn(enum libbpf_print_level level, const char *format, va
 
 #define log_errno(fmt, ...) log_errno_aux(__FILE__, __LINE__, fmt, ##__VA_ARGS__)
 
-__printf(3, 4)
+__attribute__((format(printf, 3, 4)))
 static int log_errno_aux(const char *file, int line, const char *fmt, ...)
 {
 	int err = -errno;
@@ -1337,7 +1338,7 @@ static bool output_stat_enabled(int id)
 	return false;
 }
 
-__printf(2, 3)
+__attribute__((format(printf, 2, 3)))
 static int write_one_line(const char *file, const char *fmt, ...)
 {
 	int err, saved_errno;
@@ -1358,7 +1359,7 @@ static int write_one_line(const char *file, const char *fmt, ...)
 	return err < 0 ? -1 : 0;
 }
 
-__scanf(3, 4)
+__attribute__((format(scanf, 3, 4)))
 static int scanf_one_line(const char *file, int fields_expected, const char *fmt, ...)
 {
 	int res = 0, saved_errno = 0;
-- 
2.50.0


