Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB59DBDFE
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2019 09:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfJRHFB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Oct 2019 03:05:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:38934 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727011AbfJRHFB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Oct 2019 03:05:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 51E31AC18;
        Fri, 18 Oct 2019 07:04:59 +0000 (UTC)
Date:   Fri, 18 Oct 2019 09:04:57 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org, Andrii Nakryiko <andriin@fb.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH v2 31/33] tools lib bpf: Renaming pr_warning to pr_warn
Message-ID: <20191018070457.ge3wcpdle6pwtsxd@pathway.suse.cz>
References: <20191018031710.41052-1-wangkefeng.wang@huawei.com>
 <20191018031850.48498-1-wangkefeng.wang@huawei.com>
 <20191018031850.48498-31-wangkefeng.wang@huawei.com>
 <20191018042416.r4fffxzbxb3u4csg@ast-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018042416.r4fffxzbxb3u4csg@ast-mbp>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu 2019-10-17 21:24:19, Alexei Starovoitov wrote:
> On Fri, Oct 18, 2019 at 11:18:48AM +0800, Kefeng Wang wrote:
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
> > Acked-by: Andrii Nakryiko <andriin@fb.com>
> > Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> > ---
> >  tools/lib/bpf/btf.c             |  56 +--
> >  tools/lib/bpf/btf_dump.c        |  18 +-
> >  tools/lib/bpf/libbpf.c          | 679 ++++++++++++++++----------------
> >  tools/lib/bpf/libbpf_internal.h |   8 +-
> >  tools/lib/bpf/xsk.c             |   4 +-
> >  5 files changed, 379 insertions(+), 386 deletions(-)
> 
> Nack.
> I prefer this type of renaming to go via bpf tree.
> It's not a kernel patch. It's touching user space library
> which is under heavy development.
> Doing any other way will cause a ton of conflicts.

Fair enough. I'll ignore this patch. Could I assume that it will
be taken via bpf tree, please?

I'll also postpone the patch that removes pr_warning() to avoid
synchronization problems. I'll push it later when changes in
bpf[*] subsystem are merged.

[*] I am going to check conflicts against 5.4-rc1. I'll probably
ask more subsystems to take their changes to avoid conflicts
and make it smooth.

Best Regards,
Petr
