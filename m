Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6745130F150
	for <lists+bpf@lfdr.de>; Thu,  4 Feb 2021 11:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbhBDK4l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Feb 2021 05:56:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21070 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235332AbhBDK4k (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 4 Feb 2021 05:56:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612436114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HsSUJqRpxx1yYgtE08Em8AMXnkOhHSI7H5LXeUE2PZs=;
        b=XFxZ62QJHgzy8fZmxl+xzEd9LsMOdZbCzVU4LkXy1jmHVVXGNxpqYGbFEaNE1Mtsl0yXAA
        D0tD1wcCvlUUch/fFAlypSkiLvlTSbA5UH7LB8V9qjiJEC5u27oANwWhFPeVsWipqgHfFR
        LdwgubNdseqstYztPhSpO8CliO12rbM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64--7ozrcqyP1OjfwbyxfKV7A-1; Thu, 04 Feb 2021 05:55:12 -0500
X-MC-Unique: -7ozrcqyP1OjfwbyxfKV7A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0790874981;
        Thu,  4 Feb 2021 10:55:11 +0000 (UTC)
Received: from krava (unknown [10.40.192.245])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9446A1FBC5;
        Thu,  4 Feb 2021 10:55:07 +0000 (UTC)
Date:   Thu, 4 Feb 2021 11:55:06 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, Jiri Olsa <jolsa@kernel.org>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        bpf <bpf@vger.kernel.org>
Subject: Re: finding libelf
Message-ID: <YBvSiu59XnZQ1em0@krava>
References: <8a6894e9-71ef-09e3-64fa-bf6794fc6660@infradead.org>
 <87eehxa06v.fsf@toke.dk>
 <a6a8fbd6-c610-873e-12e1-b6b0fadb94be@infradead.org>
 <CAEf4Bzb7-jpQLStjtrWm+CvDkLGHR_LiVdb6YcagR2v-Yt42tw@mail.gmail.com>
 <CAEf4BzbvQPmaDauPeH5FiqgjVjf-TA+kKL6gsN505q02Un6QZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbvQPmaDauPeH5FiqgjVjf-TA+kKL6gsN505q02Un6QZA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 03, 2021 at 12:06:10PM -0800, Andrii Nakryiko wrote:

SNIP

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

I have plans to rework this and get rid of the make code
which is the worst part of that for me.. I'll speed it up ;-)

jirka

