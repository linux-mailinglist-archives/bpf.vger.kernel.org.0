Return-Path: <bpf+bounces-68776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA43B84846
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 14:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BA0D1880620
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 12:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A812D24B8;
	Thu, 18 Sep 2025 12:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kATMjDeK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEE82C08B2
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 12:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758197389; cv=none; b=nDE8e+v1RKjnSDyFoOjM/3GJA8t5Jgw6pI7yzUtyUg63p4RA/syzcqOnfZ90o1cyVT3EiUIlSnOBNBi9OMj5csETzAAyQe9tInlTNv3M/oFZ4z1c6SA7P2sDIwcKBBKVCelr/qktfBn0XCOmPGZ3KiaX3XJadvCUxsUUBadhW24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758197389; c=relaxed/simple;
	bh=uR6j2EI8vTJoitLgXegekwk2YTw8pGvuxdnnjAUKfms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XRlWoGJCUOS3UamBP4SYoF5gSFzNabaRghvj7Nhp4gNCx7T2mBbB7prZ4iIUj3Ip+e2uqNe9lbwftIhwPKASWVt3m3ObBUQjkHoHlvvxTPjRRUl3nGiwMsSMCwLLEilgDGMcl8gf1uQYl6XLCxPXkwU7f99Wnciq/BQ4cnr1rI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kATMjDeK; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-7762021c574so890247b3a.0
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 05:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758197387; x=1758802187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=apBO0lUAo4XQGQFELSGuX1XqULu8eavmm8XQfxmpWOU=;
        b=kATMjDeKtMLxZfYBpA9LgWzrOhdR9rNOT6L/2Drw1sbgHOLNAW5fFkKjRMh7xK8Wfr
         IFCatHD9rf6ESLYi80yE+jlkZvVyLZthILLJsEAVuTQdnfv9xkEXQ3BRwNqBgzCyH637
         Z220j9hbnZUIusmHcnhAsn3da9DPCzXPNRrT0EJtS4pmf99NoygrxeOok+MOveoaZ5er
         9KSzdvveOsuCoaGcnKtJXJss79+Yem7NJX9IsBhzP4MjCWo16lsyHP0oxNhkyMl3RhOY
         47LtBpZNGh/2fu5VaSw2yFlJv7tASHQXRTD4Z+kmj+OD6x7MMq+jyxxRHKqgrfSouaNS
         2vvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758197387; x=1758802187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=apBO0lUAo4XQGQFELSGuX1XqULu8eavmm8XQfxmpWOU=;
        b=QVLO86dRST8dlDc3jbMjlKPNm/h9jIKkdohN0NY9eWpInnrhJ9Hqc7iexaLQHtiqZX
         92oGTCz0e4TEWmVANWhj2jHEtiqxqhXiAwN/PSCas3L4Tzykcv9zQMJthDRIt8RzeEoh
         iwh4FXPd1T11RTKWTjt7AQxCwxOLuBerDvh/1Um0KOFtrG4dkwzJBAB7pNJ9TsueBuDu
         eN0H6R5k7/TUv3wweMJsY2QHZcadPqt4U0fx9u8CXBreTHs+hmhoNEMqTM2eAd+E9EKI
         b7qLiPIKlKIGrhfRvVPqFUOLtgBUHIKQqIozygISN2h38eIBiThdZ9vKvu5WY3d+3ePJ
         RIlg==
X-Forwarded-Encrypted: i=1; AJvYcCUgfCYJzw88jGkhjH1Tr4+ODgPSjw9OpbvQQe8jLYq+nCINQu/0zbcljnIThOxbJoUZmiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHR5r9GH8uPQrto0laELOGRfQJo17ec5dk48vsT82ATTcmhv8n
	yh/GcA28ax/NKoh8MGiVh0n99/51/E4/SZEYleDr9zxQsGiJIBMwS8CE
X-Gm-Gg: ASbGncuPlLeamAM7IJLvf9GThzJIQB28fL4NJP7rpTJ4PoiYY1hbnEpnm6zljYP1GAK
	IfFKCm0lkM5JQW/yXydEzQRbUifnOPmSESoj8BRYqtryLNI/ktq8iLKvCYxHIDlWwp05CcB/SBs
	O8X/teEInOMBegVrzNJ1G0qLlsha4CNuDCLEAb9x0gdGPlL0K7cssXxKjQXofunur/ggGKnaxiG
	+w+z9gdRgc6bJq2SRCGDoM9M0wrOSI6JMq7g9Hc2k/eFf1RyzZRkjjNl5yp6Ew3Rk4IbprnJOT+
	aZwBcbvhDKMjHS1yNoH9ueeKHpvbax6eddhsoXYNZS9H+Ik+wB1LwaFaaLlYG3OnyAFTMRqqjLE
	vYC2LhT9JcTYa7D26QZJ7w8XVqoHZfY98d5kJlgV1ytQkJswm
X-Google-Smtp-Source: AGHT+IEsYwm3B6RDBp2oMmV3j80laKyE+tnM2aRhu87m3A6NMl6JmMBBppRgaStOGsvvVnsPTnLlPg==
X-Received: by 2002:a05:6a00:887:b0:772:638e:5f61 with SMTP id d2e1a72fcca58-77bf98553b2mr5706486b3a.30.1758197386658;
        Thu, 18 Sep 2025 05:09:46 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfed379a2sm2184065b3a.86.2025.09.18.05.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 05:09:46 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: peterz@infradead.org,
	jolsa@kernel.org
Cc: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	kees@kernel.org,
	samitolvanen@google.com,
	rppt@kernel.org,
	luto@kernel.org,
	mhiramat@kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH] x86/ibt: make is_endbr() notrace
Date: Thu, 18 Sep 2025 20:09:39 +0800
Message-ID: <20250918120939.1706585-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

is_endbr() is called in __ftrace_return_to_handler -> fprobe_return ->
kprobe_multi_link_exit_handler -> is_endbr.

It is not protected by the "bpf_prog_active", so it can't be traced by
kprobe-multi, which can cause recurring and panic the kernel. Fix it by
make it notrace.

Fixes: 72e213a7ccf9 ("x86/ibt: Clean up is_endbr()")
Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 arch/x86/kernel/alternative.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 69fb818df2ee..f67a31c77c89 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1108,7 +1108,7 @@ void __init_or_module noinline apply_returns(s32 *start, s32 *end) { }
 
 #ifdef CONFIG_X86_KERNEL_IBT
 
-__noendbr bool is_endbr(u32 *val)
+__noendbr notrace bool is_endbr(u32 *val)
 {
 	u32 endbr;
 
-- 
2.51.0


