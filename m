Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51FDC6065F9
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 18:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiJTQjv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Oct 2022 12:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiJTQjr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Oct 2022 12:39:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126F42EF46
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 09:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666283981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aGUELAy47nJF/79gSkOfF5roR0foFFldKn1QUcWa7Yo=;
        b=P8tv492XDdtIVS6SKC8lo4Y5QcFaWwwfO3PDSq6A6WEDHAfUeXSMIh9h29K9L2Z8P2eyim
        Al2lAvt5RST3ijB9n4nQcL5MP5+BxZR9ih8PWA/wuSRhXWOK1QLrZt/18delQ8q3etfZa5
        NdzPk/EiaNgJ5hr0huoetysyf8cV+GM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-115-KvEOjpxEOxOVs70PWT6ABw-1; Thu, 20 Oct 2022 12:39:40 -0400
X-MC-Unique: KvEOjpxEOxOVs70PWT6ABw-1
Received: by mail-ed1-f69.google.com with SMTP id h13-20020a056402280d00b0045cb282161cso145766ede.8
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 09:39:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aGUELAy47nJF/79gSkOfF5roR0foFFldKn1QUcWa7Yo=;
        b=OFYM64ucvewtJN6VW2eAIoMNq1RLjYcOYzVt6GqdtXulHr6gDZXGfL/kaZujhey/+W
         LD91vHRcmB97i6kcHSRw9k6lw5YGUAdKFBM/zWKBG2F16Q+X/64qENA2kYjSiNCCrAI1
         RzPAJQFL2956GqrQkG4YjDicsPP5YZvFBT4T0sCMudzpTModv0i1QkTxKzs76gfBS5QO
         WW4vgzxchgS/tLtbiD70N4kBLOQUJyNw0+C3O77o/KAXeM3+jsmyOp5b0OE8+bfD0S1t
         K/tCJghQ/aD2I5PLQuoNu9p0SqYXbwQBaV8OqqyXgEjB9X1rZR/99d58p9uykQGslqk/
         H50w==
X-Gm-Message-State: ACrzQf0nJgtv/vKqYKa7+wWu8iF/r3UkM5xEEHgRFqzDxPXb5o5t3vhf
        oW5tJGWx2iGipTYX1zbyYoZ7nomC/nH5GawctqjkHrAx1RwxwfOHhvMJ8B7Hd/2/2qH9HlbLpNk
        iMCiiBVs1HnIm
X-Received: by 2002:a05:6402:4444:b0:458:f355:ce04 with SMTP id o4-20020a056402444400b00458f355ce04mr13174570edb.422.1666283977118;
        Thu, 20 Oct 2022 09:39:37 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5CNVBjZVVfq58SRBam4SiByhDOf4PA5iwdqGxoyLyPT3yV5DvRZWIxzrNxeSW13A8723MBJQ==
X-Received: by 2002:a05:6402:4444:b0:458:f355:ce04 with SMTP id o4-20020a056402444400b00458f355ce04mr13174382edb.422.1666283974521;
        Thu, 20 Oct 2022 09:39:34 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id e16-20020a170906315000b0073d7b876621sm10395495eje.205.2022.10.20.09.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 09:39:34 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 7E75B6EA0DE; Thu, 20 Oct 2022 18:39:33 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     mtahhan@redhat.com, bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Maryam Tahhan <mtahhan@redhat.com>
Subject: Re: [PATCH bpf-next v2 1/1] doc: DEVMAPs and XDP_REDIRECT
In-Reply-To: <20221013111129.401325-2-mtahhan@redhat.com>
References: <20221013111129.401325-1-mtahhan@redhat.com>
 <20221013111129.401325-2-mtahhan@redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 20 Oct 2022 18:39:33 +0200
Message-ID: <878rlav48q.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
>
> Add documentation that describes XDP_REDIRECT.
>
> Signed-off-by: Maryam Tahhan <mtahhan@redhat.com>
> ---
>  Documentation/bpf/index.rst      |   1 +
>  Documentation/bpf/map_devmap.rst | 192 +++++++++++++++++++++++++++++++
>  Documentation/bpf/redirect.rst   |  46 ++++++++
>  3 files changed, 239 insertions(+)
>  create mode 100644 Documentation/bpf/map_devmap.rst
>  create mode 100644 Documentation/bpf/redirect.rst
>
> diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
> index 1b50de1983ee..1088d44634d6 100644
> --- a/Documentation/bpf/index.rst
> +++ b/Documentation/bpf/index.rst
> @@ -29,6 +29,7 @@ that goes into great technical depth about the BPF Architecture.
>     clang-notes
>     linux-notes
>     other
> +   redirect
>  
>  .. only::  subproject and html
>  
> diff --git a/Documentation/bpf/map_devmap.rst b/Documentation/bpf/map_devmap.rst
> new file mode 100644
> index 000000000000..bdba55640f4c
> --- /dev/null
> +++ b/Documentation/bpf/map_devmap.rst
> @@ -0,0 +1,192 @@
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
> +``BPF_MAP_TYPE_DEVMAP`` and ``BPF_MAP_TYPE_DEVMAP_HASH`` are BPF maps primarily
> +used as backend maps for the XDP BPF helper call ``bpf_redirect_map()``.
> +``BPF_MAP_TYPE_DEVMAP`` is backed by an array that uses the key as
> +the index to lookup a reference to a net device. While ``BPF_MAP_TYPE_DEVMAP_HASH``
> +is backed by a hash table that uses the ``ifindex`` as the key to lookup a reference
> +to a net device. The user provides either <``key``/ ``ifindex``> or
> +<``key``/ ``struct bpf_devmap_val``> pairs to update the maps with new net devices.

The key to a hash map doesn't *have* to be an ifindex; it's just that
the dense packing is mostly useful for the case where it is...

> +.. note::
> +    While ``BPF_MAP_TYPE_DEVMAP_HASH`` allows for densely packing the net devices
> +    it comes at the cost of a hash of the key when performing a look up.
> +
> +The setup and packet enqueue/send code is shared between the two types of
> +devmap; only the lookup and insertion is different.
> +
> +Usage
> +=====
> +
> +.. c:function::
> +   long bpf_map_update_elem(struct bpf_map *map, const void *key, const void *value, u64 flags)
> +
> + Net device entries can be added or updated using the ``bpf_map_update_elem()``
> + helper. This helper replaces existing elements atomically. The ``value`` parameter
> + can be ``struct bpf_devmap_val`` or a simple ``int ifindex`` for backwards
> + compatibility.
> +
> +.. note::
> +    The maps can only be updated from user space and not from a BPF program.
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
> + helper.
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
> +
> + Redirect the packet to the endpoint referenced by ``map`` at index ``key``.
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

Should probably mention that the key is ignored if BPF_F_BROADCAST is set.

> + This helper will return ``XDP_REDIRECT`` on success, or the value of the two
> + lower bits of the *flags* argument if the map lookup fails.
> +
> + More information about redirection can be found :doc:`redirect`
> +
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
> +        __type(key, __u32);
> +        __type(value, __u32);
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
> +        __type(key, __u32);
> +        __type(value, struct bpf_devmap_val);
> +        __uint(max_entries, 32);
> +    } forward_map SEC(".maps");
> +
> +.. note::
> +
> +    The value type in the DEVMAP above is a ``struct bpf_devmap_val``
> +
> +The following code snippet shows a simple xdp_redirect_map program. This program
> +would work with a user space program that populates the devmap ``tx_port`` based
> +on ingress ifindexes. The BPF program (below) is redirecting packets using the
> +ingress ifindex as the ``key``.
> +
> +.. code-block:: c
> +
> +    SEC("xdp")
> +    int xdp_redirect_map_func(struct xdp_md *ctx)
> +    {
> +        int index = ctx->ingress_ifindex;
> +
> +        return bpf_redirect_map(&tx_port, index, BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS);
> +    }

Since the index is ignored when setting the broadcast flag (see above),
this example doesn't actually make a lot of sense. Maybe create one
example that uses the index without flags, and another that uses the
flags with no index? Also, using the hashmap type with the ifindex key
probably makes more sense.

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
> +        struct bpf_devmap_val devmap_val = { .ifindex = redirect_ifindex };
> +        int ret = -1;
> +
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
> diff --git a/Documentation/bpf/redirect.rst b/Documentation/bpf/redirect.rst
> new file mode 100644
> index 000000000000..5a0377a67ff0
> --- /dev/null
> +++ b/Documentation/bpf/redirect.rst
> @@ -0,0 +1,46 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +.. Copyright (C) 2022 Red Hat, Inc.
> +
> +============
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
> +
> +Pointers to the map entries will be kept around for this whole sequence of
> +steps, protected by RCU. However, there is no top-level ``rcu_read_lock()`` in
> +the core code; instead, the RCU protection relies on everything happening
> +inside a single NAPI poll sequence.

Just get rid of this last paragraph? That is a bit of an internal kernel
thing...


-Toke

