Return-Path: <bpf+bounces-75457-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD56C850F0
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 13:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81C013A83E7
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 12:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6034324706;
	Tue, 25 Nov 2025 12:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siteground.com header.i=@siteground.com header.b="Ksme2MRJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ED5321456
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 12:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764075443; cv=none; b=g1JgmhWeRx11Zg0f0zceJTG/7cRqPKe/MBDVsmhGnm1CU3pyshKJDNYzxyZAHkiwe3xqgM84GF02a3IKuCkulflsNd+dJbi0FMODpmNM/2L5Y4d5XpxNKqAGf+efj6/AmDMYiy3KhCD7jChaoSBgJuU+Pq18SuNJTLiGCCrtFNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764075443; c=relaxed/simple;
	bh=FhO8u5gmMIoSErXXCzUX+OW9viQesucKGZB+3Sq2WCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kOsvxs3TCiRRt7ioU4GW7R/UiMwi0aAjRPix4iu4Qh+Iee/vOi+dycVQbBC9c4gBtggY+IIXTAWHRFfHnYUAbCmj7J+KtDm8PkpxVtJHZEuWedlTvwVWBaweeXatEeBOw3eJ7kSnAHyokraWCXeK8ZFQzqoih6ekTKgbebjhKQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siteground.com; spf=pass smtp.mailfrom=siteground.com; dkim=pass (1024-bit key) header.d=siteground.com header.i=@siteground.com header.b=Ksme2MRJ; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siteground.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siteground.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4779d47be12so42146345e9.2
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 04:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=siteground.com; s=google; t=1764075440; x=1764680240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9TEFccKX9xuPOZpBxlNgf/iBmhnWNeKRFu8XB9pJqTc=;
        b=Ksme2MRJe0bBuTyO9nI5A8yrBB4ihjbDXEDx9XmdedzzyQXGOIGbqXTdBhd2E63ZAX
         TB3uTCJ9RZd8vRZBTQp4ebHtiuqPfgRKAZG8xTcUTQF9b1QjJfEVYUN6OdSwGn0edfyu
         tIRoUkeR8YQTGV3Q5CHro2d9nPwCNL6OtJiBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764075440; x=1764680240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9TEFccKX9xuPOZpBxlNgf/iBmhnWNeKRFu8XB9pJqTc=;
        b=Q7v7HT1k0byCbqYETXT8WvFMnaPvbNPxedEC636Uo4m9OhVelxsomvjfuBrKJlooL3
         hgIDQ1ee0zbUh2P4vPFIRXXF9csqpDjuYsDkhH3cH2k5dymall8Od81lHhQQX68EbYkN
         2dex3lFvbJ+2sgHraLANd+5N0vBsfxyIXl+6TqYEnga5LEpvms4VMLx6IpF5LczauZEC
         U5jdH4tGrt+pCK3XCFVTpRLJ+NBHn/2BFrffhRKXvA7FSPTe/TiwCjoYoDlCbwmxGIGH
         hmCsqZO1fAhR61J+EjNGMehG35ucn3xjyHov8+VfXFT8l1s9pAKFdNH9p/dH/53l21d/
         AXeA==
X-Gm-Message-State: AOJu0Yxrt7lu6QJg2VHjITrAUUCmkdh/fzEeKRG1zZokD8zoSC5ssZ1M
	mI973PmyMTM2bGbozDDEyGY58oAmYqzYkhMFDPkBgFdO7cnkNxAbkIbOWzViOy1SE0Fw3lY/ysY
	3RqJnLxPNgg==
X-Gm-Gg: ASbGncts4n5U8H11nhqGlV5bFvOHHN/KdJsYWB+3SYmnI0GU18beOLvm2hTWYkVSDyS
	234Ks0gLIAgcCtZajMzwNAkxUj6Plj9jB8vLlUawEAQiwdwac7Kxpl0RW5dttQF26FZ1BCwkDEl
	hghbgXwHqJ6rufUaCdf+0zNh1ZvKppxaDCFFfoDvspU332CHqIdX94TDS/BCEKKNbjEf8M9+w37
	BfaIRnICXsLk3YvQMCb5PTSVM0BSxsuI/GXI9gu5pgMnffKYMamFYg75CF38kQOVg1yEtdpL23H
	gtc2eTqS5SrlxC55pi1u0yFIfS1nc+JUpyignkCSmUTsJtv9iuR8U1y6m8IW2kzn/Tsl9qRROCR
	sjLjViMI0Bm4CttbH+TEnNP9aZGHO6pVRVQGJBwXdzr1sLZ+nTnHl/63sr732TSa+EzkZVopkEo
	QcII/EePVPvf45W5rJ6xcIrvn6WTOAcmCSo866dZF+JTmJC+bDMgu3kFPw04irMw==
X-Google-Smtp-Source: AGHT+IE4lGh+n82afA3kdn/HUp8saVIIFYScl/nP81q2hnYLaL8lZ4vydmz8P/himOWVLZSrWERugQ==
X-Received: by 2002:a05:600c:3110:b0:477:b734:8c52 with SMTP id 5b1f17b1804b1-477c0185bebmr168313135e9.14.1764075439885;
        Tue, 25 Nov 2025 04:57:19 -0800 (PST)
Received: from Dimitar_Kanaliev.sgnet.lan ([82.118.240.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf1f3e63sm256668925e9.7.2025.11.25.04.57.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Nov 2025 04:57:19 -0800 (PST)
From: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Dimitar Kanaliev <dimitar.kanaliev@siteground.com>
Subject: [PATCH v1 3/3] selftests/bpf: Add verifier bounds checks for sign extension
Date: Tue, 25 Nov 2025 14:56:34 +0200
Message-Id: <20251125125634.2671-4-dimitar.kanaliev@siteground.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251125125634.2671-1-dimitar.kanaliev@siteground.com>
References: <20251125125634.2671-1-dimitar.kanaliev@siteground.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a new test cases to validate the improved register bounds
tracking logic.

We perform the sequence:

  call bpf_get_prandom_u32;
  r1 &= 0x100;
  r1 = (s8)r1;

After the bitwise AND, `r1` is either 0 or 256 (0x100).
If 0: The lower 8 bits are 0.
If 256: The bit at index 8 is set, but the lower 8 bits are 0.

Since the cast to s8 only considers bits 0-7, the set bit at index 8 is
truncated. In both cases, the sign bit (bit 7) is 0, so the
result is exactly 0.

With the coercion logic before this series:
  1: (bf) r1 = r0
    ; R0=scalar(id=1) R1=scalar(id=1)
  2: (57) r1 &= 256
    ; R1=scalar(...,var_off=(0x0; 0x100))
  3: (bf) r1 = (s8)r1
    ; R1=scalar(smin=smin32=-128,smax=smax32=127)

With our changes:
  1: (bf) r1 = r0
    ; R0=scalar(id=1) R1=scalar(id=1)
  2: (57) r1 &= 256
    ; R1=scalar(...,var_off=(0x0; 0x100))
  3: (bf) r1 = (s8)r1
    ; R1=0

Signed-off-by: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>
---
 .../selftests/bpf/progs/verifier_movsx.c      | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_movsx.c b/tools/testing/selftests/bpf/progs/verifier_movsx.c
index a4d8814eb5ed..df7ad41af172 100644
--- a/tools/testing/selftests/bpf/progs/verifier_movsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_movsx.c
@@ -339,6 +339,25 @@ label_%=: 	                                        \
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("MOV64SX, S8, upper bits truncation")
+__log_level(2)
+__msg("R1={{P?}}0")
+__success __success_unpriv __retval(0)
+__naked void mov64sx_s8_truncated_range(void)
+{
+	asm volatile ("                                      \
+	call %[bpf_get_prandom_u32];                         \
+	r1 = r0;                                             \
+	r1 &= 0x100;                                         \
+	r1 = (s8)r1;                                         \
+	r0 = 0;                                              \
+	exit;                                                \
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 #else
 
 SEC("socket")
-- 
2.43.0


