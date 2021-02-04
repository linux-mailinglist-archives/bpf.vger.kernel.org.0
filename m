Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 295F130FD02
	for <lists+bpf@lfdr.de>; Thu,  4 Feb 2021 20:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbhBDThK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Feb 2021 14:37:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:57204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236931AbhBDThJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Feb 2021 14:37:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 241F664E0B;
        Thu,  4 Feb 2021 19:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612467388;
        bh=FWrT0JoymyjP/OOeI7BWrsDy13Hj/c7R9O4IL03sbPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GsiR5PunB3WXKVdAFYesCMPWFIvbbLe3nsYkk6AWN/3kYlT/hgDJ8HAqRNbywmJfi
         daAkxO3A1JOHkcViP0R2BkYFa3MN2YnJmeabUpszFIuU8AgbHXPL1mZ8Eiu3avnHP5
         QvO9A5IauU7XFRP/Ok8IfqNLOEIbuUb2kevWENCajrJbJyGyFEKaynqJidNyESYTnX
         NZmSQ6uie7zUSMYXaN8yl3flPUym14I+rfN9WZwv/ZEpSi73/8DuWDQWu9eYFg/2/m
         hsnObTh8qB1zTlvV8bvrJ13C9prMdXNArGBY/CMY6JM3Qvyum1HZfbpzirEE1b9QV8
         5zYWNaJB/pIcA==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next v2 1/2] bpf: Allow usage of BPF ringbuffer in sleepable programs
Date:   Thu,  4 Feb 2021 19:36:21 +0000
Message-Id: <20210204193622.3367275-2-kpsingh@kernel.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
In-Reply-To: <20210204193622.3367275-1-kpsingh@kernel.org>
References: <20210204193622.3367275-1-kpsingh@kernel.org>
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

Acked-by: Andrii Nakryiko <andrii@kernel.org>
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

