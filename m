Return-Path: <bpf+bounces-59847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B82AACFDAF
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 09:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86F23178AC0
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 07:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6054E284B26;
	Fri,  6 Jun 2025 07:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hTn7fSfM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588A87FD
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 07:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749195978; cv=none; b=JkMUaowEjuknlKlgIaIfdFtM7uzdDMfZNGax/lJe/xUKnor3gHg2J0EsMDOTzL9cPHXXS1QR2OiYKInDzLFVbJPF9citegaZtxbfbyhgZu4ZZBLJhCYnQ/mNjYLu4PNSRWu6OjH2lg6Z8nsdnVyvV/wyyjuGJojP9IULierGczA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749195978; c=relaxed/simple;
	bh=zxhhXvbdZbCu1z2+3cxlSWIjevJNtlZONrlQxRT5V/Y=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=Vlpz9isVhK3crYh54NpIJ7dX7PTbS9dKE34ryPGgoRXIXzj7t2XUC5nGgvv0QlbMtglVxj1lRh8MK0fg1F0WIMjrWDeS3y7tpGi2wDX4iWDQp8DZBj0q7du01P5U8Mr1TKytL5TMwZBNZq4Ji2hA0UXmYUbPSAnRPnSe55eb1mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--suleiman.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hTn7fSfM; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--suleiman.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e812e1573ecso1975679276.2
        for <bpf@vger.kernel.org>; Fri, 06 Jun 2025 00:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749195976; x=1749800776; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fDb86QQFDZ67qGN2jzBUfiGS3FTrxct7KMqQKbUOmZo=;
        b=hTn7fSfMgAQhcYjz9XepZZvLo9fmuWKRYmSwrqoWEC462DRSbvgcdxMC1nz5dojEgp
         T9z58yV8MHK69OHHNcVLN/AnxCCKS33qvPsVZK1bC5+x5Cgdt9yV5D2bsk5wK6X254dR
         j8VmkaNXGcpldBq6mrUujNTrIyl0BJrjUGyeBfkKm6YnGnBustc5xr07GiXp5ajViVkF
         Qsx0aqpRZ/jFTaAIFZa8104owyae2nA5czUG/h4N0SNK0ldsjlw3e7z5XlyiSSVH9YNW
         oCxR+9kWnn/rHZ3JkVWT/g5h4gulnPC2iOoEg/bEf2Wwv4TMPfYkssVEGVJjCBcSb3bG
         KISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749195976; x=1749800776;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fDb86QQFDZ67qGN2jzBUfiGS3FTrxct7KMqQKbUOmZo=;
        b=sq7XG5lUa7/mmneUPlH02FNQwRcv2jnaBZOvao9feAtkJidfafsycjLvShtjYe5x0S
         UWgOFjPBMPpx6BSnPczI03cc3ifC1hBuFGqMRSHVbt926rYoXh97WU+TE5AXL5fOqOIL
         6RAjOLVtqCKSv9FDYVUc9Ue1hIQvw62ng+34s0soNNfd80uDvaK0BhVPUA8orFyjbk1q
         cBN/Dcw3MuOQzz8wX16HoeHoIqtkEtDX1VfkhfFINzSP0h3QHAfh1lK3etRMpwPJe+jp
         Gamk0E2k0ZSwLGb+lbkTgxUl/0SaqxujMEVMQKafno2VfNQDmsGLsHf0cZW7ZKvodBqX
         3A4g==
X-Forwarded-Encrypted: i=1; AJvYcCWtFJHLZTcvgA6x77KDxCfibcPoqc0Xa7iLV7vOn66mXw5evFW6Y04ElvFhZ1qYhAvXp8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGood+Pww9uJ67aMG/9DwU7PBW9taCPRr7yn/hKLoLFvhKUhpv
	k2puD6807uwebwhvSskgc9uF8UmiVkfu/63VY37r4yI5s4XBEAhPW2SgArKbxrvgCjWKh2Bctsl
	smZrKLmU9fyTtbQ==
X-Google-Smtp-Source: AGHT+IH+HJN97uPX2uu694TyMCiKt4EYYDjBk3XYUFywUveQC2PD8RJ0D052YFob2qvP84EDcApZAKpKIrwBUg==
X-Received: from suleiman1.tok.corp.google.com ([2401:fa00:8f:203:b09c:3d84:6735:a65])
 (user=suleiman job=sendgmr) by 2002:a25:ddc7:0:b0:e7d:c11f:897e with SMTP id
 3f1490d57ef6-e81a1f908demr1440276.0.1749195976189; Fri, 06 Jun 2025 00:46:16
 -0700 (PDT)
Date: Fri,  6 Jun 2025 16:45:38 +0900
Message-Id: <20250606074538.1608546-1-suleiman@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc0.642.g800a2b2222-goog
Subject: [PATCH v2] tools/resolve_btfids: Fix build when cross compiling
 kernel with clang.
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
CLANG_CROSS_FLAGS when preparing the step libraries.

Prior to commit d1d096312176 ("tools: fix annoying "mkdir -p ..." logs
when building tools in parallel"), MAKEFLAGS would have been set to a
value that wouldn't set a value for CLANG_CROSS_FLAGS, hiding the
fact that we weren't properly overriding it.

Cc: stable@vger.kernel.org
Fixes: 56a2df7615fa ("tools/resolve_btfids: Compile resolve_btfids as host program")
Signed-off-by: Suleiman Souhlal <suleiman@google.com>
---
v2:
- "Signed-off-by:" instead of "Signed-of-by".

v1: https://lore.kernel.org/lkml/20250606052301.810338-1-suleiman@google.com/
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


