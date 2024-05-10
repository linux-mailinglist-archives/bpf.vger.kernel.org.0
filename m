Return-Path: <bpf+bounces-29392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 320F08C1B54
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 02:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF94D289F18
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 00:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4327113D2A2;
	Fri, 10 May 2024 00:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cEW7pCqF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46B613D24E
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 00:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299895; cv=none; b=NSEkepCuPqgfcj1i5L0P8lUixdLM/CZqd3pOwz+rk6JaTrbEcVoYWdQjvvPbr+GbCY5+4D77NFDyqSbEKlIhmSSATDuQFh3IEk2D2EN9QUs6CySoDGHyvBE5oiWt4PjVeU6tqxx5dz1el+XVRF9bfnbrpR+bw6SI77tZeYZBPBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299895; c=relaxed/simple;
	bh=UhdxB0VCuAo+FfSdpwQFoDNnyUeVez9iXJJZWBhO1qk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qui6mOKKVhjIrFhp1S/PgZIepy1zpAwlpDfokFuffD5koiTyWYSdiQDMLtYsWID+5fzpUPE9vAGiahlDXpHm5/XFckzqU92bJqPazR6GVQwce62woaEzj5aAag+R5F8d7v7eTDcfaiQHhYJD3Yp+aYPsJ2IN+9WDeS7CqCioqSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cEW7pCqF; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6f44dcb8eb0so933936b3a.1
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 17:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299893; x=1715904693; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9uDFF+JWYl//M2d4lSrsSDaCKGHAotkO1fbl9/EIGoc=;
        b=cEW7pCqFHwN1YvTeUAqvC/0tFEblWEm2k7GX9n6dqpEvTevvprOuHRPFJfacuzWifx
         FPOIb2ex8S/iZinQB6RbOlpb5S5RN6xRmEyNWhmRLRX89T1X6wCI5l3tTEledh85cmYr
         EKyCuWZoTbfwDziUmeFIWF8u/+5O5iVsT74jAlGDImor9nxCh8OY+49UWfER7HSB5jP2
         r0c0MnMBe0h+/IR6ialnMC7e1ffkwqdPYnQr5IST87Lv9BdZsWjosWty/MwkPYCVP/ID
         Y+LJ4Z9jvLOGALVECfEmQ+sdf20+16nEZk0K+LJvqaa6uHSeGDGTgO1YPxbMfYKF6iZg
         09XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299893; x=1715904693;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9uDFF+JWYl//M2d4lSrsSDaCKGHAotkO1fbl9/EIGoc=;
        b=DEqzVnuXJK3ENSb0yS2i2xUMuMkm6Y5cWxkKUkcwaPzB2C2W8y0kTUg6aIzqZO/x5c
         uazr20DipDPeY9bQMBmh7ZQSaqKKR7vK3RmvGPuzPK7dRlogaYV2iKzeWAaa+ggr4bpH
         bSXCbFlkLSaCR9SqyA8Bc8jJckdQUN+/WUhb7I69sEo8XGGwECXlBhvYyhfWsgSXSpgl
         VpaAA1M4r0iQ07640o6pVdwvT9HLkCCVOBGIGEdJgy0gw3ggY666z++kgzfuzHgbw7X9
         p+OM26oo9hMFEzjJi1bZHLrntHTGCoFTHEOdE5SiJvBHdXll8/KT4cQ4q8GRDL3A4QC6
         RlTg==
X-Forwarded-Encrypted: i=1; AJvYcCWbtewawtvZmeAr58yiIfniVphz89aY7Ty0O2Zu3ulI69/RIzO6wuJG39qZjmF2S55CBv5NIqGvUGatEJp+FGCVK4ZJ
X-Gm-Message-State: AOJu0YwScRI4p8zbjcCuiUT3qQiD2g5tzBdWI0PFopamPrxJ6Czsl9tx
	cyXkN2RXNmyPkNE7ngCnLvzLZyVnL/O97UsqCWFaSEIpCBuwkuinGV53U6RUyeJBrjAbL/Z2sZf
	EPg==
X-Google-Smtp-Source: AGHT+IEdJ42TdgwwL6jMZitLCucOiECkZvqcMbyvNAdvNm+hAFnab+iaBg+Mn7Odij0H4KRyDB3AI1IKDGc=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:3912:b0:6e7:956e:4388 with SMTP id
 d2e1a72fcca58-6f4e015ee8dmr16017b3a.0.1715299893193; Thu, 09 May 2024
 17:11:33 -0700 (PDT)
Date: Fri, 10 May 2024 00:07:08 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-52-edliaw@google.com>
Subject: [PATCH v4 51/66] selftests/rlimits: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/rlimits/rlimits-per-userns.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/rlimits/rlimits-per-userns.c b/tools/testing/selftests/rlimits/rlimits-per-userns.c
index 26dc949e93ea..e0b4f2af9cee 100644
--- a/tools/testing/selftests/rlimits/rlimits-per-userns.c
+++ b/tools/testing/selftests/rlimits/rlimits-per-userns.c
@@ -2,7 +2,6 @@
 /*
  * Author: Alexey Gladkov <gladkov.alexey@gmail.com>
  */
-#define _GNU_SOURCE
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <sys/time.h>
-- 
2.45.0.118.g7fe29c98d7-goog


