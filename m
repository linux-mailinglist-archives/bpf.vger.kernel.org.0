Return-Path: <bpf+bounces-78428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C29DD0C90E
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 00:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 178D930274DC
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 23:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D86530C354;
	Fri,  9 Jan 2026 23:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noh2xcWp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EC91531E8
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 23:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768002467; cv=none; b=MJEix6szDHAIYYGECaK2TEx26UDJaLt8hEXcGP8J/pK8M8wDtOVsqKTmKMKZaBwG9Ll3/Bk3WDKupQXfr3qhgfCXNKpuan/GYOGI+EH+zRekPRPIyFBZl1Jxa4RI5dpOPfLWkivzNfgjGQ8aJ6wkQF8xZ53qI/T5M9PRRbchtN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768002467; c=relaxed/simple;
	bh=N1+r/aQt/Lt3seqrxbec5CLUW7FCRWxmpoR4OKKZs+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hNP2owzKprx/CEASP2AFYuKxJp1ABBP2gXh2UDKGymGK3gXjw4Pqzrn1ZVqnUqINdYffUDf+CUeRUgxCECtvqz8OiqKxtNgI9K8BB8FXjBEd6lSrNId3Ul8fd7f1kK4mWl5tJSODOHbh55NNPrn1X/sokGbg9kdm4h8eGOj0tHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=noh2xcWp; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-34c565c3673so1726268a91.0
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 15:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768002465; x=1768607265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLD52LJJpgXkbHmHOmGMHJXgRsruMv9okey27w/iLfA=;
        b=noh2xcWp1pGZW+1shUql9K2u9LxEw9Z1AKZrVEejAbsf26y3y/DR7IiSVzO41Dg5AG
         88ycg/Sa2tWzIGafmv9le6zVU5xAyXfgtzuxiV2qLP/bDIzRKU5Jg9t5srfqningOwEY
         /3SqoewHO4yy9Re5FLv20sbRCrPmZpEpokLRP3UCXjsnPnyswgEPSzRatjFHDPl9WLyl
         i5ZyBfCB6CLmxcSFgaBgHt0+07Cvp03/jjb1YEG4IyqN9/axM9F7bJVWPCrVN2SKDy73
         0N/D47LgToPOnCvM78qX3DJHM0cdEaBzQf/b+WFWZj4ZK6lQPkafFM0OyR+B0a54vwAY
         Vedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768002465; x=1768607265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TLD52LJJpgXkbHmHOmGMHJXgRsruMv9okey27w/iLfA=;
        b=mWLSSv/CzdgEzUs5zXzJ1l+R3jEq1yJSmbVUrDEndkOkXWsbpTyXeDeI1Sds6rUUnJ
         sSIt/EiOX5qwfw+i+5FWL6Box3lDBzNMYdk5jj5XCxFuJg0JJQ5rXoh/4szYyJlqZ5YD
         dbfEh6eCOrl192PA+GvEGfxpUsMGZByDrHvC9AW2W6veNZHH0x9VRal7ZhsRP1kxMHpG
         c58+x2RAsdKbbJxIxiUrwbTLdxXgE4RdyNMtM+3zICP+W9MYNmPy0FuWnIZhqZoqDJCK
         EGk208m2OEz7dyEQjRop+ZhBXf+e17OnS30b+FrQoWtZgrOQ10kcYm8EbQBCHZsWBfJW
         4lAA==
X-Forwarded-Encrypted: i=1; AJvYcCXg4ylSXyDhlLGysoxWtl67QTZdz2QjyyVOtYCcnUcTZ+VfCCjEon56EjQ3uV/PmUrMQUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrtF8ZXTcO/7AeNbKoRJEbVtceD2e5X3nwWLR7r6oB8/aEslUe
	7z7hBTK709qDv0r+XDQWQxx8TjbNSaeECT2Es8l1QpYvs+xJIx6blJWfCflZr4aLV7BQcWmwcL2
	0ho4preOdHJ3GDeC42mPMNL+w8469GU0=
X-Gm-Gg: AY/fxX64hZX4BXq6oeqDm+5fw+Lpl24xJ9Pp/FGsoyFxW1YhKrjeAmxzj6e4cLrSrSH
	AJ6V3hN5h7CMfaTs3rn5JvkZr6LKCA2a0k+A2mor4bwU9ORCUtYVAEaQgB0IHPIGABUBj0D38/m
	H0hECkrlvQceeCk6bI5WOu1y0GRqvidjESqMPCcKE19x7mr1VWzxouzGD/QPDa3vFxDH3pZtetU
	PUpV4qOS+ubgxsRrTuFJxchj3ebDy4UWrf6FzD7OIr9bOV0nE+AvwxhxV9Q4Jb+9sb+RDeoOYo0
	jngZhfKFXKKB24KHObw=
X-Google-Smtp-Source: AGHT+IFJmOmEq5ZJ5Ob58NZv80I9S0T5bbkH3sTY5dP35LUd9nVJtqcd258ZtmaQELz99GKrQ6IBs4xrZMe+LUmoh1g=
X-Received: by 2002:a17:90b:2e8f:b0:343:3898:e7c7 with SMTP id
 98e67ed59e1d1-34f68c010d0mr10254222a91.12.1768002464973; Fri, 09 Jan 2026
 15:47:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217093326.1745307-1-chen.dylane@linux.dev>
 <20251217093326.1745307-3-chen.dylane@linux.dev> <db97ccea-8cb4-40ea-b040-79f0f63a398e@linux.dev>
 <0e954e9a-12af-4f4f-95e2-7afedbd8f63f@linux.dev>
In-Reply-To: <0e954e9a-12af-4f4f-95e2-7afedbd8f63f@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 Jan 2026 15:47:32 -0800
X-Gm-Features: AQt7F2rFowr36ExP9mQOZTVNeDjdZr3kjVkP3CFzkP2LL6frIhP61S8ZnoVIQl4
Message-ID: <CAEf4BzZLCVMXFyfD9R0SUq_3Sinc_uFzJWnDcwZtdhJWpB3+uA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 2/2] bpf: Hold the perf callchain entry until
 used completely
To: Tao Chen <chen.dylane@linux.dev>, peterz@infradead.org
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	song@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 8:00=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> wro=
te:
>
> =E5=9C=A8 2025/12/23 14:29, Tao Chen =E5=86=99=E9=81=93:
> > =E5=9C=A8 2025/12/17 17:33, Tao Chen =E5=86=99=E9=81=93:
> >> As Alexei noted, get_perf_callchain() return values may be reused
> >> if a task is preempted after the BPF program enters migrate disable
> >> mode. The perf_callchain_entres has a small stack of entries, and
> >> we can reuse it as follows:
> >>
> >> 1. get the perf callchain entry
> >> 2. BPF use...
> >> 3. put the perf callchain entry
> >>
> >> And Peter suggested that get_recursion_context used with preemption
> >> disabled, so we should disable preemption at BPF side.
> >>
> >> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> >> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> >> ---
> >>   kernel/bpf/stackmap.c | 68 +++++++++++++++++++++++++++++++++++------=
--
> >>   1 file changed, 56 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> >> index da3d328f5c1..3bdd99a630d 100644
> >> --- a/kernel/bpf/stackmap.c
> >> +++ b/kernel/bpf/stackmap.c
> >> @@ -210,13 +210,14 @@ static void stack_map_get_build_id_offset(struct
> >> bpf_stack_build_id *id_offs,
> >>   }
> >>   static struct perf_callchain_entry *
> >> -get_callchain_entry_for_task(struct task_struct *task, u32 max_depth)
> >> +get_callchain_entry_for_task(int *rctx, struct task_struct *task, u32
> >> max_depth)
> >>   {
> >>   #ifdef CONFIG_STACKTRACE
> >>       struct perf_callchain_entry *entry;
> >> -    int rctx;
> >> -    entry =3D get_callchain_entry(&rctx);
> >> +    preempt_disable();
> >> +    entry =3D get_callchain_entry(rctx);
> >> +    preempt_enable();
> >>       if (!entry)
> >>           return NULL;
> >> @@ -238,8 +239,6 @@ get_callchain_entry_for_task(struct task_struct
> >> *task, u32 max_depth)
> >>               to[i] =3D (u64)(from[i]);
> >>       }
> >> -    put_callchain_entry(rctx);
> >> -
> >>       return entry;
> >>   #else /* CONFIG_STACKTRACE */
> >>       return NULL;
> >> @@ -320,6 +319,34 @@ static long __bpf_get_stackid(struct bpf_map *map=
,
> >>       return id;
> >>   }
> >> +static struct perf_callchain_entry *
> >> +bpf_get_perf_callchain(int *rctx, struct pt_regs *regs, bool kernel,
> >> bool user,
> >> +               int max_stack, bool crosstask)
> >> +{
> >> +    struct perf_callchain_entry_ctx ctx;
> >> +    struct perf_callchain_entry *entry;
> >> +
> >> +    preempt_disable();
> >> +    entry =3D get_callchain_entry(rctx);
> >> +    preempt_enable();
> >> +
> >> +    if (unlikely(!entry))
> >> +        return NULL;
> >> +
> >> +    __init_perf_callchain_ctx(&ctx, entry, max_stack, false);
> >> +    if (kernel)
> >> +        __get_perf_callchain_kernel(&ctx, regs);
> >> +    if (user && !crosstask)
> >> +        __get_perf_callchain_user(&ctx, regs, 0);
> >> +
> >> +    return entry;
> >> +}
> >> +
> >> +static void bpf_put_perf_callchain(int rctx)
> >> +{
> >> +    put_callchain_entry(rctx);
> >> +}
> >> +
> >>   BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map
> >> *, map,
> >>          u64, flags)
> >>   {
> >> @@ -328,20 +355,25 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *,
> >> regs, struct bpf_map *, map,
> >>       struct perf_callchain_entry *trace;
> >>       bool kernel =3D !user;
> >>       u32 max_depth;
> >> +    int rctx, ret;
> >>       if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK =
|
> >>                      BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID)))
> >>           return -EINVAL;
> >>       max_depth =3D stack_map_calculate_max_depth(map->value_size,
> >> elem_size, flags);
> >> -    trace =3D get_perf_callchain(regs, kernel, user, max_depth,
> >> -                   false, false, 0);
> >> +
> >> +    trace =3D bpf_get_perf_callchain(&rctx, regs, kernel, user, max_d=
epth,
> >> +                       false);
> >>       if (unlikely(!trace))
> >>           /* couldn't fetch the stack trace */
> >>           return -EFAULT;
> >> -    return __bpf_get_stackid(map, trace, flags);
> >> +    ret =3D __bpf_get_stackid(map, trace, flags);
> >> +    bpf_put_perf_callchain(rctx);
> >> +
> >> +    return ret;
> >>   }
> >>   const struct bpf_func_proto bpf_get_stackid_proto =3D {
> >> @@ -435,6 +467,7 @@ static long __bpf_get_stack(struct pt_regs *regs,
> >> struct task_struct *task,
> >>       bool kernel =3D !user;
> >>       int err =3D -EINVAL;
> >>       u64 *ips;
> >> +    int rctx;
> >>       if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK =
|
> >>                      BPF_F_USER_BUILD_ID)))
> >> @@ -467,18 +500,26 @@ static long __bpf_get_stack(struct pt_regs
> >> *regs, struct task_struct *task,
> >>           trace =3D trace_in;
> >>           trace->nr =3D min_t(u32, trace->nr, max_depth);
> >>       } else if (kernel && task) {
> >> -        trace =3D get_callchain_entry_for_task(task, max_depth);
> >> +        trace =3D get_callchain_entry_for_task(&rctx, task, max_depth=
);
> >>       } else {
> >> -        trace =3D get_perf_callchain(regs, kernel, user, max_depth,
> >> -                       crosstask, false, 0);
> >> +        trace =3D bpf_get_perf_callchain(&rctx, regs, kernel, user,
> >> max_depth,
> >> +                           crosstask);
> >>       }
> >> -    if (unlikely(!trace) || trace->nr < skip) {
> >> +    if (unlikely(!trace)) {
> >>           if (may_fault)
> >>               rcu_read_unlock();
> >>           goto err_fault;
> >>       }
> >> +    if (trace->nr < skip) {
> >> +        if (may_fault)
> >> +            rcu_read_unlock();
> >> +        if (!trace_in)
> >> +            bpf_put_perf_callchain(rctx);
> >> +        goto err_fault;
> >> +    }
> >> +
> >>       trace_nr =3D trace->nr - skip;
> >>       copy_len =3D trace_nr * elem_size;
> >> @@ -497,6 +538,9 @@ static long __bpf_get_stack(struct pt_regs *regs,
> >> struct task_struct *task,
> >>       if (may_fault)
> >>           rcu_read_unlock();
> >> +    if (!trace_in)
> >> +        bpf_put_perf_callchain(rctx);
> >> +
> >>       if (user_build_id)
> >>           stack_map_get_build_id_offset(buf, trace_nr, user, may_fault=
);
> >
> > Hi Peter,
> >
> > As Alexei said, the patch needs your ack, please review again, thanks.
> >
>
> ping...

Peter, if I understand correctly, this will go through bpf-next tree,
but it would be great if you could take a look and confirm this
overall is not broken. Thanks!

>
> --
> Best Regards
> Tao Chen

