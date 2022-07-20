Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640A557C0A6
	for <lists+bpf@lfdr.de>; Thu, 21 Jul 2022 01:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiGTXJZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jul 2022 19:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbiGTXJI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jul 2022 19:09:08 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD5274CE5
        for <bpf@vger.kernel.org>; Wed, 20 Jul 2022 16:08:49 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id n10-20020a17090a670a00b001f22ebae50aso174593pjj.3
        for <bpf@vger.kernel.org>; Wed, 20 Jul 2022 16:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XgnSugJEh7C6XXwqZ4wIBmPJHYzKnOKzgRIn7S1cS3w=;
        b=WYxBRjE6s+/27Lhor31jsyuEv3FPzvGoTRFC5TX3MwQ/khyzG/tDJXbHcyOuUK1WTZ
         XnAuYzwzmv5slhxU1dr2Cz101e9L6vdl7BYv7LIKVEHRt9YAsucj+XkFMZH7XIF6X+6M
         58bQmBtsha1nVoveCu9mZRAA6M4WEFB8H1hUrC9jROMepZleckbgaSae3x0wzNbgfO3Z
         V9+LAwlbZGo+6hBtIpxwiTmdl4/9EayNXXp3E+LN6n7gjgtZE8ZHig4pQLCHHzXVM9mB
         E17ve/XWg6YCjHjgyyOOWWi7LkQE54Aus+JzqGBBcZ6JT5jkkxg2REwKWTQutvS5bNTf
         1nHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XgnSugJEh7C6XXwqZ4wIBmPJHYzKnOKzgRIn7S1cS3w=;
        b=I/CHf56wOoSmKdWCT51/JfU1jja2C60Zwc6a3pi0QCQadVcAybesv80VLY28aoCqhO
         WYW2h42EHtT/bxpEJPaIDnbs4z3Pd4ADb+Qjl/THhMNt+7G7TBoR5eN7up9RsBIdV5cg
         VyCUiBTXibmZaiLL+stIbxJBhOdqYNi9peTaLekcV4gk5psWqtJ75hC2KUVI2KXRplqA
         SHLB77/czO0VumvayF91idJ9RJV6K/CpfC27lzrNIsAXtX6Q3u5untL9iieWDjYPwr4x
         W9nDtUVqXz4MY/f061FIgQlYRvTTt5Cnx5i+RM3GyBMQ066Oy1uwW4srlKorD+MvuMT6
         JDDg==
X-Gm-Message-State: AJIora94G6+gPuRPaJu59vPMO8Z7abGxJQCEIfSQBQYN0R4qn67m3M4k
        fD6siRyHq5dFnDGBZpkp8QB+7IL6QSH5fx4k8480cw==
X-Google-Smtp-Source: AGRyM1vYQPiPUtXNwodE0NwosgaCHcoolY10ujtJ2fw3ndyw9Qcy0C33jsjtIzn5YP//R8ohYjc8K31lY2d4FjAlufM=
X-Received: by 2002:a17:903:1111:b0:16a:acf4:e951 with SMTP id
 n17-20020a170903111100b0016aacf4e951mr40849774plh.72.1658358529143; Wed, 20
 Jul 2022 16:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220719194028.4180569-1-jevburton.kernel@gmail.com>
 <CAKH8qBsm0QqE-7Pmhhz=tRYAfgpirbu6K1deQ6cQTU+GTykLNA@mail.gmail.com>
 <179cfb89be0e4f928a55d049fe62aa9e@huawei.com> <CAKH8qBt0yR+mtCjAp=8jQL4M6apWQk0wH7Zf4tPDCf3=m+gAKA@mail.gmail.com>
 <31473ddf364f4f16becfd5cd4b9cd7d2@huawei.com> <CAKH8qBsFg5gQ0bqpVtYhiQx=TqJG31c8kfsbCG4X57QGLOhXvw@mail.gmail.com>
 <0c284e09817e4e699aa448aa25af5d79@huawei.com> <CAKH8qBvwzVPY1yJM_FjdH5QptVkZz=j9Ph7pTPCbTLdY1orKJg@mail.gmail.com>
 <c9c203821a854e33970fd10e01632cb7@huawei.com>
In-Reply-To: <c9c203821a854e33970fd10e01632cb7@huawei.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 20 Jul 2022 16:08:37 -0700
Message-ID: <CAKH8qBuazK5PwDYAG2bPGfyASAMQAd4_dpFjcW0KYz4ON+kj3g@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] libbpf: Add bpf_obj_get_opts()
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     Joe Burton <jevburton.kernel@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joe Burton <jevburton@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 20, 2022 at 4:02 PM Roberto Sassu <roberto.sassu@huawei.com> wrote:
>
> > From: Stanislav Fomichev [mailto:sdf@google.com]
> > Sent: Thursday, July 21, 2022 12:48 AM
> > On Wed, Jul 20, 2022 at 3:44 PM Roberto Sassu <roberto.sassu@huawei.com>
> > wrote:
> > >
> > > > From: Stanislav Fomichev [mailto:sdf@google.com]
> > > > Sent: Thursday, July 21, 2022 12:38 AM
> > > > On Wed, Jul 20, 2022 at 3:30 PM Roberto Sassu
> > <roberto.sassu@huawei.com>
> > > > wrote:
> > > > >
> > > > > > From: Stanislav Fomichev [mailto:sdf@google.com]
> > > > > > Sent: Wednesday, July 20, 2022 5:57 PM
> > > > > > On Wed, Jul 20, 2022 at 1:02 AM Roberto Sassu
> > > > <roberto.sassu@huawei.com>
> > > > > > wrote:
> > > > > > >
> > > > > > > > From: Stanislav Fomichev [mailto:sdf@google.com]
> > > > > > > > Sent: Tuesday, July 19, 2022 10:40 PM
> > > > > > > > On Tue, Jul 19, 2022 at 12:40 PM Joe Burton
> > > > <jevburton.kernel@gmail.com>
> > > > > > > > wrote:
> > > > > > > > >
> > > > > > > > > From: Joe Burton <jevburton@google.com>
> > > > > > > > >
> > > > > > > > > Add an extensible variant of bpf_obj_get() capable of setting the
> > > > > > > > > `file_flags` parameter.
> > > > > > > > >
> > > > > > > > > This parameter is needed to enable unprivileged access to BPF
> > maps.
> > > > > > > > > Without a method like this, users must manually make the syscall.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Joe Burton <jevburton@google.com>
> > > > > > > >
> > > > > > > > Reviewed-by: Stanislav Fomichev <sdf@google.com>
> > > > > > > >
> > > > > > > > For context:
> > > > > > > > We've found this out while we were trying to add support for unpriv
> > > > > > > > processes to open pinned r-x maps.
> > > > > > > > Maybe this deserves a test as well? Not sure.
> > > > > > >
> > > > > > > Hi Stanislav, Joe
> > > > > > >
> > > > > > > I noticed now this patch. I'm doing a broader work to add opts
> > > > > > > to bpf_*_get_fd_by_id(). I also adjusted permissions of bpftool
> > > > > > > depending on the operation type (e.g. show, dump: BPF_F_RDONLY).
> > > > > > >
> > > > > > > Will send it soon (I'm trying to solve an issue with the CI, where
> > > > > > > libbfd is not available in the VM doing actual tests).
> > > > > >
> > > > > > Is something like this patch included in your series as well? Can you
> > > > > > use this new interface or do you need something different?
> > > > >
> > > > > It is very similar. Except that I called it bpf_get_fd_opts, as it
> > > > > is shared with the bpf_*_get_fd_by_id() functions. The member
> > > > > name is just flags, plus an extra u32 for alignment.
> > > >
> > > > We can bikeshed the naming, but we've been using existing conventions
> > > > where opts fields match syscall fields, that seems like a sensible
> > > > thing to do?
> > >
> > > The only problem is that bpf_*_get_fd_by_id() functions would
> > > set the open_flags member of bpf_attr.
> > >
> > > Flags would be good for both, even if not exact. Believe me,
> > > duplicating the opts would just create more confusion.
> >
> > Wait, that's completely different, right? We are talking here about
> > BPF_OBJ_GET (which has related BPF_OBJ_PIN).
> > Your GET_XXX_BY_ID are different so you'll still have to have another
> > wrapper with opts?
>
> Yes, they have different wrappers, just accept the same opts as
> obj_get(). From bpftool subcommands you want to set the correct
> permission, and propagate it uniformly to bpf_*_get_fd_by_id()
> or obj_get(). See map_parse_fds().

I don't think they are accepting the same opts.

For our case, we care about:

        struct { /* anonymous struct used by BPF_OBJ_* commands */
                __aligned_u64   pathname;
                __u32           bpf_fd;
                __u32           file_flags;
        };

For your case, you care about:

        struct { /* anonymous struct used by BPF_*_GET_*_ID */
                union {
                        __u32           start_id;
                        __u32           prog_id;
                        __u32           map_id;
                        __u32           btf_id;
                        __u32           link_id;
                };
                __u32           next_id;
                __u32           open_flags;
        };

So your new _opts libbpf routine should be independent of what Joe is
doing here.

> Roberto
>
> > > > > It needs to be shared, as there are functions in bpftool calling
> > > > > both. Since the meaning of flags is the same, seems ok sharing.
> > > >
> > > > So I guess there are no objections to the current patch? If it gets
> > > > accepted, you should be able to drop some of your code and use this
> > > > new bpf_obj_get_opts..
> > >
> > > If you use a name good also for bpf_*_get_fd_by_id() and flags
> > > as structure member name, that would be ok.
> > >
> > > Roberto
> > >
> > > > > Roberto
> > > > >
> > > > > > > Roberto
> > > > > > >
> > > > > > > > > ---
> > > > > > > > >  tools/lib/bpf/bpf.c      | 10 ++++++++++
> > > > > > > > >  tools/lib/bpf/bpf.h      |  9 +++++++++
> > > > > > > > >  tools/lib/bpf/libbpf.map |  1 +
> > > > > > > > >  3 files changed, 20 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> > > > > > > > > index 5eb0df90eb2b..5acb0e8bd13c 100644
> > > > > > > > > --- a/tools/lib/bpf/bpf.c
> > > > > > > > > +++ b/tools/lib/bpf/bpf.c
> > > > > > > > > @@ -578,12 +578,22 @@ int bpf_obj_pin(int fd, const char
> > > > *pathname)
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > >  int bpf_obj_get(const char *pathname)
> > > > > > > > > +{
> > > > > > > > > +       LIBBPF_OPTS(bpf_obj_get_opts, opts);
> > > > > > > > > +       return bpf_obj_get_opts(pathname, &opts);
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +int bpf_obj_get_opts(const char *pathname, const struct
> > > > > > bpf_obj_get_opts
> > > > > > > > *opts)
> > > > > > > > >  {
> > > > > > > > >         union bpf_attr attr;
> > > > > > > > >         int fd;
> > > > > > > > >
> > > > > > > > > +       if (!OPTS_VALID(opts, bpf_obj_get_opts))
> > > > > > > > > +               return libbpf_err(-EINVAL);
> > > > > > > > > +
> > > > > > > > >         memset(&attr, 0, sizeof(attr));
> > > > > > > > >         attr.pathname = ptr_to_u64((void *)pathname);
> > > > > > > > > +       attr.file_flags = OPTS_GET(opts, file_flags, 0);
> > > > > > > > >
> > > > > > > > >         fd = sys_bpf_fd(BPF_OBJ_GET, &attr, sizeof(attr));
> > > > > > > > >         return libbpf_err_errno(fd);
> > > > > > > > > diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> > > > > > > > > index 88a7cc4bd76f..f31b493b5f9a 100644
> > > > > > > > > --- a/tools/lib/bpf/bpf.h
> > > > > > > > > +++ b/tools/lib/bpf/bpf.h
> > > > > > > > > @@ -270,8 +270,17 @@ LIBBPF_API int bpf_map_update_batch(int
> > fd,
> > > > > > const
> > > > > > > > void *keys, const void *values
> > > > > > > > >                                     __u32 *count,
> > > > > > > > >                                     const struct bpf_map_batch_opts *opts);
> > > > > > > > >
> > > > > > > > > +struct bpf_obj_get_opts {
> > > > > > > > > +       size_t sz; /* size of this struct for forward/backward
> > compatibility
> > > > */
> > > > > > > > > +
> > > > > > > > > +       __u32 file_flags;
> > > > > > > > > +};
> > > > > > > > > +#define bpf_obj_get_opts__last_field file_flags
> > > > > > > > > +
> > > > > > > > >  LIBBPF_API int bpf_obj_pin(int fd, const char *pathname);
> > > > > > > > >  LIBBPF_API int bpf_obj_get(const char *pathname);
> > > > > > > > > +LIBBPF_API int bpf_obj_get_opts(const char *pathname,
> > > > > > > > > +                               const struct bpf_obj_get_opts *opts);
> > > > > > > > >
> > > > > > > > >  struct bpf_prog_attach_opts {
> > > > > > > > >         size_t sz; /* size of this struct for forward/backward
> > compatibility
> > > > */
> > > > > > > > > diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> > > > > > > > > index 0625adb9e888..119e6e1ea7f1 100644
> > > > > > > > > --- a/tools/lib/bpf/libbpf.map
> > > > > > > > > +++ b/tools/lib/bpf/libbpf.map
> > > > > > > > > @@ -355,6 +355,7 @@ LIBBPF_0.8.0 {
> > > > > > > > >
> > > > > > > > >  LIBBPF_1.0.0 {
> > > > > > > > >         global:
> > > > > > > > > +               bpf_obj_get_opts;
> > > > > > > > >                 bpf_prog_query_opts;
> > > > > > > > >                 bpf_program__attach_ksyscall;
> > > > > > > > >                 btf__add_enum64;
> > > > > > > > > --
> > > > > > > > > 2.37.0.170.g444d1eabd0-goog
> > > > > > > > >
