Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45803937C5
	for <lists+bpf@lfdr.de>; Thu, 27 May 2021 23:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbhE0VKT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 May 2021 17:10:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36844 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233387AbhE0VKS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 27 May 2021 17:10:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622149724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RKrYNji3/LjAeH1E7Kgk4A4XbVR0vhaXNDJXT3n+9D4=;
        b=EIrzLMfLabQmg69sOuuVcW0FQ+bW0W4LMYTBan7hqyby9ts2YQ0so/qBUNijTmSu/5WJ62
        MQwHMrml172d2Jau7wh9rfBoODitWMLEHNWvIeJrORbkewBaWdpA0AMyglcFqRJcScpd5r
        4818HPPgKEcbpSuKKZs4/vvRyscTWs8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-U0eyb8fOM0OUmTX3WRqkJg-1; Thu, 27 May 2021 17:08:42 -0400
X-MC-Unique: U0eyb8fOM0OUmTX3WRqkJg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9567800D55;
        Thu, 27 May 2021 21:08:40 +0000 (UTC)
Received: from krava (unknown [10.40.192.4])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4D8FE5D9C6;
        Thu, 27 May 2021 21:08:34 +0000 (UTC)
Date:   Thu, 27 May 2021 23:08:33 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Arnaldo <arnaldo.melo@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [RFT] Testing 1.22
Message-ID: <YLAKUbjrdYio+ncV@krava>
References: <YK+41f972j25Z1QQ@kernel.org>
 <CAEf4BzaTP_jULKMN_hx6ZOqwESOmsR6_HxWW-LnrA5xwRNtSWg@mail.gmail.com>
 <4615C288-2CFD-483E-AB98-B14A33631E2F@gmail.com>
 <CAEf4BzaQmv1+1bPF=1aO3dcmNu2Mx0EFhK+ZU6UFsMjv3v6EZA@mail.gmail.com>
 <4901AF88-0354-428B-9305-2EDC6F75C073@gmail.com>
 <CAEf4BzZk8bcSZ9hmFAmgjbrQt0Yj1usCHmuQTfU-pwZkYQgztA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZk8bcSZ9hmFAmgjbrQt0Yj1usCHmuQTfU-pwZkYQgztA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 27, 2021 at 01:41:13PM -0700, Andrii Nakryiko wrote:
> On Thu, May 27, 2021 at 12:57 PM Arnaldo <arnaldo.melo@gmail.com> wrote:
> >
> >
> >
> > On May 27, 2021 4:14:17 PM GMT-03:00, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > >On Thu, May 27, 2021 at 12:06 PM Arnaldo <arnaldo.melo@gmail.com>
> > >wrote:
> > >>
> > >>
> > >>
> > >> On May 27, 2021 1:54:40 PM GMT-03:00, Andrii Nakryiko
> > ><andrii.nakryiko@gmail.com> wrote:
> > >> >On Thu, May 27, 2021 at 8:20 AM Arnaldo Carvalho de Melo
> > >> ><acme@kernel.org> wrote:
> > >> >>
> > >> >> Hi guys,
> > >> >>
> > >> >>         Its important to have 1.22 out of the door ASAP, so please
> > >> >clone
> > >> >> what is in tmp.master and report your results.
> > >> >>
> > >> >
> > >> >Hey Arnaldo,
> > >> >
> > >> >If we are going to make pahole 1.22 a new mandatory minimal version
> > >of
> > >> >pahole, I think we should take a little bit of time and fix another
> > >> >problematic issue and clean up Kbuild significantly.
> > >> >
> > >> >We discussed this before, it would be great to have an ability to
> > >dump
> > >> >generated BTF into a separate file instead of modifying vmlinux
> > >image
> > >> >in place. I'd say let's try to push for [0] to land as a temporary
> > >> >work around to buy us a bit of time to implement this feature. Then,
> > >> >when pahole 1.22 is released and packaged into major distros, we can
> > >> >follow up in kernel with Kbuild clean ups and making pahole 1.22
> > >> >mandatory.
> > >> >
> > >> >What do you think? If anyone agrees, please consider chiming in on
> > >the
> > >> >above thread ([0]).
> > >>
> > >> There's multiple fixes that affects lots of stakeholders, so I'm more
> > >inclined to release 1.22 sooner rather than later.
> > >>
> > >> If anyone has cycles right now to work on that detached BTF feature,
> > >releasing 1.23 as soon as that feature is complete and tested shouldn't
> > >be a problem.
> > >>
> > >> Then 1.23 the mandatory minimal version.
> > >>
> > >> Wdyt?
> > >
> > >If we make 1.22 mandatory there will be no good reason to make 1.23
> > >mandatory again. So I will have absolutely no inclination to work on
> > >this, for example. So we are just wasting a chance to clean up the
> > >Kbuild story w.r.t. pahole. And we are talking about just a few days
> > >at most, while we do have a reasonable work around on the kernel side.
> >
> > So there were patches for stop using objcopy, which we thought could uncover some can of worms, were there patches for the detached BTF  file?
> 
> No, there weren't, if I remember correctly. What's the concern,
> though? That detached BTF file isn't even an ELF, so it's
> btf__get_raw_data() and write it to the file. Done.

heya,
I probably overlooked this, but are there more details about that
detached BTF file feature somewhere? 

thanks,
jirka

