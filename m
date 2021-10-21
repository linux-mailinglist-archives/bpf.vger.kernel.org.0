Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B348436243
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 15:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhJUNCJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 09:02:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:47240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231731AbhJUNBm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Oct 2021 09:01:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3650B61260;
        Thu, 21 Oct 2021 12:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634821166;
        bh=3BKdRD/8wFaWv8jGzgoDJH1uu5lNDvND1IBbsx3dRcA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FgbIaMGaOxi2cZ1w0PTH5koLwAKST6WAUHaSq9rjTS96x28Op/XN1yWKTA6sYmLHX
         Ci0mHr/JbR3++YXGTRfTsi/I4fVfrk2DEYKkY2IkyEWiecIB3b5Yn5vTuAv7sFF/7k
         LJfFs4fKiraplFiZLcXKMpuyStPhJyGVT0aVp4msPBVI7i5DwOrlYMxMvUcaw8q0F+
         squkDg7QyVfvdPge8z9n4nTViSu60CTmegxTeJtnYpZVnb+qxB2UuwArQkZLZKcQxF
         H6Gcb60m9tTwWrwY7T7iCsAyzyF6Q/bU9JdDfwmw8/5bychdWNDAyzGnDaP7gVI+2G
         JfUZgYD7TDJbA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7796D410A1; Thu, 21 Oct 2021 09:59:20 -0300 (-03)
Date:   Thu, 21 Oct 2021 09:59:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Ian Rogers <irogers@google.com>, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Petar Penkov <ppenkov@google.com>
Subject: Re: [PATCH] btf_encoder: Make BTF_KIND_TAG conditional
Message-ID: <YXFkKKcAHqJ1mQCC@kernel.org>
References: <20211014212049.1010192-1-irogers@google.com>
 <CAEf4BzYiG36y0XWVfjXti-qb=gOdGkhzB6R5Ny3kvUbTRyeHUA@mail.gmail.com>
 <CAP-5=fXLAp+9tKU1qS1fr+6ZSFiq=soyD+mr_FPPmi40P0imjw@mail.gmail.com>
 <CAEf4BzaZpfnmTZj4k+APhTheODb6_NbNvUdsPYH84ophCaU3cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzaZpfnmTZj4k+APhTheODb6_NbNvUdsPYH84ophCaU3cw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Oct 20, 2021 at 02:27:37PM -0700, Andrii Nakryiko escreveu:
> On Wed, Oct 20, 2021 at 2:23 PM Ian Rogers <irogers@google.com> wrote:
> > On Wed, Oct 20, 2021 at 2:12 PM Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > > On Thu, Oct 14, 2021 at 2:20 PM Ian Rogers <irogers@google.com> wrote:
> > > > @@ -648,6 +650,7 @@ static int32_t btf_encoder__add_datasec(struct btf_encoder *encoder, const char
> > > >  static int32_t btf_encoder__add_tag(struct btf_encoder *encoder, const char *value, uint32_t type,
> > > >                                     int component_idx)
> > > >  {
> > > > +#ifdef BTF_KIND_TAG /* Proxy for libbtf 6.0 */

> > > How will this work when libbpf is loaded dynamically? I believe pahole
> > > has this mode as well.

> > Well it won't have a compilation error because BTF_KIND_TAG isn't

> Great, you traded compile-time error for runtime linking error, I hope
> that trade off makes sense to Arnaldo.

This situation is tricky to handle, yeah :-\
 
> > undefined :-) Tbh, I'm not sure but it seems that you'd be limited to
> > features in the version of libbpf you compiled against.
 
> I've been consistently advocating for statically linking against
> libbpf exactly to control what APIs and features are supported. But
> people stubbornly want dynamic linking. I hope added complexity and
> feature detection makes sense in practice for pahole.

It is a pain, but fedora also have this policy.
 
> > > Also, note that libbpf now provides LIBBPF_MAJOR_VERSION and
> > > LIBBPF_MINOR_VERSION macros, starting from 0.5, so no need for
> > > guessing the version
> >
> > This was moved to a header file in:
> > https://lore.kernel.org/bpf/CAADnVQJ2qd095mvj3z9u9BXQYCe2OTDn4=Gsu9nv1tjFHc2yqQ@mail.gmail.com/T/
> >
> > But that header doesn't appear any more:
> > https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/tools/lib/bpf
> >
> > Is that a bug?
> 
> You should be checking here:
> 
> https://github.com/libbpf/libbpf/blob/master/src/libbpf_version.h

Ian, would be so kind as to follow up on this so that we get this
situation improved?

- Arnaldo
