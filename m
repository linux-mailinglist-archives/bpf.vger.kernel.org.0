Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C8E5F6546
	for <lists+bpf@lfdr.de>; Thu,  6 Oct 2022 13:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiJFLgP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Oct 2022 07:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJFLgN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Oct 2022 07:36:13 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507045282D;
        Thu,  6 Oct 2022 04:36:12 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n16-20020a05600c4f9000b003c17bf8ddecso711004wmq.0;
        Thu, 06 Oct 2022 04:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mwciIo6Ry2Cya/l03AQ6o1jw0A+99nJemZuXprUYpuo=;
        b=euZS0y2Aw01ogwNqhOhcOe1dkUcmIj6T71sLwWIByMU26QJ0iswEQUEnr4yCIC7mck
         GpQjEVId1bkihVg4MGs+37fgSDzT7Awv9vl34GB3zZWh3Og2mayCN4RefGzwV18MUXXx
         pvxGh0fNiP6rV5CdLNxJ4S9CTrl8+ZYCVtML19Y/U7WRU+0LmRryEnwDja5uT6sF8rEJ
         BJkeSWcoB/3Pfnsj72UDVgIb8WcgJiiwOEE6aso+lkeWbiEgbvSDDwn0BYN7lXVV3A6O
         hzs0Kc+EWdWMA0nNLoWKUwRV4YHYDqIy0fx6ZuI041t5laMXMYTzzS84fN+4uDeXSaBY
         KGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwciIo6Ry2Cya/l03AQ6o1jw0A+99nJemZuXprUYpuo=;
        b=0z0jYXP0pz4em8Fs/Cre+JjAR3VAe9jA/cLSsMwlIftgXUMlda+5WgjJlFqkP15p2X
         k7e81gcttt+S1tPFchj1YVkTy0fp1Ie6rE9EXVQphNlQ4mq2L3OdaPJ2+7Gh4IFvNMMP
         zjwvjEaUxUkDE+HsGVSEzvzwEGhmxP03aOKjVrL7lzKMxHbMJj36sTdT4ZQM+f/tBjQA
         Z/bVQJKjvqzi7xV7GNpnywsRva/UARfSSsb4Ndu2fis9A8KdshwVH9JKewqp32BWb6yu
         FkVjbJ0tcvz7ULZEMfijU4MBUj6JBvuIAww96Dtuiqd8hodrOP/7nZTVbsQC9RamTK85
         l9xw==
X-Gm-Message-State: ACrzQf05PRxG6k8oH+IX6KMX4lusYDzP1HgGR35vEvqeQ15zR6kC+ZRX
        hN63JqZaihJenoCPSGDjmG0=
X-Google-Smtp-Source: AMsMyM62KUU9z2YZQUgaOaKSj/JAf52c3Y/BgZh4aAslt558hwpuVZKDlr+paQWteiVLKDnml9Rzxw==
X-Received: by 2002:a05:600c:34d6:b0:3b4:91fd:cfc with SMTP id d22-20020a05600c34d600b003b491fd0cfcmr6542645wmq.1.1665056170723;
        Thu, 06 Oct 2022 04:36:10 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id k9-20020a7bc309000000b003b47a99d928sm4569044wmj.18.2022.10.06.04.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 04:36:10 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 6 Oct 2022 13:36:09 +0200
To:     Donald Hunter <donald.hunter@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org, dave@dtucker.co.uk,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH bpf-next v6 1/1] bpf, docs: document BPF_MAP_TYPE_ARRAY
Message-ID: <Yz69qfI7ZkJPrUt7@krava>
References: <20221005104634.66406-1-donald.hunter@gmail.com>
 <20221005104634.66406-2-donald.hunter@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005104634.66406-2-donald.hunter@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 05, 2022 at 11:46:34AM +0100, Donald Hunter wrote:
> From: Dave Tucker <dave@dtucker.co.uk>
> 
> Add documentation for the BPF_MAP_TYPE_ARRAY including kernel version
> introduced, usage and examples. Also document BPF_MAP_TYPE_PERCPU_ARRAY
> which is similar.
> 
> Signed-off-by: Dave Tucker <dave@dtucker.co.uk>
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---
>  Documentation/bpf/map_array.rst | 231 ++++++++++++++++++++++++++++++++
>  1 file changed, 231 insertions(+)
>  create mode 100644 Documentation/bpf/map_array.rst
> 
> diff --git a/Documentation/bpf/map_array.rst b/Documentation/bpf/map_array.rst
> new file mode 100644
> index 000000000000..9d2da884c41e
> --- /dev/null
> +++ b/Documentation/bpf/map_array.rst
> @@ -0,0 +1,231 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +.. Copyright (C) 2022 Red Hat, Inc.
> +
> +================================================
> +BPF_MAP_TYPE_ARRAY and BPF_MAP_TYPE_PERCPU_ARRAY
> +================================================
> +
> +.. note::
> +   - ``BPF_MAP_TYPE_ARRAY`` was introduced in kernel version 3.19
> +   - ``BPF_MAP_TYPE_PERCPU_ARRAY`` was introduced in version 4.6
> +
> +``BPF_MAP_TYPE_ARRAY`` and ``BPF_MAP_TYPE_PERCPU_ARRAY`` provide generic array
> +storage. The key type is an unsigned 32-bit integer (4 bytes) and the map is of
> +constant size. All array elements are pre-allocated and zero initialized when
> +created. ``BPF_MAP_TYPE_PERCPU_ARRAY`` uses a different memory region for each
> +CPU whereas ``BPF_MAP_TYPE_ARRAY`` uses the same memory region. The maximum
> +size of an array, defined in max_entries, is limited to 2^32. The value stored
> +can be of any size, however, small values will be rounded up to 8 bytes.

I recently hit 32k size limit for per-cpu map value.. it seems to be
size limit for generic per cpu allocation, but would be great to have
it confirmed by somebody who knows mm better ;-)

jirka

> +
> +Since kernel 5.5, memory mapping may be enabled for ``BPF_MAP_TYPE_ARRAY`` by
> +setting the flag ``BPF_F_MMAPABLE``. The map definition is page-aligned and
> +starts on the first page. Sufficient page-sized and page-aligned blocks of
> +memory are allocated to store all array values, starting on the second page,
> +which in some cases will result in over-allocation of memory. The benefit of
> +using this is increased performance and ease of use since userspace programs
> +would not be required to use helper functions to access and mutate data.
> +
> +Usage
> +=====
> +
> +.. c:function::
> +   void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)
> +
> +Array elements can be retrieved using the ``bpf_map_lookup_elem()`` helper.
> +This helper returns a pointer into the array element, so to avoid data races
> +with userspace reading the value, the user must use primitives like
> +``__sync_fetch_and_add()`` when updating the value in-place. Access from
> +userspace uses the libbpf API of the same name.
> +
> +.. c:function::
> +   long bpf_map_update_elem(struct bpf_map *map, const void *key, const void *value, u64 flags)
> +
> +Array elements can also be added using the ``bpf_map_update_elem()`` helper or
> +libbpf API.
> +
> +``bpf_map_update_elem()`` returns 0 on success, or negative error in case of
> +failure.
> +
> +Since the array is of constant size, ``bpf_map_delete_elem()`` is not supported.
> +To clear an array element, you may use ``bpf_map_update_elem()`` to insert a
> +zero value to that index.
> +
> +Per CPU Array
> +-------------
> +
> +Values stored in ``BPF_MAP_TYPE_ARRAY`` can be accessed by multiple programs
> +across different CPUs. To restrict storage to a single CPU, you may use a
> +``BPF_MAP_TYPE_PERCPU_ARRAY``.
> +
> +When using a ``BPF_MAP_TYPE_PERCPU_ARRAY`` the ``bpf_map_update_elem()`` and
> +``bpf_map_lookup_elem()`` helpers automatically access the hash slot for the
> +current CPU.
> +
> +.. c:function::
> +   void *bpf_map_lookup_percpu_elem(struct bpf_map *map, const void *key, u32 cpu)
> +
> +The ``bpf_map_lookup_percpu_elem()`` helper can be used to lookup the array
> +value for a specific CPU. Returns value on success , or ``NULL`` if no entry was
> +found or ``cpu`` is invalid.
> +
> +Concurrency
> +-----------
> +
> +Since kernel version 5.1, the BPF infrastructure provides ``struct bpf_spin_lock``
> +to synchronize access.
> +
> +Examples
> +========
> +
> +Please see the ``tools/testing/selftests/bpf`` directory for functional
> +examples. The code samples below demonstrate API usage.
> +
> +Kernel BPF
> +----------
> +
> +This snippet shows how to declare an array in a BPF program.
> +
> +.. code-block:: c
> +
> +    struct {
> +            __uint(type, BPF_MAP_TYPE_ARRAY);
> +            __type(key, u32);
> +            __type(value, long);
> +            __uint(max_entries, 256);
> +    } my_map SEC(".maps");
> +
> +
> +This example BPF program shows how to access an array element.
> +
> +.. code-block:: c
> +
> +    int bpf_prog(struct __sk_buff *skb)
> +    {
> +            int index = load_byte(skb,
> +                                  ETH_HLEN + offsetof(struct iphdr, protocol));
> +            long *value;
> +
> +            if (skb->pkt_type != PACKET_OUTGOING)
> +                    return 0;
> +
> +            value = bpf_map_lookup_elem(&my_map, &index);
> +            if (value)
> +                    __sync_fetch_and_add(value, skb->len);
> +
> +            return 0;
> +    }
> +
> +Userspace
> +---------
> +
> +BPF_MAP_TYPE_ARRAY
> +~~~~~~~~~~~~~~~~~~
> +
> +This snippet shows how to create an array, using ``bpf_map_create_opts`` to
> +set flags.
> +
> +.. code-block:: c
> +
> +    #include <bpf/libbpf.h>
> +    #include <bpf/bpf.h>
> +
> +    int create_array() {
> +            int fd;
> +            LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = BPF_F_MMAPABLE);
> +            fd = bpf_map_create(BPF_MAP_TYPE_ARRAY,
> +                                "example_array",       /* name */
> +                                sizeof(__u32),         /* key size */
> +                                sizeof(long),          /* value size */
> +                                256,                   /* max entries */
> +                                &opts);                /* create opts */
> +            return fd;
> +    }
> +
> +This snippet shows how to initialize the elements of an array.
> +
> +.. code-block:: c
> +
> +    int initialize_array(int fd) {
> +            __u32 i;
> +            long value;
> +            int ret;
> +
> +            for (i = 0; i < 256; i++) {
> +                    value = i;
> +                    ret = bpf_map_update_elem(fd, &i, &value, BPF_ANY);
> +                    if (ret < 0)
> +                            return ret;
> +            }
> +
> +            return ret;
> +    }
> +
> +This snippet shows how to retrieve an element value from an array.
> +
> +.. code-block:: c
> +
> +    int lookup(int fd) {
> +            __u32 index = 42;
> +            long value;
> +            int ret = bpf_map_lookup_elem(fd, &index, &value);
> +            if (ret < 0)
> +                    return ret;
> +
> +            /* use value here */
> +            assert(value == 42);
> +
> +            return ret;
> +    }
> +
> +BPF_MAP_TYPE_PERCPU_ARRAY
> +~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +This snippet shows how to initialize the elements of a per CPU array.
> +
> +.. code-block:: c
> +
> +    int initialize_array(int fd) {
> +            int ncpus = libbpf_num_possible_cpus();
> +            long values[ncpus];
> +            __u32 i, j;
> +            int ret;
> +
> +            for (i = 0; i < 256 ; i++) {
> +                    for (j = 0; j < ncpus; j++)
> +                            values[j] = i;
> +                    ret = bpf_map_update_elem(fd, &i, &values, BPF_ANY);
> +                    if (ret < 0)
> +                            return ret;
> +            }
> +
> +            return ret;
> +    }
> +
> +This snippet shows how to access the per CPU elements of an array value.
> +
> +.. code-block:: c
> +
> +    int lookup(int fd) {
> +            int ncpus = libbpf_num_possible_cpus();
> +            __u32 index = 42, j;
> +            long values[ncpus];
> +            int ret = bpf_map_lookup_elem(fd, &index, &values);
> +            if (ret < 0)
> +                    return ret;
> +
> +            for (j = 0; j < ncpus; j++) {
> +                    /* Use per CPU value here */
> +                    assert(values[j] == 42);
> +            }
> +
> +            return ret;
> +    }
> +
> +Semantics
> +=========
> +
> +As shown in the example above, when accessing a ``BPF_MAP_TYPE_PERCPU_ARRAY``
> +in userspace, each value is an array with ``ncpus`` elements.
> +
> +When calling ``bpf_map_update_elem()`` the flag ``BPF_NOEXIST`` can not be used
> +for these maps.
> -- 
> 2.35.1
> 
