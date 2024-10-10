Return-Path: <bpf+bounces-41565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1DF998532
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 13:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D8421F22F53
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 11:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B4A1C7B85;
	Thu, 10 Oct 2024 11:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/+ROxQT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C231C5782;
	Thu, 10 Oct 2024 11:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728560309; cv=none; b=njDwWUCd8bPp68+YfxR6uBtelnFa2jW6ebNIMt4BJI5iPBwJ3+RazR+q/GwcRRxkYSzrCXrMaMXdl/YCJfVaMCGtq//Uz3OgJxdeAdIHgvjYmNCboKhAJW4zCFOcVk3WSnY9BY51mgDLqgcLnlo2zJnM3Hq6HOOUdbRorJamShw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728560309; c=relaxed/simple;
	bh=EcW7dk1wSWnuz/T49S8ao1gJh4OZbqwJI580xsjo+jw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jChD+ZdEw9m4q+EjP3RhRVuEIc/mkMDP4y21Pa2PlAj8q6B6ArPM3h8LvPYyj/s/TW91vJeN+v3/SR6ohdU3V+J1HkSDutAMecakJIatGZ0XznT7fw77BEFKt4XdfuBPw7mT2p1hvOjS4KvI5mxkxGQfkGCUHaj4dKgCBFN/asw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/+ROxQT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CCF8C4CECD;
	Thu, 10 Oct 2024 11:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728560308;
	bh=EcW7dk1wSWnuz/T49S8ao1gJh4OZbqwJI580xsjo+jw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=r/+ROxQTXVe/Wc1vwadx7014Ard+rMkAygWzGRUUvUGrCQmpFDxdZTYB74FYEYvkb
	 kmftzoSfUo8uRgD/Sh1NBaUF9WraVQxPNAc0NoZ+3yD4EBz98HYhWO7Ob+97COsOWD
	 2VOzzFjhm93phZLA+tZAfi9OftMdCxfSJWLF6cCexv0ppyLwcsYPre3jcBdZiVvZfk
	 BvbFj8qaTY/O4dDQZB2mW1EjDaQ7JTPPojEnHmjh8D128ISOnMqFFh0Jai2vqNgxiE
	 zEbLNnWTOYP3MLO4mtLhGLR6ttjDG7xNB0O6lFtfElo/fLCl5uzZqvJ6By+K099SWD
	 Ert80rTz+tRXg==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5398ec2f3c3so1102846e87.1;
        Thu, 10 Oct 2024 04:38:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVUDY2HdscEcy5KCm4ZhzLysk2RNEKeJZztGeBLkL3dNyJc3sTJjsUYMrpSdobBb672maqlzGmJvSRZ5pDb@vger.kernel.org, AJvYcCVvSoCLbKiFPiIO3M/TJY/RBVT3u66mJ59/9Woxmkkdmk9lX5otTuQVpla5l7iO+D6IRBg=@vger.kernel.org, AJvYcCWiRknxvFlUXxt8Tk+8nSAgwN/uuHki0hNHKTny9qCh/63EptRQEMu44QWis0MVwlwCz3CxUqtwtan7axbd@vger.kernel.org, AJvYcCWsHfmGD+SFnpYefMhAJQog21rs8ewoVUCktR4QkZInazhK/5D0HhZR17d5lAmiF8Gbt+quVsH6+124tBCKMixx2LWo@vger.kernel.org
X-Gm-Message-State: AOJu0YxAzJsVtKWuRGLUBVTEPvrIetEFgPOXK8PLFcBKkm/RHa0fbFOh
	KpKy6HOjbkybfOXJXGIhGSMbR5jLv/ihe4UOVMnc2wzbprfoprkI+LDgc9oZSkACA8wyaQlTRAc
	1TDTbgFAN/R5mgCk8k1TgTsf763M=
X-Google-Smtp-Source: AGHT+IEIAeSx85GQg3WmZHRAR3Mc8OK0yGFm049Ltm6BeTKAuk4nRhXRGQZVZr/zNuugqKQ1CCwu37lOuAQuk1N8b0A=
X-Received: by 2002:a05:6512:2248:b0:535:6aa9:9855 with SMTP id
 2adb3069b0e04-539c4797433mr3902667e87.0.1728560307251; Thu, 10 Oct 2024
 04:38:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240915205648.830121-1-hbathini@linux.ibm.com>
 <20240915205648.830121-12-hbathini@linux.ibm.com> <CAK7LNAS9LPPxVOU55t2C_vkXYXK-8_2bHCVPWVxYdwrSrxCduw@mail.gmail.com>
 <beeea05a-7dfc-4506-9f20-7c8a4d1f4c85@linux.ibm.com>
In-Reply-To: <beeea05a-7dfc-4506-9f20-7c8a4d1f4c85@linux.ibm.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 10 Oct 2024 20:37:50 +0900
X-Gmail-Original-Message-ID: <CAK7LNATFVmhfQv5Rb=Gkq=fST9+SmSFo_uPi4pB2ckC1qHdkqw@mail.gmail.com>
Message-ID: <CAK7LNATFVmhfQv5Rb=Gkq=fST9+SmSFo_uPi4pB2ckC1qHdkqw@mail.gmail.com>
Subject: Re: [PATCH v5 11/17] kbuild: Add generic hook for architectures to
 use before the final vmlinux link
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Naveen N. Rao" <naveen@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Nicholas Piggin <npiggin@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Vishal Chourasia <vishalc@linux.ibm.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 6:57=E2=80=AFPM Hari Bathini <hbathini@linux.ibm.co=
m> wrote:
>
>
> On 09/10/24 8:53 pm, Masahiro Yamada wrote:
> > On Mon, Sep 16, 2024 at 5:58=E2=80=AFAM Hari Bathini <hbathini@linux.ib=
m.com> wrote:
> >>
> >> From: Naveen N Rao <naveen@kernel.org>
> >>
> >> On powerpc, we would like to be able to make a pass on vmlinux.o and
> >> generate a new object file to be linked into vmlinux. Add a generic pa=
ss
> >> in Makefile.vmlinux that architectures can use for this purpose.
> >>
> >> Architectures need to select CONFIG_ARCH_WANTS_PRE_LINK_VMLINUX and mu=
st
> >> provide arch/<arch>/tools/Makefile with .arch.vmlinux.o target, which
> >> will be invoked prior to the final vmlinux link step.
> >>
> >> Signed-off-by: Naveen N Rao <naveen@kernel.org>
> >> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> >> ---
> >>
> >> Changes in v5:
> >> * Intermediate files named .vmlinux.arch.* instead of .arch.vmlinux.*
> >>
> >>
> >>   arch/Kconfig             | 6 ++++++
> >>   scripts/Makefile.vmlinux | 7 +++++++
> >>   scripts/link-vmlinux.sh  | 7 ++++++-
> >>   3 files changed, 19 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/Kconfig b/arch/Kconfig
> >> index 975dd22a2dbd..ef868ff8156a 100644
> >> --- a/arch/Kconfig
> >> +++ b/arch/Kconfig
> >> @@ -1643,4 +1643,10 @@ config CC_HAS_SANE_FUNCTION_ALIGNMENT
> >>   config ARCH_NEED_CMPXCHG_1_EMU
> >>          bool
> >>
> >> +config ARCH_WANTS_PRE_LINK_VMLINUX
> >> +       def_bool n
> >
> >
> > Redundant default. This line should be "bool".
> >
> >
> >
> >
> >
> >
> >> +       help
> >> +         An architecture can select this if it provides arch/<arch>/t=
ools/Makefile
> >> +         with .arch.vmlinux.o target to be linked into vmlinux.
> >> +
> >>   endmenu
> >> diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
> >> index 49946cb96844..edf6fae8d960 100644
> >> --- a/scripts/Makefile.vmlinux
> >> +++ b/scripts/Makefile.vmlinux
> >> @@ -22,6 +22,13 @@ targets +=3D .vmlinux.export.o
> >>   vmlinux: .vmlinux.export.o
> >>   endif
> >>
> >> +ifdef CONFIG_ARCH_WANTS_PRE_LINK_VMLINUX
> >> +vmlinux: arch/$(SRCARCH)/tools/.vmlinux.arch.o
> >
> > If you move this to arch/*/tools/, there is no reason
> > to make it a hidden file.
>
> Thanks for reviewing and the detailed comments, Masahiro.
>
> >
> >
> > vmlinux: arch/$(SRCARCH)/tools/vmlinux.arch.o
> >
> >
> >
> >
> >> +arch/$(SRCARCH)/tools/.vmlinux.arch.o: vmlinux.o
> >
> > FORCE is missing.
>
>
> I dropped FORCE as it was rebuilding vmlinux on every invocation
> of `make` irrespective of whether vmlinux.o changed or not..


It is because you did not add vmlinux.arch.S to 'targets'

See my comment in 12/17.

  targets +=3D vmlinux.arch.S


> Just curious if the changes you suggested makes FORCE necessary
> or FORCE was expected even without the other changes you suggested?


FORCE is necessary.

arch/powerpc/tools/Makefile must be checked every time.


When arch/powerpc/tools/ftrace-gen-ool-stubs.sh is changed,
vmlinux must be relinked.





> Thanks
> Hari




--
Best Regards
Masahiro Yamada

