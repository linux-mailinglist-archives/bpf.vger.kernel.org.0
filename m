Return-Path: <bpf+bounces-34508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AB892DFBF
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 07:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AD641C22160
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 05:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8350B77105;
	Thu, 11 Jul 2024 05:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoXSc18n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81742119
	for <bpf@vger.kernel.org>; Thu, 11 Jul 2024 05:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720676735; cv=none; b=WzT2HwYWswKqFz9RHCpTlAl7T+E7IuAWJaZYjakYU2BWcQ/596W8PGLptd5LdLzBbXBE1nhPkSjU31ZW+fogNNNXb9UK4hvGXHqT3F4YXXHlmYpZ4VRYW7zHgT0kj8EcolDXX11ofMPybZBoRcBcvpmrPFGRq0xJypKIArUc+AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720676735; c=relaxed/simple;
	bh=iEIdGOumEJfP3+sdC6M1y0B1K5nO9dSRwLQM36x1Fyc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UXNjrZcGNwEpCJlWn5NjAcxhg/RHRArIy4UEIlBz27NB6qZp/klZedLbfFSvoz/yx/RlF539n01ySf3pAVA3QRXDJcEoDcSSaujMSUn5KyS7LTI9eH0c2OfeGggGWR5onQFr4PiLikiLj7FrAnh2BLURY46BG3jU5CpDOpdmYv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CoXSc18n; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fb72eb3143so3744265ad.1
        for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 22:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720676733; x=1721281533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SV6IKSdYwnUQ7YDbiT/7aOvP55S89L8KhqvGdvnTkNE=;
        b=CoXSc18neN7GSGDwZGOjR2EpNL8PiQVbjTjuT8QU/5TiA90F0W+Ai+Max85pnDhBfY
         p78ouDgNGxcTlb3mgo5Cl/YGQaml+CsZhJ3YZMcArlgljk2miMerB8FW1g/PFBB2o1dD
         hnKsH9mWJzhVZqF22K+fy3oo5C4uVMdLB/ELg9YGMWECfe5/Dd3rhsI5hWMOs+cJGSk6
         Tg5/qh95zeNRPeV+KqUZ6LwMEiMsn809jNFUvlIP/BbB5qROmncYF+xUf+YDZki7wv18
         ro2w7LesicwGeazMHF3ljZRlL317WSeeCjMaXPQFgi/f0t/BfIkX1AaheB2tiRCRlnE3
         o5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720676733; x=1721281533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SV6IKSdYwnUQ7YDbiT/7aOvP55S89L8KhqvGdvnTkNE=;
        b=wBzlGL9NKP2m99RPTq9cUokIZqIeJpQs2CaakVkfbxcZgbUkDeDd9XtTM+Kn7/VX/f
         k3wE5t/zT08jWeNOJvNgcpZeXH4WpIu5OXAihOfVfEoQCdWBkQgVZU5zaF2zPFQsy+AO
         saBhLxIPd/aHF9/Ewdn4HtHLvhBQuCiHKxmQB1lFMxXA9cSpfaSjA2BoUAJo253LCIDG
         BvbqHxF2rc4V6hZQJLCV1C8gaNH8TwBOhKHRVzAX/KMAA2TvBMPRdSNbaHU5hDrw5HyA
         lSV8+WBPdsqCvzLfeOrkJNEOx+/ZJrpHHlLPOt0zKNhqCkRyA6NDuky7mmyy0stH5Bmm
         EydQ==
X-Gm-Message-State: AOJu0Yxq6z2CNMjsRQW6A/cB2evt8GLEph/hU5QvyjayX9DK6D2FmXpD
	yrjCVudHeu02Uf3jjHoq8aERkupRpCXD3kMVwqS+M3Qzi6z9dtve
X-Google-Smtp-Source: AGHT+IE7irWg6PGdhXXNi2r0zv94WDZk3rcQX7ch/0BgXvquvWIxwSv55iw/a906mYsfSs/kvxUYfg==
X-Received: by 2002:a17:902:d492:b0:1f9:fe14:592f with SMTP id d9443c01a7336-1fbdba2343amr27109175ad.17.1720676732894;
        Wed, 10 Jul 2024 22:45:32 -0700 (PDT)
Received: from FLYINGPENG-MB1.tencent.com ([103.7.29.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ac35e7sm42152905ad.223.2024.07.10.22.45.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Jul 2024 22:45:32 -0700 (PDT)
From: flyingpenghao@gmail.com
X-Google-Original-From: flyingpeng@tencent.com
To: ast@kernel.org
Cc: bpf@vger.kernel.org,
	Peng Hao <flyingpeng@tencent.com>
Subject: [PATCH v2]  bpf: make function do_misc_fixups as noinline_for_stack
Date: Thu, 11 Jul 2024 13:45:25 +0800
Message-Id: <20240711054525.20748-1-flyingpeng@tencent.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peng Hao <flyingpeng@tencent.com>

When KASAN is enabled and built with clang:
kernel/bpf/verifier.c:21486:5: error: stack frame size (2264) exceeds limit (2048) in 'bpf_check' [-Werror,-Wframe-larger-than]
int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_size)
    ^

By tracing the call chain, we found that do_misc_fixups consumed a lot
of stack space. mark it as noinline_for_stack to prevent it from spreading
to bpf_check's stack size.

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 48f3a9acdef3..ba1bf742a33d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19791,7 +19791,7 @@ static int add_hidden_subprog(struct bpf_verifier_env *env, struct bpf_insn *pat
 /* Do various post-verification rewrites in a single program pass.
  * These rewrites simplify JIT and interpreter implementations.
  */
-static int do_misc_fixups(struct bpf_verifier_env *env)
+static noinline_for_stack int do_misc_fixups(struct bpf_verifier_env *env)
 {
 	struct bpf_prog *prog = env->prog;
 	enum bpf_attach_type eatype = prog->expected_attach_type;
-- 
2.27.0


