Return-Path: <bpf+bounces-53286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C615A4F57C
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 04:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE68A7A2908
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 03:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4241016CD1D;
	Wed,  5 Mar 2025 03:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgfpY7dt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1CF2E3388
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 03:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741146065; cv=none; b=PATm0paeb/LiJoQOZwSMOjIZU4liXbmVm6fBtkvfohkRkbd459WwhAobLzEF8uc6gs2k8HCIvgye/2CTtgKVW9e+iC1RcNNTDdB+pw4v9GVcohnARo01Cw+Vlm2wpkMNpR8BXZvtTqWEWPpV4H+nufzBQKaB9BhakmEOFHKYFFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741146065; c=relaxed/simple;
	bh=OB+CEISQKrcf0z2HAQ7DxBi/sL3BKRuo6vNPrJPdrQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T9jsamsXgw7KR7HeY7r6nnQwRsX5YKAQlJXH55Aj3DFVtH0D+jpBl5Ig/wznk0Wpi/a0X6d8Nlk8qqWKoiiVJOYT/8rf4C1Z0KUIRQFn/d/KfXocGoeOKp05AQYOP7BcXscbzjuj708ou9DijuELhm6ETifKIP1cO6PjheGrJyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgfpY7dt; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso41090595e9.0
        for <bpf@vger.kernel.org>; Tue, 04 Mar 2025 19:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741146062; x=1741750862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9UCiroClVm0WTOeGXBp8siexvPBjixwAS8Oln6qojk=;
        b=OgfpY7dthP5SlsdRnuTbnKNiYAELwpnLBr1DCghOY4GhWRkKq14lqndxyOUyANriJy
         /wcQItlVVtXfYM0kkm+zgEsfIv8pBiMQiYloRcRylgUroP2yHK0StT06E3HQFQzrfcAw
         s5cPy18e03Co1XGjjEKeIAvwAPT1KFe1AJqw3ZY9XH2znst2HW+q6WExQK3TxSRnyneJ
         XjrlGdj9GTEpP/GUMSX8F58sSQ7kdFN77+/o97SOauQOlFIy1Mfjw7PU0SSa9lbo76Ej
         mrGfeso2nY8GhXjFBI8DG6oHCsAPcUxHs/bSwoednGxJEBOq5n3AwCxLh4UjKEER7m8a
         XWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741146062; x=1741750862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P9UCiroClVm0WTOeGXBp8siexvPBjixwAS8Oln6qojk=;
        b=br7hKesKL6vPAUcpkzUbm2A80n9UrxxSQt2QBu74CqW0LZWJiJbDmdaAB1fW/ZKCYa
         iR76v3zblAvPWm05oZSo0DEXvaaSkcyXucGOrzuKTdxia6AmHGmEHQT5UTGHWp2pQtKR
         0tHbeUK302MtPUjIuzDreLensDJz0JP2zbjXXNaCgFeMuItWlh+1RqNPM8UDAl/tvsUK
         DPItejyEoWVU5FIT5MjoZggUDppA3azDOafysAd0bf+rBFUyF0bwyQJLxNLPO1uukK+g
         8Uk5efpS2jADFKQZ3m/uyg3Zrnsd8gWe2zIM0pfUBl9elAgfY9OZzzzkDiswotnlfCxL
         PJCw==
X-Gm-Message-State: AOJu0YzxSM3a9cAu1hajHC+NVil/gwP+KGA2FaSmD1TGy8uolfRnaEOY
	wdV2ThSXPouOhKPZKJKTec0PGmhDVbgzCUL2Zvs9Ed4w26F3HMgSxLJiuzPnDkiFogFVW6Wu076
	E4QLEFMKGJFnwNGlNdWJRmb6FAIk=
X-Gm-Gg: ASbGnctI8U0BYlvsmNBm5Lzla6mZ0obQSzV/MjmbNKjwDdAWfBxBdm6N2PvzucCpmQs
	yXAxLw/E7azDObSHyDxafSCXgEOUf/EW/10OB8eEWbiCsQfAaBUcBpGnflxV5qQBDXZNUyomZcZ
	27hqShJhybbc8u9u/y3grOR5+97Sp1IZQbFHvHz179eA==
X-Google-Smtp-Source: AGHT+IFicduKp05YxGVwYAKwf7oZIsvi4YLX6I1wjfrbSKn84ckLs+0lT2zhlIad9L0LuYFnwbsssYOfnX1evo4zdrk=
X-Received: by 2002:a05:6000:2ac:b0:38d:e48b:1766 with SMTP id
 ffacd0b85a97d-3911f726200mr670473f8f.6.1741146062246; Tue, 04 Mar 2025
 19:41:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305011849.1168917-1-memxor@gmail.com> <20250305011849.1168917-3-memxor@gmail.com>
 <CAADnVQJQd9Lof1Qj4DWn0aFdY079gjcOsKo6XBBMKwnjXdw7eQ@mail.gmail.com> <CAP01T76LFhRogiSiPQ73pcYpt4TXfty0HLqg52L7dtz30Ono5A@mail.gmail.com>
In-Reply-To: <CAP01T76LFhRogiSiPQ73pcYpt4TXfty0HLqg52L7dtz30Ono5A@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 4 Mar 2025 19:40:51 -0800
X-Gm-Features: AQ5f1JoeHPiXcdrgXGJL1fEUNiwAqsEnnzjn3XPqi33D1xdEKO3oeLlYeGlT-_0
Message-ID: <CAADnVQ+QV=SQsgTDpRcsh=V8AHkirt4G3D3N2b-5oK=w-PMXdQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: Introduce arena spin lock
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>, 
	Dohyun Kim <dohyunkim@google.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 7:15=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> > which is doing:
> > __unqual_typeof(*(p)) VAL;
> > (__unqual_typeof(*(p)))READ_ONCE(*__ptr);
> >
> > and llvm will insert cast_kern() there,
>
> Yes, I do see a r1 =3D addr_space_cast(r2, 0x0, 0x1).
> r2 is node->next loaded from arena pointer 'node'.
>
> But I can't understand why that's a problem.
>
> If I do
> for (;;) {
>   next =3D READ_ONCE(node->next);
>   if (next)
>      break;
>   cond_break_label(...);
> }
>
> instead of the macro, everything works ok.

because the above doesn't have addr space casts.

> But that's because LLVM didn't insert a cast, and the verifier sees
> next as a scalar.
> So if next is 0x100000000000, it will see 0x100000000000.
> With cast_kern it only sees 0.

right.

> It will probably be casted once we try to write to next->locked later on.

not quite.
In a typical program llvm will emit bare minimum cast_user,
because all pointers are full 64-bit valid user space addresses all the tim=
e.
The cast_kern() is needed for read/write through the pointer
if it's not a kernel pointer yet.
See list_add_head() in bpf_arena_list.h that has
a bunch of explicit cast_kern/user (with llvm there will be a fraction
of them), but they illustrate the idea:
        cast_user(first);
        cast_kern(n); // before writing into 'n' it has to be 'kern'
        WRITE_ONCE(n->next, first); // first has to be full 64-bit
        cast_kern(first); // ignore this one :) it's my mistake.
should be after 'if'
        if (first) {
                tmp =3D &n->next;
                cast_user(tmp);
                WRITE_ONCE(first->pprev, tmp);
        }
        cast_user(n);
        WRITE_ONCE(h->first, n);

> I would gather there's a lot of other cases where someone dereferences
> before doing some pointer equality comparison.
> In that case we might end up in the same situation.
> ptr =3D load_from_arena;
> x =3D ptr->xyz;
> if (ptr =3D=3D ptr2) { ... }

There shouldn't be any issues here.
The 'load from arena' will return full 64-bit and they should
be stored as full 64-bit in memory.
ptr->xyz (assuming xyz is another pointer) will read full 64-bit too.

> The extra cast_kern is certainly causing this to surface, but I am not
> sure whether it's something to fix in the macro.

I think it's a macro issue due to casting addr space off.

> > so if (VAL) always sees upper 32-bit as zero.
> >
> > So I suspect it's not a zero page issue.
> >
>
> When I bpf_printk the node address of the qnode of CPU 0, it is
> 0x100000000000 i.e. user_vm_start. This is the pointer that's misdetected=
.
> So it appears to be on the first page.

yes and looks the addr passed into printk is correct full 64-bit
as it should be.
So this part:
  return &qnodes[cpu + 1][idx].mcs;
is fine.
It's full 64-bit.
  &((struct arena_qnode __arena *)base + idx)->mcs;
is also ok.

There are no addr space casts there.
But the macro is problematic.

