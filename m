Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEEF312841F
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2019 22:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfLTVxd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Dec 2019 16:53:33 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:53245 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbfLTVxc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Dec 2019 16:53:32 -0500
Received: by mail-pj1-f67.google.com with SMTP id w23so4684757pjd.2;
        Fri, 20 Dec 2019 13:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=34n9dhKF2BKeM8ejCw1ltZGnOmOAja8Xu9rgOz3lRzQ=;
        b=m3pxAg9oLLP7uJZGCaLQRp5sKISrC4DFipGhfubjmi+vJW9Xzuwl47IwvxGEg5Fzof
         atE4v4tfyTOgn2pNktXmURqiyKZMkI4Q7pF5PkCi1vDEBVz8LvQwPzhDmA0i3EYovlpo
         Q4Oja6z1e27KOO2QSnB0PjjK9OjawQPhZn6oPJ2GJ5G0Lbl0SeoRLVIsM262FUtDvGGs
         4dFlwJ2f9UUMvy3SJSz9loVJ/U3y2t9FalitiJhcmjktH9rm1UtycoBkAFWjXO+dlSjP
         6cSgt1owzPcMtZPmeDhf49tqljaBq/dVAWipml0p+rWLZzGJXYxCTe4/aM2iIlXKHqbt
         0pTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=34n9dhKF2BKeM8ejCw1ltZGnOmOAja8Xu9rgOz3lRzQ=;
        b=VoVNBlqFEqGPVNzgwR9prMhruIo7pffrW/MgWDX4SjNnrwnwl0q7K1gWZ7eiWCJ4qY
         WIC7SUCYRf9xivLvOtioDPiBexYYR3yUrCE+PLwj9wRmXk1cTf4l04RSNi5ipDnD53Ks
         KthVBIGfah+TrPf+dFxDIF0gWvGn+cVtSaon2lCKPi5+3i++yQaWtsBLWDsOu7FlcrYl
         QE1YQ77gW9QavgHz5knQMwyFP7GKKTqGfX+pI9tFdtfx744vbzkZC0T6YXdIfY96lID1
         ZUtoSajVC/d2MqUtpxZ8aotBKfYKuTTbmhmWoINhGnsiqFmq/X8g1M8gEJ+HfyEEPZZc
         RVDg==
X-Gm-Message-State: APjAAAU1+/f8NOH1MI59bvSgkBgQo/4KUSUWDQZ2yynC6MNSs1N2IBOP
        65q21eNo/E7u7ePx+of0n0cYVvDp
X-Google-Smtp-Source: APXvYqz+vxbaCZBvNvOKxzLxBLi6w2zYkotL2DIYIuIbaAOQDXjpw/Iuzmb1DcOHRk+NoeWJAeggOA==
X-Received: by 2002:a17:90b:309:: with SMTP id ay9mr9304060pjb.22.1576878812009;
        Fri, 20 Dec 2019 13:53:32 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id 199sm14941485pfv.81.2019.12.20.13.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 13:53:31 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B6AD940CB9; Fri, 20 Dec 2019 18:53:28 -0300 (-03)
Date:   Fri, 20 Dec 2019 18:53:28 -0300
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libbpf: Fix build on read-only filesystems
Message-ID: <20191220215328.GB9076@kernel.org>
References: <20191220032558.3259098-1-namhyung@kernel.org>
 <CAEf4BzaZBSRK2M4LD-c12_2-QLa8+jpPs1E4nA9BNeUDskOMBQ@mail.gmail.com>
 <20191220204748.GA9076@kernel.org>
 <CAEf4BzZW+bDxkdmXBJrrCHqBP5UT1NLJJ7mXLNqc6eypRCib6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZW+bDxkdmXBJrrCHqBP5UT1NLJJ7mXLNqc6eypRCib6Q@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Dec 20, 2019 at 01:45:52PM -0800, Andrii Nakryiko escreveu:
> On Fri, Dec 20, 2019 at 12:47 PM Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > Em Fri, Dec 20, 2019 at 12:29:36PM -0800, Andrii Nakryiko escreveu:
> > > On Thu, Dec 19, 2019 at 7:26 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > I got the following error when I tried to build perf on a read-only
> > > > filesystem with O=dir option.

> > > >   $ cd /some/where/ro/linux/tools/perf
> > > >   $ make O=$HOME/build/perf
> > > >   ...
> > > >     CC       /home/namhyung/build/perf/lib.o
> > > >   /bin/sh: bpf_helper_defs.h: Read-only file system
> > > >   make[3]: *** [Makefile:184: bpf_helper_defs.h] Error 1
> > > >   make[2]: *** [Makefile.perf:778: /home/namhyung/build/perf/libbpf.a] Error 2
> > > >   make[2]: *** Waiting for unfinished jobs....
> > > >     LD       /home/namhyung/build/perf/libperf-in.o
> > > >     AR       /home/namhyung/build/perf/libperf.a
> > > >     PERF_VERSION = 5.4.0
> > > >   make[1]: *** [Makefile.perf:225: sub-make] Error 2
> > > >   make: *** [Makefile:70: all] Error 2

> > > > It was becaused bpf_helper_defs.h was generated in current directory.
> > > > Move it to OUTPUT directory.

> > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > ---

> > > Overall nothing is obviously broken, except you need to fix up
> > > selftests/bpf's Makefile as well.

> > > BTW, this patch doesn't apply cleanly to latest bpf-next, so please rebase.

> > > Also subject prefix should look like [PATCH bpf-next] if it's meant to
> > > be applied against bpf-next.

> > Shouldn't this be applied to the current merge window since a behaviour
> > that people relied, i.e. using O= to generate the build in a separate
> > directory, since its not possible to use the source dir tree as it is
> > read-only is now broken, i.e. isn't this a regression?
 
> Sure, it can be applied against bpf as well, but selftests still need
> to be fixed first.

I guess this can be done on a separate patch? I.e. if the user doesn't
use selftests the only regression it will see is when trying to build
tools/perf using O=.

I think two patches is best, better granularity, do you see a strict
need for both to be in the same patch?

- Arnaldo
