Return-Path: <bpf+bounces-60659-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7670DAD9A78
	for <lists+bpf@lfdr.de>; Sat, 14 Jun 2025 08:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2111D167241
	for <lists+bpf@lfdr.de>; Sat, 14 Jun 2025 06:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594671E5219;
	Sat, 14 Jun 2025 06:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLBFKUzZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784C91ACED1
	for <bpf@vger.kernel.org>; Sat, 14 Jun 2025 06:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749883304; cv=none; b=bbBKJJVb1Q6gn1mqYvpGDl1nYIUYdoGHpq4gcgbbY81g6JPwNF1Gy0KxId2Dexxl/MI/gkh8IzrLjrBarNy+AwK9f3/fiNhEdsxrVorUjcdrF50lf5ZMeaIMXcukKX/CkVDCGXExBWkHdjTFjs0aEFXvPxc+Kax68WF4ofSb/PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749883304; c=relaxed/simple;
	bh=RqtnAp6cBn8MUcGdrrhDD6lbdGABXYRctaH59S4LvzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Npm24RgBCq0kJyLIMTzQsWahqEy10M4FjKzJzgr5ZMe6VzaMoGh/VmKhrr9Zz8UYyic9uXjeoT5QaHv9kRbD4P9GL8XnckrnXqYDAdfTQqpjA4y1coGrJn/wuJlx5xlsIpjxWxNGZdqgwonm4YKiGvidsshFQWwfDBj2JnWpLSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLBFKUzZ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7489dfb7248so264910b3a.1
        for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 23:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749883301; x=1750488101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iTowa9KXL/0Dh7hJJqP/wwUW32/F1iE53yN7lv15ma8=;
        b=CLBFKUzZIGGJU/CnVqJYgznM8St/i5mHXuOyAERqQ1HacUHhLy5hgP2EZdt8Y0YCt8
         zaTEsOrEpNAmwl6sARJeAT99F/3eDDUzjhE3gFQaAksyV3w38GzjwajfkY3gJMX1Pyoc
         t/6ZurybxABetOUCwa9g6GcmhUWEr88wkq+DATPzdw5BIkiGljJh9r3JzQ+VRFzeDkw5
         csXLm8vPJlFRFQfiRKM7b2W8pkSr1QF5myGjKMgTsUA8/0REcSTzgI4+7Fv3YhI0NE+q
         bTmeolIoMBom1d2d/qrNaHAEsybd9nGcUOkVsSXgkvNPa8slLoVQG29m9ulL7p/HPnH7
         SInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749883301; x=1750488101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iTowa9KXL/0Dh7hJJqP/wwUW32/F1iE53yN7lv15ma8=;
        b=rPOM+Dveox3BnQRdzZuKOgZZyrCezEJsXrWEZ/QKWF18BGWx/3cwdS+Fn22LBZFsU9
         0sSiB9xJwPwGK3Ch+EBokqKhHfLgK+2oWWjsjAhBH/ehAhrbIzA0m2k68Cx+JAnwaDg5
         vkGjviZquh5a//1dCTrVi8F0rD8FcO8yzrjagWW4jZDJsVpdS1M/tXfauvqN2xwBitF9
         6wD7iV9flzF06TsqbWNfQgD8hVB40CcSGSPuebUNOhzxoxqaKtYdwPHxkaWdPMA+Gocs
         7L5WVPUvPbr7QgXVJ09nxG4cDHLvafRk4kFRPAECoo5a98INe3FwLyxrEd0MlH376n3y
         JywQ==
X-Gm-Message-State: AOJu0Yy+cMeP7ynkA0ydIG92sw0j9L3IiCzTcRtJNPXrqRYoS8sDA0my
	0bLBtgSBN1Z/EhP+cUtj6txymZ5rehUnxmxl+YUjjGPLQP5uLfApy50UbnsSC6bI
X-Gm-Gg: ASbGncumJfIMNxXMnY7QCUaG1zyAZZOCIYKdJ7tILjqBZYSe1Na3hfVgWlwuQtDEKl4
	xpaYaFf0RFiEJCOLXGhx4sSdmQPhYBI83/knWusHSIqnt40vIaPaekfvVPESl1KTdf0zI3xYbVz
	QBwYfFjJrqRSmWIUxxuGgV3YwCvvA6bl5GODeFQa9izz/iC/AvJ7R/s/FJq6w6fpJK3aDdLsXNB
	BpBUtpnd8+3MmouJ4IY3XzgHUA0NJxyVMuPVlxB5GOhf9CVzH6vUesbEb9+QdQk/oJeDLdHHWY9
	F7UEfu/UMwKM92bDuCQALobx4IHCsYZsYEvecQ29PrV2bGgv2mK/96xwRXqsjbnWrsxqvwnMLHh
	m/s1dqbG4sMbDwpkF8MeQvORFcwJaQVkPQ+rhopHDnjDTKjUxwsnbeMqvx79tw81mZFnuElLQaA
	==
X-Google-Smtp-Source: AGHT+IG2uKfUPCj1LqhHigaZC54E2hIGljL0bdqPsy11HdZNPyumCAoJNMkSrvZRnkVSHcp9IAtPng==
X-Received: by 2002:a05:6a00:3a17:b0:748:2fa4:14c0 with SMTP id d2e1a72fcca58-7489ccc780cmr2791400b3a.0.1749883301563;
        Fri, 13 Jun 2025 23:41:41 -0700 (PDT)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([20.120.208.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74890083ba7sm2812124b3a.102.2025.06.13.23.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 23:41:41 -0700 (PDT)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
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
	djwillia@vt.edu,
	miloc@vt.edu,
	ericts@vt.edu,
	rahult@vt.edu,
	doniaghazy@vt.edu,
	quanzhif@vt.edu,
	jinghao7@illinois.edu,
	sidchintamaneni@gmail.com,
	memxor@gmail.com,
	egor@vt.edu,
	sairoop10@gmail.com
Subject: [RFC bpf-next v2 0/4] bpf: Fast-Path approach for BPF program
Date: Sat, 14 Jun 2025 06:40:52 +0000
Message-ID: <20250614064056.237005-1-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is RFC v2 of 
	https://lore.kernel.org/bpf/20250420105524.2115690-1-rjsu26@gmail.com/

Change since v1:
- Patch generation has been moved after verification and before JIT.
	- Now patch generation handles both helpers and kfuncs.
	- Sanity check on original prog and patch prog after JIT.
- Runtime termination handler is now global termination mechanism using
  text_poke.
- Termination is triggered by watchdog timer.

TODO:
- Termination support for tailcall programs.
- Fix issue caused by warning in runtime termination handler due to 
  https://elixir.bootlin.com/linux/v6.15.1/source/kernel/smp.c#L815
- Free memory for patch progs related fields.
- Include selftests covering more cases such as BPF program nesting.

 include/linux/bpf.h                           |  19 +-
 include/linux/bpf_verifier.h                  |   4 +
 include/linux/filter.h                        |  43 ++-
 kernel/bpf/core.c                             |  64 +++++
 kernel/bpf/syscall.c                          | 225 ++++++++++++++++
 kernel/bpf/trampoline.c                       |   5 +
 kernel/bpf/verifier.c                         | 245 +++++++++++++++++-
 .../bpf/prog_tests/bpf_termination.c          |  39 +++
 .../selftests/bpf/progs/bpf_termination.c     |  38 +++
 9 files changed, 674 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_termination.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_termination.c

-- 
2.43.0


