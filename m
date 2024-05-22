Return-Path: <bpf+bounces-30228-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2803F8CB7E2
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 03:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84C4EB25516
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 01:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBB9154427;
	Wed, 22 May 2024 01:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DMSiG7N9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D74153BC4
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 01:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339709; cv=none; b=szJzP+kXnS7N+iidjXS4AYCEDHfY/cAlnokA2tO19/yfqtOnd8KaLKCrMUVyja5GDpLjg4AyCUgi45l0/Ig7Wnwud6wG4oowRE5gvpGeRdPMnuaQ++R55SyJ8rqelSn3OU1/jAyL6M8xS4o0KSCDK01U99qBv2czfllkWWeT7/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339709; c=relaxed/simple;
	bh=Zy+x1uRprdnX1Tlrv8ZyVGm6ZAlOs3M7f83fVZKsXqU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fHMDvH56UlJI80T7oUMUjs567IJzob6bApWmnY+zqnlX0QQUDtDvrAY9YuLQp5JeCz6h9GZwL6UQ+rbg2a/IulEMtIM9y9C0gG4NPLPJ+GmS15nL8HVkHhgYw6gPEUft8/7MzJducYrnu4SUQmRwKbNH5kfhNbWHJIYDXgWxTws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DMSiG7N9; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1eea09ec7ecso134840975ad.2
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 18:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339707; x=1716944507; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1dqiMTNBgzJveM+1U2NKL51RHxmum4u5pgeXNwn+APY=;
        b=DMSiG7N9Vx2N2aLHs7pKdX+UM9nRKSI2SRAXwfTF8VvgCG7vmSYeuGBFpKseONTkly
         xnhWF5U7VrddZEJCQV0We2gKBLBv8lBfSLasG8whRSjEYUwOuGTosP5xYUja4qatAWHC
         lyesj0KwYyDzu7Rts/PhiZOLQheVAvHMdzWnG9iqwrWpH1rcEEZrSXejcbIwxgvpSePh
         1d3+1PYH27+QoNZ3LEj+VvxN9d3YfTDQqS7PPSkoqJfEsEIzgGjMRNK4cNeKLDi1oBkC
         8t8JK+ntIy738B8VB4/p/4dpFbzBeYYfOMs32dsuvpBs41kK1vx7XM1T9LT5s9cbw8NV
         L1iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339707; x=1716944507;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1dqiMTNBgzJveM+1U2NKL51RHxmum4u5pgeXNwn+APY=;
        b=DEXJkTt9IdPgInUzyyKLABZWBxgCdv47xpEEvukZli9wWg7QrjWLr3FH0P8TF8hLoP
         MTFGgLuzOGyvRyxJ3GVz5+1NCMnoOu/fAtNwdjmuCEPWXgXQJAhYDHzfoHQjGgD5Pl34
         ZlTPgUYn3dnPrfG6/YeYkRix24A9xTCH1T5W+SUv2XL+pRIx1723ziiy2CQxgoKiNh/C
         ulichDFqG9+CIfW97sgdj1XL+O4NONGpwCOw/YU4ybfYwiQneLs9pCzrPbiDZOdlX72i
         8/tXGKzY205q3Qj4QdDV8obnsMIBa8o1aywWgVxLcjGsNmDOxpid2jJYXa5ZsO6Eyft4
         zuog==
X-Forwarded-Encrypted: i=1; AJvYcCXsByEqcM3E2YcfdOO6bOIyiaV5k8clvUN32LcYUEVEIoPTGY2/dMgYbRfXag/ItAmK1Cl4uAx4a9Rtr2EZP7Exsl5n
X-Gm-Message-State: AOJu0Yx4FcORfLKzIVWKkpsDizS2pxASlHzCErAzHlgmY26ltcpzh1M0
	rfxn25immx3HyS2u5Lkb9Hy5pGPe/eD4MGe8ts9MSLl8I/IR9QRmq3+4DkR7gimmrQ6C+MdTL6c
	z3w==
X-Google-Smtp-Source: AGHT+IHx//11iRXfF9jU7Y+WwJe3/GdLuBAfz6WDem92qdspDh3/TEq+7NzW8GllbYjjYjpp726oyFnk0SE=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:903:22c4:b0:1f3:aeb:321c with SMTP id
 d9443c01a7336-1f31c9e8135mr338475ad.13.1716339707160; Tue, 21 May 2024
 18:01:47 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:31 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-46-edliaw@google.com>
Subject: [PATCH v5 45/68] selftests/proc: Drop define _GNU_SOURCE
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
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/proc/proc-empty-vm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/proc/proc-empty-vm.c b/tools/testing/selftests/proc/proc-empty-vm.c
index 56198d4ca2bf..f92a8dce58cf 100644
--- a/tools/testing/selftests/proc/proc-empty-vm.c
+++ b/tools/testing/selftests/proc/proc-empty-vm.c
@@ -23,9 +23,6 @@
  *	/proc/${pid}/smaps
  *	/proc/${pid}/smaps_rollup
  */
-#undef _GNU_SOURCE
-#define _GNU_SOURCE
-
 #undef NDEBUG
 #include <assert.h>
 #include <errno.h>
-- 
2.45.1.288.g0e0cd299f1-goog


