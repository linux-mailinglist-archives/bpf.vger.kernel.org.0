Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A44E51E06E
	for <lists+bpf@lfdr.de>; Fri,  6 May 2022 22:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346231AbiEFU71 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 May 2022 16:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443962AbiEFU7Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 May 2022 16:59:25 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6301B65A4
        for <bpf@vger.kernel.org>; Fri,  6 May 2022 13:55:40 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id n6so3639934ili.7
        for <bpf@vger.kernel.org>; Fri, 06 May 2022 13:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gSOjD5AkSdCSj3BP1gsriSDmnCRdW+lKnRIbG1nEGjc=;
        b=oIX9ryDr9DeqXUYh1uI4YETeFk/O+uu9H71Oi/gdpzlqHKENDLiZxNaib6od/2VRWL
         JGOry9IohYDerhygzYyXurpW+2TXX5aP59PFYYCOfVipn1mkDPKhJsBicsmh4LsIopaD
         oJAOUcE9fQ5ZKK3S8+DM3g5n/SOEmvP+3/DbqBLoxShRk60Ry8LDuYClgTf2sr1oeA4n
         9g0aCM5LI2zYmUF2bZP7kCZS560blvlP7e4FkaNqMtp3u5BMqw1ePJcYmB1IiIBQ5Bcn
         2/sgfR+hfBqsxIB78kSxaylJrh+XehrdqXB7Na6A6B2P43TO9N+GORYcHm8pDjlqLdo/
         BRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gSOjD5AkSdCSj3BP1gsriSDmnCRdW+lKnRIbG1nEGjc=;
        b=txhrgEoPWS0ZFhcV+aadnMHqHh3QXRqpnFFX46aj6auzh0Sw3sE6C+xs5rrEjKtbQj
         DvzbPIhqQFztqBIem9lyr/04QvsGhOGPfc2Gf4A3wcgZpB9lDtoW1SGYsu0m/c4crN0d
         Sl/Olb+42a2S6jeIW+/taIe2cdJ/Xb0HlnqNiOztJM+EjSUa5dQ8cQV9QjNE5WF8FLWH
         XU4+3x2IuoKzyVf3Wn3+20YFYaHvZA0g6+3oAbyZ1lLX4tJZ29cpgFyLwgWsdjyooBar
         3OQJj1l8B4iWffxDGI1wOivRifrNoxp+uZCrRlowhRiQwrNQa9ajkWGE54EUN1QlXqEY
         fYHA==
X-Gm-Message-State: AOAM531sjBY+jMZrtT5XcDo1zXgMJLfoRlvq5dpp6kSM5HtVr74c4ud3
        riC6NWLb1nEM+qgBDQ6qyC3zIUVlG+wi+5xP6lg=
X-Google-Smtp-Source: ABdhPJxSS37JZh0Iz4AW/McwhmXG/tbQpqum484Ob+Mlac+CeF0xLB4e2tI7TFng+f2ctSl5qabey0JBneaQx/ynrSc=
X-Received: by 2002:a05:6e02:1d8d:b0:2cf:2112:2267 with SMTP id
 h13-20020a056e021d8d00b002cf21122267mr1973534ila.239.1651870539647; Fri, 06
 May 2022 13:55:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220427214337.716372-1-grantseltzer@gmail.com>
 <CAEf4Bza4fW0v7gGO+57hwoHhhaPTeQjHPYKU5P_NzYTYdoxMdA@mail.gmail.com> <CAO658oW381jwCAe24uiySjqz+=XRpGfDSai+=opK=z6a2y5gUw@mail.gmail.com>
In-Reply-To: <CAO658oW381jwCAe24uiySjqz+=XRpGfDSai+=opK=z6a2y5gUw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 6 May 2022 13:55:28 -0700
Message-ID: <CAEf4BzYM7Uaaa=SvZvdzY4_XWmH-+T6rrao2w1cDA4z=G7Mj_g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] API function for retrieving data from percpu map
To:     Grant Seltzer Richman <grantseltzer@gmail.com>
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

On Wed, Apr 27, 2022 at 7:55 PM Grant Seltzer Richman
<grantseltzer@gmail.com> wrote:
>
> On Wed, Apr 27, 2022 at 6:16 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Apr 27, 2022 at 2:43 PM grantseltzer <grantseltzer@gmail.com> wrote:
> > >
> > > From: Grant Seltzer <grantseltzer@gmail.com>
> > >
> > > This adds a new API function used to retrieve all data from a
> > > percpu array or percpu hashmap.
> > >
> > > This is useful because the current interface for doing so
> > > requires knowledge of the layout of these BPF map internal
> > > structures.
> > >
> > > Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
> > > ---
> > >  tools/lib/bpf/libbpf.c | 28 ++++++++++++++++++++++++++++
> > >  tools/lib/bpf/libbpf.h | 25 +++++++++++++++++++++++++
> > >  2 files changed, 53 insertions(+)
> > >
> > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > index 873a29ce7781..8d72cff22688 100644
> > > --- a/tools/lib/bpf/libbpf.c
> > > +++ b/tools/lib/bpf/libbpf.c
> > > @@ -36,6 +36,7 @@
> > >  #include <linux/perf_event.h>
> > >  #include <linux/ring_buffer.h>
> > >  #include <linux/version.h>
> > > +#include <linux/math.h>
> > >  #include <sys/epoll.h>
> > >  #include <sys/ioctl.h>
> > >  #include <sys/mman.h>
> > > @@ -4370,6 +4371,33 @@ int bpf_map__resize(struct bpf_map *map, __u32 max_entries)
> > >         return bpf_map__set_max_entries(map, max_entries);
> > >  }
> > >
> > > +void *bpf_map__get_percpu_value(const struct bpf_map *map, const void *key)
> >
> > I'd rather avoid API that allocates memory on behalf of user (and
> > requires user to later free it) if possible. In this case there is no
> > need for libbpf itself to allocate memory, user can allocate enough
> > memory and pass it to libbpf.
>
> I see, this makes sense. I also considered defining a macro instead,
> similar to `bpf_object__for_each_program`, except something like
> `bpf_map__for_each_cpu`.
>
> >
> > I'm actually working on few related APIs to avoid using low-level
> > bpf_map_update_elem() from user-space. I want to add
> > bpf_map__update_elem(), bpf_map__lookup_elem(),
> > bpf_map__delete_elem(). It's TBD how it will look like for per-cpu
> > maps, but I didn't plan to have a separate API for that. It would just
> > change expectations of value size to be a value_size * num_cpus.
>
> Ah ok, you actually mentioned this to me once before, about modeling
> the  API to accept key/value sizes and validate based on bpf_map's
> definition. Please let me know if I can help with this, I'd be happy
> to tackle it.

It depends on whether you are planning to work on it soon. I'd like to
get this into v0.8 in the next week or two. If you think you can
actively work on it next week and iterate if necessary quickly, then
yes, please go ahead. I have few other small things to wrap up besides
this and this will free a bit of time for me.

Basically, I was thinking to have an API like below:

int bpf_map__lookup_elem(const struct bpf_map *map, const void *key,
size_t key_sz, void *value, size_t value_sz);

and checking 1) that map is created (fd >= 0) 2) and key_sz/value_sz
match our knowledge of the map's definition, which for per-CPU maps
would mean that value_sz is actual value_size *
libbpf_num_possible_cpus().

Similarly for other very popular operations on maps: update and
delete. We can probably also add wrappers for BPF_MAP_GET_NEXT_KEY and
LOOKUP_AND_DELETE_ELEM commands. I didn't plan to add batch operations
yet, as they are much less popular, so didn't want to over do it.

>
>
> >
> > So stay tuned, hopefully very soon
> >
> > > +{
> > > +
> > > +       if (!(bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_ARRAY ||
> > > +               bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_HASH)) {
> > > +               return libbpf_err_ptr(-EINVAL);
> > > +       }
> > > +
> > > +       int num_cpus;
> > > +       __u32 value_size;
> > > +       num_cpus = libbpf_num_possible_cpus();
> > > +
> > > +       if (num_cpus < 0)
> > > +               return libbpf_err_ptr(-EBUSY);
> > > +
> > > +       value_size = bpf_map__value_size(map);
> > > +
> > > +       void *data = malloc(roundup(value_size, 8) * num_cpus);
> > > +       int err = bpf_map_lookup_elem(map->fd, key, data);
> > > +       if (err) {
> > > +               free(data);
> > > +               return libbpf_err_ptr(err);
> > > +       }
> > > +
> > > +       return data;
> > > +}
> > > +
> > >  static int
> > >  bpf_object__probe_loading(struct bpf_object *obj)
> > >  {
> > > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > > index cdbfee60ea3e..99b218702dfb 100644
> > > --- a/tools/lib/bpf/libbpf.h
> > > +++ b/tools/lib/bpf/libbpf.h
> > > @@ -921,6 +921,31 @@ LIBBPF_API const void *bpf_map__initial_value(struct bpf_map *map, size_t *psize
> > >  LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_map__type() instead")
> > >  LIBBPF_API bool bpf_map__is_offload_neutral(const struct bpf_map *map);
> > >
> > > +/**
> > > + * @brief **bpf_map__get_percpu_value()** returns a pointer to an array
> > > + * of data stored in a per-cpu array or per-cpu hashmap at a specified
> > > + * key. Each element is padded to 8 bytes regardless of the value data
> > > + * type stored in the per-cpu map. The index of each element in the array
> > > + * corresponds with the cpu that the data was set from.
> > > + * @param map per-cpu array or per-cpu hashmap
> > > + * @param key the key or index in the map
> > > + * @return pointer to the array of data
> > > + *
> > > + * example usage:
> > > + *
> > > + *  values = bpf_map__get_percpu_value(bpfmap, (void*)&zero);
> > > + *  if (values == NULL) {
> > > + *     // error handling
> > > + *  }
> > > + *
> > > + *     void* ptr = values;
> > > + *  for (int i = 0; i < num_cpus; i++) {
> > > + *    printf("CPU %d: %ld\n", i, *(ulong*)ptr);
> > > + *    ptr += 8;
> > > + *  }
> > > + */
> > > +LIBBPF_API void *bpf_map__get_percpu_value(const struct bpf_map *map, const void *key);
> > > +
> > >  /**
> > >   * @brief **bpf_map__is_internal()** tells the caller whether or not the
> > >   * passed map is a special map created by libbpf automatically for things like
> > > --
> > > 2.34.1
> > >
