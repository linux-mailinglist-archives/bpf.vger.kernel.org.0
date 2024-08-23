Return-Path: <bpf+bounces-37923-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CED95C761
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 10:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8AB12868F8
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 08:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7385E14037D;
	Fri, 23 Aug 2024 08:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asABzpEs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30074A08
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 08:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724400423; cv=none; b=cDWm5vJz2iyi1XniOnAPcMsb+vOAM7X6zxL8wueajWwWF9CC2YKkJmX5g3dNGAVJUFaQ5kTIZK6p+V9+PTA1dkXlGPYDx+8pLD2cKz1splmsFd1E5djlsQ79mCKEHIvk/38Ano9Xx1/Wj8Okg1hGKzNQzoewg7znvajl3eyPy2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724400423; c=relaxed/simple;
	bh=VeLM5HyI97tLEkBQ+UHzTWaxBChts7r+AVjeRb/3Abs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lpNz3hcn+1cDWJe2qweS0SmMin2seRdT6SInm/69qC5wqNTtEJGpq3tEo5vIdJIZ9b707MYe0WSqywm0kYREMvVIf/pMOR0oQI/jqJF2Pbo1Rvw/scGyrman+GyEe2pI19HyAojkDH1iiPlCDFuBU8vJNhcz69HuODYlL/PJoao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asABzpEs; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-201fba05363so13881655ad.3
        for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 01:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724400421; x=1725005221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFjfH3Q7I2fkEbcO1C3+5RtO/EIwRd/dal+BkGGs7Pk=;
        b=asABzpEsxXyNMY3ObHMyjpjp9sWMkwjKvap7gcDAmfeDbxi6nCZHA25bT/AeBS4I3c
         euOrB9CGqSzOLq1stfapgavu2UVQA/9aLhbK9cBHr2JdG7DH+DVZBmP4tQad89G390Lz
         dPdP1qtdy1tZRvHl4euS/soDWGY9HBhAv3mHiABALnq91wVqIFXBF3bU7JtyYiWCg+qr
         3FnmaoM3TscJ1KGt2LtEPqGf73xWOA7svQyU/yAE0l0F5LmKr/VKJvlfG8siZIXB8+eb
         AMCS7Wb6YFsplL9ej+KFzoF3CpTt0ULyCWO67C3WXlpe51bORZ0aGtBtF10azq63ggQn
         cpmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724400421; x=1725005221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LFjfH3Q7I2fkEbcO1C3+5RtO/EIwRd/dal+BkGGs7Pk=;
        b=AV14L6y1q0Me2r9f68XYyC0xlIHKy0BzxYKFJGHjF3ekQifCEPAO4c7se4/ObfdfwH
         XbKe6xovmo3Mod7P1Lxl4mJaQGvJeDQdIZhznZg9b/7KR/lB0eDBmDjfKEhd9RE5jWok
         OZs+5lpkP7d8FVcr6igJAJzDQPqbYBnOZ/K/dkH1Q6Y2AcwxWnfmGYLQI5piwu9ykYyu
         S/bhgXawQdYFno7/mdznt2d/3Ni8wKg8CEKVT3VSu/mH7GjaSaHOCXZGCTjBKC46/jNU
         eB1zBREX0s21dC6QgSYLp4qq7TtfgQp76DgHvIhYRgGs30efNiBGaSV6yOGVHWbXZ2NN
         1exg==
X-Gm-Message-State: AOJu0YzgW4M35zSzQ3ormgxngejKMGG6lWkLveOggjhHgSoXUTZnbbg7
	7MG7d+ZBmKuO3/+SvM9xCrIYVImjYn4J7xX3v8Hw5/Llp1CmBol9qk4PhA==
X-Google-Smtp-Source: AGHT+IHAfpHhUCe5V0u+yuFEozmMeKYV5G1mchnB0aSZG43BmcTKxNztGbQkEo0Xte7n7sGi629mUw==
X-Received: by 2002:a17:902:e88b:b0:202:54b8:72e5 with SMTP id d9443c01a7336-2039e4def47mr15799435ad.22.1724400420666;
        Fri, 23 Aug 2024 01:07:00 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385567f74sm23463925ad.60.2024.08.23.01.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 01:07:00 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 1/3] selftests/bpf: test_loader.c:get_current_arch() should not return 0
Date: Fri, 23 Aug 2024 01:06:42 -0700
Message-ID: <20240823080644.263943-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240823080644.263943-1-eddyz87@gmail.com>
References: <20240823080644.263943-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At the moment, when test_loader.c:get_current_arch() can't determine
the arch, it returns 0. The arch check in run_subtest() looks as
follows:

	if ((get_current_arch() & spec->arch_mask) == 0) {
		test__skip();
		return;
	}

Which means that all test_loader based tests would be skipped if arch
could not be determined. get_current_arch() recognizes x86_64, arm64
and riscv64. Which means that CI skips test_loader tests for s390.

Fix this by making sure that get_current_arch() always returns
non-zero value. In combination with default spec->arch_mask == -1 this
should cover all possibilities.

Fixes: f406026fefa7 ("selftests/bpf: by default use arch mask allowing all archs")
Fixes: 7d743e4c759c ("selftests/bpf: __jited test tag to check disassembly after jit")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/test_loader.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 2ca9b73e5a6b..4223cffc090e 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -336,9 +336,10 @@ static const char *skip_dynamic_pfx(const char *s, const char *pfx)
 }
 
 enum arch {
-	ARCH_X86_64	= 0x1,
-	ARCH_ARM64	= 0x2,
-	ARCH_RISCV64	= 0x4,
+	ARCH_UNKNOWN	= 0x1,
+	ARCH_X86_64	= 0x2,
+	ARCH_ARM64	= 0x4,
+	ARCH_RISCV64	= 0x8,
 };
 
 static int get_current_arch(void)
@@ -350,7 +351,7 @@ static int get_current_arch(void)
 #elif defined(__riscv) && __riscv_xlen == 64
 	return ARCH_RISCV64;
 #endif
-	return 0;
+	return ARCH_UNKNOWN;
 }
 
 /* Uses btf_decl_tag attributes to describe the expected test
-- 
2.46.0


