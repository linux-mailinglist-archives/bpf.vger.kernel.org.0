Return-Path: <bpf+bounces-63289-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 796F9B04DD0
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 04:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F0481AA3B9D
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 02:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F5D2C375F;
	Tue, 15 Jul 2025 02:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhiPMDpR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDB8155A4E;
	Tue, 15 Jul 2025 02:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752546338; cv=none; b=lGjWQXMeiCYswPBdyXZOt6ESuCYz0hreQlDk3rp0jlBlp6rkM22NEUxOeegF88von6WcVciNVqOHYPYMm8gLgoWGxoBws8MTPOahuCnPl0vrbQD2MQsrer1LUdkdYBmOxXN+UkpsV/PKk8Qgtu+kqkD2AoazTkrz+ApBlE9B7Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752546338; c=relaxed/simple;
	bh=/1mQXHiO2/QpEbjJNqw1AAh6kwW4leTVsVh4GnX9Ges=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OObNrKtfnBLRZ8POLyj+Zyi2s/BkrzTxxNybuubciwkjvmF0KeWDtG5E8DakW4T6AQWuK/m7EdEh/JKBWuu46yHbEEVKsVZlNdvfbTGnUFilVNWnqFbNQmg9nun3GqAtw5WswE7lTe+gMyDv3OnCYeg1SSDPn3wv7qWeeMLsP18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhiPMDpR; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a4f72cba73so3857495f8f.1;
        Mon, 14 Jul 2025 19:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752546335; x=1753151135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ia/GRWEj/tyEXlu02YhC4uvz3h3Vs8vLzxqDT6FKBPE=;
        b=jhiPMDpRI63buaWQGgigx7He9B4a2Q4RqiRDDNR+IeO+RHntDXuzD7sR2xOoD9Hb5L
         bacPgAGiH/zJIpyvG88zsNy7EcqHJnGNOTpQSBxGfSGn84tThYXttdWI5k6uQxkFnay1
         WRA3Byw0H1jusK/wuGlRF9sYFW2WwdjQwUm9Z2uKYTfRk1dBb1A5C+2v4xBOBRfaHR/a
         vFFVPFyKomlXE7rKtKm2tD0YZaVE7/H+YOMRu002YBZEZkCyZNqUFIw5AKDYuiLkc9L5
         OdSrrSuifGviudW4mnwoI+EQkfgC9R6a8sOJwhULDNgiJyjHrBBa5Iw58HGz4BFFJBYx
         KYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752546335; x=1753151135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ia/GRWEj/tyEXlu02YhC4uvz3h3Vs8vLzxqDT6FKBPE=;
        b=YvMMaIhp9LFGmGqlefMWxT6Q/WJTMCEm9EKT/JS92KAAhuJFLF+S/wj2MltCbzaNPm
         bA38/+yTHx3Y5j15xGHvbZr9fTxCfYFsBpaS2hERZjPmlGsJiRIP/He4S0mH3EsLcHNq
         2qoD5mwj+khxP4QmdlWCZdOByKmDbVldqvFV4Uim0jrztteDTK5hnI4DC0DbOaeLXiSk
         daRBC6qf9DtQ7xX65d+ZmhcNXbni35JyR+lh3yo/lsfXK2EVJs8CRTNjxH26g6/eIkPI
         r5is4vpMkxDLp7xgaQb4HLfAyUu8W6r1KyNpEv9A8d6eB4IRSnjqn3pfjbalfLn3yDnF
         yIEw==
X-Forwarded-Encrypted: i=1; AJvYcCUDc5lcW5onjEq+Wm3+4nmdkFku5QZOqo3VBvshBEH3PVhBgf+MpEXeLc0QC6SRxib2IWs=@vger.kernel.org, AJvYcCUkVXlN1IZ6k5VZW+4p9PL5Yxo8LuMmNGt6XpPlxHwlH/uD+2zjIjZRNehreoay34DGCx46TXlM@vger.kernel.org, AJvYcCWlX9lmzr4S4RAwTqhor38npYgIzhyky7y5oS7BDeRB3TNOUywQTsw7LCfo7hd+LU4lrXQftoiogHScwl2j@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9VdKROC66g1LGMs2Hx6Vtv20wNz2xjxRh7iDXxwbjBXb8q8MJ
	YRu634cgWIeOPWendIjlkTf7f0a19XdK9oPI8SjC7rGcu0CRlQrL4qtpxkZDk6qiKK7tFKiMVfG
	7muEqu1ce/+ITgoNrm7963Suqz2mVOZg=
X-Gm-Gg: ASbGncvoW0AKH9nxfWapX5piA5HYuWsoi1UT+iYBss1Cac4z5etfwyqBKoPdsz35OwB
	/LhiyOrgQtr2Kc5rwRuWf0gMNjpQ5GPlA4IhcWhh/CgcSkUIxiXpfp+rI2djHmaFb0BOT1BWpgv
	pVtMWd4r/E/8nIy/g76nK9YGSHYZtyKfygf+b094WoxFJkGAP1ffu56S2EXGedQs2GGJsryuuwg
	6F9N8PWE7ceYEa+wutmxVsTYLpg7b2qpPbKXSrPY5Y7JzQ=
X-Google-Smtp-Source: AGHT+IGuwQzYuIpJZi1NG4UT4eHh4+LyZK9k+RZgdv9IIoBRBvgX5VWGm4NjUczRGG+YiTorsStAsEIUCfl64xxMvqM=
X-Received: by 2002:a05:6000:4a0e:b0:3a4:f7ae:77c9 with SMTP id
 ffacd0b85a97d-3b609522273mr1270675f8f.5.1752546334914; Mon, 14 Jul 2025
 19:25:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn> <20250703121521.1874196-3-dongml2@chinatelecom.cn>
In-Reply-To: <20250703121521.1874196-3-dongml2@chinatelecom.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 14 Jul 2025 19:25:22 -0700
X-Gm-Features: Ac12FXwGpB_axbDiCsJ-zcVn8kfmssggV-vZEusEaGLoymarUYN3vBaVAIsWRXw
Message-ID: <CAADnVQKP1-gdmq1xkogFeRM6o3j2zf0Q8Atz=aCEkB0PkVx++A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 02/18] x86,bpf: add bpf_global_caller for
 global trampoline
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Menglong Dong <dongml2@chinatelecom.cn>, "H. Peter Anvin" <hpa@zytor.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	LKML <linux-kernel@vger.kernel.org>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 5:17=E2=80=AFAM Menglong Dong <menglong8.dong@gmail.=
com> wrote:
>
> +static __always_inline void
> +do_origin_call(unsigned long *args, unsigned long *ip, int nr_args)
> +{
> +       /* Following code will be optimized by the compiler, as nr_args
> +        * is a const, and there will be no condition here.
> +        */
> +       if (nr_args =3D=3D 0) {
> +               asm volatile(
> +                       RESTORE_ORIGIN_0 CALL_NOSPEC "\n"
> +                       "movq %%rax, %0\n"
> +                       : "=3Dm"(args[nr_args]), ASM_CALL_CONSTRAINT
> +                       : [args]"r"(args), [thunk_target]"r"(*ip)
> +                       :
> +               );
> +       } else if (nr_args =3D=3D 1) {
> +               asm volatile(
> +                       RESTORE_ORIGIN_1 CALL_NOSPEC "\n"
> +                       "movq %%rax, %0\n"
> +                       : "=3Dm"(args[nr_args]), ASM_CALL_CONSTRAINT
> +                       : [args]"r"(args), [thunk_target]"r"(*ip)
> +                       : "rdi"
> +               );
> +       } else if (nr_args =3D=3D 2) {
> +               asm volatile(
> +                       RESTORE_ORIGIN_2 CALL_NOSPEC "\n"
> +                       "movq %%rax, %0\n"
> +                       : "=3Dm"(args[nr_args]), ASM_CALL_CONSTRAINT
> +                       : [args]"r"(args), [thunk_target]"r"(*ip)
> +                       : "rdi", "rsi"
> +               );
> +       } else if (nr_args =3D=3D 3) {
> +               asm volatile(
> +                       RESTORE_ORIGIN_3 CALL_NOSPEC "\n"
> +                       "movq %%rax, %0\n"
> +                       : "=3Dm"(args[nr_args]), ASM_CALL_CONSTRAINT
> +                       : [args]"r"(args), [thunk_target]"r"(*ip)
> +                       : "rdi", "rsi", "rdx"
> +               );
> +       } else if (nr_args =3D=3D 4) {
> +               asm volatile(
> +                       RESTORE_ORIGIN_4 CALL_NOSPEC "\n"
> +                       "movq %%rax, %0\n"
> +                       : "=3Dm"(args[nr_args]), ASM_CALL_CONSTRAINT
> +                       : [args]"r"(args), [thunk_target]"r"(*ip)
> +                       : "rdi", "rsi", "rdx", "rcx"
> +               );
> +       } else if (nr_args =3D=3D 5) {
> +               asm volatile(
> +                       RESTORE_ORIGIN_5 CALL_NOSPEC "\n"
> +                       "movq %%rax, %0\n"
> +                       : "=3Dm"(args[nr_args]), ASM_CALL_CONSTRAINT
> +                       : [args]"r"(args), [thunk_target]"r"(*ip)
> +                       : "rdi", "rsi", "rdx", "rcx", "r8"
> +               );
> +       } else if (nr_args =3D=3D 6) {
> +               asm volatile(
> +                       RESTORE_ORIGIN_6 CALL_NOSPEC "\n"
> +                       "movq %%rax, %0\n"
> +                       : "=3Dm"(args[nr_args]), ASM_CALL_CONSTRAINT
> +                       : [args]"r"(args), [thunk_target]"r"(*ip)
> +                       : "rdi", "rsi", "rdx", "rcx", "r8", "r9"
> +               );
> +       }
> +}

What is the performance difference between 0-6 variants?
I would think save/restore of regs shouldn't be that expensive.
bpf trampoline saves only what's necessary because it can do
this micro optimization, but for this one, I think, doing
_one_ global trampoline that covers all cases will simplify the code
a lot, but please benchmark the difference to understand
the trade-off.

The major simplification will be due to skipping nr_args.
There won't be a need to do btf model and count the args.
Just do one trampoline for them all.

Also funcs with 7+ arguments need to be thought through
from the start.
I think it's ok trade-off if we allow global trampoline
to be safe to attach to a function with 7+ args (and
it will not mess with the stack), but bpf prog can only
access up to 6 args. The kfuncs to access arg 7 might be
more complex and slower. It's ok trade off.

> +
> +static __always_inline notrace void
> +run_tramp_prog(struct kfunc_md_tramp_prog *tramp_prog,
> +              struct bpf_tramp_run_ctx *run_ctx, unsigned long *args)
> +{
> +       struct bpf_prog *prog;
> +       u64 start_time;
> +
> +       while (tramp_prog) {
> +               prog =3D tramp_prog->prog;
> +               run_ctx->bpf_cookie =3D tramp_prog->cookie;
> +               start_time =3D bpf_gtramp_enter(prog, run_ctx);
> +
> +               if (likely(start_time)) {
> +                       asm volatile(
> +                               CALL_NOSPEC "\n"
> +                               : : [thunk_target]"r"(prog->bpf_func), [a=
rgs]"D"(args)
> +                       );

Why this cannot be "call *(prog->bpf_func)" ?

> +               }
> +
> +               bpf_gtramp_exit(prog, start_time, run_ctx);
> +               tramp_prog =3D tramp_prog->next;
> +       }
> +}
> +
> +static __always_inline notrace int
> +bpf_global_caller_run(unsigned long *args, unsigned long *ip, int nr_arg=
s)

Pls share top 10 from "perf report" while running the bench.
I'm curious about what's hot.
Last time I benchmarked fentry/fexit migrate_disable/enable were
one the hottest functions. I suspect it's the case here as well.

