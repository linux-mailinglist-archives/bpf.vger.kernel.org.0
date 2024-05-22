Return-Path: <bpf+bounces-30216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 084D88CB7A1
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 03:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8208280FBD
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 01:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEB314E2E7;
	Wed, 22 May 2024 01:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R2bO7ccy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EE314E2F6
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 01:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339666; cv=none; b=JXKCwvGMdvw6LkqWgRnzedGrQ9rxw+Jw3imJzAANb4ffTOTWPos5zHuMeuNyEnNdBYk9s1D+bHPleQ2QkZiT3b6F8SIBZSNwN571heit2ffzsMto+dWEF3HCJJvl6qS7UdRXV8A84V8gFmuGoIRVhsfy+8xt3RN1GBLpiQWatSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339666; c=relaxed/simple;
	bh=D6pMabfdWOjYC/LSqUawpi3nlFHWIIN86xOHz+bpvM8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SyXI+8kwrG3rQ2QwW++Dxno89NRJXaSo64t//e3QYD0MLhoM73JXYHY+J2L4EyxCBJdeVCCwzxLEExXh+7VwGF9T6HAonkNK5iildW6Vi64aOaJCptZIWk43TbMFHxtWvaOhyHVGugz4Oz4UnIOK39wAwUHeTq48Gpc+7zj9ssE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R2bO7ccy; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-65789db0259so6461486a12.0
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 18:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339664; x=1716944464; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=li4cMkwFpL+HSmSEXdVX350c2G+5+gkC9h0B1FeGGvM=;
        b=R2bO7ccyqs3tXPEKzxf4XjEhbrnu5r+YFZqHPax25EnIdejevjilIkRoyRZh5kATHu
         mj4e7Z5cyf7DC0Ggo0XqtiGBl/rzk54xQbgEsBE1fXps/ghIdm9t8Z6Wv73c31vzJMhj
         U4+wFZTG1by73Qof6XSsP6OcWwSnYmtfbddc6WIxgX6X8n5gnIJqCqAAvQzFRjM4HTwe
         MYu2cm7AIg8LLV4og13cd7Jo0YBdZH36XnI45XngbkueucjswSwycjSEyDdnVOz+mDPF
         FmhEzaw7GBKPHo/oJefHNVrIHRXLtMXzSbVIBmxxmSfe9eZUxedJ6hCUAjaMngmsaFKm
         D90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339664; x=1716944464;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=li4cMkwFpL+HSmSEXdVX350c2G+5+gkC9h0B1FeGGvM=;
        b=hmLLEK82Y5aQKw0U1Ym1y3v8eNjQRtcgEJR7Tl8CHnbQoGn8zuAYahozxeejb/ChFK
         cw2IwDlJlBP64knn7l3qmTI2vQ+N+y+yBkClkUXyumVsepiMVpACR3hD2U22SB8f/ExS
         U/KbXC8tNAwOXxx9sTR+tpEGw7VTuCJ1emt4bdidqsYljqhBDnHQt432kQmfzEmKRf4+
         zY4PI2Rp2sdih+QhoBTaMpM79oWcRVCDbGcJySFfGUSe0E+vsWOxRNXRLaZF/s7jhchM
         D/Iuh+HUuk9/GxwGeO/+arzmXtKMirGlKEd6m62Xv8GwzBVckv+dGxp3emeAnVGH2yVY
         VOdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWE1CxAsstY7Q9pDwVAFooovZLmcyY4613hSmUjh64Ucha91k5mqJz9N/K8wA4nZchVGl416b7hLoS8H5/iK3IhSGh7
X-Gm-Message-State: AOJu0YzCrLYfu21/27ZSEPPMrNSO9p7ciV8YnIhDGZRj5E3EeaueYR/C
	ETbTbERBHOxtVvcMgZ8LlcVGbSRtzf5EFwAWul90fR7aQoiX1ftETitIVBXAonNrs7QRVRvirrL
	GOA==
X-Google-Smtp-Source: AGHT+IEaH9w2a57rqCwXzXPT6DdBOoiiolYlPL4GLEwkxrskFIkwJojwmD2tTcosE6e+p+FZJxRnCD+/8cU=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:2644:0:b0:633:af0f:16aa with SMTP id
 41be03b00d2f7-676492d62abmr1177a12.5.1716339664339; Tue, 21 May 2024 18:01:04
 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:19 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-34-edliaw@google.com>
Subject: [PATCH v5 33/68] selftests/mount_setattr: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Seth Forshee <sforshee@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/mount_setattr/mount_setattr_test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
index c6a8c732b802..d894417134b6 100644
--- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
+++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sched.h>
 #include <stdio.h>
 #include <errno.h>
-- 
2.45.1.288.g0e0cd299f1-goog


