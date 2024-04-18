Return-Path: <bpf+bounces-27179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3544E8AA571
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 00:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 593871C21153
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 22:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9795199EB0;
	Thu, 18 Apr 2024 22:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBVmapYq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB839168B06;
	Thu, 18 Apr 2024 22:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713479066; cv=none; b=DjQrKLTPkr57xhl00n+w28/Qc4xmN/bbNLHKn+dZi3llxkFmItSL0n3au6yhhMetFKtSD4GOGBfKShpJ9X9RxHxHUU+nk2yV8khVL9/8M4WqJaLLepYntK+r5ILh/AXM9XrWm/TIsMdbO/vvzUpbv1slM9rH2RkpMxgFnrsP5kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713479066; c=relaxed/simple;
	bh=4XIhe4LfbJ8qWHDQkf0DWffnpOmWtniEjgZwZ66z7HY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QYlmi81b/4VP0KO+7PBtElZyPsrDeRRJ53tlQvg+3R+3gSItZAeNwBVBl2Zhw2SHDa8JEw96WXi84zixO+JISxXpTx4Dr9EhwuB9lORfzd72RQa4JWbL5hTy2zUsaPl9rdU2GSY2U4igQkYgvIyWlieTkIwtLwCzaLS/bk816Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBVmapYq; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2a78c2e253aso1198134a91.3;
        Thu, 18 Apr 2024 15:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713479064; x=1714083864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=deUJvXeVY3838w4CjTqAEiIczD57MmjPpFzLc8yadh4=;
        b=jBVmapYqAnDOFPzizbPRAEZaFOsfdgW9zJHSn2kd8bqj2NrzVDbBohekZ5HgR/Ir/N
         Z5awE/ltdxz9HM4Ie5gt0mqR063ysLiJnSIt1Ok384WgT+4OmLt0+qZadhyUJQTzbxxc
         Ao7yI2gQK6StBlzqGCEvFhBsO63AFg7hNOxam3eApHHiZbhs4GPHWLwSrumPiybbeTit
         L3kssZWoJziO+KrXN1njh9p5nROFo5OPjltT8KqrvNKVv9gsbMDEYnQppYuNoPwQnYpi
         0TwiKW/PrP1lt9IJczfB7/6zgurgtG3IhqX1hvuSQx8z7UCIfyy4Nka5MpP6EFxgQoQu
         fM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713479064; x=1714083864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=deUJvXeVY3838w4CjTqAEiIczD57MmjPpFzLc8yadh4=;
        b=Ssq6h1+T4umDRKTtS+lVQgBvQ7A+gWoDWkutYo8pz6tp/DAIZ6h6cT//jjGlDRN+gt
         SOQQpvWxMoxa/63ycpW88k902OfKPDqwKMvDoW1FViOsb9CjEKqX0bQ+0xBxBw1MGjJb
         6j9ESOoqEdKAN8NFC2zTLZALvxrZ2JPotyk1FjO6WSUtBzHi/YbVshfTLo+M0MW5zi5P
         +VOKTTmIzLGO628ZHHEpkErHjImGDX0QvhIHjb+RlS6aVqfuL4gP1aDf1yCBkQP08OM5
         6OpXF8/pARtDDzKDse/pHWfB3V9WeW27yuWR1ADfxawH4KsNlO/WTiHV+ordBVm55Qr4
         j3qg==
X-Forwarded-Encrypted: i=1; AJvYcCUc7IUSPLMeJlHmoeYGlHsZSPxXSppou8niKzZQplcqq8pErGV00oHtVG6AMP8pNf3KNdWkbeKzKidkFVgtGpHQL/iIGvK8AEm30xFz0V8MavtDQb0ytD7EVWrez4tZBjG3
X-Gm-Message-State: AOJu0YzbdKfzlNFbzDNaGDW1ccNHRrq6YypF2T6Z440Mq8zAN8cfcTz1
	FmoHQNHlvkrm5EgcBU2S8kU/p5CJ7UB079fRVTw/pVNTXS6tXQnc7u6NGPVvZFdenuPb+a67KVP
	MtkcIi0fgKRbRHFrXbn7rumuc2AAxgg==
X-Google-Smtp-Source: AGHT+IFVkNK2HKAQnoLco34pMJP8gkECXKggNPuoeOQagYF3NGXKTKpy/uzP/lCl0KuENwUqAaSFPNGh1aHg6OzXk/M=
X-Received: by 2002:a05:6a21:2b13:b0:1a9:c3ac:c6d4 with SMTP id
 ss19-20020a056a212b1300b001a9c3acc6d4mr467473pzb.62.1713479064034; Thu, 18
 Apr 2024 15:24:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405124348.27644-1-puranjay12@gmail.com> <CAEf4BzZ2Tz5-GwbQKYg7KoGwqN8ewPBakmghHaH20MfoATe74g@mail.gmail.com>
 <87cyr0uwsg.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87cyr0uwsg.fsf@all.your.base.are.belong.to.us>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 18 Apr 2024 15:24:11 -0700
Message-ID: <CAEf4BzahfDssv6SgKYmay+CxQ7GAY9TD5LPG8D9NjGrzMBY28Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] riscv, bpf: add internal-only MOV instruction to
 resolve per-CPU addrs
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, bpf@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Pu Lehui <pulehui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 12:40=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
.org> wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
> > On Fri, Apr 5, 2024 at 5:44=E2=80=AFAM Puranjay Mohan <puranjay12@gmail=
.com> wrote:
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
> >> tast_struct is struct thread_info, and we can get the cpu number by
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
> >
> > TBH, I don't trust benchmarks done inside QEMU. Can you try running
> > this on some real hardware?
>
> I just ran it on a "VisionFive2" SBC:
>
> BEFORE
> =3D=3D=3D=3D=3D=3D
> glob-arr-inc   :   11.586 =C2=B1 0.021M/s
> arr-inc        :   10.892 =C2=B1 0.005M/s
> hash-inc       :    1.517 =C2=B1 0.001M/s
>
> AFTER
> =3D=3D=3D=3D=3D
> glob-arr-inc   :   11.893 =C2=B1 0.017M/s  (+2.6%)
> arr-inc        :   11.630 =C2=B1 0.020M/s  (+6.8%)
> hash-inc       :    1.543 =C2=B1 0.002M/s  (+1.7%)
>

Nice, looks pretty reasonable (and especially if
bpf_smp_get_current_id() gets inlined as well, the numbers should be
even better)


> (It's early, and the coffee haven't kicked in, so I hope the
> calculations are correct...)
>
> >>
> >> [1] https://github.com/anakryiko/linux/commit/8dec900975ef
> >>
> >> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> >> ---
> >>  arch/riscv/net/bpf_jit_comp64.c | 24 ++++++++++++++++++++++++
> >>  1 file changed, 24 insertions(+)
> >>
> >> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_=
comp64.c
> >> index 15e482f2c657..e95bd1d459a4 100644
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
> >
> > Is this an unconditional move instruction? in x86-64, EMIT_mov checks
> > whether source and destination registers are the same and doesn't emit
> > anything if they match (which makes sense, right)?
>
> Yeah, it is. Folding the check into the emit sounds like a good idea.
>

great

>
> Bj=C3=B6rn

