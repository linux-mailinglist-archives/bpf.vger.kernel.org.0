Return-Path: <bpf+bounces-29295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F27058C172E
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 22:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABD7928855E
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 20:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9463148FF2;
	Thu,  9 May 2024 20:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pe5LzmXl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0981487EF
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 20:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715285037; cv=none; b=nELQcBTkol9k2W21qTOVWyqrZsh1StL4d0DxW55X0fgEdl1DJxwjLkWbVOlRRDSxeS3UMVqp3fqAjQlsvdtUSSG4q0CPYtCy0tPcIPgHIs6fN3yT7Njh5LBqNibgMhg6o9jGxvwfGDBJaf/zmQSK+g4oEhpmvJaJlTt2/aFxliU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715285037; c=relaxed/simple;
	bh=ZEp2hCOhRfZV1MvzcY8wQBy7akJNvFUYRtoEP2ESOPg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uCMEgKoQZ332NKspyHBHiFCwvG+aP/FD8AgsBXCI93S7ll/NfcLUi7MxvjEPG4w6p3LQ2tOUMUBXI/4qPd/9+rDnlrYz3tto0bzpEe+2CncZNv/luECs4Z10ubL9A4k2UoFvSLTAtMZ/RWkG5cRYDN1uURRP3E3Bit7IPEGNIDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pe5LzmXl; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6f467b9e948so1255428b3a.0
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 13:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715285035; x=1715889835; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WC7D8aH0v4uQUEV7LLGnAs38/YjV1LtGmErWE1cbhiE=;
        b=Pe5LzmXl1/IMTW2B2qwkxlRyYG0WgdLdt9wnksTnwQ6GJtoUmYvEfwwI1oTFzJwtTa
         0adZo9PbtCoousN0mlg78joAg2ZGIdrjbYBS3j2te7D/yjdGfEKaUUVhyNE3Wa0Z0Isg
         ksKEVY1CSXoJ95rvJPFatPAQ3oQFnjw7zylc87inP2s9bxyfl/pT6/i27dwY/SzKwI2O
         1PPgFPCEsHaA7ojLJ/b//gBMSupeFdzFw9voVO3QYd1ef/mZkBji46QqeIZBsdOcwovc
         ylbCkbnq8gJQkOdRUuevajcMjjzxiy6ue9HCObZZeeQn2u5xooUpH2ZoMsJI3QeAgTiK
         Ub/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715285035; x=1715889835;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WC7D8aH0v4uQUEV7LLGnAs38/YjV1LtGmErWE1cbhiE=;
        b=d/x1OSzq8LEu8Qfn9cu+4Hu52FIY6KSc5OEajPsazm3CwjM0PR/x8cdYsaFBo7qJ6A
         +NOIu0e1WThUUjXS2Ux6gGaRYBeyps5+Hoal6ws0EQW438GCU4Sd4CSQqcmA/a6W8pVI
         KQEwcN3SdmtLfkPIR8IQWmKIKaiscUC4sQ5/tz8EfXI1MYxr05RU5U15ZUMPlDeox/lb
         DK8PAeb5wrqZ0jZw/Iy+bzjrJWzFOIWUIfIV2xqIQykrSUpoSuqBW6OI9KqU6yCnxt8z
         dHPJPTsA+Xcb0EkRJOyc3Hxv8EK4zE0ZS3T1VvwYmQcix+tDMsrb+GQLeE20xpZlHSiD
         UmdQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+y9MTl7CLRR2aVCvVIVqzT6w73fVe/iaglh9eXG6iqQet79vCaBHuqO0LKYsK5ErIAIjLmWUDz5HaxdAqKJiGHJPk
X-Gm-Message-State: AOJu0YyFmY9NPh1m5wA0+Tqg7z5+vPBi/6LNqipkhNN6TRvRxwdbrqm2
	izIQKBcotgvmtZIeLK/2UbMRHGIWS0a/4MLpi5edifppUcWhFVOAMVHLIeseUsR3RMMhBTOD6gZ
	Q1A==
X-Google-Smtp-Source: AGHT+IH2SbJN822nfl37wycvsXND96WvS/1faYgMHWYRV6m5iJpfeL+wLm1M6pioafAmOBMqwtyFIThDOZ8=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:3c91:b0:6ea:aafa:815c with SMTP id
 d2e1a72fcca58-6f4e0263dd0mr25176b3a.1.1715285034729; Thu, 09 May 2024
 13:03:54 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:57 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-66-edliaw@google.com>
Subject: [PATCH v3 65/68] selftests/user_events: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Edward Liaw <edliaw@google.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
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


