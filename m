Return-Path: <bpf+bounces-37618-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F0295845D
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 12:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B073B26B2D
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 10:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9650718EFC0;
	Tue, 20 Aug 2024 10:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqkjv7Zr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC7F18E75A
	for <bpf@vger.kernel.org>; Tue, 20 Aug 2024 10:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724149456; cv=none; b=FXHvRQNRkMx4C44EwV07N6XV5e3dyPiSFyDIonUZ0g2VndIJAi2SKwvTxy0TL5wAfMplHBhKaAOOsRRH1Kl6gdbEKNFR/GzkNdW2QBHOk/hhBLdPyJclNSbGdTl8aoxotNICLXyKC+t5PEL7xPhHV2j1ItdyBc8uyUGVnuF/Khw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724149456; c=relaxed/simple;
	bh=yVxPsa6gCWsiCW3AJxdjRC7LaGSAYzijbIZJtLytf/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t9S8zb6Bn/7lRn2WFCPz3BBON7F82K/r7H7+XuAlyVyDB0NX3OHtoErfKV0m/bevrRPOvuvfJmLpRzgQ0W2SSQK3GPfx1KHs710ytn/pgZtWa0lLseMw1lM9FELqFpxnC58p0C/LqshSRzahOJyyCKBMKvAQ/zT9bMqbYtUCgW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bqkjv7Zr; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d3c05dc63eso3901931a91.0
        for <bpf@vger.kernel.org>; Tue, 20 Aug 2024 03:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724149454; x=1724754254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GzcUh7QEGUq6bk63EgLsrBYkdCv0nG08nmJodSuJF+8=;
        b=bqkjv7ZrbUZjAcwodjEgNyACFpeZlzkohXh6LP+LWypiaSHI6uCEgBNeK37z4wEjGe
         iEl4boksel686Uxm38SiNZwI2Mrc7L2J4nFg9tDAkvRTIzJsplkgWLm8HIYhN0ScjYoR
         uER+oq6xWv3BUWycl4qGsJh8vH+rOc8GyQZXiOSM8/mCcpPGqBV9N8P/82N9E7xjo+zu
         PlSmpwlUxsjRdpITEhmpM4HBGKqQbYW3c/AbA+ov5TTmwrrbKa+W+/DNf37gMaOaPgWw
         mxDuyFKtnO+IneSzGAudcR47w226Wa5w1yQ2y5Fv89KMi0GTdML5s4eVbZt1aS0GlPPX
         6u8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724149454; x=1724754254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GzcUh7QEGUq6bk63EgLsrBYkdCv0nG08nmJodSuJF+8=;
        b=ex7H6W7EPz0ndj6sR+L1NZH47gwx9J7ylrCZtsKDfv1uhFyXj5iiNNh2zXDTINj4bS
         8ArKL4NldC9z3nLEttTxUkcJ4+qC+xP5P8NRX5t8lmKh01jay+e+5j1AQLShKaNmFkhH
         mC5h7VjkPkCSDD7/QkubRL4VvKSKQY+N/ytFRm1k3PfJz3T4sHFLeY5uFV5ncwK4OdVK
         hY0JBBlGAVswLZ9Jq5aFrxuQqtZT6+I0mtT8Jrduz+l+MKESl3+t6g1D8YRbPRaN3I5Q
         jQgidre76w/ProA565msBQwVX2FuZURm7q1yPdhXKaWvDmSKaYMv93+NRH2GcV6wgEl+
         unQw==
X-Gm-Message-State: AOJu0YzSfdUO4YQhTasF24+N9XcTu+ENtGBZ7XtSZnbN8FcjSYblIR2J
	sUtjK1Cl5nH5574xyBPzKctHEp92RbWS7Swtj+hzs2d69Rz1mHONHNkEWBgX
X-Google-Smtp-Source: AGHT+IHET56YtQoEBEbhg9jrFb71+YuKppv8B6UgRyFHn7brFqRUeza9ByP/O/XRbCx7YWumMxtZ+g==
X-Received: by 2002:a17:90a:8401:b0:2d0:d82:60ae with SMTP id 98e67ed59e1d1-2d5c0ed2a32mr2005866a91.37.1724149453837;
        Tue, 20 Aug 2024 03:24:13 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3174bfdsm8976166a91.27.2024.08.20.03.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 03:24:13 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	hffilwlqm@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 2/8] selftests/bpf: correctly move 'log' upon successful match
Date: Tue, 20 Aug 2024 03:23:50 -0700
Message-ID: <20240820102357.3372779-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240820102357.3372779-1-eddyz87@gmail.com>
References: <20240820102357.3372779-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Suppose log="foo bar buz" and msg->substr="bar".
In such case current match processing logic would update 'log' as
follows: log += strlen(msg->substr); -> log += 3 -> log=" bar".
However, the intent behind the 'log' update is to make it point after
the successful match, e.g. to make log=" buz" in the example above.

Fixes: 4ef5d6af4935 ("selftests/bpf: no need to track next_match_pos in struct test_loader")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/test_loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 1b1290e090e7..f5f5d16ac550 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -522,7 +522,7 @@ static void validate_msgs(char *log_buf, struct expected_msgs *msgs,
 		if (msg->substr) {
 			match = strstr(log, msg->substr);
 			if (match)
-				log += strlen(msg->substr);
+				log = match + strlen(msg->substr);
 		} else {
 			err = regexec(&msg->regex, log, 1, reg_match, 0);
 			if (err == 0) {
-- 
2.45.2


