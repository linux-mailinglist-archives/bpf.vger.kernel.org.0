Return-Path: <bpf+bounces-54422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D47DA69CA2
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 00:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 965417B07AB
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 23:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78512236F2;
	Wed, 19 Mar 2025 23:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m15RwVk8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A036F1CEADB;
	Wed, 19 Mar 2025 23:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742426230; cv=none; b=lA6DyK++fGDefQbptSZqD4ZNtuZCMVByxGnrFTSWJFdDWQgkjIDzzMsivkdItm4I1bEB5wM9u3ejq8WMnPNl7x1Tx6Lk2SDrfDm2NQLngBN9miwcgDXCuOuIzV7zoMotT+W+WteyWCC7uA9wZjaH9SELy8tGumdWPUPKlTA4e6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742426230; c=relaxed/simple;
	bh=GZaMfZ9ul8j4DzhhC/veqxBwy0WV+P5Hl7dRT3kVRBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fedm3Lh34N2Zkvj0F9yBUg3Y9F9DJ5IhpS7LeGsgWlckcm/BLyYg3Io8J5gMfZ0vZcy7ZrAxkFXvbepUPelZpOhAP2v+dMjNiQp+tB0kjpgcsMxhJigPv8TMCkknZYWyyoqR4EBqVUy/iwdSCZz95XlgVnidcI9m9KvcQaR3vPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m15RwVk8; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso1674045e9.1;
        Wed, 19 Mar 2025 16:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742426227; x=1743031027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PuZL7pP35g7W9j0ASOCQcHO+Zy1h62Z24KOBZ13jEcA=;
        b=m15RwVk8sVOxx7dtBAWVNtaUwotbof4+MLXi8fdGzBF4rLhMRc0sTtmqaiGnj2baWQ
         w8Q3amKcDZA9DCWQ89Fb9SfbhsqLudCyGEjKILdg15IUgVCIsM5kkLPD+jSnBYrjZ14Z
         gZ5f6FdZDKIadS4j3gme9mMgXAE7sOEp2CwWi4GbnFKlZjYCvBD9EXnCeaP0WPOrAZXV
         aQzfd4JxF+PHiKfxYB9ETdA1anSseDQzWOpitRJeDMiSZaW0b6n7bgY6jAGTH+Z+DOBY
         hEkHcUZ8Cjv3+N9CcK1jfoUZ7ouMHadN8dmsZCSnfQsDgX24KarXVCR5ProyUdDOE0UE
         cyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742426227; x=1743031027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PuZL7pP35g7W9j0ASOCQcHO+Zy1h62Z24KOBZ13jEcA=;
        b=us3ubk7W82aoNuQPPVhxHdpeyLdjlHd/QUFOFqrQwbxPTL59vBGgjGoIaTIou7ulNW
         3idL6b9Tfv4cjnGHZOX/4U1rPUn6kjxlA8Ufev5iuW/ex6owBHvKen3AR+TIPbIrvs3W
         9EvWip4nwpKqkElSKxALuhOIH4zVCLo5JgT6Txl5tDXV4DuVER7OKHzIdT05ieMNhSbG
         kc951yb6PlxVw2XbExL8EuIpzc+pG8cXk3hSkMnp/bE2f42G5fUgxg2XP0nZQvgKNzri
         WEFFGLPOsfV/kWPcarKSlQOYLbsmw7Ph1rdU1cS/iK9tBBi8SEh00W8LmN58ydWG7127
         ySvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKcAn5RAL4rdrWNNvpQN0MvU6JLACadAqwmH9FKHQTKJ42XugRlj7+5xiFBfKxG/rHJMzIPdUA@vger.kernel.org, AJvYcCXGWtHDn635k41/eGnLgRfVhMfo2KHTsyYB5j0XuF6711efWND/EyX26R0RicVjAyJW+gRldUDE9JyKnVR6@vger.kernel.org, AJvYcCXSwUx34qGdu+WSuZEpkRM1cy0Yu+y4Ld3N87eiworU3454G7OoB2C0m4l4IYuGEMgBBtg=@vger.kernel.org, AJvYcCXYa9eJUmtPzUK2VVxGjwEiO5QvaYishi/Mt9hEvtSZpB11HluKNDnc5tLEBWcERNwpgkJRiWxvd8pZ6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Q8L351Tax+EtrbQYus6rY7CVG/jWW5xP/WMV8V90Hf8ai+Bs
	nDad1zKsgHeF2UkajmO4ZVQ4PvQuX5tIBjPmLj8+w0mkE0q2nOp1v1gCCyOX7/bDAFMZGHkjP3e
	SKiugbB66uDgj//3qoeNmxgNEghQ=
X-Gm-Gg: ASbGncvF8Kv3kH8dgqG74juIepGXxdJxZZ4G3j/uejsOj9tvl3HbWZp00f99qXX5Kfa
	5TEcLiWCFmp5z6qVdRhEIoIaDi+NMGEcwJjLp4gEGbDvxnNxykJF4jFaLLSOcznINrlmMwLpEvL
	OVkje4qL5XE2JBf1ADlo3NWD0RrDuE9pjqt5x0d/JqOw==
X-Google-Smtp-Source: AGHT+IEdmZE01Vks1+jGOZmTrk675XATGZcbL8Iim2H1eIU5oSRDUP4s/g3txIPx5gc2nf5KCiWT0M2CtQawM5OYZ/c=
X-Received: by 2002:a5d:6da1:0:b0:391:952:c758 with SMTP id
 ffacd0b85a97d-399795a5027mr776163f8f.6.1742426226479; Wed, 19 Mar 2025
 16:17:06 -0700 (PDT)
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
 <CAADnVQ+7GTN0Tn_5XSZKGDwrjW=v3R6MyGrcDnos2QpkNSidAw@mail.gmail.com> <CAFULd4aHiEaJkJANNGwv1ae7T0oLd+r9_4+tozgAq0EZhS16Tw@mail.gmail.com>
In-Reply-To: <CAFULd4aHiEaJkJANNGwv1ae7T0oLd+r9_4+tozgAq0EZhS16Tw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 19 Mar 2025 16:16:54 -0700
X-Gm-Features: AQ5f1Jp4Q-WssXxFVxewhQfvYgxpKw0xShdxEJ8x8fWlrnFFcjsC5n1ZTAVPKjI
Message-ID: <CAADnVQJ56-W--rdeRyRSXVjy5beQpt5scuRuTK9nDUPqdjMQ=w@mail.gmail.com>
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

On Wed, Mar 19, 2025 at 12:44=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wr=
ote:
>
> On Wed, Mar 19, 2025 at 7:56=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Mar 19, 2025 at 9:06=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com>=
 wrote:
> > >
> > > On Wed, Mar 19, 2025 at 3:55=E2=80=AFPM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Wed, Mar 19, 2025 at 7:36=E2=80=AFAM Kumar Kartikeya Dwivedi
> > > > <memxor@gmail.com> wrote:
> > > > >
> > > > > > >
> > > > > > > I've sent a fix [0], but unfortunately I was unable to reprod=
uce the
> > > > > > > problem with an LLVM >=3D 19 build, idk why. I will try with =
GCC >=3D 14
> > > > > > > as the patches require to confirm, but based on the error I a=
m 99%
> > > > > > > sure it will fix the problem.
> > > > > >
> > > > > > Probably because __seg_gs has CC_HAS_NAMED_AS depends on CC_IS_=
GCC.
> > > > > > Let me give it a go with GCC.
> > > > > >
> > > > >
> > > > > Can confirm now that this fixes it, I just did a build with GCC 1=
4
> > > > > where Uros's __percpu checks kick in.
> > > >
> > > > Great. Thanks for checking and quick fix.
> > > >
> > > > btw clang supports it with __attribute__((address_space(256))),
> > > > so CC_IS_GCC probably should be relaxed.
> > >
> > > https://github.com/llvm/llvm-project/issues/93449
> > >
> > > needs to be fixed first. Also, the feature has to be thoroughly teste=
d
> > > (preferably by someone having a deep knowledge of clang) before it is
> > > enabled by default.
> >
> > clang error makes sense to me.
>
> It is not an error, but an internal compiler error. This should never hap=
pen.

Not quite. llvm backends don't have a good way to explain the error,
but this is invalid condition.
Arguably llvm should do a better job in such cases instead of
printing stack trace.

>
> > What does it even mean to do addr space cast from percpu to normal addr=
ess:
> >
> > __typeof__(int __seg_gs) const_pcpu_hot;
> > void *__attribute____UNIQUE_ID___addressable_const_pcpu_hot612 =3D
> >     (void *)(long)&const_pcpu_hot;
>
> Please see [1] for an explanation.
>
> [1] https://gcc.gnu.org/onlinedocs/gcc/Named-Address-Spaces.html#x86-Name=
d-Address-Spaces

You didn't answer my question.

As suspected, gcc is producing garbage code.

See:
https://godbolt.org/z/ozozYY3nv

For
void *ptr =3D (void *)(long)&pcpu_hot;

gcc emits
.quad pcpu_hot
which is nonsensical, while clang refuses to produce garbage
and dumps stack.

Sadly, both compilers produce garbage for ret_addr()

and both compilers produce correct code for ret_value().
At least something.

Uros,
your percpu code is broken.
you shouldn't rely on gcc producing garbage.
Sooner or later gcc will start erroring on it just as clang.

