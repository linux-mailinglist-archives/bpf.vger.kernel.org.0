Return-Path: <bpf+bounces-29288-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBC98C170A
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 22:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CF5D1F21623
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 20:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B167145B36;
	Thu,  9 May 2024 20:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dJVqKCP2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C50B145B0C
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 20:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715285017; cv=none; b=m8upFrHzq1UpIxW34pvA2mqGqrW1lVmWmRAti2ZGhPE3BS4NmTQdhaIf58xFPcansHkK4MIQhJhLl8TneDUUR0+sefZFLIZleTVpn8Jj2NaFmihlpHe9cERpt0ce8Joy3/CKtFM8tujYhzk+UhHmqEk+6eyOBD2CZ8x0rp0JBug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715285017; c=relaxed/simple;
	bh=I8yGuW/KXCCT2ylL6gzPoz665BMtEAWkOpPaq+pMnm0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uuqtofcC02eTGLd34pLM6A73/+yjmV9uCFvASLcIWTc+l/ym2kVbjlqdqL4W6l5HKqlehl1rxlP/KHvgM6fugOkKQNOra3jP0fOvGuGACN8a4uB5WNW7Afto9zSDqitOQs8y1qnx8nOe1FWL03r4aqa13geHA0/j9mhE6sraDKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dJVqKCP2; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1ece562f2afso17163485ad.1
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 13:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715285016; x=1715889816; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xEcgXmlghWsxQT9HZckvmES1mnfU4TIKjOLdePjkrYM=;
        b=dJVqKCP2vwIH/vfv1rqkZGJqYyq2706ApG7kGGU3RJBtCkco7mG+D/uy6HATBz+5Po
         kK3SDuuATALAZIbBAeqmfnTTltqr13OP/r3CLyQ+zpGgz60HNc1XTVcnju2yXQ7N+WX3
         8N+HCuQYdYPE5Bg6YoQyp+goa1R89rA9xrCXaV+quJe85Y9tFWtjxyQ3mpziHYZIWkaT
         vBWFlb/Vq9o0UGbpRFJ1gypBQr7FQwqSOHgHWE4w0VwppzJ6QTBkfFwnQi/iPh2rAPT9
         QM9jr+wOvrNfyWD4yLvivqMqmh4bdwaqM8eazvKlbFfXGelnhmNVhbDCY0WhFe2LFv/T
         1TYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715285016; x=1715889816;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xEcgXmlghWsxQT9HZckvmES1mnfU4TIKjOLdePjkrYM=;
        b=Q4PF5vS2yjknrUEwU05mEcgU24He/rO4Z3htfRamhVje3aIJwSayUYl+LhDXrv+M1s
         S0O8R7fbjIxoDfHNlEmDgywcr1TUqVuHQ11wYN3SjrVeZyys3SSYGnOtdWn7/LqSziuQ
         aodfQW4EKyTVhzWQMEocLutrjoTxib49N07wtR1KcKJs8Rf8mmeWkz7Wsh3YIT77EHxm
         BgwQ7t2XBlnsU4V/SLHX584j2isq2orfIqEZ/DNXRyWby86aAsXsfGY9DW0Tx/VqFtJQ
         GSUR8tC0O+hpvOR/upQiJblTGEZ7fIyb80aJZPhpi0Br8ZZoFdZ/99alfOyGYIjzqjyY
         hnig==
X-Forwarded-Encrypted: i=1; AJvYcCUq5tGnWsXjzKBerM8UiFW87a39kDppeIJZ0h/1kd9EObKP+eqNzEv97+Q0V1fMfvCGswQMDFSHjS5Mlggoeo3hp7TU
X-Gm-Message-State: AOJu0Yz2U33QdHx5hp/fsDwDGv38uUdgL7KKW2x8CFKCePG3rGTa15z/
	uZTc7UZJPsnMNTPmBmZ3r1ScQ4/KO9VlsY+M/6Sl2lBOG9bM7DU5oZ6S5K38hRcuZA/0mPsFuob
	6Hg==
X-Google-Smtp-Source: AGHT+IHTECOTBaYQhqNZfIW+fB7Q9TJWNGlGeyv6Oslt4KegdwxZAJ9Uq25W0NLahxVsi9SF18hcwHJJfh4=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:903:11d2:b0:1e6:624c:f1b8 with SMTP id
 d9443c01a7336-1ef425511a6mr278815ad.0.1715285015792; Thu, 09 May 2024
 13:03:35 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:50 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-59-edliaw@google.com>
Subject: [PATCH v3 58/68] selftests/sigaltstack: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Edward Liaw <edliaw@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/sigaltstack/sas.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/sigaltstack/sas.c b/tools/testing/selftests/sigaltstack/sas.c
index 07227fab1cc9..36b510de0195 100644
--- a/tools/testing/selftests/sigaltstack/sas.c
+++ b/tools/testing/selftests/sigaltstack/sas.c
@@ -6,8 +6,6 @@
  * If that succeeds, then swapcontext() can be used inside sighandler safely.
  *
  */
-
-#define _GNU_SOURCE
 #include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
-- 
2.45.0.118.g7fe29c98d7-goog


