Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB0069B756
	for <lists+bpf@lfdr.de>; Sat, 18 Feb 2023 02:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjBRBLL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Feb 2023 20:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBRBLJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Feb 2023 20:11:09 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57271457E9
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 17:11:08 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id co2so10204254edb.13
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 17:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VOu1dyQE8U4lY27wC/YGtk+CrLBDaxyC0YMbqWYGens=;
        b=I0ncZ2B7oCstbiS5TnIXtmyYrik7nuvuo5tVzL6/lvY4F5J0Ur6S623CrCDuLkgE2Q
         DX+ushCw4V1WB1NbqEpZlUpuMUbUhEwbXS8sgfLgBO1cUN8HeCfhi/XH7hOsSHOy9g13
         mqp7bGyN3lNkrHjE6kVJOsULfAfENtt+9bvcEkSu+AClru6TozRcqNtJqstgFRMjxnDf
         uaY2oPLJdR0GKidT4j3x9QtyLbUANaRz4159E4444tNZ+qCAdvK3+m8NwiH3EgUVT8xY
         PQSvxgJVV6D2pRaMKB+y2GKwSFA21oJ01j5ElcRYvFnrB3jrx/F8x9CK9jWR59xFWDEh
         UZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VOu1dyQE8U4lY27wC/YGtk+CrLBDaxyC0YMbqWYGens=;
        b=5G0uXYFkhlJg7uDFECIfzXNjboAMtPZnJnWkrChcKEEHuCxnAIXsTTlPWMrmSLDur1
         ACd3hlqn7W8hO/8ZQmjb6hfVO61cHjIqlIEi1MHwOzHheB6NdFoxgMrWt2uS3W9+dveL
         hSfAvPdQRiYBFwr3pDimmwE7e6pIv1INEfNpf0krL/qcaF6YCEOEUt0aY0czFT3dlWJO
         aMyAumdHLMj7BvOD1Y6EKxPVHp6vUCVayIZxXXnwLuhacqmBZmfhHEV87/rH6aKo1YFG
         nJwJwFqbPMMOGQ9xqDdptuEGsMgg6YzQWFHkv0WC62y06zCMestpIhduvTKQVx0+aozH
         HAvQ==
X-Gm-Message-State: AO0yUKVT+wc6suC2TINVlZhaPvqfj+gw7iRbV3B8DwotLRpuV6eCHGJV
        WUpZ59mvUvI1LZNMN2vVJqqpA8SkA33uZb76rwl8HZycDLM=
X-Google-Smtp-Source: AK7set+l5oFltV1D/YTsuKDXEGS5iGiqtewJ84fwBj/o2NDGonchTdN2xoBwfiGbjNsULZ+clTTJNBC9+NZNGrQHoSg=
X-Received: by 2002:a17:906:f88f:b0:8b0:7e1d:f6fa with SMTP id
 lg15-20020a170906f88f00b008b07e1df6famr1182300ejb.15.1676682666825; Fri, 17
 Feb 2023 17:11:06 -0800 (PST)
MIME-Version: 1.0
References: <20230214221718.503964-1-kuifeng@meta.com> <20230214221718.503964-7-kuifeng@meta.com>
 <CAEf4BzaKRd2jif4XeKJ1s8Dfpp-wQyTTbXpF-Not6A5kpOGYqQ@mail.gmail.com> <e3c8beb3-5ff7-9de2-b4a8-3b23a111198f@gmail.com>
In-Reply-To: <e3c8beb3-5ff7-9de2-b4a8-3b23a111198f@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 17 Feb 2023 17:10:54 -0800
Message-ID: <CAEf4Bzap2F1E09Lw8fv+akZ8_RymuxzCTCO1O4yi7rqaqkPGeQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 6/7] libbpf: Update a bpf_link with another struct_ops.
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

On Fri, Feb 17, 2023 at 4:22 PM Kui-Feng Lee <sinquersw@gmail.com> wrote:
>
>
>
> On 2/16/23 14:48, Andrii Nakryiko wrote:
> > On Tue, Feb 14, 2023 at 2:17 PM Kui-Feng Lee <kuifeng@meta.com> wrote:
> >>
> >> Introduce bpf_link__update_struct_ops(), which will allow you to
> >> effortlessly transition the struct_ops map of any given bpf_link into
> >> an alternative.
> >>
> >> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
> >> ---
> >>   tools/lib/bpf/libbpf.c   | 35 +++++++++++++++++++++++++++++++++++
> >>   tools/lib/bpf/libbpf.h   |  1 +
> >>   tools/lib/bpf/libbpf.map |  1 +
> >>   3 files changed, 37 insertions(+)
> >>
> >> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> >> index 1eff6a03ddd9..6f7c72e312d4 100644
> >> --- a/tools/lib/bpf/libbpf.c
> >> +++ b/tools/lib/bpf/libbpf.c
> >> @@ -11524,6 +11524,41 @@ struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
> >>          return &link->link;
> >>   }
> >>
> >> +/*
> >> + * Swap the back struct_ops of a link with a new struct_ops map.
> >> + */
> >> +int bpf_link__update_struct_ops(struct bpf_link *link, const struct bpf_map *map)
> >
> > we have bpf_link__update_program(), and so the generic counterpart for
> > map-based links would be bpf_link__update_map(). Let's call it that.
> > And it shouldn't probably assume so much struct_ops specific things.
>
> Sure
>
> >
> >> +{
> >> +       struct bpf_link_struct_ops_map *st_ops_link;
> >> +       int err, fd;
> >> +
> >> +       if (!bpf_map__is_struct_ops(map) || map->fd == -1)
> >> +               return -EINVAL;
> >> +
> >> +       /* Ensure the type of a link is correct */
> >> +       if (link->detach != bpf_link__detach_struct_ops)
> >> +               return -EINVAL;
> >> +
> >> +       err = bpf_map__update_vdata(map);
> >
> > it's a bit weird we do this at attach time, not when bpf_map is
> > actually instantiated. Should we move this map contents initialization
> > to bpf_object__load() phase? Same for bpf_map__attach_struct_ops().
> > What do we lose by doing it after all the BPF programs are loaded in
> > load phase?
>
> With the current behavior (w/o links), a struct_ops will be registered
> when updating its value.  If we move bpf_map__update_vdata() to
> bpf_object__load(), a congestion control algorithm will be activated at
> the moment loading it before attaching it.  However, we should activate
> an algorithm at attach time.
>

Of course. But I was thinking to move `bpf_map_update_elem(map->fd,
&zero, st_ops->kern_vdata, 0);` part out of bpf_map__update_vdata()
and make update_vdata() just prepare st_ops->kern_vdata only.

>
> >
> >> +       if (err) {
> >> +               err = -errno;
> >> +               free(link);
> >> +               return err;
> >> +       }
> >> +
> >> +       fd = bpf_link_update(link->fd, map->fd, NULL);
> >> +       if (fd < 0) {
> >> +               err = -errno;
> >> +               free(link);
> >> +               return err;
> >> +       }
> >> +
> >> +       st_ops_link = container_of(link, struct bpf_link_struct_ops_map, link);
> >> +       st_ops_link->map_fd = map->fd;
> >> +
> >> +       return 0;
> >> +}
> >> +
> >>   typedef enum bpf_perf_event_ret (*bpf_perf_event_print_t)(struct perf_event_header *hdr,
> >>                                                            void *private_data);
> >>
> >> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> >> index 2efd80f6f7b9..dd25cd6759d4 100644
> >> --- a/tools/lib/bpf/libbpf.h
> >> +++ b/tools/lib/bpf/libbpf.h
> >> @@ -695,6 +695,7 @@ bpf_program__attach_freplace(const struct bpf_program *prog,
> >>   struct bpf_map;
> >>
> >>   LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map);
> >> +LIBBPF_API int bpf_link__update_struct_ops(struct bpf_link *link, const struct bpf_map *map);
> >
> > let's rename to bpf_link__update_map() and put it next to
> > bpf_link__update_program() in libbpf.h
> >
> >>
> >>   struct bpf_iter_attach_opts {
> >>          size_t sz; /* size of this struct for forward/backward compatibility */
> >> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> >> index 11c36a3c1a9f..ca6993c744b6 100644
> >> --- a/tools/lib/bpf/libbpf.map
> >> +++ b/tools/lib/bpf/libbpf.map
> >> @@ -373,6 +373,7 @@ LIBBPF_1.1.0 {
> >>          global:
> >>                  bpf_btf_get_fd_by_id_opts;
> >>                  bpf_link_get_fd_by_id_opts;
> >> +               bpf_link__update_struct_ops;
> >>                  bpf_map_get_fd_by_id_opts;
> >>                  bpf_prog_get_fd_by_id_opts;
> >>                  user_ring_buffer__discard;
> >
> > we are in LIBBPF_1.2.0 already, please move
> >
> >
> >> --
> >> 2.30.2
> >>
