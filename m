Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB16B20F675
	for <lists+bpf@lfdr.de>; Tue, 30 Jun 2020 15:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730303AbgF3N6s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Jun 2020 09:58:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33682 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728306AbgF3N6s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Jun 2020 09:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593525526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vrr9+UDr/nL1jLcaePhj7X9mSwa+9jdHrZ+GGReV/Jo=;
        b=NgG0vDAfxqemEYkEmaP3Nrxqs+TkhgegkkYIfPAv8P1W+llKn4KoWYvaW1wG7ctnVzago5
        dJaIIbpq2imi2cln+CqDprYT+WBmQlOl6AdsVGhRn6OZ3yzvgVqBf5+i9GxjYLdYopvJ7P
        AarEDd+AgidTpW3oJrLCbTWrH2lm+WE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-89yaZnypPKmKN1Pax-Ichg-1; Tue, 30 Jun 2020 09:58:43 -0400
X-MC-Unique: 89yaZnypPKmKN1Pax-Ichg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6782E15676;
        Tue, 30 Jun 2020 13:55:43 +0000 (UTC)
Received: from krava (unknown [10.40.192.137])
        by smtp.corp.redhat.com (Postfix) with SMTP id 84EAA60C81;
        Tue, 30 Jun 2020 13:55:39 +0000 (UTC)
Date:   Tue, 30 Jun 2020 15:55:38 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        David Miller <davem@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Wenbo Zhang <ethercflow@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Brendan Gregg <bgregg@netflix.com>,
        Florent Revest <revest@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v4 bpf-next 00/14] bpf: Add d_path helper
Message-ID: <20200630135538.GB3071036@krava>
References: <20200625221304.2817194-1-jolsa@kernel.org>
 <CAEf4BzbMND3VGxzqYU38agbTd+EVquD7J1Spx9LeR=569qMyEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbMND3VGxzqYU38agbTd+EVquD7J1Spx9LeR=569qMyEg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 29, 2020 at 06:54:30PM -0700, Andrii Nakryiko wrote:
> On Thu, Jun 25, 2020 at 4:47 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > hi,
> > adding d_path helper to return full path for 'path' object.
> >
> > In a preparation for that, this patchset also adds support for BTF ID
> > whitelists, because d_path can't be called from any probe due to its
> > locks usage. The whitelists allow verifier to check if the caller is
> > one of the functions from the whitelist.
> >
> > The whitelist is implemented in a generic way. This patchset introduces
> > macros that allow to define lists of BTF IDs, which are compiled in
> > the kernel image in a new .BTF.ids ELF section.
> >
> > The generic way of BTF ID lists allows us to use them in other places
> > in kernel (than just for whitelists), that could use static BTF ID
> > values compiled in and it's also implemented in this patchset.
> >
> > I originally added and used 'file_path' helper, which did the same,
> > but used 'struct file' object. Then realized that file_path is just
> > a wrapper for d_path, so we'd cover more calling sites if we add
> > d_path helper and allowed resolving BTF object within another object,
> > so we could call d_path also with file pointer, like:
> >
> >   bpf_d_path(&file->f_path, buf, size);
> >
> > This feature is mainly to be able to add dpath (filepath originally)
> > function to bpftrace:
> >
> >   # bpftrace -e 'kfunc:vfs_open { printf("%s\n", dpath(args->path)); }'
> >
> > v4 changes:
> >   - added ID sanity checks in btf_resolve_helper_id [Andrii]
> >   - resolve bpf_ctx_convert via BTF_ID [Andrii]
> >   - keep bpf_access_type in btf_struct_access [Andrii]
> >   - rename whitelist to se and use struct btf_id_set [Andrii]
> >   - several fixes for d_path prog/verifier tests [Andrii]
> >   - added union and typedefs types support [Andrii]
> >   - rename btfid to resolve_btfids [Andrii]
> >   - fix segfault in resolve_btfids [John]
> >   - rename section from .BTF_ids .BTF.ids (following .BTF.ext example)
> >   - add .BTF.ids section info into btf.rst [John]
> >   - updated over letter with more details [John]
> >
> > Also available at:
> >   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> >   bpf/d_path
> >
> > thanks,
> > jirka
> >
> >
> > ---
> 
> Have you considered splitting this series into two? One with BTF ID
> resolution and corresponding patches. I'm pretty confident in that one
> and it seems ready (with some minor selftest changes). Then,
> separately, d_path and that sub-struct address logic. That one depends
> on the first one, but shouldn't really block BTF ID resolution from
> going in sooner.

ok, will split it and send the first part for now

jirka

