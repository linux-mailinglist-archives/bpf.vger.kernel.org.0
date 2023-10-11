Return-Path: <bpf+bounces-11870-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DCC7C4DED
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 11:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C85802824B8
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 09:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595651A717;
	Wed, 11 Oct 2023 09:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpG1SIAa"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CF61A5BD
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 09:01:14 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43100B8;
	Wed, 11 Oct 2023 02:01:12 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3248ac76acbso5792329f8f.1;
        Wed, 11 Oct 2023 02:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697014870; x=1697619670; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f24fRQOC4uNiaUVlL6gWGvPT3XEkaGKsCGt0d1J4olo=;
        b=NpG1SIAaJfF5CBPsNL3ABYl4dEjz2howZX3rw3QPRsUGytN9mO7mFkQtaQ8K3TazIF
         oIWUPn0T9J8Lcz/rTcqJIItu/lktlGuI7eK77BHKVO/Xh0nJvVO4xybaHjuF6DbJC5wH
         vnxOe9AC4X7KK43e86BSsRTijhxBtfnAQPB0aKFwOnQPWpCyX8fliJsuOzReujMvxlA+
         g34zy7lnmAqTX7879vjTsaZd4Bs6a0PDJ1W06elvgN4Uk1DcSsHqGKOQY969nKasC6kS
         wYVSuVkwrqViOy9QGXibPNZYm/NMNGO04cjet8e9I1dUPZpwwIpvqlPq2r7yFQdzUP/O
         J6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697014870; x=1697619670;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f24fRQOC4uNiaUVlL6gWGvPT3XEkaGKsCGt0d1J4olo=;
        b=DlmAxzPiNot8oHCNb/3Yl5gTSYe2oHoVl3qF2+rDk7SV2P64k7Ydyx7A57JnE549Mi
         9P8DWeeMPd38xQm9ElN37SgwqdjLZyWQRPgcHkdVnLu2hln64tAlfbrbynmZ8Gst/CYo
         GwoVNft8bqcw+p7z8Lm9DKcb4v83cQcRq5BUt3JN9CCav1OG0E7Yj7LzDu0YJTi972wE
         5CRTVIEm5Ad8AnY3u2uMYRy9qJmuZwqREA0EjNDKC1aWV48vEqvcqQRviw/tsXTpsO64
         muWMiTiM/uxySmvW11hFqbfhsmBH7mQvm2JclN5FZaPtuh6vUgN8s0Ab0mMqHmTFP2w5
         wFPg==
X-Gm-Message-State: AOJu0YxS59fRuKHv/ehUFQBMZZk0/djry1vOPQU1v8douXEVVqT/J8ts
	jvvNFz8EloMtg6bGQzjd8w==
X-Google-Smtp-Source: AGHT+IFZ8B7AW/gpA4zlK0QJySIGjwYuRq65jEcbossgKmFXjmCbs1e7uUgbuuJe0vdGsQEcI3mpGQ==
X-Received: by 2002:a5d:6c69:0:b0:32c:eeee:d438 with SMTP id r9-20020a5d6c69000000b0032ceeeed438mr4254852wrz.54.1697014870092;
        Wed, 11 Oct 2023 02:01:10 -0700 (PDT)
Received: from amdsuplus2.inf.ethz.ch (amdsuplus2.inf.ethz.ch. [129.132.31.88])
        by smtp.gmail.com with ESMTPSA id e28-20020adfa45c000000b0032d892e70b4sm554100wra.37.2023.10.11.02.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 02:01:09 -0700 (PDT)
From: Hao Sun <sunhao.th@gmail.com>
Date: Wed, 11 Oct 2023 11:00:12 +0200
Subject: [PATCH bpf-next v3 1/3] bpf: Detect jumping to reserved code
 during check_cfg()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231011-jmp-into-reserved-fields-v3-1-97d2aa979788@gmail.com>
References: <20231011-jmp-into-reserved-fields-v3-0-97d2aa979788@gmail.com>
In-Reply-To: <20231011-jmp-into-reserved-fields-v3-0-97d2aa979788@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697014868; l=2204;
 i=sunhao.th@gmail.com; s=20231009; h=from:subject:message-id;
 bh=7s+armAaYgTmOreMAmq1jM/+UHfkYy/CB5LBWoJG5Iw=;
 b=2JmzEYZ+jW5EuRoYwV8LO5vTobCF/hr7/JvRBRIxjqeRNiFvqhUCSds3+XZsFioYRH9g6xPy/
 zB6WNafvlcTAn1hD/UEfkfB5z+yyyzMWkzsW6Q1xoeMh1M6bC4zHWb3
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

-- 
2.34.1


