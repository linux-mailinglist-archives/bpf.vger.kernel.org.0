Return-Path: <bpf+bounces-40701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B90BC98C4A9
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 19:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 430C428722D
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 17:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378B31CCB37;
	Tue,  1 Oct 2024 17:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qjcvd3pX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C561CC166
	for <bpf@vger.kernel.org>; Tue,  1 Oct 2024 17:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727804083; cv=none; b=r3anFIqVC1tvNshWISKZoEx7lO4XMvpobj1bIeV7QDiCury1CNjGQ1lmT4egud5+i94NUdPbioxoxkC9hGVd9aWMB1w6wOb4/VoYDOtokoXPIBzzf89gky8kgE5I5SRMmVhbWBWIIIY96puHNTwvL58g6cAM01x5yL0iM1AnUPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727804083; c=relaxed/simple;
	bh=dfyUgvYsBlMlepL8zUYMCeFfi+O1o0TGmfKFoYtm+q8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HaaUuao9nqdY2RkCKdwC63Au2yuZQfOOw9a93jnS15qSikT4/UJO1tRA7yEnbjNgMKmELBsCq72zfWcu1UnhbdI2lyACGUkhQLXh1hivbMinKFt2Z4RDIblQODiYTcRQ7Z2cPt8ynIB5pep5UgkRO2j7Ck47ms9qGD4eHWnFHyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qjcvd3pX; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42e5e1e6d37so52986935e9.3
        for <bpf@vger.kernel.org>; Tue, 01 Oct 2024 10:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727804080; x=1728408880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uu6FFtG08Ci5mppKxPwjOAH+LB240opie6ckmBqL8ck=;
        b=Qjcvd3pX3sAngLnEriEIUUrvhNFODoBRjA4qGN5/VJQyv7Xutcwssx45/7IghivLRV
         16yu+s0x/8wtTOWuzVi/PkEJNY5w63MUdrXH/6/LnhWmSyxp/mVUq87Qx5KGGrbioGMJ
         ZMkVTdgQhAeCzEZyHHeuhieHo7S4o9hZYdh+5izJDLFnruaIdUrkQAMJ7w6s23XRqpwB
         R/U/p5jFv1JDakWks4LtRbuQIphCwmJTq/QEN2P2Wq4Xi8x1jcOylvPq9wPvFbjOnJo3
         9Q7IqH39x2jor7aab5s2PWy3yIydwdfseG9wv1+98QtavvXFHGOICBXeIj7tKvlql9AC
         jzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727804080; x=1728408880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uu6FFtG08Ci5mppKxPwjOAH+LB240opie6ckmBqL8ck=;
        b=AD6RucRCFEmfxIrP1+uYKpvlUScwdkDQKNpFgSE1nKaOxfuk8AY5d6hPtDMfFSAze2
         qOfrOCTLvM5b1s/8ppAiJDKqkBKqWLFxENZXOHRkngDt2G/E477Q8FKScDzLmiqrshcd
         g3wR90o3oZ0fijLCRAFJdjZD0WtZm0wNoiHI+YqIEw2RHyxdh/+uRB8TDyqePaLTbxLi
         1jCe5xxlTnY0UE9XAp2zMHTm5ScnvQfv3FMtM+cKdzBxwbsWyylTdHiES/19a/AjIotY
         t7VPI8FJcnIOxSXLlwRvVj7nviy3bs7SIxBMKYDjBsQKKiVqUk/zOj06HKw2m9x3IkP+
         sjrg==
X-Forwarded-Encrypted: i=1; AJvYcCVY/ptF64RZwfXyk3iVMOFzOEsryzgb4fOoIokjC05Cf6Oc0IvfPIkzRvM18i12Ew/U9/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4k835ZEUy1fOjqbNf8lQKtHjEs4ef8E2XCevY/6dLKHGfwr7m
	5WxpR5tm3gidn+6HCvJjcb1eZLqF9ad6PDVgXUzGKdw2VLASGlnBMbGBY/3ScfNkfwQsJ0K+Q2G
	lP/8RREfoH385Ae/pJreQNKAO/ls=
X-Google-Smtp-Source: AGHT+IGX1wLp00wn39clAUW/X1hCyR5idEwRwj98z3xb4i5umkRWG4IWrisqg6fMYDpvEwYqvW8I6qIkM03B/AX5kr0=
X-Received: by 2002:a05:600c:5253:b0:42c:ae4e:a990 with SMTP id
 5b1f17b1804b1-42f778ffcaamr1686685e9.35.1727804080098; Tue, 01 Oct 2024
 10:34:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727329823.git.vmalik@redhat.com> <bc06e1f4bef09ba3d431d7a7236303746a7adb57.1727329823.git.vmalik@redhat.com>
 <CAEf4Bzas4ZxiyJp7h7N5OGmPSMRfZDgPUgEAdTmir3n-4cx-xg@mail.gmail.com>
 <adaa47618f2b71c2803195749cedd4a5b468cffa.camel@gmail.com>
 <CAADnVQLCk+VNpN8WfCbSbT-FBcHBuMXpk-hBOLB7HX3BrURp8w@mail.gmail.com> <CAEf4BzZSFuXyUbwN8_VvbR6Uk_qHAKWNLkCZfdo-58WC_RYYag@mail.gmail.com>
In-Reply-To: <CAEf4BzZSFuXyUbwN8_VvbR6Uk_qHAKWNLkCZfdo-58WC_RYYag@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 1 Oct 2024 10:34:28 -0700
Message-ID: <CAADnVQLsnhsL2i_RnOBUSebO--yx_5Az1Ydr9QPb5WZCkmYQJg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add kfuncs for read-only string operations
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Viktor Malik <vmalik@redhat.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 10:04=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Oct 1, 2024 at 7:48=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Oct 1, 2024 at 4:26=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> > >
> > > On Mon, 2024-09-30 at 15:00 -0700, Andrii Nakryiko wrote:
> > >
> > > [...]
> > >
> > > > Right now, the only way to pass dynamically sized anything is throu=
gh
> > > > dynptr, AFAIU.
> > >
> > > But we do have 'is_kfunc_arg_mem_size()' that checks for __sz suffix,
> > > e.g. used for bpf_copy_from_user_str():
> > >
> > > /**
> > >  * bpf_copy_from_user_str() - Copy a string from an unsafe user addre=
ss
> > >  * @dst:             Destination address, in kernel space.  This buff=
er must be
> > >  *                   at least @dst__sz bytes long.
> > >  * @dst__sz:         Maximum number of bytes to copy, includes the tr=
ailing NUL.
> > >  * ...
> > >  */
> > > __bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__sz, const =
void __user *unsafe_ptr__ign, u64 flags)
> > >
> > > However, this suffix won't work for strnstr because of the arguments =
order.
> >
> > Stating the obvious... we don't need to keep the order exactly the same=
.
> >
> > Regarding all of these kfuncs... as Andrii pointed out 'const char *s'
> > means that the verifier will check that 's' points to a valid byte.
> > I think we can do a hybrid static + dynamic safety scheme here.
> > All of the kfunc signatures can stay the same, but we'd have to
> > open code all string helpers with __get_kernel_nofault() instead of
> > direct memory access.
> > Since the first byte is guaranteed to be valid by the verifier
> > we only need to make sure that the s+N bytes won't cause page faults
>
> You mean to just check that s[N-1] can be read? Given a large enough
> N, couldn't it be that some page between s[0] and s[N-1] still can be
> unmapped, defeating this check?

Just checking s[0] and s[N-1] is not enough, obviously, and especially,
since the logic won't know where nul byte is, so N is unknown.
I meant to that all of str* kfuncs will be reading all bytes
via __get_kernel_nofault() until they find \0.
It can be optimized to 8 byte access.
The open coding (aka copy-paste) is unfortunate, of course.

