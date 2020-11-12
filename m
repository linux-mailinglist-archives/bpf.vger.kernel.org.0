Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36782AFD29
	for <lists+bpf@lfdr.de>; Thu, 12 Nov 2020 02:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbgKLBcM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Nov 2020 20:32:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:39130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728104AbgKLAhi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Nov 2020 19:37:38 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93F0A205CB;
        Thu, 12 Nov 2020 00:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605141377;
        bh=DOk7cRTHZcbOlKVbRDvxMzJo/3Y4kVTkoZ+PTgYoh3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ig2W3ZFCr2btoWO85apExmU4ulkGa9Mf3rczwlg471zRVQQkqo003tOnYbVwwkgez
         YGIsxroBwZTt9P/LqurIxs8aYv4yCGqHQj+F4oNg9RMfVu8bZvllGuWUu2q0kPylqt
         O13PxFJqP+5jbQsMzD3PKh6uZ8+87QBF11AI7NZ8=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5A796411D1; Wed, 11 Nov 2020 21:36:15 -0300 (-03)
Date:   Wed, 11 Nov 2020 21:36:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Subject: Re: [PATCH 3/3] btf_encoder: Change functions check due to broken
 dwarf
Message-ID: <20201112003615.GH380127@kernel.org>
References: <20201106222512.52454-1-jolsa@kernel.org>
 <20201106222512.52454-4-jolsa@kernel.org>
 <CAEf4BzZqFos1N-cnyAc6nL-=fHFJYn1tf9vNUewfsmSUyK4rQQ@mail.gmail.com>
 <20201111201929.GB619201@krava>
 <20201111203130.GC619201@krava>
 <CAEf4BzZ089_ECxY_tFBMUc5c-rwtD9Mw8n7anUsdgpzgoipsPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZ089_ECxY_tFBMUc5c-rwtD9Mw8n7anUsdgpzgoipsPg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Nov 11, 2020 at 12:36:55PM -0800, Andrii Nakryiko escreveu:
> On Wed, Nov 11, 2020 at 12:31 PM Jiri Olsa <jolsa@redhat.com> wrote:
> > On Wed, Nov 11, 2020 at 09:19:29PM +0100, Jiri Olsa wrote:
> > > On Wed, Nov 11, 2020 at 11:59:20AM -0800, Andrii Nakryiko wrote:
> > > SNIP

> > > > > +       if (!fl->init_bpf_begin &&
> > > > > +           !strcmp("__init_bpf_preserve_type_begin", elf_sym__name(sym, btfe->symtab)))
> > > > > +               fl->init_bpf_begin = sym->st_value;
> > > > > +
> > > > > +       if (!fl->init_bpf_end &&
> > > > > +           !strcmp("__init_bpf_preserve_type_end", elf_sym__name(sym, btfe->symtab)))
> > > > > +               fl->init_bpf_end = sym->st_value;
> > > > > +}
> > > > > +
> > > > > +static int has_all_symbols(struct funcs_layout *fl)
> > > > > +{
> > > > > +       return fl->mcount_start && fl->mcount_stop &&
> > > > > +              fl->init_begin && fl->init_end &&
> > > > > +              fl->init_bpf_begin && fl->init_bpf_end;

> > > > See below for what seems to be the root cause for the immediate problem.

> > > > But me, Alexei and Daniel had a discussion offline, and we concluded
> > > > that this special bpf_preserve_init section is probably not the right
> > > > approach overall. We should roll back the bpf patch and instead adjust
> > > > pahole's approach. I think we should just drop the __init check and
> > > > include all the __init functions into BTF. There could be cases where
> > > > we'd need to attach BPF programs to __init functions (e.g., bpf_lsm
> > > > security cases), so having BTFs for those FUNCs are necessary as well.
> > > > Ftrace currently disallows that, but it's only because no user-space
> > > > application has a way to attach probes early enough. This might change
> > > > in the future, so there is no need to invent special mechanisms now
> > > > for bpf_iter function preservation. Let's just include all __init
> > > > functions in BTF. Can you please do that change and check how much
> > > > more functions we get in BTF? Thanks!

> > > sure, not problem to keep all init functions, will give you the count

> > with pahole change below (on top of current master) and kernel
> > without the special init section, I'm getting over ~2000 functions
> > more on my .config:

> >   $ bpftool btf dump file ./vmlinux | grep 'FUNC ' | wc -l
> >   41505
> >   $ bpftool btf dump file /sys/kernel/btf/vmlinux | grep 'FUNC ' | wc -l
> >   39256

> That's a very small percentage increase, let's just do this.

Agreed, if that is the only difference, no point in complicating things
as before, we end up with unforeseen trouble as we noticed.

- Arnaldo
