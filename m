Return-Path: <bpf+bounces-58879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D18F2AC2CDA
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 03:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 510CF1BC7036
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 01:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87CC1E00B4;
	Sat, 24 May 2025 01:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8usQLPq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D1E1DF723
	for <bpf@vger.kernel.org>; Sat, 24 May 2025 01:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748049539; cv=none; b=W/pF+7HPXpq+y8SC9NGTbEt7iQn8dsYaM2QqS1cMB8V4QpNivkzJqxxW9qYSxibqhAnaMOru8PtB0YNr3VTh64KWNJDF/abzMPIkIL/U47bFEqJmYsQp4ny7qQsZ9vNs6aFxMVG6EMR/kscw2FZ1nDwSpuXtkbxY/tojjJhqnQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748049539; c=relaxed/simple;
	bh=BMZGBZC1c9IdXCmHN5cU9qxVjSdz2TpYWZ+00NXgo74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mC6SI5LfHqqWcs4Nv+onkbwjniLaCTxYMzxV/IuHV9K5lKEMg/XLPRr8FHoY8wfTPqSDLH2wm/W20yanJl0JBSH05Epp5VwtrPb2aEVxyGP/H4R+lLoUkudyxCJibPqsgo8RTnAQTUmNSM1LNmreG99gCPyJ3CumDkYaJ3IMlGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d8usQLPq; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-3a35c894313so364403f8f.2
        for <bpf@vger.kernel.org>; Fri, 23 May 2025 18:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748049535; x=1748654335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4xgYRqWXUikMY0hhR5dOa3ZRNYc1WXf3aM2e6NSSak=;
        b=d8usQLPqD9UWUqtPObH7I8DzZHtUrqe/GynEF8moOQqRw8PQ83LNPKpaClya3F0RmO
         novgzwcmxlTx62FrE2SE4KTZJ4Lqg0vUrZgn9JHIni6KKXUWSszi0RHx+WUStq6fs8y/
         bmba70mI4RsfxPwhRQgV5xfkNuGTDr1HDBtfqHOKsdMdlUAiuUszn8zLg7FW0HHXpD8V
         acdkLtVF3LAPMhbvy4QykLpvkPpNsfpal1/l5HvC0JNUg3ag20xMqhtSnBe0teR6gdFi
         zTH8JLt7wgFsPYSa5NOgu4/7wW+5vDyWUfZCeV9vvrY/B4e0tvwWBRfhlYYYPP19cLEB
         tVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748049535; x=1748654335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d4xgYRqWXUikMY0hhR5dOa3ZRNYc1WXf3aM2e6NSSak=;
        b=KRJM/H1DwyouLBhjC+BGU+ttoaU/tNUlwEKNwaPybFtoGLsOzSQxMDM0ggAhffTaAg
         rr+N4XRLWd+g+q7KdHG2V4E0zZ9si7glHkWzduV8qg4Qar2giGBrlxWk91Yl+1T8dR8S
         NXGH2DxEuJbECPlKfOVxhKpFDg0VVd5vp8dudKYFM0aGYRzzFPi+8WrY5HUHmIDKXZ/K
         UdEOY5lT0GyBwR+RusmVYPlRKEM61svt2muqpHWZN/fkJ1Ie/ZdqCFiZGEnWe1t9spPu
         hY3yr8E6zzdKVxtJ2RgSpL4AJv+Lv/bJc/SKiuHn9B8ozHZwc+Jh8mH8TerssT5T/zYF
         sBsA==
X-Gm-Message-State: AOJu0YziLTz7GE04BXrTcVLrHR4WaP/iF+xVLVRl4RViAGps3mKCNa/k
	pLAWtjpqDDJ1oFquJRZVDYnzF4FjdCOS0+BacXq2Yve/JFghyY0aaQS3TAwTT+9Ncqg=
X-Gm-Gg: ASbGncvHzbtPLCEDP/k/Q4dBYtwo6+PwlvukExtoJ0zetGL2RcceFVxjMcukgS0SOZQ
	nrnxwPHifI7k+FHsjp6oiLpH9lnOSNi652kT5TBAkDIapM46Vdh+cFPJ3B/RLECRcDCKBB7iTbf
	SfI3jv0QKA1gaoL46mAUPR3p1jTv32hPMzYcDeD1a/OxVVQU7ZORXieSrN+4GdaKBOC8OCpOt68
	7DmjPTVe0BnBK2DjZiPWuFPymVQxgxbNU0bv6140MHTCzbTj1tYjJVvSxH2vEnbFRhbGOyuxY7F
	ZCNYV0y+RfLaDDPegrN/wkNizfQiZ2mQWey4JVtHEg==
X-Google-Smtp-Source: AGHT+IFQFsf/iYZnawK7VUtXn68Aic8+e6iqYA9rYAPyWmjnOtcsKlMr/5JmFGPC1wZU9ZopHtBFPQ==
X-Received: by 2002:a05:6000:1844:b0:3a0:7af3:843f with SMTP id ffacd0b85a97d-3a4cb46d2fcmr838322f8f.19.1748049535502;
        Fri, 23 May 2025 18:18:55 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:46::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca889d9sm28253619f8f.77.2025.05.23.18.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 18:18:55 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 04/11] bpf: Hold RCU read lock in bpf_prog_ksym_find
Date: Fri, 23 May 2025 18:18:42 -0700
Message-ID: <20250524011849.681425-5-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250524011849.681425-1-memxor@gmail.com>
References: <20250524011849.681425-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=885; h=from:subject; bh=BMZGBZC1c9IdXCmHN5cU9qxVjSdz2TpYWZ+00NXgo74=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoMR3P0FoQxlKIYcd1PEiKhxrXtdjVL50qYT8fQXC2 rEqs1DyJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaDEdzwAKCRBM4MiGSL8RynCTD/ 9R6JUeYde95nLoinSisn2mRxJUAhft23Q8GFIx0k7q0FX4vJmXHcE8FNrpA39lVeatKnroYaBLCrqT Co/EXPznDAmW/gMwBvJDOpgJe98kmqS7ya6BbmBbYEKETinmeF/qnKX90BcFTzWkRIpUYKhq6/vEXE DYBrKjvf8tcDoO6S+pPWz2ziYvhUUOxvsyE2SuqtMpXOdLE18mX3GN+g49/qlgNtSqYIA5Zga3fu5i jgR6O8RN8cB/WLKg80KSuNG/81rrRdUSIrXSY9pqIDIsEw9wYXSEoCjMDOVY4loPR4pp443cLVRnLC BDqUoy32U3ocJ7/GrjlcmWBAZ1qH6y6v7S1STTzCkYQPKApwXrXiOeap0i85XKmExFFaQ6ye4QUa5t 5L8f3EsYS3D+1kjSjcT4vUvMOOvt9bqTvotvgN2/9fIJ/JEITtrzvFNSbl6oP8sGp7ACCyt+kySUst xrocyzwBTiDIEiK9pYjX3R35I8MaQFomhJhhc+UOMb0m5I5VVGm9lrHks8qkQ22yZ+FLwCRt3Q8lD2 vuH/8mR3x1jMcoT2Wd5nsWSPka3Zx17J8OQZCQLgodTUS/XUsI/HEbgl2a67l1pN//1iZ8vwf6DUgn l6qWzSES0h1NTVrTUxAXngQMroRtZUKtSjNm5c8J3IScul8lqU9U+yrBXMMw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

The bpf_ksym_find must be called with RCU read protection, wrap the call
to bpf_ksym_find in bpf_prog_ksym_find with RCU read lock so that
callers do not have to care about holding it specifically.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 8d381ca9f2fa..959538f91c60 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -782,7 +782,11 @@ bool is_bpf_text_address(unsigned long addr)
 
 struct bpf_prog *bpf_prog_ksym_find(unsigned long addr)
 {
-	struct bpf_ksym *ksym = bpf_ksym_find(addr);
+	struct bpf_ksym *ksym;
+
+	rcu_read_lock();
+	ksym = bpf_ksym_find(addr);
+	rcu_read_unlock();
 
 	return ksym && ksym->prog ?
 	       container_of(ksym, struct bpf_prog_aux, ksym)->prog :
-- 
2.47.1


