Return-Path: <bpf+bounces-21146-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CCE848B63
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 07:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1D21B23EE3
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 06:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21756FB9;
	Sun,  4 Feb 2024 06:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6oYuvCu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21AA7465
	for <bpf@vger.kernel.org>; Sun,  4 Feb 2024 06:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707027131; cv=none; b=cUupfl5wloYWFeipyioSh+YzGczFHWfxpqW0Puw3uP6yunrxZaODKMdMRduOTLImbTutqRpL3cRZOqhFTgyBr9YTCyuCpqK1MBDCDUS8dJLl+GhFXtr16mmGLHNLOSglsqEbkCmpv7zbLMaiGkB1GN9m0mngz1gYY5dJxpMJkdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707027131; c=relaxed/simple;
	bh=F1mnk6rlPVvAnSi8LuSpuC83SDYYdYaTlE3E3xZHg6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k9OgjWLTYvFZi/VbERB3M5pe6P7WZvlw2QuDtiswGOH/h6vJV/e8i6KXK45RsQ1LxyCf8QdzLXp6TkFyrt93DQvt+8CBIFoDOmAiOrDbDEPdl/1+TcnX19VycDSXXEsByxhLhSquwmANPTYO6te18nmXgPxT57sacDrkp4IV1o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6oYuvCu; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc6d8f31930so1620506276.0
        for <bpf@vger.kernel.org>; Sat, 03 Feb 2024 22:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707027128; x=1707631928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OjOkl8TR5m7c991IP3OHFvLgHZM5L4pY8uVulxwWeD0=;
        b=R6oYuvCuZyAtH0AFjxVq0E4qkAnOG4d30CDYx3HwnZ07S4ZdbrjNXspqrurlL6VBaL
         h5Zguig1jLcvnhu6qFL90o97YlhzZwGinWXMXL3jg0bi3smw/Fskt4vXl8mZXq/mSJAt
         B9UDvo7PQV4LCcdy/9KqP4DN1f4HEaHr7iAYrxJMbW3c9hd0FaQ2J/K2DadqcXf1Of37
         XFJeJGQqUlB+ScjqzUre5N80/Cmne28GsU9gnMu9+AYwIUAKsjM1VkB3/zrEeMglksis
         IMsahnBFB8Gi5cbod3Q0tbvy+6GwGwX7bg42LoQNple3DGggyO5Q+C+wieY2uNh8FGQH
         gy0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707027128; x=1707631928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OjOkl8TR5m7c991IP3OHFvLgHZM5L4pY8uVulxwWeD0=;
        b=H4Bm0mEFFWcFOj7aAXRtKjSBGpRbaVU0Md2fja/LdoE9nv+F6v0fIkYfCeSNfQPUHu
         ZeXUVqySBfFkt67KWUDAlMaS9Pvhfls0RZOfv26hREecUNCD07h/zd5175WtZ98btgBT
         iycb4CJzGH5POT01gaqT1wPWgbhDNiYThL2JxTqPEikNXPcByIxoOVHbeVLjn0litbW6
         d/HVR1kXTmZhy4vaQK70cfazGDYGtmzKM/tK6hSMe9drNRhmvqle5sjSaQa0DSELrSh0
         9nWl7ca6ndoH0JwPfuDq82juhe5/9y7DOKfPdqmkPosj55vVS9niw47VLAQcp8ULTEIK
         IEzQ==
X-Gm-Message-State: AOJu0YwAHm2Jf06SLvU+1y5po9f81VFsNUueIgv9mzKah8SOKprAlAH5
	tRPbefWc4eKlWOj0N8ztNqtpnpQT0MeALImvRIoCyaQnImsdVmltzTtc4i8T
X-Google-Smtp-Source: AGHT+IH+WQjISkB+VJblzBRIeKUoxj1KzzzdzEcuvR44xpV9NE58pPLlC/G7RBdmiXJI35U+5D/5nw==
X-Received: by 2002:a05:6902:1b08:b0:dc2:1f6b:be4c with SMTP id eh8-20020a0569021b0800b00dc21f6bbe4cmr2083892ybb.22.1707027127976;
        Sat, 03 Feb 2024 22:12:07 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXK5WvONyIdjwn9PfFegMcK7gRQZ/PelUubnOww3lvbCgEvkOTak0fHb0eGgxYkQBOjgeCb1o39iKrWzp+xKrczFHTGXWLWNrgHJEp95C2XUVJpnAVKN4VEQM3wJhw04mlMCxGmA5sDGO6lfjsZmnfn9fSB8I038xsYFEZCeXLYgvBOhDbD7TQn3UJySMJMD4jW+aLs1okpPFLk9jYew0NQ8Nj+H2MaNsg7P6BtoZ9EUXVxuR0J2XNEtOzVoVDOgCwWeXRR7w==
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:b976:d178:add:46ae])
        by smtp.gmail.com with ESMTPSA id u16-20020a250950000000b00dc6bd47cc03sm1231958ybm.5.2024.02.03.22.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 22:12:07 -0800 (PST)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH bpf-next] selftests/bpf: Suppress warning message of an unused variable.
Date: Sat,  3 Feb 2024 22:12:04 -0800
Message-Id: <20240204061204.1864529-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

"r" is used to receive the return value of test_1 in bpf_testmod.c, but it
is not actually used. So, we remove "r" and change the return type to
"void".

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202401300557.z5vzn8FM-lkp@intel.com/
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c | 6 ++----
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h | 2 +-
 tools/testing/selftests/bpf/progs/struct_ops_module.c | 3 +--
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 4754c662b39f..a06daebc75c9 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -554,9 +554,8 @@ static const struct bpf_verifier_ops bpf_testmod_verifier_ops = {
 static int bpf_dummy_reg(void *kdata)
 {
 	struct bpf_testmod_ops *ops = kdata;
-	int r;
 
-	r = ops->test_2(4, 3);
+	ops->test_2(4, 3);
 
 	return 0;
 }
@@ -570,9 +569,8 @@ static int bpf_testmod_test_1(void)
 	return 0;
 }
 
-static int bpf_testmod_test_2(int a, int b)
+static void bpf_testmod_test_2(int a, int b)
 {
-	return 0;
 }
 
 static struct bpf_testmod_ops __bpf_testmod_ops = {
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
index ca5435751c79..537beca42896 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
@@ -30,7 +30,7 @@ struct bpf_iter_testmod_seq {
 
 struct bpf_testmod_ops {
 	int (*test_1)(void);
-	int (*test_2)(int a, int b);
+	void (*test_2)(int a, int b);
 };
 
 #endif /* _BPF_TESTMOD_H */
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_module.c b/tools/testing/selftests/bpf/progs/struct_ops_module.c
index e44ac55195ca..b78746b3cef3 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_module.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_module.c
@@ -16,10 +16,9 @@ int BPF_PROG(test_1)
 }
 
 SEC("struct_ops/test_2")
-int BPF_PROG(test_2, int a, int b)
+void BPF_PROG(test_2, int a, int b)
 {
 	test_2_result = a + b;
-	return a + b;
 }
 
 SEC(".struct_ops.link")
-- 
2.34.1


