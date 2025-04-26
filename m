Return-Path: <bpf+bounces-56759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AB2A9D68A
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 02:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83E689264E2
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 00:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D283B374EA;
	Sat, 26 Apr 2025 00:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4F949AR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAC038F9C
	for <bpf@vger.kernel.org>; Sat, 26 Apr 2025 00:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745626114; cv=none; b=Km7oy7mKazabZVrjcImXpMZBbrTGncODgWOKWjD+6Jo8YCGM1dv8AT2ABzy/eanEiNEBze5ImgwgnPV1q9FXvv3Qqb1CtQCUQw4e86A1necILzGtmVN9u7dn2+yDo9+71WBBhjuCaCiIU0JFzakdPirMVInwc9ixFRXQNzB87Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745626114; c=relaxed/simple;
	bh=dYK67T1zRNBTmCcR87fZd/r/VfhS2/LCApUwBqp0Ekw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vbme6r8G9hCPz3jT8/HMcIriS/3uGVFsQUI6AZNDJkBIRRo4km4iUxSkLNABjZaHSGjO6xcYSgNXpc1bU6Ra11zaKp4ZkoykQm751510lR5dTDV87nGlrBUrxoxao1B7ijXoJJZvBbQUE4JzkGUDpHBYER/B9zNwtVn875PrrnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4F949AR; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-ae727e87c26so1884564a12.0
        for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 17:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745626111; x=1746230911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F7nWdje3jaSRb6I3bRU+S3fVcFHELE3/hJhD1qzlpGM=;
        b=Z4F949AR5czhl7nU0m7zz4ihPMUjfQeYR3Qo3wvyA3vY26jDgtc/W+TJlSh2s3lmUV
         bef5m83ndJ70N1u4iXTZ75chGyKMsGl/gplctba6fRca7mMLx7MeoA0quyKjIl2xzcIQ
         mkPaNvFWEtsU8jqSsXTy2cJ0i0xGDEOwHVfmfmhSDn3/Gy1IUuuWy4DY1OyilRWIhFki
         NhBHG4vxar9qTLuLmjwZi00Oo6kViVnHBXD53GGkFT30C3Lx2mmRDBdpFXawGjM2dckJ
         uOO3beRUeVk+OgvP2l/UEwHZhlH4P16Qg3xhcGU5Kw2Y6gPI+mPSAPictHUpFpK0eaVD
         otXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745626111; x=1746230911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F7nWdje3jaSRb6I3bRU+S3fVcFHELE3/hJhD1qzlpGM=;
        b=MSeQ35oRpCiW7mR6DXYnZdno1dhRpZboC2vnpc2Ln3AiCovStH6SLD8rcjRKbijVbQ
         d5iOxvL36QjzXK2NagXCnhLJNmcL26uitn2w+xujV6kQciCJhbi0b1a+aykuiKj9S8oq
         gXwoaddb3ke4GzovDHo3RfL6QvobUIERqyQ+IkOFZpcysJ0pymh2W3cg+UtuTkibAi4B
         6qpx90UjT+U0hUo2Db7u9vh843Ljg8vA/D7fYD/hsXqklGVTthYz3BKb3m/hmsbveN4w
         5aftTSVra4xC0qz8LdIGVJO4j+IK4ME32fC0kcln1Q02g7wz9iBUMgSXYN2V9743/FU+
         VW1Q==
X-Gm-Message-State: AOJu0YwffVi+y3oeN3gGD+oRhhEvTi83d4SVUT5je+9+oSYKS/hdn5DW
	iInXgowfjPypQSVnQJsm4exmlw63ix2ceT/lKAsszLQLfbfX70zN
X-Gm-Gg: ASbGncu8jY81ALWYXIgsZtmkQflg1uRuC1nSpvrEEQLW5RSbkZEeyLZhyo+m1vU6KC2
	gR6/PD5Q+MBr8phN9VbQodyzEGVNLwcz5bEmUfVlgRuSUAfH0v+WYV7940FdYcsHrpTX0Rr/CtZ
	UDnjQ46pLzclfBP0jpICAmBrKNj/QKz65aev/V4Kq/nbzpinpgen+K6W+BCmQs+tNQovlzD5vvZ
	FK9dKKzCPUettY1jt+0aWRkcjAQmBxNUANsob6eyBuLy2507Hfzh4kHECjKvCfS35GfzpOtVHmb
	b2t5QHxmnwzW24sj2/VgPAKmeyaOdvYqNGbl4ptYHkdmvdflEp+c8nvgVTabHcc2kkZL
X-Google-Smtp-Source: AGHT+IGMvF2pOXTcMlP2ZRKKFVv8zq0T8rrGgdUmE/D/qE9I+z2VDVGmr9gEMdgeGERE2Y3J0uXBTA==
X-Received: by 2002:a17:90a:e706:b0:305:2d27:7ba5 with SMTP id 98e67ed59e1d1-309f8d8ce04mr5525249a91.6.1745626111237;
        Fri, 25 Apr 2025 17:08:31 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:3a24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db51025d7sm38698925ad.169.2025.04.25.17.08.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 25 Apr 2025 17:08:30 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org
Subject: [GIT PULL] BPF fixes for 6.15-rc4
Date: Fri, 25 Apr 2025 17:08:27 -0700
Message-Id: <20250426000827.84560-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit a79be02bba5c31f967885c7f3bf3a756d77d11d9:

  Fix mis-uses of 'cc-option' for warning disablement (2025-04-23 10:08:29 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

for you to fetch changes up to f0007910784a61556e94c42b401a38116a899c73:

  selftests/bpf: Correct typo in __clang_major__ macro (2025-04-25 16:56:10 -0700)

----------------------------------------------------------------
- Add namespace to BPF internal symbols (Alexei Starovoitov)

- Fix possible endless loop in BPF map iteration
  (Brandon Kammerdiener)

- Fix compilation failure for samples/bpf on LoongArch
  (Haoran Jiang)

- Disable a part of sockmap_ktls test (Ihor Solodrai)

- Correct typo in __clang_major__ macro (Peilin Ye)

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Alexei Starovoitov (2):
      Merge branch 'bpf-fix-softlock-condition-in-bpf-hashmap-interation'
      bpf: Add namespace to BPF internal symbols

Brandon Kammerdiener (2):
      bpf: fix possible endless loop in BPF map iteration
      selftests/bpf: add test for softlock when modifying hashmap while iterating

Haoran Jiang (1):
      samples/bpf: Fix compilation failure for samples/bpf on LoongArch Fedora

Ihor Solodrai (1):
      selftests/bpf: Mitigate sockmap_ktls disconnect_after_delete failure

Peilin Ye (1):
      selftests/bpf: Correct typo in __clang_major__ macro

 Documentation/bpf/bpf_devel_QA.rst                 |  8 +++++
 kernel/bpf/hashtab.c                               |  2 +-
 kernel/bpf/preload/bpf_preload_kern.c              |  1 +
 kernel/bpf/syscall.c                               |  6 ++--
 samples/bpf/Makefile                               |  2 +-
 tools/testing/selftests/bpf/prog_tests/for_each.c  | 37 ++++++++++++++++++++++
 .../selftests/bpf/prog_tests/sockmap_ktls.c        |  1 -
 tools/testing/selftests/bpf/progs/bpf_misc.h       |  2 +-
 .../selftests/bpf/progs/for_each_hash_modify.c     | 30 ++++++++++++++++++
 9 files changed, 82 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/for_each_hash_modify.c

