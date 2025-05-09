Return-Path: <bpf+bounces-57955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C168AB1F98
	for <lists+bpf@lfdr.de>; Sat, 10 May 2025 00:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BE541BC59C2
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 22:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50E52627E9;
	Fri,  9 May 2025 22:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+rmF36H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05199261565
	for <bpf@vger.kernel.org>; Fri,  9 May 2025 22:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746828215; cv=none; b=MJYCtybDCypWiw2IGioXl9EFrkhpiv/PCC/Iony2B2cRI8yoryD3kSoJSCxllP5uWa/rVBVniYo/LBHoKNp+iYMweFYuIBG9S+JO7wNvcRNG/XwLs273n+1rBeBkF5z6VsPUHcw/6jPCNZehKrVsSVSWPK27Pv+K76DsWxwzLcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746828215; c=relaxed/simple;
	bh=hJvrFYBdmWh4E2OFtMJiwMki1FxUo10Np7XN3tIkx0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=efu7vIv+e/dOg3I6jc/WbCEwiVZEC/vLuuwVopUYGN7fTlQdo9YFlHgYsJuEHc7vbgGaQcen3idkZyIVqBe07WIlof6plaatmusEBr23h6I6amE2KHhOdZOMqbtiID/QfU1ASwhIU4kn3/kgxOsQPQSRavgxRBt3pxkRXgAaxwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+rmF36H; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-30abb2d5663so2606886a91.2
        for <bpf@vger.kernel.org>; Fri, 09 May 2025 15:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746828213; x=1747433013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kz3hQGV7x6Le6c6/fbD4qBI1drjAWVolCYFahCQlzxE=;
        b=Y+rmF36HbDG+S+sg+CrzumPpM5/2nvHOP42Faa7qJPKnkh4QndXXRgy83iRfjEKg3Q
         KfG9cKsjkSYUXQ6lHtMfJsuRqqLP0CfUhD0vlNXTBLfu3qB2v5zgdMG6OhEdQi05vThg
         zZHJa9dECq0OiLqFSXLxFQMH9/hbIW3wT0mmR1uppFMQFgaq5FTwp/grfZA0TJZbCghQ
         7ahjz525i7Au7RChGas4CLnoSJh2n50ieMndx6SSs8W+ILwdTJJQaAlLkr6ZGQKdn6gj
         /QOjKpSaDewHFBc6i5iXkQFgrAO40YGMzKeziQ8LbVLIqo0m07rBmxOCyGmQpWCn/iBs
         4GUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746828213; x=1747433013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kz3hQGV7x6Le6c6/fbD4qBI1drjAWVolCYFahCQlzxE=;
        b=YzfetV0g6pc4M16U4SEMQDnCrgZcdpCmPVShXd9ly7dOnOtT+bgJIyeq9yEUrpvUBo
         vFtzQkt9v3AB2C4pY4BPlGbdK1/b0OfN4jiopTmMS8KA2rDBwyrKG2++vdC/WjCcBfDn
         e20oD79GEv6Ydtj82/3sCt1oUEM9WYaLD9R+i/G/rLLWY7HjI5GhkcyVoCIV119Z1laM
         QVMAmdVJlUEuBzXE5aCF/GnwmNSlgAE4M6XwQN51o8RBRrIH1bKmSt6LuTSslubVsl54
         wv9jUk1lpd7SX89lzbwQBEGOK7HiZNXNi2oBQ5znEtH4ZjH339YKMEm9l0x+leyLO5ch
         rb4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWHcuxAF/ztl7uTOnM4Xbu2dD5lw50vQca3QtgmQkQmPMT3Aj5/xgnAa74NB588lEfVOGI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8Z0O3foI79vd0HsiZex4z+bdCmtBYdL8hxEux0kRpRjfm88lv
	6VqJoVmwfuWJ9HqfHve5yiGMlM2HbDIrOuPTypVeuKYUE6vcpp7RGphOaSOJ0VPLgZ+izXhoWdo
	Tb5uMu1K0sPpuyx4yBNJVeAwH+ws=
X-Gm-Gg: ASbGncuI8Lut2I5QEWsUeg5BsrCl8nlXZMl/ZfXUSdT3I+pIa2DxWLXnXGsKer0NJVH
	3zuhLgrMaq90FJ6hrq2FxaOCOGhuZGaOl5EJPdJIqPvux7+sl0cH61uSlzHK5IgrhdSp9+7TRNL
	tuF1/7YGoN0HkYIrbPxjVmnCnuwlP0SmV6kOKMJ91bVkNSiDeD
X-Google-Smtp-Source: AGHT+IFDGJCnVgnWRhJmrPbVrPp27CEia13lG4yBkY8FKbXDKqPVQ/znqQcIbEA7u7qfo83F6MThuTEM9/RX4NkcwJ8=
X-Received: by 2002:a17:90b:4acb:b0:2fe:b470:dde4 with SMTP id
 98e67ed59e1d1-30c3cff34fbmr9504231a91.12.1746828213081; Fri, 09 May 2025
 15:03:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1746598898.git.vmalik@redhat.com> <19913411da8c08170d959207e28262efc0a5d813.1746598898.git.vmalik@redhat.com>
 <CAEf4BzZBB3rD0gfxq3ZC0_RuBjXHBMqdXxw3DcEyuYhmh7n5HA@mail.gmail.com> <e1bb9c33b8852e1d3575f7cefe50aca266a8ff2b.camel@gmail.com>
In-Reply-To: <e1bb9c33b8852e1d3575f7cefe50aca266a8ff2b.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 May 2025 15:03:20 -0700
X-Gm-Features: ATxdqUE_JHRNdOmFHSYYdsqF27X1r1LRTylbU6hkbhCbdbrCAHZcIsUR2LAwVU8
Message-ID: <CAEf4BzZ5x2JGcnZftf1KRiBziaz_On_mMtW77ArvnOyFNWh==Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/4] bpf: Add kfuncs for read-only string operations
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Viktor Malik <vmalik@redhat.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 2:37=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Fri, 2025-05-09 at 11:20 -0700, Andrii Nakryiko wrote:
>
> [...]
>
> > > +/**
> > > + * bpf_strchr - Find the first occurrence of a character in a string
> > > + * @s: The string to be searched
> > > + * @c: The character to search for
> > > + *
> > > + * Note that the %NUL-terminator is considered part of the string, a=
nd can
> > > + * be searched for.
> > > + *
> > > + * Return:
> > > + * * const char * - Pointer to the first occurrence of @c within @s
> > > + * * %NULL        - @c not found in @s
> > > + * * %-EFAULT     - Cannot read @s
> > > + * * %-E2BIG      - @s too large
> > > + */
> > > +__bpf_kfunc const char *bpf_strchr(const char *s, char c)
> >
> > so let's say we found the character, we return a pointer to it, and
> > that memory goes away (because we never owned it, so we don't really
> > know what and when will happen with it). Question, will verifier allow
> > BPF program to dereference this pointer? If yes, that's a problem. But
> > if not, then I'm not sure there is much point in returning a pointer.
> >
> >
> > I'm just trying to imply that in BPF world integer-based APIs work
> > better/safer, overall? For strings, we can switch any
> > pointer-returning API to position-returning (or negative error) API
> > and it would more or less naturally fit into BPF API surface, no?
>
> Integer based API solves the problem with memory access but is not
> really ergonomic. W/o special logic in verifier the returned int would
> be unbounded, hence the user would have to compare it with string
> length before using.
>
> It looks like some verifier logic is necessary regardless of API being
> integer or pointer based. In any case verifier needs additional rules
> for each pointer type to adjust bounds on the return value or its refobj_=
id.
>

You can't safely dereference any pointer returned from these APIs,
because the memory might not be there anymore.

For integers, same idea. If you use bpf_probe_read_{kernel,user} to
read data, then verifier doesn't care about the value of integer.

But that's not ergonomic, so in some other thread few days ago I was
proposing that we should add an untyped counterpart to bpf_core_cast()
that would just make any memory accesses performed using
__get_kernel_nofault() semantics. And so then:


const char *str =3D <random value or we got it from somewhere untrusted>;
int space_idx =3D bpf_strchr(str, ' ');
if (space_idx < 0)
  return -1; /* bad luck */

const char *s =3D bpf_mem_cast(str);
char buf[64] =3D {};

bpf_for(i, 0, space_idx)
    buf[i] =3D s[i]; /* MAGIC */

bpf_printk("STUFF BEFORE SPACE: %s", buf);


Tbh, when dealing with libc string APIs, I still very frequently
convert resulting pointers into indices, so I don't think it's
actually an API regression to have index-based string APIs

