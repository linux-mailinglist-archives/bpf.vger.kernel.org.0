Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2BF4128439
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2019 23:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfLTWBA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Dec 2019 17:01:00 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38961 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfLTWBA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Dec 2019 17:01:00 -0500
Received: by mail-qt1-f194.google.com with SMTP id e5so9492188qtm.6;
        Fri, 20 Dec 2019 14:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VvVsQvcLC5AtbCwjS+SvhHuW+/iK9QI8hoMqbN1CNOs=;
        b=IpTCt2BzCnS1CC0jXQVMxwOkE+E5bpaaM6bsrpAkyp19Y57jDyYgkEK62CGjFKA8h9
         eHaMv1jjLAfQ9tG6qm5UrFhxelLDEhDDdXQ18p5FnbM0Un38/9SGwQ3dWYAamiccD7+f
         FTtOZN8RsioXadBjSh59j/n5P/7DnQ8z+wP+DFRcWdNxrd/Z11ZIw8rf5utJxl6Tmj9Z
         zuKnpXk3hpcPyGx3vAlG3OQ3zXydlFSdpI5xDNAqYNkqUgHH77YQ6d4ZQvuAuqu1znks
         9+LHtGSSyI1eB7AMmn+hGVV5HIubc7c5BDbcn7N6hgnsOVg3HO0RQ6gA1o/CDHzKQeh9
         B2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VvVsQvcLC5AtbCwjS+SvhHuW+/iK9QI8hoMqbN1CNOs=;
        b=XmvfA9NMYxG7j1jlw2erbiySRKXk0UzMZiFnejJUnjjWQ7JIhL19CA/7sXl07eBCo4
         VXhqmJNDOd7igI4F0dmZ86yEpZ5w2UB5mc/Gak3d4ZSNC3fMewXx+qHVYQ7c/01+UhL9
         M7BY2BVPsgAy69aozi5HrU59jtYhcTRKy9x6qE5/RXwthjpV2+HL3KFhqW7OyQ4kUwHH
         61AAr9Lo5XarHp4fZmSlp5v3VdK4uSZs8GbuIp3emxxZHaKZtPdrpUtEzV4iLabt0lQf
         ljtSRh7bCOCMjgYZMihJNYKfseyhiaLZ6XDo4gtEedopxUfaRDoOE5zVIROFIhZ4PNoY
         egyw==
X-Gm-Message-State: APjAAAUjqLdGa3pjXGvXKEd6FKKdfZEC0GYvUnle9luQErICpQnEq6r5
        K9cQV+/TuXPreR8q5Aucfw86GRu5xgLjwWQSZY//vsCF
X-Google-Smtp-Source: APXvYqyYXv+Vjt6olFx4LKp8KxekBgv9L9LYqsXGKC9qkA1aF6MiH0cilnKSCVLdU8GgoXRHeVgylekYRpCv/jwGdAs=
X-Received: by 2002:ac8:1385:: with SMTP id h5mr13376040qtj.59.1576879259174;
 Fri, 20 Dec 2019 14:00:59 -0800 (PST)
MIME-Version: 1.0
References: <20191220032558.3259098-1-namhyung@kernel.org> <CAEf4BzaZBSRK2M4LD-c12_2-QLa8+jpPs1E4nA9BNeUDskOMBQ@mail.gmail.com>
 <20191220204748.GA9076@kernel.org> <CAEf4BzZW+bDxkdmXBJrrCHqBP5UT1NLJJ7mXLNqc6eypRCib6Q@mail.gmail.com>
 <20191220215328.GB9076@kernel.org>
In-Reply-To: <20191220215328.GB9076@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 20 Dec 2019 14:00:48 -0800
Message-ID: <CAEf4BzZBnY0neQJQ=opaGTO5yMKWhqBB_YRE4QTTBNYBD-RF9g@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Fix build on read-only filesystems
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 20, 2019 at 1:53 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Fri, Dec 20, 2019 at 01:45:52PM -0800, Andrii Nakryiko escreveu:
> > On Fri, Dec 20, 2019 at 12:47 PM Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > > Em Fri, Dec 20, 2019 at 12:29:36PM -0800, Andrii Nakryiko escreveu:
> > > > On Thu, Dec 19, 2019 at 7:26 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > I got the following error when I tried to build perf on a read-only
> > > > > filesystem with O=dir option.
>
> > > > >   $ cd /some/where/ro/linux/tools/perf
> > > > >   $ make O=$HOME/build/perf
> > > > >   ...
> > > > >     CC       /home/namhyung/build/perf/lib.o
> > > > >   /bin/sh: bpf_helper_defs.h: Read-only file system
> > > > >   make[3]: *** [Makefile:184: bpf_helper_defs.h] Error 1
> > > > >   make[2]: *** [Makefile.perf:778: /home/namhyung/build/perf/libbpf.a] Error 2
> > > > >   make[2]: *** Waiting for unfinished jobs....
> > > > >     LD       /home/namhyung/build/perf/libperf-in.o
> > > > >     AR       /home/namhyung/build/perf/libperf.a
> > > > >     PERF_VERSION = 5.4.0
> > > > >   make[1]: *** [Makefile.perf:225: sub-make] Error 2
> > > > >   make: *** [Makefile:70: all] Error 2
>
> > > > > It was becaused bpf_helper_defs.h was generated in current directory.
> > > > > Move it to OUTPUT directory.
>
> > > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > > ---
>
> > > > Overall nothing is obviously broken, except you need to fix up
> > > > selftests/bpf's Makefile as well.
>
> > > > BTW, this patch doesn't apply cleanly to latest bpf-next, so please rebase.
>
> > > > Also subject prefix should look like [PATCH bpf-next] if it's meant to
> > > > be applied against bpf-next.
>
> > > Shouldn't this be applied to the current merge window since a behaviour
> > > that people relied, i.e. using O= to generate the build in a separate
> > > directory, since its not possible to use the source dir tree as it is
> > > read-only is now broken, i.e. isn't this a regression?
>
> > Sure, it can be applied against bpf as well, but selftests still need
> > to be fixed first.
>
> I guess this can be done on a separate patch? I.e. if the user doesn't
> use selftests the only regression it will see is when trying to build
> tools/perf using O=.
>
> I think two patches is best, better granularity, do you see a strict
> need for both to be in the same patch?

Sure, it can be two separate patches, but they should go in together,
otherwise selftests will be broken.


>
> - Arnaldo
