Return-Path: <bpf+bounces-28457-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CC58B9E6B
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 18:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D6B31F24C20
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 16:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42C815E7ED;
	Thu,  2 May 2024 16:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d08shh0Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F492152E08;
	Thu,  2 May 2024 16:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714666873; cv=none; b=YTWyZXIPzEXmSanb3E4G3reDG+0Zq381sdqgPjsdiPGCJObkxTsPIjaPrJeAVuEynWzXjlP5bE1+KVzisWC5sh8NPIah7l9b4XFI/irqB90GGkwrh7WTPziJdDIHq6hWq9T52RrI4ey7I+EqjiOI6osFiZD5D6XGLMH/qUuffr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714666873; c=relaxed/simple;
	bh=3Q6POTHO3q3wAmlan9x9sIkSNWYcgn8ONEBdXg+ZbHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pBtQehtO/YKGnUY2pS1frh81mqem2k02r6fDQeSo/zLq/9X9sCo2pjKVQHy3oJdZscHphqWvGAzi6+BCbAIcH3g9mib+mEJ8zYdfyEW7/zNRx9syru/FZLslWEMVfIKCWOauB1Cwep1+qvjMTMiI7HqCykgGvFNJo/DmAnG/lAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d08shh0Z; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51f0602bc58so1077868e87.0;
        Thu, 02 May 2024 09:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714666870; x=1715271670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUyPRHnVMRowddCFlTczt50QKNbUT/pUuDV1uKnddi0=;
        b=d08shh0Z6UJoefK5G8zWV2Em2eACw062QSchj6T8EmYfYKWenSN0M7ywvOVrDnYy6X
         OrbdTCtmt9g5frpSlxRx7JOVSuodHEQCHau05/z3FvNaZxhY3e1R1UIcM1pNeRNWKxpp
         YJzuJHlOO0KRWCvcisuLZVOgYIJE2xva318WWvCVZswY0YXKGVIP2tYyq6TC/WQCxAZu
         I6TRARSJ0UG6bBoz2ISj7xhIYWeiSjJxz7GytI7lI7APXXvzTNcxTUZfN+ZW6mXNpB8Q
         dfCSuXLUYXH6grBSp9mSmwPlCHa9G1GKdKRZ0rPlTV6ddT+NAvS8qCP2kx/pF7ZqysN7
         c+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714666870; x=1715271670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUyPRHnVMRowddCFlTczt50QKNbUT/pUuDV1uKnddi0=;
        b=deDvxYz1aaWc/RCP8ZGxsio/z9CcsFohGqfrgnel5/vVqN/kRNGspRUXJjhHQ2eaM3
         b2l+MiJCS9u2bFvlMGvdfPS36lDjTQxLmtRqrrUs51re5RF/eKjgakQS/jyz5UV9/ipo
         cTtUWDR3LMOApc6unCqWMj/JpmN5YetcXUAH0A8mmDu9LtQGdOn6vT46+aHIHa9WV9rj
         6Cs5UMueqIvFtKX38xUjiGt6Zf+ytx8n6CUTWIfefAKUlt0hGyeoPXS6vkHvENW7g5Sd
         ZM3/ofpYLnxBdg+Mu3WmeBpFhMInCP/JbGyDtFQQbAF1rQcpANg89WdAt7QI5hKcOfoA
         z4Yg==
X-Forwarded-Encrypted: i=1; AJvYcCW/O6GnWm/gSGKPMTL0Dp8piaxGlS0TZ+1jM9phRZfOvvJxhoIkHSV/qkg5D1jNc4v1FavhxPZPJdbyaw2bGvB1Di809r1mCTT3ZA1anKSumu6W85Oy/KvuX+S/KXavBz8h
X-Gm-Message-State: AOJu0Yzn9M7J76pZBJn4tt082/z3A0Gw64Me6qAg9a1nO3LIfvWj/aJN
	WeTm/hPJbW9Fek1Om63QQrruFU2JDj1YIT+NozCiS2rGd832FaN5+Vvj56PakRTesuUFSUrCdE4
	QgDlfesb1K0GVzlDmFYGF7F99ltU=
X-Google-Smtp-Source: AGHT+IFOMg2OJ5YJgQMKha2I9j/taqMwMA0kN2XIRspOFD/wRUx7YTn+ftuZKKdXuBjvac3cdyvRa5yCNRZ1h8UWG0M=
X-Received: by 2002:ac2:4541:0:b0:51e:efec:dfaa with SMTP id
 j1-20020ac24541000000b0051eefecdfaamr56193lfm.19.1714666869406; Thu, 02 May
 2024 09:21:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430175834.33152-1-puranjay@kernel.org> <20240430175834.33152-2-puranjay@kernel.org>
 <CAEf4Bzb2NY+wuK159Xb8F9Nu4CuVoYJ6WWR3_0LeTAi+zONewQ@mail.gmail.com> <87jzkcw5kx.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87jzkcw5kx.fsf@all.your.base.are.belong.to.us>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Thu, 2 May 2024 18:20:58 +0200
Message-ID: <CANk7y0gqpAqjp-Ny6GyCsmTB5uk3UGc0uHpPr=ujOD0Rz_ogWw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] riscv, bpf: add internal-only MOV
 instruction to resolve per-CPU addrs
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, bpf@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Pu Lehui <pulehui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 6:18=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.=
org> wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
> > On Tue, Apr 30, 2024 at 10:58=E2=80=AFAM Puranjay Mohan <puranjay@kerne=
l.org> wrote:
> >>
> >> Support an instruction for resolving absolute addresses of per-CPU
> >> data from their per-CPU offsets. This instruction is internal-only and
> >> users are not allowed to use them directly. They will only be used for
> >> internal inlining optimizations for now between BPF verifier and BPF
> >> JITs.
> >>
> >> RISC-V uses generic per-cpu implementation where the offsets for CPUs
> >> are kept in an array called __per_cpu_offset[cpu_number]. RISCV stores
> >> the address of the task_struct in TP register. The first element in
> >> task_struct is struct thread_info, and we can get the cpu number by
> >> reading from the TP register + offsetof(struct thread_info, cpu).
> >>
> >> Once we have the cpu number in a register we read the offset for that
> >> cpu from address: &__per_cpu_offset + cpu_number << 3. Then we add thi=
s
> >> offset to the destination register.
> >>
> >> To measure the improvement from this change, the benchmark in [1] was
> >> used on Qemu:
> >>
> >> Before:
> >> glob-arr-inc   :    1.127 =C2=B1 0.013M/s
> >> arr-inc        :    1.121 =C2=B1 0.004M/s
> >> hash-inc       :    0.681 =C2=B1 0.052M/s
> >>
> >> After:
> >> glob-arr-inc   :    1.138 =C2=B1 0.011M/s
> >> arr-inc        :    1.366 =C2=B1 0.006M/s
> >> hash-inc       :    0.676 =C2=B1 0.001M/s
> >>
> >> [1] https://github.com/anakryiko/linux/commit/8dec900975ef
> >>
> >> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> >> ---
> >>  arch/riscv/net/bpf_jit_comp64.c | 24 ++++++++++++++++++++++++
> >>  1 file changed, 24 insertions(+)
> >>
> >> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_=
comp64.c
> >> index 15e482f2c657..99d7006f1420 100644
> >> --- a/arch/riscv/net/bpf_jit_comp64.c
> >> +++ b/arch/riscv/net/bpf_jit_comp64.c
> >> @@ -12,6 +12,7 @@
> >>  #include <linux/stop_machine.h>
> >>  #include <asm/patch.h>
> >>  #include <asm/cfi.h>
> >> +#include <asm/percpu.h>
> >>  #include "bpf_jit.h"
> >>
> >>  #define RV_FENTRY_NINSNS 2
> >> @@ -1089,6 +1090,24 @@ int bpf_jit_emit_insn(const struct bpf_insn *in=
sn, struct rv_jit_context *ctx,
> >>                         emit_or(RV_REG_T1, rd, RV_REG_T1, ctx);
> >>                         emit_mv(rd, RV_REG_T1, ctx);
> >>                         break;
> >> +               } else if (insn_is_mov_percpu_addr(insn)) {
> >> +                       if (rd !=3D rs)
> >> +                               emit_mv(rd, rs, ctx);
>
> No biggie, but you did not fold this check into emit_mv().
>
> >> +#ifdef CONFIG_SMP
> >> +                               /* Load current CPU number in T1 */
> >> +                               emit_ld(RV_REG_T1, offsetof(struct thr=
ead_info, cpu),
> >> +                                       RV_REG_TP, ctx);
> >> +                               /* << 3 because offsets are 8 bytes */
> >> +                               emit_slli(RV_REG_T1, RV_REG_T1, 3, ctx=
);
> >> +                               /* Load address of __per_cpu_offset ar=
ray in T2 */
> >> +                               emit_addr(RV_REG_T2, (u64)&__per_cpu_o=
ffset, extra_pass, ctx);
> >> +                               /* Add offset of current CPU to  __per=
_cpu_offset */
> >> +                               emit_add(RV_REG_T1, RV_REG_T2, RV_REG_=
T1, ctx);
> >> +                               /* Load __per_cpu_offset[cpu] in T1 */
> >> +                               emit_ld(RV_REG_T1, 0, RV_REG_T1, ctx);
> >> +                               /* Add the offset to Rd */
> >> +                               emit_add(rd, rd, RV_REG_T1, ctx);
> >
> > is this the right level of code indentation?
>
> Looks wrong.
>
> When the indent is fixed, feel free to add:
>
> Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

I fixed the indent and sent it as part of:
https://lore.kernel.org/all/20240502151854.9810-1-puranjay@kernel.org/

Also, for the emit_mv() thing, I wanted to verify if we are using that
somewhere for zero-extension or something.
So, I thought I would send a separate patch for it.

Thanks,
Puranjay

