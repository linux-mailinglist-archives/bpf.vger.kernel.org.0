Return-Path: <bpf+bounces-56624-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6B2A9B41F
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 18:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 121183A8911
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 16:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1073928A3E4;
	Thu, 24 Apr 2025 16:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xbdaz0h6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07079284688;
	Thu, 24 Apr 2025 16:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745512191; cv=none; b=byhM1EtvfVaUGh7S8yfzjfksoadBzv4py80Xdcb7Yj/QIo37llA6Dh61Y3r6TJq73y72j+f6IOv+p3lkxHkXokpW9FDufy7eI0E8Ek+FX8rEB+tbjDObHf27HCMMEUrLoUVaPOAAcuudqvB+x/r1DgWiA3yKJXedQh+S1Gd6FwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745512191; c=relaxed/simple;
	bh=Olfas3kVvORqUXf9lbxFO0QxdMLUwOPQVx90iYtTBKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qzWeKukn1NLAzhjqtFdkTy9j3vHkqf3T8NvaIT1msmXHUAjW7A7O+G+LR6GKi6Sc/4ntJHi1X7AR+4Nc3KV6QLjj1M5RHuH3I5N1UHJOXKkDTTcSbEnA+sOCIwRk0DRkGXt7FP8GFrKeESgFiF7FzTpc/k7RRUIX2i1ofM9/tUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xbdaz0h6; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso1696640b3a.2;
        Thu, 24 Apr 2025 09:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745512189; x=1746116989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svygRFPoJDCFSMtuDuDi9m6ihen4iFSM4c08PMaafg4=;
        b=Xbdaz0h6XHXTQobCCbs0ReaFjreV4oMSt7DxYgWlXNEGzymC755oGyBuH4mVa4+Y67
         itRyY1h96Q4z06EI9pVgrGbcwAYEu1Rzjl5ihHVcO6J6rmEABEdidoM88cGi9QZelQOw
         LC2fNviGbL5eZYWypYLT7vBQXlhsevd1fxpI1rXZrV/4HeBzc4/jZXPnfAEgnyPDTAAn
         tajxHwDSc/GrPQiG03fo8w2dRVK6/o8X9aNnXnIvpQBeSWi2RUyRRhLMFUHbEX6qIP2W
         4JKRX1sZUxpd8aobAvLyDdXs34mxl4Hi3OiFijurys891QSkH6ckvBWkaEowVhUOMLLM
         M6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745512189; x=1746116989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=svygRFPoJDCFSMtuDuDi9m6ihen4iFSM4c08PMaafg4=;
        b=fjewjKEqjsyDlRp1GOFDKceMbcT0uCEJqJ8wV/BUQ7knoKBMJLGdiwGk959scLKDSX
         HDDz8fobl9hrPvqOVFnxR5tCLBw8VLSSehNNJCzAphzahGQEC2pQp+q9V3C+7n9Y5gn8
         sDXPGbpvCmWQTelSO1zFjhZeZuZaeH4s46AhAlYPWi3vPH5DdzbUuaRpfZcQBFbmctRH
         pq5JAv++QvzypTztAHe3WyeewxzwQWtRSpZziTM3PU+9F1G+V+QQu7rNYDTKCj95sAxX
         BHExsvxf5x1JSivyjvm8QdNcXR4Qf6PLwFv6Wh385lFqC9f5IlZaYLBtaxtUdRe9QuF8
         CKWw==
X-Forwarded-Encrypted: i=1; AJvYcCV0ZOPxTFAD0YXxJfcjdy6Adk5RpQJ20gxyCmwjyqR97gjR2EuM2nUJy4ne9xiAU53y3TzgTDmLZvlj2Ax5@vger.kernel.org, AJvYcCVZPfEufOudDrXPsBU6+BS/Dskq1nLpt8BznChxm99+PB0yAyNNIe+uizF10fi6qgvG+BykaGWFl6WqSHdhMrUKmE4g@vger.kernel.org, AJvYcCXXMZCP6jZE5zYvfTPB3wzJRnJ1wUzVfTOPILLoQH4Ldun7ZHeM0e+ep0Cf+htJ4PT9U7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzZ0ziZcyf7TWPfh/jcpB8ABpeEwrAy36SPjCs8vPt6WJD/Wmh
	0sGOqMKC26OyFXfSyubp+Wb7xzR/AJQfcdSDnVtri+sSsatV6aSNns9wnWBTe90KxhytbNhV8rf
	iS/R/7+RM+1lj7O26WhIJV28Qjvw=
X-Gm-Gg: ASbGncvDCVCehniXjhh99B16nN6tTwNUSObQfkKJIBNW7vDALa4RKC75X+IRCXtnU/l
	5/nxmTvtv6iq8/yqbacC2rfaT2aybCW8+UGBn4odC+ZKk52tN6uc2yWTbmvdT3ucmERkgRPhSbE
	526t0rKOVWhHJjOlWwy0xA7G+y6X+yZ0U13qCMCg==
X-Google-Smtp-Source: AGHT+IE/rQQIhva32pBfpB+BSOmHson59ZUUzc3H10bBwmswAMAfAbNO+QRDfnpZKYk1c21Ng7fQ9jcPeUWjEp8hMzs=
X-Received: by 2002:a05:6a00:4ace:b0:736:34ff:be8 with SMTP id
 d2e1a72fcca58-73e330d38d1mr373044b3a.19.1745512189272; Thu, 24 Apr 2025
 09:29:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421214423.393661-1-jolsa@kernel.org> <20250421214423.393661-12-jolsa@kernel.org>
 <CAEf4BzbxCqgPErQVBV7Ojz23ZEqYKvxi0Y4j8hq6FgXVvdQo9A@mail.gmail.com> <aAozU3alQYU0vNkw@krava>
In-Reply-To: <aAozU3alQYU0vNkw@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 24 Apr 2025 09:29:37 -0700
X-Gm-Features: ATxdqUHmgJW-YiXjtRDEVNgydudLQXdw9gxzB8tj7wA1c2MRTKEnTTrY4fDeiOQ
Message-ID: <CAEf4BzagXsyr-iKB=ZpRZ3kS2FE69jpbWa8EVyFJknUOCGtEEQ@mail.gmail.com>
Subject: Re: [PATCH perf/core 11/22] selftests/bpf: Use 5-byte nop for x86
 usdt probes
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, David Laight <David.Laight@aculab.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 5:49=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Wed, Apr 23, 2025 at 10:33:18AM -0700, Andrii Nakryiko wrote:
> > On Mon, Apr 21, 2025 at 2:46=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wr=
ote:
> > >
> > > Using 5-byte nop for x86 usdt probes so we can switch
> > > to optimized uprobe them.
> > >
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  tools/testing/selftests/bpf/sdt.h | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > >
> >
> > So sdt.h is an exact copy/paste from systemtap-sdt sources. I'd prefer
> > to not modify it unnecessarily.
> >
> > How about we copy/paste usdt.h ([0]) and use *that* for your
> > benchmarks? I've already anticipated the need to change nop
> > instruction, so you won't even need to modify the usdt.h file itself,
> > just
> >
> > #define USDT_NOP .byte 0x0f, 0x1f, 0x44, 0x00, 0x00
> >
> > before #include "usdt.h"
>
>
> sounds good, but it seems we need bit more changes for that,
> so far I ended up with:
>
> -       __usdt_asm1(990:        USDT_NOP)                                =
                       \
> +       __usdt_asm5(990:        USDT_NOP)                                =
                       \
>
> but it still won't compile, will need to spend more time on that,
> unless you have better solution
>

Use

#define USDT_NOP .ascii "\x0F\x1F\x44\x00\x00"

for now, I'll need to improve macro magic to handle instructions with
commas in them...

> thanks,
> jirka
>
> >
> >
> >   [0] https://github.com/libbpf/usdt/blob/main/usdt.h
> >
> > > diff --git a/tools/testing/selftests/bpf/sdt.h b/tools/testing/selfte=
sts/bpf/sdt.h
> > > index 1fcfa5160231..1d62c06f5ddc 100644
> > > --- a/tools/testing/selftests/bpf/sdt.h
> > > +++ b/tools/testing/selftests/bpf/sdt.h
> > > @@ -236,6 +236,13 @@ __extension__ extern unsigned long long __sdt_un=
sp;
> > >  #define _SDT_NOP       nop
> > >  #endif
> > >
> > > +/* Use 5 byte nop for x86_64 to allow optimizing uprobes. */
> > > +#if defined(__x86_64__)
> > > +# define _SDT_DEF_NOP _SDT_ASM_5(990:  .byte 0x0f, 0x1f, 0x44, 0x00,=
 0x00)
> > > +#else
> > > +# define _SDT_DEF_NOP _SDT_ASM_1(990:  _SDT_NOP)
> > > +#endif
> > > +
> > >  #define _SDT_NOTE_NAME "stapsdt"
> > >  #define _SDT_NOTE_TYPE 3
> > >
> > > @@ -288,7 +295,7 @@ __extension__ extern unsigned long long __sdt_uns=
p;
> > >
> > >  #define _SDT_ASM_BODY(provider, name, pack_args, args, ...)         =
         \
> > >    _SDT_DEF_MACROS                                                   =
         \
> > > -  _SDT_ASM_1(990:      _SDT_NOP)                                    =
         \
> > > +  _SDT_DEF_NOP                                                      =
         \
> > >    _SDT_ASM_3(          .pushsection .note.stapsdt,_SDT_ASM_AUTOGROUP=
,"note") \
> > >    _SDT_ASM_1(          .balign 4)                                   =
         \
> > >    _SDT_ASM_3(          .4byte 992f-991f, 994f-993f, _SDT_NOTE_TYPE) =
         \
> > > --
> > > 2.49.0
> > >

