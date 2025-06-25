Return-Path: <bpf+bounces-61596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEEAAE9133
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 00:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E94C4A5BB4
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 22:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0B22FCE31;
	Wed, 25 Jun 2025 22:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3bTAqTo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AE02FCE2A
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 22:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750890753; cv=none; b=oMRZqIQs2lqCal3mnFqJI59iUkVVZV7wdY9QFNhIAL6Lwt8cSgNgGQWcx3s13Sc+f5tKTd6Z+54HsP/fWK3ItcHEo70zg1YGockEiUQrm0pqNEcw+WWYixrOGV4bVYOymJ2GAkS+h77RG+c924nZMowxWPswicMAlOBMoVPkJ00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750890753; c=relaxed/simple;
	bh=IUM/kfBVvarUWx4RU+riNCjVspmOSjnthX27WEMy/5w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g70L6QAxkpCH+vU4Q9YCRWdF4pgmzmgwK1uN4uck/Lx8rnzbnT7U10PBywbKnB5WWbOu/gSWwNyAZoaNxAZEh17Nt52tZWj+hfeqObgvGWfHmxgtaV1Wn0cy7jlvFbo6d5tGJwXkHEe8oAWZCcgbiY+WwN/g5u2bczykA1OF6rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3bTAqTo; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2349f096605so6563495ad.3
        for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 15:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750890752; x=1751495552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZIkFdSYIcusgUJU1H/OMxJd0qPE0IZGP0431s23HeZY=;
        b=c3bTAqTo98JB1GNk4vkFeC0qN/JPXzRwsgu352vy+qiZlFkUvS2xC2Cr+QMPe7lj8Y
         TWHlqouxtrUBV4GrvS+iWlqJbwiDU+DsIwwqf+FUrIFJWfXD/YNddU2q71Nm0nrUtrTV
         WlDbBZRtREDiZHQBRjW3mGQ9iy9pQmkRhWnkmQvF+4zHKsrr7srlCMtit0FXXsqXU3Ty
         qkM7ISGx9f2QG7I2ruy8MHHwh23ExbRdUzSoa0FHOQZSQemM2h/KigN246yq3gwQnpLJ
         WUdWT8DahsuK5nipCrQMyBh5CvRHlFacqOW7FB1mYRS5h3gnR5swOVBbQN1VUmS3jMuR
         wsJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750890752; x=1751495552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZIkFdSYIcusgUJU1H/OMxJd0qPE0IZGP0431s23HeZY=;
        b=fujwcGgQ3bDt/myAOjvz2zQC1V+oipiqLYYw1QWxUcLMkblttmvLGTAsuw08Z5sn59
         wW6zm6mY7OnLj4SHco+uQ2vcdcFqe1Yu0d9J+TrXf98TPZPpQ2pH3Tgsi6hDDumoof3b
         9YB/I+j4NY+82IDzwExSxqUfPZ+0SHZqTBDDIP0zn9zQVcTrD5Uu0ZrbeQ3q5aYTSila
         R3mrJ0/+2ItKvSYPActMDMbH+Gs2kCtT4stDBJSKSX6ULMjPolo5Nrv/BgRLC/JZ4tYc
         A8xPo4M6y8Ig7e8mMK7clmVWnfFny5VMZwDKB6CrFffRzzrPZBZKAiQJTLYJedOvDsM3
         ItRQ==
X-Gm-Message-State: AOJu0Yz7sDYEFHExbfIrjyotMDUVL1KD4priKWI6rv4s6YlDjQxmekf4
	wj8d6QE/mF/+dP/dQNcJ6/dmm/B3lKX85LKU/JJwjbTCLHpNQIeKcXsq
X-Gm-Gg: ASbGnctTcVUeqxWSRMsOczjIL2T7L7c469sBXrNKvROvTgM7iFiJMy48UVUglfqzC6v
	5S8UAbigq1iRSDfO3vw1rrWaMD1dPqhHyP/Hm+UPeRiR7YnVYS6XVY9CSVAhdPRqUzNchsFxcz0
	zThISFxWkVeL1L691omzoV9BvpYBlstL2OPIduIbq/kBNNXJTAgdV707olLGqET019Xm6fVcySz
	FC2HiozKRKqVRPXLhLR8FsV0MF+ypmroHG8qaxIGN3QPzMamVVVIhtwaqIbHYexqpQRjtdSTLWn
	J/DN145BoI/807la9c0m94gVmL3RkZRU8byj28VMvMiWJ1PrMrlXEezHODLrTSuROh5oA63O/pl
	yZJTCJ0VhVnNpxa6sPlDOD1hUo08=
X-Google-Smtp-Source: AGHT+IFf+M1Og8vRIh/vHIEJHvbLU2kGASq+Yz8uuPh9GMiD1jvr6yyCeMIeRSJoUh4xpP/WPQPeOA==
X-Received: by 2002:a17:902:f608:b0:237:e818:30f2 with SMTP id d9443c01a7336-2382409f299mr79173805ad.50.1750890751698;
        Wed, 25 Jun 2025 15:32:31 -0700 (PDT)
Received: from localhost.localdomain ([2001:558:600a:7:a83d:600f:32cc:235a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8642450sm142364805ad.147.2025.06.25.15.32.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Jun 2025 15:32:31 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org
Subject: [GIT PULL] BPF fixes for 6.16-rc4
Date: Wed, 25 Jun 2025 15:32:29 -0700
Message-Id: <20250625223229.46651-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 9afe652958c3ee88f24df1e4a97f298afce89407:

  Merge tag 'x86_urgent_for_6.16-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2025-06-16 11:36:21 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

for you to fetch changes up to 5e9388f7984a9cc7e659a105113f6ccf0aebedd0:

  selftests/bpf: adapt one more case in test_lru_map to the new target_free (2025-06-25 15:19:36 -0700)

----------------------------------------------------------------
- Fix use-after-free in libbpf when map is resized (Adin Scannell)

- Fix verifier assumptions about 2nd argument of bpf_sysctl_get_name
  (Jerome Marchand)

- Fix verifier assumption of nullness of d_inode in dentry (Song Liu)

- Fix global starvation of LRU map (Willem de Bruijn)

- Fix potential NULL dereference in btf_dump__free (Yuan Chen)

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Adin Scannell (1):
      libbpf: Fix possible use-after-free for externs

Alexei Starovoitov (1):
      Merge branch 'bpf-specify-access-type-of-bpf_sysctl_get_name-args'

Jerome Marchand (2):
      bpf: Specify access type of bpf_sysctl_get_name args
      selftests/bpf: Convert test_sysctl to prog_tests

Song Liu (1):
      bpf: Mark dentry->d_inode as trusted_or_null

Willem de Bruijn (2):
      bpf: Adjust free target to avoid global starvation of LRU map
      selftests/bpf: adapt one more case in test_lru_map to the new target_free

Yuan Chen (1):
      libbpf: Fix null pointer dereference in btf_dump__free on allocation failure

 Documentation/bpf/map_hash.rst                     |   8 +-
 Documentation/bpf/map_lru_hash_update.dot          |   6 +-
 kernel/bpf/bpf_lru_list.c                          |   9 +-
 kernel/bpf/bpf_lru_list.h                          |   1 +
 kernel/bpf/cgroup.c                                |   2 +-
 kernel/bpf/verifier.c                              |   5 +-
 tools/lib/bpf/btf_dump.c                           |   3 +
 tools/lib/bpf/libbpf.c                             |  10 +-
 tools/testing/selftests/bpf/.gitignore             |   1 -
 tools/testing/selftests/bpf/Makefile               |   5 +-
 .../selftests/bpf/{ => prog_tests}/test_sysctl.c   |  37 ++------
 .../selftests/bpf/progs/test_global_map_resize.c   |  16 ++++
 .../selftests/bpf/progs/verifier_vfs_accept.c      |  18 ++++
 .../selftests/bpf/progs/verifier_vfs_reject.c      |  15 +++
 tools/testing/selftests/bpf/test_lru_map.c         | 105 +++++++++++----------
 15 files changed, 142 insertions(+), 99 deletions(-)
 rename tools/testing/selftests/bpf/{ => prog_tests}/test_sysctl.c (98%)

