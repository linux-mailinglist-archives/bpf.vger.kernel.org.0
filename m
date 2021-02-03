Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5BF30E41D
	for <lists+bpf@lfdr.de>; Wed,  3 Feb 2021 21:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbhBCUfS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Feb 2021 15:35:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45920 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231215AbhBCUfR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 3 Feb 2021 15:35:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612384428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=krs5e0r7QMdnWdSnIqnS9a3YmE+2f248GaZHUnucJGE=;
        b=XYabp5yo02JO0djUtSq9y8wG5u0upzEoYktOXy4wTnHaPKARilHDSoousSuAWsRZLh0+E8
        AAsTlHdNzULCyo6XetvrnQuAbqkmQmOOys4dhTYN4p4XV++czGwv37dJ18B//QrwHwL1WT
        pZ73dGCRHrhKfw2kiR++qoyEGQKiT9Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-603-TwsR_zCAOa2HJ_gL0jXKgw-1; Wed, 03 Feb 2021 15:33:47 -0500
X-MC-Unique: TwsR_zCAOa2HJ_gL0jXKgw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42443100D1C2;
        Wed,  3 Feb 2021 20:33:46 +0000 (UTC)
Received: from krava (unknown [10.40.196.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DCC5F722C7;
        Wed,  3 Feb 2021 20:33:41 +0000 (UTC)
Date:   Wed, 3 Feb 2021 21:33:40 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, Jiri Olsa <jolsa@kernel.org>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        bpf <bpf@vger.kernel.org>
Subject: Re: finding libelf
Message-ID: <YBsIpCQG3QLcYLVw@krava>
References: <8a6894e9-71ef-09e3-64fa-bf6794fc6660@infradead.org>
 <87eehxa06v.fsf@toke.dk>
 <a6a8fbd6-c610-873e-12e1-b6b0fadb94be@infradead.org>
 <CAEf4Bzb7-jpQLStjtrWm+CvDkLGHR_LiVdb6YcagR2v-Yt42tw@mail.gmail.com>
 <CAEf4BzbvQPmaDauPeH5FiqgjVjf-TA+kKL6gsN505q02Un6QZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbvQPmaDauPeH5FiqgjVjf-TA+kKL6gsN505q02Un6QZA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 03, 2021 at 12:06:10PM -0800, Andrii Nakryiko wrote:
> On Wed, Feb 3, 2021 at 11:39 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Feb 3, 2021 at 9:22 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> > >
> > > On 2/3/21 2:57 AM, Toke Høiland-Jørgensen wrote:
> > > > Randy Dunlap <rdunlap@infradead.org> writes:
> > > >
> > > >> Hi,
> > > >>
> > > >> I see this sometimes when building a kernel: (on x86_64,
> > > >> with today's linux-next 20210202):
> > > >>
> > > >>
> > > >> CONFIG_CGROUP_BPF=y
> > > >> CONFIG_BPF=y
> > > >> CONFIG_BPF_SYSCALL=y
> > > >> CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
> > > >> CONFIG_BPF_PRELOAD=y
> > > >> CONFIG_BPF_PRELOAD_UMD=m
> > > >> CONFIG_HAVE_EBPF_JIT=y
> > > >>
> > > >>
> > > >> Auto-detecting system features:
> > > >> ...                        libelf: [ [31mOFF[m ]
> > > >> ...                          zlib: [ [31mOFF[m ]
> > > >> ...                           bpf: [ [31mOFF[m ]
> > > >>
> > > >> No libelf found
> > > >> make[5]: [Makefile:287: elfdep] Error 1 (ignored)
> > > >> No zlib found
> > > >> make[5]: [Makefile:290: zdep] Error 1 (ignored)
> > > >> BPF API too old
> > > >> make[5]: [Makefile:293: bpfdep] Error 1 (ignored)
> > > >>
> > > >>
> > > >> but pkg-config tells me:
> > > >>
> > > >> $ pkg-config --modversion  libelf
> > > >> 0.168
> > > >> $ pkg-config --libs  libelf
> > > >> -lelf
> > > >>
> > > >>
> > > >> Any ideas?
> > > >
> > > > This usually happens because there's a stale cache of the feature
> > > > detection tests lying around somewhere. Look for a 'feature' directory
> > > > in whatever subdir you got that error. Just removing the feature
> > > > directory usually fixes this; I've fixed a couple of places where this
> > > > is not picked up by 'make clean' (see, e.g., 9d9aae53b96d ("bpf/preload:
> > > > Make sure Makefile cleans up after itself, and add .gitignore")) but I
> > > > wouldn't be surprised if there are still some that are broken.
> > >
> > > Hi,
> > >
> > > Thanks for replying.
> > >
> > > I removed the feature subdir and still got this build error, so I
> > > removed everything in BUILDDIR/kernel/bpf/preload and rebuilt --
> > > and still got the same libelf build error.
> >
> > I hate the complexity of feature detection framework to the point that
> > I'm willing to rip it out from libbpf's Makefile completely. I just
> > spent an hour trying to understand what's going on in a very similar
> > situation. Extremely frustrating.
> >
> > In your case, it might be feature detection triggered from
> > resolve_btfids, so try removing
> > $(OUTPUT)/tools/bpf/resolve_btfids/{feature/,FEATURE-DUMP.libbpf}.
> >
> > It seems like we don't do proper cleanup in resolve_btfids (it should
> > probably call libbpf's clean as well). And it's beyond me why `make -C
> > tools/build/feature clean` doesn't clean up FEATURE-DUMP.<use-case>
> > file as well.
> 
> So resolve_btfids does call libbpf's clean, but Linux Kbuild never
> calls resolve_btfids' clean. Jiri, do you think that could be
> improved? Basically, if something goes wrong with feature detection,
> no amount of `make clean` would help and users will be forced to
> struggle with frustrating experience trying to understand what's going
> on.

ok, that one is missing.. will add

> 
> I also still think that FEATURE-DUMP should be cleaned up by feature
> infra on clean and that's not happening today, but I'm unwilling to go
> and untangle all that complexity right now.

I haven't seen this error for some time so I thought we got rid of it,
I'll try to reproduce and fix

jirka

