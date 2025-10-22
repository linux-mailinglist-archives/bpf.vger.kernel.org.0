Return-Path: <bpf+bounces-71690-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C19BFAC40
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 10:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E6DA4EB8A2
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 08:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D39A3064AE;
	Wed, 22 Oct 2025 08:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1mVyeCK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8663002B4
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 08:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120171; cv=none; b=Ta9LBcDsAIlTR6mUgXiPHJ81uHu9l7gnMvIKORx9Jeyu5VN7JXW41KJf7ZsLa+UtRPCxO781Lp9UKbyXo0jAmUt30vWYMOQRIcLrN/F30wYFX7AvhCIiHUqoD5BSEKOnhgDQsLwijDgXBgBFstfTEsqBU9yKFbU9+bFhs6/kll8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120171; c=relaxed/simple;
	bh=rQf7cIrqXhFpdtblFtlpnVlrPiULOyK/btzySltR7Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ahecw4n0Dhoa+pb8Y2KdHmZDs1pNC57FbdVxrLYPuVRmVY4Qx/JEtgKzLINIwbn9L7pOYQ4s/xQkHIhjUNwl3ocxLJoCbqeVj/dfv8Yf2Qd8ztXY5qk2pRlBg42D6KT0jLWWhQQL69CwQJgHM7i3Bd8vVGQhnDtEZ8qkyjAdwRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1mVyeCK; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2909448641eso8022325ad.1
        for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 01:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761120168; x=1761724968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+bk3eU07EvQuVpjQM0cAE/sVqM0p3Ty+ZMGLS++KRY=;
        b=V1mVyeCKE+Q9LEaLKeIrx72B+GuhCR9jVF/hn52WBMOjS6j+Yt7zj05DiUAuv2M+HQ
         jCJohRUmL/Yy3qItpLMwb7w5Ca/evKBh5ZprHUVSZELj5EKK7nBVnYrO0Dpf/dlTQYvE
         aix3FA+DKj83vM/LAV5njgNFN561B1XAOW4/fGU28NvbUj9UFB6aqegXTD/teeG7oPhN
         0eki1RCmJpgBdd8dKN+tDHMT8rI0oP+YgQZyrwtD7u8sibBGTaLFtDO74ht+SySDHnbl
         YWdAbO9N7oQKecjb6E7UA2xkvyW+1wMhqCoo0JokDwDNobfKT2xniYZZJ9W9W9rAlUrx
         vnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761120168; x=1761724968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+bk3eU07EvQuVpjQM0cAE/sVqM0p3Ty+ZMGLS++KRY=;
        b=T4YtPtCFb+uE8g8gt/fCVjGljR1M7rbtQf+Y4zwSMDbU/HSWRioJ5Z0u40D7JhLCIM
         HIIf420455P9tUp5i4UsiVNUQfUQ8SOh92EPaHb5AmWK9PkTUIHk+TIsnnhkNMvlVlCk
         4fAu9TKa+ShW6InvSv1MYPq6L+bMnw3+Blupv9oQtq27s1ed3GnL8VCgU10PWruktsam
         hD/cBbeoPjbdSSLH8ZnDZ48BY4Jr+b+9HJAvqbd2o6nEI84ayfpUhjqVeKR4wpgUHDmL
         UDbtT77fWaJImsRg014rNoaJmMAy++fykriDbIriROC86PoEAzbNxybT1FOGM/HruFa6
         i0FA==
X-Forwarded-Encrypted: i=1; AJvYcCWumlf+gnm1A9z4h/2K2I4apxASbddGsqvmqYt62jZiCISP+wJ14tnecI+5h90WO+CyQiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQdCC3B5fRhmhRIVFh3aewB3xru+8f+00I5TklWsNkLnHGmjFK
	0HdATSzLVrE3hzycue2vuo43xVUkF+6Ihc4YAwRlVI0EWrMqHcCFlEcR
X-Gm-Gg: ASbGncvNUtOkpECCXcRWodRQUBsberG8+XsjwSlMSTHMYnfLf2mfijbSS8sgMNR8abI
	Ic23s6fwr3fkcac/TC6Ot/FCtX6pDh3gPRt1LJwdivqOIm3ATk39NUyAGC+Ayd3pwXH7ugH1obY
	80V73TmKFxh7EflKOENDs7YG3GDqWhZc4RiWfhUNTJBi9bqhEq07R7k2XC1GAuac0oElf0cbx5D
	JEWT98KEgdYu3NMH8CEV9WDFeTU6WAA0AiW8clWJmQAHllUZZjJ7RTqf1BpUpFdqEZtgeKGhC6I
	yYlXN0j8FeNrLcfj0VmvgbAxKDFIbznsBJo+zzFBLD4jSBQrDu2UcR68fjqESVNDvYLCd8EZuKT
	H6Jo81yS1bn1o6XQLXd+M/so+aq7+wazO7g1NrPgh/FfEG3gGUa6q0EoMwij4cE/KWg8stRtLKQ
	C6Yu61ecg=
X-Google-Smtp-Source: AGHT+IHZbqWhKjaHa1YFzTTsX97Y9CCMc06jcvSVZQudwp5xfmvGDzbBnbpMm0kvVeibqCwk1ty0Xw==
X-Received: by 2002:a17:902:dacf:b0:271:fa2d:534c with SMTP id d9443c01a7336-292ffc32da1mr32740295ad.22.1761120168058;
        Wed, 22 Oct 2025 01:02:48 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d7e41sm131947785ad.57.2025.10.22.01.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 01:02:47 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	jolsa@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	leon.hwang@linux.dev,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 07/10] selftests/bpf: test get_func_ip for fsession
Date: Wed, 22 Oct 2025 16:01:56 +0800
Message-ID: <20251022080159.553805-8-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251022080159.553805-1-dongml2@chinatelecom.cn>
References: <20251022080159.553805-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the layout of the stack changed for fsession, we'd better test
bpf_get_func_ip() for it.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 .../selftests/bpf/prog_tests/get_func_ip_test.c    |  2 ++
 .../testing/selftests/bpf/progs/get_func_ip_test.c | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
index c40242dfa8fb..a9078a1dbb07 100644
--- a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
@@ -46,6 +46,8 @@ static void test_function_entry(void)
 	ASSERT_EQ(skel->bss->test5_result, 1, "test5_result");
 	ASSERT_EQ(skel->bss->test7_result, 1, "test7_result");
 	ASSERT_EQ(skel->bss->test8_result, 1, "test8_result");
+	ASSERT_EQ(skel->bss->test9_result1, 1, "test9_result1");
+	ASSERT_EQ(skel->bss->test9_result2, 1, "test9_result2");
 
 cleanup:
 	get_func_ip_test__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_test.c b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
index 2011cacdeb18..9acb79fc7537 100644
--- a/tools/testing/selftests/bpf/progs/get_func_ip_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
@@ -103,3 +103,17 @@ int BPF_URETPROBE(test8, int ret)
 	test8_result = (const void *) addr == (const void *) uprobe_trigger;
 	return 0;
 }
+
+__u64 test9_result1 = 0;
+__u64 test9_result2 = 0;
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test9, int a)
+{
+	__u64 addr = bpf_get_func_ip(ctx);
+
+	if (bpf_tracing_is_exit(ctx))
+		test9_result1 = (const void *) addr == &bpf_fentry_test1;
+	else
+		test9_result2 = (const void *) addr == &bpf_fentry_test1;
+	return 0;
+}
-- 
2.51.1.dirty


