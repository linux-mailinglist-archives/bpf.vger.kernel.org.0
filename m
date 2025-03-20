Return-Path: <bpf+bounces-54435-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64068A6A0BC
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 08:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66C3A189E77A
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 07:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AF8206F2E;
	Thu, 20 Mar 2025 07:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1YQ9oJQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF361DE2CD;
	Thu, 20 Mar 2025 07:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742456957; cv=none; b=fS+2vMKtGASHhjeTZPmfFVJzdeoLTr0o/kGLYAod7npRpPmgQ2l8ReqoQxZ1Hz2HvNfozygwmGcRpNDiqkzbLsDdtNA2e5hB/mpt2UN78e1qy/x0UvWeUf6xxr3WRgJUIZL7OJ4/F9pFR7jsUZMSHq08H6FgysZk/ibtjOkZ+gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742456957; c=relaxed/simple;
	bh=0RrGvjKxlH6hlqBET7Q0+kXe0Pv6c8EGXoyCElqwIsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rMAUxQ7qCyGqQeFPhyYlcQ9+imfT+uSkpwit0Y3yxUIdPo3obqKquagO8XwxN+Gt9sFMH3HO3IQOAupI/I5z+rK2BwaYRE8HGYfAc1MkvCSuXPhRHksGJ3krwBNyqG0PzvxCpKG10maFlcOPa9dREhCap5LlNAvoVFE/P/V4Hz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1YQ9oJQ; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54957f0c657so533164e87.0;
        Thu, 20 Mar 2025 00:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742456953; x=1743061753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7M2zzbCtkmPcGj+EqyLxf8UcIQIKY7mVZ0w/cIUdaM=;
        b=H1YQ9oJQZ2NZ7Gg0wz5RwBXs3GAZLynggINn83sZXS9mWHqZaAa8PlogNvTlMNFkPG
         sLC+jTRT9BEiOlbDVDS7w4WZEklpB2+S2FvZb8uvTU9bHLojIJMvqV54i0tn6p+Mma3P
         3LfP1jgXUIwOVzps2Y3OA2jAYtVOs/dXqMDCgdTDCzj2BdVh6UD08DgR74c3QOPq53W0
         IcS1nDnK2eiB0DuvdEVhm72r5ecxer8B8Iaxjk0uZSx7wn+n4htF25vIi4JizbKlChj/
         ZhBS/zzldlNurbbfSm4vat+R/PFecQrV1PxXFQfYzcfiKNEozbxfPiybxQtNCpNz5qu/
         Z3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742456953; x=1743061753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A7M2zzbCtkmPcGj+EqyLxf8UcIQIKY7mVZ0w/cIUdaM=;
        b=wyEo/deoqZBUNbPBYhHPArr7G+jj7PNHISNGGhk6BfK0uko9epjthQWNNONty0CooD
         +FCpOWZq2PoosOv+jVXGMeEuo6foY9y4G+cQzo/YjHZOT+9ISjiXPqPBK+gDweCjPz3i
         EU5ml6nLV/b/BLFN47iMRk9VYOzDGp5oFjtDeuY3lnhXy0waBzXYLA9Ce63dnv8TJaEr
         o75fvmnHOM/Gpqmc/oiX+3jI5kgmTdI5Ow5yeuENueC7tA5VqvbOjn6w1Z29y3LJ3g6x
         AiKoyKwTogIZ/S0UBZ7uE3s9Fn1U7fZ3Cd5N3Cvv2aXfL0cHP1x82AukfsWwvQ11Yeaq
         nQfw==
X-Forwarded-Encrypted: i=1; AJvYcCUV/LoCvHPFhnN0dfxnSytvu7QAiUbWqZsP/RZwVy7AFrxkylGeTYo7ELqBGsurKpaChO83Vqqd2pjvLA==@vger.kernel.org, AJvYcCVuPPhMPu4EpCy2gfhWU5ouExiOisYR+Xy6uYGMd5pVhAaeP4ii72DxhXeFrpqQ3YqGZnxahM40XApv96ec@vger.kernel.org, AJvYcCW5IwE/Retgxbfk/ZLBLvEkQCACA+oaPzYbQQbkCrdb2KG05HipLzkoBVFtKL1l1Y6rOuI=@vger.kernel.org, AJvYcCXNfdG2G1/u+lpRMyPKmoeZg/WgJOF5js49TYJZbxuXDVYSg6vbcgRaquFIdrIZTjKvcJUTFcHl@vger.kernel.org
X-Gm-Message-State: AOJu0YwuR49e3yeTVViUVPl0dqNN2I2wIFvHR+c335zAFjEwyIH+C0js
	XXu3G7YX7BcQ7sxlUCd/IgKtEd5nSEbYUGxKFqcxLlnEFmaDwNzF9FvdvOnI2y+BGz3u93IVku2
	jfuan/zR8APD6hCjEhmGMNOmaIdQ=
X-Gm-Gg: ASbGncvGFRi7PIjgRdsCYsogptS9nW0ad8SQrBo8BV5UgICjm4zFklvbYHInxhbLu0d
	ET6HeBt1A7rJhM6jSKeLWbaGrGdzMg8bayd7ZBfr6K/ye1OWr5IARlpvcqXXqR2tOhdhtScAbax
	poeK1IyKhhRFe1hBY+vBgfwjULrg==
X-Google-Smtp-Source: AGHT+IFFZQy3AHVTx+IsMUaBmexS/4SASeO8Aozq7/AJe3sTuHDO5KP/I3zD07SptzmaqDtxm6V6w8i17N3wM1R3vOQ=
X-Received: by 2002:a05:6512:3da2:b0:549:8d2f:86dd with SMTP id
 2adb3069b0e04-54acfadce20mr813459e87.20.1742456952969; Thu, 20 Mar 2025
 00:49:12 -0700 (PDT)
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
 <CAFULd4aHiEaJkJANNGwv1ae7T0oLd+r9_4+tozgAq0EZhS16Tw@mail.gmail.com> <CAADnVQJ56-W--rdeRyRSXVjy5beQpt5scuRuTK9nDUPqdjMQ=w@mail.gmail.com>
In-Reply-To: <CAADnVQJ56-W--rdeRyRSXVjy5beQpt5scuRuTK9nDUPqdjMQ=w@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 20 Mar 2025 08:49:01 +0100
X-Gm-Features: AQ5f1Jqxqm5B7f7TpFiD7n5nwUaU8XWL3GsG2zcD6bFVc5Tjvi5UBm5bGSVzTYE
Message-ID: <CAFULd4bv+j8qomULWzcU_SV8zPtvxefFN6NgPu-WQiHaTR8HCg@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 12:17=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Mar 19, 2025 at 12:44=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> =
wrote:
> >
> > On Wed, Mar 19, 2025 at 7:56=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Wed, Mar 19, 2025 at 9:06=E2=80=AFAM Uros Bizjak <ubizjak@gmail.co=
m> wrote:
> > > >
> > > > On Wed, Mar 19, 2025 at 3:55=E2=80=AFPM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Wed, Mar 19, 2025 at 7:36=E2=80=AFAM Kumar Kartikeya Dwivedi
> > > > > <memxor@gmail.com> wrote:
> > > > > >
> > > > > > > >
> > > > > > > > I've sent a fix [0], but unfortunately I was unable to repr=
oduce the
> > > > > > > > problem with an LLVM >=3D 19 build, idk why. I will try wit=
h GCC >=3D 14
> > > > > > > > as the patches require to confirm, but based on the error I=
 am 99%
> > > > > > > > sure it will fix the problem.
> > > > > > >
> > > > > > > Probably because __seg_gs has CC_HAS_NAMED_AS depends on CC_I=
S_GCC.
> > > > > > > Let me give it a go with GCC.
> > > > > > >
> > > > > >
> > > > > > Can confirm now that this fixes it, I just did a build with GCC=
 14
> > > > > > where Uros's __percpu checks kick in.
> > > > >
> > > > > Great. Thanks for checking and quick fix.
> > > > >
> > > > > btw clang supports it with __attribute__((address_space(256))),
> > > > > so CC_IS_GCC probably should be relaxed.
> > > >
> > > > https://github.com/llvm/llvm-project/issues/93449
> > > >
> > > > needs to be fixed first. Also, the feature has to be thoroughly tes=
ted
> > > > (preferably by someone having a deep knowledge of clang) before it =
is
> > > > enabled by default.
> > >
> > > clang error makes sense to me.
> >
> > It is not an error, but an internal compiler error. This should never h=
appen.
>
> Not quite. llvm backends don't have a good way to explain the error,
> but this is invalid condition.
> Arguably llvm should do a better job in such cases instead of
> printing stack trace.
>
> >
> > > What does it even mean to do addr space cast from percpu to normal ad=
dress:
> > >
> > > __typeof__(int __seg_gs) const_pcpu_hot;
> > > void *__attribute____UNIQUE_ID___addressable_const_pcpu_hot612 =3D
> > >     (void *)(long)&const_pcpu_hot;
> >
> > Please see [1] for an explanation.
> >
> > [1] https://gcc.gnu.org/onlinedocs/gcc/Named-Address-Spaces.html#x86-Na=
med-Address-Spaces
>
> You didn't answer my question.

Actually, the above link explains and documents the issue:

"... these address spaces are not considered to be subspaces of the
generic (flat) address space. This means that explicit casts are
required to convert pointers between these address spaces and the
generic address space. In practice the application should cast to
uintptr_t and apply the segment base offset that it installed
previously."

IOW, for __seg_gs address space, there exists no (known) offset that
would define it as a subspace of the generic space. It is gs: prefix
that results in segment override that "switches" to __seg_gs address
space. So, to convert the pointer from __seg_gs to (nonsensical!)
generic address space, GCC allows explicit (void *)(uintptr_t) cast
that in effect just strips gs: prefix from the address. You can then
use the pointer as a pointer to a generic space, but you can't use it
to dereference data from __seg_gs address space - this would be
nonsensical, so (__seg_gs void *)(uintptr_t) cast is needed to convert
pointer back to __seg_gs AS.

> As suspected, gcc is producing garbage code.

Nope, this is expected and well documented behavior.

> See:
> https://godbolt.org/z/ozozYY3nv
>
> For
> void *ptr =3D (void *)(long)&pcpu_hot;
>
> gcc emits
> .quad pcpu_hot
> which is nonsensical, while clang refuses to produce garbage
> and dumps stack.
>
> Sadly, both compilers produce garbage for ret_addr()

No, they are correct. The pointer is explicitly cast to generic
address space and this is what you get.

> and both compilers produce correct code for ret_value().
> At least something.
>
> Uros,
> your percpu code is broken.
> you shouldn't rely on gcc producing garbage.
> Sooner or later gcc will start erroring on it just as clang.

It won't. It is well documented behavior, as documented in [1].
Regarding linux code, you "should not" pass a pointer to generic
address space to dereference percpu data. Currently,
__verify_percpu_ptr() only triggers a warning when sparse checking is
used, but my patchset will now enforce this as a compile-time error
(this was a much sought feature, and it was possible to implement only
recently by using the newly introduced typeof_unqual() operator). Rest
assured, before enabling this feature in linux, plenty of people
unsuccessfully tried to poke a hole in this functionality and long
threads are archived where address space functionality was discussed
to death. ;)

BTW: You can use:

--cut here--
diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 474d648bca9a..e6a7525c9db9 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -105,6 +105,10 @@
 # define __my_cpu_type(var)    typeof(var) __percpu_seg_override
 # define __my_cpu_ptr(ptr)    (__my_cpu_type(*(ptr))*)(__force uintptr_t)(=
ptr)
 # define __my_cpu_var(var)    (*__my_cpu_ptr(&(var)))
+
+# if __has_attribute(address_space) && defined(USE_TYPEOF_UNQUAL)
+#  define __percpu_qual        __attribute__((address_space(3)))
+# endif
 #endif

 #define __percpu_arg(x)        __percpu_prefix "%" #x
--cut here--

to also see clang's address space checks in action on x86 even without
working __seg_gs support (You will need to disable
Wduplicate-decl-specifier warning).

HTH,
Uros.

