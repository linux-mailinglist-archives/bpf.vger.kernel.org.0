Return-Path: <bpf+bounces-42835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4599AB8EB
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 23:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AEFCB239F4
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 21:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBE11CDA14;
	Tue, 22 Oct 2024 21:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deZWoFvx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A47C1CCB31
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 21:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729633018; cv=none; b=bxhPmxe/LB4IphRur9u6kp63hQTtnV2yMjMIjAOLF08XSfQ9D8q6XHFk8dXInICFnqdBvDzZCoSg49fNID5l3vXDpxQfb/ubQQfYdQurgcsQpZ9HZFS6p4kUgrzffRY9432i+LJ7/zLdJQKGKwcu6Zmf1aUmOOm+qzmjcT0zziM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729633018; c=relaxed/simple;
	bh=UdGQIBquQFcoFDpXs8nZVGG5vIvdOJoWdHzx2HnxCng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rIOCeS0MRyMwDgEOYONjtKM/Zvt/JVZZyMmQhBi/5c6Ym/H7T0d1B0gSXPphjNeNbeZgm2P5R3lfux/koyV+9M7J05szVmi/7dH7cxOju49VdUOz4K7qeEUTKNFEq7/Vubo6hQKkHKEOF379MKPn9ee+NgjUz+MJg5zSP+uH1qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=deZWoFvx; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-a9a26a5d6bfso873606166b.1
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 14:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729633015; x=1730237815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2i0ao0h9600h9/yxTvWaFuMv30dDJLwN2/BUC5S/40E=;
        b=deZWoFvxETkGIZlSFUwqW7UFAfW35dwQ5yF4s6f9ZRujd6o8YaTNqHnlKKNuS/id6e
         jpOCycVkp9D0ZlDeJdMPaVA3OYxUVGPMp5yG/azO3IvghyNROqbOWG6H/x2ndfiQwn95
         k/7dY7zOlAirAi6F7CNdQ2ERovBhQysqwfuwT46nGi+25kKsJbtkk0sBx7xjIwkNv8cH
         1NjRMY4Ib3Ki+jS7XCRDga5EHNEtHpT5h/OB1+tJcUppO4UP/Jy1DghROi5mQ7J4CENM
         Ev/ZG1agFI0kzzZ0OKAVKbB556w8V5coiOOBwNR6e/N7aEQjmXlzRIABB3o4dtF4E/gC
         omyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729633015; x=1730237815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2i0ao0h9600h9/yxTvWaFuMv30dDJLwN2/BUC5S/40E=;
        b=Qv32sz2kcno/gpevhFF4z+i0cd6tK2pMvrT5cuvbxkt3n7RrA49Ho2E1vbZkEaulow
         QaZhOfkU/9natuExlkzg+QIcBx0j4OzP9KZL3YPjgbac8sUSWXCl8ayUQgswy4pbSOl/
         gjiK1iKjkR3h5bQp6OvnJJRPUpP65LFS16I0TKV0sPPVF5AX128oNzKWMvct24HXnoPx
         syXiQ0JZ69WSmN/TDYWCC0Utn53SOZhcOAu+zAjLiOO96A/FQSRe5wO/W604SDgLzWEh
         1nUABdSNXqUjfakO5xDVzkfkapKSdgtCW3qj5QEbKDavnGWtuVNd2IJOwss6c6nJDagC
         tsIA==
X-Forwarded-Encrypted: i=1; AJvYcCX/Jwl16RU1ftJ9yRIJyQy04H6TytnUSrTUqvoPwkL/INdmvQqc57pOe2bvfmt0q7GTpeU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/otq6Y7oz8Em9OVJv6TR8Mb2LkjGrGi7c6Eg9bT2zYS8wMz/j
	WEyqwSNerydo68AH9KgfCQ9rkg5oSmpNvb2OP7BpJLLgFJ820ECCZnMFYQv2Qz5WjiqogQUygzq
	pEqgWESk8sCcrw25ucmxqoV3MmH8=
X-Google-Smtp-Source: AGHT+IFFzdqPBL8cXxzRITBmFG1/ixycmP2WplJ1Ypo5kPtOk6rPwywQb57kqqu5onKKi38qp/WqY2XlHiPETxsNgdM=
X-Received: by 2002:a17:907:6d24:b0:a86:94e2:2a47 with SMTP id
 a640c23a62f3a-a9abf887496mr35636966b.15.1729633014489; Tue, 22 Oct 2024
 14:36:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241020191341.2104841-1-yonghong.song@linux.dev>
 <20241020191347.2105090-1-yonghong.song@linux.dev> <CAADnVQ+ZXMh_QKy0nd-n7my1SETroockPjpVVJOAWsE3tB_5sg@mail.gmail.com>
 <c6e5040b-9558-481f-b1fc-f77dc9ce90c1@linux.dev> <CAADnVQJCfiNEgrvf6GuaUadz6rDSNU6QB3grpOfk2-jQP6is4Q@mail.gmail.com>
 <179d5f87-4c70-438b-9809-cc05dffc13de@linux.dev> <CAADnVQL3+o7xV2LQcO-AArBmSEV=CQ7TQsuzBfTUnc_g+MhoMw@mail.gmail.com>
 <CAP01T74+Z_9xzmLQ+hJsYOfAMbqNQ8=Jt_zpdqckfd-SRajkUQ@mail.gmail.com>
In-Reply-To: <CAP01T74+Z_9xzmLQ+hJsYOfAMbqNQ8=Jt_zpdqckfd-SRajkUQ@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 22 Oct 2024 23:36:18 +0200
Message-ID: <CAP01T74L483Xf-pEcq05JfBwdjZhwF6tNbfMONDjBSGEZNXsKQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 1/9] bpf: Allow each subprog having stack size
 of 512 bytes
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Oct 2024 at 23:29, Kumar Kartikeya Dwivedi <memxor@gmail.com> wr=
ote:
>
> On Tue, 22 Oct 2024 at 22:41, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Oct 22, 2024 at 1:13=E2=80=AFPM Yonghong Song <yonghong.song@li=
nux.dev> wrote:
> > >
> > >
> > > On 10/21/24 8:43 PM, Alexei Starovoitov wrote:
> > > > On Mon, Oct 21, 2024 at 8:21=E2=80=AFPM Yonghong Song <yonghong.son=
g@linux.dev> wrote:
> > > >>>>           for (int i =3D 0; i < env->subprog_cnt; i++) {
> > > >>>> -               if (!i || si[i].is_async_cb) {
> > > >>>> -                       ret =3D check_max_stack_depth_subprog(en=
v, i);
> > > >>>> +               check_subprog =3D !i || (check_priv_stack ? si[i=
].is_cb : si[i].is_async_cb);
> > > >>> why?
> > > >>> This looks very suspicious.
> > > >> This is to simplify jit. For example,
> > > >>      main_prog   <=3D=3D=3D main_prog_priv_stack_ptr
> > > >>        subprog1  <=3D=3D=3D there is a helper which has a callback=
_fn
> > > >>                  <=3D=3D=3D for example bpf_for_each_map_elem
> > > >>
> > > >>          callback_fn
> > > >>            subprog2
> > > >>
> > > >> In callback_fn, we cannot simplify do
> > > >>      r9 +=3D stack_size_for_callback_fn
> > > >> since r9 may have been clobbered between subprog1 and callback_fn.
> > > >> That is why currently I allocate private_stack separately for call=
back_fn.
> > > >>
> > > >> Alternatively we could do
> > > >>      callback_fn_priv_stack_ptr =3D main_prog_priv_stack_ptr + off
> > > >> where off equals to (stack size tree main_prog+subprog1).
> > > >> I can do this approach too with a little more information in prog-=
>aux.
> > > >> WDYT?
> > > > I see. I think we're overcomplicating the verifier just to
> > > > be able to do 'r9 +=3D stack' in the subprog.
> > > > The cases of async vs sync and directly vs kfunc/helper
> > > > (and soon with inlining of kfuncs) are getting too hard
> > > > to reason about.
> > > >
> > > > I think we need to go back to the earlier approach
> > > > where every subprog had its own private stack and was
> > > > setting up r9 =3D my_priv_stack in the prologue.
> > > >
> > > > I suspect it's possible to construct a convoluted subprog
> > > > that calls itself a limited amount of time and the verifier allows =
that.
> > > > I feel it will be easier to detect just that condition
> > > > in the verifier and fallback to the normal stack.
> > >
> > > I tried a simple bpf prog below.
> > >
> > > $ cat private_stack_subprog_recur.c
> > > // SPDX-License-Identifier: GPL-2.0
> > >
> > > #include <vmlinux.h>
> > > #include <bpf/bpf_helpers.h>
> > > #include <bpf/bpf_tracing.h>
> > > #include "../bpf_testmod/bpf_testmod.h"
> > >
> > > char _license[] SEC("license") =3D "GPL";
> > >
> > > #if defined(__TARGET_ARCH_x86)
> > > bool skip __attribute((__section__(".data"))) =3D false;
> > > #else
> > > bool skip =3D true;
> > > #endif
> > >
> > > int i;
> > >
> > > __noinline static void subprog1(int level)
> > > {
> > >          if (level > 0) {
> > >                  subprog1(level >> 1);
> > >                  i++;
> > >          }
> > > }
> > >
> > > SEC("kprobe")
> > > int prog1(void)
> > > {
> > >          subprog1(1);
> > >          return 0;
> > > }
> > >
> > > In the above prog, we have a recursion of subprog1. The
> > > callchain is:
> > >     prog -> subprog1 -> subprog1
> > >
> > > The insn-level verification is successful since argument
> > > of subprog1() has precise value.
> > >
> > > But eventually, verification failed with the following message:
> > >    the call stack of 8 frames is too deep !
> > >
> > > The error message is
> > >                  if (frame >=3D MAX_CALL_FRAMES) {
> > >                          verbose(env, "the call stack of %d frames is=
 too deep !\n",
> > >                                  frame);
> > >                          return -E2BIG;
> > >                  }
> > > in function check_max_stack_depth_subprog().
> > > Basically in function check_max_stack_depth_subprog(), tracing subpro=
g
> > > call is done only based on call insn. All conditionals are ignored.
> > > In the above example, check_max_stack_depth_subprog() will have the
> > > call graph like
> > >      prog -> subprog1 -> subprog1 -> subprog1 -> subprog1 -> ...
> > > and eventually hit the error.
> > >
> > > Basically with check_max_stack_depth_subprog() self recursion is not
> > > possible for a bpf prog.
> > >
> > > This limitation is back to year 2017.
> > >    commit 70a87ffea8ac  bpf: fix maximum stack depth tracking logic
> > >
> > > So I assume people really do not write progs with self recursion insi=
de
> > > the main prog (including subprogs).
> >
> > Thanks for checking this part.
> >
> > What about sync and async callbacks? Can they recurse?
> >
> > Since progs are preemptible is the following possible:
> >
> > __noinline static void subprog(void)
> > {
> >   /* delay */
> > }
> >
> > static int timer_cb(void *map, int *key, void *val)
> > {
> >   subprog();
> > }
> >
> > SEC("tc")
> > int prog1(void)
> > {
> >     bpf_timer_set_callback(  &timer_cb);
> >     subprog();
> >     return 0;
> > }
> >
> > timers use softirq.
> > I'm not sure whether it's the same stack or not.
> > So it may be borderline ok-ish for other reasons,
> > but the question remains. Will subprog recurse this way?
> >
>
> Yes, but not in the normal ways.
> There can be only one softirq context per-CPU (even on preemptible RT
> with timers running in kthreads), but timer_cb can also be called
> directly by the prog. So any other context the same prog can execute
> in will allow it to call timer_cb while another invocation is
> potentially preempted out on the same CPU.
> It might be better to disallow direct calling such async callbacks,
> because I'm not sure anyone relies on that behavior, but it is
> something I've previously looked at (for exception_cb, which is
> disallowed to be called directly due to the distinct way prologue is
> set up).

Ah, in your example it's a subprog() called by both. Yeah, I guess we
can't really prevent that from happening.

>
> We'll also need to remember this when/if we introduce hardirq mode for
> BPF timers.

