Return-Path: <bpf+bounces-74632-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B658CC5FED6
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 03:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE4BF4E8E0C
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 02:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308A821CC7B;
	Sat, 15 Nov 2025 02:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XovaOPLd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEFC17C21E
	for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 02:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763174733; cv=none; b=U+w79sdqO2Ivyfajsfj8WzB8qeBtyHUw+DTvEJIC0Mf8boGLgzYjCMgYW8Oc8NazXYPdpLIR0vktWbHtXG8hHijfSHhMXCQ3GgTWUaFChKRJ2nCz8Sk8TYlvdcYCSF7Wiu4wxgNNBYdNz+Gv36di2t41d6yzxBCi25uy37XByfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763174733; c=relaxed/simple;
	bh=qovHNVA8a4Cke1vsSaThgOVLaAnwW+r0ouVdZKEFgkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P7wDLIswaE/2ht1beF3BV/QgjP4rXc1lOz9O6Gf+35QhJs6mt1aAY9d+PoF/6YShPvPC6JxQJd9x+TH54i/9Gthnp9UjRGfQD/ibXFcFrbogNN/Q9SpWMgeOYBTy+y4WWS/nB3UQbMggwTjnA5zHgZdmBpgc2ZVJ5Jpce2JoB8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XovaOPLd; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42b3ac40ae4so1369812f8f.0
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 18:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763174730; x=1763779530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Iznb+ycCaFjwy0sjiThVROPdc3gzb1wG0QEJqjrcsQ=;
        b=XovaOPLdNBYPhd8S3M684PvgKr1CMCJ3WL/abz4l3sAYnNKjADjweP/8xsoxcSZSlM
         Qu4CCvIP9VJXcNJ6sqPmOVIoC1Yf+KvzNhOr6q2rqGE37uDH9w+PZNEkWFMDZYcoNlCT
         e+Q97T4GXlnCjRnbEnY59iRub7eyU5Qi2urj2/9KP7+6stN29tOv0Fa6LpfHgQetfhmM
         7CbtG/1gYnISV1XK/ZBF8dHG5lyFvSqa4eCd2D/NYMb0oQ/K1+dr5yw9f/S5ucLYv6Jj
         bjvAIWrLbHkfsOv2qRV5lxytsGPXfiEnVJ2qDdNqZgj63oQ0z0EYBFMVyX69Dkd3cmrr
         WrzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763174730; x=1763779530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9Iznb+ycCaFjwy0sjiThVROPdc3gzb1wG0QEJqjrcsQ=;
        b=BvSzhjInnHfqkisO0KpQj9O8wmjxyKsosje4AtHEI0OmtvvXg8kClfbIuP2lBlFOSZ
         AvhqibM5Ko6b8o5LPhDVo4FP+7ftCKZUnfe/T591ssCgfwmDhwwuhRZl4VEMh4GVCgU/
         +DpCNg9c3tQ1AJwZNL8MosHmLyiHu7AVpqDY3sF16iU9Uq+a6nxwqYaI7PU6tFmxjveT
         G1ty7Zk3E+JLYmIVQUZ8NPT/ztjsrb0OLHGkQjnPueJ7D5DnBPIg1llec7KV2etPfyGF
         43ju4cf6HcKtuLOTVX67POoxMfuwCTf+I9d4Pi2uZJUfUJtHWKz7wLJg8uV0ha+O8Fqk
         cLdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHlrWHQ+hRt/XF3My3T++kNdiqxgMBiPuxzDPRbmgD+zxpUQkU2wdnohxmYndOf2QYYTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxZG43+Rvq5Bvxty2ylk3Cr/thT2Out2B8h9Ww0nTivhDckvEo
	33Zfzvorf/6SjNQKKQfx2CG1OZVWJqwJ/uaWCs2N150ygsZm5tP36HgcpJHuN/lDbIEoYJJi4oH
	cSWkzByoa2i6H+UvKnurkBgSwagTUnOM=
X-Gm-Gg: ASbGnctR2btWUK7GZcQowYK0BVBNAqAKbpio5XfrGtJj535kMZi2s4uLB/cj9p7FzYb
	cusDnk5Men2XPFNQZN+7PbksN35x8fYvLnc1IcLj3lJglznx70olVFz/pk52YfnzAddgzQKkp5q
	P4sxNbGs2XGOMbWONUDG+VvNK+tMx/S9Vrb62rMZyMK5AgJGh1SMK8vpWBYON5WnYWK4MMvpj+C
	/GJGTDYq1cDGDyMyl5lF7T3TbJyCp6o2+/ITMP9js1VYaKY1aCnvT7b7RK9C/h7MdJhE5n0Ugkf
	LjaEHMHaP3xb9LURgYvqQP+PqTP0
X-Google-Smtp-Source: AGHT+IHpHF7RLkAKKDo+UXhAc3BNnfVhkf4Zmb/ighVBv3/ib/f/Ie/fE6cabwZouQpwiz1Vi5M4DGf98dCCtDBQd/o=
X-Received: by 2002:a05:6000:2911:b0:429:b9bc:e810 with SMTP id
 ffacd0b85a97d-42b59388427mr4571227f8f.45.1763174730036; Fri, 14 Nov 2025
 18:45:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110092536.4082324-1-pulehui@huaweicloud.com>
 <92ba87bbc6b11234be1925a4dc7262e11cd07305.camel@gmail.com>
 <CAADnVQ+2jdSD=HMMq3tKvu08gF49T=290LNzvc5LDOf4AycEuw@mail.gmail.com>
 <fb7f62db-4dc6-4614-a0c4-3b2a1904aadb@huawei.com> <CAADnVQLPJGPwx3CfgXBCZPHi_niGYTy+VFnyd50oNrDSkvyqPw@mail.gmail.com>
 <2612eeec-8948-41d6-9d41-4f1ec813d514@huaweicloud.com>
In-Reply-To: <2612eeec-8948-41d6-9d41-4f1ec813d514@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Nov 2025 18:45:18 -0800
X-Gm-Features: AWmQ_bkgPtam_dyklmGctQDadlcEgvGA7apCMBsk4Ckf9TWYLPmi6muWSQvZsS4
Message-ID: <CAADnVQJ_jZ+Cz9n3N=0b7xYwc-Vx_iwZLXrHTR8Mk4aytcEjKw@mail.gmail.com>
Subject: Re: [PATCH bpf v3] bpf: Fix invalid mem access when
 update_effective_progs fails in __cgroup_bpf_detach
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: Pu Lehui <pulehui@huawei.com>, Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 6:42=E2=80=AFPM Pu Lehui <pulehui@huaweicloud.com> =
wrote:
>
>
>
> On 2025/11/15 5:08, Alexei Starovoitov wrote:
> > On Mon, Nov 10, 2025 at 7:20=E2=80=AFPM Pu Lehui <pulehui@huawei.com> w=
rote:
> >>
> >>
> >> On 2025/11/11 9:13, Alexei Starovoitov wrote:
> >>> On Mon, Nov 10, 2025 at 12:36=E2=80=AFPM Eduard Zingerman <eddyz87@gm=
ail.com> wrote:
> >>>>
> >>>> On Mon, 2025-11-10 at 09:25 +0000, Pu Lehui wrote:
> >>>>> From: Pu Lehui <pulehui@huawei.com>
> >>>>>
> >>>>> Syzkaller triggers an invalid memory access issue following fault
> >>>>> injection in update_effective_progs. The issue can be described as
> >>>>> follows:
> >>>>>
> >>>>> __cgroup_bpf_detach
> >>>>>     update_effective_progs
> >>>>>       compute_effective_progs
> >>>>>         bpf_prog_array_alloc <-- fault inject
> >>>>>     purge_effective_progs
> >>>>>       /* change to dummy_bpf_prog */
> >>>>>       array->items[index] =3D &dummy_bpf_prog.prog
> >>>>>
> >>>>> ---softirq start---
> >>>>> __do_softirq
> >>>>>     ...
> >>>>>       __cgroup_bpf_run_filter_skb
> >>>>>         __bpf_prog_run_save_cb
> >>>>>           bpf_prog_run
> >>>>>             stats =3D this_cpu_ptr(prog->stats)
> >>>>>             /* invalid memory access */
> >>>>>             flags =3D u64_stats_update_begin_irqsave(&stats->syncp)
> >>>>> ---softirq end---
> >>>>>
> >>>>>     static_branch_dec(&cgroup_bpf_enabled_key[atype])
> >>>>>
> >>>>> The reason is that fault injection caused update_effective_progs to=
 fail
> >>>>> and then changed the original prog into dummy_bpf_prog.prog in
> >>>>> purge_effective_progs. Then a softirq came, and accessing the stats=
 of
> >>>>> dummy_bpf_prog.prog in the softirq triggers invalid mem access.
> >>>>>
> >>>>> To fix it, we can use static per-cpu variable to initialize the sta=
ts
> >>>>> of dummy_bpf_prog.prog.
> >>>>>
> >>>>> Fixes: 4c46091ee985 ("bpf: Fix KASAN use-after-free Read in compute=
_effective_progs")
> >>>>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> >>>>> ---
> >>>>
> >>>> Hi Pu,
> >>>>
> >>>> Sorry for the delayed response. This patch looks good to me, but I
> >>>> think that your argument about memory consumption makes total sense.
> >>>> It might be the case that v1 is a better fix. Let's hear from Alexei=
.
> >>>
> >>
> >> Hi Alexei,
> >>
> >>> I don't particularly like either v1 or v2.
> >>> Runtime penalty to bpf_prog_run_array_cg() is not nice.
> >>> Memory waste with __dummy_stats is not good as well.
> >>
> >> Indeed a trade-off between time and space before better solution.
> >>
> >>>
> >>> Also v1 doesn't really fix it, since prog_array is
> >>> used not only by cgroup.
> >>> perf_event_detach_bpf_prog() does bpf_prog_array_delete_safe() too.
> >>
> >> I noticed that too, but before syncing to other parts of the
> >> bpf_prog_array, I found there were some shotgun-style modifications, s=
o
> >> I switched to initializing per-cpu variables to minimize changes.
> >>
> >>>
> >>> Another option is to add a runtime check to __bpf_prog_run()
> >>> but it isn't great either.
> >>
> >> Yep, same runtime penalty, but simpler than v1 =E2=80=93 will we use t=
his to patch?
> >>
> >> --- a/include/linux/filter.h
> >> +++ b/include/linux/filter.h
> >> @@ -712,11 +712,13 @@ static __always_inline u32 __bpf_prog_run(const
> >> struct bpf_prog *prog,
> >>                   ret =3D dfunc(ctx, prog->insnsi, prog->bpf_func);
> >>
> >>                   duration =3D sched_clock() - start;
> >> -               stats =3D this_cpu_ptr(prog->stats);
> >> -               flags =3D u64_stats_update_begin_irqsave(&stats->syncp=
);
> >> -               u64_stats_inc(&stats->cnt);
> >> -               u64_stats_add(&stats->nsecs, duration);
> >> -               u64_stats_update_end_irqrestore(&stats->syncp, flags);
> >> +               if (likely(prog->stats)) {
> >> +                       stats =3D this_cpu_ptr(prog->stats);
> >> +                       flags =3D
> >> u64_stats_update_begin_irqsave(&stats->syncp);
> >> +                       u64_stats_inc(&stats->cnt);
> >> +                       u64_stats_add(&stats->nsecs, duration);
> >> +                       u64_stats_update_end_irqrestore(&stats->syncp,
> >> flags);
> >> +               }
> >
> > Yeah. Let's do this. Pls submit it as a proper patch.
>
> Hi Alexei,
>
> How about making the stats update a callback function? That is, the
> dummy flow does nothing, while the others follow the normal process.
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index d808253f2e94..7bd784c58309 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1738,6 +1738,7 @@ struct bpf_prog {
>                 u8 tag[BPF_TAG_SIZE];
>         };
>         struct bpf_prog_stats __percpu *stats;
> +       void (*update_stats)(struct bpf_prog_stats __percpu *stats, u64 d=
uration);
>         int __percpu            *active;
>         unsigned int            (*bpf_func)(const void *ctx,
>                                             const struct bpf_insn *insn);
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index f5c859b8131a..eb2c464880fd 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -705,18 +705,12 @@ static __always_inline u32 __bpf_prog_run(const
> struct bpf_prog *prog,
>
>         cant_migrate();
>         if (static_branch_unlikely(&bpf_stats_enabled_key)) {
> -               struct bpf_prog_stats *stats;
>                 u64 duration, start =3D sched_clock();
> -               unsigned long flags;
>
>                 ret =3D dfunc(ctx, prog->insnsi, prog->bpf_func);
>
>                 duration =3D sched_clock() - start;
> -               stats =3D this_cpu_ptr(prog->stats);
> -               flags =3D u64_stats_update_begin_irqsave(&stats->syncp);
> -               u64_stats_inc(&stats->cnt);
> -               u64_stats_add(&stats->nsecs, duration);
> -               u64_stats_update_end_irqrestore(&stats->syncp, flags);
> +               prog->update_stats(prog->stats, duration);

Interesting idea, but no. Indirect calls are slow. Especially
with retpoline. Even if you static_call() it. It is still slower
than extra 'if'.

