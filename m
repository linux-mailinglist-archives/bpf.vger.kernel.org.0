Return-Path: <bpf+bounces-75560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3449EC88C58
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 09:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 80F094ECA8A
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 08:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA77E31A7F6;
	Wed, 26 Nov 2025 08:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5/NUMYY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20F431A800
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 08:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764147178; cv=none; b=q0gOg39zjGJp0j2PTOTkZSx9npH1OlOw60o85VdUvgYteo3r2qpo+eJ5i5XCglCXuBGQDSZxa/MjF4XGeqHoeRxu+tLjwCzLsFIwlCJbAFAyqsZ0UzgyMtst+zARTXsK21dsciRNnRt8BiZ+ItELRxJRcIrfa3HqKd+6dF4+RZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764147178; c=relaxed/simple;
	bh=J4BoZTcMCIwSrHMIm1Wg115n46MGz6eizwWMi1v8YGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rgz3SIRujqoO6oO/1I62pz0vbtyVUhK95Vj52ETw0y6Ir4iw1vOWvFzzNdYlRlUBefnbAY7D/jauenz1DKgzezDZBHfCmRuT4FW6NeKtH3DjzLy2VzSLoYtFhnPSALc/6fSRIw343Ha8YiArPU4m14+BJ39pDhZrFS5jBIfBR10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5/NUMYY; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-29812589890so75893055ad.3
        for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 00:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764147176; x=1764751976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jgf6QzPNkLnaNG6eo7VvZMmMgNGAzeOfWslTIH6cEEA=;
        b=O5/NUMYYTPeuduAqlaPClPrzDrbfkLKttv/VLV6vTviO5yr7ianENsD/ikOOvxJAj/
         iLlisLfZa5FFqOD0GTgKj2SIIClcdIGJGuBAig/WAqm2139NdTX+mvotQ+Psb6cGQco4
         JzOOlmYI5Z+ZMw+aksufSjk+BCrDUY80c0pi7ryCWYxHNi9eqp63Nu0SWgEESR0vo9yw
         1LO8t/x6bofMI/eokskywivT1ySYSY/9tH4au3xfjCGfOpjiQRnad88MjYFTJrQzTmQm
         d22GkJCYbEzdOs1/hKneuzpx/bZhzRouvTtd2BQSVy2DFebLbgQm1FkEBgKuLqhK9X6P
         KGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764147176; x=1764751976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jgf6QzPNkLnaNG6eo7VvZMmMgNGAzeOfWslTIH6cEEA=;
        b=skacH7iRDlKv6B7n1+HvYypjD7AcPtQp1UrmKcN20b0SgkPxphjVDbA1xCHEZqzJXG
         TCFXKMCOI4I6+2eRJ647S7hCh8rsPnTtEc2KO8WEAiQ+drgH8xC0SL3+KeHucUadwj1j
         XUCkezZjSKLHPXRQHzTCrzpnAnIa+EvF3+32NJvazk4RbLxPKZm2Bau2qkmeZt8l271P
         Xfq4Iw2/k9cG6XE/bN5ZYlRHoghi6sdR94OphKZVsS+UkcuJ88XpxOypdBJAp3VEA7cL
         5egmGL0x1Kk7i/VywVdb09wTlqCy8kSLj6gCXJRlcJa0zIbCdlHl0bPhTU8PKYnlBDtL
         Ec1A==
X-Forwarded-Encrypted: i=1; AJvYcCUYBxoz4c0K6VyM7LxCyu6Eq0G8g1zdyEydbCEX4UtMrW5Jq9mjYCou1OjpL9rBWKNXcz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU2sVF7XELGRzU8owiBwedobYCJ6+AEijmCaViFHeqM9JsBpSz
	1gkkLEUHRPHfUe6bBKEgRyE4Cr1s/CVBHBgFR0GAWX59xmpjv9lpDQPC
X-Gm-Gg: ASbGncst97QPihWVH+mFm7vK0rbPPK2rfYXyx37B8cqQs3ZHClw82dQ8zaw/5cMgY2d
	XmIBb9QnAPK0d4wtg/L2WoXSTqJbNwKJ2g3oqslPYOoUj2mrRVK7dWwjrdVv1pa69Pz89CyNcTT
	vOO2XonPyKnKTRZwXGWG+FzwNsP/KXKJ4+6zALGXwH5I/K4IuWdox/3X4BVGlwIYGBYO4dIUQBm
	JRMsqIZmKn1ek6LBqoXeGrnlAjfD1OjhDyXNOEcMVPYfpG/qUXunhmnzlpK+abeqcg6OnczKUpt
	0vWrI3sqZBan7Gjr0mSwWfuR0fOwxl9TY+/C0xksyw/4urgk2BhL9g0Qn0Ho1VlTbqIMIkO04lE
	Dp8uzmZ6p00qQpOv4GwJ48kSaGuxTNrw4oHAs8ajtKu1dj9cHfRhUxYjokIDsoY7yamYRkfQm7Q
	etAAFCsto=
X-Google-Smtp-Source: AGHT+IFOTPUQKLezoW1PtOgUH7V/2VHPRcXFHERr2qyquuXGdL9D0nyn1gqUNf+kzQfWgYx9ll5PSw==
X-Received: by 2002:a17:903:110c:b0:298:ea9:5732 with SMTP id d9443c01a7336-29b6bf64a07mr88019525ad.41.1764147175929;
        Wed, 26 Nov 2025 00:52:55 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b274d39sm190678305ad.77.2025.11.26.00.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 00:52:55 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.or,
	jolsa@kernel.org
Cc: kpsingh@kernel.org,
	mattbobrowski@google.com,
	song@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	haoluo@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpf: make kprobe_multi_link_prog_run always_inline
Date: Wed, 26 Nov 2025 16:52:46 +0800
Message-ID: <20251126085246.309942-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Make kprobe_multi_link_prog_run() always inline to obtain better
performance. Before this patch, the bench performance is:

./bench trig-kprobe-multi
Setting up benchmark 'trig-kprobe-multi'...
Benchmark 'trig-kprobe-multi' started.
Iter   0 ( 95.485us): hits   62.462M/s ( 62.462M/prod), [...]
Iter   1 (-80.054us): hits   62.486M/s ( 62.486M/prod), [...]
Iter   2 ( 13.572us): hits   62.287M/s ( 62.287M/prod), [...]
Iter   3 ( 76.961us): hits   62.293M/s ( 62.293M/prod), [...]
Iter   4 (-77.698us): hits   62.394M/s ( 62.394M/prod), [...]
Iter   5 (-13.399us): hits   62.319M/s ( 62.319M/prod), [...]
Iter   6 ( 77.573us): hits   62.250M/s ( 62.250M/prod), [...]
Summary: hits   62.338 ± 0.083M/s ( 62.338M/prod)

And after this patch, the performance is:

Iter   0 (454.148us): hits   66.900M/s ( 66.900M/prod), [...]
Iter   1 (-435.540us): hits   68.925M/s ( 68.925M/prod), [...]
Iter   2 (  8.223us): hits   68.795M/s ( 68.795M/prod), [...]
Iter   3 (-12.347us): hits   68.880M/s ( 68.880M/prod), [...]
Iter   4 (  2.291us): hits   68.767M/s ( 68.767M/prod), [...]
Iter   5 ( -1.446us): hits   68.756M/s ( 68.756M/prod), [...]
Iter   6 ( 13.882us): hits   68.657M/s ( 68.657M/prod), [...]
Summary: hits   68.792 ± 0.087M/s ( 68.792M/prod)

As we can see, the performance of kprobe-multi increase from 62M/s to
68M/s.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 kernel/trace/bpf_trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index a795f7afbf3d..d57727abaade 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2529,7 +2529,7 @@ static u64 bpf_kprobe_multi_entry_ip(struct bpf_run_ctx *ctx)
 	return run_ctx->entry_ip;
 }
 
-static int
+static __always_inline int
 kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
 			   unsigned long entry_ip, struct ftrace_regs *fregs,
 			   bool is_return, void *data)
-- 
2.52.0


