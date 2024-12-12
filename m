Return-Path: <bpf+bounces-46743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1009EFDEF
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 22:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28FDF1883F9C
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 21:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0A31C5F2C;
	Thu, 12 Dec 2024 21:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="TY1pm04/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E311ABECF
	for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 21:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734037744; cv=none; b=ZE/wAtYZhGXBQVWmHeDN2PcKxWWGf7hWkqQJoEdT6O504ySDCs7nhQ3LY9GIilV5xs9xtVTLNZGseoqgDe0pC50AYOwQn+qmeCiOqKIhsDQXuPEoFNEuC/gEq5SZDJr85z2NxHSL6NvcvMTMSrDUEQ6tu9ZF3wrTFKqd37T+ceQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734037744; c=relaxed/simple;
	bh=7Aon4Qg4yicuQ4PlZgSYUDo48kGgnNh0KkENLvF5FqA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nbopYeIdXa5Ha0Z3tNSEaEyA4oo8sQ4k8eyTxsAkRzGABZH4T9zbnXcB6UiUf49j+TufWg1bdVhMiqgjpJdbxreIKdFAQIOi/ThsSPwtsj6xjlrFgNBPCflS2tNiZsGEA/Wq7Qp0yJC2yqNvIwJIL7EdXvK69xYPlCHaX+6Uyo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=TY1pm04/; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385ed7f6605so582311f8f.3
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 13:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1734037740; x=1734642540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GYTrz6QMpF5OmUeCVT0jebqGZx29m4a4xd1ue17rPNE=;
        b=TY1pm04/4RvAietqmNBWhRgGateG9NOkBQfRa7x4rc06EWZld1ISDR5Xe4whT27ZIJ
         2uFlNHjCyiysA8aYiu4LHzpOmEcgYz11YAx4rkMgsWYIXAara1qY7uQdtVmzGbUSanNE
         3tdUKkbgq3uL55t8tQOYUH2z5MTzPdGi7JCIaaiWMzsPqhz+4FKZZUMMt4c4YU3qwKHu
         ofI9uzV0ZfvjV302n2kNhGim3pHbAhuEv91xXhrSZ2di40T8QeWCvcq+hn+MSeVLagMk
         ka6sNwykKb4RnI2Uz/sloUj4ic8YVmzkfuiV0QHwpDrTO6wIHwafeXaVtDHgyQ3inVcB
         FDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734037740; x=1734642540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GYTrz6QMpF5OmUeCVT0jebqGZx29m4a4xd1ue17rPNE=;
        b=xRSSi7+NcmW0SZmPU2Dsvlj4MhQLfENKcZ6Kq9pqUijY5ZpCPN+setcwo2gkIdwRgd
         9JNKwqQJb+Q/f6oxSissXy7Fy1dHTE+UciEH4E3JWTkOrnMrEtH4cewrjGmD5dLUdnwh
         0ugvHM+xgAh1gLPbbwgz0gLxe/77iAmRYq8ObMXxnjCi0IT5EgUR6Mk0TI0zbzmHjp5N
         EfcqshkPBsL6e3uqwe3+TmyAmistTNygmayyCk20RHpXSXLn5BRwertI54LYLUDt/mwQ
         AzNHNmAFjIOYOAN+JlcR5tTrgAVkRoo53r8bU9H4+a/MXTThaV64kZ4dAiSpl/KB5XRj
         zjGg==
X-Gm-Message-State: AOJu0Yx3n6qvWBqp+E8kMkkTdwDWb7J1BZDIhW/bLmlGkoggN99rtZdL
	VH9GRaxQt3mjaot6PwjnFBtTzV6dGhbAv7ouNEfv2k8AQIy7C4CRBgH7KwcGrqvae+xm1Jzsxt8
	rcZ8nTA==
X-Gm-Gg: ASbGnct6p2CD4W2MLJM0uAcs2MvRDAR/IDn1zoIH91zx5cDXDjuigWZapcW+CqdEeXa
	K/JWX5zFNNV3w8kZnLIAplPoNEpIKt05MWx+qpy47glZ07szy/jfNIF1TdfyxJycuP0+D/YUyJB
	2XO0immyB3MNm8ASYjHC6My7sgZW+JO8MGAMLCRcLeLpTw0tePMU5OQqU5rdPixk6bCr6YyiS3g
	4tMN/de0t/KDZWlZD5G7EBAhAogkKObJhIYh5s=
X-Google-Smtp-Source: AGHT+IGryUYkpoRYCkrP/In0Ei7efM4XiMZ0esXbT3BuY0p9h6ptW7FH8spkBEjarkCqGU6ES9Up7A==
X-Received: by 2002:a5d:64a1:0:b0:385:f7a3:fea6 with SMTP id ffacd0b85a97d-38880ad88c6mr92028f8f.13.1734037740239;
        Thu, 12 Dec 2024 13:09:00 -0800 (PST)
Received: from bobby.. ([2a09:bac1:27c0:58::3b6:40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38782514db8sm5113689f8f.84.2024.12.12.13.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 13:08:59 -0800 (PST)
From: Arthur Fabre <afabre@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	kernel-team@cloudflare.com,
	Arthur Fabre <afabre@cloudflare.com>
Subject: [PATCH] bpf: Don't trust r0 bounds after BPF to BPF call that tail_calls
Date: Thu, 12 Dec 2024 22:07:48 +0100
Message-Id: <20241212210748.1305855-1-afabre@cloudflare.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When making BPF to BPF calls, the verifier propagates register bounds
info for r0 from the callee to the caller.

For example loading:

    #include <linux/bpf.h>
    #include <bpf/bpf_helpers.h>

    static __attribute__((noinline)) int callee(struct xdp_md *ctx)
    {
            int ret;
            asm volatile("%0 = 23" : "=r"(ret));
            return ret;
    }

    static SEC("xdp") int caller(struct xdp_md *ctx)
    {
            int res = callee(ctx);
            if (res == 23) {
                    return XDP_PASS;
            }
            return XDP_DROP;
    }

The verifier logs:

    func#0 @0
    func#1 @6
    0: R1=ctx() R10=fp0
    ; int res = callee(ctx); @ test.c:15
    0: (85) call pc+5
    caller:
     R10=fp0
    callee:
     frame1: R1=ctx() R10=fp0
    6: frame1: R1=ctx() R10=fp0
    ; asm volatile("%0 = 23" : "=r"(ret)); @ test.c:9
    6: (b7) r0 = 23                       ; frame1: R0_w=23
    ; return ret; @ test.c:10
    7: (95) exit
    returning from callee:
     frame1: R0_w=23 R1=ctx() R10=fp0
    to caller at 1:
     R0_w=23 R10=fp0

    from 7 to 1: R0_w=23 R10=fp0
    ; int res = callee(ctx); @ test.c:15
    1: (bc) w1 = w0                       ; R0_w=23 R1_w=23
    2: (b4) w0 = 2                        ; R0_w=2
    ;  @ test.c:0
    3: (16) if w1 == 0x17 goto pc+1
    3: R1_w=23
    ; } @ test.c:20
    5: (95) exit
    processed 7 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0

And correctly tracks R0_w=23 from the callee through to the caller.
This lets it completely prune the res != 23 branch, skipping over
instruction 4.

But this isn't sound if the callee makes a bpf_tail_call(): if the tail
call succeeds, callee() will directly return whatever the tail called program returns.
We can't know what the bounds of r0 will be.

But the verifier still incorrectly tracks the bounds of r0, and assumes
it's 23. Loading:

    #include <linux/bpf.h>
    #include <bpf/bpf_helpers.h>

    struct {
            __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
            __uint(max_entries, 1);
            __uint(key_size, sizeof(__u32));
            __uint(value_size, sizeof(__u32));
    } tail_call_map SEC(".maps");

    static __attribute__((noinline)) int callee(struct xdp_md *ctx)
    {
            bpf_tail_call(ctx, &tail_call_map, 0);

            int ret;
            asm volatile("%0 = 23" : "=r"(ret));
            return ret;
    }

    static SEC("xdp") int caller(struct xdp_md *ctx)
    {
            int res = callee(ctx);
            if (res == 23) {
                    return XDP_PASS;
            }
            return XDP_DROP;
    }

The verifier logs:

    func#0 @0
    func#1 @6
    0: R1=ctx() R10=fp0
    ; int res = callee(ctx); @ test.c:24
    0: (85) call pc+5
    caller:
     R10=fp0
    callee:
     frame1: R1=ctx() R10=fp0
    6: frame1: R1=ctx() R10=fp0
    ; bpf_tail_call(ctx, &tail_call_map, 0); @ test.c:15
    6: (18) r2 = 0xffff8a9c82a75800       ; frame1: R2_w=map_ptr(map=tail_call_map,ks=4,vs=4)
    8: (b4) w3 = 0                        ; frame1: R3_w=0
    9: (85) call bpf_tail_call#12
    10: frame1:
    ; asm volatile("%0 = 23" : "=r"(ret)); @ test.c:18
    10: (b7) r0 = 23                      ; frame1: R0_w=23
    ; return ret; @ test.c:19
    11: (95) exit
    returning from callee:
     frame1: R0_w=23 R10=fp0
    to caller at 1:
     R0_w=23 R10=fp0

    from 11 to 1: R0_w=23 R10=fp0
    ; int res = callee(ctx); @ test.c:24
    1: (bc) w1 = w0                       ; R0_w=23 R1_w=23
    2: (b4) w0 = 2                        ; R0=2
    ;  @ test.c:0
    3: (16) if w1 == 0x17 goto pc+1
    3: R1=23
    ; } @ test.c:29
    5: (95) exit
    processed 10 insns (limit 1000000) max_states_per_insn 0 total_states 1 peak_states 1 mark_read 1

It still prunes the res != 23 branch, skipping over instruction 4.
But the tail called program can return any value.

Aside from pruning incorrect branches, this can also be used to read and
write arbitrary memory by using r0 as a index.

The added selftest fails without the fix:

    #187/p calls: call with nested tail_call r0 bounds FAIL
    Unexpected success to load

Fixes: e411901c0b77 ("bpf: allow for tailcalls in BPF subprograms for x64 JIT")
Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
Cc: stable@vger.kernel.org
---
 kernel/bpf/verifier.c                        |  3 ++
 tools/testing/selftests/bpf/verifier/calls.c | 35 ++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c2e5d0e6e3d0..0ef3a3ce695a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10359,6 +10359,9 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 				*insn_idx, callee->callsite);
 			return -EFAULT;
 		}
+	} else if (env->subprog_info[state->frame[state->curframe]->subprogno].has_tail_call) {
+		/* if tailcall succeeds, r0 could hold anything */
+		__mark_reg_unknown(env, &caller->regs[BPF_REG_0]);
 	} else {
 		/* return to the caller whatever r0 had in the callee */
 		caller->regs[BPF_REG_0] = *r0;
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index 7afc2619ab14..1c6266deec7a 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -1340,6 +1340,41 @@
 	.prog_type = BPF_PROG_TYPE_XDP,
 	.result = ACCEPT,
 },
+{
+	"calls: call with nested tail_call r0 bounds",
+	.insns = {
+	/* main prog */
+	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 4),
+	/* we shouldn't be able to index packet with r0, it could have any value */
+	BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6, offsetof(struct xdp_md, data)),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_7, BPF_REG_0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+
+	/* subprog */
+	BPF_LD_MAP_FD(BPF_REG_2, 0),
+	BPF_MOV64_IMM(BPF_REG_3, 1),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_XDP,
+	.errstr = "math between pkt pointer and register with unbounded min value",
+	.result = REJECT,
+	.fixup_prog1 = { 6 },
+	.func_info = { { 0, 4 }, { 6, 4 } },
+	.func_info_cnt = 2,
+	.btf_strings = "\0int\0ctx\0main\0",
+	.btf_types = {
+		/* 1: int   */ BTF_TYPE_INT_ENC(1, BTF_INT_SIGNED, 0, 32, 4),
+		/* 2: void* */ BTF_PTR_ENC(0),
+		/* 3: int __(void*) */ BTF_FUNC_PROTO_ENC(1, 1),
+			BTF_FUNC_PROTO_ARG_ENC(5, 2),
+		/* 4 */ BTF_FUNC_ENC(9, 3),
+	BTF_END_RAW
+	},
+},
 {
 	"calls: ambiguous return value",
 	.insns = {
-- 
2.34.1


