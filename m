Return-Path: <bpf+bounces-11805-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D547BFAAB
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 14:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3AFF281EBE
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 12:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1111945B;
	Tue, 10 Oct 2023 12:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbSuPglF"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588DE18C2F
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 12:03:39 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A8E10A;
	Tue, 10 Oct 2023 05:03:36 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-533d6a8d6b6so9910451a12.2;
        Tue, 10 Oct 2023 05:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696939415; x=1697544215; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3QU3PwQpjqDTM6ARGvE2fQcte1+YvyH9JIw+Vq8yPYQ=;
        b=UbSuPglFqpfeqlNuKh9Ts4i5IAk9Ly08u2iDtP18eG1AbQCkle0LpLinJ7uuM0pdhv
         fi5bMl1Zxuxx2Yk6xD2LcbIRRI2sDqN+uXqZAyAV74sF9azzLDeMw7hJ2U6nJtKmnDsi
         ZKgb5Cp5axduLXwIt5uFNfXKE4hE9u064HZUbCbEp5U9lBmlNoVfLqnUQ+4Mdy9fkG9+
         IUHXdFK1ErDdThVNwymkrNZzxjgfIkqtV7kNkoPgGQA8NQugo4wFBag+9gvFoWx3NpxX
         89QIoDO71Co2uBGOJUJX2gKO5guAqCvS1qmp25dQE63GPjX62t3VQwKJ5cPqHYtdSSgA
         No1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696939415; x=1697544215;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3QU3PwQpjqDTM6ARGvE2fQcte1+YvyH9JIw+Vq8yPYQ=;
        b=mdOy8ePZjk6AH/rPIsPYzAjSMLzo5WV/BWpLQeO+RXFozrzuerDlC66PA67BGZu5Y1
         wRCVkdUL1zsokiiPwMx5qCYH7MM3VHvJcW+IFhuCgulMzG9nZiJeETVS1GSriGU6m4co
         MKcTio8L6Q3fxYMEobxRZ2TVifOazgZa82mv06j7KYb6PdHJcSDs2e4UvJTdl+5dwILH
         dbwQAa+ecRKw/8an9UuSIu0Nb2EBY1YRSDtE5QR846isw/eso49/kOEuMsgE6GKaIkZ8
         75tA4dA52flyPWlslxxf4kwSXchMWyi/vwLWWfb2olbkgOWMjGtgs8Ig2com0Fn/YW66
         ctRA==
X-Gm-Message-State: AOJu0YzACky+vLWf41opZsNVNNR3J3t6bCaGmCHqss9E7IX9LRp/wM6+
	cv2y31W6cmxHdJWetp5jU3eBGVDlKQ==
X-Google-Smtp-Source: AGHT+IF/tWJ1KutsNNz1uLCzTvVJEkOGWBoJioY255Spp6TsYSam8mdDi57SwknUmTA+yZxjelMoKA==
X-Received: by 2002:a17:907:7ea0:b0:9a5:9038:b1e7 with SMTP id qb32-20020a1709077ea000b009a59038b1e7mr20607755ejc.36.1696939414903;
        Tue, 10 Oct 2023 05:03:34 -0700 (PDT)
Received: from amdsuplus2.inf.ethz.ch (amdsuplus2.inf.ethz.ch. [129.132.31.88])
        by smtp.gmail.com with ESMTPSA id f19-20020a1c6a13000000b00402d34ea099sm16180238wmc.29.2023.10.10.05.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 05:03:34 -0700 (PDT)
From: Hao Sun <sunhao.th@gmail.com>
Date: Tue, 10 Oct 2023 14:03:10 +0200
Subject: [PATCH bpf-next v2] bpf: Detect jumping to reserved code during
 check_cfg()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231010-jmp-into-reserved-fields-v2-1-3dd5a94d1e21@gmail.com>
X-B4-Tracking: v=1; b=H4sIAH09JWUC/4WNQQqDMBBFryKz7pQkBatd9R7FRZpMdIomIZFgE
 e/e4AW6fHze+ztkSkwZHs0OiQpnDr6CujRgJu1HQraVQQl1k0L0+Fkisl8DJqpqIYuOabYZnZG
 673RHd2ug6jGR4+1Mv+AdHXraVhjqMnFeQ/qen0We+/98kSjRdkK0pLSRrn2Oi+b5asICw3EcP
 zVaZh7KAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696939413; l=3633;
 i=sunhao.th@gmail.com; s=20231009; h=from:subject:message-id;
 bh=9nXWIPuvSUGi4Z84VWvR7lpi2K+zCG9H/VEpd14wmT8=;
 b=TJ63EWyTBwXVDlh/IX3C8NqOmRUioXFxryWf/OrFDWyz4xcuWWHr667fZ9hLQe/Gk4e4n2PtQ
 9Yh+XY9sOPhAirRWn/F/x9/YGqeMiN27ztlskxMwaLfQmOO7dz8SHJ+
X-Developer-Key: i=sunhao.th@gmail.com; a=ed25519;
 pk=AHFxrImGtyqXOuw4f5xTNh4PGReb7hzD86ayyTZCXd4=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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

Also adjust existing tests in ld_imm64.c, testing forward/back jump to
reserved code.

Signed-off-by: Hao Sun <sunhao.th@gmail.com>
---
Changes in v2:
- Adjust existing test cases
- Link to v1: https://lore.kernel.org/bpf/20231009-jmp-into-reserved-fields-v1-1-d8006e2ac1f6@gmail.com/
---
 kernel/bpf/verifier.c                           | 7 +++++++
 tools/testing/selftests/bpf/verifier/ld_imm64.c | 8 +++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

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
diff --git a/tools/testing/selftests/bpf/verifier/ld_imm64.c b/tools/testing/selftests/bpf/verifier/ld_imm64.c
index f9297900cea6..c34aa78f1877 100644
--- a/tools/testing/selftests/bpf/verifier/ld_imm64.c
+++ b/tools/testing/selftests/bpf/verifier/ld_imm64.c
@@ -9,22 +9,20 @@
 	BPF_MOV64_IMM(BPF_REG_0, 2),
 	BPF_EXIT_INSN(),
 	},
-	.errstr = "invalid BPF_LD_IMM insn",
-	.errstr_unpriv = "R1 pointer comparison",
+	.errstr = "jump to reserved code",
 	.result = REJECT,
 },
 {
 	"test2 ld_imm64",
 	.insns = {
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
 	BPF_LD_IMM64(BPF_REG_0, 0),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, -2),
 	BPF_LD_IMM64(BPF_REG_0, 0),
 	BPF_LD_IMM64(BPF_REG_0, 1),
 	BPF_LD_IMM64(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	},
-	.errstr = "invalid BPF_LD_IMM insn",
-	.errstr_unpriv = "R1 pointer comparison",
+	.errstr = "jump to reserved code",
 	.result = REJECT,
 },
 {

---
base-commit: 3157b7ce14bbf468b0ca8613322a05c37b5ae25d
change-id: 20231009-jmp-into-reserved-fields-fc1a98a8e7dc

Best regards,
-- 
Hao Sun <sunhao.th@gmail.com>


