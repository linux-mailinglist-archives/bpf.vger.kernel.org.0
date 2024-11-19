Return-Path: <bpf+bounces-45163-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8035A9D2328
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 11:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E3CB1F21788
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 10:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3F71C2DC8;
	Tue, 19 Nov 2024 10:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="XggMmK6n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8731C2DB4
	for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 10:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732011201; cv=none; b=qbJzfgZHg2wT/y7j1KWQDjue9xDJtWqajtuR+JY2c69Np5vQzSDyDoOjc7JHdDygEeTUBZQJo8wKhVH9pxcxMZzhcdjiBCAmY8sQ09KUqFCZdZnbIYFgR5BzqteF3Ipy/OBcUedh4ljXZL+Kf6/gwYPVsvw5HRuk5FZdA7lBhg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732011201; c=relaxed/simple;
	bh=5M+9sZ2uOISCSb6KW/FXzpjBYHwIs149KFBIoWPdbV4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nqh7g2eAbY2LMrWnXKsOGpiIxiSvfmVkDYePaR88+Rj+1FK1fLvbTXKqhFQWB7f4Yf5XUNKxSCA1uQWtyzWAvH4QGrJzOcdBtIR5Sr0qQSQATSVbnRsrVUZ7uP4LyTQ5lmffu0EQKyUI4fEKc8zkbNkvmPFQnJ1dgv0Dc0HfIjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=XggMmK6n; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb5fa911aaso41524101fa.2
        for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 02:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1732011197; x=1732615997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=95uLp76JDqCGAntKfWwQIWRGb8VQc95vaaCgVutyp08=;
        b=XggMmK6nnotAihdXwE23OFGRs/6p7Djhfa6jDXSo8begomuup39mxR5kIiuFJckPxv
         YD7HWWDalWoXHUJy4H52zMVL42bMU0WeFYdlLbbQZ66B0yTJt9lEQRi84iklLiWnStbJ
         YabMFIJkiAh7+u/nqGOrRfZgm3tIaKd5FhzMXH/Y4Rknf4EeRgL0piV5dF863+3OcxBk
         YqlZdYbuFTsTl/MAwLWfsWJ+dm0qQT1YGb+YtkfQgBGiZn9AHtnxBGfr76Hitx95vT13
         DLDnMRvSXzJrL+ZRDzWxysQiC8ueM1a8I7b7Ah2J2+xCHgev81ZYjnIbvQd6X/q2u9kd
         Soiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732011197; x=1732615997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=95uLp76JDqCGAntKfWwQIWRGb8VQc95vaaCgVutyp08=;
        b=BLjBY9PAMQAMZvwKO6GCSRmflr+NPicn3+JNWb0Y7uCqaJXYWo+r+4ej785/ywW2KJ
         fposTsWJmV4ZTNtQDy/O+o34KBoJNwM+/czNd5lQK63GEeNJO/BGPqraCdEfqTQO1fJC
         sSd7MUlubePakBJVncHkDJrVUm9Tfd+mzL9kaYoct7DF4AJHKo/C3fYiDVIAphu58htv
         zYw7d3TgVbeQjB8DLRZmEjYOehShAS/Jiu9O2CGQfQ4pXvRqBUbhK+2bn/ntrvwTR3g6
         ASQQ26t/SAuAbtYiLv3dPQsRek7fU51Yh+EryqkmtgpowqQVYxUpTcf3MRsbXB5/n+sC
         +Etg==
X-Gm-Message-State: AOJu0YzIIOmbMIuJIZ3GnctnN8Lui5OiLibFdBl54E/3x08UjEBX30hB
	P0/N8iW7apAQ3BHOSheK2Xndy7vhpFZkiXzNL9j1L/ssn6uVHd33lR2WA2tq5A26jPSeOGRtTPL
	b
X-Google-Smtp-Source: AGHT+IEcv7FD1KJhVSOoA2npLdTtfQkh/oHfzo0MtgjvXRaXBhWb7TRMalIGetTdQnkzsGhH9IkCEQ==
X-Received: by 2002:a05:651c:158d:b0:2f7:5a41:b0b with SMTP id 38308e7fff4ca-2ff606db221mr103930511fa.26.1732011196669;
        Tue, 19 Nov 2024 02:13:16 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df7eee4sm629003066b.87.2024.11.19.02.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 02:13:15 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH v2 bpf-next 6/6] selftest/bpf: replace magic constants by macros
Date: Tue, 19 Nov 2024 10:15:52 +0000
Message-Id: <20241119101552.505650-7-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119101552.505650-1-aspsk@isovalent.com>
References: <20241119101552.505650-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace magic constants in a BTF structure initialization code by
proper macros, as is done in other similar selftests.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/syscall.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/syscall.c b/tools/testing/selftests/bpf/progs/syscall.c
index 0f4dfb770c32..b698cc62a371 100644
--- a/tools/testing/selftests/bpf/progs/syscall.c
+++ b/tools/testing/selftests/bpf/progs/syscall.c
@@ -76,9 +76,9 @@ static int btf_load(void)
 			.magic = BTF_MAGIC,
 			.version = BTF_VERSION,
 			.hdr_len = sizeof(struct btf_header),
-			.type_len = sizeof(__u32) * 8,
-			.str_off = sizeof(__u32) * 8,
-			.str_len = sizeof(__u32),
+			.type_len = sizeof(raw_btf.types),
+			.str_off = offsetof(struct btf_blob, str) - offsetof(struct btf_blob, types),
+			.str_len = sizeof(raw_btf.str),
 		},
 		.types = {
 			/* long */
-- 
2.34.1


