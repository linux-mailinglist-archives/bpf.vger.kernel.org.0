Return-Path: <bpf+bounces-53287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0572A4F611
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 05:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 002EC3AA121
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 04:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271A01C6FE2;
	Wed,  5 Mar 2025 04:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hN33eBPf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0419611185
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 04:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741148953; cv=none; b=j5k4udcSPtzxRGFKjcGubm7Da70SjdHFiyWzKvqWWw9BwIvEyK1LCD/YlVsZIT3nCR08V3qewjqnEggG5jkcOKjRpCvuMBe3kini0RkdCkA49YA/wNrwfgKW5Mi0oOgJE+T/memlxJlBgPpm9huv+XRIF+plXgKHz4DAOlFHbms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741148953; c=relaxed/simple;
	bh=sxDYvsbL6lrzzQEy1IoAZ24lwrQwfG2C7ZJ+e2P8XiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uTYz0NJhRl5uWiPSrAGleRmSBtmRveRx7T/OWW5Jr5q7rr0chZhKaC+eRNwYV+ntXPdetrAsJAuLanErH31NjhBPMTHT1LPEO6Ijq+IdcsAXJeKa8ZTSuqIGLYv3HGx4kvL4B5bIBuCM6AQ1fpx6vFGOWP37Wdx8Cp1LAuKkVd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hN33eBPf; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-abf518748cbso701952066b.2
        for <bpf@vger.kernel.org>; Tue, 04 Mar 2025 20:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741148950; x=1741753750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5jeOzRyoOqdcyjx3tkw3kiYlhPMGsl2571q22Q3TXg=;
        b=hN33eBPfV4cQMimeBCewOUSWeN5QahZEvVGgPYNhcXwM6SbpiWGbD4BbdU/yjsXbRz
         bdBTz8Qe91ru2ydpgqhBbBRlNKHl3+GqqWJ4yP9Kd9zX0JSvnPFCi8ek45CWXnmSZoUl
         lKBK7WjnjLIWTcSHth36IcnvJZikWibaQdkeRvtD0+q3Z2WPpDmF76KcTMbHxa8VDQK2
         LfdJvle9euc3oYN/sAGnidpwTNweursMhGNr2aoL+z6GFB5QKOPa7X902/jqRqkKug8p
         3CUmEQU/uTx9mcOJKkxwfpdGOot6/m6PYcDqTamGIRoP40It6+h2z6mgguoy49oW9Y6j
         HcUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741148950; x=1741753750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f5jeOzRyoOqdcyjx3tkw3kiYlhPMGsl2571q22Q3TXg=;
        b=Q5Cnxv3vLlMp7syO4cfY6t+mn5G+1dwpyi4w4VfFtoC3QacIn3KINT7g/tnt97Xh96
         1monft2H+zNGICFydICqSDJ31TtsppAQtqHW8QOTXXkZ6AMuf46WYX2UQ/mCRIFNoj0O
         l0C9KGnERiu/jIYBvC1KZJN0FYuLGZz8DaVjNpytIXIl8Pbu038B+48QJgDyKt4iHV+Q
         yoIpPBsfZuSOTAqpT3ImZOhZM/k53E2VErjs0z7sHVxyrSfH1cgsxCPV9DuAmyfcRvUL
         pAlgp31pRV2vQqpC+CsXh4dYnGzmuTygFnRqFZME2mBv/De05lA+WVwrFWXustKrwSfj
         dOnw==
X-Gm-Message-State: AOJu0YwgxM7LGnYHHCz28/7A2vyUtIXDI8o/NGf0wLcsE4Jjlg9XSfie
	HFoIwmTlKnvVgwT3qcxgjGI7WjiwJAr0DK+pDazqPvlCiKt/MnLlJlrCD8AADB8CYjjg5tBi5gD
	Vh0wZx6W1PxdwsFUP3Bsl12gf8hc=
X-Gm-Gg: ASbGncsdr7NYLat8RXd8rb72Xo0FYrCdm+ulsaGCKkh5uAYQeVG/TjuSPNalFEoenVX
	vV1nUgQb/FcaTvURf3Jl/m8MPmpMEtDkQA36baVmokDFasjqCTSVEyj+fx8IWXC+BoQoxdGTW3D
	9btf7v/tr1KncBxwUGChBbLclMqS/iUqfKuHTzm0weSMGEeOc=
X-Google-Smtp-Source: AGHT+IGE5Akac+9z7jMZo+xh1I2dDSlqESCM83JX+OV074CJjiqNWFf+O5OVLo0d9JGiIHu3bLK1BU4KKugIp3Jv5Qs=
X-Received: by 2002:a17:906:6a0a:b0:abf:7a80:1a7b with SMTP id
 a640c23a62f3a-ac20d842a46mr154235866b.11.1741148949902; Tue, 04 Mar 2025
 20:29:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305011849.1168917-1-memxor@gmail.com> <20250305011849.1168917-3-memxor@gmail.com>
 <CAADnVQJQd9Lof1Qj4DWn0aFdY079gjcOsKo6XBBMKwnjXdw7eQ@mail.gmail.com>
 <CAP01T76LFhRogiSiPQ73pcYpt4TXfty0HLqg52L7dtz30Ono5A@mail.gmail.com> <CAADnVQ+QV=SQsgTDpRcsh=V8AHkirt4G3D3N2b-5oK=w-PMXdQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+QV=SQsgTDpRcsh=V8AHkirt4G3D3N2b-5oK=w-PMXdQ@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 5 Mar 2025 05:28:33 +0100
X-Gm-Features: AQ5f1Jq-DqnKsf6vKlJfr-C3ZoHKwrWNaR2mCfuDXfCEfz--QmARX811WgPIRWk
Message-ID: <CAP01T77GFjuupAA0thhuj5SppStE_bNXLRBmH8S5_KvifMrgbA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: Introduce arena spin lock
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>, 
	Dohyun Kim <dohyunkim@google.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 5 Mar 2025 at 04:41, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Mar 4, 2025 at 7:15=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@gm=
ail.com> wrote:
> >
> > > which is doing:
> > > __unqual_typeof(*(p)) VAL;
> > > (__unqual_typeof(*(p)))READ_ONCE(*__ptr);
> > >
> > > and llvm will insert cast_kern() there,
> >
> > Yes, I do see a r1 =3D addr_space_cast(r2, 0x0, 0x1).
> > r2 is node->next loaded from arena pointer 'node'.
> >
> > But I can't understand why that's a problem.
> >
> > If I do
> > for (;;) {
> >   next =3D READ_ONCE(node->next);
> >   if (next)
> >      break;
> >   cond_break_label(...);
> > }
> >
> > instead of the macro, everything works ok.
>
> because the above doesn't have addr space casts.
>
> > But that's because LLVM didn't insert a cast, and the verifier sees
> > next as a scalar.
> > So if next is 0x100000000000, it will see 0x100000000000.
> > With cast_kern it only sees 0.
>
> right.
>
> > It will probably be casted once we try to write to next->locked later o=
n.
>
> not quite.
> In a typical program llvm will emit bare minimum cast_user,
> because all pointers are full 64-bit valid user space addresses all the t=
ime.
> The cast_kern() is needed for read/write through the pointer
> if it's not a kernel pointer yet.
> See list_add_head() in bpf_arena_list.h that has
> a bunch of explicit cast_kern/user (with llvm there will be a fraction
> of them), but they illustrate the idea:
>         cast_user(first);
>         cast_kern(n); // before writing into 'n' it has to be 'kern'
>         WRITE_ONCE(n->next, first); // first has to be full 64-bit
>         cast_kern(first); // ignore this one :) it's my mistake.
> should be after 'if'
>         if (first) {
>                 tmp =3D &n->next;
>                 cast_user(tmp);
>                 WRITE_ONCE(first->pprev, tmp);
>         }
>         cast_user(n);
>         WRITE_ONCE(h->first, n);
>
> > I would gather there's a lot of other cases where someone dereferences
> > before doing some pointer equality comparison.
> > In that case we might end up in the same situation.
> > ptr =3D load_from_arena;
> > x =3D ptr->xyz;
> > if (ptr =3D=3D ptr2) { ... }
>
> There shouldn't be any issues here.
> The 'load from arena' will return full 64-bit and they should
> be stored as full 64-bit in memory.
> ptr->xyz (assuming xyz is another pointer) will read full 64-bit too.
>
> > The extra cast_kern is certainly causing this to surface, but I am not
> > sure whether it's something to fix in the macro.
>
> I think it's a macro issue due to casting addr space off.
>
> > > so if (VAL) always sees upper 32-bit as zero.
> > >
> > > So I suspect it's not a zero page issue.
> > >
> >
> > When I bpf_printk the node address of the qnode of CPU 0, it is
> > 0x100000000000 i.e. user_vm_start. This is the pointer that's misdetect=
ed.
> > So it appears to be on the first page.
>
> yes and looks the addr passed into printk is correct full 64-bit
> as it should be.
> So this part:
>   return &qnodes[cpu + 1][idx].mcs;
> is fine.
> It's full 64-bit.
>   &((struct arena_qnode __arena *)base + idx)->mcs;
> is also ok.
>
> There are no addr space casts there.
> But the macro is problematic.

Ok, makes sense. Pointer values should always be the full 64-bit equivalent=
.
I fixed up unqual_typeof to not cause the extra cast, as it won't be
necessary in case of pointers anyway.

