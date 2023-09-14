Return-Path: <bpf+bounces-9981-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 439D379FE6E
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 10:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6188281BAA
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 08:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39926CA73;
	Thu, 14 Sep 2023 08:31:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8167410A28
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 08:31:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20EB8C433C8
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 08:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694680289;
	bh=k/0vPNmdQxp4roO05xLF+5BGxvpy0UaoMlWwg/gjUYw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KBLbdm5XSr4YOPP50hwziS5CeE7cHiunWB2QZDI6JJyZcysHM12IVprRUwV2q7uzb
	 W/hGItm0im0c4HBdRfHqcYlJepkILV8wLxzCu1ogRwPDt+blW+NwRX6g59fpm9JQna
	 r2BVlxEqNak7lbXFjjSSYnhueJO8DWGLt/c79oSirZVsymbZEj2wIuiRAObEcQA6Jx
	 tzyIwtTH7Vxy9i6rf/kFPv6h7qrhfYiMjafTlJeAHKyj5X1/tCrLlWPSaGl/4S661i
	 anxtR0k4yAMLPEx/1QFWA/svKMn3vaMnVdZT+4l7IAe/wQLHP/zlyWBbcSGwcORHgc
	 HLCdaOCkt3GzA==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-57656330b80so417142eaf.3
        for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 01:31:29 -0700 (PDT)
X-Gm-Message-State: AOJu0YySqgZmWn/G7vLz0LJFD0xc2EH/gphq9+3rMR4/ZO9Onw8EPeiA
	Bm+8VHf8WTiB4F9b9SU37in5FObR3b0UNb+vwrA=
X-Google-Smtp-Source: AGHT+IERWFF+FecR/stxMweA/ZbnFj+Yx6vTn3rVN7pA2L8Z0Qooi0tRbAxNNKUXxB+3u7qUPfa14X2dOMNa8iCxDC8=
X-Received: by 2002:a05:6870:2426:b0:1b7:670e:ad7a with SMTP id
 n38-20020a056870242600b001b7670ead7amr4754765oap.43.1694680288468; Thu, 14
 Sep 2023 01:31:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKwvOdnaEakT_y8TA9b_nMY3kMp=xxqKpGQPc2drNqRdV39RQw@mail.gmail.com>
 <ZPozfCEF9SV2ADQ5@krava> <ZPsJ4AAqNMchvms/@krava> <CAKwvOd==X0exrhmsqX1j1WFX77xe8W7xPbfiCY+Rt6abgmkMCQ@mail.gmail.com>
 <ZPuA5+HmbcdBLbIq@krava> <ZQLBm8sC+V53CIzD@krava>
In-Reply-To: <ZQLBm8sC+V53CIzD@krava>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 14 Sep 2023 17:30:51 +0900
X-Gmail-Original-Message-ID: <CAK7LNATiHvOXiWQi9gXJO9rZbT_MFm6NddaWqoY4ykNWf+OYsQ@mail.gmail.com>
Message-ID: <CAK7LNATiHvOXiWQi9gXJO9rZbT_MFm6NddaWqoY4ykNWf+OYsQ@mail.gmail.com>
Subject: Re: duplicate BTF_IDs leading to symbol redefinition errors?
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Marcus Seyfarth <m.seyfarth@gmail.com>, 
	bpf <bpf@vger.kernel.org>, clang-built-linux <llvm@lists.linux.dev>, 
	Stanislav Fomichev <sdf@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2023 at 5:17=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Fri, Sep 08, 2023 at 10:15:35PM +0200, Jiri Olsa wrote:
> > On Fri, Sep 08, 2023 at 10:14:56AM -0700, Nick Desaulniers wrote:
> > > Thanks for the patch!
> > >
> > > + Marcus
> > >
> > > Marcus can you please test the below patch and provide your tested-by
> > > and reported-by tags?
> > >
> > > On Fri, Sep 8, 2023 at 4:47=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com>=
 wrote:
> > > >
> > > > On Thu, Sep 07, 2023 at 10:33:00PM +0200, Jiri Olsa wrote:
> > > > > On Thu, Sep 07, 2023 at 12:01:18PM -0700, Nick Desaulniers wrote:
> > > > > > So we've got a curious report recently:
> > > > > > https://github.com/ClangBuiltLinux/linux/issues/1913
> > > > > >
> > > > > > ld.lld: error: ld-temp.o <inline asm>:14577:1: symbol
> > > > > > '__BTF_ID__struct__cgroup__624' is already defined
> > > > > > __BTF_ID__struct__cgroup__624:
> > > > > > ^
> > > > > >
> > > > > > It's been hard to pin down a SHA and .config to reproduce this,=
 but
> > > > > > looking at the definition of BTF_ID's usage of __ID's usage of
> > > > > > __COUNTER__, and the two statements:
> > > > > >
> > > > > > kernel/bpf/helpers.c:2460:BTF_ID(struct, cgroup)
> > > > > > kernel/bpf/verifier.c:5075:BTF_ID(struct, cgroup)
> > > > > >
> > > > > > Is it possible that __COUNTER__ could evaluate to the same valu=
e
> > > > > > across 2 different translation units, leading to a name collisi=
on like
> > > > > > the above?
> > > > >
> > > > > hum, that probably the case, I see same counter values at differe=
nt
> > > > > __BTF_ID_ symbols:
> > > > >
> > > > > ffffffff833fe540 r __BTF_ID__struct__bpf_bloom_filter__380
> > > > > ffffffff833fe548 r __BTF_ID__struct__bpf_queue_stack__380
> > > > > ffffffff833fe578 r __BTF_ID__struct__cgroup__380
> > > > >
> > > > > perhaps we were just lucky not to hit that :-\
> > > > >
> > > > > >
> > > > > > looking at another usage of BTF_ID other than struct
> > > > > > cgroup;kernel/bpf/helpers.c:2461:BTF_ID(func, bpf_cgroup_releas=
e)
> > > > > > is only defined in one translation unit
> > > > > >
> > > > > > Should one of those two `BTF_ID(struct, cgroup)` be removed? Is=
 there
> > > > > > some other way we can avoid these collisions in the future?
> > > > >
> > > > > need to find some way to make the symbol unique, will check
> > > >
> > > > the change below uses object's path as the __BTF_ID_.. symbol suffi=
x to make
> > > > it unique
> > > >
> > > > I'm still looking, but can't think of a better way so far, perhaps =
somebody
> > > > will have better idea
> > >
> > > Another good approach; I had simply added __LINE__ into the paste.
> > > https://github.com/ClangBuiltLinux/linux/issues/1913#issuecomment-171=
0794319
> > > Which just makes the probability of this occurring again smaller, but
> > > still non-zero.
> >
> > yes, there's still possibility of the match
> >
> > >
> > > + Masahiro for thoughts on the invocation of echo and base32.  Looks
> > > like base32 is part of coreutils. Kind of strange that coreutils isn'=
t
> > > listed in Documentation/process/changes.rst.  Would adding the usage
> > > of base32 add a new dependency on coreutils?
> > >
> > > >
> > > > jirka
> > > >
> > > >
> > > > ---
> > > > diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> > > > index a3462a9b8e18..564953f9cbc7 100644
> > > > --- a/include/linux/btf_ids.h
> > > > +++ b/include/linux/btf_ids.h
> > > > @@ -49,7 +49,7 @@ word                                             =
     \
> > > >         ____BTF_ID(symbol, word)
> > > >
> > > >  #define __ID(prefix) \
> > > > -       __PASTE(prefix, __COUNTER__)
> > > > +       __PASTE(__PASTE(prefix, __COUNTER__), BTF_ID_BASE)
> > >
> > > Do we still need __COUNTER__ if we're now using BTF_ID_BASE?
> >
> > yes we still need that because we could have same __BTF_ID__...
> > symbol used multiple times within same object, and that's where
> > __COUNTER__ makes the difference
> >
> > >
> > > >
> > > >  /*
> > > >   * The BTF_ID defines unique symbol for each ID pointing
> > > > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > > > index 68d0134bdbf9..2ef8b2798be0 100644
> > > > --- a/scripts/Makefile.lib
> > > > +++ b/scripts/Makefile.lib
> > > > @@ -200,6 +200,10 @@ _c_flags +=3D $(if $(patsubst n%,, \
> > > >         -D__KCSAN_INSTRUMENT_BARRIERS__)
> > > >  endif
> > > >
> > > > +ifeq ($(CONFIG_DEBUG_INFO_BTF),y)
> > > > +_c_flags +=3D -DBTF_ID_BASE=3D$(subst =3D,,$(shell echo -n $(modfi=
le) | base32 -w0))
> > >
> > > `man 1 base32` shows it can just read a file. Could the above be:
> > >
> > > _c_flags +=3D -DBTF_ID_BASE=3D$(subst =3D,,$(shell base32 -w0 $(modfi=
le)))
> > >
> > > ? (untested)
> > >
> > > Also, the output of
> > >
> > > $ base32 -w0 Documentation/process/changes.rst
> > >
> > > is 24456 characters.  This is going to blow up symbol tables. I
> > > suppose ELF probably has some length limit on symbol names, too.  I
> > > was nervous about my approaching appending __LINE__.
> > >
> > > Perhaps pipe the output to `head -c <n bytes>`?
> >
> > so the change is about adding unique id that's basically path of
> > the object stored in base32 so it could be used as symbol, so we
> > don't really need to read the actual file
> >
> > the problem is when BTF_ID definition like:
> >
> > BTF_ID(struct, cgroup)
> >
> > translates in 2 separate objects into same symbol name because of
> > the matching __COUNTER__ macro values (like 380 below)
> >
> >   __BTF_ID__struct__cgroup__380
> >
> > this change just adds unique id of the path name at the end of the
> > symbol with:
> >
> >   echo -n 'kernel/bpf/helpers' | base32 -w0 --> NNSXE3TFNQXWE4DGF5UGK3D=
QMVZHG
> >
> > so the symbol looks like:
> >
> >   __BTF_ID__struct__cgroup__380NNSXE3TFNQXWE4DGF5UGK3DQMVZHG
> >
> > and is unique over the sources
> >
> > but I still hope we could come up with some better solution ;-)
>
> so far the only better solution I could come up with is to use
> cksum (also from coreutils) instead of base32, which makes the
> BTF_ID_BASE value compact
>
> I'll run test to find out how much it hurts the build time
>
> jirka



Seems a bad idea to me.

It would fork a new shell and chsum for all files,
while only a few of them need it.

Better to consult BTF forks.










--=20
Best Regards
Masahiro Yamada

