Return-Path: <bpf+bounces-72198-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A284FC09E9E
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 20:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4F01034D9CD
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 18:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048A0303A16;
	Sat, 25 Oct 2025 18:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eATwI546"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B632FCBED
	for <bpf@vger.kernel.org>; Sat, 25 Oct 2025 18:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761418185; cv=none; b=hFpG72qDN25aUa5YCdtRPXNF1hMB+ImrnBLvkkT2qQRSu3LpuBifEoBtT2k1XiAI/NhkAY1q6eahPS8bOPhHHIReBlqK6MTHvXtxZyztb7AcK9oieZAwdDJEwsVp645h98CbOrFagAoOYAwBcAOdilpMrEA1TpJgp3FbLyN4PFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761418185; c=relaxed/simple;
	bh=3jV0KfbqyUjr6nh2vaI4XUsvRoHBlT0uhCZEnBsgLUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L5YhWIe3x4yUMfXYgOwoXAe2jfsqWjWYreWMBXTv02VX+ig8WE80g4fM1T3qV/VCvrm8ZuYl5R80oURZ2/YLBXpjdByh0JxNvyYNSwo6RBI2LXj8tToL1DxIaZGpNzUWuwx46pvuhS7KndrlwA9RNXbtkQvONyjAvdoqLURwIAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eATwI546; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-290ab379d48so30177065ad.2
        for <bpf@vger.kernel.org>; Sat, 25 Oct 2025 11:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761418183; x=1762022983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MIRvzi8j6zwlZeQRUUP2B9p5LHiwZA8VZKiF7rQQGE4=;
        b=eATwI546hyMk4GmPjV99wT5Khcsf31Shup7XZmZ80FgNskJgBeltLj+C4Scngud0Kb
         eDD8L9N4+Tbxh/DaEFxWsqJtt+HYit+4spTTAkkxXJEpf5PoZpWi8CBpDVrtGHDO2z9l
         j+pKDe4fxM9tZHr476u6zbT93c6Aeh6XwpxLgdysfrA2btUH03LcwI6Ucd1Yu3nlIiiZ
         /gySeCShrSneBdT7PI/+zd5fDoONqFaV/MvMmooV+2oIhBSMFSglLRAlSWVLf588+Y8z
         Yft4jCs/ei/cc0TFYUCxvad5/EPhZDdCyWoDm5hR2+HuNhYPIJ+LaGQdHJuare79M8v0
         v2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761418183; x=1762022983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MIRvzi8j6zwlZeQRUUP2B9p5LHiwZA8VZKiF7rQQGE4=;
        b=C//FC08o6sp2E810ThcxjYgJUK5HKm3eEMetXa3DxHch9c9t7kWgbHgGmsViR8Uraz
         0pqjTpE3Tw3fXKvvnGixWZMEKu8z6DRB39mw1xXGS5IoOH6Tr4eGpPutoBQ9yZqeq3tS
         PpqvbVNSSaNBxbpnNAUDW2XC1vgTSBzU/OSU/sLUqP2g7+7c/Qgk3BYBwRPaLPma9hCz
         AyYipElxY1uV6+grpTFVF+t10dAqE1MIun3wgXX8hp2qFntPAPYF/Tlu+vRkdnXgZ+RM
         doypr3nW/xRgyeb+2u+0+QgIehORKjbyFruHBroLOdfQkC6ESfQ1VPQDJ8R6qv3s6Imj
         LAjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNTiko0N7LJnRyj9z5LnHe4g2iZNdd66ykjDkX3zMy9F+mDdhmdXvp1JL9Cj7P5Fo2IUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsWt7Uq0xk1skH50ApNOM7BMr4xZ6eztb+r3sXJAt+HU8VKpeA
	t5UqusWsZv91NU5Bk1Ac9lbXTdwX50nTF6rapDsNCXgk5TPznyMq6fCs
X-Gm-Gg: ASbGncuNQKdulDnLAX2NCK5J8YLZzUwKZX+6wsCN5rzew8wdTmBdZ9uq6nnKDRIrx6p
	F8FZyriybHnqgTm1eEjkHtsqYFjrym29nXBsLe6JixZjsszWXyR4xxx5WbSftiIxu0oI/lUAxfo
	qQY5nSuro8NINicS4TSEUAJC31MD//C0YmKoTNOt0k7IyXQ4b+A5LbrUnLdtF541ADDPjEoA+xc
	M8rGfSl/JiXBeHsym41zlVCRF9ZZxl76GiZpnw/CfgeNFPZ909bzwJsYFCcURsyuDRDj1Nmpabh
	UYYttIOIzOPCWrGhXsRRY4UrFPHm/9mBQPc4rwoQ4HYlEgUQ26c6LfmiRbp57WcpPrVeqMDO3No
	0DzPWBNah/07eNxAoOWfuht6ejniPn/uxhIzw+Hu7bNAsc2l2m+yRMkkFuBAhrBH4/FXDHg36jp
	t/G3jYC3d7mUfbkeXOgf6kXr8yYu/JMiIfs8qHulhLJMn9DSGPUMyfvk0=
X-Google-Smtp-Source: AGHT+IHAiMH9JhYQraNgPguxjgZGjEFmFQTsB3vEnaOVZ8IpIk6BfW2plHMfNLdpmtJSevEWDj22Og==
X-Received: by 2002:a17:902:ccc8:b0:292:64ec:8f4b with SMTP id d9443c01a7336-29264ec9336mr315255035ad.43.1761418183223;
        Sat, 25 Oct 2025 11:49:43 -0700 (PDT)
Received: from prakrititz-UB.. ([2a09:bac5:3c3f:a82::10c:1a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0996esm29589375ad.28.2025.10.25.11.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 11:49:42 -0700 (PDT)
From: Nirbhay Sharma <nirbhay.lkd@gmail.com>
To: Kees Cook <kees@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	khalid@kernel.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Nirbhay Sharma <nirbhay.lkd@gmail.com>
Subject: [PATCH] selftests/seccomp: fix pointer type mismatch in UPROBE test
Date: Sun, 26 Oct 2025 00:19:04 +0530
Message-ID: <20251025184903.154755-2-nirbhay.lkd@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix compilation error in UPROBE_setup caused by pointer type mismatch
in ternary expression. The probed_uretprobe and probed_uprobe function
pointers have different type attributes (__attribute__((nocf_check))),
which causes the conditional operator to fail with:

  seccomp_bpf.c:5175:74: error: pointer type mismatch in conditional
  expression [-Wincompatible-pointer-types]

Cast both function pointers to 'const void *' to match the expected
parameter type of get_uprobe_offset(), resolving the type mismatch
while preserving the function selection logic.

Signed-off-by: Nirbhay Sharma <nirbhay.lkd@gmail.com>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 874f17763536..e13ffe18ef95 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -5172,7 +5172,8 @@ FIXTURE_SETUP(UPROBE)
 		ASSERT_GE(bit, 0);
 	}
 
-	offset = get_uprobe_offset(variant->uretprobe ? probed_uretprobe : probed_uprobe);
+	offset = get_uprobe_offset(variant->uretprobe ?
+		(const void *)probed_uretprobe : (const void *)probed_uprobe);
 	ASSERT_GE(offset, 0);
 
 	if (variant->uretprobe)
-- 
2.48.1


