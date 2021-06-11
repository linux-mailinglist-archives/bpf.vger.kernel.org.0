Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0EB33A49BC
	for <lists+bpf@lfdr.de>; Fri, 11 Jun 2021 22:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhFKUCZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Jun 2021 16:02:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:57028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231179AbhFKUCW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Jun 2021 16:02:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7427613D9;
        Fri, 11 Jun 2021 20:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623441624;
        bh=OvXOmA8jkk0daf0UMlFy90AE90wHMSWfvLTPzexSDAk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YD5yq0JCNBhNow2wp7UAUW7oXkFtnGhL/0QXTOYY44+LBkqp6gpbKvNck63jtxnWR
         dACi9hDy7ZL5YfU6/B9GdrFnF27V3WruibcIw0zVYL9vL1Zcf38x74bCNXIPcQcvWM
         0Nru3zVkwZ7H1osuTrXm95fXK7S2WbKhDc9kcYs9oA07MckHODjgCdTaNvTENtTztA
         8BYzk+tLLRgEnJNfKCu50ScOHrvozzY6+xdDxwKuJyF0pJgjA48yzZdZDv5Jnggc96
         4CPJ2zCQr8LLskVlJ5oNaFWJsilfeKMMNlinOf1qJ7gyyejMrNojUP6LFBvnbgcEQr
         rwU2Hn/5LbZRg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 29D2840B1A; Fri, 11 Jun 2021 17:00:21 -0300 (-03)
Date:   Fri, 11 Jun 2021 17:00:21 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Luca Boccassi <bluca@debian.org>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Deepak Kumar Mishra <deepakkumar.mishra@arm.com>,
        dwarves@vger.kernel.org, Qais Yousef <qais.yousef@arm.com>,
        Jiri Olsa <jolsa@kernel.org>, siudin@fb.com,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] CMakeLists.txt: enable SHARED and STATIC lib
 creation
Message-ID: <YMPA1T0Cuo7xw/Sp@kernel.org>
References: <cover.1623091959.git.deepakkumar.mishra@arm.com>
 <70cb7cb534af9850dc5fe3c4b9f4366ce7dc6316.1623091959.git.deepakkumar.mishra@arm.com>
 <YMJMdQvCWHd5J0M1@kernel.org>
 <CAEf4BzZEmLbKtUMkbV4+3rDFrSwP9Eu-tO_GvYRgRvdsQqrWTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZEmLbKtUMkbV4+3rDFrSwP9Eu-tO_GvYRgRvdsQqrWTQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Jun 11, 2021 at 12:34:13PM -0700, Andrii Nakryiko escreveu:
> On Thu, Jun 10, 2021 at 10:31 AM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> > Em Tue, Jun 08, 2021 at 12:50:13AM +0530, Deepak Kumar Mishra escreveu:
> > > CMakeLists.txt does not allow creation of static library and link applications
> > > accordingly.
> > >
> > > Creation of SHARED and STATIC should be allowed using -DBUILD_SHARED_LIBS
> > > If -DBUILD_SHARED_LIBS option is not supplied, CMakeLists.txt sets it to ON.
> > >
> > > Ex:
> > > cmake -D__LIB=lib -DBUILD_SHARED_LIBS=OFF ..
> > > cmake -D__LIB=lib -DBUILD_SHARED_LIBS=ON ..
> >
> > Had to do some fixups due to a previous patch touching CMakeLists.txt,
> > please check below.
> >
> > I tested it and added some performance notes.
> 
> Hey Arnaldo, Deepak,
> 
> I think this commit actually breaks libbpf's CI (see [0]) and my local
> setup as well (see output below). It seems like now we are using
> system-wide libbpf headers, while still building local libbpf sources.
> This is pretty bad because system-wide headers might be too old or
> just missing.

I can't check this right now, but isn't this related to this one
instead?

commit ae2581647e84948810ba209f3891359dd4540110 (quaco/master, quaco/HEAD, acme/tmp.master)
Author: Luca Boccassi <bluca@debian.org>
Date:   Mon Jan 4 22:16:22 2021 +0000

    libbpf: Allow to use packaged version

    Add a new CMake option, LIBBPF_EMBEDDED, to switch between the embedded
    version and the system version (searched via pkg-config) of libbpf. Set
    the embedded version as the default.

 -------

I can't look at this right now, will try probably tomorrow.

Andrii, I would love to be able to stage this somewhere, like I did with
tmp.master, so that it could go thru your CI before I moved to master,
is that possible?

- Arnaldo
 
> Is it possible to make sure that we always use local libbpf headers
> when building pahole with libbpf built from sources (the default case,
> right?). It's also important to use UAPI headers distributed with
> libbpf when building libbpf itself, I don't know if that's what is
> done right now or not.
> 
> Note how libbpf CI case shows that system-wide bpf/btf.h is not
> available at all because we don't have system-wide libbpf installed.
> In my local case, you can see that my system-wide header is outdated
> and doesn't have BTF_LITTLE_ENDIAN/BTF_BIG_ENDIAN constants defined in
> libbpf.h.
> 
> BTW, I tried -D__LIB=lib -DBUILD_SHARED_LIBS=OFF options and they
> didn't help. Maybe I'm doing something wrong.
> 
>   [0] https://travis-ci.com/github/kernel-patches/bpf/builds/228673352
> 
> 
> $ make -j60
> -- Setting BUILD_SHARED_LIBS = ON
> -- Checking availability of DWARF and ELF development libraries
> -- Checking availability of DWARF and ELF development libraries - done
> -- Configuring done
> -- Generating done
> -- Build files have been written to: /home/andriin/local/pahole/build
> 
> ....
> 
> /home/andriin/local/pahole/btf_encoder.c:900:28: error:
> ‘BTF_LITTLE_ENDIAN’ undeclared (first use in this function)
>    btf__set_endianness(btf, BTF_LITTLE_ENDIAN);
>                             ^
> /home/andriin/local/pahole/btf_encoder.c:900:28: note: each undeclared
> identifier is reported only once for each function it appears in
> /home/andriin/local/pahole/btf_encoder.c:903:28: error:
> ‘BTF_BIG_ENDIAN’ undeclared (first use in this function)
>    btf__set_endianness(btf, BTF_BIG_ENDIAN);
>                             ^
> ...
> 
> 
> >
> > Thanks!
> >
> > - Arnaldo
> >
> > commit aa2027708659f172780f85698f14303c7de6a1d2
> > Author: Deepak Kumar Mishra <deepakkumar.mishra@arm.com>
> > Date:   Tue Jun 8 00:50:13 2021 +0530
> >
> >     CMakeLists.txt: Enable SHARED and STATIC lib creation
> >
> >     CMakeLists.txt does not allow creation of static library and link applications
> >     accordingly.
> >
> >     Creation of SHARED and STATIC should be allowed using -DBUILD_SHARED_LIBS
> >     If -DBUILD_SHARED_LIBS option is not supplied, CMakeLists.txt sets it to ON.
> >
> >     Ex:
> >
> >       $ cmake -D__LIB=lib -DBUILD_SHARED_LIBS=OFF ..
> >       $ cmake -D__LIB=lib -DBUILD_SHARED_LIBS=ON ..
> >
> 
> [...]

-- 

- Arnaldo
