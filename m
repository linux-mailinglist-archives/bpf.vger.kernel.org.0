Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC006983C8
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 19:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjBOStI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 13:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjBOStH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 13:49:07 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DBB35AD
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 10:48:50 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id y25so4120161pfw.11
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 10:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HhAUAAU6UTxOwn+R8DxPYWVLUorwT3cHaWzmfn9ZgD0=;
        b=Lvyvzngc/TMc5puh/nMnTcvE2xSykY+9ecg5Fsc+5Ok9cGOznzz8Uame6ZvSJw8RIl
         Ki5NP25AS0yWI7XxXAjgiGnN1/ahpD+gfNi+cAL94OOMoUkZz+BxnuqE4OfXgkOXD6fY
         F6c/rNNbLs+TGMHuGjF5IWhf3T5LSLnQX4Gw49f7CQjvZB6hGCZLVssZI22qKJVM47lr
         vQwMMfseKOx8gTkkZnC/fF2AjEIr630ZRLH5OyVmUAqY/BPxgOFVxk0/DtJiSlZzoP0k
         iYEsNjVNyIJUtLtxdpAUR5EaVPgs2G7tfiAg1cwtdJncPUz0wIhMHUV8q3OWdh4oVcik
         mNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HhAUAAU6UTxOwn+R8DxPYWVLUorwT3cHaWzmfn9ZgD0=;
        b=HGLFGA0qiidCa6EOjzUJSMFRP1csqyMz2opcTgBEBSTag/AHZ3Jfyr9dQcOzFydjrI
         oUWnfiQcStnFmn/qp6bp60FNb387BZSE3YXwrJKRzKRH/CkzS5Ug3JMIEMmWnWt6NqgL
         4aejgXrr99zGXpieXS6VQ2n5euxS4Bl9lYSKMwgQHSweCxhnr2efohDKL1BG4jXc9cCo
         4Cp4iP02JyByWbbWemnOisakrU13qEB/vBiI2ZVzVv/lJgNS33MODq/zCy7S/NYNSPAV
         cH4hxBllmvF4/n5qqSoeXLCi/uaTReXg0TWF38X7WOeIUdLQEvHSFrftBpTr0L3MpRKv
         bs5w==
X-Gm-Message-State: AO0yUKVbXPIZ3vP37iXlzM4AblXog9DsUQyXD/3zup0EYfqJj5ChW04v
        iL1kSycOg0z3GkoEVkONIIMWtGAOll7C+0zzZ5CLZA==
X-Google-Smtp-Source: AK7set+RB+7Nzd5xkLnUJsOz/yMya+9Jpxzav6ttAqSs4a+ZAPJUC4UZh1RzA2umDX48143D1cc8dTORIb65nU9/loo=
X-Received: by 2002:aa7:9851:0:b0:5a8:dd33:aa1e with SMTP id
 n17-20020aa79851000000b005a8dd33aa1emr534746pfq.23.1676486930014; Wed, 15 Feb
 2023 10:48:50 -0800 (PST)
MIME-Version: 1.0
References: <20230214221718.503964-1-kuifeng@meta.com> <20230214221718.503964-5-kuifeng@meta.com>
 <Y+xKOq4gW58IDMWE@google.com> <7149cfe4-7ae4-a8e9-6f85-38e488080f28@gmail.com>
In-Reply-To: <7149cfe4-7ae4-a8e9-6f85-38e488080f28@gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 15 Feb 2023 10:48:38 -0800
Message-ID: <CAKH8qBvUhDrMjveh-_MZPkcy9sUf2UJ1kL1sx=Tt+yWwf+XBtQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/7] libbpf: Create a bpf_link in bpf_map__attach_struct_ops().
To:     Kui-Feng Lee <sinquersw@gmail.com>
Cc:     Kui-Feng Lee <kuifeng@meta.com>, bpf@vger.kernel.org,
        ast@kernel.org, martin.lau@linux.dev, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org
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

On Wed, Feb 15, 2023 at 10:44 AM Kui-Feng Lee <sinquersw@gmail.com> wrote:
>
>
> On 2/14/23 18:58, Stanislav Fomichev wrote:
> > On 02/14, Kui-Feng Lee wrote:
> >> bpf_map__attach_struct_ops() was creating a dummy bpf_link as a
> >> placeholder, but now it is constructing an authentic one by calling
> >> bpf_link_create() if the map has the BPF_F_LINK flag.
> >
> >> You can flag a struct_ops map with BPF_F_LINK by calling
> >> bpf_map__set_map_flags().
> >
> >> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
> >> ---
> >>   tools/lib/bpf/libbpf.c | 73 +++++++++++++++++++++++++++++++++---------
> >>   1 file changed, 58 insertions(+), 15 deletions(-)
> >
> >> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> >> index 75ed95b7e455..1eff6a03ddd9 100644
> >> --- a/tools/lib/bpf/libbpf.c
> >> +++ b/tools/lib/bpf/libbpf.c
> >> @@ -11430,29 +11430,41 @@ struct bpf_link *bpf_program__attach(const
> >> struct bpf_program *prog)
> >>       return link;
> >>   }
> >
> >> +struct bpf_link_struct_ops_map {
> >> +    struct bpf_link link;
> >> +    int map_fd;
> >> +};
> >
> > Ah, ok, now you're adding bpf_link_struct_ops_map. I guess I'm now
> > confused why you haven't done it in the first patch :-/
>
> Just won't to mix the libbpf part and kernel part in one patch.

Ah, shoot, I completely missed that it's libbpf. So in this case, can
we use the same strategy for the kernel links? Instead of a union,
have an outer struct + container_of? If not, why not?


>
> >
> > And what are these fake bpf_links? Can you share more about it means?
>
> For the next version, I will detail it in the commit log. In a nutshell,
> before this point, there was no bpf_link for struct_ops. Libbpf
> attempted to create an equivalent interface to other BPF programs by
> providing a simulated bpf_link instead of a true one from the kernel;
> that fake bpf_link stores FDs associated with struct_ops maps rather
> than real bpf_links.
>
>
> >
> >> +
> >>   static int bpf_link__detach_struct_ops(struct bpf_link *link)
> >>   {
> >> +    struct bpf_link_struct_ops_map *st_link;
> >>       __u32 zero = 0;
> >
> >> -    if (bpf_map_delete_elem(link->fd, &zero))
> >> +    st_link = container_of(link, struct bpf_link_struct_ops_map, link);
> >> +
> >> +    if (st_link->map_fd < 0) {
> >> +        /* Fake bpf_link */
> >> +        if (bpf_map_delete_elem(link->fd, &zero))
> >> +            return -errno;
> >> +        return 0;
> >> +    }
> >> +
> >> +    if (bpf_map_delete_elem(st_link->map_fd, &zero))
> >> +        return -errno;
> >> +
> >> +    if (close(link->fd))
> >>           return -errno;
> >
> >>       return 0;
> >>   }
> >
> >> -struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
> >> +/*
> >> + * Update the map with the prepared vdata.
> >> + */
> >> +static int bpf_map__update_vdata(const struct bpf_map *map)
> >>   {
> >>       struct bpf_struct_ops *st_ops;
> >> -    struct bpf_link *link;
> >>       __u32 i, zero = 0;
> >> -    int err;
> >> -
> >> -    if (!bpf_map__is_struct_ops(map) || map->fd == -1)
> >> -        return libbpf_err_ptr(-EINVAL);
> >> -
> >> -    link = calloc(1, sizeof(*link));
> >> -    if (!link)
> >> -        return libbpf_err_ptr(-EINVAL);
> >
> >>       st_ops = map->st_ops;
> >>       for (i = 0; i < btf_vlen(st_ops->type); i++) {
> >> @@ -11468,17 +11480,48 @@ struct bpf_link
> >> *bpf_map__attach_struct_ops(const struct bpf_map *map)
> >>           *(unsigned long *)kern_data = prog_fd;
> >>       }
> >
> >> -    err = bpf_map_update_elem(map->fd, &zero, st_ops->kern_vdata, 0);
> >> +    return bpf_map_update_elem(map->fd, &zero, st_ops->kern_vdata, 0);
> >> +}
> >> +
> >> +struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
> >> +{
> >> +    struct bpf_link_struct_ops_map *link;
> >> +    int err, fd;
> >> +
> >> +    if (!bpf_map__is_struct_ops(map) || map->fd == -1)
> >> +        return libbpf_err_ptr(-EINVAL);
> >> +
> >> +    link = calloc(1, sizeof(*link));
> >> +    if (!link)
> >> +        return libbpf_err_ptr(-EINVAL);
> >> +
> >> +    err = bpf_map__update_vdata(map);
> >>       if (err) {
> >>           err = -errno;
> >>           free(link);
> >>           return libbpf_err_ptr(err);
> >>       }
> >
> >> -    link->detach = bpf_link__detach_struct_ops;
> >> -    link->fd = map->fd;
> >> +    link->link.detach = bpf_link__detach_struct_ops;
> >
> >> -    return link;
> >> +    if (!(map->def.map_flags & BPF_F_LINK)) {
> >> +        /* Fake bpf_link */
> >> +        link->link.fd = map->fd;
> >> +        link->map_fd = -1;
> >> +        return &link->link;
> >> +    }
> >> +
> >> +    fd = bpf_link_create(map->fd, -1, BPF_STRUCT_OPS_MAP, NULL);
> >> +    if (fd < 0) {
> >> +        err = -errno;
> >> +        free(link);
> >> +        return libbpf_err_ptr(err);
> >> +    }
> >> +
> >> +    link->link.fd = fd;
> >> +    link->map_fd = map->fd;
> >> +
> >> +    return &link->link;
> >>   }
> >
> >>   typedef enum bpf_perf_event_ret (*bpf_perf_event_print_t)(struct
> >> perf_event_header *hdr,
> >> --
> >> 2.30.2
> >
