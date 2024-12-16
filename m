Return-Path: <bpf+bounces-47071-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 962149F3E02
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 00:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FD50188B04E
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 23:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C941D8A0D;
	Mon, 16 Dec 2024 23:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9OuH+Uw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4D21C2443;
	Mon, 16 Dec 2024 23:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734390406; cv=none; b=cYWp3eg1Ceet5q2tsHYuh7ODTb6bEIRahXgoYxsZRyrtwqzaNsHvlcHS2cvhMw/NuiO3dokDfuF8X7ydoDn1WbZPVMcYbH2ckGq2jQWBxZmGxhgMLlkodWfUinintc8gVZ5fYAscdc0ftfU8+DkHKBf7RVWPdz7FDbXOYEstGcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734390406; c=relaxed/simple;
	bh=XViO+42NWnjzyQO61fcvOJnS84RLr7LvMIMEyMY0Q6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DRQDir8LdQ9YD8xACfmN6M2WGqgorxS13HXJMKU7TF78yvGJKmIBV+X4JKM1hzXHTniUgd24f/580hCeS7qbjuo+bdtSnOTZ5WfzTnJLLR6GT/ZPiA0K3MgBzl8BGwSRXrP/ig/FuQgzLAK8NH6OlIhM3Se066ezAJrn9uotpZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9OuH+Uw; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7fd526d4d9eso3621213a12.2;
        Mon, 16 Dec 2024 15:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734390404; x=1734995204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6AwwXdVIUIDxD5QGpknBLkBjHpgULJY8BfiRR8CmjI=;
        b=P9OuH+UwdDpFUd35iTquw4MePlnNLyFIHK3kBJc+OadQ/IAMbTzy8oMmvIwZUD7sJr
         QqhwLsMSXU2aA1HUocMax+lU4jOF/nOpu62z/OCnAKYLPMxQfVN6RLqADVnb7K7vijlV
         ePlEKWzpwjDCB0zLLG2jABLICCUtOx1oXQiF5drB3Drm3FYb8N30GnY/BwlFPyZg8lvd
         TFuvHi1WcJeROHv6kq6/ckWOd+RMmjU41/Xie6NDo7mcs6Tr6iYViO72/AmRtnoH/znZ
         0l5v9M0GOHkxgIB7wz7d3vsJX+GwIUlUpjMqmBEcb3QPvBTpFzyg7JkcWWLX/7zJc7js
         0T4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734390404; x=1734995204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6AwwXdVIUIDxD5QGpknBLkBjHpgULJY8BfiRR8CmjI=;
        b=HbHH8L+LNCxwuWaBCKER6fl4fxsHbgitEBg7wa63eGKoZ3oef4jk9fUpOaez/MLbYc
         cwNrQRJW89Czc5kWW7NOPw9/kFbtGLW7/97SIdoi08+cCHeDR47NMyj2DCg0aNv2WqnY
         u76f7F/8mmIOLiTFYgGg8t1+Ge9B0ZUWmb6VOXPW4BrunqjWFqn81A55AdgViu8d8PyI
         Gwz2SrCwIwZKmp/sIBhkA/RO4d73S/Kk7IG8wcjJNnK+nPpZ7cFBnxE6280blU4tJWkg
         1t4IvWSNLVhGyPKru0eI/+oqf12WAUib2IDxegzDxGARmL8DHM7idPh8tgvHnUx9bgio
         80QQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGWBSdO7N9g97i3CWnbr6HDg4lp5ujftDUg4o1gvcEkUjg3+PZqUQXB/bLlnZFR2blfRqMqJBVcPJQFYK4WKwrqMsu@vger.kernel.org, AJvYcCUQvNCOVB1dJNCCDIrUnogfaC1ZbCnte4MUh4SjLWjl3EVBeYBcJIIc/ZDvncMeTy9Nkes=@vger.kernel.org, AJvYcCWJXsunNfRtgtUu3aCPZX/o5ly5HqwRPSbuBz4Dtif4Kskv9NG8vvUPjXu+CyJBrsJ7SucIxP8jJd/VQrQF@vger.kernel.org
X-Gm-Message-State: AOJu0YyGRx4eW4awIToQGW9scm2CWWcZ7wEIkrKpzMe0fKrHsvBF8l0c
	TZMHq4x1NO29YFwqpXJNTdnHDMgRyVvUvQyvw6FaH2ZHWN3o8TkJXCraSVHCc9x2t3uFCNMYdlv
	XjTNVXwbE6mlPcnfRxfOfI98uvlo=
X-Gm-Gg: ASbGncvX/ZuYQtwGJ3bR0nZcgUWipEsOEuAYHIX3RbcTIUEHcnjfnKrlPB7oVDTpdfP
	OvPdcgmDtwzkPDcZKoSJl0NusTw49bM360fVpv9HGtuqKWfYwdWzdhg==
X-Google-Smtp-Source: AGHT+IH+HYfX+z2sBU/Aq1/t0RlB8BnwArkL3cFYy7RfzJincOtmLqu7QE5bFAzEEZkYak5eoEGUUkPvvTfxyjdwXQA=
X-Received: by 2002:a17:90b:3e88:b0:2ea:5054:6c49 with SMTP id
 98e67ed59e1d1-2f28f8691ebmr23957915a91.0.1734390404647; Mon, 16 Dec 2024
 15:06:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211133403.208920-1-jolsa@kernel.org> <20241211133403.208920-10-jolsa@kernel.org>
 <CAEf4BzbF1Ei-MkKOM9N2nCRspVXpVLhpAYZFaaOUpDJ4HgJ6jA@mail.gmail.com> <Z1_ll7ArngBWpx4N@krava>
In-Reply-To: <Z1_ll7ArngBWpx4N@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 16 Dec 2024 15:06:32 -0800
Message-ID: <CAEf4BzbTjk-C_PL0nGjH9jG3snxesKL5fSf46=2Y_FxeFUjB=Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 09/13] selftests/bpf: Use 5-byte nop for x86 usdt probes
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 12:32=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wro=
te:
>
> On Fri, Dec 13, 2024 at 01:58:33PM -0800, Andrii Nakryiko wrote:
> > On Wed, Dec 11, 2024 at 5:35=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wr=
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
> > This change will make it impossible to run latest selftests on older
> > kernels. Let's do what we did with -DENABLE_ATOMICS_TESTS and allow to
> > disable this through Makefile, ok?
>
> ok, I wanted to start addressing this after this version
>
> so the problem is using this macro with nop5 in application running
> on older kernels that do not have nop5 emulation and uprobe syscall
> optimization, because uprobe/usdt on top of nop5 (single-stepped)
> will be slower than on top of current nop1 (emulated)
>
> AFAICS selftests should still work, just bit slower due to nop5 emulation

ah, fair enough, it won't break anything, true

>
> one part of the solution would be to backport [1] to stable kernels
> which is an easy fix (even though it needs changes now)
>
> if that's not enough we'd need to come up with that nop1/nop5 macro
> solution, where tooling (libbpf with extra data in usdt note) would
> install uprobe on top of nop1 on older kernels and on top of nop5 on
> new ones.. but that'd need more work of course

yes, I think that's the way we should go, but as you said, that's
outside of kernel and we should work on that as a follow up to this
series

>
> jirka
>
>
> [1] patch#7 - uprobes/x86: Add support to emulate nop5 instruction
>
>
> >
> >
> > > diff --git a/tools/testing/selftests/bpf/sdt.h b/tools/testing/selfte=
sts/bpf/sdt.h
> > > index ca0162b4dc57..7ac9291f45f1 100644
> > > --- a/tools/testing/selftests/bpf/sdt.h
> > > +++ b/tools/testing/selftests/bpf/sdt.h
> > > @@ -234,6 +234,13 @@ __extension__ extern unsigned long long __sdt_un=
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
> > > @@ -286,7 +293,7 @@ __extension__ extern unsigned long long __sdt_uns=
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
> > > 2.47.0
> > >

