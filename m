Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB735129AF
	for <lists+bpf@lfdr.de>; Thu, 28 Apr 2022 04:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241597AbiD1C63 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Apr 2022 22:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiD1C62 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Apr 2022 22:58:28 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB7C2AC45
        for <bpf@vger.kernel.org>; Wed, 27 Apr 2022 19:55:13 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id w1so6264938lfa.4
        for <bpf@vger.kernel.org>; Wed, 27 Apr 2022 19:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OjFlU+AjcClS88vFs2Df8WRkj/DB0d/1nH0WPO/lECE=;
        b=qH2n3V2KkNSV6MK4tteqtwMD18ju6oX6RnhOGipUWuIqCdnss+DCdjK4lmaV5qJF/X
         LClnB2xOlUZA/bM+NVzW68TTqOgHTFU8UOLFF8Qi2v0uqMfomAQelHVA+vvQzLZmoskD
         +uXELr7acFbYxKiNiGaZr4newT4G8nCOyw3OujCX3fUvQ4MCRVBsUrsDV8CrsG4XPYep
         xwWpfonEdhFWNFNZkdeLH9wGHF77E+VhYL65a++p81z+rNrj4o1sohAV9S2lfz/K4+qZ
         C9VbT9erRpl8YMh7XdvifPYCe+RBg4Yb/Tk8sZvKAH7H0hspKLIVCS5BtKo3OZ1o57oA
         7BGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OjFlU+AjcClS88vFs2Df8WRkj/DB0d/1nH0WPO/lECE=;
        b=HlPfEQosnTxcDkzgVGgfWJ5lJ0JbFPiY2L/un38flG4JkqP0N+ui1DHPN4rfAsvGrW
         y6TgeJI5vB+FSnIM1vdMYjJWFm1qmWiAu7xCw8hGFUeqGPijE0sGVqxG7vzpN57pTIAT
         SgaZ1U0WouytRdWBF2vxB5ZkxjjYZU8cTSpER6xcFs5euP1e5gxfStK1P4kC+UkHtEsd
         ZyRKKPW04a82ueiEUWy1WN/XJa8C7XSOwA5Hrd3StCiRFMHlLQToC2/sDv3e1AwAxwnU
         qRqlGd5s5GJzJyz9tMsvuvf8uU/R1usJ+7rcNkXtR1x8PtMbeFMCp0Gsh+IE1zuxGDcy
         cpWQ==
X-Gm-Message-State: AOAM530PpHf0+D64iZnuDULUCbIkJJLYPUu9fr1EMaiYGFnrAXwxIfpq
        rUesaVAHULrsogmE03f3siCocQ8pEY5xxelHHATm2s/L3PXOBQ==
X-Google-Smtp-Source: ABdhPJw+02mR1JmZJQ4on9qrMqC99XDCXMs+CpuyaClIJ3yZNs63HPeAUDKY13UZzNRPXhsbzyeZaTqAVuqpiB8/VsQ=
X-Received: by 2002:a05:6512:2307:b0:471:c299:7a47 with SMTP id
 o7-20020a056512230700b00471c2997a47mr21990821lfu.134.1651114511876; Wed, 27
 Apr 2022 19:55:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220427214337.716372-1-grantseltzer@gmail.com> <CAEf4Bza4fW0v7gGO+57hwoHhhaPTeQjHPYKU5P_NzYTYdoxMdA@mail.gmail.com>
In-Reply-To: <CAEf4Bza4fW0v7gGO+57hwoHhhaPTeQjHPYKU5P_NzYTYdoxMdA@mail.gmail.com>
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Wed, 27 Apr 2022 22:55:01 -0400
Message-ID: <CAO658oW381jwCAe24uiySjqz+=XRpGfDSai+=opK=z6a2y5gUw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] API function for retrieving data from percpu map
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
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

On Wed, Apr 27, 2022 at 6:16 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Apr 27, 2022 at 2:43 PM grantseltzer <grantseltzer@gmail.com> wrote:
> >
> > From: Grant Seltzer <grantseltzer@gmail.com>
> >
> > This adds a new API function used to retrieve all data from a
> > percpu array or percpu hashmap.
> >
> > This is useful because the current interface for doing so
> > requires knowledge of the layout of these BPF map internal
> > structures.
> >
> > Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
> > ---
> >  tools/lib/bpf/libbpf.c | 28 ++++++++++++++++++++++++++++
> >  tools/lib/bpf/libbpf.h | 25 +++++++++++++++++++++++++
> >  2 files changed, 53 insertions(+)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 873a29ce7781..8d72cff22688 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -36,6 +36,7 @@
> >  #include <linux/perf_event.h>
> >  #include <linux/ring_buffer.h>
> >  #include <linux/version.h>
> > +#include <linux/math.h>
> >  #include <sys/epoll.h>
> >  #include <sys/ioctl.h>
> >  #include <sys/mman.h>
> > @@ -4370,6 +4371,33 @@ int bpf_map__resize(struct bpf_map *map, __u32 max_entries)
> >         return bpf_map__set_max_entries(map, max_entries);
> >  }
> >
> > +void *bpf_map__get_percpu_value(const struct bpf_map *map, const void *key)
>
> I'd rather avoid API that allocates memory on behalf of user (and
> requires user to later free it) if possible. In this case there is no
> need for libbpf itself to allocate memory, user can allocate enough
> memory and pass it to libbpf.

I see, this makes sense. I also considered defining a macro instead,
similar to `bpf_object__for_each_program`, except something like
`bpf_map__for_each_cpu`.

>
> I'm actually working on few related APIs to avoid using low-level
> bpf_map_update_elem() from user-space. I want to add
> bpf_map__update_elem(), bpf_map__lookup_elem(),
> bpf_map__delete_elem(). It's TBD how it will look like for per-cpu
> maps, but I didn't plan to have a separate API for that. It would just
> change expectations of value size to be a value_size * num_cpus.

Ah ok, you actually mentioned this to me once before, about modeling
the  API to accept key/value sizes and validate based on bpf_map's
definition. Please let me know if I can help with this, I'd be happy
to tackle it.


>
> So stay tuned, hopefully very soon
>
> > +{
> > +
> > +       if (!(bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_ARRAY ||
> > +               bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_HASH)) {
> > +               return libbpf_err_ptr(-EINVAL);
> > +       }
> > +
> > +       int num_cpus;
> > +       __u32 value_size;
> > +       num_cpus = libbpf_num_possible_cpus();
> > +
> > +       if (num_cpus < 0)
> > +               return libbpf_err_ptr(-EBUSY);
> > +
> > +       value_size = bpf_map__value_size(map);
> > +
> > +       void *data = malloc(roundup(value_size, 8) * num_cpus);
> > +       int err = bpf_map_lookup_elem(map->fd, key, data);
> > +       if (err) {
> > +               free(data);
> > +               return libbpf_err_ptr(err);
> > +       }
> > +
> > +       return data;
> > +}
> > +
> >  static int
> >  bpf_object__probe_loading(struct bpf_object *obj)
> >  {
> > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > index cdbfee60ea3e..99b218702dfb 100644
> > --- a/tools/lib/bpf/libbpf.h
> > +++ b/tools/lib/bpf/libbpf.h
> > @@ -921,6 +921,31 @@ LIBBPF_API const void *bpf_map__initial_value(struct bpf_map *map, size_t *psize
> >  LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_map__type() instead")
> >  LIBBPF_API bool bpf_map__is_offload_neutral(const struct bpf_map *map);
> >
> > +/**
> > + * @brief **bpf_map__get_percpu_value()** returns a pointer to an array
> > + * of data stored in a per-cpu array or per-cpu hashmap at a specified
> > + * key. Each element is padded to 8 bytes regardless of the value data
> > + * type stored in the per-cpu map. The index of each element in the array
> > + * corresponds with the cpu that the data was set from.
> > + * @param map per-cpu array or per-cpu hashmap
> > + * @param key the key or index in the map
> > + * @return pointer to the array of data
> > + *
> > + * example usage:
> > + *
> > + *  values = bpf_map__get_percpu_value(bpfmap, (void*)&zero);
> > + *  if (values == NULL) {
> > + *     // error handling
> > + *  }
> > + *
> > + *     void* ptr = values;
> > + *  for (int i = 0; i < num_cpus; i++) {
> > + *    printf("CPU %d: %ld\n", i, *(ulong*)ptr);
> > + *    ptr += 8;
> > + *  }
> > + */
> > +LIBBPF_API void *bpf_map__get_percpu_value(const struct bpf_map *map, const void *key);
> > +
> >  /**
> >   * @brief **bpf_map__is_internal()** tells the caller whether or not the
> >   * passed map is a special map created by libbpf automatically for things like
> > --
> > 2.34.1
> >
