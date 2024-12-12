Return-Path: <bpf+bounces-46747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F6A9EFF5C
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 23:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69601161D84
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 22:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175101DDC37;
	Thu, 12 Dec 2024 22:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S++HiME5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9023E1A707A
	for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 22:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734042623; cv=none; b=onroNpBlFdI3/BpW/bZx3uEKX2JaWgDqASP2k6uPfxWVZLigqqpbPU5EsJ/UxH0UfrvBYwdDUAq2S+CbKWSjY/SgQwinibpKe9c6IzKhOn9pF1clPzDQLe0PBpB0l0LHeQFo9s3mhvM9ZRbVOhCypLUBTeelX/b/HL7N5z5We2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734042623; c=relaxed/simple;
	bh=Tyfy35Zot/+Zkd3L0CJ6t9I1m6u5VEjWBjdI7t9sSxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FsiakKUBfiq+MW8JfQXEpqkT5Sm5mkNjK2Y829DlZy6hZmjNpa7IF1yGi2G+aSBUKjAgyEqvh7vpDKS3N7gHrJS9szdy5Qq9Dtm21hD6KDB2+N0xMKMGN4pqhtlTJph5f7BkO/TtZ9Cl30C4wJAToTAlg9hU3VW5ijgl8Oo3GRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S++HiME5; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3862a921123so825330f8f.3
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 14:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734042620; x=1734647420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjd3CcGxrBUolkkxSlkY4AUi3hk7OktEMBqQqoVQDPI=;
        b=S++HiME50TE2/0+o9GgvaWE+j0JSkVqwCGn3eha2uvPHAQFgEO2a4S1s2sSqJmYUum
         j04coYEl+5HLnlcEpTIp2vk6AtrKICtPoHMcNg82n8q3LMNKCCvrHzDaTPex4ytUxifL
         96p36qE1GPNIFvKi/vFmovdwS8UaUsKYllh91wzMrf60ZDX5+V5LwCSKpVlbQtcJjRly
         CHLLbpXLF2jMjR4xdSTdZhyg+di7Iu87QDSfqw2ZbHP3VcTtZYDuWvcQ4dSHWveRKvYB
         O8vlJFwRv5MhZjpP/2FINlI3d5wl7dLGmK9HHyoEXu0JEDSMU+y4iCfNqRdszPCU24ix
         Pacw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734042620; x=1734647420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jjd3CcGxrBUolkkxSlkY4AUi3hk7OktEMBqQqoVQDPI=;
        b=QsW/dq1yOvq/7gyJiaYmU8R3NmyEZYpcYyeF1Vd+570Q1vpzrxJGOik0iS64ssCOMt
         KBrOOT+q3of7Nnif10JQiR6nE/EGpHTC2vvEFUEQewKc7qBe+yzUuje4zR67v2r5YjQu
         0mvtTAQiGhV55GHIcOg/JwqkYmp0BGlvILd1Ovrnm1GvyObI9tGaC3IvBBz5v7bhgOpO
         k775mmKGdiAZrDRNkYtBFerFLkTUagj9Z+ryvYGby2tiO6d85ACT8qtrGXHrjgkilxSB
         TVL4Q9NAOyKr+J3V5lzMd/Kd7iqIXRyi6aFQIn2H6R7TJzhI/meLJbbqgygT4oqqGoeQ
         pQqg==
X-Gm-Message-State: AOJu0YwpNAs8+lbVd25P/QeWnm9mWZWLmaiyhm/9aqz9HJLyrW/T7VTP
	NDKgSDXbN1BuL2BBWTlW3gsOCInY3dUwMu87ZVs0spWcafVjRLbywr9PTmyDa3yVqqoXKcJyWk4
	IP5MB62TKl9Ctlf8XeCLT3oAZTcc=
X-Gm-Gg: ASbGncvZV7hpaJtscC8+lohAOgW8QpvOdywD7xkGc3Prs9BIF0yESamkd2XKAEfwFoY
	YMMmas4MZatuNfMkKaj4xxVIB6hsos3jOh6CUh16H5lgkw2a29Yb/gam/jLkPVVri8hx1oA==
X-Google-Smtp-Source: AGHT+IE+YUlt2bupD2QPv76gc0NgutAEWrTu+oLgcw4MUTfZSoEGfVTDXZRKsQMgcBgDVKCuJpj7nbOI3hXjK4OCzLc=
X-Received: by 2002:a05:6000:144d:b0:385:e37a:2a56 with SMTP id
 ffacd0b85a97d-3888e0bb669mr161617f8f.52.1734042619403; Thu, 12 Dec 2024
 14:30:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212210748.1305855-1-afabre@cloudflare.com>
In-Reply-To: <20241212210748.1305855-1-afabre@cloudflare.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 12 Dec 2024 14:30:08 -0800
Message-ID: <CAADnVQLKFrnt232-WPnA0ZzQXJEhL6APrGNQK_Wu=fNaWsbpFA@mail.gmail.com>
Subject: Re: [PATCH] bpf: Don't trust r0 bounds after BPF to BPF call that tail_calls
To: Arthur Fabre <afabre@cloudflare.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 1:09=E2=80=AFPM Arthur Fabre <afabre@cloudflare.com=
> wrote:
>
> When making BPF to BPF calls, the verifier propagates register bounds
> info for r0 from the callee to the caller.
>
> For example loading:
>
>     #include <linux/bpf.h>
>     #include <bpf/bpf_helpers.h>
>
>     static __attribute__((noinline)) int callee(struct xdp_md *ctx)
>     {
>             int ret;
>             asm volatile("%0 =3D 23" : "=3Dr"(ret));
>             return ret;
>     }
>
>     static SEC("xdp") int caller(struct xdp_md *ctx)
>     {
>             int res =3D callee(ctx);
>             if (res =3D=3D 23) {
>                     return XDP_PASS;
>             }
>             return XDP_DROP;
>     }
>
> The verifier logs:
>
>     func#0 @0
>     func#1 @6
>     0: R1=3Dctx() R10=3Dfp0
>     ; int res =3D callee(ctx); @ test.c:15
>     0: (85) call pc+5
>     caller:
>      R10=3Dfp0
>     callee:
>      frame1: R1=3Dctx() R10=3Dfp0
>     6: frame1: R1=3Dctx() R10=3Dfp0
>     ; asm volatile("%0 =3D 23" : "=3Dr"(ret)); @ test.c:9
>     6: (b7) r0 =3D 23                       ; frame1: R0_w=3D23
>     ; return ret; @ test.c:10
>     7: (95) exit
>     returning from callee:
>      frame1: R0_w=3D23 R1=3Dctx() R10=3Dfp0
>     to caller at 1:
>      R0_w=3D23 R10=3Dfp0
>
>     from 7 to 1: R0_w=3D23 R10=3Dfp0
>     ; int res =3D callee(ctx); @ test.c:15
>     1: (bc) w1 =3D w0                       ; R0_w=3D23 R1_w=3D23
>     2: (b4) w0 =3D 2                        ; R0_w=3D2
>     ;  @ test.c:0
>     3: (16) if w1 =3D=3D 0x17 goto pc+1
>     3: R1_w=3D23
>     ; } @ test.c:20
>     5: (95) exit
>     processed 7 insns (limit 1000000) max_states_per_insn 0 total_states =
0 peak_states 0 mark_read 0
>
> And correctly tracks R0_w=3D23 from the callee through to the caller.
> This lets it completely prune the res !=3D 23 branch, skipping over
> instruction 4.
>
> But this isn't sound if the callee makes a bpf_tail_call(): if the tail
> call succeeds, callee() will directly return whatever the tail called pro=
gram returns.
> We can't know what the bounds of r0 will be.
>
> But the verifier still incorrectly tracks the bounds of r0, and assumes
> it's 23. Loading:
>
>     #include <linux/bpf.h>
>     #include <bpf/bpf_helpers.h>
>
>     struct {
>             __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
>             __uint(max_entries, 1);
>             __uint(key_size, sizeof(__u32));
>             __uint(value_size, sizeof(__u32));
>     } tail_call_map SEC(".maps");
>
>     static __attribute__((noinline)) int callee(struct xdp_md *ctx)
>     {
>             bpf_tail_call(ctx, &tail_call_map, 0);
>
>             int ret;
>             asm volatile("%0 =3D 23" : "=3Dr"(ret));
>             return ret;
>     }
>
>     static SEC("xdp") int caller(struct xdp_md *ctx)
>     {
>             int res =3D callee(ctx);
>             if (res =3D=3D 23) {
>                     return XDP_PASS;
>             }
>             return XDP_DROP;
>     }
>
> The verifier logs:
>
>     func#0 @0
>     func#1 @6
>     0: R1=3Dctx() R10=3Dfp0
>     ; int res =3D callee(ctx); @ test.c:24
>     0: (85) call pc+5
>     caller:
>      R10=3Dfp0
>     callee:
>      frame1: R1=3Dctx() R10=3Dfp0
>     6: frame1: R1=3Dctx() R10=3Dfp0
>     ; bpf_tail_call(ctx, &tail_call_map, 0); @ test.c:15
>     6: (18) r2 =3D 0xffff8a9c82a75800       ; frame1: R2_w=3Dmap_ptr(map=
=3Dtail_call_map,ks=3D4,vs=3D4)
>     8: (b4) w3 =3D 0                        ; frame1: R3_w=3D0
>     9: (85) call bpf_tail_call#12
>     10: frame1:
>     ; asm volatile("%0 =3D 23" : "=3Dr"(ret)); @ test.c:18
>     10: (b7) r0 =3D 23                      ; frame1: R0_w=3D23
>     ; return ret; @ test.c:19
>     11: (95) exit
>     returning from callee:
>      frame1: R0_w=3D23 R10=3Dfp0
>     to caller at 1:
>      R0_w=3D23 R10=3Dfp0
>
>     from 11 to 1: R0_w=3D23 R10=3Dfp0
>     ; int res =3D callee(ctx); @ test.c:24
>     1: (bc) w1 =3D w0                       ; R0_w=3D23 R1_w=3D23
>     2: (b4) w0 =3D 2                        ; R0=3D2
>     ;  @ test.c:0
>     3: (16) if w1 =3D=3D 0x17 goto pc+1
>     3: R1=3D23
>     ; } @ test.c:29
>     5: (95) exit
>     processed 10 insns (limit 1000000) max_states_per_insn 0 total_states=
 1 peak_states 1 mark_read 1
>
> It still prunes the res !=3D 23 branch, skipping over instruction 4.
> But the tail called program can return any value.
>
> Aside from pruning incorrect branches, this can also be used to read and
> write arbitrary memory by using r0 as a index.
>
> The added selftest fails without the fix:
>
>     #187/p calls: call with nested tail_call r0 bounds FAIL
>     Unexpected success to load
>
> Fixes: e411901c0b77 ("bpf: allow for tailcalls in BPF subprograms for x64=
 JIT")
> Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
> Cc: stable@vger.kernel.org
> ---
>  kernel/bpf/verifier.c                        |  3 ++
>  tools/testing/selftests/bpf/verifier/calls.c | 35 ++++++++++++++++++++
>  2 files changed, 38 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c2e5d0e6e3d0..0ef3a3ce695a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10359,6 +10359,9 @@ static int prepare_func_exit(struct bpf_verifier_=
env *env, int *insn_idx)
>                                 *insn_idx, callee->callsite);
>                         return -EFAULT;
>                 }
> +       } else if (env->subprog_info[state->frame[state->curframe]->subpr=
ogno].has_tail_call) {
> +               /* if tailcall succeeds, r0 could hold anything */
> +               __mark_reg_unknown(env, &caller->regs[BPF_REG_0]);

The fix makes sense.
The has_ld_abs has the same issue.
Pls include it as well.

>         } else {
>                 /* return to the caller whatever r0 had in the callee */
>                 caller->regs[BPF_REG_0] =3D *r0;
> diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing=
/selftests/bpf/verifier/calls.c
> index 7afc2619ab14..1c6266deec7a 100644
> --- a/tools/testing/selftests/bpf/verifier/calls.c
> +++ b/tools/testing/selftests/bpf/verifier/calls.c
> @@ -1340,6 +1340,41 @@
>         .prog_type =3D BPF_PROG_TYPE_XDP,
>         .result =3D ACCEPT,
>  },
> +{
> +       "calls: call with nested tail_call r0 bounds",
> +       .insns =3D {
> +       /* main prog */
> +       BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 4),
> +       /* we shouldn't be able to index packet with r0, it could have an=
y value */
> +       BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6, offsetof(struct xdp_md, =
data)),
> +       BPF_ALU64_REG(BPF_ADD, BPF_REG_7, BPF_REG_0),
> +       BPF_MOV64_IMM(BPF_REG_0, 0),
> +       BPF_EXIT_INSN(),
> +
> +       /* subprog */
> +       BPF_LD_MAP_FD(BPF_REG_2, 0),
> +       BPF_MOV64_IMM(BPF_REG_3, 1),
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
> +       BPF_MOV64_IMM(BPF_REG_0, 0),
> +       BPF_EXIT_INSN(),
> +       },
> +       .prog_type =3D BPF_PROG_TYPE_XDP,
> +       .errstr =3D "math between pkt pointer and register with unbounded=
 min value",
> +       .result =3D REJECT,

Pls split sefltest into separate patch and use inline asm
instead of macros.
See verifier_map_ptr_mixing.c or verifier_unpriv.c

pw-bot: cr

