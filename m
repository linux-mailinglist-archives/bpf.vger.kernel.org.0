Return-Path: <bpf+bounces-22759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD20D8688CA
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 06:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEC5C1C21C96
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 05:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AE953369;
	Tue, 27 Feb 2024 05:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7M48vCE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369EC52F87
	for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 05:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709013168; cv=none; b=TAteBnQ4bdwE+5ERvOwKsFwPySVw82V1RBCZkSQyWX+sRFqrzsQ9qesGinvF55qyh3nSZatDo6esfz/Oq5+o0pCy6JpHHpeI4oFfuWkkVpmP4YIZJNDaWoqy0dBnPj3DDE+OMFqtSflOhfuVbkwrcAVyz8wnfiJ9I3i5AYB8sEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709013168; c=relaxed/simple;
	bh=FKob6W0vT+RwMxFTMQ75pUaLlDQU5b8zFmoB5dSk00A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uc2JtNpaMrAMc3b181z+lpX6UsUq1kut255KmZQy6Ce1kxrAcT2g8ubmEvqOFmOj5lvl56AQolqfxjfpGVmihCQyVGcELxAyQ1HApx7YD9G+5W4qnM5PjLtUEnTPTQ+UWkI59GWu4MuqX6qUMCY/Dae+0pRwV4k9bInlHiA4gH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7M48vCE; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dc0d11d1b7so31028475ad.2
        for <bpf@vger.kernel.org>; Mon, 26 Feb 2024 21:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709013166; x=1709617966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNSeGjjK7varE/siIBqgnSkz3us6p0kuFWNZB9lRO/0=;
        b=T7M48vCE+7YOwczoI3C214TNbEISAfwcZTGr0LVmrRtDn9RwpeA/2EaatytRCWSNM6
         tuos5BEHKQEOo4xhw/LMNIOczoqi2LpQLOwEO+R1AK1XKflYRDDM7jjzw8k0WUsZ/fbG
         p2IZIn0RhwBvWAL67iSuwF0UUVIoxa825uyfkLXDO0sIt71vMG5zYGK+h3okjOgGlwpO
         +T4Vp4qa7CV6GxBSav6o+KeohEFSqgRVFMSfyID7R92ssab2K5J7DPwkHyk8CiJkaLfx
         afCzJGqhlAIiD+/5VEPAjWf6/L3HI/JBdOcWiVHi6KLelS7wThe8YYh7MXiwGnAd8uJS
         753A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709013166; x=1709617966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNSeGjjK7varE/siIBqgnSkz3us6p0kuFWNZB9lRO/0=;
        b=mIBLwEnHdWtefAngyMDgwty41qDV9sMp7tEKAzCeBqiLlCY6O4iU5+suXDI7pzeMp9
         Duq7AjGZToTGoPFy2OFfZgVFNbLs0pm3/6MqU1zga6hzSHHuVb24gFzILw3YEyb1WZE5
         V2cUDFIEo1h8Myz1EpHIl30MjYzFDqqKpZERUCAnjLTwPov+/mkBTm969u5MzG8oomS5
         zNakYHCOAegmVMymgJ6sly/0RJJ/nT+jvsWAtCEt7hgiNwiJcJHMlULFi2fhTNnCDwDF
         IXj6iePcMi1bCUD/mt8h3G5HfRJeMfFRs3RAbNz1sLzOsuhnlRsIEHOoghI8kmODoEP6
         /Qbg==
X-Gm-Message-State: AOJu0YzyFNxPXMRIxuyYrBwG93zX7ZImozEr8ip7NC8Me3p5gbyOHsUB
	bls3fJQe+fscmjNDgJ5zfCAMIKl+RfQ21y8+Ek6AFpxyr29Pz4BX/Si9VaSe
X-Google-Smtp-Source: AGHT+IEmZ92gbBcLL3w3o4z9ItppM+pyJ/eyNBR08HhVsK1lfJNss29Ap0okzG7r+mxlq5NqiiCxyA==
X-Received: by 2002:a17:902:eccc:b0:1db:ab71:a4ae with SMTP id a12-20020a170902eccc00b001dbab71a4aemr10196993plh.42.1709013165837;
        Mon, 26 Feb 2024 21:52:45 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::4:45de])
        by smtp.gmail.com with ESMTPSA id z12-20020a170902ee0c00b001d8f2438298sm633218plb.269.2024.02.26.21.52.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Feb 2024 21:52:45 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v2 bpf-next 2/2] selftests/bpf: Test bpf_can_loop
Date: Mon, 26 Feb 2024 21:52:35 -0800
Message-Id: <20240227055235.23463-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240227055235.23463-1-alexei.starovoitov@gmail.com>
References: <20240227055235.23463-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Add a sanity test for bpf_can_loop().

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/bpf_helpers.h                   |  1 +
 .../bpf/progs/verifier_iterating_callbacks.c  | 47 +++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 79eaa581be98..70270f07074e 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -307,6 +307,7 @@ struct bpf_iter_num;
 extern int bpf_iter_num_new(struct bpf_iter_num *it, int start, int end) __weak __ksym;
 extern int *bpf_iter_num_next(struct bpf_iter_num *it) __weak __ksym;
 extern void bpf_iter_num_destroy(struct bpf_iter_num *it) __weak __ksym;
+extern long bpf_can_loop(void *ignored) __weak __ksym;
 
 #ifndef bpf_for_each
 /* bpf_for_each(iter_type, cur_elem, args...) provides generic construct for
diff --git a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
index 5905e036e0ea..3fc0e82ffc03 100644
--- a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
+++ b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
@@ -239,4 +239,51 @@ int bpf_loop_iter_limit_nested(void *unused)
 	return 1000 * a + b + c;
 }
 
+SEC("socket")
+__success __retval(0xd495cdc0)
+int can_loop1(const void *ctx)
+{
+	volatile int i;
+	int sum = 0;
+
+	for (i = 0; i < 1000000 && bpf_can_loop(0); i++)
+		sum += i;
+	for (i = 0; i < 1000000 && bpf_can_loop(0); i++)
+		sum += i;
+
+	return sum;
+}
+
+SEC("socket")
+__success __retval(999000000)
+int can_loop2(const void *ctx)
+{
+	volatile int i, j;
+	int sum = 0;
+
+	for (i = 0; i < 1000 && bpf_can_loop(0); i++)
+		for (j = 0; j < 1000 && bpf_can_loop(0); j++)
+			sum += i + j;
+
+	return sum;
+}
+
+static __noinline int loop(void)
+{
+	volatile int i;
+	int sum = 0;
+
+	for (i = 0; i <= 1000 && bpf_can_loop(0); i++)
+		sum += i;
+
+	return sum;
+}
+
+SEC("socket")
+__success __retval(500500)
+int can_loop3(const void *ctx)
+{
+	return loop();
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.34.1


