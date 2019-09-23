Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC66CBB57E
	for <lists+bpf@lfdr.de>; Mon, 23 Sep 2019 15:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439760AbfIWNgA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Sep 2019 09:36:00 -0400
Received: from www62.your-server.de ([213.133.104.62]:50092 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730669AbfIWNgA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Sep 2019 09:36:00 -0400
Received: from [178.197.248.15] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iCOVK-0004dR-Id; Mon, 23 Sep 2019 15:35:50 +0200
Date:   Mon, 23 Sep 2019 15:35:50 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Whitcroft <apw@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 30/32] tools lib bpf: Renaming pr_warning to pr_warn
Message-ID: <20190923133550.GA9880@pc-63.home>
References: <20190920062544.180997-1-wangkefeng.wang@huawei.com>
 <20190920062544.180997-31-wangkefeng.wang@huawei.com>
 <CAEf4BzbD98xeU2dSrXYkVi+mK=kuq+5DsroNDZwOzBGYbMH1-w@mail.gmail.com>
 <20190923082039.GA2530@pc-63.home>
 <20190923110306.hrgeqwo5ogd55vfo@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923110306.hrgeqwo5ogd55vfo@pathway.suse.cz>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25581/Mon Sep 23 10:20:21 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 23, 2019 at 01:03:06PM +0200, Petr Mladek wrote:
> On Mon 2019-09-23 10:20:39, Daniel Borkmann wrote:
> > On Sun, Sep 22, 2019 at 02:07:21PM -0700, Andrii Nakryiko wrote:
> > > On Fri, Sep 20, 2019 at 10:06 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> > > >
> > > > For kernel logging macro, pr_warning is completely removed and
> > > > replaced by pr_warn, using pr_warn in tools lib bpf for symmetry
> > > > to kernel logging macro, then we could drop pr_warning in the
> > > > whole linux code.
> > > >
> > > > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> > > > ---
> > > >  tools/lib/bpf/btf.c             |  56 +--
> > > >  tools/lib/bpf/btf_dump.c        |  20 +-
> > > >  tools/lib/bpf/libbpf.c          | 652 ++++++++++++++++----------------
> > > >  tools/lib/bpf/libbpf_internal.h |   2 +-
> > > >  tools/lib/bpf/xsk.c             |   4 +-
> > > >  5 files changed, 363 insertions(+), 371 deletions(-)
> > > 
> > > Thanks! This will allow to get rid of tons warnings from checkpatch.pl.
> > > 
> > > Alexei, Daniel, can we take this through bpf-next tree once it's open?
> > 
> > I'd be fine with that, in fact, it probably should be in order to avoid
> > merge conflicts since pr_warn{ing}() is used all over the place in libbpf.
> 
> The entire patchset modifies many files all over the tree.
> This is from https://lkml.kernel.org/r/20190920062544.180997-1-wangkefeng.wang@huawei.com
> 
>     120 files changed, 882 insertions(+), 927 deletions(-)
> 
> Would it make sense to push everything at the end of the merge window
> or for 5.4-rc2 after master settles down?

If all over the tree it would probably make more sense for e.g. Andrew Morton to
pick it up if there are no other objections, and try to merge it during mentioned
time frame.

Thanks,
Daniel
