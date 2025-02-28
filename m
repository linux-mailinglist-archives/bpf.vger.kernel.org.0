Return-Path: <bpf+bounces-52897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C79A4A284
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 20:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E1511675A1
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 19:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5481F8742;
	Fri, 28 Feb 2025 19:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwBPscDq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D6A1F872F
	for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 19:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740769994; cv=none; b=iX130XGh9XLjXZOQrTqiztUSaxXMfDSvLBtUMzJdSkFIJxqOeK3/9rC5N7tlACYlnr2eGj+V2FmEBeMNbQXrWmrDkQ/PBP3JWltELwmak2vcRX+XycuvF1ALy8BwxkcMc0laEEs/cD94Iy9IUxRVNNAu8ey+TYj3Y+XtMPSATa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740769994; c=relaxed/simple;
	bh=bSNL6W+oslJnsbUQZrpbZ2b8gNdI4HP3KLxTzQXDROo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LmZeiiBsmsFW808aGcnGncS/hxBXbVZLgokNKAojvBwt4z6cvzGqekDu1JdoE9y87gm+tOt6ov7/wiIsPRA8kPalv3wUTFrFJv8Tafbs1dHR0DKsy9MXBIbVk5LwKnGQOHyttrt6blyan78Rf2Mr+aaUMyZSfKsn/sx7Kf+hPO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwBPscDq; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2234daaf269so1678025ad.3
        for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 11:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740769992; x=1741374792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oda+1kcL1h0ggZQHubZyyeyWtntJD2ws9F9PynPUyvs=;
        b=kwBPscDqI1Aft3bUNptqHMlO6zKiCZkiEPOpZ+/Tn94rnNirW9afb7S+0BQaGIKKGk
         HLGYdGQU7bVZa3z5AKrI3AKKoqLfIe3dUX+x+sLHt+mCyAuQDNnkrFrQmQE67D+SMRxA
         SwWO20AewDA1N0H45/fwfHhGfVdJF4vfmonRLcZkTXWt3xxnk/QjtEy5kKmBreN4Ag3m
         rDamHvlDA3xXSRxdFJkPDCBsGjAUkci5MReID34xGXOfzNe0vMBO6xkAsaV06o1OgTnF
         GPd9J1yxw+D+3qsbD9P2c6ngpZenjiZSAQb/Lzs+xlsnqK4aIGDuF4FDa3sf8fLenWbt
         Bx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740769992; x=1741374792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oda+1kcL1h0ggZQHubZyyeyWtntJD2ws9F9PynPUyvs=;
        b=XnFtN0qbN9x9/DLPWNFVhZBiOD+ZVU09GUPOar/iiIMzof82lfM/HZ5kr608GWu1ap
         odIAuwWfwEZtPqHzHCTU8enfoyCc3qwAyfAWQncKB8xYZCekCHCSOjNkciFtZ+wAEglb
         TzpbnPNcEOeZcgU1V06gBFkS/aTgG2ScL5vtw+ihBt+lhZBJpBdG3vHd5WvIdogjB8WX
         Al6AGH9ytY1yKs5MfID/m9j3DrlfDJ+9Yit1TTVJn3ZaJZqGxB3WGDO0mlHji0GRvDh4
         hie+eQ2x8u05UCqfj89lSwxwSiRZDmuhMwc6TCocXIunZDNnGyrJ0bI6zgZDiph/samy
         vnqA==
X-Gm-Message-State: AOJu0YwGLM0/IdNOEqU2PzJSvPTzckdTL1sF3BCqTRtrZ8vCqNonYoyB
	tIFFApjX9nzhxSt+4JToTxEzMd4929WMbs67SpvPPZwvs+ZXJfi5mRprJA==
X-Gm-Gg: ASbGncv0XAhJtewh0jdQTBDWltxyCVryqx6elYkpUgmK4rFQoPo8IKqfn/wXmT1N9Bt
	oPs9JCCsYmmi2IgLawdqDAqZIuSJaZ/K7pOJseqikNE3+Ji3knmemmIlLgmfs9ScNvpLYndoAsp
	zjQYNO0azhxHfdAGzvPHCLl89V0DQudNhR/Dl58k7M4oq2LrRbnVb/GlRKgWIDmspe1hbnhByq6
	K/3yrx5xs453pkaqqS5LK2VZt78m2p+aTYoUOyyX6MTL/hr4zGfOKVW7pxL6RH0Mr4hFr3mZnkf
	mL+845mix6YwF4JHg9C6xg==
X-Google-Smtp-Source: AGHT+IFD+KT2Bpz82h8YOtXSHL+XzJ9mgPUiCwEt1S5oXiQ/AcVnTD9N+KfR/JeaE5s2GLj8E6Rruw==
X-Received: by 2002:a05:6a00:ad0:b0:730:8a0a:9f09 with SMTP id d2e1a72fcca58-734ac3f3155mr7810198b3a.18.1740769991558;
        Fri, 28 Feb 2025 11:13:11 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe48865sm4228799b3a.50.2025.02.28.11.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 11:13:11 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 2/3] veristat: strerror expects positive number (errno)
Date: Fri, 28 Feb 2025 11:12:19 -0800
Message-ID: <20250228191220.1488438-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228191220.1488438-1-eddyz87@gmail.com>
References: <20250228191220.1488438-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before:

  ./veristat -G @foobar iters.bpf.o
  Failed to open presets in 'foobar': Unknown error -2
  ...

After:

  ./veristat -G @foobar iters.bpf.o
  Failed to open presets in 'foobar': No such file or directory
  ...

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/veristat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 8bc462299290..7d13b9234d2c 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -660,7 +660,7 @@ static int append_filter_file(const char *path)
 	f = fopen(path, "r");
 	if (!f) {
 		err = -errno;
-		fprintf(stderr, "Failed to open filters in '%s': %s\n", path, strerror(err));
+		fprintf(stderr, "Failed to open filters in '%s': %s\n", path, strerror(errno));
 		return err;
 	}
 
@@ -1422,7 +1422,7 @@ static int append_var_preset_file(const char *filename)
 	f = fopen(filename, "rt");
 	if (!f) {
 		err = -errno;
-		fprintf(stderr, "Failed to open presets in '%s': %s\n", filename, strerror(err));
+		fprintf(stderr, "Failed to open presets in '%s': %s\n", filename, strerror(errno));
 		return -EINVAL;
 	}
 
-- 
2.48.1


