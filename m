Return-Path: <bpf+bounces-14632-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF897E72FE
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 21:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B65D8281073
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 20:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C0930CE4;
	Thu,  9 Nov 2023 20:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="my5blm4a"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CEE225CA
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 20:39:32 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6D8E5
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 12:39:31 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9df8d0c2505so276283866b.0
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 12:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699562370; x=1700167170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYMQrZO0HBE8szHbo88acIVM8saUDmuGjptuYVU6RJg=;
        b=my5blm4a98hMwZrCeNCHmztbq4GoBM/WTBzykUbdVhFNPB+tJV42Ecwojq7xUuMsIc
         UjXHti+nCMwTK8KyWqzwofGRlQ/mqfuBd/tuEDgwZ+uvun9pIVmzB+1BZAf/oiNEyG4t
         flJHh4MFkK4+xkyAS/+hglItDIbhaGyRhVTqmGIYveJhPnCG5JsgYL+48tRMQ+cRiU1E
         seni9O9SG4j6rcO955QzRbVFT/tCdQQYHMmvVm5l9U7xjgm+uxUlfaXB4lJQaFgHSFwQ
         N8067grYYBCl2D0yIu28lihNrpN7VRT2q4SYDQLcYRTvLYlMj6INRhivlD1MM3mnxunI
         Shaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699562370; x=1700167170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qYMQrZO0HBE8szHbo88acIVM8saUDmuGjptuYVU6RJg=;
        b=fN94dtTlJTH6DQMyYDuR594s97FkUQZJbSnSdeDjR47wXeZzm/Ot9Q11iMHlwFDgZg
         ZIZCkPICbOkAPXMhrHM/+g4S23ofp8TIt0rPUiq4RlgwEzu/OIssRxGKshDEJbaSFm7P
         1Q0iHImKD3dB9WATyK8Y/v5iUiL+iuVMlrobMk6RvyWoHQKnjGIXmkDSwR+FzXymXN/f
         QGDnFYD6O6U2uu3TibrlM+hYaqklsytxd3XuIMMXmrs4kiMS6m00xi3o6LfM/OdyXYte
         QkpMjntvoHpq8m8nD5WtI2L93y7PE1AWqXDJlSubRbB4gOtufF0ThKlK3VheyV8KLFJR
         yJcg==
X-Gm-Message-State: AOJu0YyTasv1spvoRMLt8wpPl5ZbBLWyUo2KfRvtVNm4qGZSlnYPo9m8
	yl+qnrKEyZ9NhZoXCa6LTqz1JXiaed8u4rvo4bs=
X-Google-Smtp-Source: AGHT+IHEhPscpDdAC4auq8KLrsj3ql2EkaFnj5OE7Gux4p6pElo82I9EviWXvwjn+qDVfM63QOlqYF3rNFZBx049sk0=
X-Received: by 2002:a17:906:a3c9:b0:9c7:6523:407b with SMTP id
 ca9-20020a170906a3c900b009c76523407bmr358359ejb.17.1699562369789; Thu, 09 Nov
 2023 12:39:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031050324.1107444-1-andrii@kernel.org> <20231031050324.1107444-2-andrii@kernel.org>
 <43f0d9f7219b74bfaff14b6496902f1056847de7.camel@gmail.com>
 <CAADnVQL6_o9z3z1=8o7qGNzAD8vKMZ+OetcYYy-1huxGfCJToA@mail.gmail.com>
 <CAEf4BzaA12xjXm8KZNB1mkVDOTtVDQDDWF4nYQtQ2qRYoTip3A@mail.gmail.com>
 <CAADnVQLGn4vRuZLqTm_t_9ff3t=Hsugr0j47YLThhPsnpNrs_Q@mail.gmail.com> <CAEf4BzY72H_0fF4C1kGbX5_ymNu6NHYf55HAnU8i5dnaQ+f_vA@mail.gmail.com>
In-Reply-To: <CAEf4BzY72H_0fF4C1kGbX5_ymNu6NHYf55HAnU8i5dnaQ+f_vA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 9 Nov 2023 12:39:18 -0800
Message-ID: <CAEf4BzYn83g6TSwWcqqdcJBPB74kRs5iX73J9Vdrt7fT6VstdA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/7] bpf: use common jump (instruction) history
 across all states
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 11:49=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Nov 9, 2023 at 11:29=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Nov 9, 2023 at 9:28=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > >
> > > If we ever break DFS property, we can easily change this. Or we can
> > > even have a hybrid: as long as traversal preserves DFS property, we
> > > use global shared history, but we can also optionally clone and have
> > > our own history if necessary. It's a matter of adding optional
> > > potentially NULL pointer to "local history". All this is very nicely
> > > hidden away from "normal" code.
> >
> > If we can "easily change this" then let's make it last and optional pat=
ch.
> > So we can revert in the future when we need to take non-DFS path.
>
> Ok, sounds good. I'll reorder and put it last, you can decide whether
> to apply it or not that way.
>
> >
> > > But again, let's look at data first. I'll get back with numbers soon.
> >
> > Sure. I think memory increase due to more tracking is ok.
> > I suspect it won't cause 2x increase. Likely few %.
> > The last time I checked the main memory hog is states stashed for pruni=
ng.
>
> So I'm back with data. See verifier.c changes I did at the bottom,
> just to double check I'm not missing something major. I count the
> number of allocations (but that's an underestimate that doesn't take
> into account realloc), total number of instruction history entries for
> entire program verification, and then also peak "depth" of instruction
> history. Note that entries should be multiplied by 8 to get the amount
> of bytes (and that's not counting per-allocation overhead).
>
> Here are top 20 results, sorted by number of allocs for Meta-internal,
> Cilium, and selftests. BEFORE is without added STACK_ACCESS tracking
> and STACK_ZERO optimization. AFTER is with all the patches of this
> patch set applied.
>
> It's a few megabytes of memory allocation, which in itself is probably
> not a big deal. But it's just an amount of unnecessary memory
> allocations which is basically at least 2x of the total number of
> states that we can save. And instead have just a few reallocs to size
> global jump history to an order of magnitudes smaller peak entries.
>
> And if we ever decide to track more stuff similar to
> INSNS_F_STACK_ACCESS, we won't have to worry about more allocations or
> more memory usage, because the absolute worst case is our global
> history will be up to 1 million entries tops. We can track some *code
> path dependent* per-instruction information for *each simulated
> instruction* easily without having to think twice about this. Which I
> think is a nice liberating thought in itself justifying this change.
>
>

Gmail butchered tables. See Github gist ([0]) for it properly formatted.

  [0] https://gist.github.com/anakryiko/04c5a3a5ae4ee672bd11d4b7b3d832f5

>
> Stats counting diff:
>
> $ git show -- kernel
> commit febebc9586c08820fa927b1628454b2709e98e3f (HEAD)
> Author: Andrii Nakryiko <andrii@kernel.org>
> Date:   Thu Nov 9 11:02:40 2023 -0800
>
>     [EXPERIMENT] bpf: add jump/insns history stats
>
>     Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b688043e5460..d0f25f36221e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2026,6 +2026,10 @@ static int pop_stack(struct bpf_verifier_env
> *env, int *prev_insn_idx,
>                 return -ENOENT;
>
>         if (cur) {
> +               env->jmp_hist_peak =3D max(env->jmp_hist_peak,
> cur->insn_hist_end);
> +               env->jmp_hist_total +=3D cur->insn_hist_end -
> cur->insn_hist_start;
> +               env->jmp_hist_allocs +=3D 1;
> +
>                 err =3D copy_verifier_state(cur, &head->st);
>                 if (err)
>                         return err;
> @@ -3648,6 +3653,8 @@ static int push_jmp_history(struct bpf_verifier_env=
 *env,
>         p->idx =3D env->insn_idx;
>         p->prev_idx =3D env->prev_insn_idx;
>         cur->insn_hist_end++;
> +
> +       env->jmp_hist_peak =3D max(env->jmp_hist_peak, cur->insn_hist_end=
);
>         return 0;
>  }
>
> @@ -17205,6 +17212,9 @@ static int is_state_visited(struct
> bpf_verifier_env *env, int insn_idx)
>         WARN_ONCE(new->branches !=3D 1,
>                   "BUG is_state_visited:branches_to_explore=3D%d insn
> %d\n", new->branches, insn_idx);
>
> +       env->jmp_hist_total +=3D cur->insn_hist_end - cur->insn_hist_star=
t;
> +       env->jmp_hist_allocs +=3D 1;
> +
>         cur->parent =3D new;
>         cur->first_insn_idx =3D insn_idx;
>         cur->insn_hist_start =3D cur->insn_hist_end;
> @@ -20170,10 +20180,12 @@ static void print_verification_stats(struct
> bpf_verifier_env *env)
>                 verbose(env, "\n");
>         }
>         verbose(env, "processed %d insns (limit %d) max_states_per_insn %=
d "
> -               "total_states %d peak_states %d mark_read %d\n",
> +               "total_states %d peak_states %d mark_read %d "
> +               "jmp_allocs %d jmp_total %d jmp_peak %d\n",
>                 env->insn_processed, BPF_COMPLEXITY_LIMIT_INSNS,
>                 env->max_states_per_insn, env->total_states,
> -               env->peak_states, env->longest_mark_read_walk);
> +               env->peak_states, env->longest_mark_read_walk,
> +               env->jmp_hist_allocs, env->jmp_hist_total, env->jmp_hist_=
peak);
>  }

