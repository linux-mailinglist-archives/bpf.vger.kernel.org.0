Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E50A6977B
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2019 17:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732516AbfGONyc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Jul 2019 09:54:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:55392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732510AbfGONyc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Jul 2019 09:54:32 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A2E0212F5;
        Mon, 15 Jul 2019 13:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563198871;
        bh=n73p8DBpdjQlzx+8hMTru8jM9tAEpZHBxzQSMiPsO38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M1wrskseJNElrV18oIHpV0dWJqm2d0cCEx2jxa4xIFWN6bon5KVaUYBabX9eVexiC
         68b2Yw3G/FS6YUScNynlgT1JyRE4coypVtCV8ZrABrsjLsHIzBcbQCd2OMIXAf/1pw
         tQTmyjpF5ewH1dprWdbzkkmDL0Xj+phU9BPiYcOA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 124/249] bpf: fix callees pruning callers
Date:   Mon, 15 Jul 2019 09:44:49 -0400
Message-Id: <20190715134655.4076-124-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715134655.4076-1-sashal@kernel.org>
References: <20190715134655.4076-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

[ Upstream commit eea1c227b9e9bad295e8ef984004a9acf12bb68c ]

The commit 7640ead93924 partially resolved the issue of callees
incorrectly pruning the callers.
With introduction of bounded loops and jmps_processed heuristic
single verifier state may contain multiple branches and calls.
It's possible that new verifier state (for future pruning) will be
allocated inside callee. Then callee will exit (still within the same
verifier state). It will go back to the caller and there R6-R9 registers
will be read and will trigger mark_reg_read. But the reg->live for all frames
but the top frame is not set to LIVE_NONE. Hence mark_reg_read will fail
to propagate liveness into parent and future walking will incorrectly
conclude that the states are equivalent because LIVE_READ is not set.
In other words the rule for parent/live should be:
whenever register parentage chain is set the reg->live should be set to LIVE_NONE.
is_state_visited logic already follows this rule for spilled registers.

Fixes: 7640ead93924 ("bpf: verifier: make sure callees don't prune with caller differences")
Fixes: f4d7e40a5b71 ("bpf: introduce function calls (verification)")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a5c369e60343..11528bdaa9dc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6456,17 +6456,18 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	 * the state of the call instruction (with WRITTEN set), and r0 comes
 	 * from callee with its full parentage chain, anyway.
 	 */
-	for (j = 0; j <= cur->curframe; j++)
-		for (i = j < cur->curframe ? BPF_REG_6 : 0; i < BPF_REG_FP; i++)
-			cur->frame[j]->regs[i].parent = &new->frame[j]->regs[i];
 	/* clear write marks in current state: the writes we did are not writes
 	 * our child did, so they don't screen off its reads from us.
 	 * (There are no read marks in current state, because reads always mark
 	 * their parent and current state never has children yet.  Only
 	 * explored_states can get read marks.)
 	 */
-	for (i = 0; i < BPF_REG_FP; i++)
-		cur->frame[cur->curframe]->regs[i].live = REG_LIVE_NONE;
+	for (j = 0; j <= cur->curframe; j++) {
+		for (i = j < cur->curframe ? BPF_REG_6 : 0; i < BPF_REG_FP; i++)
+			cur->frame[j]->regs[i].parent = &new->frame[j]->regs[i];
+		for (i = 0; i < BPF_REG_FP; i++)
+			cur->frame[j]->regs[i].live = REG_LIVE_NONE;
+	}
 
 	/* all stack frames are accessible from callee, clear them all */
 	for (j = 0; j <= cur->curframe; j++) {
-- 
2.20.1

