Return-Path: <bpf+bounces-30230-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E93228CB7EE
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 03:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DA481F2A19C
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 01:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F063E1552FF;
	Wed, 22 May 2024 01:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oCcbTFAn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43ED154C0E
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 01:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339714; cv=none; b=tYYj5/RTviTepDPKsRVEFl5o4CsSzE9ygZBXLGFz+bZKm8eVlE66tQcPVcQIO1sZJkfvHcjbcro3gOkpq36AsAF4/3WjDXvJNSuOxfRe/rI0GLmpvGpuKxu+BT//odmS791hYhAX4gC4GXqDMg200GYUgK7fWaT+/eJYdkp7Alg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339714; c=relaxed/simple;
	bh=HG/fzBjmfKcxpb5f3B0yExIXXkrOGmT9xMnSqfeC5lk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gcBamtDMWCmSer5r8HWN50/5elVoZnZ7ZqU1MlsCzYvPUosWnYWBB5OKHLH8IkUffSIjEohSJ6x9sxqqapcPRLe0LaAEXjCdaEgvnhDHZHcphUyxgntwICRT+uu+jPwus7LmJ/p10oqfzeEpUiQ5l4vRlugvuoYXCVEakFix3g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oCcbTFAn; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1f314d14930so7550485ad.2
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 18:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339712; x=1716944512; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8sLKR2gMdZkVeKpBpgxiG+z3Q3TQVVoa/qct09zlNg=;
        b=oCcbTFAnLAL2kv1/D8+Qt6Un0xj8UpwQlTiwGN6BOMSMbwo5CGth3F4+n6b1fp6q2Z
         0xb5jhKZNypiwCOgSeZl29sGLa8kzhzpnuAlzux1P9S9CuOhQbO+oX8ec61GgS5K4Bn6
         WUq1iTsYGH6E7WfCAWmgj9cCdFBDwk/IKWIUu3p1pQuvuv5ooHChGxAq/Y62Nm0Viarg
         lX2KQWoQtPalOrzfTg8VM0aBzEaa5VTdNRJT8b2uv2gKQQ5WSTF9jqtNBizlI5rDs+oH
         kLmnmMfODzoaMNMKtm19TwlXmZ7CKjztaFoB/jES3CN4jsVBk5Xz/xXR8QOFIxkIc618
         gCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339712; x=1716944512;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8sLKR2gMdZkVeKpBpgxiG+z3Q3TQVVoa/qct09zlNg=;
        b=JH9oiZ3BezKnLMHFtGdgnyDPHgCd38I7XMvODoyKhKcdRMPmONvmF944ukr9y6opVO
         zXF+zYB2trIZDnYPdvzLMXmt9Buyo+mugSqXt+U7XUP3s9UgwA8gioFCLdxnDbpwZMtu
         lcmsfft8TI7e7TQho7pe7K7COiYpeGCD6IrQRBIcXNjCnHD0GymTS+E4ng5dnTEycJZi
         gu6bD7SVCaWajMnu0vfDJ9hD2IY22EaVXx7Foss9KUXui3Y2udL7rIoV0S9LkyFwYkyz
         zBRfDsTf302APOF2jwVWUZCd77Bri0K9e7aYQsxBzaoeUZsZ4yNT6o2dWpk0JHjdpoGj
         bDyw==
X-Forwarded-Encrypted: i=1; AJvYcCWFK+OCfSHTbAShcpFk+khvdp6M/MUIfqguFtm4LqTpjypQgOzD09PGN8gnKFDv5ac5vuK3vn0eC8JQc/bV3J5EwYeM
X-Gm-Message-State: AOJu0YwErynnWfLUuuULaKovPQQYJRl/pSblAfNw4tY/CwNBcEEQs3LP
	8iKfMG+zlMgfkG8aIaLRbxeZSR91d2gDxkhsDcjwl9likWTuQN9zpiymr83CMWpMEQx67AoSsKm
	OeQ==
X-Google-Smtp-Source: AGHT+IGuQmIgWokYa6GFSf+m5Z57mXGg+LljOBmerbd3gJBjFhivGNVqaTCd4aTQnhoWGr5w0Jse9j9GlEI=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:f213:b0:1eb:51a3:75ee with SMTP id
 d9443c01a7336-1f31c95c280mr34845ad.4.1716339712356; Tue, 21 May 2024 18:01:52
 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:33 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-48-edliaw@google.com>
Subject: [PATCH v5 47/68] selftests/ptp: Drop define _GNU_SOURCE
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
 tools/testing/selftests/ptp/testptp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/ptp/testptp.c b/tools/testing/selftests/ptp/testptp.c
index 011252fe238c..ea3c48b97468 100644
--- a/tools/testing/selftests/ptp/testptp.c
+++ b/tools/testing/selftests/ptp/testptp.c
@@ -4,7 +4,6 @@
  *
  * Copyright (C) 2010 OMICRON electronics GmbH
  */
-#define _GNU_SOURCE
 #define __SANE_USERSPACE_TYPES__        /* For PPC64, to get LL64 types */
 #include <errno.h>
 #include <fcntl.h>
-- 
2.45.1.288.g0e0cd299f1-goog


