Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D7A5821F2
	for <lists+bpf@lfdr.de>; Wed, 27 Jul 2022 10:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiG0IUa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Jul 2022 04:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiG0IU3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Jul 2022 04:20:29 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE5EDFF6
        for <bpf@vger.kernel.org>; Wed, 27 Jul 2022 01:20:28 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id h16so8528070ila.2
        for <bpf@vger.kernel.org>; Wed, 27 Jul 2022 01:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ubWnxBZMtleRzsIovroO38JBZF9A1N9XxiKcgjIWA7o=;
        b=XH8bhrjVe9LOO68lO0UxmucHvw5eX9EhiGFSOiUMj1vheR4qi0tVAldtoqQoZm3PSY
         3MeQHIyKSHAUwlpT95pmVQuC4A+avofBkSvVLzJE759d/carXvQ1rQEwpT1EFAUx54UV
         RysPLORIElrCTcdN0aSzHlV+rJXf65gKM0h/VyVhb26g1YaJfOqLhDuXzPTkF1buvjPZ
         1WP6qxpC4YUbd0gM/TWVUdjtB2qhGhRkIEoBqoJGto54lFpW7kFflHEti5ejKtErWmcp
         NXteJjN0iFWpl4KhVXalJ6RfijMt+5a7pKqYdCZrRur670J4aBMpTS9viRJc5YTT9j62
         judw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ubWnxBZMtleRzsIovroO38JBZF9A1N9XxiKcgjIWA7o=;
        b=fmYkygB2XzwaWWebL092T1tzf2+iUE5yZfhGwQWzgenoe92B7huedhUfJCMGQrlt3R
         E4aN0Z+lTps+Wej49+KLkex5g2iGELfuQzVUSy+//FfFxdEjK1HxQMdoIMmi/OnjoBF7
         /QNBQ9DHVpd0+EreDhJWkGxocOZYyA7CO6v37x6pjpaz6ka66SwpHJI9TUxxZGKxONUz
         5gh1VieyUJTjdf6GdPYq1IRwiP5JAXegEtymMN9LTEcvGLBg1iF5zeoyay1Sba3kMHF3
         8M8pig+qVxjqrqgt4IKQ+Frtu+J98hODKUFrfbwd4eTVCuimzLso4CYqldpSpt4AxV4i
         bg3g==
X-Gm-Message-State: AJIora/5Y68UcTNZxpv6eYMDjxEzoIeL5OJjs7nmCcbNN9bCv/mDrALW
        qVIJXqq0/bayOWsm1OOqVIvWegRjyemfC4ha5JMZ7YVMfBc=
X-Google-Smtp-Source: AGRyM1uPIgpspZbZqABqc9daGB8YKDKoqMTZpnMauq3kNKel34egb67zr9QPo42Lp0qnVCcw0G4mJ5ECZjKVJJsWyfM=
X-Received: by 2002:a05:6e02:2183:b0:2dd:aa9:1f9d with SMTP id
 j3-20020a056e02218300b002dd0aa91f9dmr8335510ila.216.1658910028317; Wed, 27
 Jul 2022 01:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220726051713.840431-1-kuifeng@fb.com> <20220726051713.840431-2-kuifeng@fb.com>
 <Yt/aXYiVmGKP282Q@krava> <9e6967ec22f410edf7da3dc6e5d7c867431e3a30.camel@fb.com>
In-Reply-To: <9e6967ec22f410edf7da3dc6e5d7c867431e3a30.camel@fb.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Wed, 27 Jul 2022 10:19:52 +0200
Message-ID: <CAP01T75twVT2ea5Q74viJO+Y9kALbPFw4Yr6hbBfTdok0vAXaw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: Parameterize task iterators.
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     "olsajiri@gmail.com" <olsajiri@gmail.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 27 Jul 2022 at 09:01, Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> On Tue, 2022-07-26 at 14:13 +0200, Jiri Olsa wrote:
> > On Mon, Jul 25, 2022 at 10:17:11PM -0700, Kui-Feng Lee wrote:
> > > Allow creating an iterator that loops through resources of one
> > > task/thread.
> > >
> > > People could only create iterators to loop through all resources of
> > > files, vma, and tasks in the system, even though they were
> > > interested
> > > in only the resources of a specific task or process.  Passing the
> > > additional parameters, people can now create an iterator to go
> > > through all resources or only the resources of a task.
> > >
> > > Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> > > ---
> > >  include/linux/bpf.h            |  4 ++
> > >  include/uapi/linux/bpf.h       | 23 ++++++++++
> > >  kernel/bpf/task_iter.c         | 81 +++++++++++++++++++++++++-----
> > > ----
> > >  tools/include/uapi/linux/bpf.h | 23 ++++++++++
> > >  4 files changed, 109 insertions(+), 22 deletions(-)
> > >
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index 11950029284f..c8d164404e20 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -1718,6 +1718,10 @@ int bpf_obj_get_user(const char __user
> > > *pathname, int flags);
> > >
> > >  struct bpf_iter_aux_info {
> > >         struct bpf_map *map;
> > > +       struct {
> > > +               __u32   tid;
> >
> > should be just u32 ?
>
> Or, should change the following 'type' to __u8?

Would it be better to use a pidfd instead of a tid here? Unset pidfd
would mean going over all tasks, and any fd > 0 implies attaching to a
specific task (as is the convention in BPF land). Most of the new
UAPIs working on processes are using pidfds (to work with a stable
handle instead of a reusable ID).
The iterator taking an fd also gives an opportunity to BPF LSMs to
attach permissions/policies to it (once we have a file local storage
map) e.g. whether creating a task iterator for that specific pidfd
instance (backed by the struct file) would be allowed or not.
You are using getpid in the selftest and keeping track of last_tgid in
the iterator, so I guess you don't even need to extend pidfd_open to
work on thread IDs right now for your use case (and fdtable and mm are
shared for POSIX threads anyway, so for those two it won't make a
difference).

What is your opinion?

>
> [...]
