Return-Path: <bpf+bounces-9526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C23D1798B52
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 19:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AB271C2085A
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 17:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A901400E;
	Fri,  8 Sep 2023 17:15:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA4613AFC
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 17:15:12 +0000 (UTC)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B71CE6
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 10:15:11 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-6543d62e9a4so16700366d6.1
        for <bpf@vger.kernel.org>; Fri, 08 Sep 2023 10:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694193310; x=1694798110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvC9pL6Ni1XwRDm5BeqCIzzDS/+lbPGOBzfjrA1tAJw=;
        b=wiQXsHXBdcJgKOcBTW+aP1wTLqrfFu3ZwioqoFLcftkbynaQf0/VhkqpoNBrfNjueX
         RV8RA7Oa5bYW1F44gIOygUUgHjZWWXjI1ZcuY66vpiig5y7s/dN56PPKM7o9siW90tIl
         Uldm9Dx3Cw9yeFiBz5qD8RJBJEjHxTneHcNbb4sTuE+By+X8FT6NK7kxlfzrYkEEoHOn
         n8DRzzEJX1k7D8hNaePkxzESbD6Z1KHREd2xO9H1EmX/zgfTh9Rfiba5pWk9VeeLRlh5
         tzf5ADacSAlVhdymOWn7ywqpsx2uV0BOYjvgskKEoayLjy6Q0TQAXCZXHg34VS2NStYG
         bG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694193310; x=1694798110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FvC9pL6Ni1XwRDm5BeqCIzzDS/+lbPGOBzfjrA1tAJw=;
        b=X6pB4IQIOMTH57K2TbPBdQMeuRHtlaLhDNJzYnfqKPM7QiJm1y1Wcry6S9Vv0mdbMQ
         r8L0Zck6scasAJWYHdMHIfk5JqhDjeJVMUKQyWrjXRn/l9DQx391FgcnDRVLIV4vt32l
         RuMnJX91cHYmgKv5H7ZuZDLN9hhDTJ0TZZ60jGUtq37raZKoqzm0f7YtycsGZmBf4P2f
         6XGV4u0uO54AW8f2zXU8E9D282gOsAtH+UGM2YCir4soEz9rtsCr3KpebYKqbMVXt0IC
         pW+kYVwkiVtqH/RWJDR3dxER8Y0qmgDF2sn6RmR3e1IOLRzI5mv//5bUnoOrcQUKo9gA
         XTPg==
X-Gm-Message-State: AOJu0Yzx1ldPkUQZEjXFr2v3Sae6hgR+fp90uM5WzY7UmfaBiKZWVe/h
	I2mD3JspnIT17TZXUxdYxNooUbBwgkgSe4Hzkn1Kfg==
X-Google-Smtp-Source: AGHT+IHurteqR3i6yaqkMaO/DxMsTokaewDiPBujsr0fhYb39oy8+ZmDi6wXwmbrivcBqzheTati8qR0uJemwcQ3Zag=
X-Received: by 2002:a05:6214:20e2:b0:630:1b99:5c53 with SMTP id
 2-20020a05621420e200b006301b995c53mr7558558qvk.9.1694193310278; Fri, 08 Sep
 2023 10:15:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKwvOdnaEakT_y8TA9b_nMY3kMp=xxqKpGQPc2drNqRdV39RQw@mail.gmail.com>
 <ZPozfCEF9SV2ADQ5@krava> <ZPsJ4AAqNMchvms/@krava>
In-Reply-To: <ZPsJ4AAqNMchvms/@krava>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 8 Sep 2023 10:14:56 -0700
Message-ID: <CAKwvOd==X0exrhmsqX1j1WFX77xe8W7xPbfiCY+Rt6abgmkMCQ@mail.gmail.com>
Subject: Re: duplicate BTF_IDs leading to symbol redefinition errors?
To: Jiri Olsa <olsajiri@gmail.com>, Marcus Seyfarth <m.seyfarth@gmail.com>, 
	Masahiro Yamada <masahiroy@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, clang-built-linux <llvm@lists.linux.dev>, 
	Stanislav Fomichev <sdf@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thanks for the patch!

+ Marcus

Marcus can you please test the below patch and provide your tested-by
and reported-by tags?

On Fri, Sep 8, 2023 at 4:47=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Thu, Sep 07, 2023 at 10:33:00PM +0200, Jiri Olsa wrote:
> > On Thu, Sep 07, 2023 at 12:01:18PM -0700, Nick Desaulniers wrote:
> > > So we've got a curious report recently:
> > > https://github.com/ClangBuiltLinux/linux/issues/1913
> > >
> > > ld.lld: error: ld-temp.o <inline asm>:14577:1: symbol
> > > '__BTF_ID__struct__cgroup__624' is already defined
> > > __BTF_ID__struct__cgroup__624:
> > > ^
> > >
> > > It's been hard to pin down a SHA and .config to reproduce this, but
> > > looking at the definition of BTF_ID's usage of __ID's usage of
> > > __COUNTER__, and the two statements:
> > >
> > > kernel/bpf/helpers.c:2460:BTF_ID(struct, cgroup)
> > > kernel/bpf/verifier.c:5075:BTF_ID(struct, cgroup)
> > >
> > > Is it possible that __COUNTER__ could evaluate to the same value
> > > across 2 different translation units, leading to a name collision lik=
e
> > > the above?
> >
> > hum, that probably the case, I see same counter values at different
> > __BTF_ID_ symbols:
> >
> > ffffffff833fe540 r __BTF_ID__struct__bpf_bloom_filter__380
> > ffffffff833fe548 r __BTF_ID__struct__bpf_queue_stack__380
> > ffffffff833fe578 r __BTF_ID__struct__cgroup__380
> >
> > perhaps we were just lucky not to hit that :-\
> >
> > >
> > > looking at another usage of BTF_ID other than struct
> > > cgroup;kernel/bpf/helpers.c:2461:BTF_ID(func, bpf_cgroup_release)
> > > is only defined in one translation unit
> > >
> > > Should one of those two `BTF_ID(struct, cgroup)` be removed? Is there
> > > some other way we can avoid these collisions in the future?
> >
> > need to find some way to make the symbol unique, will check
>
> the change below uses object's path as the __BTF_ID_.. symbol suffix to m=
ake
> it unique
>
> I'm still looking, but can't think of a better way so far, perhaps somebo=
dy
> will have better idea

Another good approach; I had simply added __LINE__ into the paste.
https://github.com/ClangBuiltLinux/linux/issues/1913#issuecomment-171079431=
9
Which just makes the probability of this occurring again smaller, but
still non-zero.

+ Masahiro for thoughts on the invocation of echo and base32.  Looks
like base32 is part of coreutils. Kind of strange that coreutils isn't
listed in Documentation/process/changes.rst.  Would adding the usage
of base32 add a new dependency on coreutils?

>
> jirka
>
>
> ---
> diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> index a3462a9b8e18..564953f9cbc7 100644
> --- a/include/linux/btf_ids.h
> +++ b/include/linux/btf_ids.h
> @@ -49,7 +49,7 @@ word                                                  \
>         ____BTF_ID(symbol, word)
>
>  #define __ID(prefix) \
> -       __PASTE(prefix, __COUNTER__)
> +       __PASTE(__PASTE(prefix, __COUNTER__), BTF_ID_BASE)

Do we still need __COUNTER__ if we're now using BTF_ID_BASE?

>
>  /*
>   * The BTF_ID defines unique symbol for each ID pointing
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 68d0134bdbf9..2ef8b2798be0 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -200,6 +200,10 @@ _c_flags +=3D $(if $(patsubst n%,, \
>         -D__KCSAN_INSTRUMENT_BARRIERS__)
>  endif
>
> +ifeq ($(CONFIG_DEBUG_INFO_BTF),y)
> +_c_flags +=3D -DBTF_ID_BASE=3D$(subst =3D,,$(shell echo -n $(modfile) | =
base32 -w0))

`man 1 base32` shows it can just read a file. Could the above be:

_c_flags +=3D -DBTF_ID_BASE=3D$(subst =3D,,$(shell base32 -w0 $(modfile)))

? (untested)

Also, the output of

$ base32 -w0 Documentation/process/changes.rst

is 24456 characters.  This is going to blow up symbol tables. I
suppose ELF probably has some length limit on symbol names, too.  I
was nervous about my approaching appending __LINE__.

Perhaps pipe the output to `head -c <n bytes>`?

> +endif
> +
>  # $(srctree)/$(src) for including checkin headers from generated source =
files
>  # $(objtree)/$(obj) for including generated headers from checkin source =
files
>  ifeq ($(KBUILD_EXTMOD),)



--=20
Thanks,
~Nick Desaulniers

