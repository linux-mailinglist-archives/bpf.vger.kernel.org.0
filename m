Return-Path: <bpf+bounces-37922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6904D95C760
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 10:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07F78B2551A
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 08:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658F113DDC3;
	Fri, 23 Aug 2024 08:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ul1kOeTB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04EA6D1B9
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 08:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724400421; cv=none; b=HvKtbQybVT/OAh0ffJ1qsqVYTT7Mq5fc20xoGhxOvqGQjiObEdXFVpAxNEAJS3vXH1U2dOWC/G836OCFtVrUzZT6O6mJKPZCXhMhOHjPGbvacqg0fEC6Y2XAzag5fPLHxkV0McGL2wC/Br5sH10Hg1jLmM6EHaTwqROtunopsJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724400421; c=relaxed/simple;
	bh=v2BVbjGfXlM5y28pnWGwy28vnUBNujOAnWclWkFuGM8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kwk3YR6MjJLJtYWV5XFG2+KAdT6uvPLF1QrLUu44bwneVXS29ebJVp3OZTEDaG2N8MLoEYptO53Z/StYecFM1bRimLhXdGeN0gLIGZ9+51u6qscAqQ/rFPdj0w5UItceDh4IK6rZ/PycL50bawsHjxaRQpFQYHzK+QrY1rkmfC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ul1kOeTB; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-202089e57d8so11224795ad.0
        for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 01:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724400420; x=1725005220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kr8iy62BzN0ZuTZUu8/3DjQxrS73CqkVHj7gOYUXISs=;
        b=Ul1kOeTBovsF5Q7kEbFlwUNqG7yWBom/GksI360OOCtXrZgASQ4ZBiqcHr3+kSJ2kb
         m/G70K26o6S+6w/8AGi20TiTJMjL1eqrE9xmTYSSry3bpX+3vOLxuvatjJFmDJbrVGG/
         bgUzziSd8p6xDMg0rbMYpMxPIHIPrv2XzwWtZ3fcXl9PLXT+jHXCXUiwbBLStg7dlEn0
         MTIqg3uZaYiW8vr8qNHYzN6zth/vCpraJwRLEoW5IpTwOxSXNqazSL3Pd4y4Kb6zIPYr
         ujxA8EONrCnhOU2WuXrcS4XFzLc6c/5T5iDmxRqIKo0jw+VYgpXsGLf7arDKM92ab6nN
         19CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724400420; x=1725005220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kr8iy62BzN0ZuTZUu8/3DjQxrS73CqkVHj7gOYUXISs=;
        b=abYHV4ImzstF8nUTEvmiF0/kK4bAJLRsbT68O4nFuqTRS3Typ8zsVPKW0amRCSB1AT
         aReFBCyARNaKl8s72sHAJ1XUvZgSGLLX6v3L80mIlCt+dUQi4uAGt9EIWQbp9sJi1c55
         0cyBK/OfW1bTEFgJdLnxjSAtX5J3U4K5ImlE16+N27h/CG0ncbb+POEJ40i36lKKk/E5
         p4UH2Hd5I3/70s359BanrWLR81VMQFKsd2oXa96CZQDXsJo5a00OFQ+GRq8rBt9NtZDB
         kaBNFco8ka7AdBn8tASGTxDYK3I29JzmOu4BA3h488pepX/hlS0UVrvRVDLw0TIfdhHM
         YN6Q==
X-Gm-Message-State: AOJu0YxYqZ8p62gYQZgx7VrzRSLmv/1CTbUGXiKTGLKbdKbM3LSOoavj
	jYHc5NG108CuvkJV59A+y+TzluYMZjAYf78AHyEFGnFEgeV24brXNhn15A==
X-Google-Smtp-Source: AGHT+IEOVeEq5/Wt+XT/fW3nFNRE/DAnRb5hx3dW7bgneJDRM2XKBA5tqC7+CZ32VhcM1lyBOvtbDw==
X-Received: by 2002:a17:902:fd48:b0:202:21:eb2a with SMTP id d9443c01a7336-2039c4a1c42mr22557605ad.19.1724400419540;
        Fri, 23 Aug 2024 01:06:59 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385567f74sm23463925ad.60.2024.08.23.01.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 01:06:58 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 0/3] follow up for __jited test tag
Date: Fri, 23 Aug 2024 01:06:41 -0700
Message-ID: <20240823080644.263943-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch-set is a collection of follow-ups for
"__jited test tag to check disassembly after jit" series (see [1]).

First patch is most important:
as it turns out, I broke all test_loader based tests for s390 CI.
E.g. see log [2] for s390 execution of test_progs,
note all 'verivier_*' tests being skipped.
This happens because of incorrect handling of corner case when
get_current_arch() does not know which architecture to return.

Second patch makes matching of function return sequence in
verifier_tailcall_jit more flexible:

    -__jited("	retq")
    +__jited("	{{(retq|jmp	0x)}}")

The difference could be seen with and w/o mitigations=off boot
parameter for test VM (CI runs with mitigations=off, hence it
generates retq).

Third patch addresses Alexei's request to add #define and a comment in
jit_disasm_helpers.c.

[1] https://lore.kernel.org/bpf/20240820102357.3372779-1-eddyz87@gmail.com/
[2] https://github.com/kernel-patches/bpf/actions/runs/10518445973/job/29144511595

Eduard Zingerman (3):
  selftests/bpf: test_loader.c:get_current_arch() should not return 0
  selftests/bpf: match both retq/rethunk in verifier_tailcall_jit
  selftests/bpf: #define LOCAL_LABEL_LEN for jit_disasm_helpers.c

 .../testing/selftests/bpf/jit_disasm_helpers.c  | 17 ++++++++++++++---
 .../selftests/bpf/progs/verifier_tailcall_jit.c |  4 ++--
 tools/testing/selftests/bpf/test_loader.c       |  9 +++++----
 3 files changed, 21 insertions(+), 9 deletions(-)

-- 
2.46.0


