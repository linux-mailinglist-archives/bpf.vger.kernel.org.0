Return-Path: <bpf+bounces-47750-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 271509FFCC9
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 18:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3BBC162864
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 17:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FA5176AC8;
	Thu,  2 Jan 2025 17:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="GNR5ZvB5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6298D8BE5
	for <bpf@vger.kernel.org>; Thu,  2 Jan 2025 17:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735839337; cv=none; b=Qrp87SHOl00icmePbe9TRDKC1Bm2APltRDB6OtJiyMZva9GCk3BPbGItciRsXykhmvJbm3bTtq0Ffy0y/oi4DDL+5Rdhv724S4vJuHFyEnMLjZAkRJ5TjOi0z0qrBKN1Kqx+2MmS/8i8EQrEoe/MxZO+X10CQKat0nXfPfGZH94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735839337; c=relaxed/simple;
	bh=S5xoB7BjA7vWYX3gcMUfXNXoUWc2y8Q1OPLLhXt6CQg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=li3u3BXPJWlCiqVmhmnItZej0i64I3HieONmRg6h6dBpaR4vJ54kl91kXU7TnHQyjvvuw/dpX/TioluoAaGKlVNbzC/gW9tJiHwOlzWs7HGFLDl6NdJr0pOKfcjpkkEtwhgOyjEuQ78Sq4qoEPhCqnTM2BqXMKJJtYNeT6AfCLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=GNR5ZvB5; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1735839319; x=1736098519;
	bh=5squofcFsWmgipTOxgUzAU14aR0AJtAppRgHGhH/BUg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=GNR5ZvB5dTFcT+enRf14SCatStdPI9nMaHdCFLmKRudPUSgUamdPkyXjpodaq4tmA
	 1qrVDdR2+w8h7fiB8f4QBMoG70rfgO6RmeySzEl5z/QCAAQov56VyN4bR1E+yMfq+z
	 ojjM5c7movUO3VzA2EVy0qdWGtq0hGH3iejOzXJqf3v8xyl8samqoaCt94FDOH27Vl
	 rGIm5EyUCMEoMOQ+UBGEiXz1ADKM7192jOvWW+hvwlg/82o2Ke0P06Xyb7lWIX3l6J
	 p3NrEd6FoVQASdyHh324TwHmmFPhO4FvOn/GFzrJswSZDpsEC34iZ7QJfG09WOE2NL
	 mURLW5ieW22ew==
Date: Thu, 02 Jan 2025 17:35:14 +0000
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>, Cupertino Miranda <cupertino.miranda@oracle.com>, David Faust <david.faust@oracle.com>, Elena Zannoni <elena.zannoni@oracle.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, Manu Bretelle <chantra@meta.com>, Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@meta.com>, Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>
Subject: Re: Errors compiling BPF programs from Linux selftests/bpf with GCC
Message-ID: <HfONx8uvT8UvgKSa4GGd2dyrUNHSFTv6VHMDSeCw0849N7REwVvl5MGyyvEmVIIQRcQIEf_-fyr6TcLJodeWdczujiEqrUZKJzX3sfhrPwA=@pm.me>
In-Reply-To: <87jzbdim3j.fsf@oracle.com>
References: <ZryncitpWOFICUSCu4HLsMIZ7zOuiH5f4jrgjAh0uiOgKvZzQES09eerwIXNonKEq0U6hdI9pHSCPahUKihTeS8NKlVfkcuiRLotteNbQ9I=@pm.me> <87jzbdim3j.fsf@oracle.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: fd7c4644d30f945c7d58b767252cdb433c25061b
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thursday, January 2nd, 2025 at 1:47 AM, Jose E. Marchesi <jose.marchesi@=
oracle.com> wrote:

> Hi Ihor.
> Thanks for working on this! :)
>=20
> > [...]
> > Older versions compile the dummy program without errors, however on
> > attempt to build the selftests there is a different issue: conflicting
> > int64 definitions (full log at [6]).
> >=20
> > In file included from /usr/include/x86_64-linux-gnu/sys/types.h:155,
> > from /usr/include/x86_64-linux-gnu/bits/socket.h:29,
> > from /usr/include/x86_64-linux-gnu/sys/socket.h:33,
> > from /usr/include/linux/if.h:28,
> > from /usr/include/linux/icmp.h:23,
> > from progs/test_cls_redirect_dynptr.c:10:
> > /usr/include/x86_64-linux-gnu/bits/stdint-intn.h:27:19: error: conflict=
ing types for =E2=80=98int64_t=E2=80=99; have =E2=80=98__int64_t=E2=80=
=99 {aka =E2=80=98long long int=E2=80=99}
> > 27 | typedef __int64_t int64_t;
> > | ^~~~~~~
> > In file included from progs/test_cls_redirect_dynptr.c:6:
> > /ci/workspace/bpfgcc.20240922/lib/gcc/bpf-unknown-none/15.0.0/include/s=
tdint.h:43:24:
> > note: previous declaration of =E2=80=98int64_t=E2=80=99 with type =
=E2=80=98int64_t=E2=80=99 {aka =E2=80=98long
> > int=E2=80=99}
> > 43 | typedef INT64_TYPE int64_t;
> > | ^~~~~~~
>=20
>=20
> I think this is what is going on:
>=20
> The BPF selftest is indirectly including glibc headers from the host
> where it is being compiled. In this case your x86_64 ubuntu system.
>=20
> Many glibc headers include bits/wordsize.h, which in the case of x86_64
> is:
>=20
> #if defined x86_64 && !defined ILP32
> # define __WORDSIZE 64
> #else
> # define __WORDSIZE 32
> #define __WORDSIZE32_SIZE_ULONG 0
> #define __WORDSIZE32_PTRDIFF_LONG 0
> #endif
>=20
> and then in bits/types.h:
>=20
> #if __WORDSIZE =3D=3D 64
> typedef signed long int __int64_t;
> typedef unsigned long int __uint64_t;
> #else
> extension typedef signed long long int __int64_t;
> extension typedef unsigned long long int __uint64_t;
> #endif
>=20
> i.e. your BPF program ends using __WORDSIZE 32. This eventually leads
> to int64_t being defined as `signed long long int' in stdint-intn.h, as
> it would correspond to a x86_64 program running in 32-bit mode.
>=20
> GCC BPF, on the other hand, is a "baremetal" compiler and it provides a
> small set of headers (including stdint.h) that implement standard C99
> types like int64_t, adjusted to the BPF architecture.
>=20
> In this case there is a conflict between the 32-bit x86_64 definition of
> int64_t and the one of BPF.

Hi Jose, thanks for breaking this down.

I was able to mitigate int64_t declaration conflict by passing
-nostdinc to gcc.

Currently system-installed headers are being passed via -idirafter in
a compilation command:

    /ci/workspace/bpfgcc.20241229/bin/bpf-unknown-none-gcc \
        -g -Wall -Werror -D__TARGET_ARCH_x86 -mlittle-endian \
        -I/ci/workspace/tools/testing/selftests/bpf/tools/include
        -I/ci/workspace/tools/testing/selftests/bpf \
        -I/ci/workspace/tools/include/uapi \
        -I/ci/workspace/tools/testing/selftests/usr/include \
        -Wno-compare-distinct-pointer-types \
        -idirafter /usr/lib/gcc/x86_64-linux-gnu/13/include \
        -idirafter /usr/local/include \
        -idirafter /usr/include/x86_64-linux-gnu \
        -idirafter /usr/include \
        -DBPF_NO_PRESERVE_ACCESS_INDEX \
        -Wno-attributes \
        -O2 -std=3Dgnu17 \                  # -nostdinc here helps
        -c progs/test_cls_redirect.c \
        -o /ci/workspace/tools/testing/selftests/bpf/bpf_gcc/test_cls_redir=
ect.bpf.o

Passing -nostdinc makes gcc to pick compiler-installed header, if I
understand correctly.

>=20
> PS: the other headers installed by GCC BPF are:
> float.h iso646.h limits.h stdalign.h stdarg.h stdatomic.h stdbool.h
> stdckdint.h stddef.h stdfix.h stdint.h stdnoreturn.h syslimits.h
> tgmath.h unwind.h varargs.h

From your comments, it seems that BPF programs *must not* include
system glibc headers when compiled with GCC. Or is this only true for
the headers you listed above?

I wonder what is the proper way to build BPF programs with gcc then.
In the source code the includes are what you'd expect:

    #include <stdbool.h>
    #include <stddef.h>
    #include <stdint.h>       // conflict is between this
    #include <string.h>

    #include <linux/bpf.h>
    #include <linux/icmp.h>   // and this
    #include <linux/icmpv6.h>
    ...

Any suggestions?

Thanks.


