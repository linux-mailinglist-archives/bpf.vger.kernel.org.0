Return-Path: <bpf+bounces-29399-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C118C1B75
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 02:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C5AA284BD6
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 00:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7729A13E403;
	Fri, 10 May 2024 00:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WntSC0/A"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A914913E05E
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 00:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299913; cv=none; b=dLlRrrZKwYiAHCkrCSdhMwFheHWrozzSAAeLN5eyeEaSO3mLwzBTH1WVELENON20ZH2Cq4f0ZULqjnejYVfXZ4pyAHKP2YwMCH47/KukttQ/Wj2YyAm8BF1v5YnI4LWlqDR5tUNEUweOIkcSp4k00ajrtH/nJ8x1q9wqr86h7Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299913; c=relaxed/simple;
	bh=wdMuWYdMwrgMerE8WeS63hJz18n5JDaZO1VLefXTz14=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LhqSg0G9/wF7J710ym/A59t4+ZLhKOSoH806P24MyknaHIXFFGiB0n39z4JbOAr1NCyJ9jG/Q698dsK16b+bk68vLjJB/gJvOlthibVZhNMifn6MiwLoNMQhW2sHueY49lk5wpMQCheghN8nBPdl+wweIDfRihIf3fMIDODWsT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WntSC0/A; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6f472477050so1079782b3a.1
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 17:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299911; x=1715904711; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lfjY9RujMMfudpJuG3AQZBDh8vReKDVIi2txg8s68yI=;
        b=WntSC0/AJawdU1hccYk/aSmL9ab4AHfclF+40PNoJ4ylJqg+FxEJX5R4F/EZzO5WR4
         jXhqyIQ6FrpmQkHhiMeMsOKRPetkLPnnZb4S79PqSYFOM37lV93GT2kFTNeE6exCsOhf
         iFB3F3ZTB6bngDKby6PLhK9OP3y+gS+ZlEiAE61wWI4YfmNZIHmhaBUFaVHswaUVsu2x
         gNH0qr56GRkVicMbuIvHRTbWPLO5aVbvYjZwBfAAdRwrEC5H9nzSxvoKh5GL8JN9qX5A
         bnVFqHWBwUS/SaP+00dtLZ614BEC830hXLLrEOJdVdVZDWl1E5cOA1ovVHoJ+KiX6bkN
         p8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299911; x=1715904711;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lfjY9RujMMfudpJuG3AQZBDh8vReKDVIi2txg8s68yI=;
        b=WJdRjjHLa2ckcIxzKg4QwZUXz1Y52Adw94ToiZ+sYRyaNQ5/2Pl0zJ7JsG8d5kdCH2
         RiKod7CAjIHIotW+PplVxulw7UG/nJEWeD8fiaGn5L9tgA/Rkt7sEqpj5KrcZX8ts9ZV
         m4gUF9MeBYV5yyg9YeVxCRcbu9wdco9mfXZOSWVExPHLyNfgAzVfYggs3YaJlUe5clWI
         u9dP1+S1ZpbxoeDK/v2mZ6eBOF1PnM4WJZJG3zZDj5rVFRAkChEvKDYUYM4QPcVC1Bbg
         52yJmQYRPtWfum75RvC/sf+6axW7s/0adM849sJmW31u7js8vGw1Zqz8lcJTrd6jQDcL
         eUZg==
X-Forwarded-Encrypted: i=1; AJvYcCVZK3CONplbTct9NYiXU3ZaiBfDI8Hq9BBaQ+bAA6EgJHam3DP28PlJCJqr8d4hGZ+CBCQc1EMPVoE8k2h1MAfmFO3c
X-Gm-Message-State: AOJu0YwSK1K972R7Jj8b6aNKzSwYs34H7/HL9V/PuHH2L/K38I23XdxD
	MjxTqYR9krTBdzDlTqSewVMbP/iymFOG4ND6my5qyPA4tTISH0BU9oYFF0ORYpkZgT59CxNtVoY
	r0A==
X-Google-Smtp-Source: AGHT+IGMEDSh6n8JDhyUnrx8edlpa1/0ciKq5L6J3NGl7hDudyZ1Z9szb8Ek4WrJWFhP303EsBUN1+aLv5o=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:2da8:b0:6f3:ea4b:d232 with SMTP id
 d2e1a72fcca58-6f4e01b953cmr21227b3a.0.1715299910911; Thu, 09 May 2024
 17:11:50 -0700 (PDT)
Date: Fri, 10 May 2024 00:07:15 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-59-edliaw@google.com>
Subject: [PATCH v4 58/66] selftests/syscall_user_dispatch: Drop define _GNU_SOURCE
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
 tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c | 2 --
 tools/testing/selftests/syscall_user_dispatch/sud_test.c      | 2 --
 2 files changed, 4 deletions(-)

diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c b/tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c
index 073a03702ff5..758fa910e510 100644
--- a/tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c
+++ b/tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c
@@ -4,8 +4,6 @@
  *
  * Benchmark and test syscall user dispatch
  */
-
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_test.c b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
index d975a6767329..76e8f3d91537 100644
--- a/tools/testing/selftests/syscall_user_dispatch/sud_test.c
+++ b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
@@ -4,8 +4,6 @@
  *
  * Test code for syscall user dispatch
  */
-
-#define _GNU_SOURCE
 #include <sys/prctl.h>
 #include <sys/sysinfo.h>
 #include <sys/syscall.h>
-- 
2.45.0.118.g7fe29c98d7-goog


