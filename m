Return-Path: <bpf+bounces-45851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAE39DBE34
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 01:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E9DB1650EF
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 00:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D5318035;
	Fri, 29 Nov 2024 00:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqv+wbhD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F63A12B93
	for <bpf@vger.kernel.org>; Fri, 29 Nov 2024 00:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732839406; cv=none; b=UuQL7fvc2YlYKgXMZImpX1nwdiE/cdSdCn0DFE60rUs/w0Gh1DQ/SrGRoINWjS/cfMWtCXyxlsZJJAfGK+bt0Fc06JlK8viXxH7V7SpYB3mwbY5TgWii+HUnOJADkl+EVXByvwDn8mXL+6zkE5hMPNUhJE6+zbXlw7O9ViisfjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732839406; c=relaxed/simple;
	bh=XI8afY+EEgzwCChq5uiRY5b/c1t5IWFqhWe47+0fWFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S0rOSwW9NC1fUPqr5HgLJWDPXGH62loJqSvR2QZUylUpl2YKUtj3BRGE1x6Dd48qivsG1LmP2zHZvyH6jiT3W6vEC/TJzozc0Ls5UAIEGEEoic8O5JKw8K4Y+7vD4HM8aeUl1CYXMGZ3auUmcWbzOlfof+reKXnGLbhvs11wE6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bqv+wbhD; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-434ab938e37so8320765e9.0
        for <bpf@vger.kernel.org>; Thu, 28 Nov 2024 16:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732839402; x=1733444202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8hfXZNRSbjbJUCdqZD3pI8RxR9Vc0H89eeyYkgRzE0=;
        b=bqv+wbhDiT+mlnQ1svxtrGUgNlIwl93/JSyujs+cOr8WuhIdSs0c43+uAlBm78goAI
         SGPux9RVXhyor2lelnoeAc56Ymd/yNpaSKciRVQh20VG9Gm4C5lUIxqmIJ6FCkYDRLur
         h1Fsx9sirzFPoPBww7Y0eaPCTxTIdbJe+aOh91biotTYVERHPs3TdcaKoho/K0E92sW1
         tBfE+QD784d5xmtFoSSmcP6arvTcF0BXEVzN47E1PeBY5bhdD+VwDYX4I/G+ggVtUhVY
         C5VCcrb6PLqgbnuphIFWsuoNjRxmyJIV9tnj2Ye1QqILcxmOqKqCMSpWmHqSAqFHkOv6
         +qzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732839402; x=1733444202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O8hfXZNRSbjbJUCdqZD3pI8RxR9Vc0H89eeyYkgRzE0=;
        b=F2i5Fxa5sPZdsWoErecJ1lx1lThBdJbXVGJ30Ds+wLDe0UDF/6PwEW4yOUOYB2oSfi
         0Rxp2iO51W0opilyJqrid+UcSFwBPyD87bBfoeq62c5cIP6Km2m/gfvBQy/rYqI5WKEW
         HkJHMqvgEZPDrs/n8pKspk2p0gZH9Yiig3p2IbcOGT+i1wyg28RsOJll4o+dQZSkEJC5
         y/A9geXfJs2raN6EM+AoWi9CgMaRVeX9/QK5JQHL+fwYuzvawK5kSIbhBIPr5KTfLk73
         2K4xDIuWTzE3E8oZlKGNvX3zuuzb570MKKmvfQSKP4kmj3Nc5GPIBwhpRkrIWiD40pIv
         dz1A==
X-Gm-Message-State: AOJu0YwXVqxSu/ccApqqKyg7GvxrgBwmEcrWiYZST2BUp4A5HJ4esfty
	VA3mK/XB5EDfBB5YJNMrCWZkHJF6Y0AVJWC+1J6MKUKG5pMUcHLBHalBc6MZd7w=
X-Gm-Gg: ASbGncsRBLz5KB0wJxMjUOgVV3LUlk7O8xnyied6hzlp+nNhcY2XSbE6NVurZdMozvT
	7hP3DH9dYu0Lb5HR5I2Oz8Eoh+YDuDbN59Ew1elq6+bPERCCbxkKDpYNLD6yF/Xz4AYtC9sZwSo
	4p0Z+FoAMZ49PRUp8JxNBJMxioiXPQjmY5Nwue38Qjn40g+E7zsG8caEJR66Wadsp4YfNEVHEeG
	93dkyjG81N8831f4OteWWy4PAPJl0zS3Ho5WUGt5u8piel4MCLkcFswkq3zVU4qXOxr5TCrw8ta
	qg==
X-Google-Smtp-Source: AGHT+IH9pB7CJtiOYmOlR84KmeJ/CfNjw865ZHCfYpiQY7TUPtcPGivAUsw8XJ6TSt+0yf1to/ZB4w==
X-Received: by 2002:a05:600c:458b:b0:434:a78f:3612 with SMTP id 5b1f17b1804b1-434a9dcfef2mr92773145e9.15.1732839402324;
        Thu, 28 Nov 2024 16:16:42 -0800 (PST)
Received: from localhost (fwdproxy-cln-019.fbsv.net. [2a03:2880:31ff:13::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0dc63b6sm35739235e9.22.2024.11.28.16.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 16:16:41 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v5 6/7] selftests/bpf: Expand coverage of preempt tests to sleepable kfunc
Date: Thu, 28 Nov 2024 16:16:31 -0800
Message-ID: <20241129001632.3828611-7-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241129001632.3828611-1-memxor@gmail.com>
References: <20241129001632.3828611-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1596; h=from:subject; bh=XI8afY+EEgzwCChq5uiRY5b/c1t5IWFqhWe47+0fWFE=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnSQfcymtIJKVPVICIIc71lyz/NPShGAJs7VKCXfPI ybvJCliJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0kH3AAKCRBM4MiGSL8RykRmD/ 9tX7yhV2cWsZcM5OWJEFByvkwtXsc0/knaDrrayZm1cR1Ue3YJL2TEQk00zAngG/xC211ODUY6cwcM Usbkm/YtQ/Z1AAcsk4L/LKCTsD3zjGCSQqWiJ6gQm7tAz9jvrJlo1BHVT4qceis7duLIISAMX+k+Zt +eFt8bS1wc+68IThPjkZgFiUqFWWrRtHrSeuieHNfpDkAL0MYBZvoqTwO1TSO238qmPAAcfXAP43wu xqJmgucgk6kYHeIotwPW8CipnheaohPyQfc7VKdRVsrBcr9UjL/PZmmejtnZs/8nT9E1At3QEAzF3k S4ZKI8KeaFiPNypis8YSP4shZiv3yQgTDZJvMyZ7yiw3PR+jD3yFQmUiSjNwuIcdO0PSHdy10vm7M8 JZJ9uwAOgxRb+jmxDDtwuouuJaOblzoJl3xYSEIsFOqVEG41GkQDLqzNF6QBgsmUPRtE/RWft1vjgq PEJNEWf35wSIurOtpsaxCVjcVz/kKO56cU4qNWEUST+UqiIOU2aYRQ6QOX0VsFzb1AeMYxFYAEsAEy ZH6FghG51ecJIMTL1mxfwFqE71JvxS/54Ap7ggDYV+k7LBCXQZt6WGPwo+ezCAzvLFCeszmYT3HMK0 e2su89W/YftoX9DlpUzUEhRYPKnZQQncweyEykiMOj751OpVZ09etWAPTNtA==
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


