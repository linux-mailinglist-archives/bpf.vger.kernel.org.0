Return-Path: <bpf+bounces-63466-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE24B07BC1
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 19:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EAC018817F1
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 17:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1222F5C3C;
	Wed, 16 Jul 2025 17:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmqfGpxn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830BA186294;
	Wed, 16 Jul 2025 17:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752685471; cv=none; b=T5ivyT8PWvsqm6KeD7wt8tTuPvY3Ep4op53Zg+54AptFHhURljEjemNth46+GQ5pBWIMgb+Aj5ZlOWlq/PydztXfexl6ISIsUtMIQjg0wwXKhQLIoyKOYmyevPXpDHXuA5FQuLCMrIqfI3aGhgPTmjEtav1MHPU2i6vmpeb8TSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752685471; c=relaxed/simple;
	bh=pfDCSCBF20xGHAe1g8MHqdHKoqvKbZb6FrEiuiU5isE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M7x9glD9ZDLRiq37GovboNRbklMBZH8Mxwu6DqGcGvdzp53PJOpFc34P7Zr4U8b5ji2zIqvWKyMDPMH1uGZpnRZsZi7MZaEixDm/IzBnZTfvOgjplgaaQRUp043JT1WSQJ3fF6zHjdgTOi7L77Yu9zRV7ib6zJDbThhTphpDx4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmqfGpxn; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-60c51860bf5so64895a12.1;
        Wed, 16 Jul 2025 10:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752685468; x=1753290268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7oYQp9TxI4Fj95McwORlYyfvoBodxMgz2aYymOhtlQ=;
        b=CmqfGpxnApb0w3PmsNh7Oz2oPNElP6FOg2JHq00liLAFtyyWXfiG34m8kBDLTe9Yj9
         sKqU4Ac0HVp2e77BKS1qjV3b6YT4urtczCwYBWQK8C+3EXF6cFaNebAxnmg6qTwzYE0h
         7pJQsihbuN6CCtx8r5STsT9+7FE5e/AxaUt/YibkAMO0BgrS2/TLGGPm9NpVzarKcCBB
         y8qKm4IDiggbVhky4kBxSNT6eDArjxsebE/0ju7fqWgOCCFQ+vf4wzFQWvEFwThhXhcV
         yE/K0mj5M0TpwD4ToFamZ1hdxw9NjNAHPwDkUcwP9/9N6c0VCCchfAUNDEl2/L7nev/M
         kdMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752685468; x=1753290268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q7oYQp9TxI4Fj95McwORlYyfvoBodxMgz2aYymOhtlQ=;
        b=H3he4aWY7ysk+66exsU2nItEyU0uXTtAuR+FYVKE0kPLp7BnfqWH+zLBrb55zd3F2V
         sTgirKd5OVL9JUxFU68kPwR9GDbL1bu+0NW8o9N+ST1qMSPuA3wXURje1k6aw3TRBxb3
         57UJFdfxCpWWC6OaqqjyB4KIuuTwRP8AQ5Ky2TsxY7F9nMXdgs3fnC8rKzAPpzXSs3gj
         tMHaVjffNkTayPua5qLzYvTk1VsFcvsFYSh4pVC3FEd3cOPfYrMuvfp81jlj4Ybrej+d
         DTm9QIicoRO1kTgrRfFbrfJnX4jR09w/kEJALzclRG4S+9o9dBi6+vDXH5Y0ckhtvuWq
         fpYg==
X-Forwarded-Encrypted: i=1; AJvYcCU4QDCf9SapSc5MFuVcUJ1cPcDhicJ37YPLSdrYI6cu4unUMiO+VUcZ4/ODq31CFPmbMR8=@vger.kernel.org, AJvYcCWRPcP/7wYQcVkLWfMGnAiZUNmHdPWn0B1JQofOnI5JRyj5bHNaz4wZVKczEm/yLsB5uaC27Jkl@vger.kernel.org, AJvYcCWkK00Q1iEkZoyUcGYdcfgsukQ4GzILE4VoWUu0PO7lo1MYJfCte5JVaiGnEs1yej/eP3NE8JKSenpNrZd+@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk6ifeiXeZ4tsOqu4Qh9+2O/zDYfS/4VpxFtjGbxbmFMODU2dI
	bDdUg6yNlg7a8hzDzYlb3H5cIjNVgJqFHomNx5HEgbE8K/MzhxLv14t54uQ2aEsQUOjIHWjD+hh
	FEekqNIadu7tS8QPhXByAuoMd+jH3WG/oYzae
X-Gm-Gg: ASbGncv817ARo7EBC1FUe8P8RereHP14Q2n1uOfJAcz0k2aqpxu3F/fYNGaHSjWe8Zd
	zHy5K4TSpCF3cukSAfm5J1Mx1K4fhvdK6OtXTSEnQO9k9jg7LMLtcGcyuQfOb+AEwxZ5HmNySQg
	oEQ7S+T2vgDt51CVIvTRkA+biGY1dZ6qyz3xXwS1QWjm3UwL2U1pHMIneIhVZx77DXvlCfdPVtH
	L2aFi+b4MK/DnV7QHua5Svo72dV8Wf3atYH
X-Google-Smtp-Source: AGHT+IFamd7Y4MRHtmq2184BO6w8sFgyxYl7Zh4itA6app2I7UPsgQc9mmLYflqnadMMT9/lraUol3z1FAgnq1p09mo=
X-Received: by 2002:a05:6000:288f:b0:3a5:1410:71c0 with SMTP id
 ffacd0b85a97d-3b60dd95b34mr2909840f8f.38.1752684982596; Wed, 16 Jul 2025
 09:56:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
 <20250703121521.1874196-3-dongml2@chinatelecom.cn> <CAADnVQKP1-gdmq1xkogFeRM6o3j2zf0Q8Atz=aCEkB0PkVx++A@mail.gmail.com>
 <45f4d349-7b08-45d3-9bec-3ab75217f9b6@linux.dev> <3bccb986-bea1-4df0-a4fe-1e668498d5d5@linux.dev>
In-Reply-To: <3bccb986-bea1-4df0-a4fe-1e668498d5d5@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 16 Jul 2025 09:56:11 -0700
X-Gm-Features: Ac12FXzz97G1BInpuw1CatASNIHUf58Eb9JFMy5wt8frDaYX3XmuvRo8Dbo2D70
Message-ID: <CAADnVQ+Afov4E=9t=3M=zZmO9z4ZqT6imWD5xijDHshTf3J=RA@mail.gmail.com>
Subject: Inlining migrate_disable/enable. Was: [PATCH bpf-next v2 02/18]
 x86,bpf: add bpf_global_caller for global trampoline
To: Menglong Dong <menglong.dong@linux.dev>, Peter Zijlstra <peterz@infradead.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 2:31=E2=80=AFAM Menglong Dong <menglong.dong@linux.=
dev> wrote:
>
>  Following are the test results for fentry-multi:
>    36.36% bpf_prog_2dcccf652aac1793_bench_trigger_fentry_multi [k]
> bpf_prog_2dcccf652aac1793_bench_trigger_fentry_multi
>    20.54% [kernel] [k] migrate_enable
>    19.35% [kernel] [k] bpf_global_caller_5_run
>    6.52% [kernel] [k] bpf_global_caller_5
>    3.58% libc.so.6 [.] syscall
>    2.88% [kernel] [k] entry_SYSCALL_64
>    1.50% [kernel] [k] memchr_inv
>    1.39% [kernel] [k] fput
>    1.04% [kernel] [k] migrate_disable
>    0.91% [kernel] [k] _copy_to_user
>
> And I also did the testing for fentry:
>    54.63% bpf_prog_2dcccf652aac1793_bench_trigger_fentry [k]
> bpf_prog_2dcccf652aac1793_bench_trigger_fentry
>    10.43% [kernel] [k] migrate_enable
>    10.07% bpf_trampoline_6442517037 [k] bpf_trampoline_6442517037
>    8.06% [kernel] [k] __bpf_prog_exit_recur
>    4.11% libc.so.6 [.] syscall
>    2.15% [kernel] [k] entry_SYSCALL_64
>    1.48% [kernel] [k] memchr_inv
>    1.32% [kernel] [k] fput
>    1.16% [kernel] [k] _copy_to_user
>    0.73% [kernel] [k] bpf_prog_test_run_raw_tp

Let's pause fentry-multi stuff and fix this as a higher priority.
Since migrate_disable/enable is so hot in yours and my tests,
let's figure out how to inline it.

As far as I can see both functions can be moved to a header file
including this_rq() macro, but we need to keep
struct rq private to sched.h. Moving the whole thing is not an option.
Luckily we only need nr_pinned from there.
Maybe we can offsetof(struct rq, nr_pinned) in a precompile step
the way it's done for asm-offsets ?
And then use that constant to do nr_pinned ++, --.
__set_cpus_allowed_ptr() is a slow path and can stay .c

Maybe Peter has better ideas ?

