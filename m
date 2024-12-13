Return-Path: <bpf+bounces-46902-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3E69F1802
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 22:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1B36188ABA8
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 21:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448111917D0;
	Fri, 13 Dec 2024 21:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Tiu/C6tY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0480F1DA5F
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 21:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734125273; cv=none; b=moAOzu4kuPT7gIVgRPZoJ/0mCzBi6s/bzFUToxJCrBZp3Y02/qQGIKWssW/NoU4qPj9AcIBzWuqyS85KgYXdAz6JznHvlcCKZXWuqUDRLB2xYp+5z0De9I+RWieSmC/ccgH4PKtoYwxVCVBTGDOZXqLrShkP5yeFie6CSMdueio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734125273; c=relaxed/simple;
	bh=9oYNHHTYyghmujAUGTAE7o/GLx8VDE8KOEwSCIFrbFo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QheTZrDcvkkujg6A9GwwZm8WFDYg7XwLvBfwIOpkc5faXnmazPM9YzHDULiRmqBCRDQG3XzSiiyZrFVluiC0BVaSseSM8NXbrUWD2j6iJ7HwAPswlpGBhQMCmSoTQAGx8RrUOTPmV57Id4vfBzGXOiPAQX++dUI1OKPL9pvcRVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Tiu/C6tY; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43622267b2eso22696905e9.0
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 13:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1734125270; x=1734730070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PtqPTUR9tgOKfxXSZlJYVBmSofRATihAJyMEz3ibSsU=;
        b=Tiu/C6tY2nHSZ0A+vClRPoBr8AbpD9oNUeAZ9AEV2QvR+WnX+hnUwrZS+XHwZRqPvm
         rG8ASzSiumKz7mHd5sMJPVSzJWRH8jtcAPGiNqtZZgv7SscjmRdtcMFxmV6UbafR9cwp
         WF4d1WfFTuokHnNZ7+2TzHnZzHA9vZGnOBlbH3A1yOf9yCvOIdOfyteybva4+5NYvEv4
         k4Rxae4W+pggmLeeTkUH9jf2Frz1MSjp6e4C6v6SxXI6H9+UeaH5Zhso12ybANOHQzdS
         C1u3x3QoRKhyCjWNDkFyjILt5535+Mg2TTSyOo1lMxVd7cFblel0BUXYe2ztNYTfwPmG
         F/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734125270; x=1734730070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PtqPTUR9tgOKfxXSZlJYVBmSofRATihAJyMEz3ibSsU=;
        b=hb4XHHoJMrXqM9tMg2oLqEcm2AjVXfRCFRHMVuiPwnwHEDrccamX34BsjEyEk6H0Sw
         W4ZyGrRjeZQ/WBUeWs+bXj+NgeKiZwHW5KrV0RrtG+vgBart3KZf9lciEODGkMR25X9w
         GaZ/KawQfVNlKdiHjTN6OuQLbLS/ZmgemyOopUMprYHjmPqg4y9eswgQn++2lgFd6eqw
         48sqHNg9Z43kH6wW0TDLphZl0djXS7No1ypKEFhER+g+rNyUFgf9OVcnvdncqh7pzJFh
         MlJh4sRbNVH0myXzwTbOhfVupAtv5obiRrtU4Pydo/6+31Hz+TF0C8US6z40qp6tUktn
         31Xw==
X-Gm-Message-State: AOJu0YwSRdQ/HEdUuCc18M1ZvhK4Az6eMBySAkIvky7CYAHJ4eRisP6N
	5wW5COwWOwJXjzDQsWMN0wCP0ih8yHO2ceFpWKm3Qi3F7K5ZiWOmAC2DSxpYLSrYVzMUmTabo+N
	eHztieQ==
X-Gm-Gg: ASbGnctO00uL3K0pOCJ9aS6yQUo/upmO+I3kQaqpoVr16Qj3WJs6V4icG8wPWqJQF/4
	OAazehJ1AKjXyFbHr2s5rWJato3s2UcoVezRgkhBpG+xwwbTljkcbZR3H4/XKDlCMdfw9NCkCay
	iKt1uPFRuo8R9RfM48NG5HnyzK9dWjFOAj7YrqfLcVqDFzrNG1RKMqnA7jyWyj/MZS/dSU/drVi
	pQk/28nM97RAFmUsVIEccEMVe/e/NXziP8YoCk=
X-Google-Smtp-Source: AGHT+IGrTbwiOdzojzipt1+62/TY4fcFG5h5g6KAi8NlJy7AM/n36kQGgDbMKT9T8cc+vT8kwoTr2w==
X-Received: by 2002:a05:6000:470b:b0:385:df6d:6fc7 with SMTP id ffacd0b85a97d-38880ada7e1mr3137994f8f.25.1734125270036;
        Fri, 13 Dec 2024 13:27:50 -0800 (PST)
Received: from bobby.. ([2a09:bac1:27c0:58::3b6:40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43625706c5fsm60003975e9.31.2024.12.13.13.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 13:27:49 -0800 (PST)
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
Subject: [PATCH bpf v2 1/2] bpf: Don't trust r0 bounds after BPF to BPF calls with abnormal returns
Date: Fri, 13 Dec 2024 22:27:16 +0100
Message-Id: <20241213212717.1830565-2-afabre@cloudflare.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213212717.1830565-1-afabre@cloudflare.com>
References: <20241213212717.1830565-1-afabre@cloudflare.com>
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

But this isn't sound if the callee can return "abnormally" before an
exit instruction:
- If LD_ABS or LD_IND try to access data beyond the end of the packet,
  the callee returns 0 directly.
- If a tail_call succeeds, the return value of the tail called program
  will be returned directly.
We can't know what the bounds of r0 will be.

The verifier still incorrectly tracks the bounds of r0 in these cases. Loading:

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

Fixes: e411901c0b77 ("bpf: allow for tailcalls in BPF subprograms for x64 JIT")
Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
Cc: stable@vger.kernel.org
---
 kernel/bpf/verifier.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c2e5d0e6e3d0..76c0008f6914 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10314,6 +10314,11 @@ static bool retval_range_within(struct bpf_retval_range range, const struct bpf_
 		return range.minval <= reg->smin_value && reg->smax_value <= range.maxval;
 }
 
+static bool has_abnormal_return(struct bpf_subprog_info *subprog_info)
+{
+	return subprog_info->has_ld_abs || subprog_info->has_tail_call;
+}
+
 static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 {
 	struct bpf_verifier_state *state = env->cur_state, *prev_st;
@@ -10359,6 +10364,10 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 				*insn_idx, callee->callsite);
 			return -EFAULT;
 		}
+	} else if (has_abnormal_return(
+		    &env->subprog_info[state->frame[state->curframe]->subprogno])) {
+		/* callee can return before exit instruction, r0 could hold anything */
+		__mark_reg_unknown(env, &caller->regs[BPF_REG_0]);
 	} else {
 		/* return to the caller whatever r0 had in the callee */
 		caller->regs[BPF_REG_0] = *r0;
@@ -16881,17 +16890,14 @@ static int check_cfg(struct bpf_verifier_env *env)
 	return ret;
 }
 
+
 static int check_abnormal_return(struct bpf_verifier_env *env)
 {
 	int i;
 
 	for (i = 1; i < env->subprog_cnt; i++) {
-		if (env->subprog_info[i].has_ld_abs) {
-			verbose(env, "LD_ABS is not allowed in subprogs without BTF\n");
-			return -EINVAL;
-		}
-		if (env->subprog_info[i].has_tail_call) {
-			verbose(env, "tail_call is not allowed in subprogs without BTF\n");
+		if (has_abnormal_return(&env->subprog_info[i])) {
+			verbose(env, "LD_ABS/tail_call is not allowed in subprogs without BTF\n");
 			return -EINVAL;
 		}
 	}
-- 
2.34.1


