Return-Path: <bpf+bounces-16318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF87E7FFB00
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 20:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BC46281A09
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 19:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A067F5FF18;
	Thu, 30 Nov 2023 19:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F87pS9Nq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84F8D48
	for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 11:16:49 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a00a9c6f1e9so185871366b.3
        for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 11:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701371808; x=1701976608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jeTP3gOsW+Bv/viFO3ktvAMv3Kdgjv0u55TMCTkoUbA=;
        b=F87pS9NqGY0C8a+SserCRLVptcB/91UVsoWCeoKYg90ehEEhonfp2pq2zNRMs1MUaH
         dn4u4fC2KA9LPVDlyXdBOvJBlNxpqJGtZxxvopgYxT1fZOrTXeo0qSyuBBvDei2cgdVA
         oC+mlaQRK9kP2zr8wUpSuMJNadsRe2F1ajZv5JU/Z71nZkv29r/Ium1uQsSifeqwYOMP
         FCiolQP3HQNIKLfTxOJjJd1xtz0gc6UkONP05queU0+jMk72iBOUAFz+pWzSN/Ekp3vw
         fjKoZSif53PGTKE30GWqb3gX/2S9fa0EXic81/CvWyXNIsuJiqjWLl+XkMV4RhtAQjEO
         y31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701371808; x=1701976608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jeTP3gOsW+Bv/viFO3ktvAMv3Kdgjv0u55TMCTkoUbA=;
        b=Np/3r/EcTAiIDxTh7AH2Rg3UNjMcIRp/0m1YoPDDEBerrSO5JDva8tzaU0/FlPQxib
         0fItSy81bxDWWRDZzV1zY8jeTCQyFO647IziGmf/hbhFy41Z+IPViIK35UOHLlqqtqQk
         Hms8EoLbZ9t7+lZKnP6O3phBmkRDqg80s8NCBGGHYGXDzCxM68nMC4ecRpWVpPE+yGHb
         CmSN5OdVUTPk9RgelZmvAyUhL7TsJkW0UWC0LA75HtdH54vgqd+nMRGmvlAB6wvyoI6I
         ZRmxY42kSVhsjT3WDmKEMYZwNjpdO9+pmuNOk/QpxB22iS95fNG1FBXmyPJYU7KRM/9A
         iJIQ==
X-Gm-Message-State: AOJu0Yw2hrjolqjAbp6Xr1rpOWFekG7RMy30kN085PpA1IOVTleBtPCS
	oPBNRzMm0Q9iVEPhbDgWEr3u5U+fMrrEvChIsvNInb0L
X-Google-Smtp-Source: AGHT+IFuw5z66GU5vJ4WdcIWiMotKlgfoS4vYuP5XFoY+IRJjStrV6OSu6jtxinwMX6o//5KNMrs8ejPTYBIlN2c6XU=
X-Received: by 2002:a17:906:b7ca:b0:a19:a19b:78c4 with SMTP id
 fy10-20020a170906b7ca00b00a19a19b78c4mr7105ejb.135.1701368880887; Thu, 30 Nov
 2023 10:28:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87leahx2xh.fsf@oracle.com>
In-Reply-To: <87leahx2xh.fsf@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 30 Nov 2023 10:27:49 -0800
Message-ID: <CAEf4BzaTr1-gzEDq4_y6pzFDhTJm1VyyV2jUOEWk1jovOkpD8Q@mail.gmail.com>
Subject: Re: BPF GCC status - Nov 2023
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 8:23=E2=80=AFAM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
>
>
> [During LPC 2023 we talked about improving communication between the GCC
>  BPF toolchain port and the kernel side.  This is the first periodical
>  report that we plan to publish in the GCC wiki and send to interested
>  parties.  Hopefully this will help.]
>

[...]

> Open Questions
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> - BPF programs including libc headers.
>
>   BPF programs run on their own without an operating system or a C
>   library.  Implementing C implies providing certain definitions and
>   headers, such as stdint.h and stdarg.h.  For such targets, known as
>   "bare metal targets", the compiler has to provide these definitions
>   and headers in order to implement the language.
>
>   GCC provides the following C headers for BPF targets:
>
>     float.h
>     gcov.h
>     iso646.h
>     limits.h
>     stdalign.h
>     stdarg.h
>     stdatomic.h
>     stdbool.h
>     stdckdint.h
>     stddef.h
>     stdfix.h
>     stdint.h
>     stdnoreturn.h
>     syslimits.h
>     tgmath.h
>     unwind.h
>     varargs.h
>
>   However, we have found that there is at least one BPF kernel self test
>   that include glibc headers that, indirectly, include glibc's own
>   definitions of stdint.h and friends.  This leads to compile-time
>   errors due to conflicting types.  We think that including headers from
>   a glibc built for some host target is very questionable.  For example,
>   in BPF a C `char' is defined to be signed.  But if a BPF program
>   includes glibc headers in an android system, that code will assume an
>   unsigned char instead.
>

Do you have a list of those tests?

