Return-Path: <bpf+bounces-29404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C968C1B90
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 02:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EC42281E5E
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 00:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B681420A3;
	Fri, 10 May 2024 00:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wZyOpCWS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAB614036B
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 00:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299926; cv=none; b=CwYrYl05IWYE1BEtSycR1nrPjShQAh6kloAvFItgQGoPDKXdxW9fRo1N8do1SvqTVutAEbNCgit5Ln5NZO8cd57CqaGIa7OD6FHM2NzVPK/8OzKT2tay9ui9RL/yWO2DeR/czUQfjl7377AyY59FEChbQvZqLeLVu8K3OlWTZpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299926; c=relaxed/simple;
	bh=3eJI5zSrDuIzjnrtml0eoF0GxHt+dGhxWnDnqgmi7+E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CZrmTXoo0ukmBcqd39KLrvhzkIZZgtktvEm+/jLkpkHMzLl+ZUlXgV8OwRRnBR3gjXrclnEKIztkBEMEHDSEiD80TrPtabmMBPrEAaH6FAB3itL5hkOu+m07JaY4iKMQ+6KCSQ70YYJjkUojtN3+NyUtOkp50MgRg1J9sFGDR5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wZyOpCWS; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-613dbdf5c27so1269908a12.1
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 17:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299924; x=1715904724; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AuBb56Ya/JVHt3ZPygn0bw49ZbbB/FQ8kpaCbLZgiyk=;
        b=wZyOpCWSM3WHSJbn8sAaw/WuEzI1DaK6M/RaXSSQroIRnVDlLc+s30ZCoxG54pylQ2
         1KI01vnfWorfbKiC5B/Tgv8/wy4mlBZ3TVVX7zR1JRDW1wC/bet3UzTOaATdd0izyZBm
         UWCH+OzypJY1oKVZZDCBO0E8rPw/1t01Bh45bQ4eezMk71syvGhh3hdvPndU7uulAyuL
         oF/cLbhEeHfjMzvL8oh0Ovij/iWJeX34AWTFz0foQG/Et7ml5UwR0pEJctwt/NgNy8MQ
         zs+9hYS7nUaYXERBR+RZDzymxmDi/iAdcArRfxbbOOM0UgmT8P4VlK31nhTbi7sf66Nr
         HwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299924; x=1715904724;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AuBb56Ya/JVHt3ZPygn0bw49ZbbB/FQ8kpaCbLZgiyk=;
        b=k9hGb11UnYgoECRPHu138OQ7atNubUE9D9UJ0xBxs3XX6EYv8lmHv+aqYcearegu2h
         QsjSpEtWrM02sS2gHCX+eROfhwpyM0Whjh6N/0I/cjUjfaGxOOwelWeOBBeB0fILz5tD
         kpHs5PgTKa93qU1srOAStkm5QRIx8dALJh3kZjOJxrKIIMiC3GQ5ge+KqYW+KGvgHpn8
         rcf2hE97a7zKRrCdeWssE7QoFMNJ/MFMwgVzT7h3A71a1CGoTx4pHYkA3cVNVS+pjCM1
         MKhjy8dFJHDeNNV6/x5/KaiE5+uW+BFrIPAuK3dtHTvBe427GIRpuAx8CaJzse7QtuTQ
         hGnw==
X-Forwarded-Encrypted: i=1; AJvYcCX/RUvXcFbYKUw32u+iUUxSzZrHD743+stk8VIswIhwu7qPYwLIHxfwM1CoSom8ZT4i4Fg/NAlx8/saf2q6qZ6RqPfi
X-Gm-Message-State: AOJu0Yw9GH1oHGBtsq6tpCbCZBnE3TWog5W8NEgGJ5eOsoRLtZxiAoen
	dC9b5A0WEOEQnKu7dL1F9W6v0Rdbb2w4w6cFT5njsKXMDyw11UT5DfoFNbPRz9/O4JGYWcejmue
	+vA==
X-Google-Smtp-Source: AGHT+IGDiT6r5MtSiTKtFOeh1TnvuA8iW3sg04Hs0Mp2HYr3hoUvchEofnYDdFYeElPPK8QwfKXlxZAkHMU=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:903:32d1:b0:1ea:2838:e164 with SMTP id
 d9443c01a7336-1ef43c0cafdmr333715ad.2.1715299923621; Thu, 09 May 2024
 17:12:03 -0700 (PDT)
Date: Fri, 10 May 2024 00:07:20 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-64-edliaw@google.com>
Subject: [PATCH v4 63/66] selftests/user_events: Drop define _GNU_SOURCE
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
2.45.0.118.g7fe29c98d7-goog


