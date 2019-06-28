Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD4425A161
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2019 18:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfF1QuU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Jun 2019 12:50:20 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42174 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfF1QuU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Jun 2019 12:50:20 -0400
Received: by mail-qk1-f195.google.com with SMTP id b18so5356435qkc.9;
        Fri, 28 Jun 2019 09:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LuusNB3Pp/yz4H/7DfpaAOuD1WwEES1CopjEsJXt9eU=;
        b=CnWThvELXI3RK801wcqeCLA5UldzFZfDjVJC+xVN7V3eBTTi9N9NatAp9PLSj1pThn
         TaZ6Ose3VUsg5K++d2bewAUqZWQTzlf1Ay1JYfbFPvqnY57caIyyxIG3Uo/lSFdJoKA7
         19e4nqrGKRUY2W4Du5DAAJJbnY0AnH+N6h6lkrYsPBA0/sThvr1lHLMoThMVHGSJZUYi
         E2a/S4cOLdM3cO+rOtCa7L5a19xCP5SsDNfGV0J1xr4J4ilpzqLj9r0PKAQB4pdWv2QJ
         zMGfpCq53JoMkKw3yzFNtPeXx8jbhgRnC7BYUSrdRQGHG67uo3z+bckvH0uxu6UWorxZ
         15xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LuusNB3Pp/yz4H/7DfpaAOuD1WwEES1CopjEsJXt9eU=;
        b=HGu1r9O2nROnlfHtC7we4DdTsvRtykWq+FdqGFBwIjyg49CXPbgxbRL4DZJRMK2n9z
         5Sqh/SRaC2Qqphb2XYd8SxptA9lVtVPwoKKBxw+74boofIQ2SWVIeudp1AsUf0wFRRXo
         7PtgFd9GPe5Q5r6FEmRONT2bkgBAh8sx0ke6seIPCQFEm32GzxK/Xdf0bSd9EsaOuaWP
         ojH7xfDR2JqYSd8amv92LxR25eE0RjCZQX2Ksnu80IfWgiq55kXGvC4gzQlt1PZ9H2BK
         0avXULEBv0LlktHBahL3Ct9rIwhSU1+fZxxMsnEOr2PhAu6eL0QClHGoGpBUfqs9u4lw
         zZCg==
X-Gm-Message-State: APjAAAXAwzj8vZBUyYTkX3skbYdnnOWd4uCCBneTItw2pq+eyBDPyfSs
        gYsfqqXmpe/miJ7QYauYq4/X20y6blbtXHbTNc0=
X-Google-Smtp-Source: APXvYqziFoBSWwJ78i8Dh4uBs/EB9absS8si+PGl3dnGUKVfV3j1EjUISjqBGI6tfKtClUYv6uBu0i9JFqP5YL1lFLo=
X-Received: by 2002:a37:a095:: with SMTP id j143mr9939596qke.449.1561740619081;
 Fri, 28 Jun 2019 09:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190628055303.1249758-1-andriin@fb.com> <20190628055303.1249758-4-andriin@fb.com>
 <20190628160436.GH4866@mini-arch>
In-Reply-To: <20190628160436.GH4866@mini-arch>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 28 Jun 2019 09:50:08 -0700
Message-ID: <CAEf4BzYP+QEERsS6wFCBSVtCSTOCtPKzUBrqds5rh691X5zd_w@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 3/9] libbpf: add ability to attach/detach BPF
 program to perf event
To:     Stanislav Fomichev <sdf@fomichev.me>
Cc:     Andrii Nakryiko <andriin@fb.com>, Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 28, 2019 at 9:04 AM Stanislav Fomichev <sdf@fomichev.me> wrote:
>
> On 06/27, Andrii Nakryiko wrote:
> > bpf_program__attach_perf_event allows to attach BPF program to existing
> > perf event hook, providing most generic and most low-level way to attach BPF
> > programs. It returns struct bpf_link, which should be passed to
> > bpf_link__destroy to detach and free resources, associated with a link.
> >
> > Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> > ---
> >  tools/lib/bpf/libbpf.c   | 58 ++++++++++++++++++++++++++++++++++++++++
> >  tools/lib/bpf/libbpf.h   |  3 +++
> >  tools/lib/bpf/libbpf.map |  1 +
> >  3 files changed, 62 insertions(+)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 455795e6f8af..606705f878ba 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -32,6 +32,7 @@
> >  #include <linux/limits.h>
> >  #include <linux/perf_event.h>
> >  #include <linux/ring_buffer.h>
> > +#include <sys/ioctl.h>
> >  #include <sys/stat.h>
> >  #include <sys/types.h>
> >  #include <sys/vfs.h>
> > @@ -3958,6 +3959,63 @@ int bpf_link__destroy(struct bpf_link *link)
> >       return err;
> >  }
> >
> > +struct bpf_link_fd {
> > +     struct bpf_link link; /* has to be at the top of struct */
> [..]
> > +     int fd; /* hook FD */
> > +};
> Any cons to storing everything in bpf_link, instead of creating a
> "subclass"? Less things to worry about.

Yes, it's not always enough to just have single FD to detach BPF
program. Check bpf_prog_detach and bpf_prog_detach2 in
tools/lib/bpf/bpf.c. For some types of attachment you have to provide
target_fd+attach_type, for some target_fd+attach_type+attach_bpf_fd.
So those two will use their own bpf_link extensions.

I haven't implemented those attachment APIs yet, but we should.

What should go into bpf_link itself is any information that's common
to any kind of attachment (e.g, "kind of attachment" itself). It's
conceivable that we might allow "casting" bpf_link into specific
variation and having extra "methods" on those. I haven't done that, as
I didn't have a need yet.

>
> > +static int bpf_link__destroy_perf_event(struct bpf_link *link)
> > +{
> > +     struct bpf_link_fd *l = (void *)link;
> > +     int err;
> > +
> > +     if (l->fd < 0)
> > +             return 0;
> > +
> > +     err = ioctl(l->fd, PERF_EVENT_IOC_DISABLE, 0);
> > +     close(l->fd);
> > +     return err;
> > +}
> > +
> > +struct bpf_link *bpf_program__attach_perf_event(struct bpf_program *prog,
> > +                                             int pfd)
> > +{
> > +     char errmsg[STRERR_BUFSIZE];
> > +     struct bpf_link_fd *link;
> > +     int bpf_fd, err;
> > +
> > +     bpf_fd = bpf_program__fd(prog);
> > +     if (bpf_fd < 0) {
> > +             pr_warning("program '%s': can't attach before loaded\n",
> > +                        bpf_program__title(prog, false));
> > +             return ERR_PTR(-EINVAL);
> > +     }
> > +
> > +     link = malloc(sizeof(*link));
> > +     if (!link)
> > +             return ERR_PTR(-ENOMEM);
> > +     link->link.destroy = &bpf_link__destroy_perf_event;
> > +     link->fd = pfd;
> > +
> > +     if (ioctl(pfd, PERF_EVENT_IOC_SET_BPF, bpf_fd) < 0) {
> > +             err = -errno;
> > +             free(link);
> > +             pr_warning("program '%s': failed to attach to pfd %d: %s\n",
> > +                        bpf_program__title(prog, false), pfd,
> > +                        libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
> > +             return ERR_PTR(err);
> > +     }
> > +     if (ioctl(pfd, PERF_EVENT_IOC_ENABLE, 0) < 0) {
> > +             err = -errno;
> > +             free(link);
> > +             pr_warning("program '%s': failed to enable pfd %d: %s\n",
> > +                        bpf_program__title(prog, false), pfd,
> > +                        libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
> > +             return ERR_PTR(err);
> > +     }
> > +     return (struct bpf_link *)link;
> > +}
> > +
> >  enum bpf_perf_event_ret
> >  bpf_perf_event_read_simple(void *mmap_mem, size_t mmap_size, size_t page_size,
> >                          void **copy_mem, size_t *copy_size,
> > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > index 5082a5ebb0c2..1bf66c4a9330 100644
> > --- a/tools/lib/bpf/libbpf.h
> > +++ b/tools/lib/bpf/libbpf.h
> > @@ -169,6 +169,9 @@ struct bpf_link;
> >
> >  LIBBPF_API int bpf_link__destroy(struct bpf_link *link);
> >
> > +LIBBPF_API struct bpf_link *
> > +bpf_program__attach_perf_event(struct bpf_program *prog, int pfd);
> > +
> >  struct bpf_insn;
> >
> >  /*
> > diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> > index 3cde850fc8da..756f5aa802e9 100644
> > --- a/tools/lib/bpf/libbpf.map
> > +++ b/tools/lib/bpf/libbpf.map
> > @@ -169,6 +169,7 @@ LIBBPF_0.0.4 {
> >       global:
> >               bpf_link__destroy;
> >               bpf_object__load_xattr;
> > +             bpf_program__attach_perf_event;
> >               btf_dump__dump_type;
> >               btf_dump__free;
> >               btf_dump__new;
> > --
> > 2.17.1
> >
