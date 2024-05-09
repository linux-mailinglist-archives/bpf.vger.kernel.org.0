Return-Path: <bpf+bounces-29245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9138C1626
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 22:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 071E4B207F0
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 20:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B66134738;
	Thu,  9 May 2024 20:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1grMg40n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6947A134410
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 20:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284892; cv=none; b=UCNwqat1bxpTrYUzRkfkXoLQ/Z6/kYt8eojEa6i9ziGBwQEG/WW4HTFc8LIcfZ9pOcOOWpesnCzZ2gZKfMffsqvXDoNlFulAEwpmqQUsN9yv9gC5Ex49UJ4NHrJ1EWTPrSB/95WDFM5VLNkwFkMZ8TePD/zs+J4h6By1IqlQQwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284892; c=relaxed/simple;
	bh=tTj3M6fIal5DHH8k+Tew/M8u7hiv4dqwU6VGCuE8kiQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JhewKwfCglXKU+HUmE/bfLmAUnmo/RdOrCZro3syAzKx0WLVSsBeoX1j1kqwBEsTNzfqTN38/7XYhNIK8McKM4a8Rjjy5fr0CGK4FI5X37NqLWcL2Ud6Ruz2NAUHiGhvunNWu/ZWEZk0MYqLzWgAXQcM3Mz5Jq51LqM4u1fqSng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1grMg40n; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1ec5efb0a33so12234095ad.3
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 13:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284891; x=1715889691; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SARWn1297sTaPTixNcZ2P/NfR3z6dYPtI+wY0CAAJVY=;
        b=1grMg40nSGXiqE+I6S9kiCAhvYqAMfdhjtlFh9ujPrB66YhywAywE20mBO2gQYUIEA
         TBuJwFMk7tmy9o14MxBJK4LaAe4yFTSbr0Us9UavbtfnNtT1XDPXcbfVK2ONsMzFENWE
         rHOnf44B9sy2U1+7oL8rZwQGJlDIFtCAt7bZtS6t+qr2VI4ECSEDiM7MsvgrnsHw6xKt
         wQdVQkyNbu4HfnRsKL0to9G2E1ggVyQos0omOd/GYOZwNLoiL6O9uFbhe3O7ZOFyYcUb
         W3P/Tq92iPKWvDunZFpamvlqcy8u956fK3tlvj1BcFjwxppIA5wnx538kP9i0tRLYbI5
         IWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284891; x=1715889691;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SARWn1297sTaPTixNcZ2P/NfR3z6dYPtI+wY0CAAJVY=;
        b=wGkOb6hXRDxilU1eGCiIM1O1nxyFl6EpNw2JidmVHnHDKSjv8kp5jmBXQdyKl8tI5D
         QrndkquGLgAkkvqGSKuppJR2KG0mwpVGnxwO597C4lGckZdbVvpQM3ZuMMhCRmldYgRV
         8S+H1tx8mHG/aVoDylR6aF7rNAZaX9f7Fxdqecenhz46FwpCaW1ouBeYAGSDTsRpgS4X
         wYY6hXbhyNya6pqS6s0OnV6vSkauStw2NQ7r3xYmmSNXQn7ETSV71Dto3jxtk1aDqEIy
         ykf0iM4Q8BXKu1o0TrDuYgXlZ87gj9ieHPVVZqcrE8Ue7PWLiBmi0TRkOxRbjfgdXckc
         LOow==
X-Forwarded-Encrypted: i=1; AJvYcCXk5Zmb8qw7G1dd43wP3RYAO7oRi/FKkLgzoOKpJaNGbxzqYfnrP5RPn5srgJUzc10EyQTXzD6RdFLR6JlCbhRSzIyb
X-Gm-Message-State: AOJu0YySV7GffQVXlioO9/D+cdNxFJuDa0Qb3dqpnXzHxEChSLYAxAny
	GlAdvFv8D2/YdNqkNms1i0IYLftygBw3OA5plzxCeMy0GAELCLX6Y5gQwi/1iZpy9jINbWMhfYq
	lMQ==
X-Google-Smtp-Source: AGHT+IGdQihvGYGHF6PdjZpZUUK6gc/kNAnaTsu4e7xw8HeMCFzPLsdZMDhNcn3aU3W22mZMcXJG1JBkESE=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:903:110d:b0:1e5:62:7ab5 with SMTP id
 d9443c01a7336-1ef433d9bc7mr28285ad.0.1715284890584; Thu, 09 May 2024 13:01:30
 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:07 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-16-edliaw@google.com>
Subject: [PATCH v3 15/68] selftests/exec: Drop duplicate -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/exec/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index 3c79ec9bf780..18d7a1e5a416 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS = -Wall
 CFLAGS += -Wno-nonnull
-CFLAGS += -D_GNU_SOURCE
 
 TEST_PROGS := binfmt_script.py
 TEST_GEN_PROGS := execveat load_address_4096 load_address_2097152 load_address_16777216 non-regular
-- 
2.45.0.118.g7fe29c98d7-goog


