Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58281607EFC
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 21:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJUTVS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 15:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiJUTVO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 15:21:14 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6B5247E02;
        Fri, 21 Oct 2022 12:21:11 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id r14so9522156edc.7;
        Fri, 21 Oct 2022 12:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KWM5F1vVJ0wm0XrFWc2n70srm8Q/oNAebcvhOdKpHfs=;
        b=NQUL0+rEf8W4xI4rVnA69qrwi1NIlhlbBOFtnB8NJIJPUwDJ30/WzRJf/hhlAFd2L1
         iI08cMxyjpcG2pk+ME/gYoQdCiFr0wmLKxsQbMq5FIMLBeg8DjcWBEMyhtE+Pj/iic0v
         3KRzdJPcAQ/y//OBP2fh90SC3wsmt3jvxmFleqvuSDohrwap7SGitQbsHIc64pXV1QKP
         Y1qA4WcistOQKzdBRq5Ze/RoKTIok1t4mlojUfA5ebhcIt7Zn6KIzitOeTer+PFju37H
         wIupt9Aj3g9oBz6RjyfE13pvHHbb3qg+Va0jU+OEJWazaFZ0jobpcyuia5Nvcm+8cVnJ
         bUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KWM5F1vVJ0wm0XrFWc2n70srm8Q/oNAebcvhOdKpHfs=;
        b=pVnIQnGT1959aAnWVPRFVU3C5YCJr7S21r9N8D1pYoWg+e9jG+Ni8Gw4DN8Ak8EVer
         9LYgKaZDKqgHVvV+Z6rH8fExXLOAoqJHeIk77ve8KRnYsf2qm1FzhzoRzl0VjtuE7WUH
         gDmtAR+Bq57+8hpr1x4y4DLhyz2ke4EugVZlmLrf8gt+6Flfy84E+hRsJZbS2VfIkF2L
         BsB9mKPbK3fBhFLIoJ1pqJRRg6T13WzB3BRtILow/u/Gv+kftZgS4qxJ6HbIcEPobbBe
         /iim0NsE6wz9QAQ/OGLh3IjIQ+UQ22Ib4JpdazV2JNWQ3+9Lj7YpMDwBMxsgGjvBdewn
         NlFQ==
X-Gm-Message-State: ACrzQf14GoO4GeC8atC/Ev0si41CPajziY520MLbzs8b5FGgvZZ2kt/V
        T5e5AMzjRZOhIv9HghBn88tUUMZid+UT6uuFX7XhkPvh
X-Google-Smtp-Source: AMsMyM6AjzdRvAH+mxinH+VCM/KD/03K76NyOoSqDzyXP9uienth4TBN+/TU4BY8fX1PnEHsV7sU6ThDO+1Cs28zBbU=
X-Received: by 2002:a05:6402:428d:b0:460:b26c:82a5 with SMTP id
 g13-20020a056402428d00b00460b26c82a5mr9001044edc.66.1666380069825; Fri, 21
 Oct 2022 12:21:09 -0700 (PDT)
MIME-Version: 1.0
References: <20221021165919.509652-1-mtahhan@redhat.com> <20221021165919.509652-2-mtahhan@redhat.com>
In-Reply-To: <20221021165919.509652-2-mtahhan@redhat.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 21 Oct 2022 12:20:58 -0700
Message-ID: <CAADnVQL0CQoLKZMhDFdnmSXXH2e9Kj-mV_xTTxdLSAjp+agg=A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/1] doc: DEVMAPs and XDP_REDIRECT
To:     mtahhan@redhat.com, Jesper Dangaard Brouer <brouer@redhat.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jesper and Toke,
please review.

On Fri, Oct 21, 2022 at 9:10 AM <mtahhan@redhat.com> wrote:
>
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
>  Documentation/bpf/map_devmap.rst | 205 +++++++++++++++++++++++++++++++
>  Documentation/bpf/redirect.rst   |  45 +++++++
>  3 files changed, 251 insertions(+)
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
> index 000000000000..5072ea6086e4
> --- /dev/null
> +++ b/Documentation/bpf/map_devmap.rst
> @@ -0,0 +1,205 @@
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
> +is backed by a hash table that uses a key to lookup a reference to a net device.
> +The user provides either <``key``/ ``ifindex``> or <``key``/ ``struct bpf_devmap_val``>
> +pairs to update the maps with new net devices.
> +
> +.. note::
> +    - The key to a hash map doesn't have to be an ``ifindex``.
> +    - While ``BPF_MAP_TYPE_DEVMAP_HASH`` allows for densely packing the net devices
> +      it comes at the cost of a hash of the key when performing a look up.
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
> +.. code-block:: c
> +
> +    struct bpf_devmap_val {
> +        __u32 ifindex;   /* device index */
> +        union {
> +            int   fd;  /* prog fd on map write */
> +            __u32 id;  /* prog id on map read */
> +        } bpf_prog;
> +    };
> +
> +DEVMAPs can associate a program with a device entry by adding a ``bpf_prog.fd``
> +to ``struct bpf_devmap_val``. Programs are run after ``XDP_REDIRECT`` and have
> +access to both Rx device and Tx device. The  program associated with the ``fd``
> +must have type XDP with expected attach type ``xdp_devmap``.
> +When a program is associated with a device index, the program is run on an
> +``XDP_REDIRECT`` and before the buffer is added to the per-cpu queue. Examples
> +of how to attach/use xdp_devmap progs can be found in the kernel selftests:
> +
> +- ``tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c``
> +- ``tools/testing/selftests/bpf/progs/test_xdp_with_devmap_helpers.c``
> +
> +.. c:function::
> +   void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)
> +
> +net device entries can be retrieved using the ``bpf_map_lookup_elem()``
> +helper.
> +
> +.. c:function::
> +   long bpf_map_delete_elem(struct bpf_map *map, const void *key)
> +
> +net device entries can be deleted using the ``bpf_map_delete_elem()``
> +helper. This helper will return 0 on success, or negative error in case of
> +failure.
> +
> +.. c:function::
> +     long bpf_redirect_map(struct bpf_map *map, u32 key, u64 flags)
> +
> +Redirect the packet to the endpoint referenced by ``map`` at index ``key``.
> +For ``BPF_MAP_TYPE_DEVMAP`` and ``BPF_MAP_TYPE_DEVMAP_HASH`` this map contains
> +references to net devices (for forwarding packets through other ports).
> +
> +The lower two bits of *flags* are used as the return code if the map lookup
> +fails. This is so that the return value can be one of the XDP program return
> +codes up to ``XDP_TX``, as chosen by the caller. The higher bits of ``flags``
> +can be set to ``BPF_F_BROADCAST`` or ``BPF_F_EXCLUDE_INGRESS`` as defined
> +below.
> +
> +With ``BPF_F_BROADCAST`` the packet will be broadcast to all the interfaces
> +in the map, with ``BPF_F_EXCLUDE_INGRESS`` the ingress interface will be excluded
> +from the broadcast.
> +
> +.. note::
> +    The key is ignored if BPF_F_BROADCAST is set.
> +
> +This helper will return ``XDP_REDIRECT`` on success, or the value of the two
> +lower bits of the *flags* argument if the map lookup fails.
> +
> +More information about redirection can be found :doc:`redirect`
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
> +would work with a user space program that populates the devmap ``forward_map`` based
> +on ingress ifindexes. The BPF program (below) is redirecting packets using the
> +ingress ``ifindex`` as the ``key``.
> +
> +.. code-block:: c
> +
> +    SEC("xdp")
> +    int xdp_redirect_map_func(struct xdp_md *ctx)
> +    {
> +        int index = ctx->ingress_ifindex;
> +
> +        return bpf_redirect_map(&forward_map, index, 0);
> +    }
> +
> +The following code snippet shows a BPF program that is broadcasting packets to
> +all the interfaces in the ``tx_port`` devmap.
> +
> +.. code-block:: c
> +
> +    SEC("xdp")
> +    int xdp_redirect_map_func(struct xdp_md *ctx)
> +    {
> +        int index = ctx->ingress_ifindex;
> +
> +        return bpf_redirect_map(&tx_port, 0, BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS);
> +    }
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
> index 000000000000..ff49a0698707
> --- /dev/null
> +++ b/Documentation/bpf/redirect.rst
> @@ -0,0 +1,45 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +.. Copyright (C) 2022 Red Hat, Inc.
> +
> +============
> +XDP_REDIRECT
> +============
> +Supported maps
> +--------------
> +
> +XDP_REDIRECT works with the following map types:
> +
> +- ``BPF_MAP_TYPE_DEVMAP``
> +- ``BPF_MAP_TYPE_DEVMAP_HASH``
> +- ``BPF_MAP_TYPE_CPUMAP``
> +- ``BPF_MAP_TYPE_XSKMAP``
> +
> +For more information on these maps, please see the specific map documentation.
> +
> +Process
> +-------
> +
> +XDP_REDIRECT is a three-step process, implemented as follows:
> +
> +1. The ``bpf_redirect()`` and ``bpf_redirect_map()`` helpers will lookup the
> +   target of the redirect (from the supported map types) and store it (along with
> +   some other metadata) in a per-CPU ``struct bpf_redirect_info``.
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
> +.. note::
> +    Not all drivers support transmitting frames after a redirect, and for
> +    those that do, not all of them support non-linear frames. Non-linear xdp
> +    bufs/frames are bufs/frames that contain more than one fragment.
> +
> +References
> +===========
> +
> +- https://elixir.bootlin.com/linux/latest/source/net/core/filter.c#L4106
> --
> 2.35.3
>
