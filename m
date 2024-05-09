Return-Path: <bpf+bounces-29252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A70E68C164B
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 22:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60F3D28548B
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 20:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE79137C29;
	Thu,  9 May 2024 20:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ILO5DlI0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1BE137777
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 20:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284913; cv=none; b=qiTtuBn1Bjp8+9yI6uren831bqRaV8jaIUNq+XXtFqMQccRgmon1dLUguf5SXDjlRy04KyaBuY6jP1g5vVvdehsLn6klLiSB3jZ1ly8ESPkuKE5vVAm45NaGyIXtk+pKwQft5BtIvD3WM8FSz1NLsxHdNOiWD5+g3b+NcKlBbAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284913; c=relaxed/simple;
	bh=qbmkyF0+P08/z/Fp9ZayOXH0wErOspB3sKr8OqJ3zqA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EfpCvlEtdYhflalPFZwEggKTgG2wrIMODj02UcRf5O6HHGN3R+PLZ9gumga7hh/D0oqsdyPjk2v7QtDrz2chJ/Xb6OwddM7nWY88anttiRcmZt7fWD5UDxPHznlnO9xPY5RCAWorVMpyi9bgXHRL3mNlQU/DTbJKR0sTlenQsMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ILO5DlI0; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2acf6bce4cfso991265a91.0
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 13:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284910; x=1715889710; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7gmE/+1tJ7Ep2oqmr2taMm5VZCwXrcQv9eKCkUAc/7U=;
        b=ILO5DlI0jHo11RJEV1jUBlMw6NjsfU1gUR2zLuPOc9x4CaGpBT7LMLF6Yi4CS4xaGA
         PHLdHBbsi9u0CGsYKfKYS2DDxwvXME6WWy5KXqRXebLiOFJ6DVBz2On+fnDh+gR8KaX0
         QMhoBi+HFjI5luhHtGwhHzmnsronYEWvNnl1U0xAdQTZ4qH7kqVe5N0Hq7haPBgOnZDH
         ptQTmC00rByMG0oHAbrHcXMiwNeOEKLPHN5A8F8qcMckrzRrBm5uIksPfBnjrCPYauON
         HpkUrTRWhxOpnpdyUChzMHJLnHj1cccIbtDc8bK6s8RUuctTyBz7SaAD1phXucjvZi2f
         aLow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284910; x=1715889710;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7gmE/+1tJ7Ep2oqmr2taMm5VZCwXrcQv9eKCkUAc/7U=;
        b=HKggj7LSkGJQZ36OW673Q8kqaZq1eo57GLpmYljsR+LKgmaBj5S3lJRo0SoLz5+JPd
         uY9M3LXauVzeFL9n2QApJodrJc2tX2aeFAm9lUcoOjCMaBbcSQSVIUlcm3I1JcO3acTL
         gWr+0uWO5IGST8wd4NEDKJHQuQO23KryMgv7xg3avKJw+ChAEOdwM0AQ07DpEitmOQ9Z
         FFMK625qHBRUxHT44hIIBA75jhdJzaY28oKkz0AJITz/1kYbj5iPW2e/+odSTx8iUwSk
         Fru2F8C7sMAMd5oY482d1rBGvurXBDFuFj1cJHVZzS/AH7eXXXUlFxSgPhfrDjKlP441
         MGcw==
X-Forwarded-Encrypted: i=1; AJvYcCWbdO17OAapNrmqQEvw62a5nHwncxYoUPryKZzaHJlgvCiA6VkNL77i1iuH2eqM3ocNXJLUf0MzMg7CCKKzYeveYBI8
X-Gm-Message-State: AOJu0YwiZor9mxokDvprXSWNEQDaYsBDWxP8JaGWQsAeX9adEwzaY/Kw
	dG6WA5p4h2UYMVTsG0qrnAEINGPMDiXgJC2/k9jy5TuJYo4Iazz9RrO9ryANyagpmfB9A0jFuLG
	zuA==
X-Google-Smtp-Source: AGHT+IF3buvEsw9DOzXJjxkw3k3YqiITNaAs3ILFq1pbZpyM91Xc9NI+NKd7Vfc3Nbg4dEut1dVjyl+bk+Q=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90a:ac12:b0:2b6:4220:159d with SMTP id
 98e67ed59e1d1-2b6c748112amr23447a91.3.1715284910169; Thu, 09 May 2024
 13:01:50 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:14 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-23-edliaw@google.com>
Subject: [PATCH v3 22/68] selftests/futex: Drop duplicate -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/futex/functional/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index a392d0917b4e..f79f9bac7918 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 INCLUDES := -I../include -I../../ $(KHDR_INCLUDES)
-CFLAGS := $(CFLAGS) -g -O2 -Wall -D_GNU_SOURCE -pthread $(INCLUDES) $(KHDR_INCLUDES)
+CFLAGS := $(CFLAGS) -g -O2 -Wall -pthread $(INCLUDES) $(KHDR_INCLUDES)
 LDLIBS := -lpthread -lrt
 
 LOCAL_HDRS := \
-- 
2.45.0.118.g7fe29c98d7-goog


