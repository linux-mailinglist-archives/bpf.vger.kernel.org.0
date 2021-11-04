Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09FCA445B2E
	for <lists+bpf@lfdr.de>; Thu,  4 Nov 2021 21:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbhKDUpU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Nov 2021 16:45:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231484AbhKDUpU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Nov 2021 16:45:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C964A601FA;
        Thu,  4 Nov 2021 20:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636058562;
        bh=dlXerqS/bbq1FHUsAY+hn9hsiCKixraprltYdcL6B6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qr3ARHbOs6o/3Agnug3o4uJTXhDOYshK2lwLKH0XNoKWk2xo/etidVquD7Zr+UqVT
         dLXyKi/H+1rpQqr7bYA2zd8gvyRv/jUGGLBCkwqeOlGWElecWwWPj6ajjMEY+27ygT
         w9kvK70mJSXYdDHM/nDzji4hp6quli012BgXU0ClKxCxBN0MANlTbPj2MA63mv+DmO
         kV2SH+Ko02dRAWKohah6DBwQcX1efBOOlbmC1Ol+C16mJ+kneYqA0tvpkJqs7nX1oq
         cYDEjJownjTn8lYjNTg3pYEcOo0uqb7o9SWdReH1mOEheZ3YIF0Lr6jkaiOBRJpMs/
         xskWOUaZCLzSg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E4456410A1; Thu,  4 Nov 2021 17:42:38 -0300 (-03)
Date:   Thu, 4 Nov 2021 17:42:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: perf build broken looking for bpf/{libbpf,bpf}.h after merge
 with upstream
Message-ID: <YYRFvpRjdKxJoydK@kernel.org>
References: <YYQadWbtdZ9Ff9N4@kernel.org>
 <YYQdKijyt20cBQik@kernel.org>
 <CAEf4BzYtq5Fru0_=Stih+Tjya3i29xG+RSF=4oOT7GbUwVRQaQ@mail.gmail.com>
 <YYQiXnUxlOoWMdwZ@kernel.org>
 <C940FF7A-A27F-4F56-8659-9365FC4A2EF7@fb.com>
 <CAM9d7cg9rXKUdEsdGUBSemzSrwE8XsyQtjCM=zT+8P+gs10n=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cg9rXKUdEsdGUBSemzSrwE8XsyQtjCM=zT+8P+gs10n=Q@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Nov 04, 2021 at 01:33:20PM -0700, Namhyung Kim escreveu:
> On Thu, Nov 4, 2021 at 11:13 AM Song Liu <songliubraving@fb.com> wrote:
> > > On Nov 4, 2021, at 11:11 AM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > Em Thu, Nov 04, 2021 at 10:56:26AM -0700, Andrii Nakryiko escreveu:
> > >> On the side note, why BUILD_BPF_SKEL=1 is not a default, we might have
> > >> caught this sooner. Is there any reason not to flip the default?

> > > I asked Song in the past about this, and asked again on another reply to
> > > this thread, I think it should be the default.

> > > Song, Namhyung? You're the skel guys (so far) :-)

> > Yeah, let's make it default.
 
> Then it'd require 'clang' for the perf build.  Maybe we can check
> the availability of the compiler and disable it back if not.

Right, an extra feature check.

- Arnaldo
