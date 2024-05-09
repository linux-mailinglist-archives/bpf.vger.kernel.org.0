Return-Path: <bpf+bounces-29256-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 632FF8C1662
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 22:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8F921F2696F
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 20:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D6713A242;
	Thu,  9 May 2024 20:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NGRt5TXs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C77213A241
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 20:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284923; cv=none; b=SMNI2CQhT532XfImTkXEzOTc6qF/wZOBUABN1jgVIvg0QN4f2Z7wC/84fVhKe0qivTF16Am5/6JJRXQtskYBgZ3z+GbjaPH8S99vjk8mbLSWom68SBL0eQ/6Lf8m1NaDA9A2CPM/SKkjsgBKZUW06exULagEmlVFLd1SdLgcDNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284923; c=relaxed/simple;
	bh=WwN/b+0vohFwK2+oIb27RDmv4LoFS5SqplTVNpxiiFI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jjNFjtEqodP5OwlB8gtRgqYy4sCY5W1GKa0F40p46x+7p1vnTODw6Mx9fLKGcYhHni374BDpgqXn+LslLOLFk5UjeJ2qEHm3yf1hGXXb3sU/ZNkHBhX9kzEBPOQ0b4dWhyu4Tpqz+BZJTy4BY42miT6vyqHXkXFTCMssiWt6CS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NGRt5TXs; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61510f72bb3so22887937b3.0
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 13:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284919; x=1715889719; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bCAetgsy5/zofnz+8UMPVpCBKs2hhXfKubjl6/AwDCQ=;
        b=NGRt5TXshpVeXcX5sECsyA0C4hekfFpgdjPNRoq2ETsP3UL8uWirnJBvjNjbFZl+nG
         nlzssz7ymvF0NqcTOXvGMiQp6HqMKckg27BrWUBCNwfAOxAWlsEakin75jFCJEr+8xBb
         N1wfK4r6B0Sc6L0H5zna7wfCXCv38gPQIhyQ9zGN3Vn223HsqSfeaW1OSrciX0IC5okh
         1Z/lsoy4jLbtrxXmJXuHIgdef1LmyRq9+ONCro0EqqTUJiwOMnforAUELByut1kP1rMr
         bBSVyRZJEyWyzEQktaWTFAlhrRTqQ0xuk3f1NJ63S9md8hi/BxupTeO6TA94ZW1UC7Rc
         UHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284919; x=1715889719;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bCAetgsy5/zofnz+8UMPVpCBKs2hhXfKubjl6/AwDCQ=;
        b=Uzt7jOPoQJfyMOQNpTjSWNa7Ga7XDk3sGf3JkHhFDE1asps2iPYIKpIGFtVO9jGPua
         E7C5wGzFs6bYSDRaKLjaIyQT9zlRLNeQxNMJ8c38rBCAYPkSS6XxDD6YFqxEYBHVWzp2
         xVTVtCgsnsyAqoTfoPo6mdmdjp+G3sOBQMv7ZTJZj3YQ4ainD4Ch8Pp2ycBFquYna/sD
         e8bFq/o4P42ioYYezvq9RCIwJc52vhgvzG0fQFW/pSG8PXP2uFXASVE/g/FEcEOI7kDQ
         ysPpwjuYRDdBUSgyCRhtkrcFlghZAJkI1Zjl5neQPwmIkd8skO3BryWW89ntgHNwuXok
         eZLw==
X-Forwarded-Encrypted: i=1; AJvYcCU9EYO2QL9pUJfQC54ZYZt2zW1g+s9O5/48cP3UBEXc7KA5nre+j4kCk+R8K7It68MjziiEixoEWLXtooNyxYb3lbQe
X-Gm-Message-State: AOJu0YxP272P7E4y8g/vsWpDVxlVKqbSxTZvBhzJMPqFDPnCmnXOVzKY
	89EHCzfTkxVw41KTYd9b5mtfDbiI+pBq+2PaEAUo2EW82NsPCKk1SFXYDJtg0QSkceFp0RGPVMw
	W/g==
X-Google-Smtp-Source: AGHT+IEOccdP8zaf02kaUFiSefNhqGNYrWb2znEKmAbmEDy9741vUefYHtBjwkO9wTStl7g5XBDfQZrMi8A=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:690c:6f8c:b0:61b:ea12:d0b with SMTP id
 00721157ae682-622aff85f0cmr1704757b3.2.1715284919580; Thu, 09 May 2024
 13:01:59 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:18 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-27-edliaw@google.com>
Subject: [PATCH v3 26/68] selftests/kcmp: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Edward Liaw <edliaw@google.com>
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
 tools/testing/selftests/kcmp/kcmp_test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/kcmp/kcmp_test.c b/tools/testing/selftests/kcmp/kcmp_test.c
index d7a8e321bb16..f0e356139e1f 100644
--- a/tools/testing/selftests/kcmp/kcmp_test.c
+++ b/tools/testing/selftests/kcmp/kcmp_test.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
-
 #include <stdio.h>
 #include <stdlib.h>
 #include <signal.h>
-- 
2.45.0.118.g7fe29c98d7-goog


