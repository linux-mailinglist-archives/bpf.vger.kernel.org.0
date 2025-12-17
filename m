Return-Path: <bpf+bounces-76928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2E7CC9BC7
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 23:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F557303B7CD
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 22:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E669632E757;
	Wed, 17 Dec 2025 22:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WONFhyis"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F031F32ED3F
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 22:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766011655; cv=none; b=qzxOt3I6Eu8icgxw6gpzZUiz0gWYG+f3shOSIE55/DN8Y/F+pCo5w/WGksxsDvrM2fRhI9L8l+7QM050tLz6yypk3cXeQ+1E/Og7+mltFPdkjYzo5fzuP41eWaQiBkSU6CTUKgo03vekhvqpVVrHKpNlB42vCPF/F32EddzGRhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766011655; c=relaxed/simple;
	bh=y0orq+jZc7vjHoSnAkRkIwFNOqo4m70B0RYAfYa/67I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aosoVeRvdMAC9LmwsBY6ttaaefCAUF4NrqO9hilnZpYPWHM5J/KGCoMyNQ60cNWXJzhCnzDJoec11OXuSuzEol1abCLztXxNioGFz/fQI7r0IxbOkhKBM5zq+KrH/xZDd5u2I+AnFwAu8VENZ/o4zVguGbNHs3pl5FuvQht8+mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WONFhyis; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7b852bb31d9so68993b3a.0
        for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 14:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766011653; x=1766616453; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SgwK63zEzQd1zZfC2X2ZUWtcujKrMW3ifb1zgkpCbqU=;
        b=WONFhyisX1mZvuVl8xOnZAKVjhcHAsXb9idxc5SSsLGfIcaqIJjeT1Mmg1qRfl2lk4
         Tdza07guubJMT4Rcf2VNs0tjUxhnlWZeY8GlVDbwaXShEC99FIxkagxgk8R8G4gNW9hh
         sVlfoEyRh3PGAola3pxGJBmYzdzZYv/bHEBwjZM7S0LXLowckEwNs+k3VI1RJrL+Bjc8
         UD2BCVU2/4j3o7LGOFdHcbYKxc9NzmS+r3LgOzJdXv+RmG/irig/jXbCdOf6z9HfHNeg
         ZFR9KcLu1mJZz3NBUlRDucdCERAvIklDs8798zYCja3GXqrTaNNdjaCxOcGlRt4BmA0k
         dlrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766011653; x=1766616453;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SgwK63zEzQd1zZfC2X2ZUWtcujKrMW3ifb1zgkpCbqU=;
        b=E0z2ctoeU7vv+J5KGpAEDSshkrzlJNryqlwrjGzhlgYmCAjZzrK2MOe4sbmS3KfbY1
         RzuK1Q/ku6TudSpIfs2wawkCIFAYwB8EjY5TG4+uzwqHajVSFuFrTzump9I7hwNJ2Yh/
         3zUTXVZJowbfdhiUl8+XZmKeR7Rf11QQCBD0FSNTMioqQuMl6LRSU0Vvs5hYCJOh4ZVz
         ZN+7IqMAZuuS0ZFjsuBaNYV4X8JQGvKDL+cTbWQdNHS4zHdPE4fZk3Ad8Vu/bnTt+diO
         cPzbhrCf3IckrFOHq0EirSUnu+qB4L1TYOKv9Mx/uF6bTB2QyHik79dTNknKONZMGBxi
         5xsg==
X-Forwarded-Encrypted: i=1; AJvYcCVAlo5eWIBnYhu+a/ACTrxwxHXDhI4+a+1lY3Uw4hwl4mVn4hnZ3lkTRwYz+tt3owARX0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEKncZk3eZM02erbbjJEdBPf6ooTV340Mv6iM4UQQOVZLk1A4U
	MiRUWAFwthVFZj7gcn3nObG4pq0AQi80VZQ15c1ESKUEXFu3x9vBQ73Y
X-Gm-Gg: AY/fxX7abt0Nc+DJBYWtKAiYX1xoe2bdwaiPY1SjEff4oC9iMVIWgX3XIpe0SeiWPOj
	CXJk6LQICoolF1P+adJO53WmAZ58G+4mXKWAxZbznd+SYPl2BhUrwv6plujnkAlvdqX6BkcJbgt
	Xtz10gJwqgkFkJq+RPh+pTt+uVE233Z5D2YgFXGrZAIWCwq366CGITK++EDp1OSvvbol8LABPRY
	otHgzD368YOeC9VX1oDbB585a3ksdkHssvND5+ljgXU4lWWH0UkW4aIdRyUBhX6WHS9GTquH8Da
	ZdbQtT5IYFdaxrDk37SvPEChZBNYMrVKisdswxNhJxSY/JKl9LQIfbPJEE+Z4baA0oHgTmHk3eC
	YdbnykAospBRFN9Zi/yE+LhtW1xzqtAW07qmpA2jOWWQKxHkJq0fnUx1MXkZIPYnhpu3eDHFV23
	UKjD07wz1Wj+1/xL8a5qqQiRfyo6lSoxgckFj6
X-Google-Smtp-Source: AGHT+IHcrjV25T67kPq7hMGIOghVj6zZogJ3Ax5CjO3k6nvkdvSpjo04PMpP2GVRGw/URVXGkYZeRQ==
X-Received: by 2002:a05:7023:d09:b0:11a:4016:4491 with SMTP id a92af1059eb24-11f34bfaf47mr16353544c88.24.1766011653027;
        Wed, 17 Dec 2025 14:47:33 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:9f95:2f12:bb69:e3e6? ([2620:10d:c090:500::7:a4ff])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12061f46ce9sm2277357c88.2.2025.12.17.14.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 14:47:32 -0800 (PST)
Message-ID: <aeeae7e13ce401726ddce756268c0686d30eb3a9.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: add option to force-anonymize
 nested structs for BTF dump
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko
	 <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Quentin Monnet <qmo@kernel.org>,
  Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,  Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev	 <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, bpf	
 <bpf@vger.kernel.org>
Date: Wed, 17 Dec 2025 14:47:30 -0800
In-Reply-To: <5022ccaf5591e5bb88fe3d7a08dbb3c4fb6c3132.camel@gmail.com>
References: <20251216171854.2291424-1-alan.maguire@oracle.com>
		 <20251216171854.2291424-2-alan.maguire@oracle.com>
		 <d5a578c01f8a2d4d95ca16e0a9ee5b9bfce1c30e.camel@gmail.com>
		 <9a096b2a16d552031a12f3f4f5a2c725212df5e6.camel@gmail.com>
		 <b535b47a-519e-4138-861b-c16ed7fa0bcd@oracle.com>
		 <CAADnVQ+EyYO+aOZewNQwETr5rphOCp6jJQH_fw9GqjVFdQd19A@mail.gmail.com>
		 <CAEf4BzbWZtRdKCGwhjRV9MOufTC-coWFSU5sRtk4gdm9S_bg+w@mail.gmail.com>
		 <6ae6dfd8-3f73-4318-93c1-97541d267a28@oracle.com>
		 <CAADnVQ+wNPbbA0e4+6kx+LtOH=09jJyiYcEKZfc8kt6UPnq=EQ@mail.gmail.com>
		 <535846f7-4cc7-4b12-aab4-52e530d04706@oracle.com>
		 <ae6c6e50b3176d4ee4cce4cda09807a05d103fbf.camel@gmail.com>
		 <3071012cc1e8d6bdf16b13d371a12cb201c502a7.camel@gmail.com>
		 <b65fd7dc-fbad-4a96-8eb8-f36f8f518d44@oracle.com>
		 <CAEf4Bzb+3cryZAEwC_O7xgm3=cthZU-SNsUWfGH8OpSwc+3vaw@mail.gmail.com>
		 <CAADnVQJ1V1vwPVnhyE4OfOSQt_BnB3wRW9g9_bhkdu-QZyuQkQ@mail.gmail.com>
	 <5022ccaf5591e5bb88fe3d7a08dbb3c4fb6c3132.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-12-17 at 14:34 -0800, Eduard Zingerman wrote:
> On Wed, 2025-12-17 at 13:27 -0800, Alexei Starovoitov wrote:
> > On Wed, Dec 17, 2025 at 1:02=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Wed, Dec 17, 2025 at 12:50=E2=80=AFPM Alan Maguire <alan.maguire@o=
racle.com> wrote:
> > > >
> > > > On 17/12/2025 19:35, Eduard Zingerman wrote:
> > > > > On Wed, 2025-12-17 at 11:34 -0800, Eduard Zingerman wrote:
> > > > > > On Wed, 2025-12-17 at 18:41 +0000, Alan Maguire wrote:
> > > > > >
> > > > > > [...]
> > > > > >
> > > > > > > So maybe the best we can do here is something like the follow=
ing at the top
> > > > > > > of vmlinux.h:
> > > > > > >
> > > > > > > #ifndef BPF_USE_MS_EXTENSIONS
> > > > > > > #if __has_builtin(__builtin_FUNCSIG) || defined(_MSC_EXTENSIO=
NS)
> > > > > > > #define BPF_USE_MS_EXTENSIONS
> > > > > > > #endif
> > > > > > > #endif
> > > > > > >
> > > > > > > ...and then guard using #ifdef BPF_USE_MS_EXTENSIONS
> > > > > > >
> > > > > > > That will work on clang and perhaps at some point work on gcc=
, but also
> > > > > > > gives the user the option to supply a macro to force use in c=
ases where
> > > > > > > there is no detection available.
> > > > > >
> > > > > > Are we sure we need such flexibility?
> > > > > > Maybe just stick with current implementation and unroll the str=
uctures
> > > > > > unconditionally?
> > > > >
> > > > > I mean, the point of the extension is to make the code smaller.
> > > > > But here we are expanding it instead, so why bother?
> > > >
> > > > Yeah, I'm happy either way; if we have agreement that we just use t=
he nested anon
> > > > struct without macro complications I'll send an updated patch.
> > >
> > > There is a little bit of semantic meaning being lost when we inline
> > > the struct, but I guess that can't be helped. Let's just
> > > unconditionally inline then. Still better than having extra emit
> > > option, IMO.
> >
> > tbh I'm concerned about information loss.
> >
> > If it's not too hard I would do
> > #ifndef BPF_USE_MS_EXTENSIONS
> > #if __has_builtin(__builtin_FUNCSIG)
> > #define BPF_USE_MS_EXTENSIONS
> > #endif
> >
> > and it will guarantee to work for clang while gcc will have structs inl=
ined.
> >
> > In one of the clang selftests they have this comment:
> > clang/test/Preprocessor/feature_tests.c:
> > #elif __has_builtin(__builtin_FUNCSIG)
> > #error Clang should not have this without '-fms-extensions'
> > #endif
> >
> > so this detection is a known approach.
>
> Speaking of information loss.
> It appears that clang does the same trick internally:
>
>   $ cat ms-ext-test2.c
>   struct foo {
>     int a;
>   } __attribute__((preserve_access_index));
>
>   struct bar {
>     struct foo;
>   } __attribute__((preserve_access_index));
>
>   int buz(struct bar *bar) {
>     return bar->a;
>   }
>
>   $ clang -O2 -g -fms-extensions --target=3Dbpf -c ms-ext-test2.c
>   ms-ext-test2.c:6:3: warning: anonymous structs are a Microsoft extensio=
n [-Wmicrosoft-anon-tag]
>       6 |   struct foo;
>         |   ^~~~~~~~~~
>   1 warning generated.
>
>   $ llvm-objdump -Sdr ms-ext-test2.o
>
>   ms-ext-test2.o: file format elf64-bpf
>
>   Disassembly of section .text:
>
>   0000000000000000 <buz>:
>   ;   return bar->a;
>          0:       61 10 00 00 00 00 00 00 w0 =3D *(u32 *)(r1 + 0x0)
>                   0000000000000000:  CO-RE <byte_off> [2] struct bar::<an=
on 0>.a (0:0:0)
>          1:       95 00 00 00 00 00 00 00 exit
>
> Note the "<anon 0>" in the relocation.
> It appears that we loose no information if structures are unrolled.

On the other hand, frontend knows that it deals with 'struct foo'.

  $ clang -Xclang -ast-dump -O2 -g -fms-extensions --target=3Dbpf -c ms-ext=
-test2.c
  ...
  |-RecordDecl 0x4e0398 <line:5:1, line:7:1> line:5:8 struct bar definition
  | ...
  | |-FieldDecl 0x5200d8 <line:6:3, col:10> col:3 implicit referenced 'stru=
ct foo'
  | | `-BPFPreserveAccessIndexAttr 0x5201d8 <<invalid sloc>> Implicit
  | `-IndirectFieldDecl 0x520138 <line:2:7> col:7 implicit a 'int'
  |   |-Field 0x5200d8 field_index 0 'struct foo'
  |   |-Field 0x4e0298 'a' 'int'
  |   `-BPFPreserveAccessIndexAttr 0x520180 <<invalid sloc>> Implicit
  `-FunctionDecl 0x5204a8 <line:9:1, line:11:1> line:9:5 buz 'int (struct b=
ar *)'
    |-ParmVarDecl 0x520398 <col:9, col:21> col:21 used bar 'struct bar *'
    `-CompoundStmt 0x520668 <col:26, line:11:1>
      `-ReturnStmt 0x520658 <line:10:3, col:15>
        `-ImplicitCastExpr 0x520640 <col:10, col:15> 'int' <LValueToRValue>
          `-MemberExpr 0x520610 <col:10, col:15> 'int' lvalue .a 0x4e0298
            `-MemberExpr 0x5205d8 <col:10, col:15> 'struct foo' lvalue -> 0=
x5200d8
              `-ImplicitCastExpr 0x5205c0 <col:10> 'struct bar *' <LValueTo=
RValue>
                `-DeclRefExpr 0x5205a0 <col:10> 'struct bar *' lvalue ParmV=
ar 0x520398 'bar' 'struct bar *'


And this relation is reflected in DWARF.
So, there is a subtle difference.

