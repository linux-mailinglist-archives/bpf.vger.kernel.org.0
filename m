Return-Path: <bpf+bounces-30247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3548CB846
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 03:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0CAEB25D38
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 01:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EC815B99E;
	Wed, 22 May 2024 01:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ttx4SwfG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3E515B96C
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 01:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339758; cv=none; b=gmkANII5k7IjMC1/Y1uLmjX2B8QrF2j8ci2R+kMLj73a3clWmZt6k/IOreOIPfJvoHpkwc7G/TL58XhQmtt4Ia5yc5maSHZpTtoIlSdbeLsqrIiC1v64BYVbEFw3ff8MWdHlPk55g9ZOV0+zZOiV5QZp3wXMT4oJoMFC0wvfIF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339758; c=relaxed/simple;
	bh=XjLDp8cUGRvX84+Q9aIS9dPGIChvC28mo14HZv80yTQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dwKTYrfBnbiCXwt1odXRMRTbnXjdZsrylYoYHndQEaW7NdCzyAf1/Xb0h4shkxe1dY4+Eb9wo9K84eGgYAvaUi3ePyxqZ5tHuEsKHWTayGGO8qsHeIuZYa15UOwUe4w7E8Z6JdezQSrpxXK9goiNschQTt5ipPMRfrVvyj1l8xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ttx4SwfG; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1ee4e9a73a8so138165625ad.2
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 18:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339755; x=1716944555; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=THfAbUsdCLmnmf31zE9Pe2u6BNmh9uFbN2fzLklxkz4=;
        b=Ttx4SwfGpYtRUciUtJ77Ge/oZUkOiEnh0nbzrjoCNQSWj28wTIZoGlDtdGA1+VMaH4
         szwEgTUpamUcS5qv6trSk/8AKtL/IelA0T/jV1n55zbyPjPpYM3miMQD8ZtNCdAD3CVf
         vHjlHT6K6ansLXHepO5KnVTzc7VfPcYa+n8fUDU1xWkioLpHqY23te8IHGUlPgrIK0MY
         ki8WonnyoeqEW606KnvyE+mv1dcgWUqSxwtFGC+cj5dMurlLEn2V8Rpunxm6COR02XRJ
         OJWB1wvRciGCbFMvncc343C1V9jUasf3nheprsJiG7u0MCzVODyDbawYYiFbihTzp+i6
         Jh1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339755; x=1716944555;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=THfAbUsdCLmnmf31zE9Pe2u6BNmh9uFbN2fzLklxkz4=;
        b=Ug2lD7EeHnsrJpgOYGtsLbQvRzkqcr6lybX7+M1a34dL1rqbR3A9Fd19CrovGAPHGj
         P5rpXGa7UMKpzCxuree4vmpOLiCDEA+ge3RSm3wAjVvf/gDXltK2NyGS97erIuuaRC3J
         2kHl3MRu3y9t8isDlNcHiwL86/5Y0C18Pj+fbk8EXjEegwP6iaOPgJb9iKbLavMhmpOv
         czWxxz3oiOH27BPGs38JXMPOJg7ETzMvgJ9izdIhuXu+qqDLZTxq4Kz2Pq5PjYWvJVg9
         5tpf3a8tDvNDlycGJ4CX5VaKABNcqDGXN64e1SzeZ9IUflFbM8e/qtjsCQHmiGy59IMH
         XBFg==
X-Forwarded-Encrypted: i=1; AJvYcCXN7u6UKQpU7M+k5HQ0cQFdqZ4gas1rBjfFVpCALFV4OhYb3k54SsZzMZOrlmSI7YZmWKnGN9DDiYeOxkpDPkSuofME
X-Gm-Message-State: AOJu0YwypFZUdTObkGNHjpSRHFoQjVBC5BTv4Aczkzbaenvl3ujYY/IB
	NwA6Af9CLUOv5km/MEZJADD82G1F8gAghwX8HcVZEZy8Pp2H3rF6SpCGQJb1uMVuANw9RINzkYF
	GzA==
X-Google-Smtp-Source: AGHT+IF2I2FWOecHFUCcN7nKq/bwhFKSfcaBbhOfbRL9O8f91+0Uq1k+MIvBsT42EkpQs0UJXpRvR7cMkog=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:f7cd:b0:1eb:829:b6e3 with SMTP id
 d9443c01a7336-1f31c9672a0mr175035ad.4.1716339755383; Tue, 21 May 2024
 18:02:35 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:50 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-65-edliaw@google.com>
Subject: [PATCH v5 64/68] selftests/user_events: Drop define _GNU_SOURCE
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
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/user_events/abi_test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/user_events/abi_test.c b/tools/testing/selftests/user_events/abi_test.c
index 7288a05136ba..a1f156dbbd56 100644
--- a/tools/testing/selftests/user_events/abi_test.c
+++ b/tools/testing/selftests/user_events/abi_test.c
@@ -4,8 +4,6 @@
  *
  * Copyright (c) 2022 Beau Belgrave <beaub@linux.microsoft.com>
  */
-
-#define _GNU_SOURCE
 #include <sched.h>
 
 #include <errno.h>
-- 
2.45.1.288.g0e0cd299f1-goog


