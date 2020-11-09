Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182172AC425
	for <lists+bpf@lfdr.de>; Mon,  9 Nov 2020 19:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbgKISto (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Nov 2020 13:49:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25916 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729451AbgKISto (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 9 Nov 2020 13:49:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604947782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lZFlOeNxmwrUeGPa7WxgNjIYpmlrRyXw9qyVKnLpKpc=;
        b=Wa2xmZSZM1S/OnMsGSalOLJhnS78F4+VXoioJtopJ6NewZMUzFB9Wq0tafQbppkhcko/rw
        WLwZwCkF3FYxaK40Otgy8QFvsW6uhsbIbLNUe0OPrqEzQ/I7PVHcMebnQ/KOY2J8YcWpS8
        bKUJkwDCcXw2cUVULFm4/WD7IH/rWR4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-5cQ9s9_4O3ynlpgq2sd7uQ-1; Mon, 09 Nov 2020 13:49:38 -0500
X-MC-Unique: 5cQ9s9_4O3ynlpgq2sd7uQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17E0C1074653;
        Mon,  9 Nov 2020 18:49:37 +0000 (UTC)
Received: from krava (unknown [10.40.192.57])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3548019D7C;
        Mon,  9 Nov 2020 18:49:31 +0000 (UTC)
Date:   Mon, 9 Nov 2020 19:49:30 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>,
        Song Liu <songliubraving@fb.com>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Hao Luo <haoluo@google.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Subject: Re: [PATCH 1/3] bpf: Move iterator functions into special init
 section
Message-ID: <20201109184930.GA362089@krava>
References: <20201106222512.52454-1-jolsa@kernel.org>
 <20201106222512.52454-2-jolsa@kernel.org>
 <20201109180500.GC340169@kernel.org>
 <20201109180655.GD340169@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109180655.GD340169@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 09, 2020 at 03:06:55PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Nov 09, 2020 at 03:05:00PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Fri, Nov 06, 2020 at 11:25:10PM +0100, Jiri Olsa escreveu:
> > > With upcoming changes to pahole, that change the way how and
> > > which kernel functions are stored in BTF data, we need a way
> > > to recognize iterator functions.
> > > 
> > > Iterator functions need to be in BTF data, but have no real
> > > body and are currently placed in .init.text section, so they
> > > are freed after kernel init and are filtered out of BTF data
> > > because of that.
> > > 
> > > The solution is to place these functions under new section:
> > >   .init.bpf.preserve_type
> > > 
> > > And add 2 new symbols to mark that area:
> > >   __init_bpf_preserve_type_begin
> > >   __init_bpf_preserve_type_end
> > > 
> > > The code in pahole responsible for picking up the functions will
> > > be able to recognize functions from this section and add them to
> > > the BTF data and filter out all other .init.text functions.
> > 
> > This isn't applying on torvalds/master:
> > 
> > [acme@five linux]$ patch -p1 < /wb/1.patch
> > patching file include/asm-generic/vmlinux.lds.h
> > Hunk #2 succeeded at 754 (offset 1 line).
> > patching file include/linux/bpf.h
> > Hunk #1 succeeded at 1276 (offset -1 lines).
> > patching file include/linux/init.h
> > Hunk #1 FAILED at 52.
> > 1 out of 1 hunk FAILED -- saving rejects to file include/linux/init.h.rej
> > [acme@five linux]$
> > [acme@five linux]$ cat include/linux/init.h.rej
> > --- include/linux/init.h
> > +++ include/linux/init.h
> > @@ -52,6 +52,7 @@
> >  #define __initconst	__section(.init.rodata)
> >  #define __exitdata	__section(.exit.data)
> >  #define __exit_call	__used __section(.exitcall.exit)
> > +#define __init_bpf_preserve_type __section(.init.bpf.preserve_type)
> > 
> >  /*
> >   * modpost check for section mismatches during the kernel build.
> > [acme@five linux]$
> > 
> > 
> > I'm fixing it up by hand to try together with pahole's patches.
> 
> Due to:
> 
> 33def8498fdde180 ("treewide: Convert macro and uses of __section(foo) to __section("foo")")

ok, I'll send new version for the kernel patch

thanks,
jirka

