Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5167C58552E
	for <lists+bpf@lfdr.de>; Fri, 29 Jul 2022 20:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237998AbiG2Szo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jul 2022 14:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237936AbiG2Szn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jul 2022 14:55:43 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D8552446;
        Fri, 29 Jul 2022 11:55:42 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id bp15so10059960ejb.6;
        Fri, 29 Jul 2022 11:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=tEL3b/sv0PZtKeDIvSVgaOOn4XTpuG6EFBfFim9+8uY=;
        b=cviKk+/IuJWyk8M8bnWjyI2IU5YN+a2WP02/5+cwP5+bUPBV5Vg9VRFWQenhJOauDf
         wSQcXfOdCWaHv6gPz3fp0EXiF7wjWTl0/E0IK5nSr+nOfk0ZHNQP4YOy6u8wNT65u/eh
         xrce8hy9rFw8BC57ZlpVu130HnMrftcEi9L00idRI1XdTxz1QT1WIt7rMCnWNiU6Wq6j
         SQc7EcX3HKZWNUBeNFWBhooa/5+l9hwI6EetWkPOY0qU8cGIFoTYGJCJ0BH+VELNRWtT
         bS6Hh+tlUv0dbgkAgndUK7T/cd/2kfqMF9sKAUL0XZP/47XOujvbNXyCzLUzDVGH7J8L
         NPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=tEL3b/sv0PZtKeDIvSVgaOOn4XTpuG6EFBfFim9+8uY=;
        b=oVyNjdxKKlAK6/UKqhr7K3OL72p4eEcFmopwS/sqtROdOO/WorwpLFD9Tsm64ZEaUm
         JZPYXuqBc61LVo3wWEQvEPCFUTDV/gZgkIg3H2zyz6Z/kCMA57OIbEV0fYQuhrySkN3K
         iMJ3pWGpuQrO8Ww3KrSC0xJMGMvYpADuwDCRFuCzn60YiLUT1TjcaWCkrs5pCSiieJ+Y
         /h6V5dd0EWIoi2pfLljIxOUlbk28xq80n8vvFlU6dmBCyIix0ZZ0q+8V782hUmYzRMAa
         lQ0H0Q77bnb5AQXBoaYkBaxtmM656hlL9Fu7eRTyHBc4Tc5FhyFu0efKONIgv4KR46OX
         PEuw==
X-Gm-Message-State: AJIora9up+qkc6PisqvXauBMd9RE9NJBrou83F3DI0hH9WZw2mNnV7EY
        IcgqOkQ70ByTEv5xP6g9vNwgBUJnk9aYfaPd67o=
X-Google-Smtp-Source: AGRyM1sgoLgGY7jU0lFwdXSt8xu3+7v5cyS/AL5e5VQr9uInPiJWYJRXRN2DZqu/QwoaMur0rVk8DBq1sUrr6CyJw84=
X-Received: by 2002:a17:906:5a6c:b0:72b:561a:3458 with SMTP id
 my44-20020a1709065a6c00b0072b561a3458mr3894746ejc.114.1659120940205; Fri, 29
 Jul 2022 11:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220719194028.4180569-1-jevburton.kernel@gmail.com>
 <CAEf4BzbWpQS6js5LfS80PkqwDwcLc+NgzfqqUTG-CkLP16shCg@mail.gmail.com> <03011a0506e8474db73c8c1fa9ec0786@huawei.com>
In-Reply-To: <03011a0506e8474db73c8c1fa9ec0786@huawei.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 29 Jul 2022 11:55:29 -0700
Message-ID: <CAEf4BzaGjqA_m9cqoDUz2XxLC6oLV+42SAUkSxo2bS9FJZ6+LA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] libbpf: Add bpf_obj_get_opts()
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     Joe Burton <jevburton.kernel@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Joe Burton <jevburton@google.com>
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

On Thu, Jul 28, 2022 at 12:58 AM Roberto Sassu <roberto.sassu@huawei.com> wrote:
>
> > From: Andrii Nakryiko [mailto:andrii.nakryiko@gmail.com]
> > Sent: Thursday, July 28, 2022 1:03 AM
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
> > > ---
> > >  tools/lib/bpf/bpf.c      | 10 ++++++++++
> > >  tools/lib/bpf/bpf.h      |  9 +++++++++
> > >  tools/lib/bpf/libbpf.map |  1 +
> > >  3 files changed, 20 insertions(+)
> > >
> >
> > I agree that bpf_obj_get_opts should be separate from bpf_get_fd_opts.
> > Just because both currently have file_flags in them doesn't mean that
> > they should/will always stay in sync. So two separate opts for two
> > separate APIs makes sense to me.
> >
> > So I'd accept this patch, but please see a few small things below and
> > send v3. Thanks!
>
> Should map_parse_fds() accept two opts, or just the flags
> to be set on locally-defined variables?

it's because map_parse_fds() is used with both get_fd_by_id() and
bpf_obj_get(), right? I'd pass flags and construct correct set of
options internally, based on which BPF command you need to use to get
FD

>
> Thanks
>
> Roberto
>
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
> >
> > if you were doing it this way, here should be an empty line. But
> > really you can/should just pass NULL instead of opts in this case.
> >
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
> >
> > please add size_t :0; to avoid non-zero-initialized padding  (we do it
> > in a lot of other opts structs)
> >
> >
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
