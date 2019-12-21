Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97524128A60
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2019 17:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfLUQWE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 21 Dec 2019 11:22:04 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:55267 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfLUQWD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 21 Dec 2019 11:22:03 -0500
Received: by mail-pj1-f65.google.com with SMTP id kx11so1397234pjb.4;
        Sat, 21 Dec 2019 08:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4R50o9Q/QVb/27CP47foPm4kgwdQXbgPWO/zyAUY+90=;
        b=AjOhXEJDNPMP/wrgRNnptbTYHwGAK6hHnqpZJCxUZUfHOJoRLEOkJAImSBuoqAPxXn
         /576D8uVSTB9a+V4T5xrMZnLRrJuK6+DKt1AY4J6STcwYbm4nmjiF4HTdUy/0Ps2ToB0
         kvBCIvpWxigroo4sVJRABmLOrJYvddqQqoGFDe56LG1GcyPncAS9ux9ZNI85ja1pAsZs
         2tjDGiE/bE4dhelGVdNYBWeCZIX3FR6p/xGnwcYzCS6oCSYZqCVmLjBgGh7txVIsH1+y
         aFga20o+4oevoedsA0x9tIcLPm0kQppU3+0AxyxuqsO7F6cqkSIUGpkS2vhymAQjC6+g
         sMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4R50o9Q/QVb/27CP47foPm4kgwdQXbgPWO/zyAUY+90=;
        b=KHmcP9NKr67odibXw9OoWGEM2VxvmTjiEXi7XJ9VRxhRlyg6SA7EWYA/YrVGpNmh9m
         L9wySHpCSkwYuvFcTltUug7IFeJsvdhpYeE8eJJcEiq5BT4AJ9VAq0EG+1KFhRlkJMyh
         bliVpK3OO9fglYw/P8+VKIdAVszEJnn1k8A5240PuTWu9R0syIg2I+6dlKZbEu+k4D01
         4EFtj4EY6cxBvOiYkwafaygZ/J7t4C4LdKZ96G98qKndMOWz29MnKVxqjkqXGidIsnu8
         i39iCULSvgyPXhscb9kLysF8J2sHTzmEzToZsXGjv5l06Dnz9BE8hIFmAqNofDW9bJTx
         aung==
X-Gm-Message-State: APjAAAWByIUU25h9JEWO1ZPtgMq/5sX7XjFnbF7A7QSApZQfk7ha1gjQ
        xIUFPbcvagMEXbBkhIkZRbc=
X-Google-Smtp-Source: APXvYqw2SMp+9K0gAxuviJ2DVsRsv2yXKZ3IIL5C8oC/k4t7sz+XNein9xActbMxq1yHVMhsMD7NlQ==
X-Received: by 2002:a17:90a:b906:: with SMTP id p6mr22906744pjr.81.1576945322822;
        Sat, 21 Dec 2019 08:22:02 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::a285])
        by smtp.gmail.com with ESMTPSA id a69sm16879243pfa.129.2019.12.21.08.22.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Dec 2019 08:22:02 -0800 (PST)
Date:   Sat, 21 Dec 2019 08:22:00 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libbpf: Fix build on read-only filesystems
Message-ID: <20191221162158.rw6xqqktubozg6fg@ast-mbp.dhcp.thefacebook.com>
References: <20191220032558.3259098-1-namhyung@kernel.org>
 <CAEf4BzaZBSRK2M4LD-c12_2-QLa8+jpPs1E4nA9BNeUDskOMBQ@mail.gmail.com>
 <CAM9d7cg0A0+Oq5uDS6ZJNzAgFsWc-Pd30GYC0+PxEXdcxAxBKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cg0A0+Oq5uDS6ZJNzAgFsWc-Pd30GYC0+PxEXdcxAxBKg@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Dec 21, 2019 at 05:25:51PM +0900, Namhyung Kim wrote:
> Hello,
> 
> On Sat, Dec 21, 2019 at 5:29 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Dec 19, 2019 at 7:26 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > I got the following error when I tried to build perf on a read-only
> > > filesystem with O=dir option.
> > >
> > >   $ cd /some/where/ro/linux/tools/perf
> > >   $ make O=$HOME/build/perf
> > >   ...
> > >     CC       /home/namhyung/build/perf/lib.o
> > >   /bin/sh: bpf_helper_defs.h: Read-only file system
> > >   make[3]: *** [Makefile:184: bpf_helper_defs.h] Error 1
> > >   make[2]: *** [Makefile.perf:778: /home/namhyung/build/perf/libbpf.a] Error 2
> > >   make[2]: *** Waiting for unfinished jobs....
> > >     LD       /home/namhyung/build/perf/libperf-in.o
> > >     AR       /home/namhyung/build/perf/libperf.a
> > >     PERF_VERSION = 5.4.0
> > >   make[1]: *** [Makefile.perf:225: sub-make] Error 2
> > >   make: *** [Makefile:70: all] Error 2
> > >
> > > It was becaused bpf_helper_defs.h was generated in current directory.
> > > Move it to OUTPUT directory.
> > >
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> >
> > Overall nothing is obviously broken, except you need to fix up
> > selftests/bpf's Makefile as well.
> 
> Thanks for pointing this out.  It's because bpf selftest also needs the
> bpf_helper_defs.h right?  But I'm currently having a problem with LLVM
> when building the selftests.  Can you help me testing the patch below?
> (It should be applied after this patch.  Are you ok with it?)
> 
> 
> >
> > BTW, this patch doesn't apply cleanly to latest bpf-next, so please rebase.
> >
> > Also subject prefix should look like [PATCH bpf-next] if it's meant to
> > be applied against bpf-next.
> 
> Will do.
> 
> Thanks
> Namhyung
> 
> -----------8<-------------
> diff --git a/tools/testing/selftests/bpf/Makefile
> b/tools/testing/selftests/bpf/Makefile
> index 866fc1cadd7c..897877f7849b 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -151,9 +151,9 @@ $(DEFAULT_BPFTOOL): force
>  $(BPFOBJ): force
>         $(MAKE) -C $(BPFDIR) OUTPUT=$(OUTPUT)/
> 
> -BPF_HELPERS := $(BPFDIR)/bpf_helper_defs.h $(wildcard $(BPFDIR)/bpf_*.h)
> -$(BPFDIR)/bpf_helper_defs.h:
> -       $(MAKE) -C $(BPFDIR) OUTPUT=$(OUTPUT)/ bpf_helper_defs.h
> +BPF_HELPERS := $(OUTPUT)/bpf_helper_defs.h $(wildcard $(BPFDIR)/bpf_*.h)
> +$(OUTPUT)/bpf_helper_defs.h:
> +       $(MAKE) -C $(BPFDIR) OUTPUT=$(OUTPUT)/ $(OUTPUT)/bpf_helper_defs.h

The fix makes sense, but you cannot break it down into two patches.
The selftests/bpf are absolutely essential for everyone working on bpf.
For both developers and maintainers. You cannot break them in one patch
and then try to fix in another.
Please resubmit as one patch and tag the subject as [PATCH bpf].
