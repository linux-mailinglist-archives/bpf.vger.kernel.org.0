Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1430E44B4E0
	for <lists+bpf@lfdr.de>; Tue,  9 Nov 2021 22:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243927AbhKIVnJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Nov 2021 16:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243830AbhKIVnI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Nov 2021 16:43:08 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B329C061764
        for <bpf@vger.kernel.org>; Tue,  9 Nov 2021 13:40:22 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 200so342507pga.1
        for <bpf@vger.kernel.org>; Tue, 09 Nov 2021 13:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gbgiLrWKf1JpBgMIwxzmUPEyGBPLJDLBx2pQlUE5on8=;
        b=k8FzJThjNJJOfWSDk2KsfU8ISAzVP5EBEE4n5FLUXDf+Ts3D1cyoIehgn561ZMjxmD
         a7Js8Duw/PoS3R9n3ZL3JQ0SGLLNZe3Grso4LyHY8RBeAN71RltBJRrIqbXlUUZzlDhD
         jqn/acx0km68hPQ9DCZUuS3B3jBg7HWX2ePiisWxVfH7TkxQqNLUjI8tWagCGLlljK8r
         7YsA5EcIXgApw9hIk5OWzTG6KeCPU8t5WBFST5cAscjeWWjraGZKI5BYRhEp7KrdGcBO
         XcY8/SIjhBg3GUN8qjzowkjufR6XSk3mihFhO0ZKiRYRJAZ7j1eZNMNyWOl5t1TeswiE
         94RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gbgiLrWKf1JpBgMIwxzmUPEyGBPLJDLBx2pQlUE5on8=;
        b=tmaoWCPdoNz/G7wINj+37RUrP95Ff22dfKheAeu9ErpmsE4bvkcAkn61JIt8e9+foO
         q99HEDbM98G8RJJ7CfLj+9OlqrOXPlJxTKtx0sUeOZj56irlZFdJ02AV45KZ5H1NfthG
         WFDa3xAjkI8dMkbpCP096e94HDOlDkzh6sj7DtheUdYk+N5edknVsLair8pcO3fUs15k
         j4XDrSQSVdt+7OydfOdwBj3qMRaphpDdxyRwOaopIO7YHjH+EwL/hzs7wd66lLZhdYSw
         1AzoFo4utXT6d2Wo3xhMZWNY69VpkTKl1QgB04lzhkfAmDzc5M9aUf7GptnEUHP6g13D
         RIVA==
X-Gm-Message-State: AOAM530MKCBX+uYw50aDR7SJALWOrZMznhoBvY6cu7PBS9uzA5MuEoD1
        f2GNKwJLrxaMINb1QnKEyE2OSLMkm6a3vXLkmlY=
X-Google-Smtp-Source: ABdhPJymOQ1/VRKmqZyjbM/KH7+gVp1fCylyBcJ6Iz8bZWk4Hcjbk7+PnJwvu31c4j+d9tdLw93UJ06Clf7WEHfYMIo=
X-Received: by 2002:a65:4008:: with SMTP id f8mr8421364pgp.310.1636494021471;
 Tue, 09 Nov 2021 13:40:21 -0800 (PST)
MIME-Version: 1.0
References: <20211105234243.390179-1-memxor@gmail.com> <CAADnVQ+6D7_7WQr2OdDRHr9tp9L-4zUvSMWh09j=-t8w-1BzCQ@mail.gmail.com>
 <CAEf4BzYGG04bXBFEv-yk9jmV6amxxzGM-Zr0=0CoJAMRGxg6kA@mail.gmail.com>
 <CAADnVQLAcgdbjOiT33ED3qD7wP-D8gnzLdHA3zxjdEmaKkipkA@mail.gmail.com> <CAEf4BzYJhCjQFLOdmjK5tHFkCxuB2XmqAmnYHPmsNuKz0B7WHA@mail.gmail.com>
In-Reply-To: <CAEf4BzYJhCjQFLOdmjK5tHFkCxuB2XmqAmnYHPmsNuKz0B7WHA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 9 Nov 2021 13:40:10 -0800
Message-ID: <CAADnVQJ6hoNPXyg7bGMqthSUZnZU3O_yQRZSGkKPnvbNPQpLHg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/6] Change bpftool, libbpf, selftests to
 force GNU89 mode
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 8, 2021 at 2:15 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sat, Nov 6, 2021 at 4:20 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Sat, Nov 6, 2021 at 1:02 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Sat, Nov 6, 2021 at 9:34 AM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Fri, Nov 5, 2021 at 6:36 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> > > > >
> > > > > Fix any remaining instances that fail the build in this mode.  For selftests, we
> > > > > also need to separate CXXFLAGS from CFLAGS, since adding it to CFLAGS simply
> > > > > would generate a warning when used with g++.
> > > > >
> > > > > This also cherry-picks Andrii's patch to fix the instance in libbpf. Also tested
> > > > > introducing new invalid usage of C99 features.
> > > > >
> > > > > Andrii Nakryiko (1):
> > > > >   libbpf: fix non-C89 loop variable declaration in gen_loader.c
> > > > >
> > > > > Kumar Kartikeya Dwivedi (5):
> > > > >   bpftool: Compile using -std=gnu89
> > > > >   libbpf: Compile using -std=gnu89
> > > > >   selftests/bpf: Fix non-C89 loop variable declaration instances
> > > > >   selftests/bpf: Switch to non-unicode character in output
> > > > >   selftests/bpf: Compile using -std=gnu89
> > > >
> > > > Please don't.
> > > > I'd rather go the other way and drop gnu89 from everywhere.
> > > > for (int i = 0
> > > > is so much cleaner.
> > >
> > > I agree that for (int i) is better, but it's kernel code style which
> > > we followed so far pretty closely for libbpf and bpftool. So I think
> > > this is the right move for bpftool and libbpf.
> >
> > The kernel coding style is not white and black.
> > Certain style preferences are archaic to say the least.
> > It's not the right move to follow it blindly.
>
> Can we at least add -std=gnu89 for the libbpf? It's a library, so
> being conservative with compiler versions and language features makes
> sense there. I'll add a similar flag to Github's Makefile. I'd rather
> catch this at patch submission time rather than at the Github sync
> time.

Sure. Applied Kumar's patch 3.
With CO-RE in the kernel the pieces of libbpf will be part
of the kernel for real, so for libbpf as a whole would make sense
to conform to the language standards as parts of libbpf have to do.
As far as other parts of kernel git the language standard
can be decided whichever way.
perf and libsubcmd (part of objtool) have no issue using 'for (int'
while being part of the kernel tree.
We can adopt strong gnu89 in bpftool, but I'd rather not rush
such a decision right now.
selftests are certainly not gnu89.
All bpf programs are written in C-2021 "standard".
Lots of C extensions in there.
