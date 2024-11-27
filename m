Return-Path: <bpf+bounces-45723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CC49DAADB
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 16:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D922167992
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 15:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98230200126;
	Wed, 27 Nov 2024 15:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCmKh8Py"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC5D1F9AB6
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 15:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732721599; cv=none; b=DuzGmSm7bMA8AvPzl95n27kMn3D3wFxWovCSxmcsXUjnb0r8acLqyHANMHybO5Fcw2VU0wXcae0MgxwkoxRAmKEadMTHucBGc323/00LhhPLVLMPoMrLyY5OaywYSYpPAZ1J5AQJASsriALneoTGxhekFAtkMcLVxQVGEdC5gpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732721599; c=relaxed/simple;
	bh=nh4dH5NlTiDfgbb3waHbwKlrhlaqFszmKXwUltb3VZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kjs4eKIRLr7V8yJSaBhcGihcw2Qm4hffPhbfN5Hn0B/e/ktZogSAogdGqYcRPyvl51ZFnzqpL03xey20Bh8SAMAoAuZIYYNR95yrtpOMh0wjfwJyMkAB/BBeLB7wROFBDmzZYDWxSlZH9dsC+NcvydHHnMmixt9kmIee7+WA0Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCmKh8Py; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4349f160d62so32643705e9.2
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 07:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732721595; x=1733326395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJwbhPzqxw6PiVwLVYiGAIa2hOssPAZ0gOhNr1j2YRU=;
        b=MCmKh8PyvXJ9fa3sTFBNhuIOzpvtW9FCNDsMkwSy7iEWOnQZP/PK5tNhP2tv4I/mAh
         KwaCwaRaw/qq7hWRbnfTcguVA/zOq8qHjjwRF0Xp0ixTyp+MAPQC35gad8mNoxpR4K95
         r9r4PP1wOQgj9Uc9oQVh6IPmtLEor35SMP2eI794Ae8zVSSGeD/HGp0Q/WSBtLx4hmqT
         p+CvwQXhPqSz0FNJkPqtRrdekgWatVVnHFdAzPZbfY8nmMmrP9qYbaNEhp904LBx54lG
         aILMmzkg1W0ldC0tUFaeI8B5MsWLT0lB5tI0ceNeockdAJnC/mrcgDTgW91L5Pf/jAle
         3U0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732721595; x=1733326395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJwbhPzqxw6PiVwLVYiGAIa2hOssPAZ0gOhNr1j2YRU=;
        b=aZromiDbMFYyH2wqONuUnEChzUksLstcpf5BHscUlUApnD+omU50fdxBp179rDilDr
         eLPqbN9Q+bIvxzSAUhixAdqoh81Xmv5tSSpoyjfVZjnSgDhQFugn26gN9kiOQG8QhBos
         EXkPX2PNxpDSdGs8GklyQul+iPC/wOQveK2TsXjwy9OHm4HlVXG0Ia1oxu3QkphoRkad
         HQt7b9dJ1Q6EtWL30cwtQqUiEbZdJIHmNhTHPcBzCs9rSqLSOOSjvuXhc8oeTpz5cJBk
         5PFHKidNm/waEwnOZooreIJ7Rvfl6Anq8cYXIJ+eigfJAYXJ9um1HTR9r1JLq5Lx1J5C
         xLAg==
X-Gm-Message-State: AOJu0YyatGjxiSFoq6jzkBBMrRPwP3oC/0LcPRW4C2BB/852CH9We3b2
	DGCUTvCIUkoC5oJf/nQsp6ilgCFaO16rk+HNinOTcg1T+/41tkPQRKkSUjo4COE=
X-Gm-Gg: ASbGncvYuBU4lgLEK78g1q5Xzc6TDayqCnaq3dSpiORWOdcArTtFqpqQ61wUPBtpA69
	uabmAUGs+KDrtDl84xtTi5rcyubvzLBXQ+rdTqpkt/+36/2B7Zv+WXEK1J4lBOWI/EL9tuDHOor
	2/mJVlvCOflX9ydiKeHBrzzy+3M7imu//2zPdmGpQ4ze6MaLqM1kSgrFCNsCU6AEFR0YE1Y90aK
	s1hOyXFhf1AkeLrOZ0R4kPjlt9pIs5SgcbQLcjPEeLCxhDUsRIbngaWwWQEktelKGYxgSGVSR9r
	vA==
X-Google-Smtp-Source: AGHT+IE68Ka0o+6QmdMfD1b5qiuK5UCIZ13zQ7Pgm3Wd3x80GmwZpb0dFOn9AWS4oyaZTF7eV1YK3Q==
X-Received: by 2002:a05:600c:198c:b0:434:a386:6ae with SMTP id 5b1f17b1804b1-434a9db7cf7mr31480765e9.7.1732721595495;
        Wed, 27 Nov 2024 07:33:15 -0800 (PST)
Received: from localhost (fwdproxy-cln-039.fbsv.net. [2a03:2880:31ff:27::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa78120dsm24310775e9.24.2024.11.27.07.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 07:33:15 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v2 6/7] selftests/bpf: Expand coverage of preempt tests to sleepable kfunc
Date: Wed, 27 Nov 2024 07:33:05 -0800
Message-ID: <20241127153306.1484562-7-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241127153306.1484562-1-memxor@gmail.com>
References: <20241127153306.1484562-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1228; h=from:subject; bh=nh4dH5NlTiDfgbb3waHbwKlrhlaqFszmKXwUltb3VZs=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnRztd8WGn3gS6E0MxEsrWKBVooyTUjx8ax4WgHL+x cqnsw7WJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0c7XQAKCRBM4MiGSL8RymCKD/ 4k62ECYzW/R/nBHTtk6HnVE/YLMsq4HzpLYjulXUtiMjOWqesgYhAtMLgJmNPHuJpDXHnG56Z9PF1N dBFyHSUdqehm6wbx+nrPVS6TgO27PS8cpRYY/g3Eee8E0I4s8Gi06TLSt+PPxr2kifM3HAam5gSqOy CCfTarHxNQ3Pc+BVqeFzcv1uKlEZDBCVQBU8TLVlGQsHg7bRULDM/lfFnqhBpFnwPFQFYHZXKwfz5x 8lysxANpOzDeiiNbwcjrXTCQvV8LcDggJsu3mLmxngaHylE0H8yfePkecHfIxBGD6zfJUwoZBkrAS8 pwh7mIcPrp7AYB//T4NedqmWT9lNgkw5rkVtSEvhselz1I4d8S4v5VUCb1o90a/2b+AdBGPcILD0Uj HraKsXYSko4KZgoUNBqF2cIO3xmgEEVA6L+uZ4F3NhKaAedXmxZVU11IV274O0JrKuxLVQ/E9QiXc1 74KEdFXoivmPaBsGAXLUp+ENSXrD+VNrlWD0lb8z4ZPcnau7DJrobziN75r0cDn/5XboM6ITsAKAYl hWqQA70Ydj2fJVj/sqYPLe0sWQ6jAKzHkWoon5mKYhXvW8vV51upwCm9wTlI53QbY9XCjPP/qTqhAr EsEMC38SS8zlxe5klBRAY2OjE/3GsZGOZAkLn7HNZSYbQlmcJLKFShKI8cSA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

For preemption-related kfuncs, we don't test their interaction with
sleepable kfuncs (we do test helpers) even though the verifier has
code to protect against such a pattern. Expand coverage of the selftest
to include this case.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/progs/preempt_lock.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/preempt_lock.c b/tools/testing/selftests/bpf/progs/preempt_lock.c
index 5269571cf7b5..788cf155d641 100644
--- a/tools/testing/selftests/bpf/progs/preempt_lock.c
+++ b/tools/testing/selftests/bpf/progs/preempt_lock.c
@@ -113,6 +113,18 @@ int preempt_sleepable_helper(void *ctx)
 	return 0;
 }
 
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+__failure __msg("kernel func bpf_copy_from_user_str is sleepable within non-preemptible region")
+int preempt_sleepable_kfunc(void *ctx)
+{
+	u32 data;
+
+	bpf_preempt_disable();
+	bpf_copy_from_user_str(&data, sizeof(data), NULL, 0);
+	bpf_preempt_enable();
+	return 0;
+}
+
 int __noinline preempt_global_subprog(void)
 {
 	preempt_balance_subprog();
-- 
2.43.5


