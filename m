Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B884030E739
	for <lists+bpf@lfdr.de>; Thu,  4 Feb 2021 00:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbhBCXYR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Feb 2021 18:24:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:49664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232458AbhBCXYQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Feb 2021 18:24:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 41C4B64E06;
        Wed,  3 Feb 2021 23:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612394615;
        bh=Q72/1AENsx+ucUiIAiYdOtTjXI2X7/6kFkaFJA8HI3s=;
        h=From:To:Cc:Subject:Date:From;
        b=c1UUdlacIjpxYzFRvQunJCnOmkAS2DRhsDNlDutlXcW9KzZayEvD+bPRGJ4N+uhcR
         ZMsRSIlfS+mD26o1G/IbgfhboGBVlVTljmMJK/GSP3B+spnNz88XOl3K1jC5M8gGm/
         LjQYmdgsDNuvvqFx9bmA7HqarKWroX/6UWLTYvoQU73ZRWGT/MjZIgpNRHHQEgq1lB
         bhfF4Z/K+X05B4rvdrjRec9KEdYcCM34W1tdwQ5wnnfaLm1GR7AwVfVvMeubmCJ48F
         WVKDkVH8U6Yfiy7jF6YCVnYn+hN1sF7fULVgXbtTkaCb4JPZUjOvanCwZk4iPgCzv3
         OWVQrogEXyjLg==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next 0/2] BPF Ringbuffer + Sleepable Programs
Date:   Wed,  3 Feb 2021 23:23:29 +0000
Message-Id: <20210203232331.2567162-1-kpsingh@kernel.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

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

