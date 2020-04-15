Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180341AB2E2
	for <lists+bpf@lfdr.de>; Wed, 15 Apr 2020 23:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438176AbgDOUsO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Apr 2020 16:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2438015AbgDOUsN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 15 Apr 2020 16:48:13 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2150C061A0C
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2020 13:48:12 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id j12so567028wrr.18
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2020 13:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=rjzcjb/bQPDNviyt2sPsZPltCFMp8BiGQ60Gy3cwjMA=;
        b=ELPwg0wQpckplvDqgq/mtwUdENH/PVzfd8E6bELnegHBuHnLrtjiXKnZDrXtDBq/kG
         wSRvwaYLD7fbcdIKOrNefWMQCkBW7QEWH7SMNM2jrf698FRNRJPR/E0bDGkXaZPDR0bE
         pQuRQ/y1PThCzEkL1UOC4FSej/M+mzhKZth1JSQ2DISfsjUHCbrRM1kbL5ZvoGAjIOR6
         mIpuzvCBn43L1gzAqd+De+ZuOMJElEbjYKAKhv5sjMPmDw+5grzZSNhvUoSiIMqzb8bg
         XOs4H9+a+cxcJYUyAgN0czDkbdhPM2UJWZAxaXEm1wTbA4dEnzble/dOwdoRXZ7kUFMQ
         deEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=rjzcjb/bQPDNviyt2sPsZPltCFMp8BiGQ60Gy3cwjMA=;
        b=L5ZrrsQb0OHR/q98lC/m5N03E66C8z/bET1aiOZ9TMcKDRPY8RImecZ8cQqPAadMJt
         geO5IzV1ekG/NwpVZUln22YPYaRz5bjeTLx8HZWUb1AU0+EtqyXSdyShWMKXjt6TZ5WE
         5TzrAKwZTOQpwrSokuQ78x59OdV5cRhFsaNoP785m52I8ePieCjZ6uhNQrfKXstGIL68
         YYqeiMNr951RIN15MbbJBh3WFxlaqL4x0GEer8toAmNSfAZUo5v/2j9aEsA1V3X4x2Hg
         fPua4gZaFkYK9LH5kDUT5iJNilnaWmF24Nl9w0jVlxhPQRHxopuuIABWHw3fpZXeiSsm
         tW3Q==
X-Gm-Message-State: AGi0Pub2myfcF2bC95tuNLKfHlZxPWXVV30ei97ZHhcahbcXwQvGxTGh
        5E0IS1yOGaYRrWT2OD8Ow1M7P18k/tqu+8VcPJU01CkMYiBfE8IjdDapeavVqUVBwTi3sBt45b1
        H/lKhXIRYU1SH5NzOSBda57zmjmXwwG1+0tOOSlBIJgM8xE9MTy1GJAU=
X-Google-Smtp-Source: APiQypKDe2g3J0jWNrqKmJ0h7aRpbt+PYxVirHwm7VJdlOH9O8Ia7a9ApmtarGVGFXMi+fsVUpRVLrWI7w==
X-Received: by 2002:a5d:53c4:: with SMTP id a4mr29673340wrw.47.1586983690071;
 Wed, 15 Apr 2020 13:48:10 -0700 (PDT)
Date:   Wed, 15 Apr 2020 22:47:43 +0200
Message-Id: <20200415204743.206086-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH bpf] bpf: Use pointer type whitelist for XADD
From:   Jann Horn <jannh@google.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

At the moment, check_xadd() uses a blacklist to decide whether a given
pointer type should be usable with the XADD instruction. Out of all the
pointer types that check_mem_access() accepts, only four are currently let
through by check_xadd():

PTR_TO_MAP_VALUE
PTR_TO_CTX           rejected
PTR_TO_STACK
PTR_TO_PACKET        rejected
PTR_TO_PACKET_META   rejected
PTR_TO_FLOW_KEYS     rejected
PTR_TO_SOCKET        rejected
PTR_TO_SOCK_COMMON   rejected
PTR_TO_TCP_SOCK      rejected
PTR_TO_XDP_SOCK      rejected
PTR_TO_TP_BUFFER
PTR_TO_BTF_ID

Looking at the currently permitted ones:

 - PTR_TO_MAP_VALUE: This makes sense and is the primary usecase for XADD.
 - PTR_TO_STACK: This doesn't make much sense, there is no concurrency on
   the BPF stack. It also causes confusion further down, because the first
   check_mem_access() won't check whether the stack slot being read from is
   STACK_SPILL and the second check_mem_access() assumes in
   check_stack_write() that the value being written is a normal scalar.
   This means that unprivileged users can leak kernel pointers.
 - PTR_TO_TP_BUFFER: This is a local output buffer without concurrency.
 - PTR_TO_BTF_ID: This is read-only, XADD can't work. When the verifier
   tries to verify XADD on such memory, the first check_ptr_to_btf_access()
   invocation gets confused by value_regno not being a valid array index
   and writes to out-of-bounds memory.

Limit XADD to PTR_TO_MAP_VALUE, since everything else at least doesn't make
sense, and is sometimes broken on top of that.

Fixes: 17a5267067f3 ("bpf: verifier (add verifier core)")
Signed-off-by: Jann Horn <jannh@google.com>
---
I'm just sending this on the public list, since the worst-case impact for
non-root users is leaking kernel pointers to userspace. In a context where
you can reach BPF (no sandboxing), I don't think that kernel ASLR is very
effective at the moment anyway.

This breaks ten unit tests that assume that XADD is possible on the stack,
and I'm not sure how all of them should be fixed up; I'd appreciate it if
someone else could figure out how to fix them. I think some of them might
be using XADD to cast pointers to numbers, or something like that? But I'm
not sure.

Or is XADD on the stack actually something you want to support for some
reason, meaning that that part would have to be fixed differently?

 kernel/bpf/verifier.c | 27 +--------------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 38cfcf701eeb7..397c17a2e970f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2699,28 +2699,6 @@ static bool is_ctx_reg(struct bpf_verifier_env *env, int regno)
 	return reg->type == PTR_TO_CTX;
 }
 
-static bool is_sk_reg(struct bpf_verifier_env *env, int regno)
-{
-	const struct bpf_reg_state *reg = reg_state(env, regno);
-
-	return type_is_sk_pointer(reg->type);
-}
-
-static bool is_pkt_reg(struct bpf_verifier_env *env, int regno)
-{
-	const struct bpf_reg_state *reg = reg_state(env, regno);
-
-	return type_is_pkt_pointer(reg->type);
-}
-
-static bool is_flow_key_reg(struct bpf_verifier_env *env, int regno)
-{
-	const struct bpf_reg_state *reg = reg_state(env, regno);
-
-	/* Separate to is_ctx_reg() since we still want to allow BPF_ST here. */
-	return reg->type == PTR_TO_FLOW_KEYS;
-}
-
 static int check_pkt_ptr_alignment(struct bpf_verifier_env *env,
 				   const struct bpf_reg_state *reg,
 				   int off, int size, bool strict)
@@ -3298,10 +3276,7 @@ static int check_xadd(struct bpf_verifier_env *env, int insn_idx, struct bpf_ins
 		return -EACCES;
 	}
 
-	if (is_ctx_reg(env, insn->dst_reg) ||
-	    is_pkt_reg(env, insn->dst_reg) ||
-	    is_flow_key_reg(env, insn->dst_reg) ||
-	    is_sk_reg(env, insn->dst_reg)) {
+	if (reg_state(env, insn->dst_reg)->type != PTR_TO_MAP_VALUE) {
 		verbose(env, "BPF_XADD stores into R%d %s is not allowed\n",
 			insn->dst_reg,
 			reg_type_str[reg_state(env, insn->dst_reg)->type]);

base-commit: 87b0f983f66f23762921129fd35966eddc3f2dae
-- 
2.26.0.110.g2183baf09c-goog

