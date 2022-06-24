Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9103E55A324
	for <lists+bpf@lfdr.de>; Fri, 24 Jun 2022 23:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiFXU6P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jun 2022 16:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiFXU6O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jun 2022 16:58:14 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BFF1A063
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 13:58:07 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id e40so5110946eda.2
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 13:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0E6GaFoCmlDPdQ7oc8NPrEcUyWMA4N1ys1Z9tLHhFBs=;
        b=oE1tMvqSrobJS1nlznDYU+Ujjv4LNwAls8SS1iJusE9QlDuFXa/6FYUa3RDOtG4tM5
         H4gQSZH0ApWBrFd9E8f31wh5utmUeKjOCx2a41JM4pyQgJS9ihd1MXxDrufbAPYBKjxA
         /FnEeDVjUeOn0LbOThZpwXJqzXDlb6vexjNafIh2UmM8jzI/KFN1fgsqMX5XEOf1KYFn
         Vs4eVOgACx5l4cNeF6GDj/1dxiDH8B/Uz5zow7COTLDwlHWS0Lgeds07ZERykJ26OwHC
         tbIrG0SBhMR5lw6Y2+4pDhMyCjw36TJq82iVu5umZz1yMGpk13ES/ltFOcuhGbK25e1D
         tTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0E6GaFoCmlDPdQ7oc8NPrEcUyWMA4N1ys1Z9tLHhFBs=;
        b=6WqZiujZos3LbAxXbW66dM/HI01JyMBeWpqZaQxOuz+HCS2LGjh9S0kmJkHoxAY5/n
         bt60z20LNlVNdikcTyT71giHh5V7t3qxNOgkQndC6fJFS1IMhSHEPlUuKvPDNPDORRmz
         V203r9rjNkzzxdmKVoxPz3bgKYTqy+pf/ix4IotHTS3oqNWmAytg301mv+pRtHMiQ15+
         tvtVQWmSv5InJ0Bqjne4xT8MPUbuekaeK8dailHPD9xVrTCsUBezH97bZ+c38RU+wL1q
         Mi3m6kYTqfExkb/EKtHm0PywICWwrzjXc5AkX7Q9BLivlLjN+KfOFqejUr+cyAYRSbzq
         EM2A==
X-Gm-Message-State: AJIora+bR2evsXnWculBJfvRKuowgeldc3w7anWyjwQWBaUkKP9G4uNa
        ejTWdTSttoivhDkBrps04IiXpxA3xRbbuRkFGSI=
X-Google-Smtp-Source: AGRyM1u0eNNyFfbRUGy940TOMJVhmjCPtrvlT49g2hVJmIgZ96pDDyheLcwUqzkyuSMqgrC6GWAxd/OrHGgmnHwjwSo=
X-Received: by 2002:a05:6402:4408:b0:435:9ed2:9be with SMTP id
 y8-20020a056402440800b004359ed209bemr1218446eda.81.1656104285815; Fri, 24 Jun
 2022 13:58:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220603190155.3924899-1-andrii@kernel.org> <87wndwvjax.fsf@toke.dk>
 <CAEf4Bzb75b5cPjv1ZnM9aME3vxy4nxY0=Utp1wd0Z9P3s9mvaw@mail.gmail.com> <87mte2p03a.fsf@toke.dk>
In-Reply-To: <87mte2p03a.fsf@toke.dk>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 24 Jun 2022 13:57:54 -0700
Message-ID: <CAEf4BzZmbxOCjtk8zPP-DdSA2r3FZQwrDT-L9dogh6GgAd36YA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/15] libbpf: remove deprecated APIs
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 24, 2022 at 8:12 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@kern=
el.org> wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
> > On Sat, Jun 4, 2022 at 3:01 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@k=
ernel.org> wrote:
> >>
> >> Andrii Nakryiko <andrii@kernel.org> writes:
> >>
> >> > This patch set removes all the deprecated APIs in preparation for 1.=
0 release.
> >> > It also makes libbpf_set_strict_mode() a no-op (but keeps it to let =
per-1.0
> >> > applications buildable and dynamically linkable against libbpf 1.0 i=
f they
> >> > were already libbpf-1.0 ready) and starts enforcing all the
> >> > behaviors that were previously opt-in through libbpf_set_strict_mode=
().
> >> >
> >> > xsk.{c,h} parts that are now properly provided by libxdp ([0]) are s=
till used
> >> > by xdpxceiver.c in selftest/bpf, so I've moved xsk.{c,h} with barely=
 any
> >> > changes to under selftests/bpf.
> >> >
> >> > Other than that, apart from removing all the LIBBPF_DEPRECATED-marke=
d APIs,
> >> > there is a bunch of internal clean ups allowed by that. I've also "r=
estored"
> >> > libbpf.map inheritance chain while removing all the deprecated APIs.=
 I think
> >> > that's the right way to do this, as applications using libbpf as sha=
red
> >> > library but not relying on any deprecated APIs (i.e., "good citizens=
" that
> >> > prepared for libbpf 1.0 release ahead of time to minimize disruption=
) should
> >> > be able to link both against 0.x and 1.x versions. Either way, it do=
esn't seem
> >> > to break anything and preserve a history on when each "surviving" AP=
I was
> >> > added.
> >> >
> >> > NOTE. This shouldn't be yet landed until Jiri's changes ([1]) removi=
ng last
> >> > deprecated API usage in perf lands. But I thought to post it now to =
get the
> >> > ball rolling.
> >>
> >> Any chance you could push this to a branch of github as well? Makes it
> >> easier to test libxdp against it :)
> >>
> >
> > Sure, pushed to
> > https://github.com/libbpf/libbpf/tree/libbpf-remove-deprecated-apis
>
> Hi Andrii
>
> Took this for a test run, and besides having to fix up the Makefile in
> the github repository a bit (diff below), nothing broke
> catastrophically. So yay!
>
> It did flush out a BPF object file we used for testing that still had
> the old long-style section name, but libbpf does output a helpful error
> message for that even if it can get lost in the noise. So I guess that's
> as friendly as we can make it :)
>

Cool, thanks for testing! And yeah, I should try and not forget to do
these Github-only changes when I do proper sync, thanks for the
reminder! Now that Jiri's perf patch is merged, I'll rebase my changes
and post them as v2.

> -Toke
>
>
> diff --git a/src/Makefile b/src/Makefile
> index 40f4f98b5681..99766f4c418c 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -8,8 +8,8 @@ else
>         msg =3D @printf '  %-8s %s%s\n' "$(1)" "$(2)" "$(if $(3), $(3))";
>  endif
>
> -LIBBPF_MAJOR_VERSION :=3D 0
> -LIBBPF_MINOR_VERSION :=3D 8
> +LIBBPF_MAJOR_VERSION :=3D 1
> +LIBBPF_MINOR_VERSION :=3D 0
>  LIBBPF_PATCH_VERSION :=3D 0
>  LIBBPF_VERSION :=3D $(LIBBPF_MAJOR_VERSION).$(LIBBPF_MINOR_VERSION).$(LI=
BBPF_PATCH_VERSION)
>  LIBBPF_MAJMIN_VERSION :=3D $(LIBBPF_MAJOR_VERSION).$(LIBBPF_MINOR_VERSIO=
N).0
> @@ -50,7 +50,7 @@ OBJDIR ?=3D .
>  SHARED_OBJDIR :=3D $(OBJDIR)/sharedobjs
>  STATIC_OBJDIR :=3D $(OBJDIR)/staticobjs
>  OBJS :=3D bpf.o btf.o libbpf.o libbpf_errno.o netlink.o \
> -       nlattr.o str_error.o libbpf_probes.o bpf_prog_linfo.o xsk.o \
> +       nlattr.o str_error.o libbpf_probes.o bpf_prog_linfo.o  \
>         btf_dump.o hashmap.o ringbuf.o strset.o linker.o gen_loader.o \
>         relo_core.o usdt.o
>  SHARED_OBJS :=3D $(addprefix $(SHARED_OBJDIR)/,$(OBJS))
> @@ -64,7 +64,7 @@ ifndef BUILD_STATIC_ONLY
>         VERSION_SCRIPT :=3D libbpf.map
>  endif
>
> -HEADERS :=3D bpf.h libbpf.h btf.h libbpf_common.h libbpf_legacy.h xsk.h =
\
> +HEADERS :=3D bpf.h libbpf.h btf.h libbpf_common.h libbpf_legacy.h  \
>            bpf_helpers.h bpf_helper_defs.h bpf_tracing.h \
>            bpf_endian.h bpf_core_read.h skel_internal.h libbpf_version.h =
\
>            usdt.bpf.h
