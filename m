Return-Path: <bpf+bounces-37828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C1195AFCF
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 10:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56FCC28454A
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 08:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F781581FC;
	Thu, 22 Aug 2024 08:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PoJ55J+H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAC519470
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 08:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724313701; cv=none; b=XN2Ag8MXb+y9yVCCGHi2rwZKiswG7fROj+ty1ztiCQeIHZEBdjecBMzw0ZH7ncGJ0IAJTnHlbUSIUwXqJEbE9Y+sMIjJzX4RTkZM8mEyj4yS9i0V17eFYcgYCRg7kbjaGv3m4walLrMFyNMtyLGr79YoAHNyV6VtwqZX8TTJ5rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724313701; c=relaxed/simple;
	bh=FioVc/o2eVlmgDKt5M99GVhWNZKj3coOH1Ghqn/et+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XKmLykU1z6fbDf1egfYdR+Bu8kL1pawMia6DCCaJP8Kgxw0Ue6VBkfAExXqAT8tbzvm1hjnl66wN0oiFUJzVQJz+41RmvROYTQ5+Yuk6elAdCi3nUJRSrD5nc11XE5OpqyvM5XJDSMzt0dODFV3QvmHmUopAjC7qByGGqKvIm7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PoJ55J+H; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-201f7fb09f6so4518805ad.2
        for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 01:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724313699; x=1724918499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GenayWP6YDQCL5mtrCbvjr06SN+1cK3lYLmBD1rl4UU=;
        b=PoJ55J+Hu2+0x9rr3JghzMM5OFsiyZ7S6z/ExLLuUQ9LQIqCvFJAlMnRFYedJBgmwd
         KBq04QzWubrBa6WYiedwCLWZonQp1D67iluC9XfQBJd2wWy5T25EjjtAnH9XL5trfbfn
         BYkb3B0Y6gUwdJpzoP6K9FRtreS1xEf2cBfctE89fQRAnO411eNolXRpX6I1iJ/29pYQ
         Y9+8uwVe23vdHlmk70y2UVm0hr3Sb+AIqUZAGt6GfFQKB+xLZoWHeNBAWCD29WCTdtHs
         taL+OZlNJDFd3N9iP6KFm9MDhU1+H4mW5S7J8IB4IOiLHL6d3ooMVOACoKObDi+/9DCx
         cXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724313699; x=1724918499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GenayWP6YDQCL5mtrCbvjr06SN+1cK3lYLmBD1rl4UU=;
        b=E31KQvtjVcFwVnjAlbWMHvY2mkJMFDR2SpEQa9aaQiQaYldPmH41QUzKswsJbOpzA1
         ycTGdAFw3YVVKrvwWQNw+QU4Datw1XuMhFujPKwZJMKSJBHVQ7Hi+E1WINUk24+hTcWi
         0KOT0Ime2aiIBTkr7m7W/qxnESzlrCjroPTcWUZelNrDEip3i7AaEJsAeoDYO4LxPVvW
         qzZC9CguQnRGYC5jB8vff02/PJeNEq7+cgAvIc+amSJlGMHrootfGdJAbNr8QJfRBZZu
         N6HELTKc+EFmC1eBlOctkyAqvRfeLYPeNnbg8YZCF5H6mXqNUNHmbj+wDrYKHU36VHt+
         od2Q==
X-Gm-Message-State: AOJu0Yyso5rEaOd9oEcqnDLl/x7jFu6QtB3YGCtS6EyoYCoOeHq3Njbk
	oRr/bDxhGUUTJrFtXOV5r1LsFIubSXp0L4cT1Au5BJ0f5WQfTXOnMOzHAenn
X-Google-Smtp-Source: AGHT+IE3LzHWTGk1VVM1AB1mtoZ7LIo4Dzb+iFt/gfr3eh5+W9Ajyi4nzpcx1nBZMJLT0E0TN43ovQ==
X-Received: by 2002:a17:903:41d2:b0:202:435b:2112 with SMTP id d9443c01a7336-2038824f37bmr12266025ad.34.1724313699285;
        Thu, 22 Aug 2024 01:01:39 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038557f093sm7233445ad.63.2024.08.22.01.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 01:01:38 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	cnitlrt@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 0/2] bpf: fix null pointer access for malformed BPF_CORE_TYPE_ID_LOCAL relos
Date: Thu, 22 Aug 2024 01:01:22 -0700
Message-ID: <20240822080124.2995724-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Liu RuiTong reported an in-kernel null pointer derefence when
processing BPF_CORE_TYPE_ID_LOCAL relocations referencing non-existing
BTF types. Fix this by adding proper id checks.

Changes v2->v3:
- selftest update suggested by Andrii:
  avoid memset(0) for log buffer and do memset(0) for bpf_attr.

Changes v1->v2:
- moved check from bpf_core_calc_relo_insn() to bpf_core_apply()
  now both in kernel and in libbpf relocation type id is guaranteed
  to exist when bpf_core_calc_relo_insn() is called;
- added a test case.

v1: https://lore.kernel.org/bpf/20240821164620.1056362-1-eddyz87@gmail.com/
v2: https://lore.kernel.org/bpf/20240822001837.2715909-1-eddyz87@gmail.com/

Eduard Zingerman (2):
  bpf: correctly handle malformed BPF_CORE_TYPE_ID_LOCAL relos
  selftests/bpf: test for malformed BPF_CORE_TYPE_ID_LOCAL relocation

 kernel/bpf/btf.c                              |   8 ++
 .../selftests/bpf/prog_tests/core_reloc_raw.c | 125 ++++++++++++++++++
 2 files changed, 133 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c

-- 
2.45.2


