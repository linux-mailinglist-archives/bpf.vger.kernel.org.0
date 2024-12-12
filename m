Return-Path: <bpf+bounces-46694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1DA9EE2C9
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 10:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8A3216175E
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 09:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECF421018C;
	Thu, 12 Dec 2024 09:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDy861Qi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2C720E713
	for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 09:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733995262; cv=none; b=oSp5Yq4Fif3MGgMu9nay6BswJgz/o+d+MSKJgkQJ/BaR/Uj9LLGBY3eDFRdVCtfXMCrf7LdSUzmD5lKbLch5qwTS2y9hfXsiQTb/4HMC77dIv47zQP1caSLf3+MzrFSwI6vP4oWIR30ZyZHF9CQIENHbzm28wwck+MMtOZaIgdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733995262; c=relaxed/simple;
	bh=3FeL+LSAzzUM1JHR35P0Gn+fthZcmBx8DJpr0JAlEM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ricw+A1UV78W2vsYZOwdwMpBLbD9E01H1rHwt9e6iPKbufHWEgSeR12BGGhIQ1wLzCnsjM+/NvjGKDWSMAf/YlF0+45Deh27FFn4+IHVoLh5jLC5gNhN3qR8vRw8AgTfbTw9jpiMqtqnDhBaSplDXifGrfsyKyCJpG4TmJcA7Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDy861Qi; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-434ab938e37so2379205e9.0
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 01:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733995259; x=1734600059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z817xWZRfYYjq2ugAx1OeHBpFd1h2d1IdV1qFY+M+OY=;
        b=iDy861QiXqaO+fdqmuv5BBPStSt9cT/viI5DKfNrC3L2vO15fNLkMjiZRzVuxBgCLI
         DsMQw4yMxUMJ7wK4nYIM0enKrBEvMyjMMWzxF5hN5VFY4IwrLg0JcO5jxsi5Fqs/Ynv5
         CHAel22Ew4VGNL+b2VS4PdBoA1S+dSEvu3L1B3RVAbopYNwQW/NORUBXqaw+NIp8bk+Z
         Xi+GN/T3mTyc6bZGbCRA5yDoH/hHQQ/fc/itEOKe8r0/Z86A+5uV1ynLWd5/1u2aq5mD
         4NhYV9V5Tq2xZ6LlZX8DJSfihJto3IbLq+RXddN7+C9XHomY55oYg18Gle2zj1zdzsK0
         NtdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733995259; x=1734600059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z817xWZRfYYjq2ugAx1OeHBpFd1h2d1IdV1qFY+M+OY=;
        b=VfCLeZuXt1yy2drkhrd2JDJs5v3bBl3kjXkr9ohdyhHg4rohovHrNhEVpTromyI4LF
         MsM7koQJtmHrsGkXdWMQr/YawpHGp8HOCRKSnumVwOyg/Hz2XsQF0ZhObEa0EEibBMEt
         PihH3TiluVNYjaT76gHQqSUB2VkpqlMkIV01syCYphTjiUgyG9OzW3KfWK99JcN3q+FK
         91Q6C6HLFyc9gk4TW4iUm2u0sB01v2OK1SfbTlJHewkL3RPQJ3gkHXO+qrHzT7KfZI9S
         1yEMHXZSn8peUCFw6XxgQgp5YcZFgqd2yNWh/MWbgxEtczm439hnQg+7ykg1Wie1M64O
         sbQQ==
X-Gm-Message-State: AOJu0YxxNefVQxfoWP3Bm1jQBR5QR++rHYC49aGCo8CIAXWLT9IzNPou
	XXGbcsqlym6w4q4Uj4CYQfjSPIp2Hm/9q9O/+32ek1tclxWvCOOohTSesHZNJzQ=
X-Gm-Gg: ASbGncuKguAqTmIIzwq2p7DoB5bREBFJB2TDI2kTJYF4JFRZqD4XLm+y1eu1ZYPgsov
	5EVeoZ0PJldT2RHuy8rza/Bcxnj5UdvlsGcA3aHFZ7VjVdITtJKhnt+RbYXc7N1qCMQFRgfotJk
	SNUFLFhV0wwnIHjSQ/T5kJlKb/CW7UBpLKinm8U0v4uWCC1eHj5D+xlKIaGSxmbMUvyeYcsAGlH
	5sJqwG1fvAfjG6ESltO0YCT+HkLtzN3QrccjA7uPUZ6OWTA/jDCBcRahuEuHOkaYC2fkGf8tw+O
	3jkHDgg=
X-Google-Smtp-Source: AGHT+IFXbs5ZHMWQ+/Foo9VBERYYCleNbaoa9CQos6rZ0iIuO/26rg+bZBYYe8hzo6p/rYUp5qmc9g==
X-Received: by 2002:a05:600c:3541:b0:434:f131:1e64 with SMTP id 5b1f17b1804b1-4361c36f796mr46870885e9.9.1733995258850;
        Thu, 12 Dec 2024 01:20:58 -0800 (PST)
Received: from localhost (fwdproxy-cln-007.fbsv.net. [2a03:2880:31ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4361ec88993sm21579975e9.2.2024.12.12.01.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 01:20:57 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Robert Morris <rtm@mit.edu>,
	kernel-team@fb.com
Subject: [PATCH bpf v1 2/2] selftests/bpf: Add test for narrow ctx load for pointer args
Date: Thu, 12 Dec 2024 01:20:50 -0800
Message-ID: <20241212092050.3204165-3-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241212092050.3204165-1-memxor@gmail.com>
References: <20241212092050.3204165-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1787; h=from:subject; bh=3FeL+LSAzzUM1JHR35P0Gn+fthZcmBx8DJpr0JAlEM8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnWqgv6y0jPmvB0hh29ZzQRJfPtqf+bAhkfMSkDHo0 veECkBeJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ1qoLwAKCRBM4MiGSL8RyoXXD/ 9+4+39zAxJalddlCbzU8UuLsWxKVJ5hXKNbIwOM0+xWJRjQ48DDydGNZtO4caY3t0bT3pHjegZB0vv AhCoZudsawIsN4Fnpy3/HKvPr8MsDovityySzs+MpDGlBlZd4kTfIP85gOnyAOMN8W/bplkmNxR0xM Yjf2vddoRhKD7mXbCrMxEaviKKpjZ0QgYIPUiXcL0W/FLtTvm2PG47XFYCbISh5KskyA1pv1+0/E2u lSGTTLVr8DWMhcnX1eDxdI3BO+vVXlJyCi1vD2qYn8BCwSTKRYnEpsVZtURNC1jxq0NImLojJ23lXi yuO7te27uCorX9ygEPzgZwtovyUlR52VcRUJjKn2w176Str8T7Qkd1+go+C2CKTMYxDOFZ/BtrXNSH vC502TQhg3S7DM12DQXmNUbgjN9ZjZVY/bkf2pch0yUlc1c0HhGW8GFLESKSgQWgBu67j07iDa5Ow8 UMZgBvMdPZoFYThtWeeNJ4iLaFAH8mc5RuOBTpDe4jj4yflY75c9QHaGm22QKvJqNSUTFQpMLwAi0O +ZTHi0H0xAvKD7GMSSFlExEJCPqHpZTOA6f5Txpz6PVQjOw3Rgntm023hWCYx/kWLJ15YB9xsMuBpb ps1A+hpcvX1H8tg3h/STTSDzkEdWzvLmFNPsz6Gt0D4eE4QVdID9iHfnT4Zw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Ensure that performing narrow ctx loads other than size == 8 are
rejected when the argument is a pointer type.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/progs/verifier_btf_ctx_access.c       | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_btf_ctx_access.c b/tools/testing/selftests/bpf/progs/verifier_btf_ctx_access.c
index bfc3bf18fed4..28b939572cda 100644
--- a/tools/testing/selftests/bpf/progs/verifier_btf_ctx_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_btf_ctx_access.c
@@ -29,4 +29,40 @@ __naked void ctx_access_u32_pointer_accept(void)
 "	::: __clobber_all);
 }
 
+SEC("fentry/bpf_fentry_test9")
+__description("btf_ctx_access u32 pointer reject u32")
+__failure __msg("size 4 must be 8")
+__naked void ctx_access_u32_pointer_reject_32(void)
+{
+	asm volatile ("					\
+	r2 = *(u32 *)(r1 + 0);		/* load 1st argument with narrow load */\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("fentry/bpf_fentry_test9")
+__description("btf_ctx_access u32 pointer reject u16")
+__failure __msg("size 2 must be 8")
+__naked void ctx_access_u32_pointer_reject_16(void)
+{
+	asm volatile ("					\
+	r2 = *(u16 *)(r1 + 0);		/* load 1st argument with narrow load */\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("fentry/bpf_fentry_test9")
+__description("btf_ctx_access u32 pointer reject u8")
+__failure __msg("size 1 must be 8")
+__naked void ctx_access_u32_pointer_reject_8(void)
+{
+	asm volatile ("					\
+	r2 = *(u8 *)(r1 + 0);		/* load 1st argument with narrow load */\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.5


