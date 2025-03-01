Return-Path: <bpf+bounces-52956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D417A4A834
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 04:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDA0E16F3EE
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 03:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FCD4204E;
	Sat,  1 Mar 2025 03:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHBs2sLd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD9918C31
	for <bpf@vger.kernel.org>; Sat,  1 Mar 2025 03:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740798134; cv=none; b=E0aSULdEBXyjJ8tK6zK0vqSMxp2qUp4Ih5/NuXjnho3GWzEsQBINTYwFg/d7a4eWw23vU0hVrXxNYa7u1HOZLuS8YUosVirhAZYy2ZLo0Ml9joc1bTTJtrFezTjEUuDqTxPHTDmiSS6cyIWHHSWasWyIfsSEGLmk8xZN94q5YhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740798134; c=relaxed/simple;
	bh=Qhp1O75SzGgaIcb1mgaDBNF4DIYDP52gFjBdGVc3iCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t/mixEU+IVykE+0Nr1pJmk9ciQbAN1QQx7k7SPwqf3zbSRQc0ih7h4qwmJRxOkuKCqyEa3u/0tl6DM07cHVm5I9VS6qScWWsgogKp5eVka2bOcrWeojA60kR3RIpyLE5t4lUyvTvbZMCufER5pfrBo6RJsrrUo8hHbeaZ9Q48VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mHBs2sLd; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-43aac0390e8so17717575e9.2
        for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 19:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740798130; x=1741402930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YIDJRFM6I6D7ys4veoNNoZDJCRDrZOQ/Un18Kr0U26A=;
        b=mHBs2sLdzfm6tt49MBzqgujBTQBTtIYX4B+0aAwdPiGL0D0MQylpJ5Yj/2XpXN2exK
         0cBxHuCJHDLg6RBF+DzAE9H9kVZklWCgKTDedjSUJQrNHesq0aA5MTJ7Lk1MpFyivfew
         xqtY12CGQ7yUmiDoS1Z0By6BHS8y/ydhh1wN0JOpmRdaNOOhzZCvx15gS/0D5DUwuDuU
         oSapHr9FpH9P3bbV6TMKVY2E4Kpg8QRxsAHHx42gWjRkBbrNF146kVv9W7fHIEV7clG2
         LJ29k7t6/R7Sf4Z9p74DM3izxmJL4It8Rl8EAyuYVL7LFGPqGgyowNx7UvsyS2mBJMyv
         ecCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740798130; x=1741402930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YIDJRFM6I6D7ys4veoNNoZDJCRDrZOQ/Un18Kr0U26A=;
        b=sganWolQ0vEEawUDPZT8++omKhBo/u7h1ycogGSpHaZflvmO0CF4xUaqtLPzyKyWqt
         Vv5oo5wSG/cN//VHGUK9c5Sbu1/yzfSYEJQUUAyUoDheVL41faa15qP9QZURS4UnO8de
         cht8RkB1gArRXZPEgtPOtGq9pQ7mQuO02YAvVZGiATTYmzAXR2TWN0sguXiIEReTU2NQ
         bxbTnUIQVE9fdPCNIyH0UhIRnqrfw/6+1bumGiUiB8B9BBdcOGw2+EYjbphx6/3XuSz0
         krdxOJLk2hatcYFJk1EDZ9781MtsEM6x3RNTR9+JFwH/xe4W+wz0QQovqYiGo9sVTiUb
         QScw==
X-Gm-Message-State: AOJu0YxVTyRKwbbRH9GKw7k1wWkeWGBB5nkkriQPklEoiWaSYD4YOyah
	npcUTaXXqcNaPZzkMs6biFfZaCN09KBWPTZNsHyhLqj5jeOGxF6/qgmtWZEDIhk=
X-Gm-Gg: ASbGncsyxoM+lPGBI1qV/9XMKxuBbyzt9bBdqEoHy6v6zy7Vx+nZpa/wPIL8CeNsONy
	pUNPOdV42zA/7CwM8YjMBxoYcFayv1MxVpqA8+jMoYkDavGzlqyZjGdWRJd4YFHMf9dRzRTpHup
	puJh3EGcu7yIWHgV7+gSsuN2WYKETXvfXlSjwqFfK6o4gSFlDyGiJcTyhyv40Z73neErUViGA7Y
	g2Pq4O6RMGepiNHu24G4h7OBhvnj4rkjLJnEMYHnTQ879sjY4tl09WNdrvbmqtkQ+Xnnt5KQCAA
	erlvU9GSNw1Xt4wwGkBHC3DuNBETc/2ON7Y=
X-Google-Smtp-Source: AGHT+IFPE8js5SXRCwSFGXfQ68gWbzeTkYrEucqbC+rh7pz2H/gZF6f5rn84s4uO37Q5me2tAbRu+Q==
X-Received: by 2002:a05:6000:18ac:b0:38d:dd70:d70d with SMTP id ffacd0b85a97d-390ec7ccf43mr5144571f8f.18.1740798130008;
        Fri, 28 Feb 2025 19:02:10 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:44::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4844514sm6960599f8f.76.2025.02.28.19.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 19:02:09 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 0/3] Global subprogs in RCU/{preempt,irq}-disabled sections
Date: Fri, 28 Feb 2025 19:02:02 -0800
Message-ID: <20250301030205.1221223-1-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2570; h=from:subject; bh=Qhp1O75SzGgaIcb1mgaDBNF4DIYDP52gFjBdGVc3iCo=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnwnU/5Kj8DHmXVCnVCjjrbhJjMjTZjMrqwPot3fvN s7q39PGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8J1PwAKCRBM4MiGSL8RyiLvD/ 9FPiTEZewmLKwQb44IT7yjn3hw6b5TWMPrluUczcg2UncwXAMb7WChMsmvRJQ+6nPn8Lb5E2TMtHID ncOorrq76s+rygqHetmRGyZkkVIXJgJ6AVQY9BItrYpmn7BKOB+vHEyESi68NaWsIK+3LuV0QZNT5R M3O1bS3ay5KAf74Jc1QWi6a8T/Hn/8zWzx/yBzhWZIhf/JYCMGJrVcAswkqCtXXAKXUwoH4WWgdUP+ lBoqlcA+b0mziNWElqCnWTuRjsqiXeMJKb3rzXGXgxt48zv9mFU75LIx4NdAS4hLO9M2GkwjWaAcY3 KyumTc2Ed0Q4sA+O2KeyCXWnFTeooceK5fps2IvYiaMqJWcvQxbfQPjOgvNbr5EpOJJtw6ksuYnxWy luSs5GCs/at9Evktmn537kKdLzzmqzNSSfSRW5ITXXwIgai2Nvdlpuhi+InziPzhkhI/derJRE91nc oNsTwgGA+JTsjFzi+VjgQIIGhUjkUv+5qNou6QHEEUvMAA4rRj4RhkYhw+P3cMc7dGmkqErJxH6MDP C1L3uwdOFsA3f5GG4JCOHxxj4LddM6bjlVa64RORfpzkkk/M3rfzsvyrUpCYdCL14Ete7SLw0fxjZa wPxwQYHFa/fUAAjpkGtfjxH+W6RNMOlttW5KBsnRg0DDlH9QnNrx6UepUn4Q==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Small change to allow non-sleepable global subprogs in
RCU, preempt-disabled, and irq-disabled sections. For
now, we don't lift the limitation for locks as it requires
more analysis, and will do this one resilient spin locks
land.

This surfaced a bug where sleepable global subprogs were
allowed in RCU read sections, that has been fixed. Tests
have been added to cover various cases.

Changelog:
----------
v1 -> v2
v1: https://lore.kernel.org/bpf/20250228162858.1073529-1-memxor@gmail.com

  * Rename subprog_info[i].sleepable to might_sleep, which more
    accurately reflects the nature of the bit. 'sleepable' means whether
    a given context is allowed to, while might_sleep captures if it
    does.
  * Disallow extensions that might sleep to attach to targets that don't
    sleep, since they'd be permitted to be called in atomic contexts. (Eduard)
  * Add tests for mixing non-sleepable and sleepable global function
    calls, and extensions attaching to non-sleepable global functions. (Eduard)
  * Rename changes_pkt_data -> summarization

Kumar Kartikeya Dwivedi (3):
  bpf: Summarize sleepable global subprogs
  selftests/bpf: Test sleepable global subprogs in atomic contexts
  selftests/bpf: Add tests for extending sleepable global subprogs

 include/linux/bpf.h                           |   1 +
 include/linux/bpf_verifier.h                  |   1 +
 kernel/bpf/verifier.c                         |  62 ++++++--
 .../bpf/prog_tests/changes_pkt_data.c         | 107 -------------
 .../selftests/bpf/prog_tests/rcu_read_lock.c  |   3 +
 .../selftests/bpf/prog_tests/spin_lock.c      |   3 +
 .../selftests/bpf/prog_tests/summarization.c  | 143 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/irq.c       |  71 ++++++++-
 .../selftests/bpf/progs/preempt_lock.c        |  68 ++++++++-
 .../selftests/bpf/progs/rcu_read_lock.c       |  58 +++++++
 .../{changes_pkt_data.c => summarization.c}   |  38 ++++-
 ...ta_freplace.c => summarization_freplace.c} |  13 ++
 .../selftests/bpf/progs/test_spin_lock_fail.c |  69 +++++++++
 13 files changed, 513 insertions(+), 124 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/changes_pkt_data.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/summarization.c
 rename tools/testing/selftests/bpf/progs/{changes_pkt_data.c => summarization.c} (52%)
 rename tools/testing/selftests/bpf/progs/{changes_pkt_data_freplace.c => summarization_freplace.c} (66%)


base-commit: 0b9363131daf4227d5ae11ee677acdcfff06e938
-- 
2.43.5


