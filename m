Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4436B57C020
	for <lists+bpf@lfdr.de>; Thu, 21 Jul 2022 00:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiGTWi1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jul 2022 18:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiGTWi0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jul 2022 18:38:26 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB02A20BCA
        for <bpf@vger.kernel.org>; Wed, 20 Jul 2022 15:38:25 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id c6so124028pla.6
        for <bpf@vger.kernel.org>; Wed, 20 Jul 2022 15:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qKundeLwLE8yHDmVC5J90MC57u7WttoWzC9FUcDruuA=;
        b=teu9Ow/yaZVavTFIRBfdZhx5omBHQ/R1a+0wEZEdWXDuh4SFLngIh/dkQhevzdIAw9
         wN9if+zAcfY35HB4jzS9uInlSXQzELXqE41bHh/AjHa+O2v2AGnM48wB9piAxJkHElrG
         i3PaXat4FmqoDkRMrglMzGqg/q5d6h+bXP7t3/Cu47JOa1xUOU5ed/UuCqKIyxx82Otn
         XQ1ZTwBRWsjt0i8WD/HgPDx7o6sLUuetf79m9fFiWmZy6QX7QIKQwVmja7DIfPokUKmA
         M6fqfCHoxU6xD9GNbgdWsvRZBO+NoyQcOcEKyS/T+j+Xxnl5BLnaXE0/myauUi3LlpkF
         KIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qKundeLwLE8yHDmVC5J90MC57u7WttoWzC9FUcDruuA=;
        b=1TAg9ImrgbLllJEx5yStlEJRyIfgasvCNInJlcKyXfdiVbql8fm/7/LqtMhPUet5ln
         3ov/ZAzAvHezQCTm8ZZo5CmjFUDf4UGpaMKaLC9BH3g1d2ZkO8NTErPBllo6I4krAEug
         PPQfDA0hgfYLqjM6QlL58toKTjmUIj6/OIKJNDU7wM/B2vpXynE30vL5WQknsG8lzZb2
         UqSbxZcHEaZ+9t1lF9GouA0mQhlJLlRhYIajsFiLxjMpS04anqUZPsaiDEs/+MiWZqpV
         iEbWhDA/qTdPyaqjhKJ2d0uKpVVezWNS6spr0skA3x/5QfvtojGjrOE2Awa6Tnmj0Pp8
         ISlA==
X-Gm-Message-State: AJIora8NHMiVJE4PsMaS6qTdQAHe+A7MD9XVdXt2reRL7HK+BymjhzkO
        5YZvCBiR+J00SNu1l39xOISHQwVOgCtcFcCiAsHqLQ==
X-Google-Smtp-Source: AGRyM1sT0VjwrAlAy19Hev842jcsdcPceuFOqBKzFLrWQP0Y1syi+ScUaLbMtA1ceUCC9L3oIZ5bRsF73lTpCfLiRao=
X-Received: by 2002:a17:90b:4b4d:b0:1ef:bff5:de4f with SMTP id
 mi13-20020a17090b4b4d00b001efbff5de4fmr7931216pjb.120.1658356704967; Wed, 20
 Jul 2022 15:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220719194028.4180569-1-jevburton.kernel@gmail.com>
 <CAKH8qBsm0QqE-7Pmhhz=tRYAfgpirbu6K1deQ6cQTU+GTykLNA@mail.gmail.com>
 <179cfb89be0e4f928a55d049fe62aa9e@huawei.com> <CAKH8qBt0yR+mtCjAp=8jQL4M6apWQk0wH7Zf4tPDCf3=m+gAKA@mail.gmail.com>
 <31473ddf364f4f16becfd5cd4b9cd7d2@huawei.com>
In-Reply-To: <31473ddf364f4f16becfd5cd4b9cd7d2@huawei.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 20 Jul 2022 15:38:13 -0700
Message-ID: <CAKH8qBsFg5gQ0bqpVtYhiQx=TqJG31c8kfsbCG4X57QGLOhXvw@mail.gmail.com>
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 20, 2022 at 3:30 PM Roberto Sassu <roberto.sassu@huawei.com> wrote:
>
> > From: Stanislav Fomichev [mailto:sdf@google.com]
> > Sent: Wednesday, July 20, 2022 5:57 PM
> > On Wed, Jul 20, 2022 at 1:02 AM Roberto Sassu <roberto.sassu@huawei.com>
> > wrote:
> > >
> > > > From: Stanislav Fomichev [mailto:sdf@google.com]
> > > > Sent: Tuesday, July 19, 2022 10:40 PM
> > > > On Tue, Jul 19, 2022 at 12:40 PM Joe Burton <jevburton.kernel@gmail.com>
> > > > wrote:
> > > > >
> > > > > From: Joe Burton <jevburton@google.com>
> > > > >
> > > > > Add an extensible variant of bpf_obj_get() capable of setting the
> > > > > `file_flags` parameter.
> > > > >
> > > > > This parameter is needed to enable unprivileged access to BPF maps.
> > > > > Without a method like this, users must manually make the syscall.
> > > > >
> > > > > Signed-off-by: Joe Burton <jevburton@google.com>
> > > >
> > > > Reviewed-by: Stanislav Fomichev <sdf@google.com>
> > > >
> > > > For context:
> > > > We've found this out while we were trying to add support for unpriv
> > > > processes to open pinned r-x maps.
> > > > Maybe this deserves a test as well? Not sure.
> > >
> > > Hi Stanislav, Joe
> > >
> > > I noticed now this patch. I'm doing a broader work to add opts
> > > to bpf_*_get_fd_by_id(). I also adjusted permissions of bpftool
> > > depending on the operation type (e.g. show, dump: BPF_F_RDONLY).
> > >
> > > Will send it soon (I'm trying to solve an issue with the CI, where
> > > libbfd is not available in the VM doing actual tests).
> >
> > Is something like this patch included in your series as well? Can you
> > use this new interface or do you need something different?
>
> It is very similar. Except that I called it bpf_get_fd_opts, as it
> is shared with the bpf_*_get_fd_by_id() functions. The member
> name is just flags, plus an extra u32 for alignment.

We can bikeshed the naming, but we've been using existing conventions
where opts fields match syscall fields, that seems like a sensible
thing to do?

> It needs to be shared, as there are functions in bpftool calling
> both. Since the meaning of flags is the same, seems ok sharing.

So I guess there are no objections to the current patch? If it gets
accepted, you should be able to drop some of your code and use this
new bpf_obj_get_opts..

> Roberto
>
> > > Roberto
> > >
> > > > > ---
> > > > >  tools/lib/bpf/bpf.c      | 10 ++++++++++
> > > > >  tools/lib/bpf/bpf.h      |  9 +++++++++
> > > > >  tools/lib/bpf/libbpf.map |  1 +
> > > > >  3 files changed, 20 insertions(+)
> > > > >
> > > > > diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> > > > > index 5eb0df90eb2b..5acb0e8bd13c 100644
> > > > > --- a/tools/lib/bpf/bpf.c
> > > > > +++ b/tools/lib/bpf/bpf.c
> > > > > @@ -578,12 +578,22 @@ int bpf_obj_pin(int fd, const char *pathname)
> > > > >  }
> > > > >
> > > > >  int bpf_obj_get(const char *pathname)
> > > > > +{
> > > > > +       LIBBPF_OPTS(bpf_obj_get_opts, opts);
> > > > > +       return bpf_obj_get_opts(pathname, &opts);
> > > > > +}
> > > > > +
> > > > > +int bpf_obj_get_opts(const char *pathname, const struct
> > bpf_obj_get_opts
> > > > *opts)
> > > > >  {
> > > > >         union bpf_attr attr;
> > > > >         int fd;
> > > > >
> > > > > +       if (!OPTS_VALID(opts, bpf_obj_get_opts))
> > > > > +               return libbpf_err(-EINVAL);
> > > > > +
> > > > >         memset(&attr, 0, sizeof(attr));
> > > > >         attr.pathname = ptr_to_u64((void *)pathname);
> > > > > +       attr.file_flags = OPTS_GET(opts, file_flags, 0);
> > > > >
> > > > >         fd = sys_bpf_fd(BPF_OBJ_GET, &attr, sizeof(attr));
> > > > >         return libbpf_err_errno(fd);
> > > > > diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> > > > > index 88a7cc4bd76f..f31b493b5f9a 100644
> > > > > --- a/tools/lib/bpf/bpf.h
> > > > > +++ b/tools/lib/bpf/bpf.h
> > > > > @@ -270,8 +270,17 @@ LIBBPF_API int bpf_map_update_batch(int fd,
> > const
> > > > void *keys, const void *values
> > > > >                                     __u32 *count,
> > > > >                                     const struct bpf_map_batch_opts *opts);
> > > > >
> > > > > +struct bpf_obj_get_opts {
> > > > > +       size_t sz; /* size of this struct for forward/backward compatibility */
> > > > > +
> > > > > +       __u32 file_flags;
> > > > > +};
> > > > > +#define bpf_obj_get_opts__last_field file_flags
> > > > > +
> > > > >  LIBBPF_API int bpf_obj_pin(int fd, const char *pathname);
> > > > >  LIBBPF_API int bpf_obj_get(const char *pathname);
> > > > > +LIBBPF_API int bpf_obj_get_opts(const char *pathname,
> > > > > +                               const struct bpf_obj_get_opts *opts);
> > > > >
> > > > >  struct bpf_prog_attach_opts {
> > > > >         size_t sz; /* size of this struct for forward/backward compatibility */
> > > > > diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> > > > > index 0625adb9e888..119e6e1ea7f1 100644
> > > > > --- a/tools/lib/bpf/libbpf.map
> > > > > +++ b/tools/lib/bpf/libbpf.map
> > > > > @@ -355,6 +355,7 @@ LIBBPF_0.8.0 {
> > > > >
> > > > >  LIBBPF_1.0.0 {
> > > > >         global:
> > > > > +               bpf_obj_get_opts;
> > > > >                 bpf_prog_query_opts;
> > > > >                 bpf_program__attach_ksyscall;
> > > > >                 btf__add_enum64;
> > > > > --
> > > > > 2.37.0.170.g444d1eabd0-goog
> > > > >
