Return-Path: <bpf+bounces-76142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55074CA8931
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 18:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E7053161225
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 17:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB10349AE3;
	Fri,  5 Dec 2025 17:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuK7fuQN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9369734679B
	for <bpf@vger.kernel.org>; Fri,  5 Dec 2025 17:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954752; cv=none; b=pPMKQLJkKEElnI4XiDZeni3H0Q6I05p9e1pXGHviIyGrQXX8ewzH9qlLoPW4uA6aoVBtWeCPg9WMCSVxXDsEbGodq1akbTsARnXk/9KGj9cpBk3HKnZgxoA1X8UNv5WAtpFfrwYR5iI2VVK82W+LD7dGLTu0zGs1ReBM/iN7jME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954752; c=relaxed/simple;
	bh=TVRX6OVXaN6/F8l3SopsYHbh+ST+dk2HGsZrDg1QD84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YCnJpFjoQRYLW4T92V1zzZTU3urqh1Vwy3X0fFva04gF9mzGLzxQzDtycD08KtKjzeXRhLXZmyqixU/6TO/2Kbdld4ryWNgnOoZyXza4uhcHlmN8USeE5JQBTNpsndznPfIUqez1yO0nOSrFz7kA2S2qBQ3WYQXuu/GneUzRDz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuK7fuQN; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-bc0e89640b9so1555158a12.1
        for <bpf@vger.kernel.org>; Fri, 05 Dec 2025 09:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764954740; x=1765559540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIl/aawA4xeGwYCaPG7Uh3j0tRW+jDxmmUaf9p3hcUE=;
        b=UuK7fuQNuI0rtnsf7Nc33GBdx6dzAfSUeKBvuz7tojI5LL5uZh4PrtvpuiYSBRBeSM
         ALQc4EF1zFTgEOJdSA9/Azvs02cgC57UADu8nM8X/hUYv8e5LBzzofRDfuScv1lfbmqU
         ZZaUKJQBjM5BcLmAbfVdaofY6/tVaNo3OhT+Qk2VokG9/i0l/pBjCPFxlX+yz5lJxMvu
         uGlJDWWBFhfLoUj5DLdlaMMwW48YvUmSAgySVa3+mFNnnWqQl0cpQgFRxLN3aVeJPF7a
         wHwwCt/+MFb8XFzLUn73PPQHYSIPOSIQna7daHzGmE4udWc9O8LjdtN9ZcKkXEEtEg8U
         u7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764954740; x=1765559540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BIl/aawA4xeGwYCaPG7Uh3j0tRW+jDxmmUaf9p3hcUE=;
        b=XTlaelS9hA9YuXxTJZ9hQlAONju01fm6V8Hx6k9VrFGq7AIc/9PBWQoXKDfzu5mXXq
         Nza2NbkRkCXfh1CFmCJkdyqedCfge0WQYrgdtnnTfxCJ4+TTXq1W944HGMnTdGgBXirh
         GdNWraVKpKtYYjnCWS/nJuE+YIRt04wKcnXsUn9a/OzE4dSphMKyt8QYW1QNMWW6Pl32
         n9Gmj5n14pPiFlcNCRedKBdQIvKd/Kl+nABnRzzximTvUdUk3JaKR9aiYNoZ8TQelReu
         4oi+9RbkMNL+YrVu1/Q5USP7sdaHqlNIj8WlVMnXgeAqxCBZ8hpQyjrMnliLXo5MnMaU
         vcmw==
X-Forwarded-Encrypted: i=1; AJvYcCXZ6XSVc9kSobIR2lg+L5zvhrj3Y0NHNCuRqoNktElJwVErEg2LG3v7Bd8zKRijVGzQn+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNQHG5LDMkjzsU5M1P3VtIJJ2DSOPU7oSKbq1ZRN1SBtJplgQE
	mF+u2XNWDUGAkSnWQcoK2qIDsKOTY8jB7+ASannesi1zTOLMKsXwtepg
X-Gm-Gg: ASbGncvJ3h+Ip5ii2/BVv0a/Y4EYOq/ReCoNXdqwJVrPjIMqIyp4j0F7wqanAA3EM7q
	NBxoQd4nUDxEPSOeyQauUDJJ3+cCQp+2LvnXlE3PWs3oFqoH217CyKr06juLoQUFbvorvmbPOX4
	RJmLExVclVBJNf8w0wy/qk/O/1v5pa71A+zUMHvHnasbBua6RjgMaCv1nflgBc2e/GyuRoXHJnY
	fvYbLT7VgH0o4AxVhCj0IK154DpfEAIB++2sgsxSejV5A6TduFXxrebd8vIYChT76TG6RxIHstf
	0Yo3oY1XrNdTRTqXFbddRybOgOrpooUj/jSN7bHd4mUJDncNHod2ambgQmJdQacJhZJsvJcdkET
	p3eppBj8qyq/Z8C2nwbg4m/FVcsL2+DdorIPpzFeYutK7hyotfFeN7Y2gBmnCA1grfZ0Gp79VaK
	P1jnv+PqI8L9OwY6Liocv5zGs=
X-Google-Smtp-Source: AGHT+IGLmu//P31DCy/RNC7sTNOq4cvelmghY7u/vM6nTRJiFEDfwjbdinP/0y5Z7o1g/QEtoGFjOg==
X-Received: by 2002:a05:7301:4616:b0:2a4:3594:72e7 with SMTP id 5a478bee46e88-2ab92e2da45mr5744996eec.22.1764954739092;
        Fri, 05 Dec 2025 09:12:19 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2aba87d7b9dsm20594306eec.4.2025.12.05.09.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:12:18 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Shuah Khan <shuah@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	wine-devel@winehq.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v2 07/13] selftest/futex: Comment out test_futex_mpol
Date: Fri,  5 Dec 2025 09:10:01 -0800
Message-ID: <20251205171010.515236-8-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251205171010.515236-1-linux@roeck-us.net>
References: <20251205171010.515236-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

test_futex_mpol() is not called, resulting in the following build warning.

futex_numa_mpol.c:134:13: warning: ‘test_futex_mpol’ defined but not used

Disable the function but keep it in case it was supposed to be used.

Fixes: d35ca2f64272 ("selftests/futex: Refactor futex_numa_mpol with kselftest_harness.h")
Cc: André Almeida <andrealmeid@igalia.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Update subject and description to reflect that the patch fixes a build
    warning. 

 tools/testing/selftests/futex/functional/futex_numa_mpol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/futex/functional/futex_numa_mpol.c b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
index d037a3f10ee8..8e3d17d66684 100644
--- a/tools/testing/selftests/futex/functional/futex_numa_mpol.c
+++ b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
@@ -131,10 +131,12 @@ static void test_futex(void *futex_ptr, int err_value)
 	__test_futex(futex_ptr, err_value, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG | FUTEX2_NUMA);
 }
 
+#ifdef NOTUSED
 static void test_futex_mpol(void *futex_ptr, int err_value)
 {
 	__test_futex(futex_ptr, err_value, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG | FUTEX2_NUMA | FUTEX2_MPOL);
 }
+#endif
 
 TEST(futex_numa_mpol)
 {
-- 
2.45.2


