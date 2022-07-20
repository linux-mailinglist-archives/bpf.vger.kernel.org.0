Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8773357BAF3
	for <lists+bpf@lfdr.de>; Wed, 20 Jul 2022 17:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbiGTP5L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jul 2022 11:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbiGTP5K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jul 2022 11:57:10 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E364B0E3
        for <bpf@vger.kernel.org>; Wed, 20 Jul 2022 08:57:09 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id o18so16760059pgu.9
        for <bpf@vger.kernel.org>; Wed, 20 Jul 2022 08:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ce/0l8zZFSWxrvXqTD1rFm6VFoYD2QFsbPDkuHHkwaY=;
        b=RoKxGblmnegdrP1c0em3AoK5G4jeKtLnt4i2jnxOgsuI+WbC12ClEOCv9Ip327DSg7
         u7OnrzBCQmTAwD+iIRo4E0bBUAtsQwk/sSFIcHyfCPfi4m6TuSAM0WjJ+8aBs9oEx8DK
         DD3Cu1D+VkUuCfBitqFMXA33WbLqlm+RNcifcOjjqb4S6n9UvPsvHWxolZCqjcMHq3KW
         4x3ZPxHAb5LAAy7nyabAsOBA78W5D+RxyePrw8YyXj9FhxpOkkpCWKP26QFKzl4f7bYl
         /oxLuZtpYcd4TB0ACz9ww0YZgW93ZjrcR4e4Imq/iHY5wC+wQ+Hbckqw7+BV/+LCQ5jV
         /3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ce/0l8zZFSWxrvXqTD1rFm6VFoYD2QFsbPDkuHHkwaY=;
        b=BOcUQBIIMq0Sjuv4jn59Xx/j88Qj/xxcCwaCPEiwdIXlTo3z5ANNUoZuTahDMJFSXN
         ogWLFvLVSn1UWZouJs06sa0dsjxu/25ctiyOwCv/8SKtT+S1JPKyDDdBSBCJMjKpETGE
         XPgihYs27MbUTKOyqzRIKZqvxmCYMDclN1xl7EpwCqpMe5O3y/seP53av1DJTDJ6fRwk
         5vvpM0H17V+jusq+PPfNVUSjxBmCQfXOU+7CdbRWZUYVHDBsF82gQuACtJXY+CHRmr52
         7V40vgTPO9aUIfY/CBF52udWf8d4+5XGqvbqPYNfZspVq+t1ucd1Ooaepu2Lqjgls7S1
         M/YQ==
X-Gm-Message-State: AJIora9GtPfb9KytzBW1WPTLkeCM6vKKc1258csQ8UfTrz64Lt9iZ0A1
        YhCyR/HsSlGCL0PXMirGk17S48RYXEq8Yng+JxjaVg==
X-Google-Smtp-Source: AGRyM1tINSVkMuM4eb4gm1xru+KFwEKZU3QyNxXe0sGn0kBmUMtttpngaMrGv+eJAVxEtd7/6O0iezB0rkrAM1sODLE=
X-Received: by 2002:a65:4c0b:0:b0:415:d3a4:44d1 with SMTP id
 u11-20020a654c0b000000b00415d3a444d1mr34871068pgq.191.1658332629110; Wed, 20
 Jul 2022 08:57:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220719194028.4180569-1-jevburton.kernel@gmail.com>
 <CAKH8qBsm0QqE-7Pmhhz=tRYAfgpirbu6K1deQ6cQTU+GTykLNA@mail.gmail.com> <179cfb89be0e4f928a55d049fe62aa9e@huawei.com>
In-Reply-To: <179cfb89be0e4f928a55d049fe62aa9e@huawei.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 20 Jul 2022 08:56:58 -0700
Message-ID: <CAKH8qBt0yR+mtCjAp=8jQL4M6apWQk0wH7Zf4tPDCf3=m+gAKA@mail.gmail.com>
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

On Wed, Jul 20, 2022 at 1:02 AM Roberto Sassu <roberto.sassu@huawei.com> wrote:
>
> > From: Stanislav Fomichev [mailto:sdf@google.com]
> > Sent: Tuesday, July 19, 2022 10:40 PM
> > On Tue, Jul 19, 2022 at 12:40 PM Joe Burton <jevburton.kernel@gmail.com>
> > wrote:
> > >
> > > From: Joe Burton <jevburton@google.com>
> > >
> > > Add an extensible variant of bpf_obj_get() capable of setting the
> > > `file_flags` parameter.
> > >
> > > This parameter is needed to enable unprivileged access to BPF maps.
> > > Without a method like this, users must manually make the syscall.
> > >
> > > Signed-off-by: Joe Burton <jevburton@google.com>
> >
> > Reviewed-by: Stanislav Fomichev <sdf@google.com>
> >
> > For context:
> > We've found this out while we were trying to add support for unpriv
> > processes to open pinned r-x maps.
> > Maybe this deserves a test as well? Not sure.
>
> Hi Stanislav, Joe
>
> I noticed now this patch. I'm doing a broader work to add opts
> to bpf_*_get_fd_by_id(). I also adjusted permissions of bpftool
> depending on the operation type (e.g. show, dump: BPF_F_RDONLY).
>
> Will send it soon (I'm trying to solve an issue with the CI, where
> libbfd is not available in the VM doing actual tests).

Is something like this patch included in your series as well? Can you
use this new interface or do you need something different?

> Roberto
>
> > > ---
> > >  tools/lib/bpf/bpf.c      | 10 ++++++++++
> > >  tools/lib/bpf/bpf.h      |  9 +++++++++
> > >  tools/lib/bpf/libbpf.map |  1 +
> > >  3 files changed, 20 insertions(+)
> > >
> > > diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> > > index 5eb0df90eb2b..5acb0e8bd13c 100644
> > > --- a/tools/lib/bpf/bpf.c
> > > +++ b/tools/lib/bpf/bpf.c
> > > @@ -578,12 +578,22 @@ int bpf_obj_pin(int fd, const char *pathname)
> > >  }
> > >
> > >  int bpf_obj_get(const char *pathname)
> > > +{
> > > +       LIBBPF_OPTS(bpf_obj_get_opts, opts);
> > > +       return bpf_obj_get_opts(pathname, &opts);
> > > +}
> > > +
> > > +int bpf_obj_get_opts(const char *pathname, const struct bpf_obj_get_opts
> > *opts)
> > >  {
> > >         union bpf_attr attr;
> > >         int fd;
> > >
> > > +       if (!OPTS_VALID(opts, bpf_obj_get_opts))
> > > +               return libbpf_err(-EINVAL);
> > > +
> > >         memset(&attr, 0, sizeof(attr));
> > >         attr.pathname = ptr_to_u64((void *)pathname);
> > > +       attr.file_flags = OPTS_GET(opts, file_flags, 0);
> > >
> > >         fd = sys_bpf_fd(BPF_OBJ_GET, &attr, sizeof(attr));
> > >         return libbpf_err_errno(fd);
> > > diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> > > index 88a7cc4bd76f..f31b493b5f9a 100644
> > > --- a/tools/lib/bpf/bpf.h
> > > +++ b/tools/lib/bpf/bpf.h
> > > @@ -270,8 +270,17 @@ LIBBPF_API int bpf_map_update_batch(int fd, const
> > void *keys, const void *values
> > >                                     __u32 *count,
> > >                                     const struct bpf_map_batch_opts *opts);
> > >
> > > +struct bpf_obj_get_opts {
> > > +       size_t sz; /* size of this struct for forward/backward compatibility */
> > > +
> > > +       __u32 file_flags;
> > > +};
> > > +#define bpf_obj_get_opts__last_field file_flags
> > > +
> > >  LIBBPF_API int bpf_obj_pin(int fd, const char *pathname);
> > >  LIBBPF_API int bpf_obj_get(const char *pathname);
> > > +LIBBPF_API int bpf_obj_get_opts(const char *pathname,
> > > +                               const struct bpf_obj_get_opts *opts);
> > >
> > >  struct bpf_prog_attach_opts {
> > >         size_t sz; /* size of this struct for forward/backward compatibility */
> > > diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> > > index 0625adb9e888..119e6e1ea7f1 100644
> > > --- a/tools/lib/bpf/libbpf.map
> > > +++ b/tools/lib/bpf/libbpf.map
> > > @@ -355,6 +355,7 @@ LIBBPF_0.8.0 {
> > >
> > >  LIBBPF_1.0.0 {
> > >         global:
> > > +               bpf_obj_get_opts;
> > >                 bpf_prog_query_opts;
> > >                 bpf_program__attach_ksyscall;
> > >                 btf__add_enum64;
> > > --
> > > 2.37.0.170.g444d1eabd0-goog
> > >
