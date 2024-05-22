Return-Path: <bpf+bounces-30315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C468CC591
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 19:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BA311F22911
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 17:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055A01422B6;
	Wed, 22 May 2024 17:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUsXbAn4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDDF76048
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716399231; cv=none; b=tPyisrc4ideCznNe1l+TMnw4XIG/vO6rAQei3VV2V6bi2CSoLkI9h8+97dxKLRQWBtcs4mdFWKi0O9LLeTvmFK2q77EV2jEIM/pmVQIlNXP2KGfsoRMGNEgmYbdznDOktRmIvBpM0RgfakDaG/WW3992T0yn5/Elv+uIgeXdH7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716399231; c=relaxed/simple;
	bh=Xkma6qKWzXr9pBKAYY7gfwbomIFHP0ZJkJnKmA7bK9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QAskkWWmN1iu10VxSW9+UrtFOz7bp2nqt+NMY07RrIvVTVPQLQL7i120SAMIwDCr0pzm+qDc68S/h+NJihlBmpjOK7dSsK7oLz+iVsjXVhmzwSebDx3WSZ7TXaywMc1610V/+rwu3m/hS6zawZFYoo/+s6wMK7lNb8SwQjWoYV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUsXbAn4; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so2415103a12.1
        for <bpf@vger.kernel.org>; Wed, 22 May 2024 10:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716399229; x=1717004029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ct6+wB54jhc2iyTd2a6sxqvVClIIwykE5awV2ALmN78=;
        b=hUsXbAn4qbzXeL8wQDIBystaSUHRQVCG1/yMFaliS3ZyO6btFeU0Eh0eke3+v+cX9m
         +cigr7JkWkVo1sC/YcOLNw5xlGm/SdITL1umEtx7uBq0D+kaFkUnqL1PpvMUDze91VSN
         g15TCx13GwSdqJ3t9VqzTX44WGNk9nXxxh6YtTiO2uGB0MfkODmGnmXdckXAbiywF/zB
         mPU5ithYxffxWCrd1vXfn1PRl2qJ/fXCKOZycni2Chl0dZnjUKoFP18PwyB1YOtYk6XZ
         eblBJkkox96aK/hkzNDPJ4q+K9bjJS0S2Xp5T0em2rLfW06t4yJNzLzP32vNTtvNrS9j
         a9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716399229; x=1717004029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ct6+wB54jhc2iyTd2a6sxqvVClIIwykE5awV2ALmN78=;
        b=MeiHiU3S1Jt6egL8uziDj/fFJz7vQEZBjj51M6rY/yoMYwV8lYdyqauO28N44bY1rX
         S73h4W9hsDTn3Y/yw+8M7uSGEZgVME7LnR4ewl0FtEnfGbwJwIXY+W2bKVtW5MRkrsAj
         a9UDDX4LdDUlvc+gfTZF5SNgiQIE5zXs3YXw8Cm8yVAgyz7p4wX+nlw0SXUhHbjEdc2E
         gU87Ij6J8Odj8/7RnbZSFZx/0VnMqmco6LOrYw7rJeK/StBvdeB5GOMFN9+8UWrn4G8b
         Fid7SKBz8F+YX7fsqgSxjcRNYyvDgsVZOzXrJwrGA+J2fH/Y1DUP/f/pgUY6N8Y/72mU
         lQfw==
X-Gm-Message-State: AOJu0YwOM4qZskyxZk9hWW+bsxq/qUjGfdS0BeLCyCwg16Jn63PQefiJ
	JA9tjAgRAqG0AYkN0ZB0z3C6YEZYwOmDxAeD8qXWSYOXnR6+Zg7p2kOlGnWlgbXOAcdXerQwD9y
	/AqQcg51yVWzy6KRRr77rjXSIh/o=
X-Google-Smtp-Source: AGHT+IEXQDi29I5LeFJcpo5yygne9lc/dTo66x2Nm6BEnnBtcYuZv2/F3OJlAnd+EVuGeD6zv4QzBUX9TvDcSRRPyHU=
X-Received: by 2002:a17:90a:d450:b0:2a2:b097:dabc with SMTP id
 98e67ed59e1d1-2bd9f5a0ad4mr3664960a91.31.1716399229324; Wed, 22 May 2024
 10:33:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522024713.59136-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20240522024713.59136-1-alexei.starovoitov@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 22 May 2024 10:33:37 -0700
Message-ID: <CAEf4BzaJyju+0r=PnaJyv4zYnUbiAfxtXk5oQqPrVGqN4F++fQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Relax precision marking in open coded iters
 and may_goto loop.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, eddyz87@gmail.com
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, memxor@gmail.com, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 7:47=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Motivation for the patch
> ------------------------
> Open coded iterators and may_goto is a great mechanism to implement loops=
,
> but counted loops are problematic. For example:
>   for (i =3D 0; i < 100 && can_loop; i++)
> is verified as a bounded loop, since i < 100 condition forces the verifie=
r
> to mark 'i' as precise and loop states at different iterations are not eq=
uivalent.
> That removes the benefit of open coded iterators and may_goto.
> The workaround is to do:
>   int zero =3D 0; /* global or volatile variable */
>   for (i =3D zero; i < 100 && can_loop; i++)
> to hide from the verifier the value of 'i'.
> It's unnatural and so far users didn't learn such odd programming pattern=
.
>
> This patch aims to improve the verifier to support
>   for (i =3D 0; i < 100000 && can_loop; i++)
> as open coded iter loop (when 'i' doesn't need to be precise).
>
> Algorithm
> ---------
> First of all:
>    if (is_may_goto_insn_at(env, insn_idx)) {
> +          update_loop_entry(cur, &sl->state);
>            if (states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
> -                  update_loop_entry(cur, &sl->state);
>
> This should be correct, since reaching the same insn should
> satisfy "if h1 in path" requirement of update_loop_entry() algorithm.
> It's too conservative to update loop_entry only on a state match.
>
> With that the get_loop_entry() can be used to gate is_branch_taken() logi=
c.
> When 'if (i < 1000)' is done within open coded iterator or in a loop with=
 may_goto
> don't invoke is_branch_taken() logic.
> When it's skipped don't do reg_bounds_sanity_check(), since it will surel=
y
> see range violations.
>
> Now, consider progs/iters_task_vma.c that has the following logic:
>     bpf_for_each(...) {
>        if (i > 1000)

I'm wondering, maybe we should change rules around handling inequality
(>, >=3D, <, <=3D) comparisons for register(s) that have a constant value
(or maybe actually any value).

My reasoning is the following. When we have something like this `if (i
> 1000)` condition, that means that for fallthrough branch whether i
is 0, or 1, or 2, or whatever doesn't really matter, because the code
presumably works for any value in [0, 999] range, right? So maybe in
addition to marking it precise and keeping i's range estimate the
same, we should extend this range according to inequality condition?

That is, even if we know on first iteration that i is 0 (!precise),
when we simulate this conditional jump instruction, adjust i's range
to be [0, 999] (precise) in the fallthrough branch, and [1000,
U64_MAX] in the true branch?

I.e., make conditional jumps into "range widening" instructions?

Have you thought about this approach? Do you think it will work in
practice? I'm sure it can't be as simple, but still, worth
considering. Curious also to hear Eduard's opinion as well, he's dealt
with this a lot in the past.

>           break;
>
>        arr[i] =3D ..;
>     }
>
> Skipping precision mark at if (i > 1000) keeps 'i' imprecise,
> but arr[i] will mark 'i' as precise anyway, because 'arr' is a map.
> On the next iteration of the loop the patch does copy_precision()
> that copies precision markings for top of the loop into next state
> of the loop. So on the next iteration 'i' will be seen as precise.
>
> Hence the key part of the patch:
> -       pred =3D is_branch_taken(dst_reg, src_reg, opcode, is_jmp32);
> +       if (!get_loop_entry(this_branch) || src_reg->precise || dst_reg->=
precise ||
> +           (BPF_SRC(insn->code) =3D=3D BPF_K && insn->imm =3D=3D 0))
> +               pred =3D is_branch_taken(dst_reg, src_reg, opcode, is_jmp=
32);
>
> !get_loop_entry(this_branch) -> if not inside open coded iter keep
>   existing is_branch_taken() logic, since bounded loop relies on it.
>
> src_reg->precise || dst_reg->precise -> if later inside the loop the 'i' =
was
>   actually marked as precise then we have to do is_branch_taken() and abo=
ve
>   bpf_for_each() will be verified as a bounded loop checking all 1000
>   iterations. Otherwise we will keep incrementing 'i' and it will eventua=
lly
>   get out of bounds in arr[i] and the verifier will reject such memory ac=
cess.
>
> BPF_SRC(insn->code) =3D=3D BPF_K && insn->imm =3D=3D 0 -> if it's a check=
 for
>   an exit condition from open coded iterator then do is_branch_taken() as=
 well.
>   Otherwise all open coded iterators won't work.
>
> Now consider the same example:
>     bpf_for_each(...) {
>        if (i > 1000)
>           break;
>
>        arr[i] =3D ..;
>     }
> but 'arr' is an arena pointer. In this case 'i > 1000' will keep 'i' as
> imprecise and arr[i] will keep it as imprecise as well.
> And the whole loop will be verified with open coded iterator logic.
>
> Now the following works:
> -       for (i =3D zero; i < 1000; i++)
> +       for (i =3D 0; i < 100000 && can_loop; i++) {
>                 htab_update_elem(htab, i, i);
> +               arr[i] =3D i; // either arr1 or arr2
> +       }
> +char __arena arr1[100000]; /* works */
> +char arr2[100000]; /* runs into 1M limit */
>
> So the users can now use 'for (i =3D 0;...' pattern everywhere and
> the verifier will fall back to bounded loop logic and precise 'i'
> when 'i' is used in map-style memory access.
> For arena based algorithms 'i' will stay imprecise.
>
> -       for (i =3D zero; i < ARR_SZ && can_loop; i++)
> +       /* i =3D 0 is ok here, since i is not used in memory access */
> +       for (i =3D 0; i < ARR_SZ && can_loop; i++)
>                 sum +=3D i;
> +
> +       /* have to use i =3D zero due to arr[i] where arr is not an arena=
 */
>         for (i =3D zero; i < ARR_SZ; i++) {
>                 barrier_var(i);
>                 sum +=3D i + arr[i];
>
> and i =3D zero workaround in iter_obfuscate_counter() can be removed.
>
> copy_precision() is a hack, of course, to demonstrate an idea.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

There is a lot to think about here, I'll try to get to this
today/tomorrow. But for now veristat is concerned about this change
([0]):

|File                              |Program
|Verdict                |States Diff (%)|
|----------------------------------|---------------------------------|-----=
------------------|---------------|
|arena_htab_asm.bpf.o              |arena_htab_asm
|success                |-80.91 %       |
|core_kern.bpf.o                   |balancer_ingress
|success -> failure (!!)|+0.00 %        |
|dynptr_success.bpf.o              |test_read_write
|success -> failure (!!)|+0.00 %        |
|iters.bpf.o                       |checkpoint_states_deletion
|success -> failure (!!)|+0.00 %        |
|iters.bpf.o                       |iter_multiple_sequential_loops
|success                |-11.43 %       |
|iters.bpf.o                       |iter_obfuscate_counter
|success                |+30.00 %       |
|iters.bpf.o                       |iter_pragma_unroll_loop
|success                |-23.08 %       |
|iters.bpf.o                       |iter_subprog_iters
|success                |+1.14 %        |
|iters.bpf.o                       |loop_state_deps1
|failure                |+7.14 %        |
|iters.bpf.o                       |loop_state_deps2
|failure                |-2.17 %        |
|iters_task_vma.bpf.o              |iter_task_vma_for_each
|success -> failure (!!)|+99.20 %       |
|linked_list.bpf.o                 |global_list_push_pop_multiple
|success -> failure (!!)|+0.00 %        |
|linked_list.bpf.o                 |inner_map_list_push_pop_multiple
|success -> failure (!!)|+0.00 %        |
|linked_list.bpf.o                 |map_list_push_pop_multiple
|success -> failure (!!)|+0.00 %        |
|test_seg6_loop.bpf.o              |__add_egr_x
|success -> failure (!!)|+0.00 %        |
|test_sysctl_loop1.bpf.o           |sysctl_tcp_mem
|success -> failure (!!)|+0.00 %        |
|test_sysctl_loop2.bpf.o           |sysctl_tcp_mem
|success -> failure (!!)|+0.00 %        |
|test_verif_scale2.bpf.o           |balancer_ingress
|success -> failure (!!)|+0.00 %        |
|verifier_bounds.bpf.o             |bound_greater_than_u32_max
|success -> failure (!!)|+0.00 %        |
|verifier_bounds.bpf.o
|crossing_32_bit_signed_boundary_2|success -> failure (!!)|+0.00 %
   |
|verifier_bounds.bpf.o
|crossing_64_bit_signed_boundary_2|success -> failure (!!)|+0.00 %
   |
|verifier_iterating_callbacks.bpf.o|cond_break2
|success                |+75.00 %       |
|verifier_iterating_callbacks.bpf.o|cond_break3
|success                |+66.67 %       |
|verifier_iterating_callbacks.bpf.o|cond_break4
|success                |+300.00 %      |
|verifier_iterating_callbacks.bpf.o|cond_break5
|success                |+266.67 %      |

  [0] https://github.com/kernel-patches/bpf/actions/runs/9184700207/job/252=
57587541

>  kernel/bpf/verifier.c                         | 94 +++++++++++++++++--
>  .../testing/selftests/bpf/progs/arena_htab.c  | 11 ++-
>  tools/testing/selftests/bpf/progs/iters.c     | 18 +---
>  .../bpf/progs/verifier_iterating_callbacks.c  | 17 ++--
>  4 files changed, 112 insertions(+), 28 deletions(-)
>

[...]

