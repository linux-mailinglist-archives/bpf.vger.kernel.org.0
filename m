Return-Path: <bpf+bounces-21379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AED284BFC8
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 23:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DE0F1C24200
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 22:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27601C2BC;
	Tue,  6 Feb 2024 22:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cf/DTIQD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0493F1C29B
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 22:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707257143; cv=none; b=OKJM3NOQoWHLb+SRU03KkadRwx3RAjgKBCKjD/Aghj3N5kw7H0fak86MvjQvvkwTbifWL1M2jE4t2FLPwoqve2VOZ7jnqt/y1gir9TSBifxaNeWetOYgjS7ZBshubsdhYFvKzhh8bbUean8pTeSowd+4S0/FQcDMHb+/yucq++M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707257143; c=relaxed/simple;
	bh=DpM4HzfqjDOit5k3hAkHFBsY8yXYvaZc7MIRe8CSyMA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n7N6ySFO96o9CPp0lJ3YTgr3TAkhQ74xABx4V/THDcJo+xv2AAJy3Zko+Z/Tuav5gVdd3jzsUkI35aZqK6LNsEJCFxnV8CizFyl8nI82aBtbECIbI2rtCK6uXcr5LmrBM/T8St3gT0+10H0W51pB75dUg7BNENJFWvJtu/8uFdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cf/DTIQD; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e05f6c7f50so5148b3a.3
        for <bpf@vger.kernel.org>; Tue, 06 Feb 2024 14:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707257141; x=1707861941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MsJBrUUPtruHWtQsS6zgKVxqPHg8IzuE7qrpmwhQpng=;
        b=Cf/DTIQDRmuUZOYoOHria+vEiVNJvjNMP7qKQ4Hal6KH+ltqZFKRzXcTQu85HAy1VZ
         RtUH6l8teB8w+aPWTJYbnnMmUjbk0nKogDZ2xkYASNmzZvAGaBoG8DJqxhbiJLWuHvXK
         JKltZmjflCWoQf0tHE4aUrrliG5vLJ/o1XvlLz+vyaXc8ITKLg9eat30RLZ2mjxxJs7/
         HdYVhtyXBvsrkPtAbMWGQ6/6QwDMySoJT1t6fmixqAneUhJ7FnynnY/Nu8nbA5x/RUdq
         359iLXL6ADW2CTHaqTPFIVobZCiFLjnqOrrbjSPPtPjMH/B8vcvg0Y6/Tdt/fWKY2X1h
         MIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707257141; x=1707861941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MsJBrUUPtruHWtQsS6zgKVxqPHg8IzuE7qrpmwhQpng=;
        b=SOx1bCxCKsvoBKO/56bA44IXkw1hksThAU2JXyMXXh6Aey8CI20Dt61QYJpXruqdKu
         MVX9e5J+8Cuwbv2o0hULAkYY26yOBqv02w+4nmsY8nvPxJDBBjEZ7o9RomzOSfBAD4YY
         t3j7Kyrxev7OjK13AzYeLgX537zQUp1bnkQa4uOrbfsjn8+HuaAzeVSoEXtkX62iMXhz
         piFr1dd8ny9F5yxkSl4doExQlemWYahptvLp/TSji/hh1Szrs2TCOLrI1lx8Vjs0+q8g
         SNX0RmYQv69/hOwR8TXlNrixBgV80uSBlnXDTA6HRsTwzfVI3lxolgaWY+1/eV4WFS0n
         C0RA==
X-Gm-Message-State: AOJu0YxfI+Tko4fAHSqKj9MFIjGNUKdhIE7iHlA2gb/bbLGZdK2WgzlF
	/x16fAVy/UQBflKQni15dl2yWSl0UFi/6wajfHhJYcqdaWsntTkeoahURFFL
X-Google-Smtp-Source: AGHT+IGdHBHn8MfZOBdjDr1wev3fr0slDMYt9TgRf3fpt6EWXX4IriOrk3M4U7i1fJwsabnbpdMnnw==
X-Received: by 2002:a05:6a21:1798:b0:19e:a1a1:5360 with SMTP id nx24-20020a056a21179800b0019ea1a15360mr1112802pzb.23.1707257141056;
        Tue, 06 Feb 2024 14:05:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXz5G5HRMjkZjOv6ZNWk6IaBtAGKiStm6/yVXkGspRuSxmD8HC/H4mL6JLFh1XIx4+3PUuzmNG1hY1hX1FugKNofjuX0OghF/O+bK3DIKUNmz9/KnpQdtT8//WXOCO2GXI8KGJN+EmACq9yWmsUXs7bFR9BI0sxDJuQnL9vbW+jHQa5a3qDh4DEh2y7YXrvFIQ58H5MaP8nMeLs3gE0dbpirRALVTKUDLfUP/yiW6/QSk3qNwqYmu3W8DUazqg05AWtkQyQJbdVkyiE0bsIoonUbE2V78dSYFLF
Received: from localhost.localdomain ([2620:10d:c090:400::4:27bf])
        by smtp.gmail.com with ESMTPSA id sz14-20020a17090b2d4e00b00295b93bfb24sm7888pjb.22.2024.02.06.14.05.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Feb 2024 14:05:40 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	tj@kernel.org,
	brho@google.com,
	hannes@cmpxchg.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next 14/16] bpf: Add helper macro bpf_arena_cast()
Date: Tue,  6 Feb 2024 14:04:39 -0800
Message-Id: <20240206220441.38311-15-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Introduce helper macro bpf_arena_cast() that emits:
rX = rX
instruction with off = BPF_ARENA_CAST_KERN or off = BPF_ARENA_CAST_USER
and encodes address_space into imm32.

It's useful with older LLVM that doesn't emit this insn automatically.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../testing/selftests/bpf/bpf_experimental.h  | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 0d749006d107..e73b7d48439f 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -331,6 +331,47 @@ l_true:												\
 	asm volatile("%[reg]=%[reg]"::[reg]"r"((short)var))
 #endif
 
+/* emit instruction: rX=rX .off = mode .imm32 = address_space */
+#ifndef bpf_arena_cast
+#define bpf_arena_cast(var, mode, addr_space)	\
+	({					\
+	typeof(var) __var = var;		\
+	asm volatile(".byte 0xBF;		\
+		     .ifc %[reg], r0;		\
+		     .byte 0x00;		\
+		     .endif;			\
+		     .ifc %[reg], r1;		\
+		     .byte 0x11;		\
+		     .endif;			\
+		     .ifc %[reg], r2;		\
+		     .byte 0x22;		\
+		     .endif;			\
+		     .ifc %[reg], r3;		\
+		     .byte 0x33;		\
+		     .endif;			\
+		     .ifc %[reg], r4;		\
+		     .byte 0x44;		\
+		     .endif;			\
+		     .ifc %[reg], r5;		\
+		     .byte 0x55;		\
+		     .endif;			\
+		     .ifc %[reg], r6;		\
+		     .byte 0x66;		\
+		     .endif;			\
+		     .ifc %[reg], r7;		\
+		     .byte 0x77;		\
+		     .endif;			\
+		     .ifc %[reg], r8;		\
+		     .byte 0x88;		\
+		     .endif;			\
+		     .ifc %[reg], r9;		\
+		     .byte 0x99;		\
+		     .endif;			\
+		     .short %[off]; .long %[as]"	\
+		     :: [reg]"r"(__var), [off]"i"(mode), [as]"i"(addr_space)); __var; \
+	})
+#endif
+
 /* Description
  *	Assert that a conditional expression is true.
  * Returns
-- 
2.34.1


