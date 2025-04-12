Return-Path: <bpf+bounces-55822-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCA8A86ED8
	for <lists+bpf@lfdr.de>; Sat, 12 Apr 2025 20:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E3148C032E
	for <lists+bpf@lfdr.de>; Sat, 12 Apr 2025 18:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AD021A447;
	Sat, 12 Apr 2025 18:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrqIsWg2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340D6193402;
	Sat, 12 Apr 2025 18:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744483090; cv=none; b=p9GLqSmdSutLjpKjqaKjFL3iF1rmvgFD1HYysKaUinkWQoCbuJdIunxD1fb2m3eVH1oEvBxfnWipTLGdgUcZr5Rp0EKtK/izHWPqLPrj1Rjhw1A9JrcqWXE7k6EZoY/zVNY4I63hZCjKJBTt8qTb9nlvH60YWXnwhotMzFg2LmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744483090; c=relaxed/simple;
	bh=DB3ehN9uGhewpt+zV2BiPfCcLuTfwl7hGoU5BtcOe2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=du+mtEfBX4L96VDOoMjMp1HljUCoA2rnTW4M8ljQu0bUmG2/bt3PMQIblSa7n2aUeU5hfVPf/m+g/KkWjTNNtZi9rTnLEmnj50+g7ElGFM/8Owrn6ZwENIanNDf0TG5X7vCfl9ehE6z7b1eGDbWGFaapgXVXGJEarMKgHIeMhK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrqIsWg2; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2240b4de12bso41960205ad.2;
        Sat, 12 Apr 2025 11:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744483088; x=1745087888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qQM8fmMFppc/FCmln+vq9h3fENBqnRGQqbR3PeHRC9g=;
        b=lrqIsWg2xe+eIWuzWtSTGa7NTwDGQKTA7i5IGIy6tJ7ZD5SpVqut509YhqiIbA+Ta4
         sNXGal1yutKybawH5NrWEQlBeIjVpBgvCO+vcjGqwqYvb9J6FSitsa7JjyD1T/4OQswD
         s6UOzfDhdAeMtRwcNBR7qu4eEIsMdKmIXdHlUru5jM+s0Z5y99iOXC9IXbp/o6u9i1UK
         pqgkRHb7lzMP040/JdAyCYY9L5k1gP1Wqis1HfvtdvF8bE3cHSZytS0fAYqgrexegJ8c
         mL79m2lb7BLL8H4bv4IjBRKyRRmQ5tm9KJ5RZY1ISK78b3z0FyfuULkqz5Fk/at9hTzr
         rkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744483088; x=1745087888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qQM8fmMFppc/FCmln+vq9h3fENBqnRGQqbR3PeHRC9g=;
        b=TUkc5UkA6O77b+NgtgVHwxhME4muMnUTcH5bj5eB1gV6bfRH03+G7v2Qcd+do2fMd4
         gWyMMXf7W0WaWC6s3h6wVfPx5ai55IK4JmjszuyD3i4FyzmIzmGKgdc2HiyiZAY5me9Q
         Fa//dQiebZ8UVv7nJkGbkwjewYS1ChbIIB2Tk5bt/wHmkDnbrgLS7kmTBXrNh/woGeym
         E5A/yXUUNhvizP45KMpoDvgBbsw0RA8POZmYomDgCDQEj6z+SQsHBmAkY0GQC9tKsLn+
         CqNq9TwTSUWobPvCS+KCHA4yC46tm+mU30r1ev1quyzSVKghq2zTDyt9x5BBd4Zo3B1v
         fsZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHbylFJ5zgMTodNCoa5xP7pSpiNCZkB1cjBSmFEANrywzmA9PWcbQuqSP9x2KoDD5IeWMKnXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq5+i7yXXsRdFZMnNxhFTsoIWQYZBThaWCkmkZNa0aQ4X6m5jP
	yNk6dTGq3PUwGBalxQCFDTAb/5gaMOtKOD27pfsDf+aFWrLH9xf6
X-Gm-Gg: ASbGncuP0T0/12P3PenTjjw1eDfc7YMhLpSjvu23ZfEphyv43wY/DB4tvog4r/I/cfo
	egzD3QLOqVR7CWeEvmaksJnTmXqrntO5jkrU1dePZN2dHwr/RhjU43qnB0GAWR06BdN8Bvc/QRN
	J/DYU9lEwm6bRnl9zY754jzG16j1gygLtjNcxo7eryJoACkEk76NvadYIpGvlp9PzSfMu29sDvT
	VdT3UebrWlVtnDRFDfeAl8sM//hFU0a8r2XlKeYZ592uIt0CvO7Zrtzb+at35kJ+hGCWrMOiSw9
	iloHkLMNqRDdkNMaLM8qJV+Jd7FmXZ3haJk7YFKDJ3w7SHJOFHa/VRWCZhGIfI1zQXhUseGe4g=
	=
X-Google-Smtp-Source: AGHT+IHSywlzTeWPXiJ6eCS/vmFZYOxJH3s1j9ZXTbS+pQJjjWRL9LMRKY9z3kRM4vP86uBPI3R7VQ==
X-Received: by 2002:a17:903:fae:b0:223:37ec:63d5 with SMTP id d9443c01a7336-22bea4c6beemr117609235ad.28.1744483088169;
        Sat, 12 Apr 2025 11:38:08 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:67d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7c9c59dsm70251615ad.151.2025.04.12.11.38.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Apr 2025 11:38:07 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] BPF fixes for 6.15-rc2
Date: Sat, 12 Apr 2025 11:38:04 -0700
Message-Id: <20250412183804.36400-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit a8662bcd2ff152bfbc751cab20f33053d74d0963:

  Merge tag 'v6.15-p3' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6 (2025-04-04 19:34:38 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

for you to fetch changes up to a650d38915c194b87616a0747a339b20958d17db:

  bpf: Convert ringbuf map to rqspinlock (2025-04-11 10:28:26 -0700)

----------------------------------------------------------------
- Followup fixes for resilient spinlock (Kumar Kartikeya Dwivedi)
  . Make res_spin_lock test less verbose, since it was spamming
    BPF CI on failure, and make the check for AA deadlock stronger
  . Fix rebasing mistake and use architecture provided
    res_smp_cond_load_acquire
  . Convert BPF maps (queue_stack and ringbuf) to resilient
    spinlock to address long standing syzbot reports

- Make sure that classic BPF load instruction from SKF_[NET|LL]_OFF
  offsets works when skb is fragmeneted (Willem de Bruijn) 

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Alexei Starovoitov (1):
      Merge branch 'support-skf_net_off-and-skf_ll_off-on-skb-frags'

Kumar Kartikeya Dwivedi (5):
      selftests/bpf: Make res_spin_lock test less verbose
      selftests/bpf: Make res_spin_lock AA test condition stronger
      bpf: Use architecture provided res_smp_cond_load_acquire
      bpf: Convert queue_stack map to rqspinlock
      bpf: Convert ringbuf map to rqspinlock

Willem de Bruijn (2):
      bpf: support SKF_NET_OFF and SKF_LL_OFF on skb frags
      selftests/net: test sk_filter support for SKF_NET_OFF on frags

 arch/arm64/include/asm/rqspinlock.h                |   2 +-
 kernel/bpf/queue_stack_maps.c                      |  35 +--
 kernel/bpf/ringbuf.c                               |  17 +-
 kernel/bpf/rqspinlock.c                            |   2 +-
 net/core/filter.c                                  |  80 ++++---
 .../selftests/bpf/prog_tests/res_spin_lock.c       |   7 +-
 tools/testing/selftests/bpf/progs/res_spin_lock.c  |  10 +-
 tools/testing/selftests/net/.gitignore             |   1 +
 tools/testing/selftests/net/Makefile               |   2 +
 tools/testing/selftests/net/skf_net_off.c          | 244 +++++++++++++++++++++
 tools/testing/selftests/net/skf_net_off.sh         |  30 +++
 11 files changed, 354 insertions(+), 76 deletions(-)
 create mode 100644 tools/testing/selftests/net/skf_net_off.c
 create mode 100755 tools/testing/selftests/net/skf_net_off.sh

