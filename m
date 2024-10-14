Return-Path: <bpf+bounces-41854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E0E99C7CB
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 12:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 169BC281D7D
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 10:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024BD1A4F20;
	Mon, 14 Oct 2024 10:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siteground.com header.i=@siteground.com header.b="juzleSGj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CF41A4F15
	for <bpf@vger.kernel.org>; Mon, 14 Oct 2024 10:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903366; cv=none; b=U1jQ2LR8ERCR11EDz4U9sFCM9yQNceOqPQcDxAuCk3LTpvFMLhu/5vtkPoQlit/Stco/6QOOFM6NALVz1pGQkdrgIBxyqHl7T6YiWjpmd/6FoGBCdeSPDq25pqZlfQLGSbAoo9VEAuf7pz9wTRYBDI3pWxbvNxj2LUJeydhaet0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903366; c=relaxed/simple;
	bh=lVE0Ob+ihplK2ZdSoin0DUnQqzukpB6hkjsVZNfHAmc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m32WtFBfP+SgXQPArIT8CfKF8e5AA3zLzgemoz8bAtpNRsNJ1jDJOB17aCsYyUrA0O5pbMzKcN3G3Q2XShEEVu+8iQaZC/+S4vMQ9IgKgkb4LkqU80ZwQNUCAjNi6TxjXXww3DIPLhVG7nL4SsMNIGMGcCiapVg1xSS8ScdXmRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siteground.com; spf=pass smtp.mailfrom=siteground.com; dkim=pass (1024-bit key) header.d=siteground.com header.i=@siteground.com header.b=juzleSGj; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siteground.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siteground.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a14cb0147so78376566b.0
        for <bpf@vger.kernel.org>; Mon, 14 Oct 2024 03:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=siteground.com; s=google; t=1728903363; x=1729508163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMLjbfjVZfKT8rnpaWVJZnN33l9IdfLPTHhbSw3d/xo=;
        b=juzleSGjqgj2/wsQK97yFHMms96ERAoxFgv1CcV9hziQ8brA/gXlR5pAx9T7Oei1hs
         4q4kMnsOnd1rgYlBPwN14en96i2tTywwGuiqg7XJD/JU21r3a6jEgVcG0i0vRvBpO2Oe
         F8wDFrgcl328KuOk2kUxywdRNXXc8kJGKaaVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728903363; x=1729508163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OMLjbfjVZfKT8rnpaWVJZnN33l9IdfLPTHhbSw3d/xo=;
        b=Y/FnMaWY1wEez9c+Rh7p4CHWkaFBEmPMFi/xcsOSxmxq7avBx/ENwTwOtuZd8oJUs5
         09/lD11B+kmHdCmWofnPtLEFS54Q+2snk978hC6V0LXEZd8RPDS5ZApIDLNU/Hby2pEO
         UlkGE3Sf6oyObpT/beXwTK2GaWa+sK8sZKfCUbSPYXYzvLRu1HMkgX3faP/kZy/seqQl
         aHVdqbTqOjmzkGgvHNm8vXilxx5Nd3zjNd6mljkanGjV+S3SBZlvjVkx8+C2X1wZAa/m
         xuSsSoUm6GLXoWzioTvxIEZNRM1FxDSzUEByA4IQk/Ez3yGtoIoI8tZR0KeU3t3nx+eP
         Kjow==
X-Forwarded-Encrypted: i=1; AJvYcCXx2o9uVDUvPwnL0XE8OgvWorWRFjQ5MHDs4gS4v+CyU4swMJpwcU3DraeZczY3j10C3eU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0SqeghiWP8vyH8ILXa8tb1jNXxzOhXHvq1cDEpTiJqTo8VmO6
	q3uJhDgPiGtfiyek0jKQthkbc+0n5R0lzId+J3EyYcpyQtGPggQnkdoUv4sPmgg=
X-Google-Smtp-Source: AGHT+IGIykltc+g0HpfZB3R+IdiUjtHz8zjpwIeHIr+pze/t1MPx+E/8kqgdLt1WR1NCagB8UiWt5Q==
X-Received: by 2002:a17:906:fd88:b0:a99:d308:926 with SMTP id a640c23a62f3a-a99d3080adbmr856885266b.57.1728903363312;
        Mon, 14 Oct 2024 03:56:03 -0700 (PDT)
Received: from Dimitar_Kanaliev.sgnet.lan ([82.118.240.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a0c95c80asm159996866b.144.2024.10.14.03.56.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Oct 2024 03:56:03 -0700 (PDT)
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
Subject: [PATCH 2/3] selftests/bpf: Add test for truncation after sign extension in coerce_reg_to_size_sx()
Date: Mon, 14 Oct 2024 13:55:40 +0300
Message-Id: <20241014105541.91184-3-dimitar.kanaliev@siteground.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20241014105541.91184-1-dimitar.kanaliev@siteground.com>
References: <20241014105541.91184-1-dimitar.kanaliev@siteground.com>
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
index 028ec855587b..8e37d44d87e5 100644
--- a/tools/testing/selftests/bpf/progs/verifier_movsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_movsx.c
@@ -289,6 +289,26 @@ l0_%=:							\
 
 #else
 
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
 SEC("socket")
 __description("cpuv4 is not supported by compiler or jit, use a dummy test")
 __success
-- 
2.43.0


