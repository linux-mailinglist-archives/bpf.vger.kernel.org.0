Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E56111EBFD
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2019 21:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725799AbfLMUmv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Dec 2019 15:42:51 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:38481 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfLMUmv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Dec 2019 15:42:51 -0500
Received: by mail-qv1-f66.google.com with SMTP id t5so289182qvs.5
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2019 12:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7z22bzahDJkMUE2cbYPpTcy17b1MlIJ+lYOwi7uBrio=;
        b=EcLHmbkf1dwEx2Zlr6in0EvDU2AYojloop7icXbhWxh9I1Kf5nJP63tmY4tW8/Rks/
         6vybhOkLIWBD3si8Pm0Gqm1QuguaqkhDGeY3T3yGHk0IZiik66YlzjuFChTg8PfcFTTj
         gX5EpXyPzSfMNIBUSov4oCx1mHj3bdGr9oxiXlXyS+FlOfXyV46Ftcgoe/HXyUGz0snt
         Pv1ZBLAMvY3Xzj3xt+ezVsJ2pMVmu+MrQim2t8KYjA3VT9FbffS0IBBF3kPyQOz/keoZ
         0nqJTs/BdWEhSzFhTSlPAmstKaN05+OH+VPYNRk74BTgnP9ppwdhcUJLSplC/y12kR2W
         6N4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7z22bzahDJkMUE2cbYPpTcy17b1MlIJ+lYOwi7uBrio=;
        b=mZ31gTO/ig/GQppkHhu6s8jFefQytl+qwYqBOedV0lEAT1mybDWglLRW5Ub5or0RJ3
         6yKoMDgc/KwaFwun4FGmLHOiLL3sz9uT5JIjUYYye/mjjzLtoBRl7KRKOS1kWa0bAh/4
         ONgUB5VKQS3Ul8yJ8xndBK7Clkdj388WfkdnT9RSVQkiqv3aPR+U3EvulHNNvvwT648H
         AhIQAnUEWJsLz2YW1pGiVRaqLtadTuLbY6D+ZmRAyP9mX7UCZYBvwSa4nHAVL5tdvC5j
         XYY37x2sMo0FvyX19VqZgQyvgxcoy4DHoUutrEM1gRKBHkXZYxEIDhmm4TrxfdixAMt1
         56tg==
X-Gm-Message-State: APjAAAUva6Ba/VKvlX8IANvLOyghAlsRKqN6vyuFPDcBDxMFKbxpuqEO
        /6u5u9nLq4X63fK1FgCObINl2VuLyuB8vPp5urYTfeiyfSg=
X-Google-Smtp-Source: APXvYqw7dfuFgFzcgSVaJUfsofmaGY65XCUsqpiqhKEYTrsoY9y4JS5IW5xLQ+2P+9W4z21Ckp5kD/Vt61E4g9v4mX4=
X-Received: by 2002:a05:6214:8cb:: with SMTP id da11mr13718798qvb.228.1576269769534;
 Fri, 13 Dec 2019 12:42:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1576193131.git.rdna@fb.com> <364944f93a1d77eab769eeba79bb74122a688338.1576193131.git.rdna@fb.com>
 <CAEf4BzavGP6Aug4Jeg_MsxtgKyVDMGH6omoyMK=BvaAeW1QP3Q@mail.gmail.com> <20191213175810.GA85689@rdna-mbp>
In-Reply-To: <20191213175810.GA85689@rdna-mbp>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 13 Dec 2019 12:42:38 -0800
Message-ID: <CAEf4BzZpmp_TjqQ+SmkwZjDbgG3NvxNX0-AOu1+iTEOhFYt+2g@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 5/6] libbpf: Introduce bpf_prog_attach_xattr
To:     Andrey Ignatov <rdna@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 13, 2019 at 9:58 AM Andrey Ignatov <rdna@fb.com> wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> [Thu, 2019-12-12 22:58 -0800]:
> > On Thu, Dec 12, 2019 at 3:34 PM Andrey Ignatov <rdna@fb.com> wrote:
> > >
> > > Introduce a new bpf_prog_attach_xattr function that accepts an
> > > extendable struct bpf_prog_attach_opts and supports passing a new
> > > attribute to BPF_PROG_ATTACH command: replace_prog_fd that is fd of
> > > previously attached cgroup-bpf program to replace if recently introduced
> > > BPF_F_REPLACE flag is used.
> > >
> > > The new function is named to be consistent with other xattr-functions
> > > (bpf_prog_test_run_xattr, bpf_create_map_xattr, bpf_load_program_xattr).
> > >
> > > The struct bpf_prog_attach_opts is supposed to be used with
> > > DECLARE_LIBBPF_OPTS framework.
> > >
> > > The opts argument is used directly in bpf_prog_attach_xattr
> > > implementation since at the time of adding all fields already exist in
> > > the kernel. New fields, if added, will need to be used via OPTS_* macros
> > > from libbpf_internal.h.
> > >
> > > Signed-off-by: Andrey Ignatov <rdna@fb.com>
> > > ---
> > >  tools/lib/bpf/bpf.c      | 21 +++++++++++++++++----
> > >  tools/lib/bpf/bpf.h      | 12 ++++++++++++
> > >  tools/lib/bpf/libbpf.map |  2 ++
> > >  3 files changed, 31 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> > > index 98596e15390f..9f4e42abd185 100644
> > > --- a/tools/lib/bpf/bpf.c
> > > +++ b/tools/lib/bpf/bpf.c
> > > @@ -466,14 +466,27 @@ int bpf_obj_get(const char *pathname)
> > >
> > >  int bpf_prog_attach(int prog_fd, int target_fd, enum bpf_attach_type type,
> > >                     unsigned int flags)
> > > +{
> > > +       DECLARE_LIBBPF_OPTS(bpf_prog_attach_opts, opts,
> > > +               .target_fd = target_fd,
> > > +               .prog_fd = prog_fd,
> > > +               .type = type,
> > > +               .flags = flags,
> > > +       );
> > > +
> > > +       return bpf_prog_attach_xattr(&opts);
> > > +}
> > > +
> > > +int bpf_prog_attach_xattr(const struct bpf_prog_attach_opts *opts)
> >
> > When we discussed this whole OPTS idea, we agreed that specifying
> > mandatory arguments as is makes for better usability. All the optional
> > stuff then is moved into opts (and then extended indefinitely, because
> > all the newly added stuff has to be optional, at least for some subset
> > of arguments).
> >
> > So if we were to follow those unofficial "guidelines",
> > bpf_prog_attach_xattr would be defined as:
> >
> > int bpf_prog_attach_xattr(int prog_fd, int target_fd, enum bpf_attach_type type,
> >                           const struct bpf_prog_attach_opts *opts);
> >
> > , where opts has flags and replace_bpf_fd right now.
>
> Oh, I see, I think I missed the "mandatory vs optional" part of your
> comment and took only the "switching to options" as the main idea, but
> now I see it. Sorry.
>
> Though thinking more about it, I'm not sure it'd buy us much in this
> specific case. "Required" arguments are set in stone and can't be
> changed, but the API already has a version of function with this same
> list of required arguments:
>
> LIBBPF_API int bpf_prog_attach(int prog_fd, int attachable_fd,
>                                enum bpf_attach_type type, unsigned int flags);
>
> As a user, I'd rather use bpf_prog_attach() if I don't need optional
> arguments (what, also, has shorted name).
>
> Adding another very similar one with same list of arguments + optional
> ones would make it so that it'd never be used in the case when no
> optional arguments are needed.

Yeah, no problem with that, it's not changing or going anywhere, so I
don't see why not. It's not like we have to force all the users to
switch to _opts() variants, if old ones work just fine.

>
> Yeah, I saw you comment on the flags, but flags are needed quite often
> (not BPF_F_REPLACE, but BPF_F_ALLOW_OVERRIDE and BPF_F_ALLOW_MULTI),
> so I'm not sure about moving flags to optional.

if it's used often in practice, I'd leave it as explicit argument then.


>
> The last point brings another point that such a separation, "required" /
> "optional", may be quite biased according to use-cases users mostly deal
> with and may start making less sense over time when more arguments are
> added to optional that are "highly recommended to use".
>
> On the other hand if we just do one single struct argument, there won't
> be this problem how to separate required and optional wht both the
> current set of arguments and whatever is added in the future.

Well, it's not a black and white thing. Take bpf_prog_load_xattr() as
an example. The fact that I'm specifying file path as part of xattr is
super confusing to me, so I'd rather have it as file path + options
instead. The benefit of listing those mandatory arguments explicitly
is that it's very clear which parts user cannot forget to specify.
Surely, some of the added "optional" ones might be mandatory under
some conditions (e.g., when some specific flags are specified), but
that's a bit different (they are conditionally mandatory ;) ). So
having explicit args before options serves double purpose of extra
documentation and making common use cases more succinct.

>
>
> > Naming wise, it's quite departure from xattr approach, so I'd probably
> > would go with bpf_prog_attach_opts, but I won't insist.
>
> Yeah, agree that it's not quite "xattr". I don't have strong preferences
> here, just used the prefix that is already used in the API. I can't
> rename it to bpf_prog_attach_opts though, because there is a structure
> with the same name :) but if there is a better name, happy to rename it.


You sure that's a problem? struct names are in separate namespace from
typedefs and functions, so it will work. But sticking to xattr for
low-level stuff is fine by me as well.

> I had an option bpf_prog_attach2 (similar to existing bpf_prog_detach2)
> but IMO it's worse.
>
>
> > WDYT?
> >
> > >  {
> > >         union bpf_attr attr;
> > >
> > >         memset(&attr, 0, sizeof(attr));
> > > -       attr.target_fd     = target_fd;
> > > -       attr.attach_bpf_fd = prog_fd;
> > > -       attr.attach_type   = type;
> > > -       attr.attach_flags  = flags;
> > > +       attr.target_fd     = opts->target_fd;
> > > +       attr.attach_bpf_fd = opts->prog_fd;
> > > +       attr.attach_type   = opts->type;
> > > +       attr.attach_flags  = opts->flags;
> > > +       attr.replace_bpf_fd = opts->replace_prog_fd;
> > >
> > >         return sys_bpf(BPF_PROG_ATTACH, &attr, sizeof(attr));
> > >  }
> > > diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> > > index 5cfe6e0a1aef..5b5f9b374074 100644
> > > --- a/tools/lib/bpf/bpf.h
> > > +++ b/tools/lib/bpf/bpf.h
> > > @@ -150,8 +150,20 @@ LIBBPF_API int bpf_map_get_next_key(int fd, const void *key, void *next_key);
> > >  LIBBPF_API int bpf_map_freeze(int fd);
> > >  LIBBPF_API int bpf_obj_pin(int fd, const char *pathname);
> > >  LIBBPF_API int bpf_obj_get(const char *pathname);
> > > +
> > > +struct bpf_prog_attach_opts {
> > > +       size_t sz; /* size of this struct for forward/backward compatibility */
> > > +       int target_fd;
> > > +       int prog_fd;
> > > +       enum bpf_attach_type type;
> > > +       unsigned int flags;
> > > +       int replace_prog_fd;
> > > +};
> > > +#define bpf_prog_attach_opts__last_field replace_prog_fd
> > > +
> > >  LIBBPF_API int bpf_prog_attach(int prog_fd, int attachable_fd,
> > >                                enum bpf_attach_type type, unsigned int flags);
> > > +LIBBPF_API int bpf_prog_attach_xattr(const struct bpf_prog_attach_opts *opts);
> > >  LIBBPF_API int bpf_prog_detach(int attachable_fd, enum bpf_attach_type type);
> > >  LIBBPF_API int bpf_prog_detach2(int prog_fd, int attachable_fd,
> > >                                 enum bpf_attach_type type);
> > > diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> > > index 495df575f87f..42b065454031 100644
> > > --- a/tools/lib/bpf/libbpf.map
> > > +++ b/tools/lib/bpf/libbpf.map
> > > @@ -210,4 +210,6 @@ LIBBPF_0.0.6 {
> > >  } LIBBPF_0.0.5;
> > >
> > >  LIBBPF_0.0.7 {
> > > +       global:
> > > +               bpf_prog_attach_xattr;
> > >  } LIBBPF_0.0.6;
> > > --
> > > 2.17.1
> > >
>
> --
> Andrey Ignatov
