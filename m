Return-Path: <bpf+bounces-30239-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD2A8CB81C
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 03:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F5D01F2A3B9
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 01:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12FD39FDA;
	Wed, 22 May 2024 01:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Co+AbFUT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C9C158855
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 01:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339737; cv=none; b=f+OdWX4qr3CY8nSmMzMcPum9wxCGLc/CI/EKSphVBDqx50KUZLHrsylJUB5aIyMebrnwKbj9almjuJv41U+pk8E7YFNG+HJHibiaEo/NmPAoVPhcHdH1T3O97MtWqAEkC3HmLk2hiFtlHmrQKobAxTu0idybCbPxREQIafFZXDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339737; c=relaxed/simple;
	bh=zPNuHZmW6nYPA4b1ssPkMnA//ewKrdDtUiQgRbu9K8Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sxrLniZ4rSGd8N97sdRbpKvVy4q1xdLRpY4g2EUimukhbqQ7Kv8/97audF1hifPl41digvYRJD9HC/wD5ZjnYChvUIYnAsqOyD04ORn6xC6wLgnpWEvXlS2dAw2oCqZ0CV1953QjrxqcEXqa2Of/dnaMRkO4JKM8+k1tYZLl8u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Co+AbFUT; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61bea0c36bbso263524597b3.2
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 18:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339735; x=1716944535; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3QBjORy9CCAcoNFplhmp+lv83AAPBVpYWXZaRSdbesY=;
        b=Co+AbFUTTk92+sYWVFc6TgN7gG64uIDmTRw1xaqg5rOk8Vx4BVfuVjToCVWUyBB8cM
         nPfGDcNdaK0Ilsvba5jzM+NRdBowFKLeJ6ElhqgrGlsUknD7uvIJMTkH2m4HPw2jdLdj
         JEc5c8OQbtcdDA77sD6w3FIiQKvoRgwwyr1VFvyQk7/W4TRrYQEd2YnM8hec0Che5OBO
         86p9daPVHIPkOF4Mh5YZ4K4l/UDA/qw3vNPjK29efLX6+wy2pfBFOizFJYZZ/yEwYUZz
         4yhtw3foM0pI1QOWqe9ldfASdvPy2vQvt/+dUNW4vZHKKiu8BQr4B710+/uZcAv9knYn
         FPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339735; x=1716944535;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3QBjORy9CCAcoNFplhmp+lv83AAPBVpYWXZaRSdbesY=;
        b=K3MnRchJ5ZVBAo6py/Umxe+yjcW4K5R7votVW4utSnQ0q4nBuHFPmv0G3QeriHBPOE
         3T20SaqQ09IBn7vcrFUj4DekdBQ2sFk5zkDyl3V/YG1dS7teOJaUx8DUBk+NYLBwcgaT
         uLhxk32MSTzyWP97FKE/bLEETTORdJfCTB97Fq8X/KQczHUaPNxb4YNkNsLFw64B33ag
         mf9DVgdK0uVTnPn+eUFLu+HrB6a/zxmW8amvioTpG2Rb/zbv+VRWyaAGAFqydk6hbWDl
         Q9p79ZtsMcRNpTs8o+cvecSxr8oFAOdEtlOQ8+I9Nt59BLIb/0IDqpu5+LGePcDR5Nqp
         Ax7w==
X-Forwarded-Encrypted: i=1; AJvYcCVOe1IYABoRGm19aRWDBIClMqgQW+6RJZJyLn7GBpt3oO4EGoiPAiB1J8IDeuGuHhHsV6dtwbXuRfPecBJlqN7GxRcv
X-Gm-Message-State: AOJu0Yyh3eLdV+rKIqyHyZm641fsbyNbRIqNMUv61Njj+nnehGn7b3ea
	P1TtV6eSA5VZhZYi17HUMuoaW+RabIN19esPYVZiTwAODqeg+izJh6IobDczx4080sZkm3VgkhS
	OwQ==
X-Google-Smtp-Source: AGHT+IGZAosXDprDp/opSzocer/3U9rmGdxYzPmyOuGueK6WGHlw53mh3NJVeBX+ZfzcX387bGW84sonKH8=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a81:4849:0:b0:61b:791a:9850 with SMTP id
 00721157ae682-627e4891fcdmr1675237b3.9.1716339735130; Tue, 21 May 2024
 18:02:15 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:42 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-57-edliaw@google.com>
Subject: [PATCH v5 56/68] selftests/sigaltstack: Drop define _GNU_SOURCE
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
 tools/testing/selftests/sigaltstack/sas.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/sigaltstack/sas.c b/tools/testing/selftests/sigaltstack/sas.c
index 07227fab1cc9..36b510de0195 100644
--- a/tools/testing/selftests/sigaltstack/sas.c
+++ b/tools/testing/selftests/sigaltstack/sas.c
@@ -6,8 +6,6 @@
  * If that succeeds, then swapcontext() can be used inside sighandler safely.
  *
  */
-
-#define _GNU_SOURCE
 #include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
-- 
2.45.1.288.g0e0cd299f1-goog


