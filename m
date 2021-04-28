Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDDD936E15C
	for <lists+bpf@lfdr.de>; Thu, 29 Apr 2021 00:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbhD1WGB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Apr 2021 18:06:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:39260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229488AbhD1WGA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Apr 2021 18:06:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 191F961352;
        Wed, 28 Apr 2021 22:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619647515;
        bh=FGs86d/LbRhfYZZhsLqUx+A4yXtI4DHMtl9ILbHTC3E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UEzHubqR+m7QG1aXffYAgFrz0w5mve6G+A5ppTPBxuiB5o4awjNLU+9iXyxUhtcgK
         CGQcQZIv9h0rJXnGSvgcPFmSHs+FqW/9eZQ9+2F1vuRCBH+q1JmCIXV2QugbiXPU5F
         0/5qguK5ESy1LyRh2E0GWbhgKep6BhGDfMkntJL2Q4qFLnsiA8tIdVDiXNCf7PWpqX
         /+/5/B/BUVOOSmKPlUufujKiAq2IJfHx97VsKq2pFyaeE2A1qBYhvl3jGANdlY0gTL
         fTaBRlr0FArzvM5JRrgQ2Tv3n2IjbAgXZ0Qh/3QV88tEeOUAj/TrkCXo4si87guxbg
         m/6AhDImFNZpA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3A0394034C; Wed, 28 Apr 2021 19:05:12 -0300 (-03)
Date:   Wed, 28 Apr 2021 19:05:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>, Martin KaFai Lau <kafai@fb.com>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH dwarves] btf: Generate btf for functions in the .BTF_ids
 section
Message-ID: <YIncGM/9BsB8h7PW@kernel.org>
References: <20210423213728.3538141-1-kafai@fb.com>
 <CAEf4BzY16ziMkOMdNGNjQOmiACF3E5nFn2LhtUUQbo-y-AP7Tg@mail.gmail.com>
 <YIf3rHTLqW7yZxFJ@krava>
 <YIgE1hAaa3Hzwni8@kernel.org>
 <CAEf4Bzbh7+WJ502J_MQKiHDZ_Ab-Vb_ysHO6NNuZwNfThKCAKw@mail.gmail.com>
 <YIle2kdR4IniQnbN@kernel.org>
 <CAEf4BzbzYeG9fWPe=Vugq8WG6bK79dk3byjWV9gtCX_v7L0XLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbzYeG9fWPe=Vugq8WG6bK79dk3byjWV9gtCX_v7L0XLw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Apr 28, 2021 at 12:45:10PM -0700, Andrii Nakryiko escreveu:
> On Wed, Apr 28, 2021 at 6:10 AM Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > Em Tue, Apr 27, 2021 at 01:38:51PM -0700, Andrii Nakryiko escreveu:
> > > On Tue, Apr 27, 2021 at 5:34 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> > > > And tools that expect to trace a function can get that information from
> > > > the BTF info instead of getting some failure when trying to trace those
> > > > functions, right?

> > > I don't think it belongs in BTF, though.

> > My thinking was that since BTF is used when tracing, one would be
> > interested in knowing if some functions can't be used for that.

> > > Plus there are additional limitations enforced by BPF verifier that
> > > will prevent some functions to be attached. So just because the
> > > function is in BTF doesn't mean it's 100% attachable.

> > Well, at least we would avoid some that can't for sure be used for
> > tracing. But, a bit in there is precious, so probably geting a NACK from
> > the kernel should be a good enough capability query. :-)

> > Tools should just silently prune things in wildcards provided by the
> > user that aren't traceable, silently, and provide an error message when
> > the user explicitely asks for tracing a verbotten function.

> Yep, that's what I'm doing in my retsnoop tool (I both filter by
> available kprobes [0], and have extra blacklist [1]). Loading kprobes
> is pretty simple and fast enough, shouldn't be a problem.

>   [0] https://github.com/anakryiko/retsnoop/blob/master/src/mass_attacher.c#L495
>   [1] https://github.com/anakryiko/retsnoop/blob/master/src/mass_attacher.c#L41

Oh my, one more tool to download, build, try, have updated, etc. Will
look at it, thanks for the pointer.

- Arnaldo
