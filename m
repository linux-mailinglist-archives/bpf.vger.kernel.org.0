Return-Path: <bpf+bounces-29239-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 366AF8C1603
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 22:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6751A1C20A54
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 20:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2268B12AAED;
	Thu,  9 May 2024 20:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N2E5/RyY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448ED129A8D
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 20:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284876; cv=none; b=Hqge0U8xCsqssdIaaXdGSqFLHc7QRprch3QOj7Wi8nfilEwGeshPlnA5rGvOu2v7w37r+d/Kt0yAz4vQRfxXsvT0brPtNc1jkX6F3xLotN//g7ObeomeW0bfFGTQKA3FGFBYAyUAxDc9RZSGQdqr/BYqFAsN2ecmXhlUY7B2UjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284876; c=relaxed/simple;
	bh=nVA7WynaYFBVsnuTAeEB3HhV8hTaJ/3V0zzotuqqx3U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WhN77aRs2CZz0eoWJPN8Dh2ewjkYDfbjLInyQRIYDZLnJdWEXRoc6fNNk0r9leq1RauNLaOb8Uez40YFZCQ2V4A2HY7Oa4Zb8Wi7P6v/jqCqZ1kFpYVc+V3OnXSN+pOYPLyLxf+ug2anbAjMCYMy0f093RhVkcO8l3R3xYfGxlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N2E5/RyY; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6207c483342so21135307b3.1
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 13:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284874; x=1715889674; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vKajnWgRPRIusaCsN3ehDRoTdZ5to7bBmZ+li5CBaYY=;
        b=N2E5/RyY3Sofe4tQmN1U7Texo3jUIp41vSmRp3qfu64rUQJKWKqDmhYjuWVvpModnd
         blvx/c0WoXXJFilyGK01v7JPVbZki13roJgOBEm+U+K/NALmNJVVLN94OJGysuENYjvH
         AMGezGUtvHA+mlhev1JOwEEKXGmGpuSuT+WzfNl6S/DN+OmMBCfdtApJBLlzkpfXui1W
         yo695cblr5w9R01mYtxWRvKKu/v4aT4clsVekRna6C9AApMADKj6hK5ohHF+C4X6AB7V
         5BY95UjMSYr5f3PE46CyYKFQmw1nd7qJjfEUhwLQwB1sDg3CJr6fiGmvH0UKXH3RiecZ
         S69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284874; x=1715889674;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vKajnWgRPRIusaCsN3ehDRoTdZ5to7bBmZ+li5CBaYY=;
        b=JhptyF1RfkFpN7afMej4gxcyE+6vw8B9db5f6XbPZcvVv97MI/B3Fnpkr6PeJapxU8
         A0GPpbY2ksWNmk5QKZM4WwHkwvLE/mMXVPFk9/YXts/1yEtFMDpIo2cwUsi7zIOBBBXE
         2ZbpsL6ka9b2KgCqOSaauDZCHUD/JASpCd8xmEPaINYXqWgKc2eJXK3cPN/VRzjEa3pp
         UYn2sZcibfEPYRBswxTYbISg141GYiiURxaNXn8tQrPlj6lOaWJxqo3cBKz6s8l0ZPUU
         Grq9lqmJj8Xx2zCS9k6bIezWbgaRBkbvBeE+xOdo2pWdPz7Qtr8rc/Itmr96atxnfgP3
         NaiA==
X-Forwarded-Encrypted: i=1; AJvYcCW/8FdqUM8PGZ+9gCtGykdLiUscDRpi5Zlzu5Myb3zJYQo9EbZQ+Uv4xz2lU7Ppf1r7zFI75Mhdd2cV4il9NLv6S52x
X-Gm-Message-State: AOJu0YySkH5NQmhge8xSyxjHTJzOifKRPF4MyqjbWdrEvCtDDlKNS2yS
	m4DuVFLRdU6Z1Cf3O0dJotnuTrPsNOnxljRZOD2peucdxyYHjTY62F0hzO0NfwNNZnsx+rVEDvc
	fQA==
X-Google-Smtp-Source: AGHT+IG8BlqL9c7H6gT7HJqAjPMzqcZbchjuSJZoZPXFaFuFxFzRUA/yGwhzK4FApgVn7UGcsEa39MLwACI=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:690c:4508:b0:615:e53:1c1 with SMTP id
 00721157ae682-622afff693amr1508007b3.7.1715284874424; Thu, 09 May 2024
 13:01:14 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:01 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-10-edliaw@google.com>
Subject: [PATCH v3 09/68] selftests/capabilities: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Edward Liaw <edliaw@google.com>
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
 tools/testing/selftests/capabilities/test_execve.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/capabilities/test_execve.c b/tools/testing/selftests/capabilities/test_execve.c
index 7cde07a5df78..e3954b88c3ee 100644
--- a/tools/testing/selftests/capabilities/test_execve.c
+++ b/tools/testing/selftests/capabilities/test_execve.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
-
 #include <cap-ng.h>
 #include <linux/capability.h>
 #include <stdbool.h>
-- 
2.45.0.118.g7fe29c98d7-goog


