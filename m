Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D0B62DC51
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 14:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239592AbiKQNKn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 08:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239636AbiKQNKn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 08:10:43 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6833F6207F;
        Thu, 17 Nov 2022 05:10:41 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id l14so3807739wrw.2;
        Thu, 17 Nov 2022 05:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1E16Wg9BwXGQCZzwhn9INR5uQhH9/wEtii6ez7bUawY=;
        b=e+CHqtO8ETxCRBb7wNGNrIfQ1YF7+xEL6p1wLMy2RW0uS+HNK7fLrwbhDdZfGG7xk1
         Pf5EZjah0fB768pOnz4xjMwNy4vnnAKMB33I7A49LSEUeS86+seREcI/ob+vrdMP7wY1
         Rwm5z8/bbp5uP4rCJgCjdoW4rqVastq968AEzUWpkhm+688KaUs4XEnt0J++7GXnP2BF
         XLdLT6o4z9dpnrJLKG7/qN1q6Xgrre+cMQdKcnxetJ610F35ySs4+EVVKnpFnYuFafTB
         mhGJMCrzJqJgXOHJ/gQKA4YdIKbEoJMW2lup3EWe5uyRYPRDVtH7tNmML3Flyi1wh1tx
         EoQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1E16Wg9BwXGQCZzwhn9INR5uQhH9/wEtii6ez7bUawY=;
        b=Iio1xTp5M8zJXULHTh6QP6Vv3hy/wYn0pxv6xmi3cAAoRw/DWMcUk5Nb8qRfKZUY0A
         uFJby47bFPmq3NuJyDJ8BJYxHezB3H8a/Jer+S01NlNHxEqndrbK+JEHgMt0uWgGGqkG
         IU8XaWi7G+H1c49tWa9UpmkIa+rVAN59TtSdOuxuD5S2Ncy8KJ/y5qbckA0RszpKv/VZ
         VV5ahv6R0ODOujNX8oZzkp72dP3eIvg/Q7hAMMCWADZpwC9XIvU3OGbCf4+TwvlV0mLT
         d7FrgNPqhlPdyPvgY1lsuKDfS4A+BXigNmy9v7DdEt/iL2BazPDNv1u/l8BlmbsEmYqG
         rFaA==
X-Gm-Message-State: ANoB5pkpWhRkFr0WDCSVf35oUte4CxqCk7NQlgfj3e6VRNrLqFP7sLyI
        wt0bP/+F70vHGp79QPApmjg=
X-Google-Smtp-Source: AA0mqf4Eu+3ZucUBzS34eIs0cqoipl/MjJ43vILvpKnAi0/BJNEjWr+AAJFb/aGMpqykefCBVA/X3Q==
X-Received: by 2002:a5d:628e:0:b0:236:5ea4:68c8 with SMTP id k14-20020a5d628e000000b002365ea468c8mr1468576wru.132.1668690639774;
        Thu, 17 Nov 2022 05:10:39 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:2c71:30b9:69c:c340])
        by smtp.gmail.com with ESMTPSA id c15-20020a05600c0acf00b003c21ba7d7d6sm1157346wmr.44.2022.11.17.05.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 05:10:38 -0800 (PST)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     mtahhan@redhat.com
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org, jbrouer@redhat.com,
        thoiland@redhat.com, donhunte@redhat.com, magnus.karlsson@gmail.com
Subject: Re: [PATCH bpf-next v1 1/1] docs: BPF_MAP_TYPE_XSKMAP
In-Reply-To: <20221117105044.1935488-1-mtahhan@redhat.com>
        (mtahhan@redhat.com's message of "Thu, 17 Nov 2022 05:50:44 -0500")
Date:   Thu, 17 Nov 2022 13:10:32 +0000
Message-ID: <m2cz9lybef.fsf@gmail.com>
References: <20221117105044.1935488-1-mtahhan@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (darwin)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

mtahhan@redhat.com writes:

> From: Maryam Tahhan <mtahhan@redhat.com>
>
> Add documentation for BPF_MAP_TYPE_XSKMAP
> including kernel version introduced, usage
> and examples.
>
> Signed-off-by: Maryam Tahhan <mtahhan@redhat.com>
> ---
>  Documentation/bpf/map_xskmap.rst | 161 +++++++++++++++++++++++++++++++
>  1 file changed, 161 insertions(+)
>  create mode 100644 Documentation/bpf/map_xskmap.rst
>
> diff --git a/Documentation/bpf/map_xskmap.rst b/Documentation/bpf/map_xskmap.rst
> new file mode 100644
> index 000000000000..5699a89851ef
> --- /dev/null
> +++ b/Documentation/bpf/map_xskmap.rst
> @@ -0,0 +1,161 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +.. Copyright (C) 2022 Red Hat, Inc.
> +
> +===================
> +BPF_MAP_TYPE_XSKMAP
> +===================
> +
> +.. note::
> +   - ``BPF_MAP_TYPE_XSKMAP`` was introduced in kernel version 4.18
> +
> +The ``BPF_MAP_TYPE_XSKMAP`` is used as a backend map for XDP BPF helper
> +call ``bpf_redirect_map()`` and XDP_REDIRECT action, like 'devmap' and 'cpumap'.

``XDP_REDIRECT``

> +This map type redirects raw XDP frames to AF_XDP sockets (XSKs). An AF_XDP socket
> +binds to a single netdev queue. A mapping of XSKs to queues is shown below:
> +
> +.. code-block:: none
> +
> +    +---------------------------------------------------+
> +    |     xsk A      |     xsk B       |      xsk C     |<---+ Userspace
> +    =========================================================|==========
> +    |    Queue 0     |     Queue 1     |     Queue 2    |    |  Kernel
> +    +---------------------------------------------------+    |
> +    |                  Netdev eth0                      |    |
> +    +---------------------------------------------------+    |
> +    |                            +=============+        |    |
> +    |                            | key |  xsk  |        |    |
> +    |  +---------+               +=============+        |    |
> +    |  |         |               |  0  | xsk A |        |    |
> +    |  |         |               +-------------+        |    |
> +    |  |         |               |  1  | xsk B |        |    |
> +    |  | eBPF    |-- redirect -->+-------------+-------------+
> +    |  | prog    |               |  2  | xsk C |        |
> +    |  |         |               +-------------+        |
> +    |  |         |                                      |
> +    |  |         |                                      |
> +    |  +---------+                                      |
> +    |                                                   |
> +    +---------------------------------------------------+
> +
> +.. note::
> +    An AF_XDP socket that is bound to a certain <netdev/queue_id> will *only*
> +    accept XDP frames from that <netdev/queue_id>. If an XDP program tries to redirect
> +    from a <netdev/queue_id> other than what the socket is bound to, the frame will
> +    not be received on the socket.
> +
> +Typically an XSKMAP is created per netdev. This map contains an array of XSK File
> +Descriptors (FDs). The number of array elements is typically set or adjusted using
> +the ``max_entries`` map parameter. For AF_XDP ``max_entries`` is equal to the number
> +of queues supported by the netdev.

Should it mention that both key and value size must be 4 bytes?

> +
> +Usage
> +=====
> +
> +Kernel BPF
> +----------
> +.. c:function::
> +     long bpf_redirect_map(struct bpf_map *map, u32 key, u64 flags)
> +
> + Redirect the packet to the endpoint referenced by ``map`` at index ``key``.
> + For ``BPF_MAP_TYPE_XSKMAP`` this map contains references to AF_XDP socket FDs
> + for sockets attached to a netdev's queues.
> +
> + .. note::
> +    If the map is empty at an index, the packet is dropped. This means that it is
> +    mandatory to have an XDP program loaded (and one AF_XDP socket in the XSKMAP)

mandatory -> necessary

'and at least one AF_XDP socket'

> +    to be able to get any traffic to user space through the socket.
> +
> +.. c:function::
> +    void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)
> +
> + XSK FD entries can be retrieved using the ``bpf_map_lookup_elem()`` helper.

Unless I'm mistaken, it returns a pointer to the ``struct xdp_sock``.

> +
> +Userspace
> +---------
> +.. note::
> +    AF_XDP socket entries can only be updated/deleted from user space and not from
> +    an eBPF program. Trying to call these functions from a kernel eBPF program will
> +    result in the program failing to load and a verifier warning.
> +
> +.. c:function::
> +   int bpf_map_update_elem(int fd, const void *key, const void *value, __u64 flags)
> +
> + AF_XDP socket entries can be added or updated using the ``bpf_map_update_elem()``
> + helper. The ``key`` parameter is equal to the queue_id of the queue the AF_XDP
> + socket is attaching to. And the ``value`` parameter is the file descriptor (fd))

Extra ')' at end of line.

> + value of that socket.
> +
> + Under the hood, the AF_XDP map update function uses the XSK FD value to retrieve the
> + associated ``struct xdp_sock`` instance.
> +
> + The flags argument can be one of the following:
> +  - BPF_ANY: Create a new element or update an existing element.
> +  - BPF_NOEXIST: Create a new element only if it did not exist.
> +  - BPF_EXIST: Update an existing element.
> +
> +.. c:function::
> +    int bpf_map_lookup_elem(int fd, const void *key, void *value)
> +
> + AF_XDP socket entries can be retrieved using the ``bpf_map_lookup_elem()``
> + helper.

returns the ``struct xdp_sock`` or negative error in case of failure.

> +
> +.. c:function::
> +    int bpf_map_delete_elem(int fd, const void *key)
> +
> + AF_XDP socket entries can be deleted using the ``bpf_map_delete_elem()``
> + helper. This helper will return 0 on success, or negative error in case of
> + failure.

Should we note that entries are automatically deleted when the xdp_sock
is released?

> +
> +Examples
> +========
> +Kernel
> +------
> +
> +The following code snippet shows how to declare a ``BPF_MAP_TYPE_XSKMAP`` called
> +``xsks_map`` and how to redirect packets to an AF_XDP socket.
> +
> +.. code-block:: c
> +
> +   struct {
> +        __uint(type, BPF_MAP_TYPE_XSKMAP);
> +        __type(key_size, int);

Should be key and __u32

> +        __type(value_size, int);

Should be value and __u32

> +        __uint(max_entries, 64);
> +    } xsks_map SEC(".maps");
> +
> +
> +    SEC("xdp")
> +    int xsk_redir_prog(struct xdp_md *ctx)
> +    {
> +        int index = ctx->rx_queue_id;

Should be __u32 and ctx->rx_queue_index

> +
> +        if (bpf_map_lookup_elem(&xsks_map, &index))
> +            return bpf_redirect_map(&xsks_map, index, 0);
> +        return XDP_PASS;
> +    }
> +
> +Userspace
> +---------
> +
> +The following code snippet shows how to update an XSK map with an AF_XDP socket
> +entry.
> +
> +.. code-block:: c
> +
> +    int update_xsks_map(struct bpf_map *xsks_map, int queue_id, int xsk_fd)
> +    {
> +        int ret;
> +
> +        ret = bpf_map_update_elem(bpf_map__fd(xsks_map), &queue_id, &xsk_fd, 0);
> +        if (ret < 0) {
> +            fprintf(stderr, "Failed to update xsks_map: %s\n",
> +                strerror(errno));
> +        }
> +
> +        return ret;
> +    }
> +
> +.. note::
> +    The most comprehensive resource for using XSKMAPs is `libxdp`_.
> +
> +.. _libxdp: https://github.com/xdp-project/xdp-tools/tree/master/lib/libxdp
