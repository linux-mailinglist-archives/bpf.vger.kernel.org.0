Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E924B5236C8
	for <lists+bpf@lfdr.de>; Wed, 11 May 2022 17:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245576AbiEKPMq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 May 2022 11:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245505AbiEKPMj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 May 2022 11:12:39 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30EC7A820
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 08:12:37 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id a30so2998954ljq.9
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 08:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8z498OBrO5TrJpyBP8Q3gKeEhSZ26vQ1Lzs9/gCf97Q=;
        b=FNLW5qV8Atgua0YkEbZQDW2UBmk3YRCnnkqyFVe3aGKCck2AHaL83EcikNnvN7rgLj
         2BPSCtytd38QvMAoQr1r4oxeRxWA8mfPDwCyb6FcprZ+dRYo3lFNjGSVsAVEizXoSfzP
         5GI6cLC5Op3LF82OaXtK8qaf1uSs8pK1jVvZHs1ct2CHb+WJ8k5T13oG2q37UWi2OKxp
         mbifD7cPhhEtirixUfLFx62H0iEmTgy3B6zeIhALNVbcL8GUKvw24kJa541NqayUW1sO
         owDvpOMIOP9wWyciR4Qm7bXhJ0B+R2fewddyqigfvwGfOHnVRUGkRgJco9OzeHgExUUO
         bB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8z498OBrO5TrJpyBP8Q3gKeEhSZ26vQ1Lzs9/gCf97Q=;
        b=kxhB+hHvkXh+B66YiuNt8V+ZAIy9oJZ0l8TDAcTIMupQ0Nn9NxVUy9NfFXy+IFBgKx
         VT8e6RGfExVp5ORL+YCt4xnPfvFnotm3nG8iTod0do4/jX7WyMJkzE4JQW1Obitmm73B
         qZsPhtD5BWqiILwc5gfRbs8C/HvaF4B76CzicVypkXTduxm0Z0qja834GbTWtSFQXYPR
         5ZX9xrWA8pRkUmrTWcTPl+RevbqaoBxZiGuqNsDapYUVGSCb9qETiouIaqg1MD2PlbRu
         0apwaFtokIaUW/DO1gRia8A+HLg/XkwJba+QGZbfh4dFtdx2t4SMjx4O2G3s3v71AEm9
         MtJQ==
X-Gm-Message-State: AOAM5326871CrGZEhgRak3+ayaQIPFGeZWdxDCoFZFB9REpUgWGLdZad
        SqGLkFosxhc9Fm3xxi4L02cHTJ0ol300deMrTtQ=
X-Google-Smtp-Source: ABdhPJxGfte01+1Vx7sDkd0zyG194Glnit8cZwlZVr3Ivz5WglRAvsZZgy3t3AkJ3luRgMEsBKp9zXJz8MktNLWLtLI=
X-Received: by 2002:a2e:944a:0:b0:24f:10bd:b7e8 with SMTP id
 o10-20020a2e944a000000b0024f10bdb7e8mr17372273ljh.238.1652281956023; Wed, 11
 May 2022 08:12:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220427214337.716372-1-grantseltzer@gmail.com>
 <CAEf4Bza4fW0v7gGO+57hwoHhhaPTeQjHPYKU5P_NzYTYdoxMdA@mail.gmail.com>
 <CAO658oW381jwCAe24uiySjqz+=XRpGfDSai+=opK=z6a2y5gUw@mail.gmail.com> <CAEf4BzYM7Uaaa=SvZvdzY4_XWmH-+T6rrao2w1cDA4z=G7Mj_g@mail.gmail.com>
In-Reply-To: <CAEf4BzYM7Uaaa=SvZvdzY4_XWmH-+T6rrao2w1cDA4z=G7Mj_g@mail.gmail.com>
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Wed, 11 May 2022 11:12:25 -0400
Message-ID: <CAO658oVY0jb-j-z7=YFPfPWdd5Tt8yT=YyA_NaOGqbewMdkj7w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] API function for retrieving data from percpu map
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 6, 2022 at 4:55 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Apr 27, 2022 at 7:55 PM Grant Seltzer Richman
> <grantseltzer@gmail.com> wrote:
> >
> > On Wed, Apr 27, 2022 at 6:16 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Wed, Apr 27, 2022 at 2:43 PM grantseltzer <grantseltzer@gmail.com> wrote:
> > > >
> > > > From: Grant Seltzer <grantseltzer@gmail.com>
> > > >
> > > > This adds a new API function used to retrieve all data from a
> > > > percpu array or percpu hashmap.
> > > >
> > > > This is useful because the current interface for doing so
> > > > requires knowledge of the layout of these BPF map internal
> > > > structures.
> > > >
> > > > Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
> > > > ---
> > > >  tools/lib/bpf/libbpf.c | 28 ++++++++++++++++++++++++++++
> > > >  tools/lib/bpf/libbpf.h | 25 +++++++++++++++++++++++++
> > > >  2 files changed, 53 insertions(+)
> > > >
> > > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > > index 873a29ce7781..8d72cff22688 100644
> > > > --- a/tools/lib/bpf/libbpf.c
> > > > +++ b/tools/lib/bpf/libbpf.c
> > > > @@ -36,6 +36,7 @@
> > > >  #include <linux/perf_event.h>
> > > >  #include <linux/ring_buffer.h>
> > > >  #include <linux/version.h>
> > > > +#include <linux/math.h>
> > > >  #include <sys/epoll.h>
> > > >  #include <sys/ioctl.h>
> > > >  #include <sys/mman.h>
> > > > @@ -4370,6 +4371,33 @@ int bpf_map__resize(struct bpf_map *map, __u32 max_entries)
> > > >         return bpf_map__set_max_entries(map, max_entries);
> > > >  }
> > > >
> > > > +void *bpf_map__get_percpu_value(const struct bpf_map *map, const void *key)
> > >
> > > I'd rather avoid API that allocates memory on behalf of user (and
> > > requires user to later free it) if possible. In this case there is no
> > > need for libbpf itself to allocate memory, user can allocate enough
> > > memory and pass it to libbpf.
> >
> > I see, this makes sense. I also considered defining a macro instead,
> > similar to `bpf_object__for_each_program`, except something like
> > `bpf_map__for_each_cpu`.
> >
> > >
> > > I'm actually working on few related APIs to avoid using low-level
> > > bpf_map_update_elem() from user-space. I want to add
> > > bpf_map__update_elem(), bpf_map__lookup_elem(),
> > > bpf_map__delete_elem(). It's TBD how it will look like for per-cpu
> > > maps, but I didn't plan to have a separate API for that. It would just
> > > change expectations of value size to be a value_size * num_cpus.
> >
> > Ah ok, you actually mentioned this to me once before, about modeling
> > the  API to accept key/value sizes and validate based on bpf_map's
> > definition. Please let me know if I can help with this, I'd be happy
> > to tackle it.
>
> It depends on whether you are planning to work on it soon. I'd like to
> get this into v0.8 in the next week or two. If you think you can
> actively work on it next week and iterate if necessary quickly, then
> yes, please go ahead. I have few other small things to wrap up besides
> this and this will free a bit of time for me.

Apologies for the delay, this slipped past my attention. I won't have
time to work on this quickly so you can work on it for now, i'll look
out for the patch!

>
> Basically, I was thinking to have an API like below:
>
> int bpf_map__lookup_elem(const struct bpf_map *map, const void *key,
> size_t key_sz, void *value, size_t value_sz);
>
> and checking 1) that map is created (fd >= 0) 2) and key_sz/value_sz
> match our knowledge of the map's definition, which for per-CPU maps
> would mean that value_sz is actual value_size *
> libbpf_num_possible_cpus().
>
> Similarly for other very popular operations on maps: update and
> delete. We can probably also add wrappers for BPF_MAP_GET_NEXT_KEY and
> LOOKUP_AND_DELETE_ELEM commands. I didn't plan to add batch operations
> yet, as they are much less popular, so didn't want to over do it.
>
> >
> >
> > >
> > > So stay tuned, hopefully very soon
> > >
> > > > +{
> > > > +
> > > > +       if (!(bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_ARRAY ||
> > > > +               bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_HASH)) {
> > > > +               return libbpf_err_ptr(-EINVAL);
> > > > +       }
> > > > +
> > > > +       int num_cpus;
> > > > +       __u32 value_size;
> > > > +       num_cpus = libbpf_num_possible_cpus();
> > > > +
> > > > +       if (num_cpus < 0)
> > > > +               return libbpf_err_ptr(-EBUSY);
> > > > +
> > > > +       value_size = bpf_map__value_size(map);
> > > > +
> > > > +       void *data = malloc(roundup(value_size, 8) * num_cpus);
> > > > +       int err = bpf_map_lookup_elem(map->fd, key, data);
> > > > +       if (err) {
> > > > +               free(data);
> > > > +               return libbpf_err_ptr(err);
> > > > +       }
> > > > +
> > > > +       return data;
> > > > +}
> > > > +
> > > >  static int
> > > >  bpf_object__probe_loading(struct bpf_object *obj)
> > > >  {
> > > > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > > > index cdbfee60ea3e..99b218702dfb 100644
> > > > --- a/tools/lib/bpf/libbpf.h
> > > > +++ b/tools/lib/bpf/libbpf.h
> > > > @@ -921,6 +921,31 @@ LIBBPF_API const void *bpf_map__initial_value(struct bpf_map *map, size_t *psize
> > > >  LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_map__type() instead")
> > > >  LIBBPF_API bool bpf_map__is_offload_neutral(const struct bpf_map *map);
> > > >
> > > > +/**
> > > > + * @brief **bpf_map__get_percpu_value()** returns a pointer to an array
> > > > + * of data stored in a per-cpu array or per-cpu hashmap at a specified
> > > > + * key. Each element is padded to 8 bytes regardless of the value data
> > > > + * type stored in the per-cpu map. The index of each element in the array
> > > > + * corresponds with the cpu that the data was set from.
> > > > + * @param map per-cpu array or per-cpu hashmap
> > > > + * @param key the key or index in the map
> > > > + * @return pointer to the array of data
> > > > + *
> > > > + * example usage:
> > > > + *
> > > > + *  values = bpf_map__get_percpu_value(bpfmap, (void*)&zero);
> > > > + *  if (values == NULL) {
> > > > + *     // error handling
> > > > + *  }
> > > > + *
> > > > + *     void* ptr = values;
> > > > + *  for (int i = 0; i < num_cpus; i++) {
> > > > + *    printf("CPU %d: %ld\n", i, *(ulong*)ptr);
> > > > + *    ptr += 8;
> > > > + *  }
> > > > + */
> > > > +LIBBPF_API void *bpf_map__get_percpu_value(const struct bpf_map *map, const void *key);
> > > > +
> > > >  /**
> > > >   * @brief **bpf_map__is_internal()** tells the caller whether or not the
> > > >   * passed map is a special map created by libbpf automatically for things like
> > > > --
> > > > 2.34.1
> > > >
