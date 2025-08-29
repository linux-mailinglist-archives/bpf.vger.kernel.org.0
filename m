Return-Path: <bpf+bounces-67031-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B63F4B3C2B2
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 20:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10E0D1CC4A2D
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 18:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A55230BE9;
	Fri, 29 Aug 2025 18:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSc/h3Tt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C6D30CD9F;
	Fri, 29 Aug 2025 18:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756493405; cv=none; b=CpKQA3RDJYxSzFn1nrU4f0vw/XmFz08rnNNxejhJCB04d1MYvjF12HhZYTBYa8MxZIBQE/OX5pkt0AaYnKjiMwmFR1i7NIPn0pwrfZ88H1ICLf2DOxSPM2iiX0sj8SXAro5+Rvr9eEUVqLYQW17K8opXGWngb9wNgTEL2SutRDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756493405; c=relaxed/simple;
	bh=kRzuQPQvzBNdotMBP7pTnWR1VHUeXzZCdlNmYEGfLEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kCs2Pys2BuBLYkTSGcoLil969Z5vy5PsdLoLL1LAu/JU9rdclCUvUeH6uLkEMef5wnD52HTbCtpDINNOaeOHznWK+wS0jLpj8gYCivXJe0RlMxwDM0rGmu2iZETOue6UcpA4ZxYYztwQdwB7vvGkFcgpsbZthCaS8FYlGx+Ed08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pSc/h3Tt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2809C4CEFA;
	Fri, 29 Aug 2025 18:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756493404;
	bh=kRzuQPQvzBNdotMBP7pTnWR1VHUeXzZCdlNmYEGfLEI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pSc/h3TtTy66683UtsDFjw5lfDUKOX657sak2OgwgcNNq8iAF2xrzqwbaGjLCl6f9
	 gMUiA8FQFKciBfUWGxeAFKmv4EivlxR6NMzZm0EUiZE06VFFq0AvnWE5jai8HvfewA
	 VNcdLxiKLxViNlBPEohTpFP57ldZJciAsjLAVWfRWPhvZtMAbMuhOxLo/kzBbQ5AwW
	 0ABh+4brs214VNfQCNKcgUqPBjWrS2joxC00kJjkKSNmC2HPFT9mXc0Lz4Rt28zkiz
	 RIO3jV77ZsszpwA6njjtwVx2hnhV6v58lZg6hxYxn/lMxmMpZDMvYl4y9etBiL5Vs4
	 sf2uYuX0CRx0w==
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7f7e89e4b37so233845185a.3;
        Fri, 29 Aug 2025 11:50:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV1tSsR5kMP7WQF1hsueleSbDT6sdyuCOpCP+IFhpLU/dziHaTC+zbZqYia9c/sKNiotCttiYdD3GvdMib6@vger.kernel.org, AJvYcCWHAnL+XpchO0b/KBFodxC3xipBldobCzmHgjIInobYeNwCWKrOzb1B/6gZno26BpaemZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0udDmHmWphj9RHa2rRLrrKGiqEP1Bcf8l6guTQcAZ+i8nixSJ
	8uDC2kMZS8bE1L1eH3edyiLYi/VbqKRkj7eNw+L4rr1Et9BcKy9a/hbYCKb/nLLDVGqi2NJPzIo
	3XOmjzydAnp9Sf8fcnoNm48dyvcAzJBA=
X-Google-Smtp-Source: AGHT+IGk+2e+MtbMfwnwjvMNj8yikW5bC6K516UGdm2sSFuCWKS1iZedV3T1faNau0Cipnb+kFsu14fOLq5avBSWm94=
X-Received: by 2002:a05:620a:4706:b0:7fc:b747:3168 with SMTP id
 af79cd13be357-7fcb74734a0mr375745085a.71.1756493403865; Fri, 29 Aug 2025
 11:50:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826212229.143230-1-contact@arnaud-lcm.com>
 <20250826212352.143299-1-contact@arnaud-lcm.com> <CAADnVQ+6bV3h3i-A1LHbEk=nY_PMx69BiogWjf5GtGaLxWSQVg@mail.gmail.com>
In-Reply-To: <CAADnVQ+6bV3h3i-A1LHbEk=nY_PMx69BiogWjf5GtGaLxWSQVg@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Fri, 29 Aug 2025 11:49:52 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5P4sOHmMCmVTZw2vfuz7Rny-xkhuPkRBitfoATQkm=eA@mail.gmail.com>
X-Gm-Features: Ac12FXx2yvfNrnZ_hVhKtaFpA_xeHScVvOotbYo86wZxc1kdVMhhG9MXCo_IIb4
Message-ID: <CAPhsuW5P4sOHmMCmVTZw2vfuz7Rny-xkhuPkRBitfoATQkm=eA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/2] bpf: fix stackmap overflow check in __bpf_get_stackid()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Arnaud Lecomte <contact@arnaud-lcm.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 10:29=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
[...]
> >
> >  static long __bpf_get_stackid(struct bpf_map *map,
> > -                             struct perf_callchain_entry *trace, u64 f=
lags)
> > +                             struct perf_callchain_entry *trace, u64 f=
lags, u32 max_depth)
> >  {
> >         struct bpf_stack_map *smap =3D container_of(map, struct bpf_sta=
ck_map, map);
> >         struct stack_map_bucket *bucket, *new_bucket, *old_bucket;
> > @@ -263,6 +263,8 @@ static long __bpf_get_stackid(struct bpf_map *map,
> >
> >         trace_nr =3D trace->nr - skip;
> >         trace_len =3D trace_nr * sizeof(u64);
> > +       trace_nr =3D min(trace_nr, max_depth - skip);
> > +
>
> The patch might have fixed this particular syzbot repro
> with OOB in stackmap-with-buildid case,
> but above two line looks wrong.
> trace_len is computed before being capped by max_depth.
> So non-buildid case below is using
> memcpy(new_bucket->data, ips, trace_len);
>
> so OOB is still there?

+1 for this observation.

We are calling __bpf_get_stackid() from two functions: bpf_get_stackid
and bpf_get_stackid_pe. The check against max_depth is only needed
from bpf_get_stackid_pe, so it is better to just check here.

I have got the following on top of patch 1/2. This makes more sense to
me.

PS: The following also includes some clean up in __bpf_get_stack.
I include those because it also uses stack_map_calculate_max_depth.

Does this look better?

Thanks,
Song


diff --git c/kernel/bpf/stackmap.c w/kernel/bpf/stackmap.c
index 796cc105eacb..08554fb146e1 100644
--- c/kernel/bpf/stackmap.c
+++ w/kernel/bpf/stackmap.c
@@ -262,7 +262,7 @@ static long __bpf_get_stackid(struct bpf_map *map,
                return -EFAULT;

        trace_nr =3D trace->nr - skip;
-       trace_len =3D trace_nr * sizeof(u64);
+
        ips =3D trace->ip + skip;
        hash =3D jhash2((u32 *)ips, trace_len / sizeof(u32), 0);
        id =3D hash & (smap->n_buckets - 1);
@@ -297,6 +297,7 @@ static long __bpf_get_stackid(struct bpf_map *map,
                        return -EEXIST;
                }
        } else {
+               trace_len =3D trace_nr * sizeof(u64);
                if (hash_matches && bucket->nr =3D=3D trace_nr &&
                    memcmp(bucket->data, ips, trace_len) =3D=3D 0)
                        return id;
@@ -322,19 +323,17 @@ static long __bpf_get_stackid(struct bpf_map *map,
 BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
           u64, flags)
 {
-       u32 max_depth =3D map->value_size / stack_map_data_size(map);
-       u32 skip =3D flags & BPF_F_SKIP_FIELD_MASK;
+       u32 elem_size =3D stack_map_data_size(map);
        bool user =3D flags & BPF_F_USER_STACK;
        struct perf_callchain_entry *trace;
        bool kernel =3D !user;
+       u32 max_depth;

        if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
                               BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID))=
)
                return -EINVAL;

-       max_depth +=3D skip;
-       if (max_depth > sysctl_perf_event_max_stack)
-               max_depth =3D sysctl_perf_event_max_stack;
+       max_depth =3D stack_map_calculate_max_depth(map->value_size,
elem_size, flags);

        trace =3D get_perf_callchain(regs, 0, kernel, user, max_depth,
                                   false, false);
@@ -375,6 +374,7 @@ BPF_CALL_3(bpf_get_stackid_pe, struct
bpf_perf_event_data_kern *, ctx,
        bool kernel, user;
        __u64 nr_kernel;
        int ret;
+       u32 elem_size, max_depth;

        /* perf_sample_data doesn't have callchain, use bpf_get_stackid */
        if (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN))
@@ -393,11 +393,12 @@ BPF_CALL_3(bpf_get_stackid_pe, struct
bpf_perf_event_data_kern *, ctx,
                return -EFAULT;

        nr_kernel =3D count_kernel_ip(trace);
-
+       elem_size =3D stack_map_data_size(map);
        if (kernel) {
                __u64 nr =3D trace->nr;

-               trace->nr =3D nr_kernel;
+               max_depth =3D
stack_map_calculate_max_depth(map->value_size, elem_size, flags);
+               trace->nr =3D min_t(u32, nr_kernel, max_depth);
                ret =3D __bpf_get_stackid(map, trace, flags);

                /* restore nr */
@@ -410,6 +411,8 @@ BPF_CALL_3(bpf_get_stackid_pe, struct
bpf_perf_event_data_kern *, ctx,
                        return -EFAULT;

                flags =3D (flags & ~BPF_F_SKIP_FIELD_MASK) | skip;
+               max_depth =3D
stack_map_calculate_max_depth(map->value_size, elem_size, flags);
+               trace->nr =3D min_t(u32, trace->nr, max_depth);
                ret =3D __bpf_get_stackid(map, trace, flags);
        }
        return ret;
@@ -428,7 +431,7 @@ static long __bpf_get_stack(struct pt_regs *regs,
struct task_struct *task,
                            struct perf_callchain_entry *trace_in,
                            void *buf, u32 size, u64 flags, bool may_fault)
 {
-       u32 trace_nr, copy_len, elem_size, num_elem, max_depth;
+       u32 trace_nr, copy_len, elem_size, max_depth;
        bool user_build_id =3D flags & BPF_F_USER_BUILD_ID;
        bool crosstask =3D task && task !=3D current;
        u32 skip =3D flags & BPF_F_SKIP_FIELD_MASK;
@@ -465,13 +468,15 @@ static long __bpf_get_stack(struct pt_regs
*regs, struct task_struct *task,
        if (may_fault)
                rcu_read_lock(); /* need RCU for perf's callchain below */

-       if (trace_in)
+       if (trace_in) {
                trace =3D trace_in;
-       else if (kernel && task)
+               trace->nr =3D min_t(u32, trace->nr, max_depth);
+       } else if (kernel && task) {
                trace =3D get_callchain_entry_for_task(task, max_depth);
-       else
+       } else {
                trace =3D get_perf_callchain(regs, 0, kernel, user, max_dep=
th,
                                           crosstask, false);
+       }

        if (unlikely(!trace) || trace->nr < skip) {
                if (may_fault)
@@ -479,9 +484,7 @@ static long __bpf_get_stack(struct pt_regs *regs,
struct task_struct *task,
                goto err_fault;
        }

-       num_elem =3D size / elem_size;
        trace_nr =3D trace->nr - skip;
-       trace_nr =3D (trace_nr <=3D num_elem) ? trace_nr : num_elem;
        copy_len =3D trace_nr * elem_size;

        ips =3D trace->ip + skip;

