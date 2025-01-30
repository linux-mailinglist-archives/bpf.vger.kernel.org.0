Return-Path: <bpf+bounces-50119-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A26A22C79
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 12:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 746F01887B80
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 11:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834CA1D9A5D;
	Thu, 30 Jan 2025 11:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siteground.com header.i=@siteground.com header.b="wc1nIB3J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED9F1C1F07
	for <bpf@vger.kernel.org>; Thu, 30 Jan 2025 11:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738236249; cv=none; b=ic4sP+rWTb5qNJ5WtTX45kpmeJ99z4/rQYFR1G/66B29E5JotHIvV+bWfsHCeVUgK/W+JKRvRGLO+NCv3Z9sg4DBs5TMsC6P5gzvd4xcpWACr0Vp2LNNJzA5Hv/Qvv6bEwF7ijh46qdNA0bZZhHmGTvOuvQsfAmM4fBwG3g89Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738236249; c=relaxed/simple;
	bh=V745EBPtWfO/KlVgeT/flSnTLJNcnFiunDgLtlkuRng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=unxJ8QnolsZPKRf+xjLHCdAr9CMSrh5xsLDhPU0DnbYXuPfpCrVWiNxWt7y3Ol6kxZPkLmJTksi3DXPV750vcQrY79LD6AK6vs2VNsGWaXJ9g9DAjxprIfhBF0R08aBHS+58H6csRB0bCJhAn1KPUPZn+fUXTs++MPoRP1BFeG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siteground.com; spf=pass smtp.mailfrom=siteground.com; dkim=pass (1024-bit key) header.d=siteground.com header.i=@siteground.com header.b=wc1nIB3J; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siteground.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siteground.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385e27c75f4so563679f8f.2
        for <bpf@vger.kernel.org>; Thu, 30 Jan 2025 03:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=siteground.com; s=google; t=1738236245; x=1738841045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYWhsyq+R/1EI1JInTggJWtmiRl2dMfBFoFdGnxFB5w=;
        b=wc1nIB3JMyPE5chLqcxm9fbYKd9vVDI/vbhJ5CIwAZ2oqGJr8lj/iqEf2Km5YR/AEJ
         kbpUuavIEFnaujhR/b4eX7Tchy+2BevA+VuPfdGlfvppn+SRgOeFGEzGcwhCvRV4kz3R
         c6P1BGZbyWatT8O4n2CKSYjUemRx0MJJpcdmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738236245; x=1738841045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LYWhsyq+R/1EI1JInTggJWtmiRl2dMfBFoFdGnxFB5w=;
        b=M6BTRBmPOq8+tGYUfY2Q54bac78xbR9DTgzZ0sN/rxUiobOs6eFq1/8CimVu2qUk4l
         St4h88YReg/Pq3omd3JM5yDZmg4tio/C7eoswHGETJTUKulQbI+3cX0Zp5p1rP1FYc7x
         2/mCUn4wBH5QYlpE7djq7alE0s7R+y3MlqLCYNcCGnx+mYAUBOKT1bcuHMYfAD0d4cIK
         wi1pqg3tmjfANII81DdiXHaUkMyLba1aV6uOqIhTbIxPcpRlHc6lBDL4I1Zdq4RGlKeg
         lHjmRYzE8xqY90/JO+JvpI0EkupNtfCUPudUrH9sL7jJj9782aEJW2d9VPY3KyaGclnB
         Dcsw==
X-Gm-Message-State: AOJu0YwauAQFcZfqIN4pG/DXt7jRsUOPvDk6e6CPbfwqT00L6p/XydVE
	7s2UsmefxwrazV3SVYCevsm8EB0VBMfb6aG7JKbY3vWj+uw7zTAqZs7IaGIs6uSzwiaMot3kN29
	8+T4=
X-Gm-Gg: ASbGncupE2ngeHkna/9GJ7SQbit/3xZ/wZ1a5HZd1/cAbqBo0mI0met0k16TaJ/gpK4
	ioe/GiIOsOGM7kt2oQrTWOWwIkd99xRaEhEtQj0WIVZeyx4b1XhQmLiEY3FrEfckDtw0oRQVkMf
	1WGRFuT+/SKPN0qED7pPaQjxRWOpcYQE7+Ne3iLNyaOsmpfCIu8xIYU+f3sn8uXkWsGOMSenJwq
	BwITMAIymlAoimOxku4d9Q6CwRVHk8w/qVfuT9rzmVSFf1CLwP9adpuOnhno8XS8GHFpeUbvWjb
	VGAqNFs90HXKkzdOdBxlBmrqWNMCdGETns+w8rACkYN9Nk9g1vsvlVU=
X-Google-Smtp-Source: AGHT+IE6E9y1qbeZwqYyFKuJAaMuNalusb+mJc8UfE0nLv4MdMrq+YCk19kqDOzVpa6EWB0eP2nfQA==
X-Received: by 2002:a05:6000:18a9:b0:385:df6d:6fc7 with SMTP id ffacd0b85a97d-38c51b5efb4mr6535840f8f.25.1738236245551;
        Thu, 30 Jan 2025 03:24:05 -0800 (PST)
Received: from localhost.localdomain ([85.196.187.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c1b51e1sm1678981f8f.77.2025.01.30.03.24.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Jan 2025 03:24:05 -0800 (PST)
From: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>
To: bpf@vger.kernel.org
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
	Yonghong Song <yonghong.song@linux.dev>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Dimitar Kanaliev <dimitar.kanaliev@siteground.com>
Subject: [PATCH v0 3/3] selftests/bpf: Extend tests with more coverage for sign extension
Date: Thu, 30 Jan 2025 13:23:42 +0200
Message-Id: <20250130112342.69843-4-dimitar.kanaliev@siteground.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250130112342.69843-1-dimitar.kanaliev@siteground.com>
References: <20250130112342.69843-1-dimitar.kanaliev@siteground.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds a few more tests related to tnum_scast that explicitly
check cases with known / unknown sign bit, as well as values that cross
zero (going from negative to positive).

Signed-off-by: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>
---
 .../selftests/bpf/progs/verifier_movsx.c      | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_movsx.c b/tools/testing/selftests/bpf/progs/verifier_movsx.c
index 994bbc346d25..20abeec09dee 100644
--- a/tools/testing/selftests/bpf/progs/verifier_movsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_movsx.c
@@ -327,6 +327,79 @@ label_%=: 	                                        \
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("MOV64SX, S8, unknown value")
+__success __success_unpriv __retval(1)
+__naked void mov64sx_s8_unknown(void)
+{
+	asm volatile ("                                      \
+	call %[bpf_get_prandom_u32];                         \
+	r1 = r0;                                             \
+	r1 &= 0xFF;      			             \
+	r1 = (s8)r1;  					     \
+	if r1 s>= -128 goto l0_%=;                           \
+	r0 = 0;                                              \
+	exit;                                                \
+l0_%=:                                                       \
+	if r1 s<= 127 goto l1_%=;                            \
+	r0 = 0;                                              \
+	exit;                                                \
+l1_%=:                                                       \
+	r0 = 1;                                              \
+	exit;                                                \
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+	__description("MOV64SX, S8, sign bit unknown")
+	__success __success_unpriv __retval(1)
+__naked void mov64sx_s8_sign_unknown(void)
+{
+	asm volatile ("                                      \
+	call %[bpf_get_prandom_u32];                         \
+	r1 = r0;                                             \
+	r1 &= 0x7F;                 			     \
+	r1 |= 0x80;        				     \
+	r1 = (s8)r1;       				     \
+	if r1 s>= -128 goto l0_%=;                           \
+	r0 = 0;                                              \
+	exit;                                                \
+l0_%=:                                                       \
+	if r1 s<= 127 goto l1_%=;                            \
+	r0 = 0;                                              \
+	exit;                                                \
+l1_%=:                                                       \
+	r0 = 1;                                              \
+	exit;                                                \
+	"   :
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+	__description("MOV64SX, S8, value crossing zero")
+	__success __success_unpriv __retval(1)
+__naked void mov64sx_s8_cross_zero(void)
+{
+	asm volatile ("                                      \
+	call %[bpf_get_prandom_u32];                         \
+	r1 = r0;                                             \
+	r1 &= 0xFF;      			             \
+	r1 = (s8)r1;             			     \
+	if r1 s> -10 goto l0_%=;                             \
+	if r1 s< 10 goto l0_%=;                              \
+	r0 = 0;                                              \
+	exit;                                                \
+l0_%=:                                               	     \
+	r0 = 1;                                              \
+	exit;                                                \
+	"   :
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 #else
 
 SEC("socket")
-- 
2.43.0


