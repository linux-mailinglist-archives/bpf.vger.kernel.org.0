Return-Path: <bpf+bounces-29384-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0088C1B27
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 02:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5508428804D
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 00:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE5013A897;
	Fri, 10 May 2024 00:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ihijklfl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB0013A88D
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 00:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299871; cv=none; b=Cu4pk/cqbH6ckTVLmwchoTbfpzympfinXfo8vVOgpxmqv/e3EiT+P2qHo3EjA0A5W94Ke8d8vA3EkL9MLRXv1wk5j6NyD1HQ2TylkMDtvVjML4tfKWTYSY1PiLkp9VCZew+UsfQR1CuL1UYb1sTCZAyTEZLpPki43VZgOZNVg2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299871; c=relaxed/simple;
	bh=D+lO9RJiz0JqcAKo+iLXjUNg3VNWTwEI/ljWSIi/yJw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SMn6uBm2sDDVB+EDGKtx51HGuqI+tF9CiRr0781XvEmWaI6UhXN/raYV8u0XbvaHFvcvOs5FTFPN8MiHsJwZ+WsAzbsJ/mmZiT+WTztCTewsAnVmc/8Nd8RV4IM36FG4C+tASsK9FdqpgDILdOFQDb4hUtsxYLbeQZmNRGLVhH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ihijklfl; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-61a119df58fso1078372a12.1
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 17:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299869; x=1715904669; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZH/PIKk2jB1jyNx8bwLH0dpZjssl+xjC9urhdkKkpFc=;
        b=ihijklflM/LXZxFpQ53Argdo7ZXQMLLVmKPMognN4gaCMmD44G2oEg1261nUbvD4J7
         Y8GvGFipy4oqYd4WMLd8bzoVPx7QpJV4A7MQ0qmBDw4QDbLiqM1942mPy+bMMQxJTFVo
         L7B7rg3mYDqiX9L7TMBrZdAnnUXZiRasUOxcWf3xnUlzXyyl5eQmIYaKuqXhevtAbv4S
         0P6lSUE+uUKm+HvcCwzpO7ZDIq/cH/fAieJl0OsSUazilFf4LwDJJN+oJgZqkI8+ysYF
         rl/QIH0EnrfBk1MUWc6/M8gTxpLjNbawQBhcTGTKwpiAPY/pSC1gTA6NB7ZYoTgSyJSL
         k/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299869; x=1715904669;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZH/PIKk2jB1jyNx8bwLH0dpZjssl+xjC9urhdkKkpFc=;
        b=R9UpBBgUY6sa6wcGeWVVhxiUck1mGzxtaOeMy2amVzduvYOw91oOJk0dBmF2Ghoe48
         kF+Lri6JDS4viLHFNsd/ZYG/2FaBJzQkKiJghacFXHeVVvW0yBVhyaEZKG8NK0pIYt7y
         /8y4rYV4Xjfv539hMwU66WhJlCcuEQXETGhs5T+fCwoNy/B5nQz/YNaZUHz9jp95R/97
         hfipUUx4N9rrPV0Wq7aeCJcAgmg5Rzw/gUGU6bSa3ekCvEKUPd2bMPaxfvG8G9kgiOP9
         a/7o/Ck8l+zD1SZoqBucHiZ5Wj61dHOtuSh4Q8++3NEIgpJe9ih4NKUQ0TBNX6Wax4Qo
         zBxw==
X-Forwarded-Encrypted: i=1; AJvYcCU7ovxnLI91wpvAkjCxFdUx3HmR+y4PloQAJUD66D3R77Z9lybFZC/fgjsD05ohLQNo2W1OT95bXhphjVmgv2qFWCTa
X-Gm-Message-State: AOJu0YzajaxcbjXP2vVaw8BFo6fhgaY8iKHwr5k3f6IWlPSKAtztwmhD
	iuyDWtzm/Sjz7B/ZJ/1B1Bko7fisBuMbhPbRABpuRybNSpKcgCRaKJjFSmSX+NuDjgMNqZ0wIq/
	fNw==
X-Google-Smtp-Source: AGHT+IG+AWPXfoUCb1Oi86gOdIU3+gShVVbb026/H7Tu9SdBzskU+3a26qTumDrP4NKVHaPqPJ5R/T8IRu4=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a65:534d:0:b0:629:b0b9:e381 with SMTP id
 41be03b00d2f7-6374183ee66mr2181a12.7.1715299868986; Thu, 09 May 2024 17:11:08
 -0700 (PDT)
Date: Fri, 10 May 2024 00:07:00 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-44-edliaw@google.com>
Subject: [PATCH v4 43/66] selftests/ptrace: Drop define _GNU_SOURCE
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
 tools/testing/selftests/ptrace/get_set_sud.c | 1 -
 tools/testing/selftests/ptrace/peeksiginfo.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/testing/selftests/ptrace/get_set_sud.c b/tools/testing/selftests/ptrace/get_set_sud.c
index 5297b10d25c3..054a78ebe8b5 100644
--- a/tools/testing/selftests/ptrace/get_set_sud.c
+++ b/tools/testing/selftests/ptrace/get_set_sud.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include "../kselftest_harness.h"
 #include <stdio.h>
 #include <string.h>
diff --git a/tools/testing/selftests/ptrace/peeksiginfo.c b/tools/testing/selftests/ptrace/peeksiginfo.c
index a6884f66dc01..1b7b77190f72 100644
--- a/tools/testing/selftests/ptrace/peeksiginfo.c
+++ b/tools/testing/selftests/ptrace/peeksiginfo.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <signal.h>
 #include <unistd.h>
-- 
2.45.0.118.g7fe29c98d7-goog


