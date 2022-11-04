Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC6A61A351
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 22:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiKDV0t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 17:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKDV0s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 17:26:48 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D93643871;
        Fri,  4 Nov 2022 14:26:47 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id kt23so16481052ejc.7;
        Fri, 04 Nov 2022 14:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AveMACjXVbF/hxLVe9ZZR8krStFPyiZoSTVBDH05wjw=;
        b=cTOlGMMzZJR1iNQytevx/7l+waGuBR0MG5AnpaC85mR4CkNuOcs9TnL2yON8WE66c7
         Tsqt73xWDzTuSE91FhwGk4HvIdn/wqgCnKR5PHKaSCBRskr+qMtJY0mnL3bD+eJH1+hX
         2wkGRVGg55xPWfe+xfP0A68j+X2cnaUni57u6cj9IawCwZwrsLPR5OapHw9Sd1Ah/eS1
         sJjwnjwRCDH/KPafbFFDq/5/UULs/2VtykHfFacjU//3gQKYI3mZDXOPlKozG7nb/C52
         t3Ht5UlM7q9empPn2qPlDK99L+oj1l3a7oa3Rb5tQad4tiDzwGi1nrwe4JfHhUSUkks1
         zIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AveMACjXVbF/hxLVe9ZZR8krStFPyiZoSTVBDH05wjw=;
        b=VEHyOaUI0MspsFnmn5Ro0SgY0wnpdZVqaxqvtILl7Gz4suzvsAmab2KZJP2Bk+i2KE
         uhULi7Uh3s8GPxB2Fy7fIsb2ozNKvmQ/3h6G+IuKLzhlDOxQnjT/eo+hDh5//SnLcGjW
         oz+Y6S6JwGeXtsE919IhOEhzoulmR1DySaXj1i70sYtoGfcCMHKtrCY/FF9ZlA+B7/+J
         D/4Lf74ku5umAdM8GM+WlmktNgDBHJfPwOB9CCjwBRq0v7NEsMAyO4y3KPY2tIJRwVE3
         0tQXQ/9fBAg57c9W8bceRNgHq/P6DgDgtieuH6JMe5oOJJaUAVCTX0qzhRFnvKjSyh5F
         UdjA==
X-Gm-Message-State: ACrzQf1tSkpX7MWRx4jmg9eRjtSyBysife8IQV7aQAWCAAPxtPTymLhy
        RMlkzD7LUTDmiW8q4Z4PJSP4exe4W/eSINDnv1s=
X-Google-Smtp-Source: AMsMyM7Z1SD/98VyO1rZj5Skho54nfScaK7yrTH+svVpB2spa/fkUna6NMalV8wNaNZHqKh4KEQGJNB7iLZJ0LTHtR4=
X-Received: by 2002:a17:906:99c5:b0:73d:70c5:1a4f with SMTP id
 s5-20020a17090699c500b0073d70c51a4fmr35850607ejn.302.1667597205313; Fri, 04
 Nov 2022 14:26:45 -0700 (PDT)
MIME-Version: 1.0
References: <20221010112154.39494-1-donald.hunter@gmail.com>
In-Reply-To: <20221010112154.39494-1-donald.hunter@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 4 Nov 2022 14:26:33 -0700
Message-ID: <CAEf4BzYiSyps09esMH407WnzPvND+c56EQHeooLUF9RKcs-Y3Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] bpf, docs: document BPF_MAP_TYPE_ARRAY_OF_MAPS
 and *_HASH_OF_MAPS
To:     Donald Hunter <donald.hunter@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
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

On Mon, Oct 10, 2022 at 4:32 AM Donald Hunter <donald.hunter@gmail.com> wrote:
>
> Add documentation for the ARRAY_OF_MAPS and HASH_OF_MAPS map types,
> including usage and examples.
>
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---

subject suggestion (as it's pretty long):

bpf, docs: document BPF_MAP_TYPE_{ARRAY,HASH}_OF_MAPS


>  Documentation/bpf/map_of_maps.rst | 145 ++++++++++++++++++++++++++++++
>  1 file changed, 145 insertions(+)
>  create mode 100644 Documentation/bpf/map_of_maps.rst
>
> diff --git a/Documentation/bpf/map_of_maps.rst b/Documentation/bpf/map_of_maps.rst
> new file mode 100644
> index 000000000000..16fcda8720de
> --- /dev/null
> +++ b/Documentation/bpf/map_of_maps.rst
> @@ -0,0 +1,145 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +.. Copyright (C) 2022 Red Hat, Inc.
> +
> +========================================================
> +BPF_MAP_TYPE_ARRAY_OF_MAPS and BPF_MAP_TYPE_HASH_OF_MAPS
> +========================================================
> +
> +.. note::
> +   - ``BPF_MAP_TYPE_ARRAY_OF_MAPS`` and ``BPF_MAP_TYPE_HASH_OF_MAPS`` were
> +     introduced in kernel version 4.12.
> +
> +``BPF_MAP_TYPE_ARRAY_OF_MAPS`` and ``BPF_MAP_TYPE_HASH_OF_MAPS`` provide general
> +purpose support for map in map storage. One level of nesting is supported, where
> +an outer map contains instances of a single type of inner map, for example
> +``array_of_maps->sock_map``.
> +
> +When creating an outer map, an inner map instance is used to initialize the
> +metadata that the outer map holds about its inner maps. This inner map has a
> +separate lifetime from the outer map and can be deleted after the outer map has
> +been created.
> +
> +The outer map supports element update and delete from user space using the
> +syscall API. A BPF program is only allowed to do element lookup in the outer
> +map.
> +
> +.. note::
> +   - Multi-level nesting is not supported.
> +   - Any BPF map type can be used as an inner map, except for
> +     ``BPF_MAP_TYPE_PROG_ARRAY``.
> +   - A BPF program cannot update or delete outer map entries.
> +
> +Array of Maps
> +-------------
> +
> +For ``BPF_MAP_TYPE_ARRAY_OF_MAPS`` the key is an unsigned 32-bit integer index
> +into the array. The array is a fixed size with `max_entries` elements that are
> +zero initialized when created.
> +
> +Hash of Maps
> +------------
> +
> +For ``BPF_MAP_TYPE_HASH_OF_MAPS`` the key type can be chosen when defining the
> +map.
> +
> +The kernel is responsible for allocating and freeing key/value pairs, up
> +to the max_entries limit that you specify. Hash maps use pre-allocation
> +of hash table elements by default. The ``BPF_F_NO_PREALLOC`` flag can be
> +used to disable pre-allocation when it is too memory expensive.
> +
> +Usage
> +=====
> +
> +.. c:function::
> +   void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)
> +
> +Inner maps can be retrieved using the ``bpf_map_lookup_elem()`` helper. This
> +helper returns a pointer to the inner map, or ``NULL`` if no entry was found.
> +
> +Examples
> +========
> +
> +Kernel BPF
> +----------
> +
> +This snippet shows how to create an array of devmaps in a BPF program. Note that
> +the outer array can only be modified from user space using the syscall API.
> +
> +.. code-block:: c
> +
> +    struct redirect_map {
> +            __uint(type, BPF_MAP_TYPE_DEVMAP);
> +            __uint(max_entries, 32);
> +            __type(key, enum skb_drop_reason);
> +            __type(value, __u64);
> +    } redirect_map SEC(".maps");
> +
> +    struct {
> +            __uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
> +            __uint(max_entries, 2);
> +            __uint(key_size, sizeof(int));
> +            __uint(value_size, sizeof(int));
> +            __array(values, struct redirect_map);
> +    } outer_map SEC(".maps");
> +

Let's also demonstrate libbpf's declarative way to initialize entries
in outer map? See progs/test_btf_map_in_map.c under selftests/bpf for
various examples.

> +This snippet shows how to lookup an outer map to retrieve an inner map.
> +
> +.. code-block:: c
> +
> +    SEC("xdp")
> +    int redirect_by_priority(struct xdp_md *ctx) {
> +            struct bpf_map *devmap;
> +            int action = XDP_PASS;
> +            int index = 0;
> +
> +            devmap = bpf_map_lookup_elem(&outer_arr, &index);
> +            if (!devmap)
> +                    return XDP_PASS;
> +
> +            /* use inner devmap here */
> +
> +            return action;
> +    }
> +
> +User Space
> +----------
> +
> +This snippet shows how to create an array based outer map:
> +
> +.. code-block:: c
> +
> +    int create_outer_array(int inner_fd) {
> +            int fd;
> +            LIBBPF_OPTS(bpf_map_create_opts, opts);
> +            opts.inner_map_fd = inner_fd;

LIBBPF_OPTS(bpf_map_create_opts, opts, .inner_map_fd = inner_fd);

> +            fd = bpf_map_create(BPF_MAP_TYPE_ARRAY_OF_MAPS,
> +                                "example_array",       /* name */
> +                                sizeof(__u32),         /* key size */
> +                                sizeof(__u32),         /* value size */
> +                                256,                   /* max entries */
> +                                &opts);                /* create opts */
> +            return fd;
> +    }
> +
> +
> +This snippet shows how to add an inner map to an outer map:
> +
> +.. code-block:: c
> +
> +    int add_devmap(int outer_fd, int index, const char *name) {
> +            int fd, ret;
> +
> +            fd = bpf_map_create(BPF_MAP_TYPE_DEVMAP, name,
> +                                sizeof(__u32), sizeof(__u32), 256, NULL);
> +            if (fd < 0)
> +                    return fd;
> +
> +            ret = bpf_map_update_elem(outer_fd, &index, &fd, BPF_NOEXIST);
> +            return ret;
> +    }
> +
> +References
> +==========
> +
> +- https://lore.kernel.org/netdev/20170322170035.923581-3-kafai@fb.com/
> +- https://lore.kernel.org/netdev/20170322170035.923581-4-kafai@fb.com/
> --
> 2.35.1
>
