Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0FEF30FD01
	for <lists+bpf@lfdr.de>; Thu,  4 Feb 2021 20:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238270AbhBDThJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Feb 2021 14:37:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:57184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236851AbhBDThH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Feb 2021 14:37:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E43D64E07;
        Thu,  4 Feb 2021 19:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612467386;
        bh=zNGJGSCORnlC0Fa+Y/YbJgFbAyUSqt29rQBxP16NoW8=;
        h=From:To:Cc:Subject:Date:From;
        b=Jkkfy/ORgFrH9xDCENxQDRijBQeZ49DyX+zz4g09FRf7zHUKLtNztUg1zTcTPhCTJ
         UscVI9M2mIcm4UPvW8ia2FBCRTtMV56OdJwOGh/4HARtR1QOzKR0m6ERhllfoRUS+4
         urL7b080OnQ3LI3Finxvt7a+CroLGOMnaFY8PQp0QM1jPWayWOonu7V+CEd+k7cEo7
         7UZA6evyf92M2KP5pZahg2/lLQN5mLUEGEatT/Rr/XEq/kof8BqGEKD1kI+8UHu6rI
         oVRwMRYIXmW/WsanvML15eC8qBDZrFG9qzbSq4V9RZ7noKTBwjauusmgR2VRLyGqRp
         rTxIQ2obO4a4Q==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next v2 0/2] BPF Ringbuffer + Sleepable Programs
Date:   Thu,  4 Feb 2021 19:36:20 +0000
Message-Id: <20210204193622.3367275-1-kpsingh@kernel.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

# v1 -> v2

- Use ring_buffer__consume without BPF_RB_FORCE_WAKEUP as suggested by
  Andrii
- Use ASSERT_OK_PTR macro

Sleepable programs currently do not have access to any ringbuffer and
since the perf ring buffer is a per-cpu map, it would not be trivial to
enable for sleepable programs. Our specific use-case is to use the
bpf_ima_inode_hash helper and write the hash to a ring buffer from a
sleepable LSM hook.

This series allows the BPF ringbuffer to be used in sleepable programs
(tracing and lsm). Since the helper prototypes were already exposed
the only change required was have the verifier allow
BPF_MAP_TYPE_RINGBUF for sleepable programs. The ima test is also
modified to use the ringbuffer instead of global variables.

Based on dicussions we had over the BPF office hours and enabling all
the possible debug options, I could not find any issues or warnings when
using the ring buffer from sleepable programs.



KP Singh (2):
  bpf: Allow usage of BPF ringbuffer in sleepable programs
  bpf/selftests: Update the IMA test to use BPF ring buffer

 kernel/bpf/verifier.c                         |  2 ++
 .../selftests/bpf/prog_tests/test_ima.c       | 23 ++++++++++---
 tools/testing/selftests/bpf/progs/ima.c       | 33 ++++++++++++++-----
 3 files changed, 45 insertions(+), 13 deletions(-)

-- 
2.30.0.365.g02bc693789-goog

