Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFCE969FC36
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 20:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjBVTaC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 14:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjBVT3q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 14:29:46 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFF631E2E
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 11:29:44 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id i11-20020a056a00224b00b005d44149eb06so1780621pfu.10
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 11:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CBY1EQ8rgvYwbAE0sNfh/NLDoFtyGrAczu8biZVyLX0=;
        b=o3icHyjxwvdHAhPRUh6Mt6hvF5TRYma19mD+TxcsNWR4dcwvzykuLrLgvdV+PDLtlF
         cdZvsk7or8RrIsU067FeiJHYoz+MPT+JgTTv0DBnRbYGcxzIwktwKnMLlU3p6gt6+w4i
         ids2WRyltylT6UatxWBrSQgsF5ZnyBuaHlLUMx9hJo5AXRIVF3HN2y7GZmBuKJv63Iha
         f/huLn96P2Rk1WA2a4IwinWnGiJJogk5K83YwSdyxlr2FWjfv6tZ657eAnaoBWAEcKHc
         g/qOWXwx5Qo25UH0yfAfr1AdI+cxaQHLySxnQAtq75ko8f0mKMqAWb1N3s+dJ5RVBYXZ
         VSlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CBY1EQ8rgvYwbAE0sNfh/NLDoFtyGrAczu8biZVyLX0=;
        b=mKh/Uuh3HD/NfelonxKCI2qWUJKQgCFXuibgMN03wpZ9WwwhL3f7u+jK5oZzhw4gC+
         R0kd1LScaL1ahLNNSEUWzGRwA5pwLp8pIht7NUtg0wT8s/m2BSHCAd6cfd9pktpUu8zI
         G9xbhK5ZBs/nVIjT5RB6YmtcqNnzdkxqCbuZjU82jX0d5mDl5p8CXL7P3JW7Bpl/vEFB
         tvUo/2knMakxAXXlD9G5rjY6KEKxw2p5Ob6c7qS0Ilri3qGBaKKj4656XoqhLAhzywi4
         VNg1aN5erNSw1KLETgURJ21PUvZasumHZ2z6FOGRiBhpnlEgKEftCmURmUqK0Ztt4Sbf
         9aYA==
X-Gm-Message-State: AO0yUKWuFvOzE5BjcrsZx1ukaUEsxJgg3dYky2tJ9tQfDQh7GrAZpAOC
        Y0CC4RLBGiqf7JKtF3qw+ot19NS3UQU=
X-Google-Smtp-Source: AK7set8IjtejlcQuK1gmqMMMCxx3rSvp07+jvv64f31bXlPR3CPC0jh/v1XrF0KwPfYEha3WiyIHCV9t+9A=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a62:a110:0:b0:5a8:c0ee:876f with SMTP id
 b16-20020a62a110000000b005a8c0ee876fmr1332747pff.3.1677094183762; Wed, 22 Feb
 2023 11:29:43 -0800 (PST)
Date:   Wed, 22 Feb 2023 19:29:24 +0000
In-Reply-To: <20230222192925.1778183-1-edliaw@google.com>
Mime-Version: 1.0
References: <20230222192925.1778183-1-edliaw@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230222192925.1778183-5-edliaw@google.com>
Subject: [PATCH 4.14 v2 4/4] bpf: Fix truncation handling for mod32 dst reg
 wrt zero
From:   Edward Liaw <edliaw@google.com>
To:     stable@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>
Cc:     bpf@vger.kernel.org, kernel-team@android.com,
        Edward Liaw <edliaw@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        John Fastabend <john.fastabend@gmail.com>,
        Salvatore Bonaccorso <carnil@debian.org>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>

Commit 9b00f1b78809309163dda2d044d9e94a3c0248a3 upstream.

Recently noticed that when mod32 with a known src reg of 0 is performed,
then the dst register is 32-bit truncated in verifier:

  0: R1=ctx(id=0,off=0,imm=0) R10=fp0
  0: (b7) r0 = 0
  1: R0_w=inv0 R1=ctx(id=0,off=0,imm=0) R10=fp0
  1: (b7) r1 = -1
  2: R0_w=inv0 R1_w=inv-1 R10=fp0
  2: (b4) w2 = -1
  3: R0_w=inv0 R1_w=inv-1 R2_w=inv4294967295 R10=fp0
  3: (9c) w1 %= w0
  4: R0_w=inv0 R1_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R2_w=inv4294967295 R10=fp0
  4: (b7) r0 = 1
  5: R0_w=inv1 R1_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R2_w=inv4294967295 R10=fp0
  5: (1d) if r1 == r2 goto pc+1
   R0_w=inv1 R1_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R2_w=inv4294967295 R10=fp0
  6: R0_w=inv1 R1_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R2_w=inv4294967295 R10=fp0
  6: (b7) r0 = 2
  7: R0_w=inv2 R1_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R2_w=inv4294967295 R10=fp0
  7: (95) exit
  7: R0=inv1 R1=inv(id=0,umin_value=4294967295,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R2=inv4294967295 R10=fp0
  7: (95) exit

However, as a runtime result, we get 2 instead of 1, meaning the dst
register does not contain (u32)-1 in this case. The reason is fairly
straight forward given the 0 test leaves the dst register as-is:

  # ./bpftool p d x i 23
   0: (b7) r0 = 0
   1: (b7) r1 = -1
   2: (b4) w2 = -1
   3: (16) if w0 == 0x0 goto pc+1
   4: (9c) w1 %= w0
   5: (b7) r0 = 1
   6: (1d) if r1 == r2 goto pc+1
   7: (b7) r0 = 2
   8: (95) exit

This was originally not an issue given the dst register was marked as
completely unknown (aka 64 bit unknown). However, after 468f6eafa6c4
("bpf: fix 32-bit ALU op verification") the verifier casts the register
output to 32 bit, and hence it becomes 32 bit unknown. Note that for
the case where the src register is unknown, the dst register is marked
64 bit unknown. After the fix, the register is truncated by the runtime
and the test passes:

  # ./bpftool p d x i 23
   0: (b7) r0 = 0
   1: (b7) r1 = -1
   2: (b4) w2 = -1
   3: (16) if w0 == 0x0 goto pc+2
   4: (9c) w1 %= w0
   5: (05) goto pc+1
   6: (bc) w1 = w1
   7: (b7) r0 = 1
   8: (1d) if r1 == r2 goto pc+1
   9: (b7) r0 = 2
  10: (95) exit

Semantics also match with {R,W}x mod{64,32} 0 -> {R,W}x. Invalid div
has always been {R,W}x div{64,32} 0 -> 0. Rewrites are as follows:

  mod32:                            mod64:

  (16) if w0 == 0x0 goto pc+2       (15) if r0 == 0x0 goto pc+1
  (9c) w1 %= w0                     (9f) r1 %= r0
  (05) goto pc+1
  (bc) w1 = w1

[Salvatore Bonaccorso: This is an earlier version based on work by
Daniel and John which does not rely on availability of the BPF_JMP32
instruction class. This means it is not even strictly a backport of the
upstream commit mentioned but based on Daniel's and John's work to
address the issue and was finalized by Thadeu Lima de Souza Cascardo.]

Fixes: 468f6eafa6c4 ("bpf: fix 32-bit ALU op verification")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: John Fastabend <john.fastabend@gmail.com>
Tested-by: Salvatore Bonaccorso <carnil@debian.org>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
---
 kernel/bpf/verifier.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9f04d413df92..a55e264cdb54 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4846,7 +4846,7 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
 			bool is64 = BPF_CLASS(insn->code) == BPF_ALU64;
 			struct bpf_insn mask_and_div[] = {
 				BPF_MOV_REG(BPF_CLASS(insn->code), BPF_REG_AX, insn->src_reg),
-				/* Rx div 0 -> 0 */
+				/* [R,W]x div 0 -> 0 */
 				BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, 2),
 				BPF_RAW_REG(*insn, insn->dst_reg, BPF_REG_AX),
 				BPF_JMP_IMM(BPF_JA, 0, 0, 1),
@@ -4854,9 +4854,10 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
 			};
 			struct bpf_insn mask_and_mod[] = {
 				BPF_MOV_REG(BPF_CLASS(insn->code), BPF_REG_AX, insn->src_reg),
-				/* Rx mod 0 -> Rx */
-				BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, 1),
+				BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, 1 + (is64 ? 0 : 1)),
 				BPF_RAW_REG(*insn, insn->dst_reg, BPF_REG_AX),
+				BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+				BPF_MOV32_REG(insn->dst_reg, insn->dst_reg),
 			};
 			struct bpf_insn *patchlet;
 
@@ -4866,7 +4867,7 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
 				cnt = ARRAY_SIZE(mask_and_div);
 			} else {
 				patchlet = mask_and_mod;
-				cnt = ARRAY_SIZE(mask_and_mod);
+				cnt = ARRAY_SIZE(mask_and_mod) - (is64 ? 2 : 0);
 			}
 
 			new_prog = bpf_patch_insn_data(env, i + delta, patchlet, cnt);
-- 
2.39.2.637.g21b0678d19-goog

