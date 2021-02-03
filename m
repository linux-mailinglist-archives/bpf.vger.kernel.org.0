Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9A130E736
	for <lists+bpf@lfdr.de>; Thu,  4 Feb 2021 00:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbhBCXYS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Feb 2021 18:24:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:49674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232458AbhBCXYR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Feb 2021 18:24:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EFA3164F43;
        Wed,  3 Feb 2021 23:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612394617;
        bh=PTVYv7f3q04Ewx0yYuhCee8Xadz6Jy6gdGf4sFC0JDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sVhTck0WNMa0115fJMPy6l6yPwSfScJ6e1OWERJwx1/2DR0S/OTOl6bxs7vIX5+7z
         sQ+SeUXHHVhjh9l1faaNBqwTqyKTzFLMLI+Y2cFXSgtJTJlGGcI8cYnAvYXPQB23rJ
         fPYGFrX6sd5VqH5WItLgzpGQ+UwyVR3Ye7BefH+SgMSNQrDvrpIWfDO228pVF4Evi5
         vdefPbszmh2YEOuZgH95RXnb9zyKSJlBBZgRa0qopBp4UKUJCCUhBwLeq1LMt7Y0CE
         1tN9Sf2lfqqjHJZC6QyipiQWLCGKNqIwTEcFnlYdZuuQ24ytZ/r1RE9JjpmTWcyWdy
         yhqOkmo7s13YA==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next 1/2] bpf: Allow usage of BPF ringbuffer in sleepable programs
Date:   Wed,  3 Feb 2021 23:23:30 +0000
Message-Id: <20210203232331.2567162-2-kpsingh@kernel.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
In-Reply-To: <20210203232331.2567162-1-kpsingh@kernel.org>
References: <20210203232331.2567162-1-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The BPF ringbuffer map is pre-allocated and the implementation logic
does not rely on disabling preemption or per-cpu data structures. Using
the BPF ringbuffer sleepable LSM and tracing programs does not trigger
any warnings with DEBUG_ATOMIC_SLEEP, DEBUG_PREEMPT,
PROVE_RCU and PROVE_LOCKING and LOCKDEP enabled.

This allows helpers like bpf_copy_from_user and bpf_ima_inode_hash to
write to the BPF ring buffer from sleepable BPF programs.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 kernel/bpf/verifier.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5e09632efddb..4c33b4840438 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10024,6 +10024,8 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 				return -EINVAL;
 			}
 			break;
+		case BPF_MAP_TYPE_RINGBUF:
+			break;
 		default:
 			verbose(env,
 				"Sleepable programs can only use array and hash maps\n");
-- 
2.30.0.365.g02bc693789-goog

