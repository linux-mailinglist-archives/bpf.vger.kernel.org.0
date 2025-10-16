Return-Path: <bpf+bounces-71072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A567BE1595
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 05:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E1C919C6A7F
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 03:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE681F4CAE;
	Thu, 16 Oct 2025 03:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIT+NX43"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D4418D656
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 03:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760584771; cv=none; b=BDRTZRu/POlLpQ9x5jPfgWxooCL48E5bFtSFUgJVk6UFx9Taos6xcM6vPGbGx9WTVIfHpyR3BMpqWFK2M/wsPe4JHTbw9r+YNMKudI4j7WzBQqKjriBMP8wMY0Ns3+Hxat+FHr065SpDBHEOiViXj+OezcidFdrT2gSJc8N7JCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760584771; c=relaxed/simple;
	bh=g1nKlbTESNDH4VVUn9g+7CtmZGgAzIVfoPUIFApydxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N7Pr66F0mUpLOK6gDIMzmo7GLkTkdyZS8ao39Qd0JHpvgWKxFv9cy3Joj9wUFiLIJdT7Fjk1D9UUETqxa67T0lVU3oDckeSaPvV1eH/ARor5eshXfAnWzjFnlP42fh/Wb7aS7Is9WSjtEIHMXla9tV2PnmwZ4il/VkK5RidfGig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIT+NX43; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2698e4795ebso2793795ad.0
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 20:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760584769; x=1761189569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Bx/iQgFty+Ih9RtA4OkcRz4bv15d/JUq+vGVdq+OfM=;
        b=MIT+NX43C7e3L6D9Ft0Qcs+BOjba5ZfDtz7p8eJA4LuJ2/drPEnyuGRhaVvIiaxzBd
         YdEVAcw5lY0BhHLl60q5v/qZahvJ9GTjhI4E81nLiZa0gT4lirxbSB7yxjAUOpFxAPdL
         BjvqjAfD/s6wmTsLISQpkHfampN9X5PfoexHa3KUnvr6KjZU0zS7XmanroiqmT49w/D1
         H6lh199BZd+ldP9wt9/vI/4lM6wgpO/nfSaMdF1ssbGjCnTsYkeQF/+Yml2rrDZ0Z8gl
         OAsvWn4mfGnK2+hbJYmCSEzdMCrf5aP+DPSQAH9CSERTncpxAuuufE2F1RlMISUau6ia
         fPYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760584769; x=1761189569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Bx/iQgFty+Ih9RtA4OkcRz4bv15d/JUq+vGVdq+OfM=;
        b=D6+Vhb7860BNEc7vhI8TYEAUEPs6OF/xaWkydyk28C9yNc+riUGfpP8EmHEOGMOOXZ
         flMIJqFTgvp+FZIi4eNVElPKbc0yX07tfYa+yDcreLpZ49MaZZR2AdgWNj/sNRpG1dSn
         7F31xwV+8oo2F9Ge/YyiLNGvUGD79GMGdAkWtwwtuiCwGAUzaY3QESEfvadsoK5qCDVX
         BlNCcX1RoGDP45FYyvMNC+nL65YVWhj9AIC3q3rK/ecsK4QNy/UoQuDyBBNOnULiUzm+
         V5vzfsT3mycQp5uIID5WFwtScSF0sb2+ZhgogtpaBVKyUMR9bUK5RkaMWKSrGBeBuCyv
         fzig==
X-Forwarded-Encrypted: i=1; AJvYcCUAfG0xNq4j91gU2W/91Le4DXRTRGORUz7Bt7bKIXrqWZLUnfiozyC9YTpJubOQqfASp5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyAc3EAmn75Bbfg0kAGkvnE4zvPBEXlUGpMbv5GkBXnkvv5hdw
	nSDD3+dkAcrtSx2UN2bKTUvXQvzRIJO4iID7mmCE2JcKY/AvuJpFKkU5
X-Gm-Gg: ASbGncvNmagAyxezjInrs1CzshbtBewrHF/f4XowtDPFidfdiTHEBNVkisyLkZj8gkY
	HAX9sk+8+PTxAEyQFO/8+f/VANSJnI24tQs6A2EIvSt6u+vvKFV1s2LTsU1ZYEfhnBNbZNgglHt
	5rrnhvEI+OOd4byz/AL+oPh4TELyJFcUBGM0pVbgdY5KxUJx5XXmxo64fXK9Dz4zNulLkSWBEg7
	vMzkMTH2R69gcSuPpXF9s8a48mzBXibKXIbEk0WiQAKs1bVUrfqRkZCBcp4BAjeCGLSxwLk+3h3
	W9BPgcRip4HtC0zwTYYyms3l0vHsCjTqQMVnCg4Q4qxXFdSFNaPI1p4w0hNBZqE3vLScEo2iXJO
	YqT48Q2qXPN3Pu7uRrbNjxAuHZx6Ll+fJT3x+cqVQYnHfUs0jBBY4A3gDbSG5xfCYb8WvwQ+hbF
	VukQkbPDv2DcqcKmD+XsNzffOQdcifenp6ZrtV2V8=
X-Google-Smtp-Source: AGHT+IFGgrQQezuUmj3bgEqlrU/M5qvpgXc0yxELz/SA5/yvCJAwWZGvoq/U4EbOgHCFzOpjKLISKg==
X-Received: by 2002:a17:903:2c06:b0:24b:4a9a:703a with SMTP id d9443c01a7336-29027373d80mr426369245ad.17.1760584769404;
        Wed, 15 Oct 2025 20:19:29 -0700 (PDT)
Received: from laptop.dhcp.broadcom.net ([192.19.38.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099a7de45sm11916855ad.54.2025.10.15.20.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 20:19:28 -0700 (PDT)
From: Xing Guo <higuoxing@gmail.com>
To: andrii.nakryiko@gmail.com
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	higuoxing@gmail.com,
	linux-kselftest@vger.kernel.org,
	olsajiri@gmail.com,
	sveiss@meta.com
Subject: [PATCH bpf v5] selftests: arg_parsing: Ensure data is flushed to disk before reading.
Date: Thu, 16 Oct 2025 11:19:23 +0800
Message-ID: <20251016031923.3169221-1-higuoxing@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CAEf4BzaSPbsWGw9XiFq7qt7P0m0Yoquuxca39QrvorKFeS+LAg@mail.gmail.com>
References: <CAEf4BzaSPbsWGw9XiFq7qt7P0m0Yoquuxca39QrvorKFeS+LAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test_parse_test_list_file writes some data to
/tmp/bpf_arg_parsing_test.XXXXXX and parse_test_list_file() will read
the data back.  However, after writing data to that file, we forget to
call fsync() and it's causing testing failure in my laptop.  This patch
helps fix it by adding the missing fsync() call.

Signed-off-by: Xing Guo <higuoxing@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/arg_parsing.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
index fbf0d9c2f58b..e27d66b75fb1 100644
--- a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
+++ b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
@@ -144,6 +144,9 @@ static void test_parse_test_list_file(void)
 	if (!ASSERT_OK(ferror(fp), "prepare tmp"))
 		goto out_fclose;
 
+	if (!ASSERT_OK(fsync(fileno(fp)), "fsync tmp"))
+		goto out_fclose;
+
 	init_test_filter_set(&set);
 
 	if (!ASSERT_OK(parse_test_list_file(tmpfile, &set, true), "parse file"))
-- 
2.51.0


