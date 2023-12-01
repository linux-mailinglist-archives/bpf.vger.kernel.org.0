Return-Path: <bpf+bounces-16471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB17A80158E
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 22:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5581C209E0
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 21:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4773459B5F;
	Fri,  1 Dec 2023 21:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5Ajoc/Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1490E6
	for <bpf@vger.kernel.org>; Fri,  1 Dec 2023 13:38:33 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-54b89582efeso3292271a12.0
        for <bpf@vger.kernel.org>; Fri, 01 Dec 2023 13:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701466712; x=1702071512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+X6LA6fnbldSrBqHIm5XwZXqjr+TWYekkLM47ofNrTk=;
        b=Q5Ajoc/QvcDoo8aVAi3vZsFU99x3EHVs9TRFzf0a1XAtoJ3CjQGJBKzG7r+uu2mi/Y
         VsAkS86JmmABvrrpZ8+FVOrQd1BLM2WGxmjqd9TzPAjbEw93HEdieZKLl01cZV//xBh5
         DCIYWoamytWTpBklN7cCECVN3mJS8SGGAwkfgiCMuNCm7hfNRztEmwH0LabCHoWMbF71
         HN7zDZsS+F++PMVID0ss6X7kvw5mJQvuZzrTkdJ67CWYBCPG/2KOyWoL94jPZn1Z4tVm
         +5gM2W1MLg4pMpcvjoSrNUy66IniEDpa7/44L95A9itjBBmx0CMIwDV62Kl8hG1WylBo
         fCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701466712; x=1702071512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+X6LA6fnbldSrBqHIm5XwZXqjr+TWYekkLM47ofNrTk=;
        b=ikv2NGHqPJLo3q80K5lalXelcott0JVR5KIbewZ+qG/AmsG3gLarAJbyVoRYXwFuJ7
         G9tYoUJ+LUGsl4o4m9zMCHxBC/geknF191STiGQcJJzCvHNUsFBLz1DywGtDYR/dZXSD
         bUyp2+jS1s9nUx22D8iGHegDdVYXhFxniQVQDpYNep4aDjo9reD49p1+QU1rvZdB1j/+
         m2o+jvH/FQ7nn7IEnpUeVIgls7rX96KdMavF2fGf6JA+BKktHMm0iuFSaqslYC6zZK73
         hG8R9ygC+6Kcx7ms7kHvOEfsHPYXY+wCqMJXJE95FIQcrHqenGTiIkFTg9xSwMtMLK9T
         JrPQ==
X-Gm-Message-State: AOJu0YxFR83X73zN2j2PG8MyhJvMJTr8XcXAZfpSZUpaw8JjTWwu7jQU
	XN2f9K/jY7b8Tq3pIzPnrwiU4G2DbgsNGCSw9MsQOnauBX0=
X-Google-Smtp-Source: AGHT+IEfaTyhsA+SdP+SR0zyRDf9VbtXg05t8nPTXcf9dD+cFn61PoQ9IXR2Xj9QxDNZMURmezuYm8g+zD0p+ajDBV8=
X-Received: by 2002:a17:906:bc57:b0:a19:a19b:423d with SMTP id
 s23-20020a170906bc5700b00a19a19b423dmr861685ejv.168.1701466711914; Fri, 01
 Dec 2023 13:38:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87leahx2xh.fsf@oracle.com> <CAEf4BzaTr1-gzEDq4_y6pzFDhTJm1VyyV2jUOEWk1jovOkpD8Q@mail.gmail.com>
 <875y1j81i5.fsf@oracle.com>
In-Reply-To: <875y1j81i5.fsf@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 1 Dec 2023 13:38:19 -0800
Message-ID: <CAEf4BzaRK7rtfuZcjyzNkZONMV7qDXvVRfzU3xiafQ9ABjLwBg@mail.gmail.com>
Subject: Re: BPF GCC status - Nov 2023
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 11:50=E2=80=AFAM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
>
>
> > On Tue, Nov 28, 2023 at 8:23=E2=80=AFAM Jose E. Marchesi
> > <jose.marchesi@oracle.com> wrote:
> >>
> >>
> >> [During LPC 2023 we talked about improving communication between the G=
CC
> >>  BPF toolchain port and the kernel side.  This is the first periodical
> >>  report that we plan to publish in the GCC wiki and send to interested
> >>  parties.  Hopefully this will help.]
> >>
> >
> > [...]
> >
> >> Open Questions
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> - BPF programs including libc headers.
> >>
> >>   BPF programs run on their own without an operating system or a C
> >>   library.  Implementing C implies providing certain definitions and
> >>   headers, such as stdint.h and stdarg.h.  For such targets, known as
> >>   "bare metal targets", the compiler has to provide these definitions
> >>   and headers in order to implement the language.
> >>
> >>   GCC provides the following C headers for BPF targets:
> >>
> >>     float.h
> >>     gcov.h
> >>     iso646.h
> >>     limits.h
> >>     stdalign.h
> >>     stdarg.h
> >>     stdatomic.h
> >>     stdbool.h
> >>     stdckdint.h
> >>     stddef.h
> >>     stdfix.h
> >>     stdint.h
> >>     stdnoreturn.h
> >>     syslimits.h
> >>     tgmath.h
> >>     unwind.h
> >>     varargs.h
> >>
> >>   However, we have found that there is at least one BPF kernel self te=
st
> >>   that include glibc headers that, indirectly, include glibc's own
> >>   definitions of stdint.h and friends.  This leads to compile-time
> >>   errors due to conflicting types.  We think that including headers fr=
om
> >>   a glibc built for some host target is very questionable.  For exampl=
e,
> >>   in BPF a C `char' is defined to be signed.  But if a BPF program
> >>   includes glibc headers in an android system, that code will assume a=
n
> >>   unsigned char instead.
> >>
> >
> > Do you have a list of those tests?
>
> For example:
>
>   progs/test_cls_redirect.c
>   progs/test_cls_redirect_dynptr.c
>   progs/test_cls_redirect_subprogs.c
>
> they include linux/icmp.h that, in turn:
>
>  linux/icmp.h <- linux/if.h <- sys/socket.h <- bits/socket.h <- sys/types=
.h
>
> If BPF programs are expected to be able to liberally include kernel
> headers that, in turn, may include glibc headers, then it is gonna be
> very difficult to consistently avoid these conflicts..

I don't think anyone ever promised this. I think it should be fine to
convert all those tests to use vmlinux.h, but we'll need to add a
bunch of #defines from UAPI headers (like TC_ACT_SHOT). I see we have
tons of those in progs/xdp_synproxy_kern.c, so maybe just extracting
that into a separate header would be enough.

Ideally TC_ACT_SHOT and other stuff is an enum in UAPI and is just
added into vmlinux.h, but someone would need to propose this upstream
and do the changes.

