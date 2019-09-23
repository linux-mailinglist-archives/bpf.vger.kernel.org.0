Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 766CABAF3A
	for <lists+bpf@lfdr.de>; Mon, 23 Sep 2019 10:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437631AbfIWIUp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Sep 2019 04:20:45 -0400
Received: from www62.your-server.de ([213.133.104.62]:42736 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392126AbfIWIUp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Sep 2019 04:20:45 -0400
Received: from [178.197.248.15] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iCJaJ-0007z4-U5; Mon, 23 Sep 2019 10:20:40 +0200
Date:   Mon, 23 Sep 2019 10:20:39 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andy Whitcroft <apw@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        open list <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH 30/32] tools lib bpf: Renaming pr_warning to pr_warn
Message-ID: <20190923082039.GA2530@pc-63.home>
References: <20190920062544.180997-1-wangkefeng.wang@huawei.com>
 <20190920062544.180997-31-wangkefeng.wang@huawei.com>
 <CAEf4BzbD98xeU2dSrXYkVi+mK=kuq+5DsroNDZwOzBGYbMH1-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbD98xeU2dSrXYkVi+mK=kuq+5DsroNDZwOzBGYbMH1-w@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25580/Sun Sep 22 10:23:13 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Sep 22, 2019 at 02:07:21PM -0700, Andrii Nakryiko wrote:
> On Fri, Sep 20, 2019 at 10:06 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> >
> > For kernel logging macro, pr_warning is completely removed and
> > replaced by pr_warn, using pr_warn in tools lib bpf for symmetry
> > to kernel logging macro, then we could drop pr_warning in the
> > whole linux code.
> >
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: Martin KaFai Lau <kafai@fb.com>
> > Cc: Song Liu <songliubraving@fb.com>
> > Cc: Yonghong Song <yhs@fb.com>
> > Cc: bpf@vger.kernel.org
> > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> > ---
> >  tools/lib/bpf/btf.c             |  56 +--
> >  tools/lib/bpf/btf_dump.c        |  20 +-
> >  tools/lib/bpf/libbpf.c          | 652 ++++++++++++++++----------------
> >  tools/lib/bpf/libbpf_internal.h |   2 +-
> >  tools/lib/bpf/xsk.c             |   4 +-
> >  5 files changed, 363 insertions(+), 371 deletions(-)
> 
> Thanks! This will allow to get rid of tons warnings from checkpatch.pl.
> 
> Alexei, Daniel, can we take this through bpf-next tree once it's open?

I'd be fine with that, in fact, it probably should be in order to avoid
merge conflicts since pr_warn{ing}() is used all over the place in libbpf.

Kefeng would then however also need to include the original patch which
adds the pr_warn() to tools in the first place.

> Acked-by: Andrii Nakryiko <andriin@fb.com>
> 
> [...]
