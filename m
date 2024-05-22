Return-Path: <bpf+bounces-30207-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E0D8CB774
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 03:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EB9DB25094
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 01:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2A914A08D;
	Wed, 22 May 2024 01:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tJyjl3Ll"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D7B148853
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 01:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339640; cv=none; b=nkK/TA2rPSPgy0muIbmfRqNrm/pvz/AVZ6KbeOUnlw6EJ5fOuMo0lrEH2rwxZK+VRRhpvXpMEbDbSZtxKTfE7PpnV46Zn/ZLDfoaETD9PNPpLZJkVfvEEXjOhrQ5OUUxAZiVMcieCF14RqntWv9eCTI2snJaQ4hB7/EJUCB5xgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339640; c=relaxed/simple;
	bh=JFhciCbc61MBa4XyewvFb1lKT00Bu3BgfLyFEhkBF2M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AOSkc5nqmVzNL28gKD1grRzNYgJ8nN7DVQ2S4Xr8a2o0TxI2ZxX72NVNmGqAntnWezH+CHhrIIutkPAmSn7PT1VgY7G6oWG+OAARgcsatF2JgKLuJL+vw0zox4BrmtCzFoHOvJ68/1iLY3yExsCv+3e6rkfPiSd/NqkBf+S1KYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tJyjl3Ll; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-62a379a7c80so229316a12.1
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 18:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339637; x=1716944437; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JxajjTXnYYVOFD9uBYzEDwXtIEu/3Rsj0ndr4XzJYGw=;
        b=tJyjl3LlC40c7l4MvoBWOON7OCzq0T3nLPe5vwJH9t2SN4J8/6rWW5ZI7jNkIi8/c7
         gsoILil87wyJfIRMWhee+QD1eQ25BFMB/oNT7+xp2xDHmK5gvl7e1GNhnLQHMbGCelNY
         Y4g+PXx/5Hd9R8Y+WTRzCgEAfDfLtK6oNbZiP6s4y/ma0sTVIGUk0yVjt59UxEOwd+H8
         DqaVM+S/EaOOlp/AQDtrQAH5vOSSr8LM3g+Om7Y+bhPaZ4bX7P9mZwef34tMM8fQig5D
         wz1ayQePg75RGvaxuxVDudCexW3ck2idYBGDSKJn4I252m0IyIwHJcvSZm8qNog/JkUS
         MVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339637; x=1716944437;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JxajjTXnYYVOFD9uBYzEDwXtIEu/3Rsj0ndr4XzJYGw=;
        b=Q1lsjh7+rQTzyggxlbffbH51jD6sOzD4KuJxZcBQX2MA0Id3fYdj/EpNTv1TmhDtgp
         HHI+bZUuiYQYm2PUQu5J25+e9zZhjA+fC4uGLzJ8OzA287nRnoVF/8IDJyoo7tgFLZ9x
         LrgXIJSwDReaYBGKFIZs/urkFy9N1Wsgo/5T6p77BU0Tl5B3aHlJWzmInCMcQbtlt7Nb
         q/w07rNFdDqIajtt8mIklq2rX015TpC+UyoR0BlwWRASZaUW28lzhDyBbvGARmDjyxSG
         hgWjC4+0lCySiDLSZMEIYhbO2yARKP2HsT9zzZ45M38PfYpRjQv884XfJaD7zp4McS8W
         MsZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo/DCd+hVQTImg5NTNIuD33evvl3cr80qw1fzVeG5Fj+z3r13QTgHCQt+x7Pn9gNgV7EKSsrJEk5B7jkKfC5Fr5KGB
X-Gm-Message-State: AOJu0YzT5BYzKz9hwIljO1U000lKTKH3I8JA2FZdaR7hmpLFJ5jdgpZu
	BH6jk7ZJa7LVFNBCJot3Pu6GveO8rot+lmI/EJUO5cA2MxWro6M6WJJmmnD6GNQo1EMR+DgxbVF
	sGQ==
X-Google-Smtp-Source: AGHT+IEnjqQT67JKIH5im85s2TXusw89Zmodc/cXnUeHwbA1PsuQIpfWppspP0Q6xlgu0hmLR6KjvP2VuXY=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a02:59f:b0:658:7c4c:25b with SMTP id
 41be03b00d2f7-67601b5a4c7mr2750a12.4.1716339637230; Tue, 21 May 2024 18:00:37
 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:10 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-25-edliaw@google.com>
Subject: [PATCH v5 24/68] selftests/ipc: Drop define _GNU_SOURCE
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
 tools/testing/selftests/ipc/msgque.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/ipc/msgque.c b/tools/testing/selftests/ipc/msgque.c
index c75ea4094870..45aba6aa8e1d 100644
--- a/tools/testing/selftests/ipc/msgque.c
+++ b/tools/testing/selftests/ipc/msgque.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
-- 
2.45.1.288.g0e0cd299f1-goog


