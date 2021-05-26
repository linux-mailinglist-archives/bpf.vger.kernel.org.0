Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6887391EC6
	for <lists+bpf@lfdr.de>; Wed, 26 May 2021 20:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbhEZSOm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 May 2021 14:14:42 -0400
Received: from outbound-smtp56.blacknight.com ([46.22.136.240]:50155 "EHLO
        outbound-smtp56.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234857AbhEZSOl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 26 May 2021 14:14:41 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp56.blacknight.com (Postfix) with ESMTPS id E46D5FB091
        for <bpf@vger.kernel.org>; Wed, 26 May 2021 19:13:08 +0100 (IST)
Received: (qmail 4224 invoked from network); 26 May 2021 18:13:08 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 26 May 2021 18:13:08 -0000
Date:   Wed, 26 May 2021 19:13:07 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Suchanek <msuchanek@suse.de>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Hritik Vijay <hritikxx8@gmail.com>, bpf <bpf@vger.kernel.org>,
        Linux-Net <netdev@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH] mm/page_alloc: Work around a pahole limitation with
 zero-sized struct pagesets
Message-ID: <20210526181306.GZ30378@techsingularity.net>
References: <20210526080741.GW30378@techsingularity.net>
 <CAEf4BzZOQnBgYXSR71HgsqhYcaFk5M5mre+6do+hnuxgWx5aNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAEf4BzZOQnBgYXSR71HgsqhYcaFk5M5mre+6do+hnuxgWx5aNg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 26, 2021 at 09:57:31AM -0700, Andrii Nakryiko wrote:
> > This patch checks for older versions of pahole and forces struct pagesets
> > to be non-zero sized as a workaround when CONFIG_DEBUG_INFO_BTF is set. A
> > warning is omitted so that distributions can update pahole when 1.22
> 
> s/omitted/emitted/ ?
> 

Yes.

> > is released.
> >
> > Reported-by: Michal Suchanek <msuchanek@suse.de>
> > Reported-by: Hritik Vijay <hritikxx8@gmail.com>
> > Debugged-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> > ---
> 
> Looks good! I verified that this does fix the issue on the latest
> linux-next tree, thanks!
> 

Excellent

> One question, should
> 
> Fixes: 5716a627517d ("mm/page_alloc: convert per-cpu list protection
> to local_lock")
> 
> be added to facilitate backporting?
> 

The git commit is not stable because the patch "mm/page_alloc: convert
per-cpu list protection to local_lock" is in Andrew's mmotm tree which is
quilt based. I decided not to treat the patch as a fix because the patch is
not wrong as such, it's a limitation of an external tool.  However, I would
expect both the problematic patch and the BTF workaround to go in during
the same merge window so backports to -stable should not be required.

> Either way:
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Tested-by: Andrii Nakryiko <andrii@kernel.org>
> 

Thanks!

-- 
Mel Gorman
SUSE Labs
