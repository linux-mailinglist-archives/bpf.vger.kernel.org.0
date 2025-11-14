Return-Path: <bpf+bounces-74563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0154EC5F50D
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 22:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 90A854E07CA
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 21:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB162FCC04;
	Fri, 14 Nov 2025 21:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgPe7syf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249411E1A3D
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 21:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763154527; cv=none; b=kLxEsY8EV6oig+WiLDHFzetm1aoA3jTqWUg4waZKfGFyHQYmhu+L4d9GPPJRzdWQLOzbuIjVwYkzk1SN+3sO4QexU3wRMwKCLGuTgJHqzs4eojzWl6WnK1aeVZV1xYYUKZ+BlotMzZFApRlDpDL914rTR6SfLMWdrpC6Sz93EUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763154527; c=relaxed/simple;
	bh=KRMGGNY122g8lZkeQzU6dKyq7XOXru+RZ32H2Mv+h7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G1kvYu1gCmaB0fi1boqi+oCdesVlfhaG4SyEfo1xpXnZ67MM3bIOvwuAgiqxYh29zk/2d4AW81F6cTP7QrPptFuqhb6T4JwZ4sC1pnNWOkvb0YMJ6W5MNWbi12i1pjOlACPa+5QJv0LsT/yZ0dcvAovmDy0RxKE8dB1TkRjiWn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgPe7syf; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42b2e9ac45aso1671286f8f.0
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 13:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763154524; x=1763759324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGV6lDsgtvsiqMUXROmCMiUdRgqENQwi46dlRVJgAWM=;
        b=ZgPe7syfP3RbX/Fo431AR6ysi+WllMBZSWtUatF84ZWDO4o9hsdiOx65gkmmNw3W3C
         l4vwxFUC1S7hnDTUf597VRv0YUTJoIHHVCY3oZ71EQMHBxgpvparX66TT6r4jp/kF71e
         Yybdz8rBJ2Q/RtuXUdn5Ke18Gi6hfIML7gh8COOggIcXBawlPqN29MH7O9+MsQf+QdE9
         nqM8QnJ8S2JC2i5nhY85XhTNUOAM4yLTA8OpgwzPMaV/Fdzt1vXNyU7m/uxNRim7I699
         npvYCqySKE4WmA21eNNqVKXdHOxVUaEXIpXHPbADrdS2RZoz3oYbBVgB0LfPltMAF1CS
         Fz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763154524; x=1763759324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jGV6lDsgtvsiqMUXROmCMiUdRgqENQwi46dlRVJgAWM=;
        b=OQGAyRix+OuPCqztDUdWyC2Gn4GGpSWA78fJweGPcFXbCfoFJ4ogAPy4ulT2NfOqqk
         mOjDekejXwrn3Js2ck1QWUkPzOuvzQSca0zFeAIuUY37M7+Sqnqu4vGZp1JFM9Pou1gR
         FS7vFwI3JASTZv5njMtiCfvwNdxn2Ak9yR3Lxep8d4Ch2C+sD2VENk320efm0byBGsAP
         SdYPCCwpCnj9UXUH8BcVsGwvlc49VV1rKM3z0AlRVipJRD+EFNHlgUJ6nxSdI0WXGkUS
         uvDzW7l3DD/i+0etosfxpdMnLTlzHq0OLug5tRp2n8GVZ12rjMHHigFOWK3XsAQmhpK9
         d5EA==
X-Forwarded-Encrypted: i=1; AJvYcCXoayCb96W5ktAZ1B2hlg3b5rSnJ1H7YX3DncHvIzlWXjiSjx9Ilj6BbLDwsAUkj3jqQw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCuO6hOQI/Aqp07Yz3rvpS8L4upKq2JanuE8vmKYKyEk35IG6m
	8qrIk5I5lmRNcK1VsN461zbHj3mHKwHdKyhPEl3eQZbHU2sS1QGLbqhADzSYM/wgZuxOzryHFZn
	ybg98Cn9zz7Dgxv39P2lu+j3hmFr1Zno=
X-Gm-Gg: ASbGncsLLj60T+DdB7HHHP3yzuC/VeBCJP1dbkA/7xecLQSdKkSYHYa55sZ1L5cX3Oq
	B0PYsB1SNTpTQ+DXMYltfFm4TFf66VX66BehSc6lqUnUrWE13kzGPPTRhQ59JX27wHC5r+jHtex
	LExnAlmWb+fdDPKnXPn+fIJxQdbGTbTEreXcBQWdmiD7enx5Rujbx+OjcCXBhmvt9JDyaUIrWRh
	6v0q1aFQNDEh2M24EpiPHwlwA/bjZEwYWNEoMXoYJzF4FVq4zXwT1TXjX4uBofk96xF3HJlT9B5
	DWqpxcFp5VLNUNFarrvqD02chqEifVED4Kq0XXc=
X-Google-Smtp-Source: AGHT+IFuUE3sEWNAqFuNxoo0MuMUFYy9e2lFskZYHT3gAyhYO80IVRKhcB+9b0jc8WaYA0laYckja4+JTKFe+Z4BhSY=
X-Received: by 2002:a05:6000:2689:b0:42b:2dfd:534f with SMTP id
 ffacd0b85a97d-42b5938ab93mr4000498f8f.34.1763154524336; Fri, 14 Nov 2025
 13:08:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110092536.4082324-1-pulehui@huaweicloud.com>
 <92ba87bbc6b11234be1925a4dc7262e11cd07305.camel@gmail.com>
 <CAADnVQ+2jdSD=HMMq3tKvu08gF49T=290LNzvc5LDOf4AycEuw@mail.gmail.com> <fb7f62db-4dc6-4614-a0c4-3b2a1904aadb@huawei.com>
In-Reply-To: <fb7f62db-4dc6-4614-a0c4-3b2a1904aadb@huawei.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Nov 2025 13:08:33 -0800
X-Gm-Features: AWmQ_blpgFK64G91EMaRHm4MOZIY5MaZfYhfnG-Fv52VJVOhS92JpqmPRw50iDU
Message-ID: <CAADnVQLPJGPwx3CfgXBCZPHi_niGYTy+VFnyd50oNrDSkvyqPw@mail.gmail.com>
Subject: Re: [PATCH bpf v3] bpf: Fix invalid mem access when
 update_effective_progs fails in __cgroup_bpf_detach
To: Pu Lehui <pulehui@huawei.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Pu Lehui <pulehui@huaweicloud.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 7:20=E2=80=AFPM Pu Lehui <pulehui@huawei.com> wrote=
:
>
>
> On 2025/11/11 9:13, Alexei Starovoitov wrote:
> > On Mon, Nov 10, 2025 at 12:36=E2=80=AFPM Eduard Zingerman <eddyz87@gmai=
l.com> wrote:
> >>
> >> On Mon, 2025-11-10 at 09:25 +0000, Pu Lehui wrote:
> >>> From: Pu Lehui <pulehui@huawei.com>
> >>>
> >>> Syzkaller triggers an invalid memory access issue following fault
> >>> injection in update_effective_progs. The issue can be described as
> >>> follows:
> >>>
> >>> __cgroup_bpf_detach
> >>>    update_effective_progs
> >>>      compute_effective_progs
> >>>        bpf_prog_array_alloc <-- fault inject
> >>>    purge_effective_progs
> >>>      /* change to dummy_bpf_prog */
> >>>      array->items[index] =3D &dummy_bpf_prog.prog
> >>>
> >>> ---softirq start---
> >>> __do_softirq
> >>>    ...
> >>>      __cgroup_bpf_run_filter_skb
> >>>        __bpf_prog_run_save_cb
> >>>          bpf_prog_run
> >>>            stats =3D this_cpu_ptr(prog->stats)
> >>>            /* invalid memory access */
> >>>            flags =3D u64_stats_update_begin_irqsave(&stats->syncp)
> >>> ---softirq end---
> >>>
> >>>    static_branch_dec(&cgroup_bpf_enabled_key[atype])
> >>>
> >>> The reason is that fault injection caused update_effective_progs to f=
ail
> >>> and then changed the original prog into dummy_bpf_prog.prog in
> >>> purge_effective_progs. Then a softirq came, and accessing the stats o=
f
> >>> dummy_bpf_prog.prog in the softirq triggers invalid mem access.
> >>>
> >>> To fix it, we can use static per-cpu variable to initialize the stats
> >>> of dummy_bpf_prog.prog.
> >>>
> >>> Fixes: 4c46091ee985 ("bpf: Fix KASAN use-after-free Read in compute_e=
ffective_progs")
> >>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> >>> ---
> >>
> >> Hi Pu,
> >>
> >> Sorry for the delayed response. This patch looks good to me, but I
> >> think that your argument about memory consumption makes total sense.
> >> It might be the case that v1 is a better fix. Let's hear from Alexei.
> >
>
> Hi Alexei,
>
> > I don't particularly like either v1 or v2.
> > Runtime penalty to bpf_prog_run_array_cg() is not nice.
> > Memory waste with __dummy_stats is not good as well.
>
> Indeed a trade-off between time and space before better solution.
>
> >
> > Also v1 doesn't really fix it, since prog_array is
> > used not only by cgroup.
> > perf_event_detach_bpf_prog() does bpf_prog_array_delete_safe() too.
>
> I noticed that too, but before syncing to other parts of the
> bpf_prog_array, I found there were some shotgun-style modifications, so
> I switched to initializing per-cpu variables to minimize changes.
>
> >
> > Another option is to add a runtime check to __bpf_prog_run()
> > but it isn't great either.
>
> Yep, same runtime penalty, but simpler than v1 =E2=80=93 will we use this=
 to patch?
>
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -712,11 +712,13 @@ static __always_inline u32 __bpf_prog_run(const
> struct bpf_prog *prog,
>                  ret =3D dfunc(ctx, prog->insnsi, prog->bpf_func);
>
>                  duration =3D sched_clock() - start;
> -               stats =3D this_cpu_ptr(prog->stats);
> -               flags =3D u64_stats_update_begin_irqsave(&stats->syncp);
> -               u64_stats_inc(&stats->cnt);
> -               u64_stats_add(&stats->nsecs, duration);
> -               u64_stats_update_end_irqrestore(&stats->syncp, flags);
> +               if (likely(prog->stats)) {
> +                       stats =3D this_cpu_ptr(prog->stats);
> +                       flags =3D
> u64_stats_update_begin_irqsave(&stats->syncp);
> +                       u64_stats_inc(&stats->cnt);
> +                       u64_stats_add(&stats->nsecs, duration);
> +                       u64_stats_update_end_irqrestore(&stats->syncp,
> flags);
> +               }

Yeah. Let's do this. Pls submit it as a proper patch.

