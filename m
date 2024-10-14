Return-Path: <bpf+bounces-41863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB4799C9C5
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 14:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 448401F22EDB
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 12:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DF319F434;
	Mon, 14 Oct 2024 12:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siteground.com header.i=@siteground.com header.b="s0J8aG9x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0961419F436
	for <bpf@vger.kernel.org>; Mon, 14 Oct 2024 12:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728907930; cv=none; b=AD7Lg573F4UQ/AKXrP6beVKqrs+AtqK85nyziDL+nAkl0DzW7n7e0VaE7FpkI+AdpPxJwuHYzW7geZh4yLivIo9zYnPhK5cJ9zmNtPSYmLtAdP9sMx8JCSZLZLWUTuVfNq8eacPwRPJ6scDK/0QVH14OoufR6vT9UOTqqoElp5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728907930; c=relaxed/simple;
	bh=EesEq5KutfLQH0arHJ3NT+k1If3/I2XC+AKBxNyei6o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MGhuavcf8ZiOS2orPgghgnah5a/oTdFhJ4ynckRenUC6wyG1Ec4TkEf1G2+70KPHlptkqxy+AI0+rIZlyPS4t2t9zvw3B6xaWFIu17bitsS1J6PqBlTOfgpcaPTWg4G25hPFHyueunE7xtV5xAhyP0T5/3Mavfc+V9PLorFmUc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siteground.com; spf=pass smtp.mailfrom=siteground.com; dkim=pass (1024-bit key) header.d=siteground.com header.i=@siteground.com header.b=s0J8aG9x; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siteground.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siteground.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a1b71d7ffso53341166b.1
        for <bpf@vger.kernel.org>; Mon, 14 Oct 2024 05:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=siteground.com; s=google; t=1728907927; x=1729512727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MzvbESw33rfDpeUyuX9Br3TNot/byO/WWelHmthPeYI=;
        b=s0J8aG9xu4mar3IdJ63lRUTN6mul5WCytICcbV3OeKKNRkyBKT4CrI3apUhjna9es2
         QPOPEm42CgNEDFX9ltsNl+hlvByoyRHbaluQ2rStbr8HPKACQQCRngHfvKEpp02MVBKr
         rysinisubZLl/BluV4rkmBe//VEZvnhbXRJik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728907927; x=1729512727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MzvbESw33rfDpeUyuX9Br3TNot/byO/WWelHmthPeYI=;
        b=DglOZ7ZEixsFhq7kcMkoLBBv9al9Vm+Y64uAEwyaT84z7DMvBk/hMA5HE6JAl1kl9D
         au1M1aBfO16ZdmitAufhgYu/hJK4Nt8XTjkRa3vkdwAKi7XuYeFZZRk1Dyl5hHBG54He
         TqAdUWeW2wVRmJsEtVos85zvdUQhyOjLXk+PBUYeZOHt6SpaipoVHupt3p0a18sqoBV/
         wilXGmHB04j3bGhbQWgh2I5+flF1eo/ATbrluRoe4yyDsZ2XhYTa8hG67Fo+SbAo0NAd
         XIjvmxJK66kVD3NUqDdpGE8KhV8x8kGv8tk5G80Vkbfa5/6tBiRysKV6zw5vc4JzMW4H
         E6Hw==
X-Forwarded-Encrypted: i=1; AJvYcCXJzYgIlibg3Hr3f0bT1Uuguy/RFnAQSbvF9VlG/CprmJZB6SOaDnfMo1U3fWjQVqZWvvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAjudh7hgMQPkHdDVApdHEZvAefjN4dsKdS7E3eV2Rpr8XVHbV
	f3IOthysD/yScLzcp0x5n+MDiIjBQtdgZW1fHny8Pzg2h+TPxhwhI0lvhhnEe34=
X-Google-Smtp-Source: AGHT+IGuKysFsV+OcEaZXVEfAO3mjVvIiTzPlL0vRGBSAD/FW1BaM/J8vssypUI3bbIOKobY/zmQIQ==
X-Received: by 2002:a17:907:3f8a:b0:a99:f605:7f1b with SMTP id a640c23a62f3a-a99f6058003mr595663466b.60.1728907927291;
        Mon, 14 Oct 2024 05:12:07 -0700 (PDT)
Received: from Dimitar_Kanaliev.sgnet.lan ([82.118.240.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a1ac71a7fsm55293666b.15.2024.10.14.05.12.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Oct 2024 05:12:07 -0700 (PDT)
From: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>
To: Yonghong Song <yonghong.song@linux.dev>,
	bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Dimitar Kanaliev <dimitar.kanaliev@siteground.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH v2 2/3] selftests/bpf: Add test for truncation after sign extension in coerce_reg_to_size_sx()
Date: Mon, 14 Oct 2024 15:11:54 +0300
Message-Id: <20241014121155.92887-3-dimitar.kanaliev@siteground.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20241014121155.92887-1-dimitar.kanaliev@siteground.com>
References: <20241014121155.92887-1-dimitar.kanaliev@siteground.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test that checks whether unsigned ranges deduced by the verifier for
sign extension instruction is correct. Without previous patch that
fixes truncation in coerce_reg_to_size_sx() this test fails.

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Signed-off-by: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>
---
 .../selftests/bpf/progs/verifier_movsx.c      | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_movsx.c b/tools/testing/selftests/bpf/progs/verifier_movsx.c
index 028ec855587b..0cb879c609c5 100644
--- a/tools/testing/selftests/bpf/progs/verifier_movsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_movsx.c
@@ -287,6 +287,26 @@ l0_%=:							\
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("MOV64SX, S8, unsigned range_check")
+__success __retval(0)
+__naked void mov64sx_s8_range_check(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 0x1;					\
+	r0 += 0xfe;					\
+	r0 = (s8)r0;					\
+	if r0 < 0xfffffffffffffffe goto label_%=;	\
+	r0 = 0;						\
+	exit;						\
+label_%=:						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 #else
 
 SEC("socket")
-- 
2.43.0


