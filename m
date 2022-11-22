Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6736333D4
	for <lists+bpf@lfdr.de>; Tue, 22 Nov 2022 04:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiKVDVD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 22:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiKVDVD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 22:21:03 -0500
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931A323384;
        Mon, 21 Nov 2022 19:21:01 -0800 (PST)
Received: by mail-qk1-f169.google.com with SMTP id d8so9418408qki.13;
        Mon, 21 Nov 2022 19:21:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Y4XUTF/Qbwf1whciw3Pb3uvCrel4QM3BcAjVpywwMY=;
        b=T7M2hOrH19m1ROjebFFnPK4Kmcsb2m4hMpukdfm5u7GDITWU/CpvQu5L1sEggdLqYM
         i3BNSyX920Dt5MHvRIPNF8AOigZW0FvGmmPHwd3iGXcnKd587Mq0DuO4XqnmPAQHTBs+
         LxCnvX8FElqwF44qMecEwKpXXoLyznh2c81Ker14e4mt4z63KA0xnKLiCKixjpTNaz3a
         fthsUF1Zzm7MzI5rR4hZBBioZNZpHpWekV/QGdlJAwF9SkrPckM2Lqt67nsNKXZpUf5+
         rpkT1/JrSdFA7nNyNM8pFhwjFNva6fWPlP+95OiRUgqWFDIzN+4EMFvjLdxQTfMoNiHg
         ZBPA==
X-Gm-Message-State: ANoB5pkivqjR26ubMYeG0kAch2Ygr1gUCpMINHDRVrBnea+fiCaiiL+v
        bYiQ6q4fjFv6wFW+Ce92Q80=
X-Google-Smtp-Source: AA0mqf58iFr1VUwPl9OigpsdGn56hTW92Fos7sdq9/0vTNG4I+zmDJZvJwk1++xOQofOIfVzJUEztg==
X-Received: by 2002:ae9:ee08:0:b0:6fb:def9:3fc1 with SMTP id i8-20020ae9ee08000000b006fbdef93fc1mr3439481qkg.335.1669087260428;
        Mon, 21 Nov 2022 19:21:00 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:3170])
        by smtp.gmail.com with ESMTPSA id k1-20020a05620a414100b006eea4b5abcesm9383777qko.89.2022.11.21.19.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 19:21:00 -0800 (PST)
Date:   Mon, 21 Nov 2022 21:21:05 -0600
From:   David Vernet <void@manifault.com>
To:     mtahhan@redhat.com
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org, jbrouer@redhat.com,
        thoiland@redhat.com, donhunte@redhat.com,
        magnus.karlsson@gmail.com, akiyks@gmail.com
Subject: Re: [PATCH bpf-next v3 1/1] docs: BPF_MAP_TYPE_XSKMAP
Message-ID: <Y3xAIdfl0ck2wivj@maniforge.lan>
References: <20221121142240.40451-1-mtahhan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121142240.40451-1-mtahhan@redhat.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 21, 2022 at 02:22:40PM +0000, mtahhan@redhat.com wrote:
> From: Maryam Tahhan <mtahhan@redhat.com>
> 
> Add documentation for BPF_MAP_TYPE_XSKMAP
> including kernel version introduced, usage
> and examples.
> 
> Signed-off-by: Maryam Tahhan <mtahhan@redhat.com>

Hi Maryam,

Looks great overall. Left a few comments and suggestions below.

> 
> ---
> v3:
> - Fixed duplicate function warnings from Sphinx >= 3.3.
> 
> v2:
> - Fixed typos + incorrect return type references.
> - Adjusted examples to use __u32 and fixed references to key_size.
> - Changed `AF_XDP socket` references to XSK.
> - Added note re map key and value size.
> ---
>  Documentation/bpf/map_xskmap.rst | 173 +++++++++++++++++++++++++++++++
>  1 file changed, 173 insertions(+)
>  create mode 100644 Documentation/bpf/map_xskmap.rst
> 
> diff --git a/Documentation/bpf/map_xskmap.rst b/Documentation/bpf/map_xskmap.rst
> new file mode 100644
> index 000000000000..8715034600d4
> --- /dev/null
> +++ b/Documentation/bpf/map_xskmap.rst
> @@ -0,0 +1,173 @@
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
> +call ``bpf_redirect_map()`` and ``XDP_REDIRECT`` action, like 'devmap' and 'cpumap'.
> +This map type redirects raw XDP frames to AF_XDP sockets (XSKs). An AF_XDP socket
> +binds to a single netdev queue. A mapping of XSKs to queues is shown below:

Suggestion: consider providing a bit more background here on what
exactly an XSK is. The ASCII diagram below is fantastic, but IMO this
docs writeup would be even more valuable if you provided a slightly more
thorough high-level explanation of how all of this works. As is, a
reader who is unfamiliar with these concepts would still have to
probably read through code to understand what's going on.

If this is already written down elsewhere in Documentation/bpf,
providing a link to that page would work as well.

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
> +Typically a XSKMAP is created per netdev. This map contains an array of XSK File

s/a XSKMAP/an XSKMAP

> +Descriptors (FDs). The number of array elements is typically set or adjusted using
> +the ``max_entries`` map parameter. For AF_XDP ``max_entries`` is equal to the number
> +of queues supported by the netdev.
> +
> +.. note::
> +    Both the map key and map value size must be 4 bytes.
> +
> +Usage
> +=====
> +
> +Kernel BPF
> +----------
> +
> +.. code-block:: c
> +
> +     long bpf_redirect_map(struct bpf_map *map, u32 key, u64 flags)
> +
> +Redirect the packet to the endpoint referenced by ``map`` at index ``key``.
> +For ``BPF_MAP_TYPE_XSKMAP`` this map contains references to XSK FDs
> +for sockets attached to a netdev's queues.
> +
> +.. note::
> +    If the map is empty at an index, the packet is dropped. This means that it is
> +    necessary to have an XDP program loaded with at least one XSK in the
> +    XSKMAP to be able to get any traffic to user space through the socket.
> +
> +.. code-block:: c
> +
> +    void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)
> +
> +XSK entry references of type ``struct xdp_sock *`` can be retrieved using the
> +``bpf_map_lookup_elem()`` helper.
> +
> +Userspace
> +---------
> +.. note::
> +    XSK entries can only be updated/deleted from user space and not from
> +    an eBPF program. Trying to call these functions from a kernel eBPF program will

In docs, we tend to just say "BPF" rather than "eBPF". So I would
suggest the following:

s/an eBPF program/a BPF program

here and elsewhere

> +    result in the program failing to load and a verifier warning.
> +
> +.. code-block:: c
> +
> +	int bpf_map_update_elem(int fd, const void *key, const void *value, __u64 flags)
> +
> +XSK entries can be added or updated using the ``bpf_map_update_elem()``
> +helper. The ``key`` parameter is equal to the queue_id of the queue the XSK
> +is attaching to. And the ``value`` parameter is the FD value of that socket.
> +
> +Under the hood, the XSKMAP update function uses the XSK FD value to retrieve the
> +associated ``struct xdp_sock`` instance.
> +
> +The flags argument can be one of the following:
> +
> +- BPF_ANY: Create a new element or update an existing element.
> +- BPF_NOEXIST: Create a new element only if it did not exist.
> +- BPF_EXIST: Update an existing element.
> +
> +.. code-block:: c
> +
> +    int bpf_map_lookup_elem(int fd, const void *key, void *value)
> +
> +Returns ``struct xdp_sock *`` or negative error in case of failure.
> +
> +.. code-block:: c
> +
> +    int bpf_map_delete_elem(int fd, const void *key)
> +
> +XSK entries can be deleted using the ``bpf_map_delete_elem()``
> +helper. This helper will return 0 on success, or negative error in case of
> +failure.
> +
> +.. note::
> +    When `libxdp`_ deletes a XSK it also removes the associated socket

s/a XSK/an XSK

> +    entry from the XSKMAP.
> +
> +Examples
> +========
> +Kernel
> +------
> +
> +The following code snippet shows how to declare a ``BPF_MAP_TYPE_XSKMAP`` called
> +``xsks_map`` and how to redirect packets to a XSK.

s/a XSK/an XSK

> +
> +.. code-block:: c
> +
> +   struct {
> +        __uint(type, BPF_MAP_TYPE_XSKMAP);
> +        __type(key, __u32);
> +        __type(value, __u32);
> +        __uint(max_entries, 64);
> +    } xsks_map SEC(".maps");
> +
> +
> +    SEC("xdp")
> +    int xsk_redir_prog(struct xdp_md *ctx)
> +    {
> +        __u32 index = ctx->rx_queue_index;
> +
> +        if (bpf_map_lookup_elem(&xsks_map, &index))
> +            return bpf_redirect_map(&xsks_map, index, 0);
> +        return XDP_PASS;
> +    }
> +
> +Userspace
> +---------
> +
> +The following code snippet shows how to update a XSKMAP with a XSK entry.

s/a XSKMAP/an XSKMAP

s/a XSK entry/an XSK entry

> +
> +.. code-block:: c
> +
> +    int update_xsks_map(struct bpf_map *xsks_map, int queue_id, int xsk_fd)

Do you think it's worth including code that shows how to obtain an
xsk_fd / create an XSK?

> +    {
> +        int ret;
> +
> +        ret = bpf_map_update_elem(bpf_map__fd(xsks_map), &queue_id, &xsk_fd, 0);
> +        if (ret < 0) {
> +            fprintf(stderr, "Failed to update xsks_map: %s\n",
> +                strerror(errno));
> +        }

nit: Would you mind updating this to follow kernel coding conventions?
Ideally the sample code in documenation/ will be pristine and perfectly
reflect what we consider to be correct code. In this case:

- Remove extra {}
- Fix alignment and use tabs
- Ideally add some comments explaining what's going on.

> +
> +        return ret;
> +    }
> +
> +.. note::
> +    The most comprehensive resource for using XSKMAPs is `libxdp`_.
> +
> +.. _libxdp: https://github.com/xdp-project/xdp-tools/tree/master/lib/libxdp

Are there any selftest suites we could also link to?

> -- 
> 2.34.1
> 
