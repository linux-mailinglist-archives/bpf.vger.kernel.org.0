Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135716389C5
	for <lists+bpf@lfdr.de>; Fri, 25 Nov 2022 13:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiKYM3h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Nov 2022 07:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiKYM3f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Nov 2022 07:29:35 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A33C46648;
        Fri, 25 Nov 2022 04:29:33 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id b62so3882879pgc.0;
        Fri, 25 Nov 2022 04:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GmQ7BjLoCmFrUUEJVAI/nRPPy9EKlpRrKIvp2Rfiow=;
        b=icmAY7cFlJaqJGQGc01npRhRFtZ7qKc80BCB+W48FQLHHl2v8eZckLEacFz1L2qcQR
         AVY3CsavJZbbsVYFsI4YQsYyYq3eur+b1W4kexnYsqAC10NtAGppqNZgRqjYikh1b4fQ
         FkTakprNCco+xrZm+6rQJnF/J8jud6bDhY6kI4qVx3dymqfGW2O6c71RSebLzJtb1bKZ
         fQbANqU0ixtw+tRZvT0Y+LbEg0y1H05OJWgv4gkMnsfJGTT9I+7wpcrqEQhhPhswZtHM
         020iOZ2Q0HOzjfCcx/dc1hPMP9FF0H964WSZBt5RStKv9rFbVLwsuSGZ1/pr11+TqI6A
         G7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6GmQ7BjLoCmFrUUEJVAI/nRPPy9EKlpRrKIvp2Rfiow=;
        b=h8bTIvjwjBl5s5L5OPQU6UcKUQ3KtNnJoVihcz2rAopKaWw0anOCbWlcmjtGUPeQ5F
         kIbmXvI9/wfXwXM+QJgVr5L843XZReRz7QikSloJIj5010iSAh4pzmgV407c1aRGA0Nr
         9VyGhmX2jWnaw5saQqGBhgPBZZrSLJrMM/7yDzNxjS1/+m2cRSyYLSJYJ2TL0fwMdpv0
         s78yiTHIb3KKY5jbkS2dZHHm+kU40iUaUVDrHJJCrQlR1bFL8cwPJGetZUPt4MvJs/fE
         +XeAN/JuCEuoBFi6qnWiXZw7lovG42DPxpXFDBMgzsc+ecD9XCSdS61+5Dbwc91XZ4VB
         YM5Q==
X-Gm-Message-State: ANoB5pmIR0YQZ2ajouG+5Ab0ZPhHt6i8oKW2oc7x8r6WbiV5HL1vdmwo
        90G31L89zm19LAAkq8rTjVq8kO9VNY57
X-Google-Smtp-Source: AA0mqf5AN5atYKi0OTLDisR49lELfPQUfrtDWpwU5RzZy+dgzGkYpnT0HzL2t/IvFw2zGRuXd5trqA==
X-Received: by 2002:a63:5d62:0:b0:477:2263:a5d with SMTP id o34-20020a635d62000000b0047722630a5dmr24532980pgm.536.1669379372493;
        Fri, 25 Nov 2022 04:29:32 -0800 (PST)
Received: from localhost.localdomain ([144.214.0.6])
        by smtp.gmail.com with ESMTPSA id x14-20020a170902a38e00b0018912c37c8fsm117009pla.129.2022.11.25.04.29.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 25 Nov 2022 04:29:31 -0800 (PST)
From:   Hao Sun <sunhao.th@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, Hao Sun <sunhao.th@gmail.com>
Subject: [PATCH bpf-next v3 2/3] bpf: Sanitize LDX in jited BPF progs with KASAN
Date:   Fri, 25 Nov 2022 20:29:11 +0800
Message-Id: <20221125122912.54709-3-sunhao.th@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20221125122912.54709-1-sunhao.th@gmail.com>
References: <20221125122912.54709-1-sunhao.th@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make the verifier sanitize LDX insns in jited BPF programs. Saved
all the scratch regs to the extended stack first, skip backing up
of R0 if it is the dst_reg, then save checking addr to R1. Finally
the checking funcs are inserted, and regs are restored then.

Signed-off-by: Hao Sun <sunhao.th@gmail.com>
---
 kernel/bpf/verifier.c | 60 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7a31fceee370..b3b6855a9756 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15345,6 +15345,18 @@ BPF_ASAN_STORE(16);
 BPF_ASAN_STORE(32);
 BPF_ASAN_STORE(64);
 
+#define BPF_ASAN_LOAD(n)                          \
+	notrace u64 bpf_asan_load##n(u##n *addr); \
+	notrace u64 bpf_asan_load##n(u##n *addr)  \
+	{                                         \
+		return *addr;                     \
+	}
+
+BPF_ASAN_LOAD(8);
+BPF_ASAN_LOAD(16);
+BPF_ASAN_LOAD(32);
+BPF_ASAN_LOAD(64);
+
 #endif
 
 /* Do various post-verification rewrites in a single program pass.
@@ -15567,6 +15579,54 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			insn = new_prog->insnsi + i + delta;
 			continue;
 		}
+
+		/* Sanitize LDX operation*/
+		if (BPF_CLASS(insn->code) == BPF_LDX) {
+			struct bpf_insn sanitize_fn;
+			struct bpf_insn *patch = &insn_buf[0];
+
+			if (in_patch_use_ax || insn->src_reg == BPF_REG_10)
+				continue;
+
+			switch (BPF_SIZE(insn->code)) {
+			case BPF_B:
+				sanitize_fn = BPF_EMIT_CALL(bpf_asan_load8);
+				break;
+			case BPF_H:
+				sanitize_fn = BPF_EMIT_CALL(bpf_asan_load16);
+				break;
+			case BPF_W:
+				sanitize_fn = BPF_EMIT_CALL(bpf_asan_load32);
+				break;
+			case BPF_DW:
+				sanitize_fn = BPF_EMIT_CALL(bpf_asan_load64);
+				break;
+			}
+
+			BACKUP_SCRATCH_REGS;
+			/* Skip R0, if it is dst but not src */
+			if (insn->dst_reg != BPF_REG_0 || insn->src_reg == BPF_REG_0)
+				*patch++ = BPF_MOV64_REG(BPF_REG_AX, BPF_REG_0);
+			if (insn->src_reg != BPF_REG_1)
+				*patch++ = BPF_MOV64_REG(BPF_REG_1, insn->src_reg);
+			if (insn->off != 0)
+				*patch++ = BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, insn->off);
+			*patch++ = sanitize_fn;
+			RESTORE_SCRATCH_REGS;
+			if (insn->dst_reg != BPF_REG_0 || insn->src_reg == BPF_REG_0)
+				*patch++ = BPF_MOV64_REG(BPF_REG_0, BPF_REG_AX);
+			*patch++ = *insn;
+			cnt = patch - insn_buf;
+
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta += cnt - 1;
+			env->prog = prog = new_prog;
+			insn = new_prog->insnsi + i + delta;
+			continue;
+		}
 #endif
 
 		if (insn->code != (BPF_JMP | BPF_CALL))
-- 
2.38.1

