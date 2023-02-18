Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CB869B753
	for <lists+bpf@lfdr.de>; Sat, 18 Feb 2023 02:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjBRBIr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Feb 2023 20:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjBRBIq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Feb 2023 20:08:46 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8178B4347B
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 17:08:44 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id ez12so10698562edb.1
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 17:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VdYBUDQ9DnDR0sKL6Dz3dx8wvpqTmzDnpHI3t4+lvKg=;
        b=fSAGedPBfqnMNUEOG8pLL5ic/zt0/SdXQ47QNygf20UQbZa1VZgsaXF4BjCptYy8q+
         41AkPsn52DSfHTSOTWR5bq8kFlj596xajxU8ouctgHEPEHXcPphi7Fp+GLnKiuuXfvN/
         9j5oZgw9K4l/v8LiAF+V6XzrL/8Ht6fnD7xoyYx/z0DjKyFua8SBDBNOWxV5H1OuGI3V
         N9BqlWrQgtXmU1LfEMEQEXIchoW6AKEGIJ5sl+S1l21t3kfwiZABl5yhu13DKEivIQHR
         MQE9kHndzcZZH2C8cwx4QsEGHVz3ogipo3ZcSPqha8GtyNdQ1rl+gvKo6Y5W8vY+Gnom
         Kl/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VdYBUDQ9DnDR0sKL6Dz3dx8wvpqTmzDnpHI3t4+lvKg=;
        b=j6xMluTtFZtCk7dgL75SJOPyWKzze9qfEBXeOyTC+1tR3owfHt2Mc4fBnltIoNpmLG
         R0RTJvnmKj+a5hGWnCrBSY8OzdniqGlc/4xPMQiJixMMDkRJijDeOenqL8fCSOUUGdP2
         26D9HRIdcBSg7hpKneg0xzUZHPIfWAwtV4yqMgJol3eX+BIzDXZa9m4aJV+nYRz/Dbd3
         eBw/LyEqgOZQFEb6w5fLzlvCagOxAT1Ivkuy2ua1PQbtsyBfddVyw4q6XndjdISIKcxq
         QmbOqoj/teIS+uZMbdhzw3UslPL+bi3VZkpM/ftyE2kCK/fLA89Oc7ll8+bCnU3ky+8h
         mBxw==
X-Gm-Message-State: AO0yUKWUkqXieQWqmMFPg7kzY2887lbdO2xatQg541u4V0nbbb4NQfoG
        64YbMTkJPcf/KydXylZzagR6MlbTvOWMZYYXUBvKSkFY
X-Google-Smtp-Source: AK7set8oRdb7Kljp4e88Bba8OHU1Skj/l8VE+BjeBQBpDU+EHCW1XeoL8C1WhwoiuKYX1sDGX7uqtrgFJOu0AAPxiFc=
X-Received: by 2002:a17:906:bce7:b0:8b1:28f6:8ab3 with SMTP id
 op7-20020a170906bce700b008b128f68ab3mr1407285ejb.15.1676682522956; Fri, 17
 Feb 2023 17:08:42 -0800 (PST)
MIME-Version: 1.0
References: <20230214221718.503964-1-kuifeng@meta.com> <20230214221718.503964-5-kuifeng@meta.com>
 <CAEf4BzZ8k04R4Y0FY2k6KoSPZdiYRJxcnA1qypi=Hk-JM8ppWw@mail.gmail.com> <f8ed7a71-626a-a86f-7404-07b2ae44b20d@gmail.com>
In-Reply-To: <f8ed7a71-626a-a86f-7404-07b2ae44b20d@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 17 Feb 2023 17:08:30 -0800
Message-ID: <CAEf4BzYQtacgsNcYXjyz+8zrjG=tA8o5q4s4JnUywGLwYABE1A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/7] libbpf: Create a bpf_link in bpf_map__attach_struct_ops().
To:     Kui-Feng Lee <sinquersw@gmail.com>
Cc:     Kui-Feng Lee <kuifeng@meta.com>, bpf@vger.kernel.org,
        ast@kernel.org, martin.lau@linux.dev, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org
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

On Fri, Feb 17, 2023 at 4:05 PM Kui-Feng Lee <sinquersw@gmail.com> wrote:
>
>
>
> On 2/16/23 14:40, Andrii Nakryiko wrote:
> > On Tue, Feb 14, 2023 at 2:17 PM Kui-Feng Lee <kuifeng@meta.com> wrote:
> >>
> >> bpf_map__attach_struct_ops() was creating a dummy bpf_link as a
> >> placeholder, but now it is constructing an authentic one by calling
> >> bpf_link_create() if the map has the BPF_F_LINK flag.
> >>
> >> You can flag a struct_ops map with BPF_F_LINK by calling
> >> bpf_map__set_map_flags().
> >>
> >> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
> >> ---
> >>   tools/lib/bpf/libbpf.c | 73 +++++++++++++++++++++++++++++++++---------
> >>   1 file changed, 58 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> >> index 75ed95b7e455..1eff6a03ddd9 100644
> >> --- a/tools/lib/bpf/libbpf.c
> >> +++ b/tools/lib/bpf/libbpf.c
> >> @@ -11430,29 +11430,41 @@ struct bpf_link *bpf_program__attach(const struct bpf_program *prog)
> >>          return link;
> >>   }
> >>
> >> +struct bpf_link_struct_ops_map {
> >
> > let's drop the "_map" suffix? struct_ops is always a map, so no need
> > to point this out
>
> Sure!
>
> >
> >> +       struct bpf_link link;
> >> +       int map_fd;
> >> +};
> >> +
> >>   static int bpf_link__detach_struct_ops(struct bpf_link *link)
> >>   {
> >> +       struct bpf_link_struct_ops_map *st_link;
> >>          __u32 zero = 0;
> >>
> >> -       if (bpf_map_delete_elem(link->fd, &zero))
> >> +       st_link = container_of(link, struct bpf_link_struct_ops_map, link);
> >> +
> >> +       if (st_link->map_fd < 0) {
> >> +               /* Fake bpf_link */
> >> +               if (bpf_map_delete_elem(link->fd, &zero))
> >> +                       return -errno;
> >> +               return 0;
> >> +       }
> >> +
> >> +       if (bpf_map_delete_elem(st_link->map_fd, &zero))
> >> +               return -errno;
> >> +
> >> +       if (close(link->fd))
> >>                  return -errno;
> >>
> >>          return 0;
> >>   }
> >>
> >> -struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
> >> +/*
> >> + * Update the map with the prepared vdata.
> >> + */
> >> +static int bpf_map__update_vdata(const struct bpf_map *map)
> >
> > this is internal helper, so let's not use double underscores, just
> > bpf_map_update_vdata()
>
> Ok!
>
> >
> >>   {
> >>          struct bpf_struct_ops *st_ops;
> >> -       struct bpf_link *link;
> >>          __u32 i, zero = 0;
> >> -       int err;
> >> -
> >> -       if (!bpf_map__is_struct_ops(map) || map->fd == -1)
> >> -               return libbpf_err_ptr(-EINVAL);
> >> -
> >> -       link = calloc(1, sizeof(*link));
> >> -       if (!link)
> >> -               return libbpf_err_ptr(-EINVAL);
> >>
> >>          st_ops = map->st_ops;
> >>          for (i = 0; i < btf_vlen(st_ops->type); i++) {
> >> @@ -11468,17 +11480,48 @@ struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
> >>                  *(unsigned long *)kern_data = prog_fd;
> >>          }
> >>
> >> -       err = bpf_map_update_elem(map->fd, &zero, st_ops->kern_vdata, 0);
> >> +       return bpf_map_update_elem(map->fd, &zero, st_ops->kern_vdata, 0);
> >> +}
> >> +
> >> +struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
> >> +{
> >> +       struct bpf_link_struct_ops_map *link;
> >> +       int err, fd;
> >> +
> >> +       if (!bpf_map__is_struct_ops(map) || map->fd == -1)
> >> +               return libbpf_err_ptr(-EINVAL);
> >> +
> >> +       link = calloc(1, sizeof(*link));
> >> +       if (!link)
> >> +               return libbpf_err_ptr(-EINVAL);
> >> +
> >> +       err = bpf_map__update_vdata(map);
> >>          if (err) {
> >>                  err = -errno;
> >>                  free(link);
> >>                  return libbpf_err_ptr(err);
> >>          }
> >>
> >> -       link->detach = bpf_link__detach_struct_ops;
> >> -       link->fd = map->fd;
> >> +       link->link.detach = bpf_link__detach_struct_ops;
> >>
> >> -       return link;
> >> +       if (!(map->def.map_flags & BPF_F_LINK)) {
> >
> > So this will always require a programmatic bpf_map__set_map_flags()
> > call, there is currently no declarative way to do this, right?
> >
> > Is there any way to avoid this BPF_F_LINK flag approach? How bad would
> > it be if kernel just always created bpf_link-backed struct_ops?
> >
> > Alternatively, should we think about SEC(".struct_ops.link") or
> > something like that to instruct libbpf to add this BPF_F_LINK flag
> > automatically?
>
> Agree!
>
> The other solution is to add a flag when declare a struct_ops.
>
>   SEC(".struct_ops")
>   tcp_congestion_ops ops = {
>       ...
>       .flags = WITH_LINK,
>   }
>

tcp_congestion_ops is defined in kernel and used by kernel internal
code. I don't think randomly setting and passing extra flag is generic
solution that will work for all struct_ops kinds.

>
> >
> >> +               /* Fake bpf_link */
> >> +               link->link.fd = map->fd;
> >> +               link->map_fd = -1;
> >> +               return &link->link;
> >> +       }
> >> +
