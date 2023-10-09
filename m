Return-Path: <bpf+bounces-11702-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2769F7BD950
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 13:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEC4728174E
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 11:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52C7171B3;
	Mon,  9 Oct 2023 11:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyKZ8Xcu"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C886B1171E
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 11:12:39 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6E694;
	Mon,  9 Oct 2023 04:12:38 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-405497850dbso40792215e9.0;
        Mon, 09 Oct 2023 04:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696849956; x=1697454756; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=er7cddzQstZpFxcdLakPZUUkD06YhuxbDUUxJ2NUqkQ=;
        b=RyKZ8XcuK5mhjvVE4OscfXV00ahPF7K8bV0JWsOdpcKGqTIWun3PSssg5ks4C7xHzo
         R8zbbr4NuyEtgOSmU9fjgQNSPOJdSgBNsw/y2Sp3foNHtpgwR22ZwbsjN7QRR3NfhDGW
         xxP4NQ/Z+p2f79jEJfeWNfVOXqVHOQSVP+M5+frLnzz2rMjFLM2Oi97MrvGEb/2MjSvg
         3PXQ2zplh1raedE3UAz8MIiw89+BznXaH7zU/LdZptGImx6Vt5DHr22d3wdJu0wam5f/
         gEZ4gm8KghLF1WtZMfTEFBTcC0RXS/sFKeY7WMuPYMECnWXnrK0jxpUlPbx1ikcEbnFx
         irYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696849956; x=1697454756;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=er7cddzQstZpFxcdLakPZUUkD06YhuxbDUUxJ2NUqkQ=;
        b=tkI+/oG4bUj7Lux1yUgtl8H9PQPf2pi0qI/kRCDbxxDdMic/NmLetS8cOKzS8IKC6h
         PcqItoUHl/3A+/2RxdUCg4blhiSP5rzoFvFEvWkM2wZVjLdXWjZbVVI9wF7PcXZyH/fT
         Kapdez2krj3q55HwgDD8yl2fYGZ2ZOwfr4iTQ3bkkL1uV33U7nWBJ2dF0K5OzrKkBgVZ
         6/CHAcp4TnfpH/3/6MRHMro8FXcb+hq5pattgW/Gd+9EtYjgIWGXl2ZLyJiKLQnhxeCd
         8CHfINdiqsH1phywHEmyNgmEg2JhUxy3tGunMVn2bAJrgUoAz7EC4F5iIh32z9bPxNY3
         N+Yw==
X-Gm-Message-State: AOJu0YxuNwBbQ9p0gTmD1Mg5djzgQEqmmsuKHSIx2YoUjsuHXlVD6Pgw
	9mh9/mnieFR8eO8TXWcMaO/Uw/eOUw==
X-Google-Smtp-Source: AGHT+IEfMal/y1YXs3d3fjAHUYDtoTbl97gsCwi8vCSTLWnqdCIa5qWPs661zfQeCM89MtfOL0Zg7A==
X-Received: by 2002:a5d:6a07:0:b0:314:350a:6912 with SMTP id m7-20020a5d6a07000000b00314350a6912mr13366375wru.36.1696849955951;
        Mon, 09 Oct 2023 04:12:35 -0700 (PDT)
Received: from amdsuplus2.inf.ethz.ch (amdsuplus2.inf.ethz.ch. [129.132.31.88])
        by smtp.gmail.com with ESMTPSA id n8-20020a5d4208000000b003253523d767sm9285019wrq.109.2023.10.09.04.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 04:12:35 -0700 (PDT)
From: Hao Sun <sunhao.th@gmail.com>
Date: Mon, 09 Oct 2023 13:12:02 +0200
Subject: [PATCH bpf-next] Detect jumping to reserved code during
 check_cfg()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231009-jmp-into-reserved-fields-v1-1-d8006e2ac1f6@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAHgI2UC/x3MQQ6DIBBG4auYWXcS0EXFqzRdIPy001gkYIyJ4
 e4Sl2/xvZMKsqDQ1J2UsUuRNbbQj47c18YPWHxr6lU/aKUM//6JJW4rZzS6w3MQLL5wcNqa0Y5
 4ekeNp4wgx71+0ZwCRxwbvWu9AJ+Mgb90AAAA
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hao Sun <sunhao.th@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696849955; l=2372;
 i=sunhao.th@gmail.com; s=20231009; h=from:subject:message-id;
 bh=wf3i1Iv2g4OKCrVAVIuikfMpT8jO6JJjtxyGZjBPh+c=;
 b=NXxUFgPTG86JjkxKihOaSnVsPPFSRBFPQbNOwB4RujNLdjlbxW0UY1ypBJs5EjMP9AhyMIfdC
 8bAQvRSF97OC6Ska02pyK6OVt5hHPEL/fAU4xW3MB7c37zjIy8xsGdy
X-Developer-Key: i=sunhao.th@gmail.com; a=ed25519;
 pk=AHFxrImGtyqXOuw4f5xTNh4PGReb7hzD86ayyTZCXd4=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently, we don't check if the branch-taken of a jump is reserved code of
ld_imm64. Instead, such a issue is captured in check_ld_imm(). The verifier
gives the following log in such case:

func#0 @0
0: R1=ctx(off=0,imm=0) R10=fp0
0: (18) r4 = 0xffff888103436000       ; R4_w=map_ptr(off=0,ks=4,vs=128,imm=0)
2: (18) r1 = 0x1d                     ; R1_w=29
4: (55) if r4 != 0x0 goto pc+4        ; R4_w=map_ptr(off=0,ks=4,vs=128,imm=0)
5: (1c) w1 -= w1                      ; R1_w=0
6: (18) r5 = 0x32                     ; R5_w=50
8: (56) if w5 != 0xfffffff4 goto pc-2
mark_precise: frame0: last_idx 8 first_idx 0 subseq_idx -1
mark_precise: frame0: regs=r5 stack= before 6: (18) r5 = 0x32
7: R5_w=50
7: BUG_ld_00
invalid BPF_LD_IMM insn

Here the verifier rejects the program because it thinks insn at 7 is an
invalid BPF_LD_IMM, but such a error log is not accurate since the issue
is jumping to reserved code not because the program contains invalid insn.
Therefore, make the verifier check the jump target during check_cfg(). For
the same program, the verifier reports the following log:

func#0 @0
jump to reserved code from insn 8 to 7

---


Signed-off-by: Hao Sun <sunhao.th@gmail.com>
---
 kernel/bpf/verifier.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index eed7350e15f4..725ac0b464cf 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14980,6 +14980,7 @@ static int push_insn(int t, int w, int e, struct bpf_verifier_env *env,
 {
 	int *insn_stack = env->cfg.insn_stack;
 	int *insn_state = env->cfg.insn_state;
+	struct bpf_insn *insns = env->prog->insnsi;
 
 	if (e == FALLTHROUGH && insn_state[t] >= (DISCOVERED | FALLTHROUGH))
 		return DONE_EXPLORING;
@@ -14993,6 +14994,12 @@ static int push_insn(int t, int w, int e, struct bpf_verifier_env *env,
 		return -EINVAL;
 	}
 
+	if (e == BRANCH && insns[w].code == 0) {
+		verbose_linfo(env, t, "%d", t);
+		verbose(env, "jump to reserved code from insn %d to %d\n", t, w);
+		return -EINVAL;
+	}
+
 	if (e == BRANCH) {
 		/* mark branch target for state pruning */
 		mark_prune_point(env, w);

---
base-commit: 3157b7ce14bbf468b0ca8613322a05c37b5ae25d
change-id: 20231009-jmp-into-reserved-fields-fc1a98a8e7dc

Best regards,
-- 
Hao Sun <sunhao.th@gmail.com>


