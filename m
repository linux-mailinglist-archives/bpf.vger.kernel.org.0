Return-Path: <bpf+bounces-60425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A047AD6516
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 03:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A5173A7FD0
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 01:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAD072613;
	Thu, 12 Jun 2025 01:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oht3aTsE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A263A20328
	for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 01:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749691158; cv=none; b=qYKhluH4C1PyfABNjiBqP7/L4vwYhyt5nlwDGjE3TArLjh34tPZtOukw1oQh5PEE02mOHKPdyXHWt3h/KqycGTZ7xfbfP8XsmJ6BqitMUqJHttW25dDMMrWpXend36QpO5bALcr44UHWOlECMrL0beX0vDXUWTaZxOqQpucrsak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749691158; c=relaxed/simple;
	bh=brEVAXm6LS10egOhiDKSgLl5YHN0iPvhRk6Gt5D+IS0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iPfn2sxZ6JBswXfYk157PwmFh5irKqRj85igtcz6TiZI6poaNrrMgtmDInVzIpOAmB8ACGUBLUtVLz65y7i1Cous5uj2uFgvjNgATUWt/3gKr0yWpbh9NcASBOOV56IQfs99ycHE63jLqdDci/+C0CYkqn+gsJUUlmDXF95p390=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oht3aTsE; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-234b9dfb842so4757735ad.1
        for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 18:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749691156; x=1750295956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f4Yb4jOFV5ANiWnZ8jGh8e0X8foAY/v/u4htrI/rjTg=;
        b=Oht3aTsEx5KjBxydb8sMZhNA2duNj9MbZRSLqDsipdZzRgLOBeZt3z5hAWtdTsqjzd
         OpX8zn/c5a3Jcuc/vkT2VhM0b1HehHP99yPFurjFiqWkh5K3kqHklj9lS37o7oYaliHp
         XmzBQT+Ibjv5VQPtYP+7hwbGLEsyFaAqNwoTR9qwECmKKkzAur1HuXgqRgnfHxXpnkN4
         fZFZnNbkIrD70eullutg2uHntuJ4UbwgT4PAsyPdFgevsAwTPRU9w5iVhrbvTaRzHh/k
         GQVe1ENfOvb/Mgg4d4lVDkgaUlUe4PLliBvpD9iFliPsQrlbY07Z4dbFfPMor99pvpJg
         01+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749691156; x=1750295956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f4Yb4jOFV5ANiWnZ8jGh8e0X8foAY/v/u4htrI/rjTg=;
        b=FpS/2t9lSBou9B1D87unuc7AY/9i+1cDb1lDa7V/WxJNez8dMcrNMhIgTLeoPFutql
         tCLq5xooF8WJINv7NeuQ8FZ6TsL8Ee3aaj90fawwmFHdZDY67uUQbZN0ef+e1O4JpbHe
         +4EcNS70CJQTKJpxkHB7T796rJTSU1H7vAvZX5l5Wi0wu0EZAy4wYtPXAFmsATM7XA0x
         wmDqY8O2obyBvoYMTW9OatngunEirN7JBgfFsxM6mAAOIYU/ol40NT0+tewP720550m5
         eTRSt9JqTUuyN7RTGp+BOi+02skrhUVGwdId3TC6aDEL1T4i4VaRb9f8btTyVft2x+jJ
         U9nA==
X-Gm-Message-State: AOJu0YwzgxeNuwxZNOIwiRuT3xUKObjezq4dsF3aNEEQvufan1H4enms
	pe8VO1whKzIjYVdEIvxMROxHcYhoWiP/xIPSwI0CG4s09NV7aasIA1wvcIi+jA==
X-Gm-Gg: ASbGnctCjdKsskh7jmj9PIg5nZrX2Xxx2FkFNpy2a9XY+UgY1iSf4sqR2qQqIIG4JGg
	zyHV46/nGsxjR35f7itkmCysWhf5WRFrh5Zb7VJxo5rSCeEz1yk0otDOUlg4FTQlwpqJuC+T9gM
	ZHyCvn65T0OG2d4vrHBUO5xXCMqT35vZzwqpam3uXvqq9J7EmX6uqU21N/3OK14+Q/rHcA6loxX
	Ik/n7NH5KgnaXAIayfoJ0UnqpBxeqm6FlFsKHn/6VsQEejDtk9yvWQ6Y7xYmPpl88f29foOtID3
	8nNQ+yg8OcK5rxt6I91lajIxzu3Awi3vN3+4P6AuthgwY4L1BAaVJvsYMefKslWIRFGCw35x9wa
	x5BTpt7UmAHoydrngqi3num1WELQ=
X-Google-Smtp-Source: AGHT+IENjlXT7cY8PLm8AMBrhyfVvO0vBRL2bMeBdCHfvXcMsgMOlrmYZnAaPiXWdDOmsAHdRaDbLQ==
X-Received: by 2002:a17:903:288:b0:234:f182:a735 with SMTP id d9443c01a7336-2364d8c01f0mr17748025ad.34.1749691155864;
        Wed, 11 Jun 2025 18:19:15 -0700 (PDT)
Received: from localhost.localdomain ([2001:558:600a:7:a83d:600f:32cc:235a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e6db039sm2173365ad.121.2025.06.11.18.19.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Jun 2025 18:19:15 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org
Subject: [GIT PULL] BPF fixes for 6.16-rc2
Date: Wed, 11 Jun 2025 18:19:13 -0700
Message-Id: <20250612011913.48375-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 7a912d04415b372324e5a8dfad3360d993d0c23a:

  Merge tag 'spi-v6.16-merge-window' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi (2025-06-06 13:22:31 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

for you to fetch changes up to 9cf1e25053c269d64b9e9fa25e8697d6d58028d4:

  MAINTAINERS: Add myself as bpf networking reviewer (2025-06-10 12:48:24 -0700)

----------------------------------------------------------------
- Fix libbpf backward compatibility (Andrii Nakryiko)

- Add Stanislav Fomichev as bpf/net reviewer

- Fix resolve_btfid build when cross compiling (Suleiman Souhlal)

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Andrii Nakryiko (1):
      libbpf: Handle unsupported mmap-based /sys/kernel/btf/vmlinux correctly

Stanislav Fomichev (1):
      MAINTAINERS: Add myself as bpf networking reviewer

Suleiman Souhlal (1):
      tools/resolve_btfids: Fix build when cross compiling kernel with clang.

 .mailmap                          | 1 +
 MAINTAINERS                       | 3 +++
 tools/bpf/resolve_btfids/Makefile | 2 +-
 tools/lib/bpf/btf.c               | 6 +++---
 4 files changed, 8 insertions(+), 4 deletions(-)

