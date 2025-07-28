Return-Path: <bpf+bounces-64477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD07B13394
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 06:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC0D616A017
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 04:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FE721FF21;
	Mon, 28 Jul 2025 04:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HByaA437"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBE421CC74;
	Mon, 28 Jul 2025 04:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753675992; cv=none; b=spZGfoflpBT9h3DtQC83psxLEdBJl0RnurdtdSUvr4NIknl78tPYz+siwKQPa2VMpLsyhKm6ePFmYcLv1MIfDBCFT+eo/J0U0QZnZCOIPxqxzncCneD/2CgnPpaw7YsFyyrd1zUfaN2bIOpgo6JPFzdcUA8qJLPx6qLUq+lAUTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753675992; c=relaxed/simple;
	bh=TGw2ul2ZAldEcVHaU0fnT+T9Zm5AaMY7QcEq1fLdVSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TrKsWbJPN8E/BEaHK6LhdyANcjgxOaIGZucM5LKlqI2s/ys5eIWYLZlCy+YnrXU3Cz++/0/fmvWCQeAV6I5UBTXh1afOmZ+xFrV5ZbwwpT+6f2mQCfh1D90/bSnKunI0c3xFyd1IaWz/7JZg3S8pq0fQViUKkrjm8uXDdFpd1kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HByaA437; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-234f17910d8so33814795ad.3;
        Sun, 27 Jul 2025 21:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753675990; x=1754280790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGBbLIiLGqrmFvSwaYDbAojdCre78exL+6ZjHnBuXvE=;
        b=HByaA437BoA9M86BoqGIPDAMLeB975vjxV6EXiGTXszhkMGWlPtN3HGXOAB5BkhfZX
         KD5mepIRUK43RYo4U+11BexLkK2+jZcM01LUqcxI8ETG8EwIzKLSBHoalDTL5ru0lsTF
         SZczRc/rUmeC25twD4yziI1n7WViZtIfoL2+92fnlfCaKGZr6VMXQ7TrObtg9Bo2PxeB
         HLsYD8yMuYLHvDBiC+iz7lnd7cHZHJabSQmHCvalCGN7tMG910fwTOhzNiTln31hBcq3
         DAb7ZUXeuIOOyVkVEqwSncX9AyaMkKasH5rKKcdvH+zO8qZZxJCamzRrihZHqoogbc3u
         kwIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753675990; x=1754280790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGBbLIiLGqrmFvSwaYDbAojdCre78exL+6ZjHnBuXvE=;
        b=b/0bLSZuqVZMKLbyi7R+714vnV46fHYSKXTig36QK1+GANpCqmb8uq0hm6pKBp6Wzv
         AVzZCgNgitSBEBR2pzqmCzYCHZ7f6vkTIi0c45KirpZsBq5zme7j24S3L7hGqBmznyrd
         3VrYJRovDZBmGsla1qQENdTYzCV9L77u+PE+Yj3DbGpOiTHAXsZgckZ/9sOPaW3SCPYL
         iBl3w/VOggU3/tNxilvy62fUXWQWpUXcvUM57StWjirxAfzNaDPoNQdCn0GZ7aVhGmSG
         ORxiYkpxTQQbgtBH4Vj0+hmPTdByMTTzgJdnL4oa54OjPBg05o3G1ECFa9XaGJC50KRT
         vT7g==
X-Forwarded-Encrypted: i=1; AJvYcCUM+JGpsIw4OZ6NlZH+/+QBS8KCptLt5JobmaSgU/f8LfvrqT8f4tNuiCHP8GDZqaO2EmSyQNPfkEryVANUAVmWVDPP@vger.kernel.org, AJvYcCXhXgeg8lXq+gn3Dp04owI6woUpBKMKypzk+uMxHNEMKYsxNcS+S6VeiEd2V+4S36O0c+s=@vger.kernel.org, AJvYcCXxWgU+mq0KlGatDsMefnD0aBZTYRDKGaWbTZvh3B80/ljOYelgh1n2bn74H3C3KrbbPMNx4WklRFn0n/da@vger.kernel.org
X-Gm-Message-State: AOJu0YxppwLGvNmB4/FHxZLL5Zr1V+TbuYwmeVVsELCeTUMGpIxejuF1
	xmgYTUMBLU1ueAeubExSK05CTFCP19lkDI9TaYIdbsmP26180HpZpsKGuDzVGfnNcd0=
X-Gm-Gg: ASbGncs2VapEI4tR3DuYFho8wvvtLp9jZMFi8AA/3FXnwMCxGXvqacZ2LqU7zVPUE0f
	qZyynVnOAQWF2qyPCTUHsNLQo9ccXW3SCnPw9bMWxiD2Yq2BX6D/g8Vrg4Ni7q7RKRQLwjTUcd7
	hBRqZDherF5DKY5bjG4AqpNJAhPpVCOc1klr04aWfbWZq+cl92Jjz3aCfTtTURy8LZB8wVT1xa7
	0vSGuRFKCn3y6oDwgF7Vd0trOLmc7JVbErsGQEWUWLL6C+Cez1Y9pUNVa8dYV8ludpZxORhy0vT
	XCuJWQrJVf6GgvDRK9B8ER8ED840xRJRCvfsmeXPG8AJL7qFW1XSCP9oa8UK2PeyspGSZgg8UrO
	OyDgYrZeApBgNRkduYjQ=
X-Google-Smtp-Source: AGHT+IGB2pjt0vkcDq6lWjAxS++yOy8gk7moI81oq6LOT4h67+7I5MBC0hse5/AG1yjymEbtYkgE5A==
X-Received: by 2002:a17:902:d506:b0:235:f45f:ed2b with SMTP id d9443c01a7336-23fb2fe1271mr144452705ad.1.1753675989958;
        Sun, 27 Jul 2025 21:13:09 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24008efc073sm20599175ad.58.2025.07.27.21.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 21:13:09 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com,
	mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	hca@linux.ibm.com,
	revest@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 3/4] selftests/bpf: skip recursive functions for kprobe_multi
Date: Mon, 28 Jul 2025 12:12:50 +0800
Message-ID: <20250728041252.441040-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250728041252.441040-1-dongml2@chinatelecom.cn>
References: <20250728041252.441040-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some functions is recursive for the kprobe_multi and impact the benchmark
results. So just skip them.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 tools/testing/selftests/bpf/trace_helpers.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index d24baf244d1f..9da9da51b132 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -559,6 +559,22 @@ static bool skip_entry(char *name)
 	if (!strncmp(name, "__ftrace_invalid_address__",
 		     sizeof("__ftrace_invalid_address__") - 1))
 		return true;
+
+	if (!strcmp(name, "migrate_disable"))
+		return true;
+	if (!strcmp(name, "migrate_enable"))
+		return true;
+	if (!strcmp(name, "rcu_read_unlock_strict"))
+		return true;
+	if (!strcmp(name, "preempt_count_add"))
+		return true;
+	if (!strcmp(name, "preempt_count_sub"))
+		return true;
+	if (!strcmp(name, "__rcu_read_lock"))
+		return true;
+	if (!strcmp(name, "__rcu_read_unlock"))
+		return true;
+
 	return false;
 }
 
-- 
2.50.1


