Return-Path: <bpf+bounces-47791-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 061C1A00174
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 00:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D58E63A372B
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 23:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA491B4F04;
	Thu,  2 Jan 2025 23:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQTvZTYO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B2C224F0
	for <bpf@vger.kernel.org>; Thu,  2 Jan 2025 23:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735859080; cv=none; b=s6x5r0KOhV1PYUbuMjyI1cTKPXcfmJiBU+eeEP//s7HfYRwcllwiE5iJFQIm9mOD5eJkrzPCQJsp2GveLWS+BLxYpRaI0Jd1Ww8kFgNUK01DnOoXuRibfrFODJyaoskXLEoYpFLA+5oaMUADiriqFNXM9IQ+o77oDFha4YXgqbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735859080; c=relaxed/simple;
	bh=DokGzzFbOjvCtWpufzC1GkQm9PYuxXNzw201Se22cM4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tUW7ebdiJBQCYEixYc1bSau9xZ26Tpa+AdnRE8AxoLSchMpGwzTVVMgHc5YUCgSQgb3DX1nimq0mERnsVqF1RoZTjpGdvz3fvNTwR8H+pide+tjEEdBLA+sd4FsycyChKQbaZpnVAWB4Dbc4eaD0IAh/u1svQEjFK3VmgADDGHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQTvZTYO; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2167141dfa1so158635075ad.1
        for <bpf@vger.kernel.org>; Thu, 02 Jan 2025 15:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735859078; x=1736463878; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eErom6ud3khX44+dOquQHaQg8gNP6zIPpGREZq/z+qw=;
        b=DQTvZTYOOPCI/9/ivW+KfKAvFMbM41KZBX7W+msZhCgX5LsL/Y9jFV2ZNKNY52Oyfw
         HHWBoIm/vzUXopo0RcLqAeqznZsSxh3/FnYcVF8xKEpN7MfszYG5ElRMeWk3vrYmr1eh
         M3DN3tu0YSXen0qpN00GDaaa1ztUTW7K1DdD22i5tcJOXi3e3yEGnqeECMdNjF5LFVM6
         CT9IG2wXH8QU1wBk09kJPguPsNMzfe3ey2IUXYXGvgIM9O5kuf5fzrTw0RFI3r6Yq35i
         qgB3SbXtLaFuyhsMVRw7GdpMFn2Ub8K9OTyCZRGSThPhUc9J09LImiU7xqP4KmveSQes
         /bvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735859078; x=1736463878;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eErom6ud3khX44+dOquQHaQg8gNP6zIPpGREZq/z+qw=;
        b=xF8u8K0pALbyVuvEk+s/VTFtExipa3gsebgRCCau/Q5kKObTLtGq+uZ0iK5IDxuKD4
         6pGdSiOKtA6EOINoZvihU741+yHUxW2N4XpE5dCnRxeGFX9qS68uWXIQOwuL/wrHdMMf
         6BQv25BGUiKEY0ZpxuPz3d+GWXeguqjx8dtqEHHZDSWvG9iaYFeRvfh2dW1Ztz2gEMyV
         VHqZuBGdO+3I/QKiHRMAZXVLQrdsJMA0VXaUj+GA1tXwL32ghGpeg6P7ty9iMq+gTjrs
         h9IoKlZnFSqI1UVbCW5kc3D6nYXOhREBArsVdCaHgqRp5h8FMxslUJ7H9AuLVI8hlrQn
         VCGw==
X-Forwarded-Encrypted: i=1; AJvYcCUPMAiftbziZLakKcBRBepGDaIBsMmSMtRrs+E4rbg9lAykQxaXEgobeh75hFOksD0akbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBlkN803g+HAkTBoVIjIVgGl8Ny+ifg6N0bUgzr+OgzSqLWP5T
	N77X6gui7wb+w/aMF8gteqokMuz5Xp1uZdhMc5oovk1QQDJOiTxw
X-Gm-Gg: ASbGnctyMNFNZ8tsLaWGgzdiICdPChZB3J/4QJN06tjy6ttLJxJTZxRgFX90kHrI5Hc
	JtSQThPQa22h9UsGxtQQR/iarpcGv96r3+0mP0CscuGuHmLHjovt8Txf1OEzgZwFqnedQ5iYwno
	hlYIMKBnUQEt1ll02KhBjoBCCYgA2Tpp/apJ+t/NawaVqmzFxW9a1Cql2eT+mxXv/Qz189gZYZZ
	BY3+fy+4jzGBNeiJeR0B58gGbbvB8WbfbzEALWtN+VJkRvDDC9HSQ==
X-Google-Smtp-Source: AGHT+IFFwfROnQot88P95Nsfb5S0XIUJlevJ7EOszaP1eNrhOmAGORWhIboGT43N+6om6px9OsfRUQ==
X-Received: by 2002:a17:902:da8e:b0:216:6a4a:9a47 with SMTP id d9443c01a7336-219da7effd4mr798806555ad.21.1735859077661;
        Thu, 02 Jan 2025 15:04:37 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f447798ab6sm26923314a91.4.2025.01.02.15.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 15:04:37 -0800 (PST)
Message-ID: <64d8a1a7037c9bf1057799c04f2d5bb6bdad3bad.camel@gmail.com>
Subject: Re: Errors compiling BPF programs from Linux selftests/bpf with GCC
From: Eduard Zingerman <eddyz87@gmail.com>
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>, Ihor Solodrai
	 <ihor.solodrai@pm.me>
Cc: "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>, Cupertino Miranda	
 <cupertino.miranda@oracle.com>, David Faust <david.faust@oracle.com>, Elena
 Zannoni <elena.zannoni@oracle.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Manu Bretelle <chantra@meta.com>, Mykola
 Lysenko <mykolal@meta.com>, Yonghong Song	 <yonghong.song@linux.dev>, bpf
 <bpf@vger.kernel.org>
Date: Thu, 02 Jan 2025 15:04:30 -0800
In-Reply-To: <87jzbdim3j.fsf@oracle.com>
References: 
	<ZryncitpWOFICUSCu4HLsMIZ7zOuiH5f4jrgjAh0uiOgKvZzQES09eerwIXNonKEq0U6hdI9pHSCPahUKihTeS8NKlVfkcuiRLotteNbQ9I=@pm.me>
	 <87jzbdim3j.fsf@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-01-02 at 10:47 +0100, Jose E. Marchesi wrote:
> Hi Ihor.
> Thanks for working on this! :)
>=20
> > [...]
> > Older versions compile the dummy program without errors, however on
> > attempt to build the selftests there is a different issue: conflicting
> > int64 definitions (full log at [6]).
> >=20
> >     In file included from /usr/include/x86_64-linux-gnu/sys/types.h:155=
,
> >                      from /usr/include/x86_64-linux-gnu/bits/socket.h:2=
9,
> >                      from /usr/include/x86_64-linux-gnu/sys/socket.h:33=
,
> >                      from /usr/include/linux/if.h:28,
> >                      from /usr/include/linux/icmp.h:23,
> >                      from progs/test_cls_redirect_dynptr.c:10:
> >     /usr/include/x86_64-linux-gnu/bits/stdint-intn.h:27:19: error: conf=
licting types for =E2=80=98int64_t=E2=80=99; have =E2=80=98__int64_t=E2=80=
=99 {aka =E2=80=98long long int=E2=80=99}
> >        27 | typedef __int64_t int64_t;
> >           |                   ^~~~~~~
> >     In file included from progs/test_cls_redirect_dynptr.c:6:
> >     /ci/workspace/bpfgcc.20240922/lib/gcc/bpf-unknown-none/15.0.0/inclu=
de/stdint.h:43:24:
> > note: previous declaration of =E2=80=98int64_t=E2=80=99 with type =E2=
=80=98int64_t=E2=80=99 {aka =E2=80=98long
> > int=E2=80=99}
> >        43 | typedef __INT64_TYPE__ int64_t;
> >           |                        ^~~~~~~
>=20
> I think this is what is going on:
>=20
> The BPF selftest is indirectly including glibc headers from the host
> where it is being compiled.  In this case your x86_64 ubuntu system.
>=20
> Many glibc headers include bits/wordsize.h, which in the case of x86_64
> is:
>=20
>   #if defined __x86_64__ && !defined __ILP32__
>   # define __WORDSIZE	64
>   #else
>   # define __WORDSIZE	32
>   #define __WORDSIZE32_SIZE_ULONG		0
>   #define __WORDSIZE32_PTRDIFF_LONG	0
>   #endif
>=20
> and then in bits/types.h:
>=20
>   #if __WORDSIZE =3D=3D 64
>   typedef signed long int __int64_t;
>   typedef unsigned long int __uint64_t;
>   #else
>   __extension__ typedef signed long long int __int64_t;
>   __extension__ typedef unsigned long long int __uint64_t;
>   #endif
>=20
> i.e. your BPF program ends using __WORDSIZE 32.  This eventually leads
> to int64_t being defined as `signed long long int' in stdint-intn.h, as
> it would correspond to a x86_64 program running in 32-bit mode.
>=20
> GCC BPF, on the other hand, is a "baremetal" compiler and it provides a
> small set of headers (including stdint.h) that implement standard C99
> types like int64_t, adjusted to the BPF architecture.
>=20
> In this case there is a conflict between the 32-bit x86_64 definition of
> int64_t and the one of BPF.
>=20
> PS: the other headers installed by GCC BPF are:
>     float.h iso646.h limits.h stdalign.h stdarg.h stdatomic.h stdbool.h
>     stdckdint.h stddef.h stdfix.h stdint.h stdnoreturn.h syslimits.h
>     tgmath.h unwind.h varargs.h

I wondered how this works with clang, because it does not define
__x86_64__ for bpf target. After staring and the output of -E:
- for clang int64_t is defined once and definition originate from
  /usr/include/bits/stdint-intn.h included from /usr/include/stdint.h;
- for gcc int64_t is defined two times, definitions originate from:
  - <gcc-install-path>/bpf-unknown-none/15.0.0/include/stdint.h
  - /usr/include/bits/stdint-intn.h included from /usr/include/sys/types.h.

So, both refer to stdint-intn.h, but only gcc refers to
compiler-specific stdint.h. This is so because of the structure of the
clang's /usr/lib/clang/19/include/stdint.h:

    ...
    #if __STDC_HOSTED__ && __has_include_next(<stdint.h>)
      ...
      # include_next <stdint.h>
      ...
    #else
      ...
      typedef __INT64_TYPE__ int64_t;
      ...
    #endif
    ...

The __STDC_HOSTED__ is defined as 1, thus when clang compiles the test case=
,
compiler-specific stdint.h is included, but it's content is ifdef'ed out an=
d
it refers to system stdint.h instead. On the other hand, gcc-specific stdin=
t.h
unconditionally typedefs int64_t.

Links:
- test case pre-processed by clang and gcc:
  https://gist.github.com/eddyz87/d381094d67979291bd8338655b15dd5e
- LLVM source code for stdint.h:
  https://github.com/llvm/llvm-project/blob/c703b4645c79e889fd6a0f3f64f01f9=
57d981aa4/clang/lib/Headers/stdint.h#L24


