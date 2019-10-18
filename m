Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF89DCEBC
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2019 20:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439902AbfJRSw0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Oct 2019 14:52:26 -0400
Received: from www62.your-server.de ([213.133.104.62]:56792 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfJRSw0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Oct 2019 14:52:26 -0400
Received: from 55.249.197.178.dynamic.dsl-lte-bonding.lssmb00p-msn.res.cust.swisscom.ch ([178.197.249.55] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iLXML-0004R5-9H; Fri, 18 Oct 2019 20:52:21 +0200
Date:   Fri, 18 Oct 2019 20:52:20 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org, Andrii Nakryiko <andriin@fb.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH v2 31/33] tools lib bpf: Renaming pr_warning to pr_warn
Message-ID: <20191018185220.GE26267@pc-63.home>
References: <20191018031710.41052-1-wangkefeng.wang@huawei.com>
 <20191018031850.48498-1-wangkefeng.wang@huawei.com>
 <20191018031850.48498-31-wangkefeng.wang@huawei.com>
 <20191018042416.r4fffxzbxb3u4csg@ast-mbp>
 <20191018070457.ge3wcpdle6pwtsxd@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018070457.ge3wcpdle6pwtsxd@pathway.suse.cz>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25606/Fri Oct 18 10:58:40 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 18, 2019 at 09:04:57AM +0200, Petr Mladek wrote:
> On Thu 2019-10-17 21:24:19, Alexei Starovoitov wrote:
> > On Fri, Oct 18, 2019 at 11:18:48AM +0800, Kefeng Wang wrote:
> > > For kernel logging macro, pr_warning is completely removed and
> > > replaced by pr_warn, using pr_warn in tools lib bpf for symmetry
> > > to kernel logging macro, then we could drop pr_warning in the
> > > whole linux code.
> > > 
> > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > > Cc: Martin KaFai Lau <kafai@fb.com>
> > > Cc: Song Liu <songliubraving@fb.com>
> > > Cc: Yonghong Song <yhs@fb.com>
> > > Cc: bpf@vger.kernel.org
> > > Acked-by: Andrii Nakryiko <andriin@fb.com>
> > > Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> > > ---
> > >  tools/lib/bpf/btf.c             |  56 +--
> > >  tools/lib/bpf/btf_dump.c        |  18 +-
> > >  tools/lib/bpf/libbpf.c          | 679 ++++++++++++++++----------------
> > >  tools/lib/bpf/libbpf_internal.h |   8 +-
> > >  tools/lib/bpf/xsk.c             |   4 +-
> > >  5 files changed, 379 insertions(+), 386 deletions(-)
> > 
> > Nack.
> > I prefer this type of renaming to go via bpf tree.
> > It's not a kernel patch. It's touching user space library
> > which is under heavy development.
> > Doing any other way will cause a ton of conflicts.
> 
> Fair enough. I'll ignore this patch. Could I assume that it will
> be taken via bpf tree, please?
> 
> I'll also postpone the patch that removes pr_warning() to avoid
> synchronization problems. I'll push it later when changes in
> bpf[*] subsystem are merged.
> 
> [*] I am going to check conflicts against 5.4-rc1. I'll probably
> ask more subsystems to take their changes to avoid conflicts
> and make it smooth.

The stand-alone patch as-is currently doesn't apply to bpf-next.
Could you spin a fresh rebase and resubmit?

Thanks,
Daniel
