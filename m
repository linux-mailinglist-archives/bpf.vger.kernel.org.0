Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A044512529
	for <lists+bpf@lfdr.de>; Thu, 28 Apr 2022 00:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236555AbiD0WUR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Apr 2022 18:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiD0WUM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Apr 2022 18:20:12 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1130385960
        for <bpf@vger.kernel.org>; Wed, 27 Apr 2022 15:16:59 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id y16so855095ilc.7
        for <bpf@vger.kernel.org>; Wed, 27 Apr 2022 15:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7n73zzRDYYjJkLIG0X7GSKHL2BlEq1dy+iJeBCkW9KA=;
        b=kmuP/qOyMeyv3ixLqYPU3rBxqXRWiWyUSPvCD+2J/n4I6lOLNyXklk4W2q/CwuQ9/F
         nW0LYDSgx14fcVn+VNdZlW7rEc7eHR9YknLKjJ9zItBWb+JJ1hb2BGkG3QGf+b/hBsEm
         qDPl2dX/AfSw5Dz/wCNvpB3/ubZ1nRZY0WaDXP8I+DSUTrK28crcV+KcFWJLgbCnixG9
         m8gtnmw6rjHW895KKkAO42poAlL748bxAiIg2WmDZN14qTxOk0giznuskc3hjJvllBTW
         mMqWeWlDzUe4KR90hC1rVkadag4KZHTrY/QBonGIhxsIq/svutPArq8a7BOn11p+X94T
         TWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7n73zzRDYYjJkLIG0X7GSKHL2BlEq1dy+iJeBCkW9KA=;
        b=JxLrw2KBEAj6R9f0KrILDvdNpb/5zWbm/wY+gepr6azFGqMFbzLTpT2PJ192tBFNHJ
         77tOAozuZHFxkT3KuzpZD2pbkM2pHXJ3Bojej+Ey/gxxexvIHv1Y5AkMRSsdazaKABGz
         LqEsO12eoTRMenSwQKZlX1fvvnwXpJBVXDoyh3uYfpYclAfitTlxQaQzmzriVsvC3am0
         puQo01JQNxDXCGbJAWU8V/peaY+vfBCBFY4NI4UYrN7o04jyiSDWd1qVJjglvCz2E74q
         JyKibyTbyy2CjjNj6DIeOwxpihac/JX6MiF6ytITm0OordCOwT4S3ywViSbELSDfnOba
         f5sw==
X-Gm-Message-State: AOAM532qI8xUZIkzGmWomcD2JtcNzTj/KckVT0wgTu1+wFYCa74oKcJg
        mA2QPL8jzPo4cZNyvSQ5qAH/hOld4KWSMAllj38SPoKK7hA=
X-Google-Smtp-Source: ABdhPJx+bnt3Q4AkJACOvZNwVH78WgusE9FRrpo9V8KJP3l0/F3+TJLSyonY4TIKA9NIBpwCZCGIKDah9c+Q/2b1TJ8=
X-Received: by 2002:a92:c247:0:b0:2cc:1798:74fe with SMTP id
 k7-20020a92c247000000b002cc179874femr11932297ilo.239.1651097818123; Wed, 27
 Apr 2022 15:16:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220427214337.716372-1-grantseltzer@gmail.com>
In-Reply-To: <20220427214337.716372-1-grantseltzer@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 27 Apr 2022 15:16:47 -0700
Message-ID: <CAEf4Bza4fW0v7gGO+57hwoHhhaPTeQjHPYKU5P_NzYTYdoxMdA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] API function for retrieving data from percpu map
To:     grantseltzer <grantseltzer@gmail.com>
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

On Wed, Apr 27, 2022 at 2:43 PM grantseltzer <grantseltzer@gmail.com> wrote:
>
> From: Grant Seltzer <grantseltzer@gmail.com>
>
> This adds a new API function used to retrieve all data from a
> percpu array or percpu hashmap.
>
> This is useful because the current interface for doing so
> requires knowledge of the layout of these BPF map internal
> structures.
>
> Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 28 ++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.h | 25 +++++++++++++++++++++++++
>  2 files changed, 53 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 873a29ce7781..8d72cff22688 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -36,6 +36,7 @@
>  #include <linux/perf_event.h>
>  #include <linux/ring_buffer.h>
>  #include <linux/version.h>
> +#include <linux/math.h>
>  #include <sys/epoll.h>
>  #include <sys/ioctl.h>
>  #include <sys/mman.h>
> @@ -4370,6 +4371,33 @@ int bpf_map__resize(struct bpf_map *map, __u32 max_entries)
>         return bpf_map__set_max_entries(map, max_entries);
>  }
>
> +void *bpf_map__get_percpu_value(const struct bpf_map *map, const void *key)

I'd rather avoid API that allocates memory on behalf of user (and
requires user to later free it) if possible. In this case there is no
need for libbpf itself to allocate memory, user can allocate enough
memory and pass it to libbpf.

I'm actually working on few related APIs to avoid using low-level
bpf_map_update_elem() from user-space. I want to add
bpf_map__update_elem(), bpf_map__lookup_elem(),
bpf_map__delete_elem(). It's TBD how it will look like for per-cpu
maps, but I didn't plan to have a separate API for that. It would just
change expectations of value size to be a value_size * num_cpus.

So stay tuned, hopefully very soon

> +{
> +
> +       if (!(bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_ARRAY ||
> +               bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_HASH)) {
> +               return libbpf_err_ptr(-EINVAL);
> +       }
> +
> +       int num_cpus;
> +       __u32 value_size;
> +       num_cpus = libbpf_num_possible_cpus();
> +
> +       if (num_cpus < 0)
> +               return libbpf_err_ptr(-EBUSY);
> +
> +       value_size = bpf_map__value_size(map);
> +
> +       void *data = malloc(roundup(value_size, 8) * num_cpus);
> +       int err = bpf_map_lookup_elem(map->fd, key, data);
> +       if (err) {
> +               free(data);
> +               return libbpf_err_ptr(err);
> +       }
> +
> +       return data;
> +}
> +
>  static int
>  bpf_object__probe_loading(struct bpf_object *obj)
>  {
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index cdbfee60ea3e..99b218702dfb 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -921,6 +921,31 @@ LIBBPF_API const void *bpf_map__initial_value(struct bpf_map *map, size_t *psize
>  LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_map__type() instead")
>  LIBBPF_API bool bpf_map__is_offload_neutral(const struct bpf_map *map);
>
> +/**
> + * @brief **bpf_map__get_percpu_value()** returns a pointer to an array
> + * of data stored in a per-cpu array or per-cpu hashmap at a specified
> + * key. Each element is padded to 8 bytes regardless of the value data
> + * type stored in the per-cpu map. The index of each element in the array
> + * corresponds with the cpu that the data was set from.
> + * @param map per-cpu array or per-cpu hashmap
> + * @param key the key or index in the map
> + * @return pointer to the array of data
> + *
> + * example usage:
> + *
> + *  values = bpf_map__get_percpu_value(bpfmap, (void*)&zero);
> + *  if (values == NULL) {
> + *     // error handling
> + *  }
> + *
> + *     void* ptr = values;
> + *  for (int i = 0; i < num_cpus; i++) {
> + *    printf("CPU %d: %ld\n", i, *(ulong*)ptr);
> + *    ptr += 8;
> + *  }
> + */
> +LIBBPF_API void *bpf_map__get_percpu_value(const struct bpf_map *map, const void *key);
> +
>  /**
>   * @brief **bpf_map__is_internal()** tells the caller whether or not the
>   * passed map is a special map created by libbpf automatically for things like
> --
> 2.34.1
>
