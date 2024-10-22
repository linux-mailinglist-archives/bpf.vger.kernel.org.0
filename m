Return-Path: <bpf+bounces-42826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E921D9AB7CE
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 22:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A48FE283829
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 20:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EB51CCEE7;
	Tue, 22 Oct 2024 20:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfuV0olN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DD01CC8A8
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 20:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729629690; cv=none; b=AdYb5zsXjVDmURSXe4YiHTxX3zCfMxsJ3QVpG3aB6m5kFipv70JGX1g8ef7U27pzAkCoXT8+StnvwxWewLuFlSRQ+cDfBDyApktaRrYShLAGWPFzVkSlH5licLCw26P4tncZ8/ys9MZ7Clnn/wo0CqFAD7mB/zk9Aq88pbTI/18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729629690; c=relaxed/simple;
	bh=okF/+xRhwviSh3xUvJznUVyZdqrVlP/M/AOiun7gVbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QaX3t1J1A1o1Gm2Jg1EPkrrPbbpqpJ8335LD105BFnKQrEkfc1ta3orw5sKNqX+22dTer3zTXvKretNlRMNSTu5PNWZduFpXFYh76gqFIsgpEyz54TvScdHIk6yxf8Wb+P2M1zkIN4jo7UjSRQXNA4azIuf4PmHb9vcE2ck+/ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EfuV0olN; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d473c4bb6so5459663f8f.3
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 13:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729629687; x=1730234487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnv5yVe5EwL9gcM80SVSn9LWMi3N/XpHnpMPJrJj3zg=;
        b=EfuV0olN/QAlClCGgUdUuYiZwUX5uIUAuaVe/6Xr2yAYfhw+znkrIyRbT8XvWjMxpd
         tI9XpfJc/6KYhRKfOJWRtz6HS4Q91M6MaXKxYSKZLk8QD8C6MBli88VF+ZXnvy0Mxf46
         iE5JfHwuNB4U2XZScOewnVQTonNYYJeDnuxSov5WLB3YC6jS/fhyMoxqNxVHAfK7Ym2O
         Uk/80UdWhfZoPs/qpFcdDDoCISYuYEUKiHLuSJ+6qh700LjapKW7D11w1huDhKhXOCW9
         qK42fc4VEK5afuRIioXQmyz5hwmfV5NTNM3716oR1epbfs9JI6OvpCE9p5ZvGPTAXZxp
         cltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729629687; x=1730234487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vnv5yVe5EwL9gcM80SVSn9LWMi3N/XpHnpMPJrJj3zg=;
        b=MRW4458dOeUI+c4h+9sV8RXFFAjaUcf+2x07gcbPb9KSKuJi49E8wwVMCWz6c9YlMv
         VVr6jhbjLItd98QZ/fKv1nbXE1SHE5zPp1OWZDjRBBSdDcGweFc/2aIf7BR+PPXCXwGO
         JtvqOdbKhldDItVU3ys+EuRdXx+IjipP+vY76ky/edG71wVchwSAOTDmpnsC2s1tjzCz
         BredIBA83zhpF5ehiIHqbzsaxyxYqo5/VD1uHcITVvMfkpYBn1WnkK0Y0DLC6fJZMSzq
         yeQLYxQ5Eio7Z8jIw4GdmBXVgmL6u6lAwWplX7538go/6pnq/134uVXB4R19JRCUbdr+
         l2bg==
X-Gm-Message-State: AOJu0YzeYP6g21yK33yyrZorvQfcDAVaLNuRm/oGySgWjNWpvGv8jqTd
	8bA4iJdUi4za20sl2gRmvEnsNZNw4JCvbqNHSqD8UCe2nCfgMfKrI09ePFRwbpn256MK8w4IMdL
	TK3W1rMwBfxjB3Xh5kXwyxhp9BRY=
X-Google-Smtp-Source: AGHT+IEo1dOVR3xM47iS0R7b28BUbbbcJmskCC8uDSmuEqGGT7w5onccEKFcJnL+lRQOEUlSuuLeDChELCxMyiDl6mQ=
X-Received: by 2002:a5d:5051:0:b0:37d:4c40:699 with SMTP id
 ffacd0b85a97d-37efcee5a1cmr197567f8f.5.1729629687160; Tue, 22 Oct 2024
 13:41:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241020191341.2104841-1-yonghong.song@linux.dev>
 <20241020191347.2105090-1-yonghong.song@linux.dev> <CAADnVQ+ZXMh_QKy0nd-n7my1SETroockPjpVVJOAWsE3tB_5sg@mail.gmail.com>
 <c6e5040b-9558-481f-b1fc-f77dc9ce90c1@linux.dev> <CAADnVQJCfiNEgrvf6GuaUadz6rDSNU6QB3grpOfk2-jQP6is4Q@mail.gmail.com>
 <179d5f87-4c70-438b-9809-cc05dffc13de@linux.dev>
In-Reply-To: <179d5f87-4c70-438b-9809-cc05dffc13de@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 22 Oct 2024 13:41:15 -0700
Message-ID: <CAADnVQL3+o7xV2LQcO-AArBmSEV=CQ7TQsuzBfTUnc_g+MhoMw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 1/9] bpf: Allow each subprog having stack size
 of 512 bytes
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 1:13=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> On 10/21/24 8:43 PM, Alexei Starovoitov wrote:
> > On Mon, Oct 21, 2024 at 8:21=E2=80=AFPM Yonghong Song <yonghong.song@li=
nux.dev> wrote:
> >>>>           for (int i =3D 0; i < env->subprog_cnt; i++) {
> >>>> -               if (!i || si[i].is_async_cb) {
> >>>> -                       ret =3D check_max_stack_depth_subprog(env, i=
);
> >>>> +               check_subprog =3D !i || (check_priv_stack ? si[i].is=
_cb : si[i].is_async_cb);
> >>> why?
> >>> This looks very suspicious.
> >> This is to simplify jit. For example,
> >>      main_prog   <=3D=3D=3D main_prog_priv_stack_ptr
> >>        subprog1  <=3D=3D=3D there is a helper which has a callback_fn
> >>                  <=3D=3D=3D for example bpf_for_each_map_elem
> >>
> >>          callback_fn
> >>            subprog2
> >>
> >> In callback_fn, we cannot simplify do
> >>      r9 +=3D stack_size_for_callback_fn
> >> since r9 may have been clobbered between subprog1 and callback_fn.
> >> That is why currently I allocate private_stack separately for callback=
_fn.
> >>
> >> Alternatively we could do
> >>      callback_fn_priv_stack_ptr =3D main_prog_priv_stack_ptr + off
> >> where off equals to (stack size tree main_prog+subprog1).
> >> I can do this approach too with a little more information in prog->aux=
.
> >> WDYT?
> > I see. I think we're overcomplicating the verifier just to
> > be able to do 'r9 +=3D stack' in the subprog.
> > The cases of async vs sync and directly vs kfunc/helper
> > (and soon with inlining of kfuncs) are getting too hard
> > to reason about.
> >
> > I think we need to go back to the earlier approach
> > where every subprog had its own private stack and was
> > setting up r9 =3D my_priv_stack in the prologue.
> >
> > I suspect it's possible to construct a convoluted subprog
> > that calls itself a limited amount of time and the verifier allows that=
.
> > I feel it will be easier to detect just that condition
> > in the verifier and fallback to the normal stack.
>
> I tried a simple bpf prog below.
>
> $ cat private_stack_subprog_recur.c
> // SPDX-License-Identifier: GPL-2.0
>
> #include <vmlinux.h>
> #include <bpf/bpf_helpers.h>
> #include <bpf/bpf_tracing.h>
> #include "../bpf_testmod/bpf_testmod.h"
>
> char _license[] SEC("license") =3D "GPL";
>
> #if defined(__TARGET_ARCH_x86)
> bool skip __attribute((__section__(".data"))) =3D false;
> #else
> bool skip =3D true;
> #endif
>
> int i;
>
> __noinline static void subprog1(int level)
> {
>          if (level > 0) {
>                  subprog1(level >> 1);
>                  i++;
>          }
> }
>
> SEC("kprobe")
> int prog1(void)
> {
>          subprog1(1);
>          return 0;
> }
>
> In the above prog, we have a recursion of subprog1. The
> callchain is:
>     prog -> subprog1 -> subprog1
>
> The insn-level verification is successful since argument
> of subprog1() has precise value.
>
> But eventually, verification failed with the following message:
>    the call stack of 8 frames is too deep !
>
> The error message is
>                  if (frame >=3D MAX_CALL_FRAMES) {
>                          verbose(env, "the call stack of %d frames is too=
 deep !\n",
>                                  frame);
>                          return -E2BIG;
>                  }
> in function check_max_stack_depth_subprog().
> Basically in function check_max_stack_depth_subprog(), tracing subprog
> call is done only based on call insn. All conditionals are ignored.
> In the above example, check_max_stack_depth_subprog() will have the
> call graph like
>      prog -> subprog1 -> subprog1 -> subprog1 -> subprog1 -> ...
> and eventually hit the error.
>
> Basically with check_max_stack_depth_subprog() self recursion is not
> possible for a bpf prog.
>
> This limitation is back to year 2017.
>    commit 70a87ffea8ac  bpf: fix maximum stack depth tracking logic
>
> So I assume people really do not write progs with self recursion inside
> the main prog (including subprogs).

Thanks for checking this part.

What about sync and async callbacks? Can they recurse?

Since progs are preemptible is the following possible:

__noinline static void subprog(void)
{
  /* delay */
}

static int timer_cb(void *map, int *key, void *val)
{
  subprog();
}

SEC("tc")
int prog1(void)
{
    bpf_timer_set_callback(  &timer_cb);
    subprog();
    return 0;
}

timers use softirq.
I'm not sure whether it's the same stack or not.
So it may be borderline ok-ish for other reasons,
but the question remains. Will subprog recurse this way?

