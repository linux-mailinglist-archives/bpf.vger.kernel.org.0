Return-Path: <bpf+bounces-39015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8815E96D85D
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 14:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30E591F24E6E
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 12:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50A11A0733;
	Thu,  5 Sep 2024 12:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgVF7yOl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFBA1A01D4;
	Thu,  5 Sep 2024 12:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725538846; cv=none; b=pEKYVfhzSD0gV2zxg5irHEFzhgrqKpqJxVWq0RhjzypkI3H+VUT7SqBT0AA4FE+bjGf2BVeBtVu78xJjAjEX+ki2NGTm+FfdLQl/p3s3CXXiBRUFtGg845B2RqJN5QCWeLK9Oxb+XU7l8UP6s89bxpDgSDvaMJGhmNmL7BY+lcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725538846; c=relaxed/simple;
	bh=ntZah+TMe1UsnrBWws4HdTpKi38LYAnKX4lsun7p7ME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FGnqm3FBUtwnBSL+gRF7Bm8tWZC076cnUc4eJYxUf3FGjwuMJqGjRQ90dBqHLYl3z4XYM64K7XmxffOYX0Z6kl1ZIp1R6IrDUUqn5Sgh2LKUK5ySCS/0bL+Q9DSK6ZAIH3hP6oQoF4OkCENpt0IukZCCgc6yt1qu7zRWj3Y1Ofk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgVF7yOl; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42bc19e94bdso5501755e9.3;
        Thu, 05 Sep 2024 05:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725538842; x=1726143642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+hWQwbU8/zLn94r+/MW1PS9zt1M0q617URppC4Ogv4=;
        b=hgVF7yOlNczOuS9OHmVBgeXEJJYTU6ZihFeV5nGhwEV4RrYUABmFOa99t1QHsuqBUi
         BaYQKYsN/GdkhKeRc8kC+SLoEorfUcB0E58YHpGEx0IcbAFlXuwvU6/zPdwJFy3Gnfr7
         UKPKOwStz+7IaHk1aJzkW5ZcROSrxfCtVv2+MD3f8Rjwic2explkiKS1yXRMiS1/pj5A
         3VJv39ngYCFGqyv+IY2RO5Z1vP7FAxKTx3tstt78RqjUGLmlV0aBb44p9ISP/pE8ZKWG
         7EnhrN6a05JFEmuiPkzIBXzmuoEC62Vi9Y7FAtknA9fuWZtZwd4RuO5+lpQlQPpN0Tkz
         rlqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725538842; x=1726143642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+hWQwbU8/zLn94r+/MW1PS9zt1M0q617URppC4Ogv4=;
        b=F3eVtfCLhAlQ3f2LKiKLU8s7CHNlZa1e50dhCKqJg0IYSeoVLK0nGPX5GILr51RLKE
         pJPiUeHBGksntb5x9oP18OTqDgANYuVox8iAnNayXwaVGU4hB9e/bpsPxtiVXGh/29IQ
         vgaDbV6QsvyIUvCQjPyAW3ynL11eymsAPbpDb8WRSPTFRnFKg7AhKAW16nwjpwpN0qiB
         6Ds+PkdUqjls5H73X1asO72jy3i6L3WMWVdxVILPLExQ7TB14HUbLStJJ+p/C3O6TWzf
         Doov0zgVaMP7geOgT0eUtnQNJc+ezWPrGgVOZg7+UUU8g7SgrpQpYlS64Oq9yqNIzYm/
         TcFw==
X-Forwarded-Encrypted: i=1; AJvYcCVfF+WYn5u+GOu83cy6u2zJ08wcsRktZO6oa8/mbAY80Fa6sk1CDGDOIIYGJXCyP2pgsHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE9XGRoN0kaNVVcaxJTJocfsruYGdXLfyaQ4QOuFowqZqG0W0V
	M+qQ5ZjvgeTlO0O9+cQBhneXbV2SwQw+hxrm0aTDq/d/WegONLwT4gbZ6VbwP8M=
X-Google-Smtp-Source: AGHT+IHiG59lwYh2JBbk0IvapT98odJgbdBlY7Aa9LCCfED3V0MkOreKseQ/p2M1f9MUqWlfOGQZig==
X-Received: by 2002:a05:600c:a4c:b0:428:17b6:bcf1 with SMTP id 5b1f17b1804b1-42c8de87c57mr57755945e9.22.1725538842283;
        Thu, 05 Sep 2024 05:20:42 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e27364sm230390515e9.34.2024.09.05.05.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 05:20:41 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org
Subject: [PATCH 13/18] bpf/tests: Include <linux/prandom.h> instead of <linux/random.h>
Date: Thu,  5 Sep 2024 14:17:21 +0200
Message-ID: <20240905122020.872466-14-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905122020.872466-1-ubizjak@gmail.com>
References: <20240905122020.872466-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Usage of pseudo-random functions requires inclusion of
<linux/prandom.h> header instead of <linux/random.h>.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
---
 lib/test_bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index ca4b0eea81a2..eb4a1915e4d2 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -14,7 +14,7 @@
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
 #include <linux/if_vlan.h>
-#include <linux/random.h>
+#include <linux/prandom.h>
 #include <linux/highmem.h>
 #include <linux/sched.h>
 
-- 
2.46.0


