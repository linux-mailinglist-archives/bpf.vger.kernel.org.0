Return-Path: <bpf+bounces-30233-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5EF8CB7FC
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 03:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B27DB2526C
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 01:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B613415534A;
	Wed, 22 May 2024 01:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PrdTMX1o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CE81553A2
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 01:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339721; cv=none; b=oI6K1OxGW8W5YLojadxyqjWNtK2jvMyOtxuREja1nhcxZM//9tVmJEtqVPUnRgUYNqid/IjsowPU3QCYcakM2C5bacZ48HU38RHBOGS7UAcYpRCXCzmPwJ0cxN5va9WF/R7mtY3ipei+swjopTTuuq54RbMyj+N+FrBQhQkU92Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339721; c=relaxed/simple;
	bh=PVD0tBSM8eTq+XpI9YU4VnLpg0PN05oNGpDwrUAueuI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=onC5astbsMUGX/8cl8ohseAkAi2AM7qHWGY8OKLk0MMtY0VEA4WLj+IhafCHQ1TsC9Z54F9vRVwEsqNcb1yY8D1DNOXOadbcyLnYSy4AaXaKhWHPBoYA6+4wbcxBTLUS9r5nJ6KtB4KPD8iFnvwx3V/8K8+Z6fj1jA+rXQb3HrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PrdTMX1o; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-61cb5628620so13301815a12.3
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 18:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339719; x=1716944519; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hV5vKaIDliigP0PvfdQCKt36xDKqbqkdCLWM1sPsWPk=;
        b=PrdTMX1oXcTlAbDriYl7lDL2/S7aaUXpsAE7vtEcFzNkzn/MjkVWk/g/1iiMJ1d40g
         pOsR4ApQ90rPEehpr7VXgFDcr0Lo/cXVPFdBTTW7AsBRp04Z3dG3dbmJEob0rONwPa7O
         fyzXVAFU+18XI917IFYqB5wvbFj30gk5QQaf+kG9L+y2ufy7jLjyA9itkvzqZjt8Rp60
         Mh4vbwRvZ4Wk+z90ITWtHyI2DU2p2ljx4ymcJ/RDBFqxXUUIZpysZ9ga4MdsRBQ1DVLJ
         JH5v9VQpA/nYGMK2njZxHck/s5t74mzOoZWd71f3U4H0FIttHVm1hC6EmsUsTVm8vYr1
         Zz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339719; x=1716944519;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hV5vKaIDliigP0PvfdQCKt36xDKqbqkdCLWM1sPsWPk=;
        b=Gwq1OivYyFkQznT2EYSfg+h2m9+S8g53zOVGvI5xwcr5T/dimgdZuDPxM29kYbJK5T
         yX0XBRmZ7vTi3Fl5WpKYJrfXBzYvADJ8X7ZhX7LtkgscKZmgY/HX6I+G8VBU6NEr3GTt
         b8c3zrMUiGUOtdyLCoIwuRecP0mysB+fyXjzoxD62vjHgUsHQoN5N6FEpMNdw6hgpHst
         3XS6PKsuxwXHZYAQgexp3lNgCLDm8iCc/AllTU40wxSVm8snu8fZvaV3lrRP0HEerlrQ
         jmYeMKjw2EjFU+T0PJ6l5AeJy4K0zyQ4M+eAu8nKFnkljoOnNYX8F098hv6bFwn8eeVz
         5CSA==
X-Forwarded-Encrypted: i=1; AJvYcCW8v2IU5318SJiyiQfSMdBLfu79RyeKk+zX2lYkfPBTrc8mMQ9YnQUqcjVCXEY3ksHvlJ6gEewJnvPDPejd3H8I98QB
X-Gm-Message-State: AOJu0YzjnNTbzEdX0VvJo3/5LjeabBn39douU3G/R3mI8/9LmYHuep4P
	x0XgxWzqYlAr4PbqAld9P9Go9Qf+cD0g4jGib4pqoR2bqQ9pVxx5F4Z+Krhxs6oq7OG4jvdd1R5
	H/w==
X-Google-Smtp-Source: AGHT+IHJf7XnW8l3uCaIbtKOYrd79j1um0RYB3UjOWToEbOM9Pm94KWZLjHWmnPYbuyo6Pe/x0NBJ7rbzlA=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a02:90e:b0:650:17f0:94e3 with SMTP id
 41be03b00d2f7-676492dc647mr1174a12.5.1716339719405; Tue, 21 May 2024 18:01:59
 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:36 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-51-edliaw@google.com>
Subject: [PATCH v5 50/68] selftests/riscv: Drop duplicate -D_GNU_SOURCE
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

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/riscv/mm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/riscv/mm/Makefile b/tools/testing/selftests/riscv/mm/Makefile
index c333263f2b27..4664ed79e20b 100644
--- a/tools/testing/selftests/riscv/mm/Makefile
+++ b/tools/testing/selftests/riscv/mm/Makefile
@@ -3,7 +3,7 @@
 # Originally tools/testing/arm64/abi/Makefile
 
 # Additional include paths needed by kselftest.h and local headers
-CFLAGS += -D_GNU_SOURCE -std=gnu99 -I.
+CFLAGS += -std=gnu99 -I.
 
 TEST_GEN_FILES := mmap_default mmap_bottomup
 
-- 
2.45.1.288.g0e0cd299f1-goog


