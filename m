Return-Path: <bpf+bounces-56648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD556A9BA7E
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 00:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12AA5467440
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 22:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F7028A1F3;
	Thu, 24 Apr 2025 22:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FavL/Zp9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9DD28935D
	for <bpf@vger.kernel.org>; Thu, 24 Apr 2025 22:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745532904; cv=none; b=tCNuMhMUBAjL904pw2geDz4Nklzj1hcRMj/C42hLjNAlAjADeapT8khLv1WGiQUmWIGBdfcXI5G1wnueaBYH32E7qd6KVsxSE/nm1PIeAx6PQhmHLhoK8XbyGiX+WJV33p4O9rAbeWI5o9RJNPVF9KZkZ1i2CsAFuQTPR9jfC/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745532904; c=relaxed/simple;
	bh=4i3s/2nHarO04+oMVn8Uz7DOdT6EKaS5QhII+voZm7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OrRoId03FmwoB4gFxPimz4/wXZyRsMRciLRqUgtF3Uz7henKaMP9mL/uHBIHOTzS6eIv62DlTiiCM/e9/2kfnS76WD5y7fg+dI59DHbYJ8nEpN3NaPhcRlJKkP9YyhMwT8kM+wyefdrD9CprAIPw1hNAQrVIHcrLgO0pXwPJvoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FavL/Zp9; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6ed16ce246bso8682956d6.3
        for <bpf@vger.kernel.org>; Thu, 24 Apr 2025 15:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745532901; x=1746137701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PpVfnOEQuZhyZsUzUxECGMMhhgWm8Cay8T+HkujJNpA=;
        b=FavL/Zp95Udzabj1N+DMMP1h8cqkB42qHM1eDtl1DD5cHhXiqKJIJwgj2tO+J5Iqlr
         GvCzNzd+V7mkdQ5LJNcNvdx5B5SUa/8zlAZEbqYbrBYVqKcSvNgMmj6Lp4I2E9ianolG
         lkaGjf4Zc8LZQFqXM43vlPHKW6DAG8iGyLlfyFi+ZbEarFmBxc/Gppk1+vZ+yXve2s1O
         adhO5B+lVdya2iDtw0BO6oLO2FM9XUWf6Bf9IKXsqrV2ToFrweY8+WYzYJfOZc9CYLCR
         0NIEr2k35V3qx228BiAci9tuFPvB00AaICJ62gX/Us6AjhhBYOiJBgMRrihfVwFu3r4g
         bm2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745532901; x=1746137701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PpVfnOEQuZhyZsUzUxECGMMhhgWm8Cay8T+HkujJNpA=;
        b=dcebtJBhgOZ9hjI39RaLT4rnG/fd+ir6chweKDGF3g3g0pjB9nlEv7qhshaaPYgLd9
         vI9Ywj/Op7D9cN/i4Q53vDnNZmlci6G1blA7pHgzRMSaltsh1hIA19v9LMcppFyiPED7
         yiMe44T5JAHejwaQPBwWmFMfOAAA+Z6+RCb/xgqgspZ9gg0GlPISiQ2aaBrEZd7zd3Ue
         hXeh5vPBr6zuYUZqnZLgISlwVKZvSrRj7A5bzcII6A1XXQAE0tm2ppt0kl5BcJ95ND0j
         bERBSY3QQMzbe8dSvXO49NawU1cRrj2uBjjhWbBFQiLBO1KIRrbZP4ddg14/Sa9dcJEF
         2tig==
X-Gm-Message-State: AOJu0Yw1yfRXmfPZjlBj6MwuGW9MkLu+caVzK31D5jeGJNqHwP3jguHb
	1rUI5S2dk93Qy3MkmwRFhcLDyAiAZh+llGGvRchJPTEsQbzZgg7RgmnoONRPiYzQ9A==
X-Gm-Gg: ASbGncvP8o71lgjIkTVu7LHQUC7fYpNw4pWeZFuSmF7AoxqTR/t0I/L79jsw8LESQo4
	qYbabRBIp9qFNmo7+lPbRUKe3mIStg1R0GJWavP4V6RcYqQ3ay9WzaUiiMfU0bpeGgGbO7pfA5r
	RaYXPwQcLqiv+Z7RH8O8E70VKfwELUbSuPIJ0BQv2jR+uM447XBD9qbgZrv3abxQXQQO8N+57+t
	6j8huMkjP/Za/aKt+xbtwvVndN3bFgc1rgQObjKr/LS6DA/Ach13KDgUSEXM+a42fqJQO5KxlUJ
	om3gigq7wc9/kvR7QDuG8o9w8E7z2jbC5F66t/roBtGlax6q96gBl5odEcNSJSKt5qJbhJCzDK9
	/cOjf3QTsh0+/FGADmA==
X-Google-Smtp-Source: AGHT+IHGuni4azmESJ+k6O6hd05DXiX9R1mzVCFYgdWxlxYR5Nb8mev8lR7glzuiO0DDaruVAbwfVQ==
X-Received: by 2002:a05:6214:2423:b0:6ed:1651:e8c1 with SMTP id 6a1803df08f44-6f4cb9bedbfmr2398826d6.13.1745532901141;
        Thu, 24 Apr 2025 15:15:01 -0700 (PDT)
Received: from localhost (pool-173-68-184-64.nycmny.fios.verizon.net. [173.68.184.64])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47e9f7a820esm17673281cf.41.2025.04.24.15.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 15:15:00 -0700 (PDT)
From: ">" <jonathan.wiepert@gmail.com>
X-Google-Original-From: Jonathan Wiepert jonathan.wiepert@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jordan Rome <linux@jordanrome.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jonathan Wiepert <jonathan.wiepert@gmail.com>,
	Kernel Team <kernel-team@fb.com>
Subject: [PATCH bpf-next] Use thread-safe function pointer in libbpf_print
Date: Thu, 24 Apr 2025 18:14:57 -0400
Message-ID: <20250424221457.793068-1-jonathan.wiepert@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Wiepert <jonathan.wiepert@gmail.com>

This patch fixes a thread safety bug where libbpf_print uses the
global variable storing the print function pointer rather than the local
variable that had the print function set via __atomic_load_n.

Signed-off-by: Jonathan Wiepert <jonathan.wiepert@gmail.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 56250b5ac5b0..ea97a84460cd 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -284,7 +284,7 @@ void libbpf_print(enum libbpf_print_level level, const char *format, ...)
 	old_errno = errno;
 
 	va_start(args, format);
-	__libbpf_pr(level, format, args);
+	print_fn(level, format, args);
 	va_end(args);
 
 	errno = old_errno;
-- 
2.42.0


