Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68064496E00
	for <lists+bpf@lfdr.de>; Sat, 22 Jan 2022 21:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbiAVUlC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 22 Jan 2022 15:41:02 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:42134 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiAVUlC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 22 Jan 2022 15:41:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CDA51B8091A;
        Sat, 22 Jan 2022 20:41:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54FEEC004E1;
        Sat, 22 Jan 2022 20:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642884059;
        bh=CCEzqgi6FRhJO/OWCZMQk5xq6qkKKr+JJxvzBcU7XeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QjEq5YKqji0txr33eKwEZvxNKa8jzXlneAckcJ1YF+XDNkTjnFXrIGM4bjXqU30Uu
         VyNPUen5m/e8+6s4e2MDtMCkXXsFA27o2xe2kzPJR/dzyPNaq5W8n9Kh/DmRc50/Xj
         Qkl5Jn5CFcGFTIBLbmR3IdGeprwkkYfhN7ItIPwDUvnCp0Nk4NtDIAsSXoCVWogzj5
         5csznvh9rZ9bpc4sPIhhv9KY+BT0xx7DpbXnabRzcvRX8NorhElEmrgjAb+mJWnB/v
         EuuFOu+USQ5dft7QyO6zaQuW0vlMDv8Dh9a52Y+YnmmUqkl1aRjFUSoWjPu07E3klT
         YnRBFdcNxcWkQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8811A40C99; Sat, 22 Jan 2022 17:38:56 -0300 (-03)
Date:   Sat, 22 Jan 2022 17:38:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Christy Lee <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Christy Lee <christyc.y.lee@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Wang Nan <wangnan0@huawei.com>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH bpf-next v4 0/2] perf: stop using deprecated bpf APIs
Message-ID: <YexrYDEeoAdcqoDE@kernel.org>
References: <20220119230636.1752684-1-christylee@fb.com>
 <CAEf4BzbODQmEH+wuFsEPFdtRoZ1Y-vDJKAKkBLsUDBLoQOmrvg@mail.gmail.com>
 <YexirjnVa7KpvrP9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YexirjnVa7KpvrP9@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Sat, Jan 22, 2022 at 05:01:50PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Jan 20, 2022 at 02:58:29PM -0800, Andrii Nakryiko escreveu:
> > On Wed, Jan 19, 2022 at 3:09 PM Christy Lee <christylee@fb.com> wrote:
> > >
> > > libbpf's bpf_load_program() and bpf__object_next() APIs are deprecated.
> > > remove perf's usage of these deprecated functions. After this patch
> > > set, the only remaining libbpf deprecated APIs in perf would be
> > > bpf_program__set_prep() and bpf_program__nth_fd().
> > >
> > 
> > Arnaldo, do you want to take this through perf tree or should we apply
> > this to bpf-next? If the latter, can you give your ack as well?
> > Thanks!
> 
> I'd love to be able to test it with the containers, after I push the
> current batch to Linus.

I just looked at it, simple enough, applied.

- Arnaldo
 
> - Arnaldo
>  
> > > Changelog:
> > > ----------
> > > v3 -> v4:
> > > * Fixed commit title
> > > * Added weak definition for deprecated function
> > >
> > > v2 -> v3:
> > > https://lore.kernel.org/all/20220106200032.3067127-1-christylee@fb.com/
> > >
> > > Patch 2/2:
> > > Fixed commit message to use upstream perf
> > >
> > > v1 -> v2:
> > > https://lore.kernel.org/all/20211216222108.110518-1-christylee@fb.com/
> > >
> > > Patch 1/2:
> > > Added missing commit message
> > >
> > > Patch 2/2:
> > > Added more details to commit message and added steps to reproduce
> > > original test case.
> > >
> > > Christy Lee (2):
> > >   perf: stop using deprecated bpf_load_program() API
> > >   perf: stop using deprecated bpf_object__next() API
> > >
> > >  tools/perf/tests/bpf.c       | 14 ++-----
> > >  tools/perf/util/bpf-event.c  | 16 ++++++++
> > >  tools/perf/util/bpf-loader.c | 72 +++++++++++++++++++++++++++---------
> > >  tools/perf/util/bpf-loader.h |  1 +
> > >  4 files changed, 75 insertions(+), 28 deletions(-)
> > >
> > > --
> > > 2.30.2
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
