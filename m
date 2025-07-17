Return-Path: <bpf+bounces-63594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 605E0B08C50
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 14:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ADD51C24BBF
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 12:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9392429B8E8;
	Thu, 17 Jul 2025 11:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2c2d1UT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1440244695;
	Thu, 17 Jul 2025 11:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752753591; cv=none; b=X/M1XbFyqEdTJ+oDr9XrLvn0Ptv4NTixIeo1oL4wQH2FL0xCAVm2fErINONnA8sn42bjDEBpd4obp5mF+AQwRhllUAqMkiZ7Z8O6yG1c7fjDOsonZnRScI4p48z26wI3h+T9WQkWEkUq7MphxIK6QjFH90GfJDjJuHKbujqWEiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752753591; c=relaxed/simple;
	bh=nkcmylT9yipRsOBI6uhXOZOwKH5/VJoxCifVdfyQYUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qarOlq+ZvZGuXOWyITbqLAtlgEfLiFb+kV+F6v/z9QShyRV+DToHSyKT81ibyb/ZJ8aWAyFhUHmBWRA91tMda0iu52HiIUzdnyi0PxV+3TwLE0xZ/8hxEB5dXhH/6/uUZOHYdyLhNg+XKWNatjpN8cJZyjRSyRvn/RHiOWvge6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2c2d1UT; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2350fc2591dso8957485ad.1;
        Thu, 17 Jul 2025 04:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752753589; x=1753358389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PbLRuGBCBDgfVU6yEnMIFZuymSG0mxgBMi0dHo+HMI4=;
        b=C2c2d1UTtTht7AQKKfVt2LRi3iJuDY9IZY86Kvu0txlL57PgndO7X7AoaQT/nh/lHg
         fiYtxytJsnK4yEheZAWdU+EE6OZlxztW0yuy0hVsgYPQJ5I7+aQSuYMSiZkhn0ErlmI4
         /O7lFX07mZo58Mnx3G3zuwsXlgENyI/G6uN5guZEBktY9ZR8n8isxqFfpRJ35afFgUfp
         Qw6sZnBRNdKmpQ37u9pKCtW9ivfwRGs2gCiQt95in7clSXpJv1J2ofQpm7yyRf/SOhl6
         6HTqjC5ov7p3LEEUo4fQ3hxsW+3Qv0wnIX6vGBhoDbjWaWXkCCLlMRDi+1rqS0INLBbo
         7s4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752753589; x=1753358389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PbLRuGBCBDgfVU6yEnMIFZuymSG0mxgBMi0dHo+HMI4=;
        b=ni4+kQuzU4Yf9ZEx4PfW+9PeZsdHsOUv6LP4eIhnGJctsLsFaLd4BGeVb1TcKbQ5DL
         UqK9RqYEzlKuVDzoJ0DXudJFbkW9N2BtLd2ajVTSHHcw26sGl7tHl5yfiHPgQrsYW7h5
         FQjloKqWm8UBdPsdTMGKV9ssSQWaGwuCXIYtbtazrnVUO1b9Kv4kKV1hOsZW/qZLVYUK
         YEdTO5AFQU/aOyhVRNEKCyMn0DHOTOwsvMUhUqQsZmLairoHtQkKtVkKvvG3WngTaTYV
         /+BFG/EdfBPLa9dOLToyW7z1MstH7lO8QpwU4hAMtNkWnX9qsjNQ5jqq4wpuA8GqRlH/
         nK9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVqA7pBTb6gO1we8q3g1FIRVxckvTmxffO0xt8mzOSTaB+YsZ68OlWa/4jJfZz3WOVG0W0=@vger.kernel.org, AJvYcCXIMz97rJTpodoup3UaPO7GO0FGZHUmjzev6zN94U63EfPv+KOb0lAi9OXYmhBE7RoRtyMyyylkrvu4tuzG@vger.kernel.org
X-Gm-Message-State: AOJu0YwSIQ3zz+ivroS9M66AR6jF31RqesdZmGkaB4ZsPal/inDE2VOj
	OcH1o2sykdlMII36TzV9TLPsPSRnb7Q5/PO6gj+pFZDauzbafQiVAneF
X-Gm-Gg: ASbGnctYC460TOkWwPkp78veru63ku9hw6u8FxZ744x5F91EWUWewxVuBO3Drd1FP+A
	3saDZIV3VBtFfRzHYdPV0mcwq9/IbYSHwkEaq+i6LBx+iUovilk22AG/Ol1umzcmbMcWAaomhxl
	Z3h25p5YRF5z7qynrPpV5BgjytaUpkiM3NLIif7uQA5LZVAWLBwLZj/ap9/ELyUGtfy3QM2eJ7o
	ilqwOIMZONRMQbr4ebZlJ8Crgrytgo+KtfyWpHTS1YzEqSJRvfDG3bml36Mad7sgcIYNfDqE/+H
	D0u9+xODWaeMr7JBHngbxJSyTUjK5B+L18wjREEJoEx3rq4IeomFdgUZ+5BDQFe2SckZp/9beP5
	6s0JbtcsrKGnoDIzUZYmxWsaOHf/d+w==
X-Google-Smtp-Source: AGHT+IE7gXMblI4F3h/n2WJ5+86/B68s1uRAd1eAVRlCcY9lkPK3X73PWe7RYmr9PH2N+slxR08t+Q==
X-Received: by 2002:a17:902:bd4a:b0:237:e3bc:7691 with SMTP id d9443c01a7336-23e2f704bbamr31439535ad.13.1752753588815;
        Thu, 17 Jul 2025 04:59:48 -0700 (PDT)
Received: from archlinux ([38.188.108.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4322890sm146172075ad.136.2025.07.17.04.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 04:59:48 -0700 (PDT)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: [PATCH] libbpf: Replace strcpy() with memcpy() in bpf_object__new()
Date: Thu, 17 Jul 2025 17:29:36 +0530
Message-ID: <20250717115936.7025-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the unsafe strcpy() call with memcpy() when copying the path
into the bpf_object structure. Since the memory is pre-allocated to
exactly strlen(path) + 1 bytes and the length is already known, memcpy()
is safer than strcpy().

Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 52e353368f58..279f226dd965 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1495,7 +1495,7 @@ static struct bpf_object *bpf_object__new(const char *path,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	strcpy(obj->path, path);
+	memcpy(obj->path, path, strlen(path) + 1);
 	if (obj_name) {
 		libbpf_strlcpy(obj->name, obj_name, sizeof(obj->name));
 	} else {
-- 
2.50.1


