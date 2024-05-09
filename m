Return-Path: <bpf+bounces-29279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD1D8C16DE
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 22:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72D581F2469B
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 20:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C5180C02;
	Thu,  9 May 2024 20:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F+YyfEEy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970651411FA
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 20:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284997; cv=none; b=t6kNqhXiAo4XM/xQ++nwh9HEXBG2IY9dbRypF45E7sjeMrHwUvJLGjcQ1Gfnj1LmAY/xai/ev8ExyRneO6wmqO9lLd0UBy3VNNSFFmI3foSo0zIlyzmb3uqYO8W4WXoelwaoLBK3TrwHlT2S+TWXLue2gjY4XlXs8WIqiGbWKOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284997; c=relaxed/simple;
	bh=mj1+9C9mGGt2xAUv+e7gPU5cUpp2meMCMmhcAJTBnKg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B4h4ThsrbH829TAcTkSDrXL0tJi7RrZt23hrFrwEGPucSgq22FJ2p3rkiMIocZ6YJlxV8REUdTmbc7RYBPBScfBttA9u/scrgf0RRiq/ljzAFQYa/FvATcEHZc6U+eP3RBhNfQqmePNW6o470oyV1R036/cERIoQu9GWPSgs4/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F+YyfEEy; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6f45487858eso894919b3a.0
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 13:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284994; x=1715889794; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7kj5kZHOgeTEFE9rl1cg+M+RfV2lbnnrAzPZA+2Lqy4=;
        b=F+YyfEEy24HlJ8TvMLojXarcltCLl3eql5xFMpaXaa1nfm5Ot/ODCI253Zk5l67W0Z
         TMj7Hb1ZqVDyjGE7RgYwo4wDgWKhs4HqJjuMsUg+VAY18K1Mrc9azxPRrhrmyh0jsgd1
         KIvfcXR8Q1Wmd9n+LxGtcl131g+8ujDX2dkA4pIpG0L2+6EANadHjGrFjxaGsJcdDNli
         ebUYJl33+PnI+4ciG36J4DNzwaJQijQ3zt/KuUp3FvD6iqtt4Lcy26Q+J+QIq7c2wScR
         YQhCMrenamPDwHOGZMDPFAEc5ztn0cwYPb+vdtIiMJzF1oohHls1RAdWkRmpW+lO2Nia
         kE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284994; x=1715889794;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7kj5kZHOgeTEFE9rl1cg+M+RfV2lbnnrAzPZA+2Lqy4=;
        b=bvWMIle5Enudl9WeUnIPqmTiTBY8Rxo6xp6kuaL/wk7oE9oQasjD0RDfDRigljyqjz
         D1t2PTqKLHthEO1hHRjjcDEHrhznGHGDLBFmknAg+wVhzPxSDiUL0uYuFwzkK3xSIW0j
         A5n/7+2BxFfOL1ALM2H09bIlPVt6x86B0b5+VbbVwzxGnXCcpBgk2hPZOy6/RSkH7Swn
         trfKCWyk46EJWjiPuDHcqHZlweMMka7zsaDKZJt+8L3PdhpUtsz6eP79ZTT6nAJQoDoN
         p1tU8euCGyfxtz5c8aeuUiBaMX6tRKR/F33ZcqhHATvGpDaihG6OLxS3QKSFEA8LEEk7
         nlrg==
X-Forwarded-Encrypted: i=1; AJvYcCWTtKsg3bgkzQtNm1PQdX6DNMKe6D0VylGGQjPIZgTWquKBogADyx08kCwNbB2pKRAzb2B4hmvKApI6MV5cKoh/W44U
X-Gm-Message-State: AOJu0YzRlqlLsWf37SdV8x35uXJiguw368o2NSTBaO5xmAMkO5VsjRkJ
	jcq+ywrJg++IW7BD06Tc7g1EArNwEGd1ucn35bt+bMRGQiL+DujlLkDHWPwvh6JmdjmyiO1pP/P
	x9g==
X-Google-Smtp-Source: AGHT+IHAGY8ymc83X4QYeJVn87tCufTNrw9Kmu80cCJPzOsgO8hVIGuL67CoY+OKX3uI1QLyaTTUJozyG14=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:982:b0:6ea:bdbc:6b5 with SMTP id
 d2e1a72fcca58-6f4e029c2b1mr1517b3a.1.1715284993800; Thu, 09 May 2024 13:03:13
 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:41 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-50-edliaw@google.com>
Subject: [PATCH v3 49/68] selftests/ptp: Drop define _GNU_SOURCE
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
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
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
2.45.0.118.g7fe29c98d7-goog


