Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160883CB3C0
	for <lists+bpf@lfdr.de>; Fri, 16 Jul 2021 10:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhGPIK2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Jul 2021 04:10:28 -0400
Received: from outbound-smtp30.blacknight.com ([81.17.249.61]:44599 "EHLO
        outbound-smtp30.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236777AbhGPIK2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 16 Jul 2021 04:10:28 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp30.blacknight.com (Postfix) with ESMTPS id D804F24068
        for <bpf@vger.kernel.org>; Fri, 16 Jul 2021 09:07:32 +0100 (IST)
Received: (qmail 22557 invoked from network); 16 Jul 2021 08:07:32 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 16 Jul 2021 08:07:32 -0000
Date:   Fri, 16 Jul 2021 09:07:30 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Michal Such?nek <msuchanek@suse.de>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Hritik Vijay <hritikxx8@gmail.com>,
        Linux-BPF <bpf@vger.kernel.org>,
        Linux-Net <netdev@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, clm@fb.com
Subject: Re: [PATCH v3] mm/page_alloc: Require pahole v1.22 to cope with
 zero-sized struct pagesets
Message-ID: <20210716080730.GU3809@techsingularity.net>
References: <20210527171923.GG30378@techsingularity.net>
 <CAEf4BzZB7Z3fGyVH1+a9SvTtm1LBBG2T++pYiTjRVxbrodzzZA@mail.gmail.com>
 <20210528074248.GI30378@techsingularity.net>
 <CAEf4BzYrfKtecSEbf3yZs5v6aeSkNRJuHfed3kKz-6Vy1eeKuA@mail.gmail.com>
 <20210531093554.GT30378@techsingularity.net>
 <20210715194453.GI24916@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210715194453.GI24916@kitsune.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 15, 2021 at 09:44:53PM +0200, Michal Such?nek wrote:
> > > Well, luckily it seems we anticipated issues like that and added
> > > --skip_encoding_btf_vars argument, which I completely forgot about and
> > > just accidentally came across reviewing Arnaldo's latest pahole patch.
> > > I think that one is a much better solution, as then it will impact
> > > only those that explicitly relies on availability of BTF for per-CPU
> > > variables, which is a subset of all possible uses for kernel BTF. Sent
> > > a patch ([0]), please take a look.
> > > 
> > >   [0] https://lore.kernel.org/linux-mm/20210530002536.3193829-1-andrii@kernel.org/T/#u
> > 
> > I'm happy to have this patch used as an alternative to forcing 1.22 to
> > be the minimum version of pahole required.
> 
> Is pahole 1.22 available already?
> 

Ultimately it was of less importance because of a0b8200d06ad ("kbuild:
skip per-CPU BTF generation for pahole v1.18-v1.21"). As I write this,
pahole v1.22 has not been tagged.

-- 
Mel Gorman
SUSE Labs
