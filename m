Return-Path: <bpf+bounces-32552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6323390FB13
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 03:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 687B61C20F96
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 01:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B549114A8F;
	Thu, 20 Jun 2024 01:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="MdJDSZ0R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69311EAC6
	for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 01:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718848652; cv=none; b=GL/jtQYmQMrUoHhcfltkNKHdkRIw5Vi7HNjaxD+TJsMM4WzTJlOJOPlP1EKnhTnNEjnT1erbWtuqca4KfBJ7ZQON/RjpDV4+7zHLxod/3+JyPeR0sWoRp1MvVrsZN4AJEnx1akdaxVvP6gBhLrlI0m9A3LSU1KdjYyzj+TrVbiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718848652; c=relaxed/simple;
	bh=wVQ465YqEiJzEYw2nbW8L8gt9+qx7bXuVsr79KsNobg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i7cJ7I3p2iyquPZSJFpoQCciyEqmOAuu9iHkbx9jSxfyZuEfMhe5lYLPa9oK815UESwNaHPoiq6ze0vUPVn2cRMegwZEEmq6FQMxB/qbZF6daojVaSzAUHMk9TEgjR4Vhzeoo/GN5MrPB3sLDyqfFmBmTH/Jd3TOxMmiX5tljjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=MdJDSZ0R; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57d1679ee83so287015a12.2
        for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 18:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718848649; x=1719453449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrN98uj5LrucmXo8KqMUl+JtD7AINRjFYpbBTXhC80g=;
        b=MdJDSZ0RsFWoJh+GWm6bD0G0H70Y6DZ1JS7Ld47jFRpMZlyBMMXf6QSHcV+qwKLVAc
         jjTQhFZ1cbWlrrmUMeoqOOMWu8DPa1SrYjkbAfah4Q3n4DVhie3EKocZDHlC/A2AKCSf
         9Pp+o6ypDi8aQ+3xQ1my5w7I3FmGa479m/fGx2Q/iGKD//C1h7KSauI4AqhR3l3/GU9w
         3/jF6PR8FNiEYSFzPgvjbGQZxkY07F2pmgwpSsToLZZ6DR9v4kdjzTlrqDjs1rldA9Oh
         72YNocmPGyD8JFAtsBCuFzAyQmzpuRHFWVBiW0F9+3RKyO/I637bwqMdFcqlSpl/9OXG
         2M9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718848649; x=1719453449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qrN98uj5LrucmXo8KqMUl+JtD7AINRjFYpbBTXhC80g=;
        b=lusP8laKsjW/CeYo2n/UC8q+3c7tSRNSReKedm/lheuE1dyNaDWNkNiZRlvVNZOcvn
         XIWzZGQx0EG3UDZden35HNuny/x8nH9ltFbp4p5WGyrTW/iArn4pIMJPZN/SNDnljVaP
         L6wjN1nrzhOe8atPfEYw0LLZjKJmTevlntKz+OUQO7ZfLEahTjFgzQfNSZAlIKZ7e3Ro
         o2HBBfD3CcW7bfaY5jmsOsLsEw4bUU/aR6OPWoaYs5CoKk7EFVsRd9ht81p9pPauJCob
         VqsajHWp7WRrR/jAj275/mMyz/pppjMg4Dp4sPQlyGQKhILK3qga3A6Oxot6lp10PJvb
         axGA==
X-Forwarded-Encrypted: i=1; AJvYcCUN+ptuRO7i4glJUuXP605MPN2R0ub2/znXVDkwk+KQw+mk0SArC1TtIUix0Ux3TKy48YoIgFq8xBMPO41sKGbqIBkN
X-Gm-Message-State: AOJu0YykrHudlZph89eAfHQ5KNnPPeuGHmQY0K9Xpx/vZbaXHJbKrNLg
	fbIye18QvlttT1IDFjmdRdrhg7V5OO9ktKTt21kPZ9vlO2PLHNVRP0dbhfNAt39nTyJeUJ2gRe0
	kANxbNVevJz9h9KmUHSvvT+285o9q4Dx7a1Oljg==
X-Google-Smtp-Source: AGHT+IF8fdvhkjMS0UY8hcyPiu+B4sAA0WOxxnMU2TNSbNNaNFpFhEVPyi0HzmyJp602or5cL6e3VNKWSVvZjJ4o9U0=
X-Received: by 2002:a17:907:8688:b0:a6f:4d38:f40c with SMTP id
 a640c23a62f3a-a6fab77a60amr271829266b.62.1718848648534; Wed, 19 Jun 2024
 18:57:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZmIyMfRSp9DpU7dF@debian.debian> <CAADnVQKYAf7tZU+gqnDAoOa4THyqdhZtbmSd7DtwpTZyUZi9RQ@mail.gmail.com>
In-Reply-To: <CAADnVQKYAf7tZU+gqnDAoOa4THyqdhZtbmSd7DtwpTZyUZi9RQ@mail.gmail.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Wed, 19 Jun 2024 20:57:17 -0500
Message-ID: <CAO3-Pbo7RnFfqd4ONL9jxRsjFpUnO-VKXNs90qAwMQaa2Ln_OA@mail.gmail.com>
Subject: Re: Ideal way to read FUNC_PROTO in raw tp?
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexei,

Thanks for getting back.

On Fri, Jun 14, 2024 at 8:05=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jun 6, 2024 at 3:03=E2=80=AFPM Yan Zhai <yan@cloudflare.com> wrot=
e:
> >
> > Hi,
> >
> >  I am building a tracing program around workqueue. But I encountered
> > following problem when I try to record a function pointer value from
> > trace_workqueue_execute_end on net-next kernel:
> >
> > ...
> > libbpf: prog 'workqueue_end': BPF program load failed: Permission
> > denied
> > libbpf: prog 'workqueue_end': -- BEGIN PROG LOAD LOG --
> > reg type unsupported for arg#0 function workqueue_end#5
> > 0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
> > ; int BPF_PROG(workqueue_end, struct work_struct *w, work_func_t f)
> > 0: (79) r3 =3D *(u64 *)(r1 +8)
> > func 'workqueue_execute_end' arg1 type FUNC_PROTO is not a struct
> > invalid bpf_context access off=3D8 size=3D8
> > processed 1 insns (limit 1000000) max_states_per_insn 0 total_states 0
> > peak_states 0 mark_read 0
> > -- END PROG LOAD LOG --
> > libbpf: prog 'workqueue_end': failed to load: -13
> > libbpf: failed to load object 'configs/test.bpf.o'
> > Error: failed to load object file
> > Warning: bpftool is now running in libbpf strict mode and has more
> > stringent requirements about BPF programs.
> > If it used to work for this object file but now doesn't, see --legacy
> > option for more details.
> > ...
> >
> > A simple reproducer for me is like:
> > #include "vmlinux.h"
> > #include <bpf/bpf_helpers.h>
> > #include <bpf/bpf_tracing.h>
> >
> > SEC("tp_btf/workqueue_execute_end")
> > int BPF_PROG(workqueue_end, struct work_struct *w, work_func_t f)
> > {
> >         u64 addr =3D (u64) f;
> >         bpf_printk("f is %lu\n", addr);
> >
> >         return 0;
> > }
> >
> > char LICENSE[] SEC("license") =3D "GPL";
> >
> > I would like to use the function address to decode the kernel symbol
> > and track execution of these functions. Replacing raw tp to regular tp
> > solves the problem, but I am wondering if there is any go-to approach
> > to read the pointer value in a raw tp? Doesn't seem to find one in
> > selftests/samples. If not, does it make sense if we allow it in
> > the verifier for tracing programs like the attached patch?
> >
> > Yan
> >
> > ---
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 821063660d9f..5f000ab4c8d0 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -6308,6 +6308,11 @@ bool btf_ctx_access(int off, int size, enum bpf_=
access_type type,
> >                         __btf_name_by_offset(btf, t->name_off),
> >                         btf_type_str(t));
> >                 return false;
> > +       } else if (prog->type =3D=3D BPF_PROG_TYPE_TRACING || prog->typ=
e =3D=3D BPF_PROG_TYPE_RAW_TRACEPOINT) {
> > +               /* allow reading function pointer value from a tracing =
program */
> > +               const struct btf_type *pointed =3D btf_type_by_id(btf, =
t->type);
> > +               if (btf_type_is_func_proto(pointed))
> > +                       return true;
>
> The reason it wasn't supported in tp_btf is to avoid potential
> backward compat issues when the verifier will start to recognize it
> as a proper pointer to a function.
> Since I didn't know what that support would look like I left it
> as an error for now.
>
> 'return true' (which would mean scalar type to the verifier)
> is a bit dangerous and I feel it's better to think it through right away.
>
> Eventually it probably will be a new reg_type PTR_TO_KERN_FUNC or somethi=
ng.
> And it won't be modifiable.
> Like arithmetic won't be allowed.
> Passing into other helpers (like prinkt in your example) is fine.
> But if we do 'return true -> scalar' today then bpf prog
> will be able to do math on it, including conditional jmps,
> which will be disallowed once it becomes PTR_TO_KERN_FUNC.
> And that would become a backward compat issue.
> So pls think it through from that angle.

Having a new reg_type makes sense to me, but IMHO it could still cause
a backward compatibility issue. In my example, the regular version TP
has the func pointer assigned as a void * arg, which I can do
arithmetics already with. So if anyone relies on this fact, then it
may break if we introduce the PTR_TO_KERN_FUNC and replace void * with
a proper kernel function pointer. But if we leave the void * in place,
then TP/Raw-TP have different capabilities on the same argument just
like today. WDYT?

Yan

