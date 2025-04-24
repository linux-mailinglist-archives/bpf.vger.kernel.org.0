Return-Path: <bpf+bounces-56633-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C1DA9B650
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 20:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6A261B64039
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 18:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17AD2900A1;
	Thu, 24 Apr 2025 18:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAjQiv2S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9937A28F501;
	Thu, 24 Apr 2025 18:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745518831; cv=none; b=Eun4wbMEbhfXoubq9WXr2LVCCXWRkFIz0O+xRUbyjbnNs++xs6MdDBmpc23ijLAm5VY7yh+Qu/JvVdDRveOHbcUWMfMnY9W+dch02l2Iw1IW1EhVX0agYxp7Bh1iz5OkvQ4Rl9LTku/LCYe7RSNNvx112MEFwAB0eNwipVwBNAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745518831; c=relaxed/simple;
	bh=ovtahvZEMFGVaxFa2bucb/xvKBh6g0ARBv2BYQjMjDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LKeGK0BmpQ6AcQscFRN/UrAjHpnv4g0cX4c/tg0DGdbwhWhVlVb/hP/SA21pmvmmSy4gA931EWuCOXdfr3ZMQRxr5Ly7NFZPeTIiF3ABdlJ953NA75GXVkVqVhVQRKivE6+PBqM2V1T3tqL+fHZHJstswx1idwlg1elmjfYs6dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XAjQiv2S; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9eb12so1983669a12.1;
        Thu, 24 Apr 2025 11:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745518828; x=1746123628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ke2htjOdEMv6+V6OvVMVgB0NcfIGZYBPjYHJTWyZADc=;
        b=XAjQiv2SpQDJsx59fz3RHdpEZTs4yccCrUHYl81EnMSTL7HzEc6Hp30B2qMagS1yUk
         0UKPQ69tsMPKU57T/R0J8cicN9qM+yWragLnzLsLI8UDzGBv8jrYg9IOZdPlIYRVJbuv
         aCx9JwWOq+LEwRv0l5F6WP2dXdoRT9SCo4loNq7dxhTrbFDtn6w8NDdmLkM958xWXDAz
         Jm+CjiHNMR4ZYmmUCxwB9LsLa7JJHxSKEWLtUSnpZU1C6DWReYKXNAKw/73r5gieWpX5
         I+Uw0SJChAMFl7/CLxn0nLhxWEnIL5wXMHZpjbyzQv8hLZS+mh5iZh337HpWaJNSIx1a
         Yp+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745518828; x=1746123628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ke2htjOdEMv6+V6OvVMVgB0NcfIGZYBPjYHJTWyZADc=;
        b=LG/KlbRfXrn9UgSotVYvgLlpo3Xn6XQDIHE/0SozBNqfPUHFNsarbjReTSPJMgGEtz
         4CCsn5g7duul5ISyCEe1Fz8ouijYSMu6u13x40nXuIJH9UDxt9jytcwN4cltnO+ItYOx
         e1Mj1jDZJMJpMKf9eS0C4Res+GvsX9SVjjyMiOFLfp6hm2XUh2sj/F6Qh2sgEeHFNhWm
         ijixs1SZtwD9yQmDBub0O9nmtC0ynHkET+nv1oPIdgAzO0ndwb5jFDQ4UK4nLj77aceE
         SoqP9BrWBtlaTlxr5QB4vfQVHrn16fkvVFFcYPtJGxMtkOLnlA82OKCxzM8ngTBKE8Ge
         lM6g==
X-Forwarded-Encrypted: i=1; AJvYcCVq62dUwgqVM09/jqqGRY+Q+jK/KYSh2qLpcW0rp81zAzcXOXykeTkSDtag6zbmtfko9D4=@vger.kernel.org, AJvYcCWm77gpdd5r6VBV6St7XuVz+ud/OfAWLjrKB8mVghQig6cpxOT4aM1AMPeW0sxDPDLNc9+fGKwcG/TBcmsR@vger.kernel.org, AJvYcCXicugOk0ls+iPwFyz4WAZfptq0lD+f0IDVW6PHy8/OzAPbn30BvQODMYRjHYoqUH5DLdgIMmTVI93tFAoO5iNBFKCc@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf/Dm0YDMGQF/oQ3kN9SBxyFWiGG6jVWwuyL31+R6k/bXGU7F2
	HAO6WnEsaQAiiUtw4EkN0TriQKl1VQeBYsfvw3H6p+04jh7t3bYFWh9s+io6qrvyalWqdEFkwsD
	MEfT+AoxBJickmMpmHUsG0bOClCg=
X-Gm-Gg: ASbGncsEW9jsgm8vkwntoplyarSiMqIvtV9P5PUZvDiD9gWKGQdIw69vMHxJViY26ZV
	pwkehkuoOKpJXU3hCeF0b7Cy24UdVkeEbv4ygdvIn6wyojKVPbykFoFZ1T5kH8wzMtD4ht1pNrW
	uf/C4jOCi1os7zDXEzZz45Diw+FiGnn21uDgzNWA==
X-Google-Smtp-Source: AGHT+IH+fKYgMGLfkoH2vGq+xgfLWSkrv6VeyRaPXLdDZWrjcNaSURF8L8kxg23mdNkeyXcNVPDPY78ZQV6r+LUoNkY=
X-Received: by 2002:a17:906:1615:b0:ace:6bfb:4a12 with SMTP id
 a640c23a62f3a-ace6bfb4a2amr39389966b.7.1745518827594; Thu, 24 Apr 2025
 11:20:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421214423.393661-1-jolsa@kernel.org> <20250421214423.393661-12-jolsa@kernel.org>
 <CAEf4BzbxCqgPErQVBV7Ojz23ZEqYKvxi0Y4j8hq6FgXVvdQo9A@mail.gmail.com>
 <aAozU3alQYU0vNkw@krava> <CAEf4BzagXsyr-iKB=ZpRZ3kS2FE69jpbWa8EVyFJknUOCGtEEQ@mail.gmail.com>
In-Reply-To: <CAEf4BzagXsyr-iKB=ZpRZ3kS2FE69jpbWa8EVyFJknUOCGtEEQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 24 Apr 2025 11:20:11 -0700
X-Gm-Features: ATxdqUGbvPzCaaRKhboVgR-vCppiSUq1JwIJG-nhSV_mJEgjvx-79vVkaf0nB0s
Message-ID: <CAEf4BzZvwH2GR6cr8EN8Up02tHBkGij_1v6UNPcKaVFATmKvUQ@mail.gmail.com>
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

On Thu, Apr 24, 2025 at 9:29=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Apr 24, 2025 at 5:49=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wr=
ote:
> >
> > On Wed, Apr 23, 2025 at 10:33:18AM -0700, Andrii Nakryiko wrote:
> > > On Mon, Apr 21, 2025 at 2:46=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> =
wrote:
> > > >
> > > > Using 5-byte nop for x86 usdt probes so we can switch
> > > > to optimized uprobe them.
> > > >
> > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > ---
> > > >  tools/testing/selftests/bpf/sdt.h | 9 ++++++++-
> > > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > >
> > >
> > > So sdt.h is an exact copy/paste from systemtap-sdt sources. I'd prefe=
r
> > > to not modify it unnecessarily.
> > >
> > > How about we copy/paste usdt.h ([0]) and use *that* for your
> > > benchmarks? I've already anticipated the need to change nop
> > > instruction, so you won't even need to modify the usdt.h file itself,
> > > just
> > >
> > > #define USDT_NOP .byte 0x0f, 0x1f, 0x44, 0x00, 0x00
> > >
> > > before #include "usdt.h"
> >
> >
> > sounds good, but it seems we need bit more changes for that,
> > so far I ended up with:
> >
> > -       __usdt_asm1(990:        USDT_NOP)                              =
                         \
> > +       __usdt_asm5(990:        USDT_NOP)                              =
                         \
> >
> > but it still won't compile, will need to spend more time on that,
> > unless you have better solution
> >
>
> Use
>
> #define USDT_NOP .ascii "\x0F\x1F\x44\x00\x00"
>
> for now, I'll need to improve macro magic to handle instructions with
> commas in them...

Ok, fixed in [0]. If you get the latest version, the .byte approach
will work (I have tests in CI now to validate this).

  [0] https://github.com/libbpf/usdt/pull/12

>
> > thanks,
> > jirka
> >
> > >
> > >
> > >   [0] https://github.com/libbpf/usdt/blob/main/usdt.h
> > >
> > > > diff --git a/tools/testing/selftests/bpf/sdt.h b/tools/testing/self=
tests/bpf/sdt.h
> > > > index 1fcfa5160231..1d62c06f5ddc 100644
> > > > --- a/tools/testing/selftests/bpf/sdt.h
> > > > +++ b/tools/testing/selftests/bpf/sdt.h
> > > > @@ -236,6 +236,13 @@ __extension__ extern unsigned long long __sdt_=
unsp;
> > > >  #define _SDT_NOP       nop
> > > >  #endif
> > > >
> > > > +/* Use 5 byte nop for x86_64 to allow optimizing uprobes. */
> > > > +#if defined(__x86_64__)
> > > > +# define _SDT_DEF_NOP _SDT_ASM_5(990:  .byte 0x0f, 0x1f, 0x44, 0x0=
0, 0x00)
> > > > +#else
> > > > +# define _SDT_DEF_NOP _SDT_ASM_1(990:  _SDT_NOP)
> > > > +#endif
> > > > +
> > > >  #define _SDT_NOTE_NAME "stapsdt"
> > > >  #define _SDT_NOTE_TYPE 3
> > > >
> > > > @@ -288,7 +295,7 @@ __extension__ extern unsigned long long __sdt_u=
nsp;
> > > >
> > > >  #define _SDT_ASM_BODY(provider, name, pack_args, args, ...)       =
           \
> > > >    _SDT_DEF_MACROS                                                 =
           \
> > > > -  _SDT_ASM_1(990:      _SDT_NOP)                                  =
           \
> > > > +  _SDT_DEF_NOP                                                    =
           \
> > > >    _SDT_ASM_3(          .pushsection .note.stapsdt,_SDT_ASM_AUTOGRO=
UP,"note") \
> > > >    _SDT_ASM_1(          .balign 4)                                 =
           \
> > > >    _SDT_ASM_3(          .4byte 992f-991f, 994f-993f, _SDT_NOTE_TYPE=
)          \
> > > > --
> > > > 2.49.0
> > > >

