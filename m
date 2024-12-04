Return-Path: <bpf+bounces-46053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 910149E31C9
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 04:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 989751667AC
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 03:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082B81465B8;
	Wed,  4 Dec 2024 03:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObMHtlGV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5087082C
	for <bpf@vger.kernel.org>; Wed,  4 Dec 2024 03:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733281457; cv=none; b=F4UKlLLgg176dWz029ZYWkw4np/JL7mkha9WUV55LrGDc9eXl3Bdnc/0ZCwEu6H/oiRPPbPjQT0XGyJ2ZaI1XdfCG3bnNECXuBkHOz7Dfj4T++v/TpYAYZXAn4+FI3Z3m04gOid/PYUSx08eEoiC3xXDFETtRHN2v4qcI0259PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733281457; c=relaxed/simple;
	bh=XI8afY+EEgzwCChq5uiRY5b/c1t5IWFqhWe47+0fWFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vEdRzJPWmaODnHWW4OO5ORrOvYKh/ip0ijmBo6Z3zycPu24h+9JotJomQcR4KH53a2IvL3gpDh6JsoCIDPpz2Qwc1ptbYRpM4AZ0j5ORuIe3WEJbULIm6H1vsbUeuX6GYo2vYY4WD5CpUqUhDy303zJZZRlUNXYUMc7tiTegpBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObMHtlGV; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-434ab938e37so40590025e9.0
        for <bpf@vger.kernel.org>; Tue, 03 Dec 2024 19:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733281454; x=1733886254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8hfXZNRSbjbJUCdqZD3pI8RxR9Vc0H89eeyYkgRzE0=;
        b=ObMHtlGVcjx/tt5j3Kq/7rNbjSb2xwk2jcmWjaHMpbf+nI3N6lywUt1VB3zadOlifO
         KoEpqcriNzvoIpBHws7vtGepuBqTqZkiJAjlqtaExpKra2RyWnUbUEwLGdnDSXSW3azg
         ancBexEdCl/hV3aN+oQZrl3D4C3Ci8ifKmSMdC49c9z61qmDfhnbl3up/rXbauRlQVJL
         rRzaHsogeODWfkiINN1N1u5iKXaDKAa1QrFd5KCTXY0sMOpxUE0TrGMqExREuPQL5aL3
         K9i2mKpmq/GEqVgLrLJe+0jNx9yspJ+AddT4ppTqp+k+MSks1KEYAzEQv/FDh4nV9+b+
         nb+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733281454; x=1733886254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O8hfXZNRSbjbJUCdqZD3pI8RxR9Vc0H89eeyYkgRzE0=;
        b=S1jLg1X6+/qf7QkmUWOtgmCEaRnV/bjMnBQxsrDROZ/DCy4YVEGR+567Rtb9c5JoBp
         5elsjjA54qmvk83vd1n659GXHwmgNfQxWEBzzLSJhDZcPt+D5jORhYGZN5VRJi/IheVV
         pzsVNOmK0oB6sI3k0YR+odDlTvaGf+ldyTXsX2hgs7MeSLfJwXUkmnbeqOv9MXqiAPU4
         Ld4Zg3S5FRVBY8RFgmi+4slcuxdjaOtkU283KO2srfymMoZT0bXbADzuV5hguS4wOkY2
         cfsvjU94ar4ZRx502KI7zozsx8ApINXTSp3IqrazkuekXEXiiqhMpcUYfT11UPQAJHwt
         bbaQ==
X-Gm-Message-State: AOJu0YzRidksTIW5r3zE6MTKT8m8kHQNoy8Z/+XsCQ8+C6hJKc0gGny1
	j9/0MPQOHEXVBHk0OQ2avehhk06YyVKJKSvgxUhi8wVxDUvcHcmLUCErWUfvFOQ=
X-Gm-Gg: ASbGncuENMUgvrl89jks5Ho2+H2kfCPgQqElMtRQPwIZXCXC+aClUV4myrkSdXVnXXM
	lfyckN2M6hupY2BG+usOokdeszg7KCzoEOtvy3ZQOGdaDV9WgR45GLb1pEnitpfsA2HzT/2JmPT
	U+O0sE1XNnTk1w8lwVYny+56oFVgaK5n60rKNflq1DMOiw0lvfq34SYlthAsAeNC2qQo8XU0S+o
	nEX/sGee2y84phm9aAdzBjPWirY02lPaWAEUiQmK2cZpbDAFat1bV9UQCLTfAFjvqJEkG2eJfxX
	0w==
X-Google-Smtp-Source: AGHT+IF+jahHwKELrpEK6FGju8W8pyWR/1ghFMhvDKaznWWMW4G+4aSjbf+/cZIA7NG9kTKlxZUI8Q==
X-Received: by 2002:a05:600c:35c2:b0:434:9499:9e87 with SMTP id 5b1f17b1804b1-434d3fcc5afmr19981465e9.25.1733281453568;
        Tue, 03 Dec 2024 19:04:13 -0800 (PST)
Received: from localhost (fwdproxy-cln-112.fbsv.net. [2a03:2880:31ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52cbf57sm7587145e9.39.2024.12.03.19.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 19:04:13 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v6 6/7] selftests/bpf: Expand coverage of preempt tests to sleepable kfunc
Date: Tue,  3 Dec 2024 19:03:59 -0800
Message-ID: <20241204030400.208005-7-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241204030400.208005-1-memxor@gmail.com>
References: <20241204030400.208005-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1596; h=from:subject; bh=XI8afY+EEgzwCChq5uiRY5b/c1t5IWFqhWe47+0fWFE=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnT8Q/ymtIJKVPVICIIc71lyz/NPShGAJs7VKCXfPI ybvJCliJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0/EPwAKCRBM4MiGSL8RyiTmD/ 9fEowGzapceRmF0dS+FwqgD1UEEn9wnjyad0bqf9TSvkgo9LAGVDGOTltHbQ751jyMrgjRJhxFRwQh 1gEwv8EM2EuYOj3QVBQta/qwPUqZt4hf79yJnxFVn2Qe4FE7F3BNo1VINoX1OeoSOas49gxiU0vLvF yEqQwl1FAQfX+5LRBNGUN1fQIUog2yq2n983H+5VLjLoyvqhuZYcQ6UgiKaqstNoWzB4EWAnGnc3ug yWNmomVJw6k1UFKfsALGa5WcApCAhu9iyFdQj8GVRmjh52h2EaedqaBiGnmuB08wcvSdvWD7jiJwC4 O++5opcYSgnrWIGG7+srYGrNQLSeO++ltya/zfEU5O8d5opZ7/AntFL9NuDti0maVIaoidJE6ebLX7 REVakMxqD3n23pOEXBGS+7SONWBq1iaqyQc6MrGUrxfrmmwFTfpUTOYwgdFDCiEfHbKP7yNoYA9Fww /TFHTefLtPc+mnCUvOlo30o+YvW7FS+LMs5HvTAKMZKJ/t6IpNdBjmmRcExEvERiYCAWU+A/vC3Yg7 jc0Qk4oy8Xom4fheq9RXTZkFYKWQcK178mlD4gN4btAXLROwvCo5gRj/r+1BB0Conb5bjL3r+o6RvN CB+AJ4nRODeCBtPCinQkQp2ip5OLD8sLDOEHCtt5e+ju4gqU6rjWWQhPyHIw==
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


