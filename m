Return-Path: <bpf+bounces-54504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA49AA6B184
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 00:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4637F17EC5B
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 23:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A854229B2C;
	Thu, 20 Mar 2025 23:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBRO045p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DBF1F5F6;
	Thu, 20 Mar 2025 23:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742512689; cv=none; b=gXcME0HuBsOssK9Fxvl98Y9yMvmB8p/3NVjO+fMcE5PfyMcJ6v0v6cQbSlV9oHZjxCj69WF7wr/ibv4qTSCrkDviqv62S9kiJMuOCu02SQxPRXGzyRMELSrBmMicRdKPp1LFfkYWIrwe1K1EsSxUvV863w/yUXT7fOZhysEpQqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742512689; c=relaxed/simple;
	bh=Shct0J1ZfLdiyYTPiJs/NDiX5WgQ987PjZ8Sz0X5RvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lsUYRb6cNn4n3sbOZUSppDRM3N+rrQCtPdZsvsLa8ocIMsyuaujZNGCIj7Fdfw3GA1vvU0hrxxc6P7EE5PAKO/ZcUBlcdx3Dl2tz31ul6HmENi5zCSlPr4buteJS1QvPutz1w2yUr4YmlDa6y4r3f0oreJ9VhL0UbcOWT9QfwEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBRO045p; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cfdc2c8c9so8291195e9.2;
        Thu, 20 Mar 2025 16:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742512686; x=1743117486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DeQb6JD+b4uxVzrEwo0wfvjSmHJVE4hCfjBEIgdDhpo=;
        b=mBRO045p6hg6GFiuvm89fhmlENsTMK/E7H6TvTl6tOer6M0RbWAVHnxK0ml1FW2/bF
         aCvNVK6ffHkPXLC6rtpBIus6iS6ZevRboeJcUDfETH0lypMgCILj2ntKI1T6/Hl5ciqA
         cKjckBC44DPcdQmo9ObgMwPul5qxtZdm9Ubm5q7bXrWrjgQWl9JvUraO3hQGQ7Za4BSj
         zf7+cGOy3SWg4M2aQ2ueBASbSK7hWN69MLaDJTbyaV/h2HDcIMTZ7uX09V7frnVlt0rx
         MqqNqA1IDCcg1R0Wj7C/D2l0g8u4PQwtnqh8bpcOOVp+ifEOSbPbkNoOAVdwmehddURn
         stsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742512686; x=1743117486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DeQb6JD+b4uxVzrEwo0wfvjSmHJVE4hCfjBEIgdDhpo=;
        b=awZVgQ1gNJuyDfja1ucYeSXTKRUOC1Bv+kRvXs63Cn0PbvdiXYp93zCylMfs9aD6cN
         ySP3wD3QScft2/bp77m+nbvm4bRBJtZKoFFShP9L1XFQmtt4J5XuPpi9jpn1rJuBUAdD
         kFgskhLSWKRyy7bTGDBaWfCbo3oFZv4ilZpDww7aTvR25wUIclSE32mBg2dCi8r4qvgm
         VoyftGudYSTSPdz6scmAesaIqAACwCiiqc0ZVdqB0AnLSFAc9tX3JmjDaX0l2hdk7CjY
         vqbemcSLbsuxXprV5kKTQwK198riRoj1ugCI6PzWPtDQGWbAakhgeSW//TZzkS5MYbE4
         GYGg==
X-Forwarded-Encrypted: i=1; AJvYcCU8t7se4ZUeGUmPsaPUhk1NYNX7F8QtKbXCHHT9uwvAZOXrrNb78A1xhzPWiPE4DV1H6WE=@vger.kernel.org, AJvYcCV5vmodkSlbCtD/TRGqKV4gNPBoW8kLQuRKAmkqjrCj/FQ28ZKm3jI31B5fT7e4wWFvIiigdQnS08czeg==@vger.kernel.org, AJvYcCVn7X1q7GFzlY9BrAUKPOAVFmptbQ6TefevDvto23R5LM3gjCc0O/IPk++gKV/4tlW+ZEsgQQg7@vger.kernel.org, AJvYcCVtoV9XmwtcS66JHDB4208PBXUmez48rs6bmJUdxRiYutlSgSSPa+HgQ8/4c13n99oCZQRVymre8y0zqHCN@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3tPGm6gIHECbm1mwkW8DU3n4H+G/c7i89xhN5c1aKnq3E0wwR
	4JHuMb0HBFj8KHeBRubauSsDKsVI0ZQon62Q6mbuWutjS4Wvi0gPWBy0N7EcJOBOkoy8FQLI3tR
	ie54pYOgv4+ojS8lwVfHyuO0Cxz4=
X-Gm-Gg: ASbGncuL7lp3IhUB/31WY6XRX2ZepNiWrMCGwHV1vEAdhM4E9jigZkSXq4AQ02byo3U
	ZhfklMbbQoIBKA0LC0glk0lZ9dCnZkZG5slkjqbz6oioH5Wi76D+cv1vgXOrZI239/DRj6RnPjO
	vjIZYIQxW4HeUmE/Irpg5O/smgZuoJNk991JKY4aOqPqAzmW9Z4Hm9YMUTFw==
X-Google-Smtp-Source: AGHT+IFO9Zrkw1uCcybgYfUsNWbsOgMRahB84uq7DpwdoQTVjaz+k8iO2DulmaUISDMPlEsjobMJV3tr1Ilr4HheGEA=
X-Received: by 2002:a05:600c:468a:b0:43c:fe15:41d4 with SMTP id
 5b1f17b1804b1-43d509f4d2fmr8630675e9.18.1742512685640; Thu, 20 Mar 2025
 16:18:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319133309.6fce6404@canb.auug.org.au> <CAADnVQKotSrp8CkVpFw-y800NJ_R7An-iw-twrQZaOdYUeRtqQ@mail.gmail.com>
 <CAP01T76CqOxzEiMLKJ2y_YD=qDgWq+Fq5Zy-fnKP4AAyS30Dwg@mail.gmail.com>
 <CAP01T77_qMiMmyeyizud=-sbBH5q1jvY_Jkj-QLZqM1zh0a2hg@mail.gmail.com>
 <CAP01T77St7cpkvJ7w+5d3Ji-ULdz04QhZDxQWdNSBX9W7vXJCw@mail.gmail.com>
 <CAADnVQ+8apdQtyvMO=SKXCE_HWpQEo3CaTUwd39ekYEj-D4TQA@mail.gmail.com>
 <CAFULd4brsMuNX3-jJ44JyyRZqN1PO9FwJX7N3mvMwRzi8XYLag@mail.gmail.com>
 <CAADnVQ+7GTN0Tn_5XSZKGDwrjW=v3R6MyGrcDnos2QpkNSidAw@mail.gmail.com>
 <CAFULd4aHiEaJkJANNGwv1ae7T0oLd+r9_4+tozgAq0EZhS16Tw@mail.gmail.com>
 <CAADnVQJ56-W--rdeRyRSXVjy5beQpt5scuRuTK9nDUPqdjMQ=w@mail.gmail.com> <CAFULd4bv+j8qomULWzcU_SV8zPtvxefFN6NgPu-WQiHaTR8HCg@mail.gmail.com>
In-Reply-To: <CAFULd4bv+j8qomULWzcU_SV8zPtvxefFN6NgPu-WQiHaTR8HCg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 20 Mar 2025 16:17:53 -0700
X-Gm-Features: AQ5f1JpnjSNktuEaUMFlnP7r4sXuDi2tnnP4ZbzUHz3HLqaxRxdVpU4R4sNm5DM
Message-ID: <CAADnVQ+Aq85fJJGkurLopdAwjyTEnXAb8=u-ni6mjm-swpEYjQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 12:49=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> wr=
ote:
>
> On Thu, Mar 20, 2025 at 12:17=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Mar 19, 2025 at 12:44=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com=
> wrote:
> > >
> > > On Wed, Mar 19, 2025 at 7:56=E2=80=AFPM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Wed, Mar 19, 2025 at 9:06=E2=80=AFAM Uros Bizjak <ubizjak@gmail.=
com> wrote:
> > > > >
> > > > > On Wed, Mar 19, 2025 at 3:55=E2=80=AFPM Alexei Starovoitov
> > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > >
> > > > > > On Wed, Mar 19, 2025 at 7:36=E2=80=AFAM Kumar Kartikeya Dwivedi
> > > > > > <memxor@gmail.com> wrote:
> > > > > > >
> > > > > > > > >
> > > > > > > > > I've sent a fix [0], but unfortunately I was unable to re=
produce the
> > > > > > > > > problem with an LLVM >=3D 19 build, idk why. I will try w=
ith GCC >=3D 14
> > > > > > > > > as the patches require to confirm, but based on the error=
 I am 99%
> > > > > > > > > sure it will fix the problem.
> > > > > > > >
> > > > > > > > Probably because __seg_gs has CC_HAS_NAMED_AS depends on CC=
_IS_GCC.
> > > > > > > > Let me give it a go with GCC.
> > > > > > > >
> > > > > > >
> > > > > > > Can confirm now that this fixes it, I just did a build with G=
CC 14
> > > > > > > where Uros's __percpu checks kick in.
> > > > > >
> > > > > > Great. Thanks for checking and quick fix.
> > > > > >
> > > > > > btw clang supports it with __attribute__((address_space(256))),
> > > > > > so CC_IS_GCC probably should be relaxed.
> > > > >
> > > > > https://github.com/llvm/llvm-project/issues/93449
> > > > >
> > > > > needs to be fixed first. Also, the feature has to be thoroughly t=
ested
> > > > > (preferably by someone having a deep knowledge of clang) before i=
t is
> > > > > enabled by default.
> > > >
> > > > clang error makes sense to me.
> > >
> > > It is not an error, but an internal compiler error. This should never=
 happen.
> >
> > Not quite. llvm backends don't have a good way to explain the error,
> > but this is invalid condition.
> > Arguably llvm should do a better job in such cases instead of
> > printing stack trace.
> >
> > >
> > > > What does it even mean to do addr space cast from percpu to normal =
address:
> > > >
> > > > __typeof__(int __seg_gs) const_pcpu_hot;
> > > > void *__attribute____UNIQUE_ID___addressable_const_pcpu_hot612 =3D
> > > >     (void *)(long)&const_pcpu_hot;
> > >
> > > Please see [1] for an explanation.
> > >
> > > [1] https://gcc.gnu.org/onlinedocs/gcc/Named-Address-Spaces.html#x86-=
Named-Address-Spaces
> >
> > You didn't answer my question.
>
> Actually, the above link explains and documents the issue:
>
> "... these address spaces are not considered to be subspaces of the
> generic (flat) address space. This means that explicit casts are
> required to convert pointers between these address spaces and the
> generic address space. In practice the application should cast to
> uintptr_t and apply the segment base offset that it installed
> previously."
>
> IOW, for __seg_gs address space, there exists no (known) offset that
> would define it as a subspace of the generic space. It is gs: prefix
> that results in segment override that "switches" to __seg_gs address
> space. So, to convert the pointer from __seg_gs to (nonsensical!)
> generic address space, GCC allows explicit (void *)(uintptr_t) cast
> that in effect just strips gs: prefix from the address. You can then
> use the pointer as a pointer to a generic space, but you can't use it
> to dereference data from __seg_gs address space - this would be
> nonsensical, so (__seg_gs void *)(uintptr_t) cast is needed to convert
> pointer back to __seg_gs AS.

tbh, I don't see how the above doc sentence means "just strip gs:".
But ok, if that's what gcc folks clarified as true intent and it's
not going to change.
btw both compilers disallow automatic variables with address space
qualifier and that makes sense, but if "just strip gs:" would be
the rule then auto var with gs should have meant "just strip" too.
Weird.

> > As suspected, gcc is producing garbage code.
>
> Nope, this is expected and well documented behavior.
>
> > See:
> > https://godbolt.org/z/ozozYY3nv
> >
> > For
> > void *ptr =3D (void *)(long)&pcpu_hot;
> >
> > gcc emits
> > .quad pcpu_hot
> > which is nonsensical, while clang refuses to produce garbage
> > and dumps stack.
> >
> > Sadly, both compilers produce garbage for ret_addr()
>
> No, they are correct. The pointer is explicitly cast to generic
> address space and this is what you get.
>
> > and both compilers produce correct code for ret_value().
> > At least something.
> >
> > Uros,
> > your percpu code is broken.
> > you shouldn't rely on gcc producing garbage.
> > Sooner or later gcc will start erroring on it just as clang.
>
> It won't. It is well documented behavior, as documented in [1].
> Regarding linux code, you "should not" pass a pointer to generic
> address space to dereference percpu data. Currently,
> __verify_percpu_ptr() only triggers a warning when sparse checking is
> used, but my patchset will now enforce this as a compile-time error
> (this was a much sought feature, and it was possible to implement only
> recently by using the newly introduced typeof_unqual() operator).

That value proposition of the patch is clear. It's a good check,
no doubt. My point that compilers could have done it just fine
without using this "just strip gs:" rule for global percpu variables.
I suspect it should be possible to craft the macro
without assigning (void *)(long)&pcpu_hot into global var.
And both compilers would have worked.

> Rest
> assured, before enabling this feature in linux, plenty of people
> unsuccessfully tried to poke a hole in this functionality and long
> threads are archived where address space functionality was discussed
> to death. ;)
>
> BTW: You can use:
>
> --cut here--
> diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.=
h
> index 474d648bca9a..e6a7525c9db9 100644
> --- a/arch/x86/include/asm/percpu.h
> +++ b/arch/x86/include/asm/percpu.h
> @@ -105,6 +105,10 @@
>  # define __my_cpu_type(var)    typeof(var) __percpu_seg_override
>  # define __my_cpu_ptr(ptr)    (__my_cpu_type(*(ptr))*)(__force uintptr_t=
)(ptr)
>  # define __my_cpu_var(var)    (*__my_cpu_ptr(&(var)))
> +
> +# if __has_attribute(address_space) && defined(USE_TYPEOF_UNQUAL)
> +#  define __percpu_qual        __attribute__((address_space(3)))

I see, so for undefined addr spaces clang x86 just ignores it.
Weird. But ok.

