Return-Path: <bpf+bounces-45767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC6C9DAEFE
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 22:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDC08B21328
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 21:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C22A203714;
	Wed, 27 Nov 2024 21:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfeYd4pI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7C7202F8F
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 21:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732743349; cv=none; b=Dx5EF/BgWk6jJgbIVFaPSTrur6oz2CyJUjHclaRQ74FGa+hMOGwctV6FkRlJxtc7eR/0DkSZi2ovW8UVVgNeCIIYeZWmRvttKs9NkA9qrRs1DsQoXTK+T5mk95oggp518Cpf2YlYdLT5BXFrZ6AGDhDlihkV7H6RZJL5riYg6A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732743349; c=relaxed/simple;
	bh=XI8afY+EEgzwCChq5uiRY5b/c1t5IWFqhWe47+0fWFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I85gIDeEb9LT21G+D/R40GVJIeCz84oWyuo/L34bDLXP+NF6Oq9kasljb9kDeOlvqvrKJQmT+9X83DiAmJQsV3DFJtz9psEJHvbFu4DDOYB5NkBnTgu9Yml4oB350rkfGPvn1oc6A+HSuzUmqrI+FJrYTO/sD1uSLP571a+TP1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfeYd4pI; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-382296631f1so165003f8f.3
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 13:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732743346; x=1733348146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8hfXZNRSbjbJUCdqZD3pI8RxR9Vc0H89eeyYkgRzE0=;
        b=GfeYd4pIzazYqWwtT+Zy4B+2SZxrCaQci46ciNWWichsABN51oA80agz6XLQsxFIUf
         Q0ThZBRJH4rXlo0yoghPJiMVIHImZ1ZPv3Ic81P1hRie8FkosbCbWZOqpxOrz9tz/T6E
         orcEBH+7x2MeqMb2CJIzOjaVOmVp9fnGpmubi5YIzLxp96n7CYePLVn18qY0MBl2f+Gt
         m75hAUGO6LXr16Ogi8gDFjvYoehfGRqZ5kWeAF+EV667/h+1b8wKd7+8tuMbPzoXkW+n
         9W70u0MutB2tZNNSDf94FWNS+qyxlY45aVjBjIKHvXveofmINED4Di9maZh4GgOQTY2S
         J/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732743346; x=1733348146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O8hfXZNRSbjbJUCdqZD3pI8RxR9Vc0H89eeyYkgRzE0=;
        b=ITelWFaLYDJx/7ucehw6yF0vFLHYq1m031My86pKO2nEc9Hl1DjG6qMGbR5sxoRQgT
         u8UMxRmucNGQpBsHWq/OOxNHhUSVL2hNRP8gOD/LuYzUFYJvjho3li8a8sL57ELkH/W+
         7YmXDzrlTM6rZpl5xwnFzN3GUsJz+j8FLVq0dBFz808aEoJSIOjgUO49mPhZE1Z2913x
         aUPuY0H2Gdmd9CMJvWJCiSzUi9a2ZQevUwsdXx8U5HWtW+kVR2b7ildVEeyiiFzOaj8h
         4Xmp1s/b10sPc8k92pXSfw/YTMmykb1edCxkwKrLA6EoahwhdoYcF9WHg+RvDemlsoJo
         wz8w==
X-Gm-Message-State: AOJu0YxBfVaGslWSQvjfUeyWHF4WzFhi40As26xA1SMBYb6rdsx7w19x
	LKJuyZY1KmcfciiTRILi/qHPrPTSRHSUWYVXKv/NM9dG6WwJTLpeWspv3JJum2Q=
X-Gm-Gg: ASbGncvf9Y9BjnjSRzcYATN1r5pXhM3y38IXmy/bh+8trE6eEv1uXxMjS9gVxkiG7pT
	cAB0aZkB2jU1BNYvR2aIFBwLNHwrNk6aDtsQvGLRbOAlQdKmqfDV5kzswxuQCP7xJHCfNmKUzza
	1nEvpDxQQdxsnTNjtjcEm8FQj8OGE7IGw+R403bITpATGAX45dpAh6hGiMXpn2Ndp/Isq6M2f/2
	bOyJJrt5hXKfRBjWkxvh/RgfvwEuyBAIOFx/Ac4XFox5gLvhxt5WyX/sXUE7mGwkC3avcc0Siog
X-Google-Smtp-Source: AGHT+IF4DH7ef0iH5RlKywoIhgDRNMmjbI74FhOsYB7yKXwgYTT+grUfGsdZ0JDV2vDbKBXhdT4HnQ==
X-Received: by 2002:a5d:5f83:0:b0:382:4bb3:9050 with SMTP id ffacd0b85a97d-385c6ef4785mr3716386f8f.57.1732743346154;
        Wed, 27 Nov 2024 13:35:46 -0800 (PST)
Received: from localhost (fwdproxy-cln-013.fbsv.net. [2a03:2880:31ff:d::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbe901esm17519794f8f.87.2024.11.27.13.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 13:35:45 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4 6/7] selftests/bpf: Expand coverage of preempt tests to sleepable kfunc
Date: Wed, 27 Nov 2024 13:35:34 -0800
Message-ID: <20241127213535.3657472-7-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241127213535.3657472-1-memxor@gmail.com>
References: <20241127213535.3657472-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1596; h=from:subject; bh=XI8afY+EEgzwCChq5uiRY5b/c1t5IWFqhWe47+0fWFE=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnR46uymtIJKVPVICIIc71lyz/NPShGAJs7VKCXfPI ybvJCliJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0eOrgAKCRBM4MiGSL8RyiKOD/ 0R096k3rdl1P15gPO4WWgiEPyna0t1+EXI1yas3E69XCqmyGmyBPkd/BfLVEussl1IOiUE46wsgH2m 7JEc1GznePJ8qiCDwKL1+2oUPorTkI5bPI4oN2ADGpSFan8IUtGHJGWp0kiRJ3l8Ivzl2G7JAwwn5F kOp4hxOhrGagmURBQ2yp6fRT8vBsoraygOhai5LoN5C2gX8xpjVxpnFD81eXhxWdo4VGeWBVmJJ7bb 5Mpz5V1PpiICep2xDoBc9aVZWcymI7r9Aabln1vM4kD2whAIzVJDy7ETK6Fofm6Z8kP9nwNzY6+Xbc RcPmh7wtXI6ovd04F6+nvLvxejJqtubp72kF1z430wMutdgD2D7/zZcN89EWosq2EZ3f+3xsS5MEk5 nTQIpFI9LQwDGj6gIoZp/qCWRj3komGuyvw+UAVvuZSYJg7mTPD+BGyL6elkGAvcXqj81CBe/YfmA4 UtF5/SoytQlJEm0XmvyiSKljWMZRhs0bAwPLltUnSN1k3LAKeBOj4pZQlv8Oh9kpdAszXiXB+XaCU8 wbFWIPua9182UhoLm1azazRiuOV0WHnkRau8Nu2B+vHP1QunncNsDkC2W9sM427eqKk4PoRE4i44mA 5EckljqplALOiItcY/4BEnkLQAF5q60nmU8klnP36zZ5X55/JaeR1w1AqQhg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

For preemption-related kfuncs, we don't test their interaction with
sleepable kfuncs (we do test helpers) even though the verifier has
code to protect against such a pattern. Expand coverage of the selftest
to include this case.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/progs/preempt_lock.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/preempt_lock.c b/tools/testing/selftests/bpf/progs/preempt_lock.c
index 5269571cf7b5..6c5797bf0ead 100644
--- a/tools/testing/selftests/bpf/progs/preempt_lock.c
+++ b/tools/testing/selftests/bpf/progs/preempt_lock.c
@@ -5,6 +5,8 @@
 #include "bpf_misc.h"
 #include "bpf_experimental.h"
 
+extern int bpf_copy_from_user_str(void *dst, u32 dst__sz, const void *unsafe_ptr__ign, u64 flags) __weak __ksym;
+
 SEC("?tc")
 __failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_preempt_disable-ed region")
 int preempt_lock_missing_1(struct __sk_buff *ctx)
@@ -113,6 +115,18 @@ int preempt_sleepable_helper(void *ctx)
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


