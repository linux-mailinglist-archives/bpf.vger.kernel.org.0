Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96795FB4C2
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 16:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiJKOkP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Oct 2022 10:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiJKOkM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Oct 2022 10:40:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA99165A0
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 07:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665499206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uZ3v4pjnJDIojWEqppu2PN3XNMeuVy2PS0+WLzDvoJY=;
        b=BxCv5HNkNIW+PcXBhWj2hH1Y9Lvt3vqw2F345EmPX8TCnmMumuGu4K+2olNFX/N8kLA8dI
        lpVb5eC3TGQOZdVOheRYoKJD/imvalvqS2kldEVWnfFKCX4zYwxcGx+e6xvRq4QQQbA2e6
        d06iVHU7pMxBzioZotwYhZZAoEgOw9A=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-607-UARhf-VhObSgwIHCE6Hp6Q-1; Tue, 11 Oct 2022 10:40:05 -0400
X-MC-Unique: UARhf-VhObSgwIHCE6Hp6Q-1
Received: by mail-ed1-f70.google.com with SMTP id t19-20020a056402525300b00459546fd250so11525992edd.23
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 07:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uZ3v4pjnJDIojWEqppu2PN3XNMeuVy2PS0+WLzDvoJY=;
        b=iwlnsZ2W/oIwkH5z1hrtIAnO6yk91z9i/QaOsRe/fpmooZpb4z3ZL2yxe16/XQaiQ4
         Fc05gb7PTSsq88bcYh49zkCtpKAASs9g6mWsm0NKPeL0Tozp2syvAwY2hm9HIBZvEI1U
         pLZMF1/Ne839Sg7hZg8qeymuMDrHI7dT/KUvnwk15vXHKwTpvEQqWQi3YxLU0Xn5CNeb
         AEPK54gxp17az7L1YTMJh8Nt7e+Sx0RtmM4NC6DHoF3j+NOn0DralF79cIxxzC42qjk0
         VNE5aDUglaWSmSV+bj4tl6oLuo4tyZTNtOHvfsacMqBMluEIrA7L3ThQFckpZ5WD8ySv
         GwVQ==
X-Gm-Message-State: ACrzQf2IptRW3vbm4cdPMqx//5P/vM56wZu6pSC8rD2VwA+qPkdUUhX2
        iG4n/OBwrU+Zdwj2ffqgZWnjfZaATRefRdGiLR2rs0aW2iL9r2xEf3GFnQ2zWKDbR8eKHY3/MpY
        wqGYa3T9xp5NR
X-Received: by 2002:a17:906:5d0f:b0:78d:1bed:890f with SMTP id g15-20020a1709065d0f00b0078d1bed890fmr19408340ejt.594.1665499203391;
        Tue, 11 Oct 2022 07:40:03 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7F2pHhFMErZLqiL3W/dHKt2lypGiwTU6kTF0fZvUbidfvcUAgdSzaTi516qR3wQRBC7ixilA==
X-Received: by 2002:a17:906:5d0f:b0:78d:1bed:890f with SMTP id g15-20020a1709065d0f00b0078d1bed890fmr19408271ejt.594.1665499202266;
        Tue, 11 Oct 2022 07:40:02 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id dn22-20020a05640222f600b00451319a43dasm9451073edb.2.2022.10.11.07.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 07:40:01 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 7808A682D16; Tue, 11 Oct 2022 16:40:00 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     mtahhan@redhat.com, bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Maryam Tahhan <mtahhan@redhat.com>
Subject: Re: [PATCH v1 1/1] doc: BPF_MAP_TYPE_DEVMAP, BPF_MAP_TYPE_DEVMAP_HASH
In-Reply-To: <20221011090846.752622-2-mtahhan@redhat.com>
References: <20221011090846.752622-1-mtahhan@redhat.com>
 <20221011090846.752622-2-mtahhan@redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 11 Oct 2022 16:40:00 +0200
Message-ID: <878rlmqv9b.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

mtahhan@redhat.com writes:

> From: Maryam Tahhan <mtahhan@redhat.com>
>
> Add documentation for BPF_MAP_TYPE_DEVMAP and
> BPF_MAP_TYPE_DEVMAP_HASH including kernel version
> introduced, usage and examples.

Thanks for doing this! Some comments below.

>
> Signed-off-by: Maryam Tahhan <mtahhan@redhat.com>
> ---
>  Documentation/bpf/map_devmap.rst | 231 +++++++++++++++++++++++++++++++
>  1 file changed, 231 insertions(+)
>  create mode 100644 Documentation/bpf/map_devmap.rst
>
> diff --git a/Documentation/bpf/map_devmap.rst b/Documentation/bpf/map_devmap.rst
> new file mode 100644
> index 000000000000..ecd2b7b951cc
> --- /dev/null
> +++ b/Documentation/bpf/map_devmap.rst
> @@ -0,0 +1,231 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +.. Copyright (C) 2022 Red Hat, Inc.
> +
> +=================================================
> +BPF_MAP_TYPE_DEVMAP and BPF_MAP_TYPE_DEVMAP_HASH
> +=================================================
> +
> +.. note::
> +   - ``BPF_MAP_TYPE_DEVMAP`` was introduced in kernel version 4.14
> +   - ``BPF_MAP_TYPE_DEVMAP_HASH`` was introduced in kernel version 5.4
> +
> +``BPF_MAP_TYPE_DEVMAP`` is a BPF map, primarily used as a backend map for the XDP
> +BPF helper call ``bpf_redirect_map()``. It's backed by an array that uses the key as
> +the index to lookup a reference to a net device. The user provides <``key``/ ``ifindex``>
> +pairs to update the map with new net devices.

The TYPE_DEVMAP also takes the bpf_devmap_val struct as its value, not
just key/ifindex (as is indeed also noted below). Maybe it's better to
just collapse the description of the two into one paragraph noting that
they only differ in the "sparseness" of keys?

> +``BPF_MAP_TYPE_DEVMAP_HASH`` is also a backend map for ``bpf_redirect_map()``.
> +It's backed by a hash table that uses the ``ifindex`` as the key to lookup a reference
> +to a net device. As it's a hash map, it allows for densely packing the net devices
> +(compared with the sparsely packed ``BPF_MAP_TYPE_DEVMAP``).

Should we note that the packing comes at the cost of a hash of the key
when looking up?

> The user provides
> +<``key``/ ``struct bpf_devmap_val``> pairs to update the map with new net devices.
> +
> +The setup and packet enqueue/send code is shared between the two types of
> +devmap; only the lookup and insertion is different.
> +
> +XDP_REDIRECT
> +============
> +
> +XDP_REDIRECT works by a three-step process, implemented as follows:
> +
> +1. The ``bpf_redirect()`` and ``bpf_redirect_map()`` helpers will lookup the
> +   target of the redirect and store it (along with some other metadata) in a
> +   per-CPU ``struct bpf_redirect_info``. This is where the maps above come into
> +   play.
> +
> +2. When the program returns the ``XDP_REDIRECT`` return code, the driver will
> +   call ``xdp_do_redirect()`` which will use the information in ``struct
> +   bpf_redirect_info`` to actually enqueue the frame into a map type-specific
> +   bulk queue structure.
> +
> +3. Before exiting its NAPI poll loop, the driver will call ``xdp_do_flush()``,
> +   which will flush all the different bulk queues, thus completing the
> +   redirect.

This is supposed to be user-facing documentation right (i.e., to be read
by BPF program authors not kernel programmers)? If so, maybe this is a
tad bit too much detail. I feel it's fine to explain the three-step
process and bulk queueing, but the function and data structure names are
maybe superfluous details?

> +Pointers to the map entries will be kept around for this whole sequence of
> +steps, protected by RCU. However, there is no top-level ``rcu_read_lock()`` in
> +the core code; instead, the RCU protection relies on everything happening
> +inside a single NAPI poll sequence, which means it's between a pair of calls
> +to ``local_bh_disable()`` / ``local_bh_enable()``.
> +
> +The map entries are marked as ``__rcu`` and the map code makes sure to dereference
> +those pointers with ``rcu_dereference_check()`` in a way that works for both
> +sections that to hold an ``rcu_read_lock()`` and sections that are called from
> +NAPI without a separate ``rcu_read_lock()``. The code below does not use RCU
> +annotations, but relies on those in the map code.

This is *definitely* too much detail for user-facing documentation.

> +.. note::
> +    ``XDP_REDIRECT`` is not fully supported yet for xdp frags since not all XDP
> +    capable drivers can map a non-linear ``xdp_frame`` in ``ndo_xdp_xmit``.

It's not really "fully supported" for non-frags either (i.e., it still
depends on driver support). So maybe expand this to say something like
"not all drivers support transmitting frames after a redirect, and for
those that do, not all of them support non-linear frames"? Do we explain
anywhere what a non-linear frame is, BTW?


> +Usage
> +=====
> +
> +.. c:function::
> +   long bpf_map_update_elem(struct bpf_map *map, const void *key, const void *value, u64 flags)

Feels a bit weird to include these (generic) helpers into a document on
the specific map type? Shouldn't they be documented separately (and the
map type just document the value type)?

> + Net device entries can be added or updated using the ``bpf_map_update_elem()``
> + helper. This helper replaces existing elements atomically. The ``flags``
> + parameter can be used to control the update behaviour:

Should probably specify that updates can only be done from userspace
(not from a BPF program)?

> +
> + - ``BPF_ANY`` will create a new element or update an existing element
> + - ``BPF_NOEXIST`` will create a new element only if one did not already
> +   exist
> + - ``BPF_EXIST`` will update an existing element
> +
> + ``bpf_map_update_elem()`` returns 0 on success, or negative error in
> + case of failure.
> +
> + The value parameter is of type ``struct bpf_devmap_val``:

It's either a bpf_devmap_val struct or just an ifindex (for backwards
compatibility reasons).

> +
> + .. code-block:: c
> +
> +    struct bpf_devmap_val {
> +        __u32 ifindex;   /* device index */
> +        union {
> +            int   fd;  /* prog fd on map write */
> +            __u32 id;  /* prog id on map read */
> +        } bpf_prog;
> +    };
> +
> + DEVMAPs can associate a program with a device entry by adding a ``bpf_prog.fd``
> + to ``struct bpf_devmap_val``. Programs are run after ``XDP_REDIRECT`` and have
> + access to both Rx device and Tx device. The  program associated with the ``fd``
> + must have type XDP with expected attach type ``xdp_devmap``.
> + When a program is associated with a device index, the program is run on an
> + ``XDP_REDIRECT`` and before the buffer is added to the per-cpu queue. Examples
> + of how to attach/use xdp_devmap progs can be found in the kernel selftests:
> +
> + - test_xdp_with_devmap_helpers_
> + - xdp_devmap_attach_
> +
> +.. _xdp_devmap_attach: https://github.com/torvalds/linux/blob/master/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
> +.. _test_xdp_with_devmap_helpers: https://github.com/torvalds/linux/blob/master/tools/testing/selftests/bpf/progs/test_xdp_with_devmap_helpers.c
> +
> +.. c:function::
> +   void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)
> +
> + net device entries can be retrieved using the ``bpf_map_lookup_elem()``
> + helper. This helper returns a pointer to the value associated with ``key``, or
> + ``NULL`` if no entry was found.
> +
> +.. c:function::
> +   long bpf_map_delete_elem(struct bpf_map *map, const void *key)
> +
> + net device entries can be deleted using the ``bpf_map_delete_elem()``
> + helper. This helper will return 0 on success, or negative error in case of
> + failure.
> +
> +.. c:function::
> +     long bpf_redirect_map(struct bpf_map *map, u32 key, u64 flags)

This helper makes a bit more sense to have documented here, but I also
feels like it would make more sense to document thew hole redirect
facility in one place, along with all the different map types (i.e.,
also XSK and CPUMAP)?

> + Redirect the packet to the endpoint referenced by map at index
> ``key``.

s/map/``map``/ ?

> + For ``BPF_MAP_TYPE_DEVMAP`` and ``BPF_MAP_TYPE_DEVMAP_HASH`` this map contains
> + references to net devices (for forwarding packets through other ports).
> +
> + The lower two bits of *flags* are used as the return code if the map lookup
> + fails. This is so that the return value can be one of the XDP program return
> + codes up to ``XDP_TX``, as chosen by the caller. The higher bits of ``flags``
> + can be set to ``BPF_F_BROADCAST`` or ``BPF_F_EXCLUDE_INGRESS`` as defined
> + below.
> +
> + With ``BPF_F_BROADCAST`` the packet will be broadcast to all the interfaces
> + in the map, with ``BPF_F_EXCLUDE_INGRESS`` the ingress interface will be excluded
> + from the broadcast.
> +
> + This helper will return ``XDP_REDIRECT`` on success, or the value of the two
> + lower bits of the *flags* argument if the map lookup fails.
>
> +Examples
> +========
> +
> +Kernel BPF
> +----------
> +
> +The following code snippet shows how to declare a ``BPF_MAP_TYPE_DEVMAP``
> +called tx_port.
> +
> +.. code-block:: c
> +
> +    struct {
> +        __uint(type, BPF_MAP_TYPE_DEVMAP);
> +        __uint(key_size, sizeof(int));
> +        __uint(value_size, sizeof(int));

I think we generally use '__u32' not 'int' as the key and value types;
also, should this use the '__type(key, __u32)' syntax instead of __uint(key_size..)?

> +        __uint(max_entries, 256);
> +    } tx_port SEC(".maps");
> +
> +The following code snippet shows how to declare a ``BPF_MAP_TYPE_DEVMAP_HASH``
> +called forward_map.
> +
> +.. code-block:: c
> +
> +    struct {
> +        __uint(type, BPF_MAP_TYPE_DEVMAP_HASH);
> +        __uint(key_size, sizeof(int));
> +        __uint(value_size, sizeof(struct bpf_devmap_val));
> +        __uint(max_entries, 32);
> +    } forward_map SEC(".maps");

As above, and maybe point out that this one is deliberately using the
struct value while the other isn't?

> +The following code snippet shows a simple xdp_redirect_map program.
> +
> +.. code-block:: c
> +
> +    SEC("xdp")
> +    int xdp_redirect_map_func(struct xdp_md *ctx)
> +    {
> +        void *data_end = (void *)(long)ctx->data_end;
> +        void *data = (void *)(long)ctx->data;

Why define the data pointers if they're not used?

> +        int action = XDP_PASS;

Why is this defined as a variable, and why is it initialised (it will
always be overridden below)?

> +        int index = ctx->ingress_ifindex;

Should probably explain that this works in concert with the userspace
code to index the devmap on ingress ifindex, yielding a fixed
destination port for each ingress ifindex?

> +
> +        action = bpf_redirect_map(&tx_port, index, BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS);
> +
> +    out:

Unused label?

> +        return action;
> +    }
> +
> +
> +User space
> +----------
> +
> +The following code snippet shows how to update a devmap called ``tx_port``.
> +
> +.. code-block:: c
> +
> +    int update_devmap(int ifindex, int redirect_ifindex)
> +    {
> +        int ret = -1;
> +
> +        ret = bpf_map_update_elem(bpf_map__fd(tx_port), &ifindex, &redirect_ifindex, 0);
> +        if (ret < 0) {
> +            fprintf(stderr, "Failed to update devmap_ value: %s\n",
> +                strerror(errno));
> +        }
> +
> +        return ret;
> +    }
> +
> +The following code snippet shows how to update a hash_devmap called ``forward_map``.
> +
> +.. code-block:: c
> +
> +    int update_devmap(int ifindex, int redirect_ifindex)
> +    {
> +        struct bpf_devmap_val devmap_val;

This should be zero-initialised; maybe just initialise as { .ifindex =
redirect_ifindex }; ?

> +        int ret = -1;
> +
> +        devmap_val.ifindex = redirect_ifindex;
> +        ret = bpf_map_update_elem(bpf_map__fd(forward_map), &ifindex, &devmap_val, 0);
> +        if (ret < 0) {
> +            fprintf(stderr, "Failed to update devmap_ value: %s\n",
> +                strerror(errno));
> +        }
> +        return ret;
> +    }
> +
> +References
> +===========
> +
> +- https://lwn.net/Articles/728146/
> +- https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=6f9d451ab1a33728adb72d7ff66a7b374d665176
> +- https://elixir.bootlin.com/linux/latest/source/net/core/filter.c#L4106
> -- 
> 2.35.3

