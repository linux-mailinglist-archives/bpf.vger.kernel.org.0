Return-Path: <bpf+bounces-30329-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC0A8CC7FC
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 23:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25E7B1F22102
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 21:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F777146001;
	Wed, 22 May 2024 21:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bV3/7eeg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE29E57CA6
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 21:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716412192; cv=none; b=ZCMZF+zCeqipw8dNEnkq3MI3PGEEmMgX3ET4BqwsC3oTcMkeb1uycE6dwVJapUaxR6g9xe945DnTbqO8Sa1+4tD+0TwhvFDUKxlC1T5hB2gJt2DfaqMddO3RBexzLHQjfI+Pfk1WfLSmMMOdFuLspToV7UF4spQFKaTjuPAe27I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716412192; c=relaxed/simple;
	bh=dxDSehBc5ykVC+YA7WNTHBbn8vXh8QWVPoMBmoJkWgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oFXbw/pNF6TxE01Bm5UwJak9ZZ9yvVhS+LatxQhkc7vsAA05u3Z+IBZ7v5T5zo2U3JyefhU+i8+12wFi4pWlYRXmtJc7ehjwRGoo50VePSDuGHIexzcm3qUjknOGPJB2PBW+W3kLAELEZmMGLFL2svVzqG+bfogOxsxBo5YBKok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bV3/7eeg; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4202cea9941so45838995e9.1
        for <bpf@vger.kernel.org>; Wed, 22 May 2024 14:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716412189; x=1717016989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFr8A+oVm+APUfpbfZX87Jm3oo2ykNLeUV4tC8ZavNs=;
        b=bV3/7eegGJ7Fr1OnUEIl9elAbbQJnonDPG/nIwVpWMTrLaNb5NsKIa9cHBWIMI6E6T
         8qiBUkRWsqamjDZ6N/WCX/QT6Ug9m1umtoOteRomjSC/Kc4eRIdefst78u8AHErFqW9j
         f/xc9r/yAT04m+Tc0+4b4TeordpvQpi9e6wjq5T6RVRHRhOr4IXJo1uQHvw9hQ7Lkb8h
         1A0ItQdpaI2iWc3DHMHXLgfQRIUXOLpUlJjTeUybnrw7JiO4eBWsizJZDuwNme5Xvzfy
         rK31LJlQKRDNeOLev6RITWGtFe4h6BO0nfzK04d3cqAJl7Lad80QK6PwiAFUN3YpxZkH
         r27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716412189; x=1717016989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QFr8A+oVm+APUfpbfZX87Jm3oo2ykNLeUV4tC8ZavNs=;
        b=ossPis5sOHpY0WpB6lXgBjnQII4z/RPyhf3kAinY+mDCXOofuh5sIbdOKzIFrlz32w
         B2qI1VIBLmujnE+48ynaiupjcmyUcV/ig3MGoap1CUCJhyAJTRq81truAlKiCy6F5JsA
         Lceu25kKMktNv2l85H+HeRX0mKLNDNCaijahDCSOMiPwLHHNUgimm3Yj0IW2UZxl+6QZ
         uja4cMrpNqNMkcnvGhu3v7AUlTE0zO9wERhw7Bs0iCNNlg7aHjD/scwPSzdssEnG0UIL
         /x+aC05ymjvRbPYjE0GxmTOrKTt5ulJ3l9RdlFADIiT8LdBbKd9KTwlj8lNxdmZBnBrt
         bASA==
X-Forwarded-Encrypted: i=1; AJvYcCXQ+AOj4Gve50d0D2pdP/j68Ni7E6C3JwGeLKUu7g1hTULoTeT75cERDJR+HjXuov5EUGHnH2RGjV+LzIJeNY+yoB2+
X-Gm-Message-State: AOJu0YwGi14qgDszRGLTKj2aa7w1I+ejzFGvbqi+r8KPqX7BX9ex6mWu
	a7hmi8gmwwf6n49bLo+P7Gy6/8EIlKbT8PwBtlGUrxL7Jt9dOFqYsE02Cr7wlVSzu+exzCvmPJh
	xSV6PVQbvyBIDFcJgmxlYCX11idI=
X-Google-Smtp-Source: AGHT+IHt+PdMeKj5zzn7U9LwMKm/3sf/sh1SBxa+slY/gyAKDZiZUT03I11SJmy6Z/82Hq5u1Ldc5dhWByUUGb+gSp0=
X-Received: by 2002:a05:6000:1d1:b0:351:c934:e9e6 with SMTP id
 ffacd0b85a97d-354d8dac66dmr2043573f8f.64.1716412188516; Wed, 22 May 2024
 14:09:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522024713.59136-1-alexei.starovoitov@gmail.com> <CAEf4BzaJyju+0r=PnaJyv4zYnUbiAfxtXk5oQqPrVGqN4F++fQ@mail.gmail.com>
In-Reply-To: <CAEf4BzaJyju+0r=PnaJyv4zYnUbiAfxtXk5oQqPrVGqN4F++fQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 22 May 2024 14:09:37 -0700
Message-ID: <CAADnVQLj3vHKNJqdrG=WwbRk2A+DCi+2tGyxj7XeSTqzJ1T=pw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Relax precision marking in open coded iters
 and may_goto loop.
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eddy Z <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 10:33=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, May 21, 2024 at 7:47=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Motivation for the patch
> > ------------------------
> > Open coded iterators and may_goto is a great mechanism to implement loo=
ps,
> > but counted loops are problematic. For example:
> >   for (i =3D 0; i < 100 && can_loop; i++)
> > is verified as a bounded loop, since i < 100 condition forces the verif=
ier
> > to mark 'i' as precise and loop states at different iterations are not =
equivalent.
> > That removes the benefit of open coded iterators and may_goto.
> > The workaround is to do:
> >   int zero =3D 0; /* global or volatile variable */
> >   for (i =3D zero; i < 100 && can_loop; i++)
> > to hide from the verifier the value of 'i'.
> > It's unnatural and so far users didn't learn such odd programming patte=
rn.
> >
> > This patch aims to improve the verifier to support
> >   for (i =3D 0; i < 100000 && can_loop; i++)
> > as open coded iter loop (when 'i' doesn't need to be precise).
> >
> > Algorithm
> > ---------
> > First of all:
> >    if (is_may_goto_insn_at(env, insn_idx)) {
> > +          update_loop_entry(cur, &sl->state);
> >            if (states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
> > -                  update_loop_entry(cur, &sl->state);
> >
> > This should be correct, since reaching the same insn should
> > satisfy "if h1 in path" requirement of update_loop_entry() algorithm.
> > It's too conservative to update loop_entry only on a state match.
> >
> > With that the get_loop_entry() can be used to gate is_branch_taken() lo=
gic.
> > When 'if (i < 1000)' is done within open coded iterator or in a loop wi=
th may_goto
> > don't invoke is_branch_taken() logic.
> > When it's skipped don't do reg_bounds_sanity_check(), since it will sur=
ely
> > see range violations.
> >
> > Now, consider progs/iters_task_vma.c that has the following logic:
> >     bpf_for_each(...) {
> >        if (i > 1000)
>
> I'm wondering, maybe we should change rules around handling inequality
> (>, >=3D, <, <=3D) comparisons for register(s) that have a constant value
> (or maybe actually any value).
>
> My reasoning is the following. When we have something like this `if (i
> > 1000)` condition, that means that for fallthrough branch whether i
> is 0, or 1, or 2, or whatever doesn't really matter, because the code
> presumably works for any value in [0, 999] range, right? So maybe in
> addition to marking it precise and keeping i's range estimate the
> same, we should extend this range according to inequality condition?
>
> That is, even if we know on first iteration that i is 0 (!precise),
> when we simulate this conditional jump instruction, adjust i's range
> to be [0, 999] (precise) in the fallthrough branch, and [1000,
> U64_MAX] in the true branch?
>
> I.e., make conditional jumps into "range widening" instructions?
>
> Have you thought about this approach? Do you think it will work in
> practice? I'm sure it can't be as simple, but still, worth
> considering. Curious also to hear Eduard's opinion as well, he's dealt
> with this a lot in the past.

I looked into doing exactly that [0, 999] and [1000, max],
then on the next iteration i+=3D1 insn will adjust it to
[1, 1000], but the next i < 1000 will widen it back to
[0, 999] and the state equivalence will be happy.
But my excitement was short lived, since both gcc and llvm
optimize the loop exit condition to !=3D
and they do it in the middle end.
Backends cannot influence this optimization.
I don't think it's practical to undo it in the backend.
So most of the loops written as:
for (i =3D 0; i < 1000; i++)
are compiled as
for (i =3D 0; i !=3D 1000; i++)
for x86, arm, bpf, etc.

so if there is arr[i] inside the loop the verifier
have to rely on bounded loop logic and check i=3D0, 1, 2, ... 999
one by one, since nothing else inside the loop
makes the array index bounded.

Another small obstacle is that we don't have [!=3Dconst] range,
so i !=3D 100 cannot be widened into [100] and [!=3D100].
We can add that without too much trouble.
But it won't help this arr[i] case anyway.

We can make i !=3D 100 to be [unknown] and [unknown].
It's bad for arr[i] too, but fine when arr is an arena pointer.
Unfortunately at the time of the 'if' we don't know what comes later.
If the verifier knew that it's only dealing with arena pointers
it could disable precision altogether.

So I went with conditional disable of is_branch_taken + mark_precise and
surprisingly it didn't break any tests.

>
> >           break;
> >
> >        arr[i] =3D ..;
> >     }
> >
> > Skipping precision mark at if (i > 1000) keeps 'i' imprecise,
> > but arr[i] will mark 'i' as precise anyway, because 'arr' is a map.
> > On the next iteration of the loop the patch does copy_precision()
> > that copies precision markings for top of the loop into next state
> > of the loop. So on the next iteration 'i' will be seen as precise.
> >
> > Hence the key part of the patch:
> > -       pred =3D is_branch_taken(dst_reg, src_reg, opcode, is_jmp32);
> > +       if (!get_loop_entry(this_branch) || src_reg->precise || dst_reg=
->precise ||
> > +           (BPF_SRC(insn->code) =3D=3D BPF_K && insn->imm =3D=3D 0))
> > +               pred =3D is_branch_taken(dst_reg, src_reg, opcode, is_j=
mp32);
> >
> > !get_loop_entry(this_branch) -> if not inside open coded iter keep
> >   existing is_branch_taken() logic, since bounded loop relies on it.
> >
> > src_reg->precise || dst_reg->precise -> if later inside the loop the 'i=
' was
> >   actually marked as precise then we have to do is_branch_taken() and a=
bove
> >   bpf_for_each() will be verified as a bounded loop checking all 1000
> >   iterations. Otherwise we will keep incrementing 'i' and it will event=
ually
> >   get out of bounds in arr[i] and the verifier will reject such memory =
access.
> >
> > BPF_SRC(insn->code) =3D=3D BPF_K && insn->imm =3D=3D 0 -> if it's a che=
ck for
> >   an exit condition from open coded iterator then do is_branch_taken() =
as well.
> >   Otherwise all open coded iterators won't work.
> >
> > Now consider the same example:
> >     bpf_for_each(...) {
> >        if (i > 1000)
> >           break;
> >
> >        arr[i] =3D ..;
> >     }
> > but 'arr' is an arena pointer. In this case 'i > 1000' will keep 'i' as
> > imprecise and arr[i] will keep it as imprecise as well.
> > And the whole loop will be verified with open coded iterator logic.
> >
> > Now the following works:
> > -       for (i =3D zero; i < 1000; i++)
> > +       for (i =3D 0; i < 100000 && can_loop; i++) {
> >                 htab_update_elem(htab, i, i);
> > +               arr[i] =3D i; // either arr1 or arr2
> > +       }
> > +char __arena arr1[100000]; /* works */
> > +char arr2[100000]; /* runs into 1M limit */
> >
> > So the users can now use 'for (i =3D 0;...' pattern everywhere and
> > the verifier will fall back to bounded loop logic and precise 'i'
> > when 'i' is used in map-style memory access.
> > For arena based algorithms 'i' will stay imprecise.
> >
> > -       for (i =3D zero; i < ARR_SZ && can_loop; i++)
> > +       /* i =3D 0 is ok here, since i is not used in memory access */
> > +       for (i =3D 0; i < ARR_SZ && can_loop; i++)
> >                 sum +=3D i;
> > +
> > +       /* have to use i =3D zero due to arr[i] where arr is not an are=
na */
> >         for (i =3D zero; i < ARR_SZ; i++) {
> >                 barrier_var(i);
> >                 sum +=3D i + arr[i];
> >
> > and i =3D zero workaround in iter_obfuscate_counter() can be removed.
> >

...

> > copy_precision() is a hack, of course, to demonstrate an idea.

btw I think I know of a better way of doing copy_precision().
So don't pay much attention to it.

> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
>
> There is a lot to think about here, I'll try to get to this
> today/tomorrow. But for now veristat is concerned about this change
> ([0]):
>
> |File                              |Program
> |Verdict                |States Diff (%)|
> |----------------------------------|---------------------------------|---=
--------------------|---------------|
> |arena_htab_asm.bpf.o              |arena_htab_asm
> |success                |-80.91 %       |
> |core_kern.bpf.o                   |balancer_ingress
> |success -> failure (!!)|+0.00 %        |
> |dynptr_success.bpf.o              |test_read_write
> |success -> failure (!!)|+0.00 %        |
> |iters.bpf.o                       |checkpoint_states_deletion
> |success -> failure (!!)|+0.00 %        |
> |iters.bpf.o                       |iter_multiple_sequential_loops
> |success                |-11.43 %       |
> |iters.bpf.o                       |iter_obfuscate_counter
> |success                |+30.00 %       |
> |iters.bpf.o                       |iter_pragma_unroll_loop
> |success                |-23.08 %       |
> |iters.bpf.o                       |iter_subprog_iters
> |success                |+1.14 %        |
> |iters.bpf.o                       |loop_state_deps1
> |failure                |+7.14 %        |
> |iters.bpf.o                       |loop_state_deps2
> |failure                |-2.17 %        |
> |iters_task_vma.bpf.o              |iter_task_vma_for_each
> |success -> failure (!!)|+99.20 %       |
> |linked_list.bpf.o                 |global_list_push_pop_multiple
> |success -> failure (!!)|+0.00 %        |
> |linked_list.bpf.o                 |inner_map_list_push_pop_multiple
> |success -> failure (!!)|+0.00 %        |
> |linked_list.bpf.o                 |map_list_push_pop_multiple
> |success -> failure (!!)|+0.00 %        |
> |test_seg6_loop.bpf.o              |__add_egr_x
> |success -> failure (!!)|+0.00 %        |
> |test_sysctl_loop1.bpf.o           |sysctl_tcp_mem
> |success -> failure (!!)|+0.00 %        |
> |test_sysctl_loop2.bpf.o           |sysctl_tcp_mem
> |success -> failure (!!)|+0.00 %        |
> |test_verif_scale2.bpf.o           |balancer_ingress
> |success -> failure (!!)|+0.00 %        |
> |verifier_bounds.bpf.o             |bound_greater_than_u32_max
> |success -> failure (!!)|+0.00 %        |
> |verifier_bounds.bpf.o

That was due to veristat being picky ;)
Extra verbose() in the verifier not gated by log_level
didn't fit in 64k veristat log buffer and ENOSPC turned into failure.

> |crossing_32_bit_signed_boundary_2|success -> failure (!!)|+0.00 %
>    |
> |verifier_bounds.bpf.o
> |crossing_64_bit_signed_boundary_2|success -> failure (!!)|+0.00 %
>    |
> |verifier_iterating_callbacks.bpf.o|cond_break2
> |success                |+75.00 %       |
> |verifier_iterating_callbacks.bpf.o|cond_break3
> |success                |+66.67 %       |
> |verifier_iterating_callbacks.bpf.o|cond_break4
> |success                |+300.00 %      |
> |verifier_iterating_callbacks.bpf.o|cond_break5
> |success                |+266.67 %      |

This is expected, since the tests changed.
In this case 300% regression is from 1 state to 3 states,
and from 10 to 21 states, ...
We should probably print absolute state values in veristat CI.

