Return-Path: <bpf+bounces-32014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2150390612B
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 03:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1D671F21737
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 01:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745B818EAF;
	Thu, 13 Jun 2024 01:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+xsrkfX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D1E2A1CF
	for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 01:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718242714; cv=none; b=W+rWz5fRu3iBHNPoR4UNoQ80AJsW0OqZ9rUa4hhSt9S8OM1dXQANzUYd5saEoBZBqgeubejOckEiOxKhW6OPHH4o1r4Oat4Upbi19z5DpApWtjnlYN6/hjM9BHNr7iz27dcjjySoRFB1QWnmKZFRWTchafxJsrSV5u84s3XjECI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718242714; c=relaxed/simple;
	bh=Gm5gtUs7ESel2//jbT0TijXe29JcPEixmsWoeLbvHjg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gp1UVNebmaV9yIQI8YbGpvM8MgaXSmPUlYKT0Zt5FwMe9tfGXIi6G2tRfkHUfotIDMeA3aJQLvN6jcLJl1Lmzf3TPUqwz1QZGDkD4PHtf2VhvT4OoUpQORcTzIh7Jc5Y8gkG/zCmuULf8qJAV9Xj/hPk+5vQSXUb+bsl9HqOcJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+xsrkfX; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f44b5b9de6so4351385ad.3
        for <bpf@vger.kernel.org>; Wed, 12 Jun 2024 18:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718242711; x=1718847511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Us1aqdKDZ5u/C9Le8gUMjYEff67H98STOGSj9ePhdrk=;
        b=V+xsrkfXYXoTXFGfMegh7xbtQtiznoslh6HC21A9bb0umT3BV79JkTwgp1c3pb9HGS
         JkN3hhYJZRwetFNThOInA80mRkH4Ty5D/1FinwBki4/UuwUMtm9YWrix/2T6m+wxYkXY
         XxVZnVP4nTgoJF2FVgXg4YG/6CFKIqXur/z6pGaI0hJG2gNiZNT4oQ4HSPNH4uQvDmT9
         NVqjrHIZVFIb+Zaws23/yugEkcdBVo9vN8mZLWGw4KN0sejlUiljJNunLhdAAry+ssQy
         MhVTQaZQTXNofMks8F97lmNe6a9W9jVXZbijlefFYwaTalnCS8QmRr3oYHwvra5skBFH
         lEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718242711; x=1718847511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Us1aqdKDZ5u/C9Le8gUMjYEff67H98STOGSj9ePhdrk=;
        b=nqJxq/veGhfzijM5x47QnXh0zKWHbSS1OumYi6z5gIe01i/sQnJ9E++3Ad0wK5+SbK
         yRpABc21WORwL5acpce+cKo2qQPX7LLHhKME/aokKkHH3gvt3g0PHY3df7ykHDYHnTho
         rr4GVm62N2zCDNfDbKPU5nb+4k8b+R4aaSGrOLqQWvjUgVnWL1jl6TDSoz/P/2oOTzpt
         6B40CjgEIz46zP4zygRQqhFqzLHwTBLk7aOZvl7BFbuq5p0HdpajHNLPonBsON1mNpap
         hKw344OAfV1pkVulaO/lRja7GRk5xuPr4b2YGjLZ9TGZHlc8NeeORT1DbLgrmxA1acmk
         RMsg==
X-Gm-Message-State: AOJu0Yzz6Zl5GpfEgszmMoHlw1eeeXlLy+u4PvxFiRY+RsoZZ/JWDmEu
	zDQVBPtGxOBe/gZ+stSYre4rBkZ2nIVBm/BabW9vxkKvcKZlO7ZenmOZLA==
X-Google-Smtp-Source: AGHT+IFGYl3IWcCKw/3V5YEGdYNfP0q8xYgH0dQ5VFnUgwUMLiE2J5bX7I8hEcKapsBK1G4Upru6LQ==
X-Received: by 2002:a17:902:c944:b0:1f7:2091:978 with SMTP id d9443c01a7336-1f83b60919fmr40866005ad.37.1718242711255;
        Wed, 12 Jun 2024 18:38:31 -0700 (PDT)
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::5:b914])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f2fe6dsm1287355ad.257.2024.06.12.18.38.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 12 Jun 2024 18:38:30 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v3 bpf-next 3/4] bpf: Support can_loop/cond_break on big endian
Date: Wed, 12 Jun 2024 18:38:14 -0700
Message-Id: <20240613013815.953-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240613013815.953-1-alexei.starovoitov@gmail.com>
References: <20240613013815.953-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Add big endian support for can_loop/cond_break macros.

Acked-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../testing/selftests/bpf/bpf_experimental.h  | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 3d9e4b8c6b81..82b73c37b50b 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -351,6 +351,7 @@ l_true:												\
 	l_continue:;					\
 	})
 #else
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 #define can_loop					\
 	({ __label__ l_break, l_continue;		\
 	bool ret = true;				\
@@ -376,6 +377,33 @@ l_true:												\
 	l_break: break;					\
 	l_continue:;					\
 	})
+#else
+#define can_loop					\
+	({ __label__ l_break, l_continue;		\
+	bool ret = true;				\
+	asm volatile goto("1:.byte 0xe5;		\
+		      .byte 0;				\
+		      .long (((%l[l_break] - 1b - 8) / 8) & 0xffff) << 16;	\
+		      .short 0"				\
+		      :::: l_break);			\
+	goto l_continue;				\
+	l_break: ret = false;				\
+	l_continue:;					\
+	ret;						\
+	})
+
+#define cond_break					\
+	({ __label__ l_break, l_continue;		\
+	asm volatile goto("1:.byte 0xe5;		\
+		      .byte 0;				\
+		      .long (((%l[l_break] - 1b - 8) / 8) & 0xffff) << 16;	\
+		      .short 0"				\
+		      :::: l_break);			\
+	goto l_continue;				\
+	l_break: break;					\
+	l_continue:;					\
+	})
+#endif
 #endif
 
 #ifndef bpf_nop_mov
-- 
2.43.0


