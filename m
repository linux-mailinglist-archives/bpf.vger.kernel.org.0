Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88ED839A3C3
	for <lists+bpf@lfdr.de>; Thu,  3 Jun 2021 16:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbhFCO6w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Jun 2021 10:58:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:45826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231411AbhFCO6w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Jun 2021 10:58:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 31DEC613E3;
        Thu,  3 Jun 2021 14:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622732227;
        bh=iOSsgdS8c3kqEElZXShIq5hdaRoypd8OdXLk+YarE4s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EUi52X8SPTuvnRTGydOz6BRMR4SQQygG+SnLv5WSNqoyYxW2hxPHfwqGMrYUeaOos
         xg4ZI/8FT7kU6xm28ztz6fn3Vx/k7Hg3DgM8nxEsaKq9hJAc71ieorXRO/D2oVxmW2
         lV8I943qSlduCRCqfzRo9KX3v8muII+wU2NmARIaENVjs+2VsRg7wKbooV+N64JAok
         DrVNDBamE+TSJvLjsLUIwf9pW2oWzJcnEq8db2gOWZck3UeT9EiZJiscntDsaxpuey
         ZnAbYYkAMgKODxGQtr3cKOE+41qeDZRf1bbni0DuYSE7syYb55qXK9CGdNtWVHQekY
         sxZMif5FO8/lA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9D1EA40EFC; Thu,  3 Jun 2021 11:57:04 -0300 (-03)
Date:   Thu, 3 Jun 2021 11:57:04 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [RFT] Testing 1.22
Message-ID: <YLjtwB+nGYvcCfgC@kernel.org>
References: <YK+41f972j25Z1QQ@kernel.org>
 <CAEf4BzaTP_jULKMN_hx6ZOqwESOmsR6_HxWW-LnrA5xwRNtSWg@mail.gmail.com>
 <4615C288-2CFD-483E-AB98-B14A33631E2F@gmail.com>
 <CAEf4BzaQmv1+1bPF=1aO3dcmNu2Mx0EFhK+ZU6UFsMjv3v6EZA@mail.gmail.com>
 <4901AF88-0354-428B-9305-2EDC6F75C073@gmail.com>
 <CAEf4BzZk8bcSZ9hmFAmgjbrQt0Yj1usCHmuQTfU-pwZkYQgztA@mail.gmail.com>
 <YLFIW9fd9ZqbR3B9@kernel.org>
 <CAEf4BzYCCWM0WBz0w+vL1rVBjGvLZ7wVtgJCUVr3D-NmVK0MEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYCCWM0WBz0w+vL1rVBjGvLZ7wVtgJCUVr3D-NmVK0MEg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Sat, May 29, 2021 at 05:40:17PM -0700, Andrii Nakryiko escreveu:
> On Fri, May 28, 2021 at 12:45 PM Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > commit b579a18a1ea0ee84b90b5302f597dda2edf2f61b
> > Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Date:   Fri May 28 16:41:30 2021 -0300
> >
> >     pahole: Allow encoding BTF into a detached file
> >
> >     Previously the newly encoded BTF info was stored into a ELF section in
> >     the file where the DWARF info was obtained, but it is useful to just
> >     dump it into a separate file, do it.
> >
> >     Requested-by: Andrii Nakryiko <andrii@kernel.org>
> >     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> >
> 
> Looks good, see few minor comments below. At some point it probably
> would make sense to formalize "btf_encoder" as a struct with its own
> state instead of passing in multiple variables. It would probably also

Take a look at the tmp.master branch at:

https://git.kernel.org/pub/scm/devel/pahole/pahole.git/log/?h=tmp.master

that btf_elf class isn't used anymore by btf_loader, that uses only
libbpf's APIs, and now we have a btf_encoder class with all the globals,
etc, more baby steps are needed to finally ditch btf_elf altogether and
move on to the parallelization.

I'm doing 'pahole -J vmlinux && btfdiff' after each cset and doing it
very piecemeal as I'm doing will help bisecting any subtle bug this may
introduce.

> allow to parallelize BTF generation, where each CU would proceed in
> parallel generating local BTF, and then the final pass would merge and
> dedup BTFs. Currently reading and processing DWARF is the slowest part
> of the DWARF-to-BTF conversion, parallelization and maybe some other
> optimization seems like the only way to speed the process up.
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Thanks!

- Arnaldo
