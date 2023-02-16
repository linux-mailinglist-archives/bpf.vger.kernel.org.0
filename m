Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C5E69A278
	for <lists+bpf@lfdr.de>; Fri, 17 Feb 2023 00:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjBPXhz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Feb 2023 18:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjBPXhz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Feb 2023 18:37:55 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6787515CA4
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 15:37:53 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id n20so9237943edy.0
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 15:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lUlKET5N1wLsBmYASq5sEjnasT3LbF0LcdAR9d18DqM=;
        b=XZrE/xBVWqstUYWEbrsSQR6f+zphJ7Li+FR/RVDdMqYQp53fa238bS4pPnVZn/dzB0
         Og7Ct8NmUXL8Lgw9qyVR7EVR7S2K7bMAAEKJD8XIJv6ye3UL0BtQNwL6ZKCPUcsSc13l
         WgmKdAWccpEERk5RcvJilbY5Diif5rbjoWP9mI5DI8XZLauPZyDQkd25GKImpRx7oC43
         Uy7ZEIeTzfolpnea/syC8iURdOaaq2JzjMpElToxwCOBzx1kTYHsxHImcYZabpMoO3VZ
         +38GIQTsWQ/3do1YZnU6ZDorAqOpwDsz0bLV+o8dWcX91p+EUDEiX+dJoqfAJ1ofJhEQ
         zNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lUlKET5N1wLsBmYASq5sEjnasT3LbF0LcdAR9d18DqM=;
        b=mZ4Y+WVn5b08mp+5SmXimrkrZAFhH/gu5I/G6AbIFtIEdypyRfZz6RdisOgjFvjC9g
         9eGTfJOpicnzEZSptBS1dgzF0rp/RQBILqCPea4VU3qB0OTY2csWIBQcNftruH5RYFc1
         rm2Vq1tKG62xmrhTnrIl0Y5eR90E/W0SaK0HaiajNZJ6NKXXSx1j5s8JP6YIjIg9eaPv
         zvGgg597CI1BDr1DzHJ4UjmfpBaLOa690KgjM491vD+tRGLwvPEBPruYQ9414RBeCAlZ
         Yem8ucw46VG0FbIYtwSBZwBJwzGSpWRDlOTAmUEK3ue685M1emKLcw3T+g1ib+UA1H9v
         pjYw==
X-Gm-Message-State: AO0yUKWH/eAFmRNrut3u00iX9sF+XkcMLUbSTKogRyaGsKLXZT9BUMs7
        UHEBrlLSUEEOM/yWhPkyMPyqoxgSaoZXKaID+id9r465
X-Google-Smtp-Source: AK7set83q7V4QT7HihzHmctLx/zQHv9zDfE+0jQUUvyE1rcSUmMgjqXdHvehsBgEinfy8R3FMBSjqXlTQCyHs6uso7k=
X-Received: by 2002:a05:6402:3890:b0:4ab:1f1b:95a1 with SMTP id
 fd16-20020a056402389000b004ab1f1b95a1mr2845796edb.0.1676590671771; Thu, 16
 Feb 2023 15:37:51 -0800 (PST)
MIME-Version: 1.0
References: <20230214231221.249277-1-iii@linux.ibm.com> <20230214231221.249277-2-iii@linux.ibm.com>
 <CAEf4BzZhtgPn795-ExciXvgvhDA5rOhdWtXC7wRX+QT9qVMsdg@mail.gmail.com>
In-Reply-To: <CAEf4BzZhtgPn795-ExciXvgvhDA5rOhdWtXC7wRX+QT9qVMsdg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 16 Feb 2023 15:37:39 -0800
Message-ID: <CAEf4Bzb-dbt=vowjMKs1KQcjnxqPa9ftCLfxX9YjTKw+ewKjAg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/8] libbpf: Introduce bpf_{btf,link,map,prog}_get_info_by_fd()
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
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

On Thu, Feb 16, 2023 at 3:08 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Feb 14, 2023 at 3:12 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
> >
> > These are type-safe wrappers around bpf_obj_get_info_by_fd(). They
> > found one problem in selftests, and are also useful for adding
> > Memory Sanitizer annotations.
> >
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> >  tools/lib/bpf/bpf.c      | 24 ++++++++++++++++++++++++
> >  tools/lib/bpf/bpf.h      | 13 +++++++++++++
> >  tools/lib/bpf/libbpf.map |  5 +++++
> >  3 files changed, 42 insertions(+)
> >
> > diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> > index 9aff98f42a3d..b562019271fe 100644
> > --- a/tools/lib/bpf/bpf.c
> > +++ b/tools/lib/bpf/bpf.c
> > @@ -1044,6 +1044,30 @@ int bpf_obj_get_info_by_fd(int bpf_fd, void *info, __u32 *info_len)
> >         return libbpf_err_errno(err);
> >  }
> >
> > +int bpf_prog_get_info_by_fd(int prog_fd, struct bpf_prog_info *info,
> > +                           __u32 *info_len)
> > +{
> > +       return bpf_obj_get_info_by_fd(prog_fd, info, info_len);
> > +}
> > +
> > +int bpf_map_get_info_by_fd(int map_fd, struct bpf_map_info *info,
> > +                          __u32 *info_len)
> > +{
> > +       return bpf_obj_get_info_by_fd(map_fd, info, info_len);
> > +}
> > +
> > +int bpf_btf_get_info_by_fd(int btf_fd, struct bpf_btf_info *info,
> > +                          __u32 *info_len)
> > +{
> > +       return bpf_obj_get_info_by_fd(btf_fd, info, info_len);
> > +}
> > +
> > +int bpf_link_get_info_by_fd(int link_fd, struct bpf_link_info *info,
> > +                           __u32 *info_len)
>
> fits under 100 characters, please keep on single line
>
> > +{
> > +       return bpf_obj_get_info_by_fd(link_fd, info, info_len);
> > +}
> > +
> >  int bpf_raw_tracepoint_open(const char *name, int prog_fd)
> >  {
> >         const size_t attr_sz = offsetofend(union bpf_attr, raw_tracepoint);
> > diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> > index 7468978d3c27..9f698088c9bc 100644
> > --- a/tools/lib/bpf/bpf.h
> > +++ b/tools/lib/bpf/bpf.h
> > @@ -386,6 +386,19 @@ LIBBPF_API int bpf_link_get_fd_by_id(__u32 id);
> >  LIBBPF_API int bpf_link_get_fd_by_id_opts(__u32 id,
> >                                 const struct bpf_get_fd_by_id_opts *opts);
> >  LIBBPF_API int bpf_obj_get_info_by_fd(int bpf_fd, void *info, __u32 *info_len);
> > +/* Type-safe variants of bpf_obj_get_info_by_fd(). The callers still needs to
> > + * pass info_len, which should normally be
> > + * sizeof(struct bpf_{prog,map,btf,link}_info), in order to be compatible with
> > + * different libbpf and kernel versions.
> > + */
>
> let's add proper doc comments for new APIs, see bpf_map_update_batch
> for an example
>

It was sad to require you to respin first 5 patches because of this
doc comment issue, so I unwrapped lines and landed first 5 patches as
is. Please do follow up with doc comments, and let's figure out what
we do about MSan annotations separately. Thanks for clean ups and
improvements!

> > +LIBBPF_API int bpf_prog_get_info_by_fd(int prog_fd, struct bpf_prog_info *info,
> > +                                      __u32 *info_len);
> > +LIBBPF_API int bpf_map_get_info_by_fd(int map_fd, struct bpf_map_info *info,
> > +                                     __u32 *info_len);
> > +LIBBPF_API int bpf_btf_get_info_by_fd(int btf_fd, struct bpf_btf_info *info,
> > +                                     __u32 *info_len);
> > +LIBBPF_API int bpf_link_get_info_by_fd(int link_fd, struct bpf_link_info *info,
> > +                                      __u32 *info_len);
> >
>
> ditto, single lines are the best
>
> >  struct bpf_prog_query_opts {
> >         size_t sz; /* size of this struct for forward/backward compatibility */
> > diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> > index 11c36a3c1a9f..50dde1f6521e 100644
> > --- a/tools/lib/bpf/libbpf.map
> > +++ b/tools/lib/bpf/libbpf.map
> > @@ -384,4 +384,9 @@ LIBBPF_1.1.0 {
> >  } LIBBPF_1.0.0;
> >
> >  LIBBPF_1.2.0 {
> > +       global:
> > +               bpf_btf_get_info_by_fd;
> > +               bpf_link_get_info_by_fd;
> > +               bpf_map_get_info_by_fd;
> > +               bpf_prog_get_info_by_fd;
> >  } LIBBPF_1.1.0;
> > --
> > 2.39.1
> >
