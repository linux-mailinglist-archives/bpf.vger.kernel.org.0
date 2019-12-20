Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C83B612835C
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2019 21:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfLTUrx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Dec 2019 15:47:53 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36071 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfLTUrx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Dec 2019 15:47:53 -0500
Received: by mail-pl1-f196.google.com with SMTP id a6so3864291plm.3;
        Fri, 20 Dec 2019 12:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f40bQDy6bbmWGpJ8gtvPrGZ9k+HSSNNsGWV0KlBXr2I=;
        b=qNlfru8aAC0YrW0PRWN8jHhdu+gd8QS6FRn4zvgHAeHJUwv9LoteHyPBKG0GSRviXT
         W/2ShNQZW8LbkoyulPdei6LBZfKwrMGFMqu128TdvbRz7fpSnNWfqTKcYBRnnix/yOxx
         0Fu2lm6drRBEC+dlGEEDqT5sQwG3uQj+3Hbjh7Hic+x+V7cGJf8lOjKx28lmC3L6QiVj
         Gs9fTd9zHj63pzMfRJJ+nz13E7VXg413UBcSL8oi4NPXX18dpBGytEnftyz9L8xzl9jk
         Aa3wQ+afCi6rMotTaIvWHwZWAcu5W48lq5+VZFgUUmfsDM9ISZSWO1K0sMRoUiGBqVXX
         9VHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f40bQDy6bbmWGpJ8gtvPrGZ9k+HSSNNsGWV0KlBXr2I=;
        b=evK6+PDSMjFmj9AfwDi//foTMUhAAc5yr8xbGHZWtjZCTCdJtqXKZkMzz4SABjkdlw
         NtAZxTDpyAVa4vhtIOyS1Y+U5Sb/xoruaEW7vrHuQ9QqVMmKcPVDwMtcIuOD7/gbbPH7
         MDxwZEU2daIWmXYjQT0svLvaexm/FmNlnXk1okZSJB+IOwhgaSE7KzEyAHZ/0WJCFOKT
         gY6+/NSRn5dWrbpjamBrWQ3XrN8Gb4wemP07io3Tn9kjrixVwaV8pzNJjm7nslGf02Gp
         sM2V0uBOGpKFrBvkFYMMha/gUXbHhYHgxD2mEEIthfpc+1iCGYC9ZV+IKY8hXjMdhTXo
         W12g==
X-Gm-Message-State: APjAAAXxDbFI51Qt0+2o3U4eae0JeIwcwZdZoX1TYuR4o3b7MZddMjVW
        WPVSXprGvu+wFnXaVhmwK00=
X-Google-Smtp-Source: APXvYqxUaPGTYayT6LJmFBvJaH4z2jskQX+3XoRvHOOXoOyPFY99CQQa9TUPkUCgJrMhiKCiu/2bjw==
X-Received: by 2002:a17:902:64:: with SMTP id 91mr17424583pla.307.1576874872336;
        Fri, 20 Dec 2019 12:47:52 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id d2sm11461080pjv.18.2019.12.20.12.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 12:47:51 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DCC4840CB9; Fri, 20 Dec 2019 17:47:48 -0300 (-03)
Date:   Fri, 20 Dec 2019 17:47:48 -0300
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libbpf: Fix build on read-only filesystems
Message-ID: <20191220204748.GA9076@kernel.org>
References: <20191220032558.3259098-1-namhyung@kernel.org>
 <CAEf4BzaZBSRK2M4LD-c12_2-QLa8+jpPs1E4nA9BNeUDskOMBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzaZBSRK2M4LD-c12_2-QLa8+jpPs1E4nA9BNeUDskOMBQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Dec 20, 2019 at 12:29:36PM -0800, Andrii Nakryiko escreveu:
> On Thu, Dec 19, 2019 at 7:26 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > I got the following error when I tried to build perf on a read-only
> > filesystem with O=dir option.
> >
> >   $ cd /some/where/ro/linux/tools/perf
> >   $ make O=$HOME/build/perf
> >   ...
> >     CC       /home/namhyung/build/perf/lib.o
> >   /bin/sh: bpf_helper_defs.h: Read-only file system
> >   make[3]: *** [Makefile:184: bpf_helper_defs.h] Error 1
> >   make[2]: *** [Makefile.perf:778: /home/namhyung/build/perf/libbpf.a] Error 2
> >   make[2]: *** Waiting for unfinished jobs....
> >     LD       /home/namhyung/build/perf/libperf-in.o
> >     AR       /home/namhyung/build/perf/libperf.a
> >     PERF_VERSION = 5.4.0
> >   make[1]: *** [Makefile.perf:225: sub-make] Error 2
> >   make: *** [Makefile:70: all] Error 2
> >
> > It was becaused bpf_helper_defs.h was generated in current directory.
> > Move it to OUTPUT directory.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> 
> Overall nothing is obviously broken, except you need to fix up
> selftests/bpf's Makefile as well.
> 
> BTW, this patch doesn't apply cleanly to latest bpf-next, so please rebase.
> 
> Also subject prefix should look like [PATCH bpf-next] if it's meant to
> be applied against bpf-next.

Shouldn't this be applied to the current merge window since a behaviour
that people relied, i.e. using O= to generate the build in a separate
directory, since its not possible to use the source dir tree as it is
read-only is now broken, i.e. isn't this a regression?

- Arnaldo
 
> >  tools/lib/bpf/Makefile | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> 
> [...]

-- 

- Arnaldo
