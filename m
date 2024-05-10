Return-Path: <bpf+bounces-29350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B835E8C1A78
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 02:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E94921C21F62
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 00:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69694D13B;
	Fri, 10 May 2024 00:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yz0ta83T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7B9481D7
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 00:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299778; cv=none; b=ItI8MrUJXgYHmCeF39qJSTE3c23ruQolIIJ0lCJfsvztSIbaWFMJ9bCWXw1ZQDULTn3I4ZFfYCpKISikC5KcXVhgPkWzBlv0qTtNQg1W72bcoU0GNbD3vpRTUfxunkCVILJY+slAJYS+25j3a/3TT80ddDY+5/0/k+KDDg7Y1t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299778; c=relaxed/simple;
	bh=uP1VjvjO+ZG+H0u8xtc1s3616aMKUL64MqV9W+TF5xA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cUHQ90mD5MGNUhc5oR+STUfgD78JTJwv5B5ZDYL8Tj6mkzbowe1ef1XlDV+E5gE66vR7Ws518Uyc7krnnfAiEz6dkTz0GsjhBD9ur0XYvbXrsx5s9ixA5UqJeIk0HyiIQh7zi7cZG8I76ZVcXIimUS32dGdd6b72DKuwdShHnNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yz0ta83T; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6f4755be972so992159b3a.0
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 17:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299776; x=1715904576; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rki1zNwlC4Q2li/JAqXiFWxY+6JbB/VfdRW8esf0LTc=;
        b=Yz0ta83T8xfHIJ4KRf3Aavr9G878zQELtD9Qj30m438OqnqWy+TJEQMNexcm1hcsD+
         M1GlhWcWtZchm6imrHzyYKmik6ZS+uKk3yTj+nh5f0iWRZs8rEnkiK2QTEahv14K8U+3
         NLI1G+0FvXlJAd9blL50OVkvxHnqkL5u6qIvkAkMR+SRe0Kp1mnAwcErmE8aqs6zQ5D/
         h+L4I6U0H7OLpnXKs+thE9hvrSQAXW9KB6Rz3JXLh0vtwMweYWi3mxiqB3bMlKj7Xpfm
         cY4gKaq2hZc1PHWrTgr9TfKhHNImmpE2I6XwuyE5SlJaRCx7vxVMCtPKuzkMcgT11RNx
         lQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299776; x=1715904576;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rki1zNwlC4Q2li/JAqXiFWxY+6JbB/VfdRW8esf0LTc=;
        b=VwjZItpQiSJi1D3q5CEGbJWOddHhreWDN3eZumbzoFcFl7l041XrHehXv7yeKJLWUP
         smpE5b5TJr1JI9fJdUfvPjalYj5kS5nH2MQjZl5DDz9Sovm3WRIXyePTx+fINJIvMbcX
         Z6YK7RNQE6u3thr4yQ0wq9OStPjDmAu8cP3H1n6ib0e+0705mHhUe4YcvuNoNM2XiBDf
         s9DfYxQ39Y7kVlo51wclwT4RRT1oL/kI5QbToSzYzQjMfP0Z6C/m/8lMXjuoW0VIxUyx
         csuqcwsSW1dQQPXfkupxWrMMMInC72L6t+imOeZE9Vv6aI4TMostdrowUWNQTvHF6wsv
         oUGA==
X-Forwarded-Encrypted: i=1; AJvYcCUQPkkXRbYwo3x9qN94fDRchvof7KeG2H0hBOZWoPPjOviiMNB5YQzEP5z8hj2r+wGCRwB44mM02qXeAYc9Dy3PZ1Kp
X-Gm-Message-State: AOJu0YwM0Mqk8zHawuWKRQ0keuPyRzIwUMtup5QHFht37d6JB3nR4CZg
	70Sc+LcXGyYGf1mOf+EmnKIk1VLR1UecdMvTVchSLOSJj86iGneBx8BeNJ//RHsOmEr4diJto7A
	kkQ==
X-Google-Smtp-Source: AGHT+IEEWJM7ftE9Jo7Seni08HtCRrr3H8vKgAka6puRcK7n9yq+c0cor9pTiIkjlNkR1yBLMg0zxAAn6XY=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:2da6:b0:6f4:47dd:5f41 with SMTP id
 d2e1a72fcca58-6f4e040fefamr39256b3a.6.1715299776407; Thu, 09 May 2024
 17:09:36 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:27 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-11-edliaw@google.com>
Subject: [PATCH v4 10/66] selftests/core: Drop define _GNU_SOURCE
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
 tools/testing/selftests/core/close_range_test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/core/close_range_test.c b/tools/testing/selftests/core/close_range_test.c
index c59e4adb905d..1c2902bcc913 100644
--- a/tools/testing/selftests/core/close_range_test.c
+++ b/tools/testing/selftests/core/close_range_test.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <linux/kernel.h>
-- 
2.45.0.118.g7fe29c98d7-goog


