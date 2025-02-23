Return-Path: <bpf+bounces-52263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B984FA40CF3
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 07:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1910D1898470
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 06:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B151D7E47;
	Sun, 23 Feb 2025 06:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvnS/cHU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D1B481A3;
	Sun, 23 Feb 2025 06:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740292071; cv=none; b=Ip8Q6AA3Y1siQPyJHMV+i65HRgw78egAZz1UE4SxQpf3J+Renr0sM3c1WlB9ALoHb25dqGLG2YE1ZnBJvcuEaoSI8WJdk5RuRal+ajBCV/EyAWbw1+sdsC5AaVcqjKFzoIPgBlg3k/6ZnyNos5izuErGm9wFLqpe65/EVBIaTXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740292071; c=relaxed/simple;
	bh=34+Kj0pCYupbe5FnIaNBsFhcirzueAWu05iXRUJLFCI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F2b41bi0EnM9xfJ/5OEVlVYqtFfG5qlsShx/jH2btB0TNV1Hx4z06boJ/WtAJXsrjdLQr8iYVL6x5TKb1eMwjQYVc0MXicMcl23cXdIrzswKD9+yTR10tfxpJCa5dVFpLVAZ+6C5Fotbzy1/zRt2RKSN0BYT5YqplMe4DDosEN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvnS/cHU; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fa8ada6662so6964541a91.1;
        Sat, 22 Feb 2025 22:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740292069; x=1740896869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d43WQ4KuUrq/KmTXmMr4T3J9Doo9C9jfnt2R44K/1Bc=;
        b=kvnS/cHUEBKKNtHhRrwY98G1QVK8T/NK67PjiEO+FpJLT0PIKRUEu4i5Ngxbo1A19e
         jJiFReMGaoB04C8JMrU2EdXNiDyu6++DNaAn1Ak6X3+LfjpzfOu7jK7Vfj/ZcqlHWAGu
         FGKDVdlbMe1fIywNZw0GHWMjwXUOIQAbvdtPnpnovIcDInEMfQq8tpjXCVKyd9KNddZc
         F2x4BGw4Yo6ritgdxI90S1uwuf0Zp6sHdaCzRCRElAMGXW1ZpYsDdVdVXNWTun7c60zv
         lBLVTFT7Ogc6D5TUHAaDrbAGB2YPvuKoSb4CQxFpmWbZbD4JG9Pyoj/abeSX8NLx4i93
         eYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740292069; x=1740896869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d43WQ4KuUrq/KmTXmMr4T3J9Doo9C9jfnt2R44K/1Bc=;
        b=r5NVtKjBIgeDbFe9UBkd/GApxpN13Hk+kgnu5ABSXL9F++rb0aoY+dEQn9mes9y2LK
         gKXMPGGVZWdzIL9JmWAISaNm1hUepxJIszfXuDgcR/6pgRKlBylw47urrMP/+1bMNboG
         48SljDE7X0RsMY/nO7fv/3OuZq2WiRcNLpy908Bkw39QY+6O7UtaponJ73ZNOiFPtqTT
         RuWuCjUtdEaJIUwmErS+Gri0teIagyP3FP+loNjO1jnLMqKh8guRc243okKQLzqcPCKN
         zS+CVFB86XwRDuIItWPWfy1So/MZ/zitGn9IyDmSjldu9wVpgb32YeaZlmVcdmcLYaeS
         nIGw==
X-Forwarded-Encrypted: i=1; AJvYcCW/kMCPF280km4znAeuN5K8ZL7PtAcilaJS4XrIf4SpF/aFvPasFB1BWwlQepXi7+Ntc3XYuhMo195KrZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRtpDQy7dQ4PyUPDllZCsMDRn+qg9YsGp4aa4Q75ggPiEaiBOa
	g/uVzNN9UvNw/ili9ypuX+uHBDjkRPVOHMt3gcUq+qtGRaVmSxig
X-Gm-Gg: ASbGncsDtkEo227V5f5P23sF7NPppTSScE8bCYuzA9tG+mZL/3BKmoiU+tWBUmkXgXi
	KdgjbtM+kfk61KBZwmRCvHfgObT7HjXAiZ+BVEibRbf/0ahD98wteD0UM8MXfB1WIAwYiNWvY7X
	n8doaxZbkVN2frHKp+XIZNKpuikBo8lmziPgNv1ZJhbdYz70HmGkpRE6B7hSgADWEaibq2VANou
	H51sOfSchOKcXIBMkNDzQh6+G7260n/fWzVAPNTM2VIfGrQBARiZNDiYbvITkdDxLsYkvd8hUuz
	DLd3+91fj6gUpParzXS5o9uZafuSkOhht3/FUwoEV45mWST+XuM=
X-Google-Smtp-Source: AGHT+IEa05i0QQpMNhepACEnwcadkQdmRtq3OE3C4Ae3LadAi+GmdtQJfFuXZ55hT3stycAVznzypA==
X-Received: by 2002:a05:6a21:3a93:b0:1ee:d687:c39b with SMTP id adf61e73a8af0-1eef52c9910mr16640164637.7.1740292069442;
        Sat, 22 Feb 2025 22:27:49 -0800 (PST)
Received: from localhost.localdomain ([39.144.244.105])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732521b82b3sm16693128b3a.92.2025.02.22.22.27.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 22 Feb 2025 22:27:48 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	jpoimboe@kernel.org,
	peterz@infradead.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 bpf-next 0/3] bpf: Reject attaching fexit to __noreturn functions
Date: Sun, 23 Feb 2025 14:27:32 +0800
Message-Id: <20250223062735.3341-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Attaching fexit probes to functions marked with __noreturn may lead to
unpredictable behavior. To avoid this, we will reject attaching probes to
such functions. Currently, there is no ideal solution, so we will hardcode
a check for all __noreturn functions. Since objtool already handles
this, we will leverage its implementation.

Once a more robust solution is found, this workaround can be removed.

v1->v2:
- keep tools/objtool/noreturns.h as is (Josh)
- Add noreturns.h to objtool/sync-check.sh (Josh)
- Add verbose for the reject and simplify the test case (Song)

v1: https://lore.kernel.org/bpf/20250211023359.1570-1-laoar.shao@gmail.com/

Yafang Shao (3):
  objtool: Copy noreturns.h to include/linux
  bpf: Reject attaching fexit to functions annotated with __noreturn
  selftests/bpf: Add selftest for attaching fexit to __noreturn
    functions

 include/linux/noreturns.h                     | 52 +++++++++++++++++++
 kernel/bpf/verifier.c                         | 11 ++++
 tools/objtool/Documentation/objtool.txt       |  3 +-
 tools/objtool/sync-check.sh                   |  2 +
 .../bpf/prog_tests/fexit_noreturns.c          |  9 ++++
 .../selftests/bpf/progs/fexit_noreturns.c     | 15 ++++++
 6 files changed, 91 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/noreturns.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fexit_noreturns.c
 create mode 100644 tools/testing/selftests/bpf/progs/fexit_noreturns.c

-- 
2.43.5


