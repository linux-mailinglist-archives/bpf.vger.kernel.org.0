Return-Path: <bpf+bounces-42834-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 779799AB86C
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 23:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D61F3B220B9
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 21:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152AD1CCEE3;
	Tue, 22 Oct 2024 21:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNnIaon1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36D2130AF6
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 21:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729632592; cv=none; b=VlEpX6av+gLtpaKD6qQ8OARhUtxepEKUNMz0GsTuvuhIRv67GdCVwqkiwSAKlLiaDHDP1TPnzaEh5+0Nx0Lbk/7ExM9qQE1Zoi6wq392TfAacWwmicsvEGZyEnnKtBwoiAi/DeyNFhpOe1vuYLX+iP26FWq/n6NtIGkns8960W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729632592; c=relaxed/simple;
	bh=d2DG3+phVWkq9leE1QVqcPaKbAvgS1vzuSW2O/o5v3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IeAeKOb8kWEGLuqEAIZMhFHFwDFReFFZlXU50Bh5uCWUyHUjf6tEJ9GTe6MvN7dGnsP9D0RmRZiedOAuUoMDUU6uXZy/B1/ZRUIbPVECFlE3IilAyMVuItMvL/+O0pg6Ixc9pzG7KyVIM+K3Q4V8zpHFT3lV2+zc38IJV3ajR3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNnIaon1; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-431688d5127so37736155e9.0
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 14:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729632589; x=1730237389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQFk/nXJnYQzsD20FdCHqa/ZFb3P/5It9CmbJH0Ayn4=;
        b=gNnIaon1yr9m7hDPbDR4/wXHs3bZGFXGc7+RV2vT+bvFxC7zyCiOiWwTT1WafwF84P
         pVHXGyLTZSxVa49Z82CsvmQA2yBZcjnmzpluun++twxNbcnje5AE3b4ghUuZaqhbuWn2
         9bs6fwDNl5i8kTD1VhmQLhA5N1v4U4V3URGd1N1dz8TVBVuneLmo5XLD3LJwQk45UGu7
         3HE9qp9L8AzRmU0J6IoHBErkqy0e4pe4WEYQZmtoqk4oJ0XggoC2NzAsOrbfcYmPruzV
         KKW1GzWEUKMXKv5yZflV40QHv7ycXR1wS+rECxurY2cXBQxbbcPSLWBiTykaNmD6pond
         g8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729632589; x=1730237389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQFk/nXJnYQzsD20FdCHqa/ZFb3P/5It9CmbJH0Ayn4=;
        b=QsEjldK2iSgI4NLA9zMkN/4w5FY3MUsYCw/0D6oFE1upRwVVQCwMMOzHZjYH7iIydM
         lfkRzKzvm6F/OhAdebdTJQZR6Ty0jRaJUVWLeZLkzR/Z1skKBtlzJjCHi+oqstBpVakH
         /z+QQ6Vn5b3l56J9NKIBwKPR8tfaSzNXauBrhfuc2ybxQk2V6eLjITuhd2pYiXPVRpBD
         UGt/UbeSNDvPDqJZd8zTMBa864X59wm8r2pyYdz4oAagxmuECFLoCeDfq1QzxPi+JvF2
         yaXPQqJBisMociP6fqbi9OEuDmes4pUwQdTv36jXXX6/3+1hG3T/IDJKvjIQnjizb1mi
         Mu+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVm0Zz09jufof9cfKMZMnG7s9eBcnfSrUKjq7A+cokgUCHCIRrDEOjXA2MXIlyq0uzls6A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqtxjfj6nXGIQeLhozBWSxJwkN+jaCRvi1VLmGmVj+Ij8V/yOG
	MA/EQKzgZDfS2NxH6kCJCj8l+2YgfncpQUTv0jOY8AqfgYTGMPG8KMB49Z39kDKhKA0QzMKaSGX
	jm7oN/z1fITaxhnuLJPYaQdaK5oRRobSg
X-Google-Smtp-Source: AGHT+IF9mAZZWogMDNyR8/wXzejZBhcipmCCHNFhpEA9aI2Sp3vEm+nipC0o3xTZMSNR1/sDhHgSEwECGb+PHtSuUcg=
X-Received: by 2002:a05:6000:c8e:b0:37d:5046:565 with SMTP id
 ffacd0b85a97d-37efcf7bb38mr221711f8f.40.1729632589041; Tue, 22 Oct 2024
 14:29:49 -0700 (PDT)
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
In-Reply-To: <CAADnVQL3+o7xV2LQcO-AArBmSEV=CQ7TQsuzBfTUnc_g+MhoMw@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 22 Oct 2024 23:29:12 +0200
Message-ID: <CAP01T74+Z_9xzmLQ+hJsYOfAMbqNQ8=Jt_zpdqckfd-SRajkUQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 1/9] bpf: Allow each subprog having stack size
 of 512 bytes
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Oct 2024 at 22:41, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Oct 22, 2024 at 1:13=E2=80=AFPM Yonghong Song <yonghong.song@linu=
x.dev> wrote:
> >
> >
> > On 10/21/24 8:43 PM, Alexei Starovoitov wrote:
> > > On Mon, Oct 21, 2024 at 8:21=E2=80=AFPM Yonghong Song <yonghong.song@=
linux.dev> wrote:
> > >>>>           for (int i =3D 0; i < env->subprog_cnt; i++) {
> > >>>> -               if (!i || si[i].is_async_cb) {
> > >>>> -                       ret =3D check_max_stack_depth_subprog(env,=
 i);
> > >>>> +               check_subprog =3D !i || (check_priv_stack ? si[i].=
is_cb : si[i].is_async_cb);
> > >>> why?
> > >>> This looks very suspicious.
> > >> This is to simplify jit. For example,
> > >>      main_prog   <=3D=3D=3D main_prog_priv_stack_ptr
> > >>        subprog1  <=3D=3D=3D there is a helper which has a callback_f=
n
> > >>                  <=3D=3D=3D for example bpf_for_each_map_elem
> > >>
> > >>          callback_fn
> > >>            subprog2
> > >>
> > >> In callback_fn, we cannot simplify do
> > >>      r9 +=3D stack_size_for_callback_fn
> > >> since r9 may have been clobbered between subprog1 and callback_fn.
> > >> That is why currently I allocate private_stack separately for callba=
ck_fn.
> > >>
> > >> Alternatively we could do
> > >>      callback_fn_priv_stack_ptr =3D main_prog_priv_stack_ptr + off
> > >> where off equals to (stack size tree main_prog+subprog1).
> > >> I can do this approach too with a little more information in prog->a=
ux.
> > >> WDYT?
> > > I see. I think we're overcomplicating the verifier just to
> > > be able to do 'r9 +=3D stack' in the subprog.
> > > The cases of async vs sync and directly vs kfunc/helper
> > > (and soon with inlining of kfuncs) are getting too hard
> > > to reason about.
> > >
> > > I think we need to go back to the earlier approach
> > > where every subprog had its own private stack and was
> > > setting up r9 =3D my_priv_stack in the prologue.
> > >
> > > I suspect it's possible to construct a convoluted subprog
> > > that calls itself a limited amount of time and the verifier allows th=
at.
> > > I feel it will be easier to detect just that condition
> > > in the verifier and fallback to the normal stack.
> >
> > I tried a simple bpf prog below.
> >
> > $ cat private_stack_subprog_recur.c
> > // SPDX-License-Identifier: GPL-2.0
> >
> > #include <vmlinux.h>
> > #include <bpf/bpf_helpers.h>
> > #include <bpf/bpf_tracing.h>
> > #include "../bpf_testmod/bpf_testmod.h"
> >
> > char _license[] SEC("license") =3D "GPL";
> >
> > #if defined(__TARGET_ARCH_x86)
> > bool skip __attribute((__section__(".data"))) =3D false;
> > #else
> > bool skip =3D true;
> > #endif
> >
> > int i;
> >
> > __noinline static void subprog1(int level)
> > {
> >          if (level > 0) {
> >                  subprog1(level >> 1);
> >                  i++;
> >          }
> > }
> >
> > SEC("kprobe")
> > int prog1(void)
> > {
> >          subprog1(1);
> >          return 0;
> > }
> >
> > In the above prog, we have a recursion of subprog1. The
> > callchain is:
> >     prog -> subprog1 -> subprog1
> >
> > The insn-level verification is successful since argument
> > of subprog1() has precise value.
> >
> > But eventually, verification failed with the following message:
> >    the call stack of 8 frames is too deep !
> >
> > The error message is
> >                  if (frame >=3D MAX_CALL_FRAMES) {
> >                          verbose(env, "the call stack of %d frames is t=
oo deep !\n",
> >                                  frame);
> >                          return -E2BIG;
> >                  }
> > in function check_max_stack_depth_subprog().
> > Basically in function check_max_stack_depth_subprog(), tracing subprog
> > call is done only based on call insn. All conditionals are ignored.
> > In the above example, check_max_stack_depth_subprog() will have the
> > call graph like
> >      prog -> subprog1 -> subprog1 -> subprog1 -> subprog1 -> ...
> > and eventually hit the error.
> >
> > Basically with check_max_stack_depth_subprog() self recursion is not
> > possible for a bpf prog.
> >
> > This limitation is back to year 2017.
> >    commit 70a87ffea8ac  bpf: fix maximum stack depth tracking logic
> >
> > So I assume people really do not write progs with self recursion inside
> > the main prog (including subprogs).
>
> Thanks for checking this part.
>
> What about sync and async callbacks? Can they recurse?
>
> Since progs are preemptible is the following possible:
>
> __noinline static void subprog(void)
> {
>   /* delay */
> }
>
> static int timer_cb(void *map, int *key, void *val)
> {
>   subprog();
> }
>
> SEC("tc")
> int prog1(void)
> {
>     bpf_timer_set_callback(  &timer_cb);
>     subprog();
>     return 0;
> }
>
> timers use softirq.
> I'm not sure whether it's the same stack or not.
> So it may be borderline ok-ish for other reasons,
> but the question remains. Will subprog recurse this way?
>

Yes, but not in the normal ways.
There can be only one softirq context per-CPU (even on preemptible RT
with timers running in kthreads), but timer_cb can also be called
directly by the prog. So any other context the same prog can execute
in will allow it to call timer_cb while another invocation is
potentially preempted out on the same CPU.
It might be better to disallow direct calling such async callbacks,
because I'm not sure anyone relies on that behavior, but it is
something I've previously looked at (for exception_cb, which is
disallowed to be called directly due to the distinct way prologue is
set up).

We'll also need to remember this when/if we introduce hardirq mode for
BPF timers.

