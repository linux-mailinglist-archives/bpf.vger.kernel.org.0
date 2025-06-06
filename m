Return-Path: <bpf+bounces-59836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0E3ACFC2E
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 07:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7683B188B74C
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 05:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BDE1E5B95;
	Fri,  6 Jun 2025 05:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yfP10EHU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D371D88A4
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 05:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749187437; cv=none; b=qwmGs0Xy4GzmGnl2Fp+wO5oapRiYRhz+sa0SWB2XaRQ24zL3NIhwY70yBkS+Ax1BnhbfJFKAGbFL3gdwdg6IX0EBqJbFSah29sXuo4yC2fYWYXWHzhhekO6CXclIg0A+2FARsvoQ02tAI6yDHCB6DP5jvyTEQEwcwR8KN984y3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749187437; c=relaxed/simple;
	bh=0LcugX7pIJqi20ylrFfW2GJHIIOk7YhX5V657AkjHuo=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=DFu4xzyGbpOQ7GAMOZhBiIWgp/qffEcex0xE6k1BnPCS2XIdQmfrPpuLg8KWcK9Wo5dgQrAs5nSnI10mdyKVjS4V/x7yxApyWsLKRdYsuY85DyBU0CoSB0RKtr/amoXv6woK4ottqISyLFDosL6+flLCccLhJ4GlA3H8CnKsYNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--suleiman.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yfP10EHU; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--suleiman.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-70e4269deb2so20512537b3.3
        for <bpf@vger.kernel.org>; Thu, 05 Jun 2025 22:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749187433; x=1749792233; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xPdemEaGJWvzsN6Iuk80gCcUSIvsiiSoKmwg/dFuW0k=;
        b=yfP10EHUYSptf3vTvQpLzrWk6SoM8dVGsCjwcyPEPo1u9ALbLCd5EXvrwaXwKRwYYo
         QlI3UZwO3ik/aXEoFohb0r+fmmx00W5sv8f4KwPHaiSfLFHjxB/92F12jGCeRfjbKqWZ
         IB4U8j/hh9hYDPt0eumUIed+UIcuK+ZtXcZTEttc1jJQmY/nTlcPqNPtLxT8ovD59lyU
         aHuj/jIuX/1EvpONMGuWMpuIShkjM2gtvXHZScLLDgFmyZtCQxI+1QxbheG4dRt4OlpD
         uAEwS5eMPbNv43LUyZ1QcgbqHK8JsQUSMN626nNs8B+GoE0wV6R5xOGa41diDiFYybm4
         z5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749187433; x=1749792233;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xPdemEaGJWvzsN6Iuk80gCcUSIvsiiSoKmwg/dFuW0k=;
        b=GNtPG5Dmy/ERPqfSkIb1aW2l+6+RbvHHE+NUEOXcB0R9h7rvT4pI8rhpbpT3LRmEYO
         luVaikSCwT3PdbKK3a/eb0np+H1Tbez55ggen6qlvtxkCVCehsvsOzmV78SrBF7z2AXc
         dPMaCdllGLKch4yX3dH9mGq3Sk++kuPOUTxSqLdLh8fzaYz1ik2bbER5hJVyvpgRoKDk
         q4mIP2cCMSRvuOdurzXrHSjTsFQABe/BsiUaAkIBLVjWV3nmIBnULGP5d3e9Fe6iXW/B
         UCUyo2/itcF8XRv0sKOmG0eyLVut6muqS1ITLdT+negJ7GnscLmSSRor4Af9FGpfblBq
         tS/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVCPt3IGuNqxFZrJJKwVHAJpSeM3mJLm7UAJk5WsKwJeSi5udA0E7YmGNwK02cnzfsPbzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpvhgICXKzOcBo8kxo9ppLaOasD9QjQXlJAd/7xHpUe2Zg1fPL
	7aU2XthINIMblImgs4vAnHu0a2M9L5t4psotm2qbQSZnTZ8Go1KVOLU8JyS4ryhCdD1xjANEgV+
	3fYfQPAAeelBcmw==
X-Google-Smtp-Source: AGHT+IGM/2zgkKAi8l8Bv5Y3g3HKlCcWzySlnqdZP8vCaBlczO4XnsaCrkzqSdd8WqbJpXkzwLkHLILC/I6frg==
X-Received: from suleiman1.tok.corp.google.com ([2401:fa00:8f:203:b09c:3d84:6735:a65])
 (user=suleiman job=sendgmr) by 2002:a05:690c:8e0d:b0:70e:458:874a with SMTP
 id 00721157ae682-710f7533fb3mr8927b3.0.1749187433661; Thu, 05 Jun 2025
 22:23:53 -0700 (PDT)
Date: Fri,  6 Jun 2025 14:23:01 +0900
Message-Id: <20250606052301.810338-1-suleiman@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc0.642.g800a2b2222-goog
Subject: [PATCH] tools/resolve_btfids: Fix build when cross compiling kernel
 with clang.
From: Suleiman Souhlal <suleiman@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Ian Rogers <irogers@google.com>, 
	ssouhlal@freebsd.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Suleiman Souhlal <suleiman@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When cross compiling the kernel with clang, we need to override
CLANG_CROSS_FLAGS when preparing the step libraries for
resolve_btfids.

Prior to commit d1d096312176 ("tools: fix annoying "mkdir -p ..." logs
when building tools in parallel"), MAKEFLAGS would have been set to a
value that wouldn't set a value for CLANG_CROSS_FLAGS, hiding the
fact that we weren't properly overriding it.

Cc: stable@vger.kernel.org
Fixes: 56a2df7615fa ("tools/resolve_btfids: Compile resolve_btfids as host program")
Signed-of-by: Suleiman Souhlal <suleiman@google.com>
---
 tools/bpf/resolve_btfids/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
index afbddea3a39c..ce1b556dfa90 100644
--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -17,7 +17,7 @@ endif
 
 # Overrides for the prepare step libraries.
 HOST_OVERRIDES := AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" ARCH="$(HOSTARCH)" \
-		  CROSS_COMPILE="" EXTRA_CFLAGS="$(HOSTCFLAGS)"
+		  CROSS_COMPILE="" CLANG_CROSS_FLAGS="" EXTRA_CFLAGS="$(HOSTCFLAGS)"
 
 RM      ?= rm
 HOSTCC  ?= gcc
-- 
2.50.0.rc0.642.g800a2b2222-goog


