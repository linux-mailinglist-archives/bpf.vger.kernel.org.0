Return-Path: <bpf+bounces-52119-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AEFA3E92A
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 01:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB20919C1ADB
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 00:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E253A94A;
	Fri, 21 Feb 2025 00:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIJgfwu9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C895680
	for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 00:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740097655; cv=none; b=JSxcS+WiUHG16vY7UK3rmXyo5cn/GYl3qXiK2LLN0kgDesIq4p2LvwKBMeBrdoo+h+cdLiNusfIdSThNzjKkmsTENp7E8QZY4wKVhYy9vNlt9kC7L20j7TW+w9rHffHalq6NtBL1mbDg6o0VA6Ry9a0XSrEoFlOlUjE7gBkTszA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740097655; c=relaxed/simple;
	bh=TTdw1tPFi8yOHGp0ZMkHGvT2KdqRWrsaowg6na42ZgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o9YmfIUlU5iq9MHgRQEoX9oN1WHFjb8Aq9LJeqSUgRiF7zuGPjX4WGCJWEBNIRTDokvt/1Ztp3bqIqkGPB5KcnMhXElppbZ4ONBPphcHDZsFtDTjSQIMOOgXImNewxaNgTU6DNUx4QD+C+FTMmjDPEC5NNtL6lMzGlD7q1xBi5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LIJgfwu9; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2fbfa8c73a6so3150478a91.2
        for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 16:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740097653; x=1740702453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/VDipfeu3J7pK4FwGR9nB/uNJJHa2UZBHDvEXttMDpQ=;
        b=LIJgfwu9GaPMW9o3iVHzKYDeWd2xnsyJmAsjZYgez34OZfhVa7j3BqAG9nhhn1cUpq
         iuMw/lItM/CHXWBKUHqQsjIaWNv1FE6989zdFQzZe52UpZ20dGWujlos2tEDV9Z5c43b
         AZfuTrFkMlBT70bHGNw2yfo646XbipAeZhSN6RG6XM7nHuUvpTYm93iAX3h+kWHK8UA2
         kuk3CKdtOPgA/IxnM86FAv9SAIBi3cT4uQsu3WHJ1E+7MlB8+Tg/bFNFtTxfdjUA4ibC
         bazq0mG7jqruENHAyzH/YGO0qx8BN/f7mzol4LXVCpzTFc2o2YWg+ULip1CcrLL/wAfz
         h4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740097653; x=1740702453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/VDipfeu3J7pK4FwGR9nB/uNJJHa2UZBHDvEXttMDpQ=;
        b=TOoDzBQ7C1NZXXps4N1wIpjuytkc8nsvQqcK0AoASTf9u7t/Kqh+Gei+KpcRU0lqpY
         gMo9u7qApiy8xloxn7fLO2KhnR7z6OW++QB6+21HjLYKUWWyBmypAeA8fFCYZvX5AeDf
         RXQEf1jIV04KgueAUy++TN9Fy08Yd9sSDSzel5JYG5SehI8ywvxYWWTG0+5i1/7uQxqm
         zvNozxIo/6WaY6z6Vz+b8dSALaVc+9zAmsfFnN+rrYnMCHKl/6bXhIsDn4mv9MzbsseK
         DulIcLc7loIWQPtH34QBMArYaxwxBw+rHdoLiSFZ+YTu5sCO62//fXVYXMxhrSeBLzsq
         KCjQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+7avmI2VDyi6r2uu5w406xQkNDAUEKy6j/f2RMfAzGmDoxm6y139ZIWcRSdtj5tQnAec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxln3onhk4VYGgjwd1Cd1QV2vgSK+rnhEYxFTqltkfhSwOHT8nR
	Ibyf0RhuvAeGZ/9LvFmmj7FHlCKshBEPhg+f9d6ItxJDjBYPDZZ+gCMZFTOM1FFhXUwfIVSj+6z
	+0S6+0rJrzdZDgNvN865PrfXOcIo=
X-Gm-Gg: ASbGncspyHsPpLbxEaMO4mACRdeW3Nbuw3kVjPfCud/fQ3MVBgB5gzD+FZkG4E052Nv
	RRlCOagwB+Il2jIybpsTIJSPs37mS6dP1sPqsBHX/XQBUC50onBh+QqU0T5iqpMO9ePTtACkCD1
	YbaALv1T5Xz+Gc
X-Google-Smtp-Source: AGHT+IERkGgRFL5wRGu/nwG7K86LWw0zpb5PHzx/E9g7ZMRx5xrSsygM8OMG67DYcG7WNA2VMmrDdLpzqfxYmZhfgF4=
X-Received: by 2002:a17:90b:2ccd:b0:2ee:b26c:10a0 with SMTP id
 98e67ed59e1d1-2fce8724390mr1426493a91.24.1740097652550; Thu, 20 Feb 2025
 16:27:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219125117.1956939-1-memxor@gmail.com> <20250219125117.1956939-2-memxor@gmail.com>
 <CAADnVQ+TBG+yAxtY1Q5D6HnhbvgusUVrzyRm7-8oF7wYw+Nqfw@mail.gmail.com>
 <CAP01T74tZudfS8huoz=sP4UkEgs5ipkz9Qjf=6XNVzJvGOFLgQ@mail.gmail.com>
 <CAEf4BzbyF3aWdE0Uk0KtdeYwmEYSahfpZk=vK-JhhZ-Bgb55ZQ@mail.gmail.com> <CAP01T76=Twha0twPgzO8Un6--e3cX1PMFEtu1jHVS_7iQzOcfQ@mail.gmail.com>
In-Reply-To: <CAP01T76=Twha0twPgzO8Un6--e3cX1PMFEtu1jHVS_7iQzOcfQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 20 Feb 2025 16:27:20 -0800
X-Gm-Features: AWEUYZm16Ewx3twDo-7BP-fD-UYrL96px-isKQTOLe1PVtb9bLAciDauAvm1YLU
Message-ID: <CAEf4Bzbny7VFufpMq6RZJ1_poYsAFw89tpmKHhMSbTNb2=PsBg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v1 1/2] bpf: Explore PTR_TO_STACK as R0 for bpf_dynptr_slice_rdwr
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 7:41=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Thu, 20 Feb 2025 at 01:13, Andrii Nakryiko <andrii.nakryiko@gmail.com>=
 wrote:
> >
> > On Wed, Feb 19, 2025 at 10:10=E2=80=AFAM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > On Wed, 19 Feb 2025 at 18:41, Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Wed, Feb 19, 2025 at 4:51=E2=80=AFAM Kumar Kartikeya Dwivedi
> > > > <memxor@gmail.com> wrote:
> > > > >
> > > > > For the bpf_dynptr_slice_rdwr kfunc, the verifier may return a po=
inter
> > > > > to the underlying packet (if the requested slice is linear), or c=
opy out
> > > > > the data to the buffer passed into the kfunc. The verifier perfor=
ms
> > > > > symbolic execution assuming the returned value is a PTR_TO_MEM of=
 a
> > > > > certain size (passed into the kfunc), and ensures reads and write=
s are
> > > > > within bounds.
> > > >
> > > > sounds like
> > > > check_kfunc_mem_size_reg() -> check_mem_size_reg() ->
> > > > check_helper_mem_access()
> > > >    case PTR_TO_STACK:
> > > >       check_stack_range_initialized()
> > > >          clobber =3D true
> > > >              if (clobber) {
> > > >                   __mark_reg_unknown(env, &state->stack[spi].spille=
d_ptr);
> > > >
> > > > is somehow broken?
> > > >
> > > > ohh. It might be:
> > > > || !is_kfunc_arg_optional(meta->btf, buff_arg)
> > > >
> > > > This bit is wrong then.
> > > > When arg is not-null check_kfunc_mem_size_reg() should be called.
> > > > The PTR_TO_STACK abuse is a small subset of issues
> > > > if check_kfunc_mem_size_reg() is indeed not called.
> > >
> > > The condition looks ok to me.
> > >
> > > The condition to do check_mem_size_reg is !null || !opt.
> > > So when it's null, and it's opt, it will be skipped.
> > > When it's null, and it's not opt, the check will happen.
> > > When arg is not-null, the said function is called, opt does not matte=
r then.
> > > So the stack slots are marked misc.
> > >
> > > In our case we're not passing a NULL pointer in the selftest.
> > >
> > > The problem occurs once we spill to that slot _after_ the call, and
> > > then do a write through returned mem pointer.
> > >
> > > The final few lines from the selftest do the dirty thing, where r0 is
> > > aliasing fp-8, and r1 =3D 0.
> > >
> > > + *(u64 *)(r10 - 8) =3D r8; \
> > > + *(u64 *)(r0 + 0) =3D r1; \
> > > + r8 =3D *(u64 *)(r10 - 8); \
> > > + r0 =3D *(u64 *)(r8 + 0); \
> > >
> > > The write through r0 must re-mark the stack, but the verifier doesn't
> > > know it's pointing to the stack.
> > > push_stack was the conceptually cleaner/simpler fix, but it apparentl=
y
> > > isn't good enough.
> > >
> > > Remarking the stack on write to PTR_TO_MEM, or invalidating PTR_TO_ME=
M
> > > when r8 is spilled to fp-8 first time after the call are two options.
> > > Both have some concerns (first, the misaligned stack access is not
> > > caught, second PTR_TO_MEM may outlive stack frame).
> >
> > Reading the description of the problem my first instinct was to have
> > stack slots with associated obj_ref_id for such cases and when
> > something writes into that stack slot, invalidate everything with that
> > obj_ref_id. So that's probably what you mean by invalidating
> > PTR_TO_MEM, right?
> >
> > Not sure I understand what "PTR_TO_STACK with mem_size" (that Alexei
> > mentioned in another email) means, though, so hard to compare.
> >
>
> Invalidation is certainly one option. The one Alexei mentioned was
> where we discussed bounding how much data can be read through the
> PTR_TO_STACK (similar to PTR_TO_MEM), and mark r0 as PTR_TO_STACK.
> This ends up combining the constraints of both types of pointers (it
> may as well be called PTR_TO_STACK_OR_MEM) without forking paths.

Yeah, PTR_TO_STACK_OR_MEM would be more precise. But how does that
help with this problem? Not sure I follow the idea of the solution
(but I can wait for patches to be posted).

>
> The benefit over the push_stack approach is that we avoid the states
> regression for cls_redirect and balancer_ingress.

yeah, of course, I don't particularly like the push_stack approach.

> For the selftest failure, I plan to just silence the error by changing it=
.
>
> > >
> > > I don't recall if there was a hardware/JIT specific reason to care
> > > about stack access alignment or not (on some architectures), but
> > > otherwise we can over approximately mark at 8-byte granularity for an=
y
> > > slot(s) that overlap with the buffer to cover such a case. The second
> > > problem is slightly trickier, which makes me lean towards invalidatin=
g
> > > returned PTR_TO_MEM when stack slot is overwritten or frame is
> > > destroyed.

