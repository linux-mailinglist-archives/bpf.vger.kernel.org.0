Return-Path: <bpf+bounces-62425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE3FAF9A5A
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 20:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F342C3ABA85
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 18:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4DF20F079;
	Fri,  4 Jul 2025 18:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAlWCmnr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3138220E030
	for <bpf@vger.kernel.org>; Fri,  4 Jul 2025 18:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751652707; cv=none; b=GPsZp20vxVfUJd07r0bKKonFfpk0pR+Nron4T9qdfzZLNuI6Fo3du0tW7KTmsxK+81jjWu4XS6Pv6gb/rSyv9V1leVWVNuFXfp6ufVinx2yKUFAY4o5+mn/I7K85l/1ayUsLwOXAzM8I1Cew7+kh2zMw7JAB7oswQYi+WG/Wlv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751652707; c=relaxed/simple;
	bh=1qFtH+yFODgHAfBpJLUUVzLvMRPmvqXNxTP0+A4n2ls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fvn2j2KBY9KRI5IiCrrPwOtWk4YceyGspntHIicKPF0/BvN6dp2+I1fuSzTn662kN//icpmDWLBtDH1lnW3bDrgHUQtWTXXZAKGpLEG++zKfMp6PIr2yRI6bMjJScl9k65ubek/wbxB7gvoZolO4ay5Lz5GfzaNH8CPuviOq8dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAlWCmnr; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a6d1369d4eso667310f8f.2
        for <bpf@vger.kernel.org>; Fri, 04 Jul 2025 11:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751652704; x=1752257504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGEMbZcLl+nmzGxaDK9fwvVHa3fc9qJIQPqu7VR5Arg=;
        b=hAlWCmnrXE6BuWfMayI1YA/qdQuwzEy7Pj6qULOr1bBA6+5VfaHTTnTrOSHKpa8fGC
         fGHXGfI7YBc1WE5eifQZ0S8XusFh7bw4gb/VEY7RBCBHmfUyL9YbP8+IbaxBv+wJQ9GF
         f+Hfs6fPjvOaG3BHGH7bfCT+WxTCK9S5nqheiAIqU7JZXcs83A/h8DBnZBb7gwqaudZQ
         yV5igvgvOHfuLuXzjdMc+xvO2yJ1O4RkyvGQdaBLIIuLQZXV4IzLSfnLeBl0VJA9XyJr
         rcdTBsUmtReB6VlosCesqBv9JzoQB9BYFFTTSDPOknqpm0nknEEIacKWMLnHzJin4uKK
         YB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751652704; x=1752257504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XGEMbZcLl+nmzGxaDK9fwvVHa3fc9qJIQPqu7VR5Arg=;
        b=girGyM4ukPgGqIW91NWxTlvMS9GgVTFqkXEpiOyZnvXfQLCz3mGqfQ6WfMNE/4OVfW
         f2trqEfW9fJ2CqY0DadhTES54EgvgfLT2xPU5OtfCYLZW72PshzkNyMryDm7cLX1WZfm
         5Fkl2QrR7IrHd28aU6kNynvfIqxgcaF5HNo73qFNlCr79v7kUL0Upod4br7401OFzi+s
         fqEfuTsmYSXsCg4jmEaVv5T2iXmbPlqOnF2fIkmA+QYawvNA7jQwSR/LM57K8TbQ+cnj
         YY+GCtoTbr8md6CHEsyFyNTCmmMMtHow4XJLw8otz7/DDC37xAgygdNm9lE70Wiz6NsH
         O9qg==
X-Gm-Message-State: AOJu0Yzq1cUZeX3N/NtohBkEy0KWGme0qDF7mbFKQfvbHZ3eOE/vRCeY
	c/6W4jW5yN7rA60LoxRfhI9zOBW9RaJT1VQmhz5IhIA2EmJPp2tNS9oFg8WZKjzmAFquMFrX4aa
	LLYUiueN+/AxGN3Dy5GpZy8jipNBIQHo=
X-Gm-Gg: ASbGncs9xrOvv+ofzwP0uhWWQ2zsGqPYnhMKuIcnJvXBpLi7Dlz3e9Q1W/CKS1PPWui
	mTe9dOVidiYadQEs2iNgN10Onxb1MUT9gqHjB8B3HqIfj2RO+lxaaDs/u/0jvdkzJD+gCJlhb7i
	ROl78snGrvN3IdIdgO1BKjyH5Xekiv0wUoaVKWLiNcLY57AvD/YTAT3JeyDuOsiDFGRvg/b6RMa
	mv8ff1yu9U=
X-Google-Smtp-Source: AGHT+IF2fdgXj7w3C9E4E4OA9+6lRhSsGlJ/ccRhw/wUl/PNlk/NVwFUW23wGuKi3CYPp9UkZ5iKv3/0XVeWSkj/G8M=
X-Received: by 2002:a5d:5f92:0:b0:3a4:f7dc:8a62 with SMTP id
 ffacd0b85a97d-3b4964be0d3mr3154043f8f.0.1751652704124; Fri, 04 Jul 2025
 11:11:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702224209.3300396-1-eddyz87@gmail.com> <20250702224209.3300396-8-eddyz87@gmail.com>
 <CAADnVQKRigoGjm+jeKY-nGHi=_5pVr+Yjs_MnRDXNbf09AP8kg@mail.gmail.com> <63695ed41e85be62d93e5e86204cd8c0d3491ff5.camel@gmail.com>
In-Reply-To: <63695ed41e85be62d93e5e86204cd8c0d3491ff5.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 4 Jul 2025 11:11:32 -0700
X-Gm-Features: Ac12FXw7O9rf8QHtcTnuvAtmQYqT-83uJ4fc0ksE2iZX2pYq7rOKhUF7H3bdKPw
Message-ID: <CAADnVQJSN3DPW28QQNsysurEwGeZNgeTwE0mTi+kfghvc0kXiA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 7/8] bpf: support for void/primitive
 __arg_untrusted global func params
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 2:49=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Wed, 2025-07-02 at 20:20 -0700, Alexei Starovoitov wrote:
> > On Wed, Jul 2, 2025 at 3:42=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> > >
> > > Allow specifying __arg_untrusted for void */char */int */long *
> > > parameters. Treat such parameters as
> > > PTR_TO_MEM|MEM_RDONLY|PTR_UNTRUSTED of size zero.
> > > Intended usage is as follows:
> > >
> > >   int memcmp(char *a __arg_untrusted, char *b __arg_untrusted, size_t=
 n) {
> > >     bpf_for(i, 0, n) {
> > >       if (a[i] - b[i])      // load at any offset is allowed
> > >         return a[i] - b[i];
> > >     }
> > >     return 0;
> > >   }
> >
> > ...
> >
> > > +bool btf_type_is_primitive(const struct btf_type *t)
> > > +{
> > > +       return (btf_type_is_int(t) && btf_type_int_is_regular(t)) ||
> > > +              btf_is_any_enum(t);
> > > +}
> >
> > Should array of primitive types be allowed as well ?
> > Since in C
> >    int memcmp(char a[] __arg_untrusted, char b[] __arg_untrusted, size_=
t n) {
> >      bpf_for(i, 0, n) {
> >        if (a[i] - b[i])      // load at any offset is allowed
> >          return a[i] - b[i];
> >
> > will work just like 'char *'.
>
> I agree in general, but compiler converts arrays to pointers for
> function parameters, e.g.:
>
>   [~/tmp]
>   $ cat test-array-btf.c
>   int foo(int a[], char b[3]) {
>     return 0;
>   }
>   [~/tmp]
>   $ clang --target=3Dbpf -c -g -O2 test-array-btf.c -o test-array-btf.o
>   [~/tmp]
>   $ bpftool btf dump file test-array-btf.o
>   [1] PTR '(anon)' type_id=3D2
>   [2] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3DSIGNED
>   [3] PTR '(anon)' type_id=3D4
>   [4] INT 'char' size=3D1 bits_offset=3D0 nr_bits=3D8 encoding=3DSIGNED
>   [5] FUNC_PROTO '(anon)' ret_type_id=3D2 vlen=3D2
>           'a' type_id=3D1
>           'b' type_id=3D3
>   [6] FUNC 'foo' type_id=3D5 linkage=3Dglobal
>
> So, I'm inclined to skip this for now.

I see. Makes sense then.

