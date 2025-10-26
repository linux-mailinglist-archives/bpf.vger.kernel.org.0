Return-Path: <bpf+bounces-72214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06180C0A542
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 10:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C1C33AE186
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 09:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE83288C24;
	Sun, 26 Oct 2025 09:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SN2KKfDs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0A91F418F
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 09:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761470001; cv=none; b=FgYwjqoBN7Moa8O19QxCgBDowkwgDvPyrZhivmIfrepwvl+1ziDY2M3e1nZ9bKKxrQufT9j6xNdQ56gieT45EGqIPDjzoTm6TCPpc7uEpIGzU/6EGHiFOjWCLGyuQPCLiN1Us2ArR4e4bUq43sD/5wnCs2Y0l0jiQ1/laNWVVu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761470001; c=relaxed/simple;
	bh=5b5PYMxopEb8YY4FdGelcJUO0Yvn+/7BT0Giy57xNWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ejKllYx4QMQz2FCGHuPB495+0XiU2YutWAYsSEK0TvM21jyGoocaPNTY+f0i3wv6Bn3y9LFQ0Gyd5+EJWKV71j5qFV3EKAiZQ71My12AQ7O41fwWE1YyZwl0qISfaEgkcQyo2qhY9kD1TCfAnJYWNJsMkIJgfdv1IskQ+b7DOPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SN2KKfDs; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-33255011eafso3410322a91.1
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 02:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761469999; x=1762074799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMX23+YLvbC4KKYE3owkIF/POC5qa9l7q+YDn+rGhBs=;
        b=SN2KKfDsQkeTqdseEQyG/hCI7cTwgkEZdcfVDhayZ7m0K26eYWv62CVqOEhqj8S6GH
         y3symXdmxE0YzyqQW1Ti1PAHRB+GHkK0kZa3HbLi3CVtHlPkMHfPg6Kqz43mvLXaIzHF
         MMkTRx2ehLRvXhuO4Tc784kYtE1pX/xhrGrWmoMEXTeDEX7Rledc/GbVFqAqOjoo4aui
         bqdcjmMetRx+BbiPX+gAd2dsd4/EVNlV/YsAf4OvdBXKEmL7zugyp6Q75Q/QVU12cqfJ
         gEAta1gPws2MZSIEgn4E9Kr3r0GrpQdk5sDzDxZiHaxSMli9pVeUlzAnpqDV+K/nV47D
         eo4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761469999; x=1762074799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vMX23+YLvbC4KKYE3owkIF/POC5qa9l7q+YDn+rGhBs=;
        b=tHUWhvzpIgiAkNl8BykJB3K7zpEoCS6z1pK6bj5wL/oUarfoWNMTaliAnPgWeTLlKh
         9EmjH+AJeuDt3S2QHCjmeU7lJ+pIWKR8LJWb4xIA2R16i4UHTAOzH57atWn0xmaZQpYn
         Pp2GOV07cqfe7ckVktHp60bxuswu2bP0t0kq4RJWmtPx0EauWvFrpHzLeCWWZMW/YiHw
         CUKelavGlVr2aa3EASkQ9p6BoN4zb2diSxk7MW8QI/jW8gwhybs+xzGhriAdw9X527Vf
         BiW3C5u9nwZq7GaSysKz4nzlzsIlhbFz1Y26DcYsPhaNeViPW1Ws/mEf1gvbW09VBY9D
         /3dw==
X-Forwarded-Encrypted: i=1; AJvYcCXbQjKMG9lZO9QBMau7bkBJRSwrQrvMS94S2YyvMexVt5VH1Rrn8cpy03pbygpsRuirEQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR4o089VamTm89CEUH4VsNpvuQi2Fu/HhAZ+1z6xft4tX4/rwP
	rqioTfUDKi18w54FYHUUS+XCbtgnSzkHtmmMRiCEPxrfeth0mHaGnbjF
X-Gm-Gg: ASbGncvuwFMYMsqFzvnnVoCMEIyUobIx0ZFPsEPWT9vdtahhCzAYuUJ4PV8kYaPAHF6
	SkwkUzGla0MikduP0dvP/tg4PYVNh7HWMeV554mftDjA0+tcshvgbuDZ3EevscEKT+UmgdupqXN
	e41iWUwYprKEhY4mQ6zxSVzFrlFNei1YEQALtufDxQA6V2SmwK2Dt00vsp8i+8j7Ghhza6cC7dj
	yL+mAM5cp4oFShzFsakpRh6pMWpzGfq42qAphEDwZ1J3Ug/HnNyI3H7rwVnuZK6eqqRZC/HDcJ3
	hkytfRFw6aBdPe2RHrOLOLQ9hm7YI/QpgLScZgOgEQOBXBUC+DKL+2m3N3h3AoonrTOcjokSZ7x
	oPhnDw1I9ogf6kYDWTO5GOCFxORRP9NoYyt19tGkzYpxlcF0Ep+G7NS9Z4+ASrf5aK+PoXsUDL8
	dy2saKeu0xbBvmv1u3cI22xuK4/dKpzBdPCD+v+DLOHs+YnhXMhRStMfM=
X-Google-Smtp-Source: AGHT+IFQFXNUYIY4vSpSr/xv31CBewG848HOy0cOfx8lxhYhMoQ5KdF68P3/KWEwPTs9NKzCL3WWXg==
X-Received: by 2002:a17:90b:5386:b0:33b:b308:7655 with SMTP id 98e67ed59e1d1-33bcf861fc3mr44925100a91.8.1761469999250;
        Sun, 26 Oct 2025 02:13:19 -0700 (PDT)
Received: from prakrititz-UB.. ([2a09:bac1:36e0:1c0::10c:2f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a42aa5d9a6sm789558b3a.62.2025.10.26.02.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 02:13:18 -0700 (PDT)
From: Nirbhay Sharma <nirbhay.lkd@gmail.com>
To: Kees Cook <kees@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev,
	khalid@kernel.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Jiri Olsa <olsajiri@gmail.com>,
	sam@gentoo.org,
	Nirbhay Sharma <nirbhay.lkd@gmail.com>
Subject: [PATCH v2] selftests/seccomp: fix pointer type mismatch in UPROBE test
Date: Sun, 26 Oct 2025 14:42:33 +0530
Message-ID: <20251026091232.166638-2-nirbhay.lkd@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <aP0-k3vlEEWNUtF8@krava>
References: <aP0-k3vlEEWNUtF8@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix compilation error in UPROBE_setup caused by pointer type mismatch
in the ternary expression when compiled with -fcf-protection. The
probed_uprobe function pointer has the __attribute__((nocf_check))
attribute, which causes the conditional operator to fail when combined
with the regular probed_uretprobe function pointer:

  seccomp_bpf.c:5175:74: error: pointer type mismatch in conditional
  expression [-Wincompatible-pointer-types]

Cast both function pointers to 'const void *' to match the expected
parameter type of get_uprobe_offset(), resolving the type mismatch
while preserving the function selection logic.

This error appears with compilers that enable Control Flow Integrity
(CFI) protection via -fcf-protection, such as Clang 19.1.2 (default
on Fedora).

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


