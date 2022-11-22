Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D6A633FE8
	for <lists+bpf@lfdr.de>; Tue, 22 Nov 2022 16:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbiKVPOy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Nov 2022 10:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbiKVPOx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Nov 2022 10:14:53 -0500
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3003C6FA;
        Tue, 22 Nov 2022 07:14:52 -0800 (PST)
Received: by mail-qt1-f181.google.com with SMTP id a27so9413525qtw.10;
        Tue, 22 Nov 2022 07:14:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UxfZgpGwT0GYG3tIgH9BI66ub1rR2oFhzDYqzUxR5do=;
        b=2j7FdMuGsSva2TZ2acJDLKxHK0HbLpj6fc1VuPLv7zgRFVFz5AGJEJedqJ1kpw3A9E
         gqKhhuZlfUgtGWyX1b19FlzXy5XWAkAWoFbnrhJYr1VHffaYboUpcwV9QqWnnxfzPE5T
         IPm3GfeanTnxw5usB7DpdkG0TU/ogH7z9Pb833VP6OxMCxVNx3kzYT8jqmpzX8ZHFprI
         cz7mTBj9dYtB7uGukHzsa1RuRc3nblj+qN5KjR1M5UXSRUkGjRvZh6yd6JRE7t/6lhw9
         OI38nNzjcufVS8DqJSv1qgrqCuo6u3zs5H2qU31v0YtE5TWLA/Gm5LdrhzpoGaSMW6cP
         FtUA==
X-Gm-Message-State: ANoB5pmgS0shbXqJvxDiFzgsmJGDCyf5P5sSi27JevklT3BO7ouFEIav
        RYvZk9p6+eyC6gdCdf6Rru3LCss2UqOyjefV
X-Google-Smtp-Source: AA0mqf4DzFaBz0DF/Golsblhc29lwGY1y1GxC8YC8XKBA4SOaNcPhhO1sx3jlfRff8pvqZX6HzP8AA==
X-Received: by 2002:ac8:518b:0:b0:3a5:49fa:3983 with SMTP id c11-20020ac8518b000000b003a549fa3983mr21952942qtn.436.1669130090828;
        Tue, 22 Nov 2022 07:14:50 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:3170])
        by smtp.gmail.com with ESMTPSA id dt44-20020a05620a47ac00b006fbf88667bcsm4536814qkb.77.2022.11.22.07.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 07:14:50 -0800 (PST)
Date:   Tue, 22 Nov 2022 09:14:56 -0600
From:   David Vernet <void@manifault.com>
To:     mtahhan@redhat.com
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org, jbrouer@redhat.com,
        thoiland@redhat.com, donhunte@redhat.com,
        magnus.karlsson@gmail.com, akiyks@gmail.com
Subject: Re: [PATCH bpf-next v4 1/1] docs: BPF_MAP_TYPE_XSKMAP
Message-ID: <Y3zncFzVo9k3bj41@maniforge.lan>
References: <20221122103701.65867-1-mtahhan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122103701.65867-1-mtahhan@redhat.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 22, 2022 at 10:37:01AM +0000, mtahhan@redhat.com wrote:
> From: Maryam Tahhan <mtahhan@redhat.com>
> 
> Add documentation for BPF_MAP_TYPE_XSKMAP
> including kernel version introduced, usage
> and examples.
> 
> Signed-off-by: Maryam Tahhan <mtahhan@redhat.com>
> 
> ---
> v4:
> - Add more details about AF_XDP sockets and where to find
>   relevant info.
> - Fixup typos.
> - Remove ``c:function::`` block directives.
> - Replace spaces with tabs in code blocks.
> 
> v3:
> - Fixed duplicate function warnings from Sphinx >= 3.3.
> 
> v2:
> - Fixed typos + incorrect return type references.
> - Adjusted examples to use __u32 and fixed references to key_size.
> - Changed `AF_XDP socket` references to XSK.
> - Added note re map key and value size.
> ---
>  Documentation/bpf/map_xskmap.rst | 192 +++++++++++++++++++++++++++++++
>  1 file changed, 192 insertions(+)
>  create mode 100644 Documentation/bpf/map_xskmap.rst
> 
> diff --git a/Documentation/bpf/map_xskmap.rst b/Documentation/bpf/map_xskmap.rst
> new file mode 100644
> index 000000000000..990010952d2f
> --- /dev/null
> +++ b/Documentation/bpf/map_xskmap.rst
> @@ -0,0 +1,192 @@
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
> +This map type redirects raw XDP frames to `AF_XDP`_ sockets (XSKs), a new type of
> +address family in the Kernel that allows redirection of frames from a driver to

s/Kernel/kernel

> +userspace without having to traverse the full network stack. An AF_XDP socket

We make this mistake all over the BPF docs, but we might as well be
consistent / correct here:

s/userspace/user space

> +binds to a single netdev queue. A mapping of XSKs to queues is shown below:
> +
> +.. code-block:: none
> +
> +    +---------------------------------------------------+
> +    |     xsk A      |     xsk B       |      xsk C     |<---+ Userspace

s/Userspace/User space

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
> +    |  | BPF     |-- redirect -->+-------------+-------------+
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
> +
> +.. note::
> +    Both the map key and map value size must be 4 bytes.
> +
> +Usage
> +=====
> +
> +Kernel BPF
> +----------
> +bpf_redirect_map()
> +^^^^^^^^^^^^^^^^^^
> +.. code-block:: c
> +
> +    long bpf_redirect_map(struct bpf_map *map, u32 key, u64 flags)
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
> +bpf_map_lookup_elem()
> +^^^^^^^^^^^^^^^^^^^^^
> +.. code-block:: c
> +
> +    void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)
> +
> +XSK entry references of type ``struct xdp_sock *`` can be retrieved using the
> +``bpf_map_lookup_elem()`` helper.
> +
> +Userspace
> +---------

s/Userspace/User space

> +.. note::
> +    XSK entries can only be updated/deleted from user space and not from
> +    an BPF program. Trying to call these functions from a kernel BPF program will

s/an BPF/a BPF

> +    result in the program failing to load and a verifier warning.
> +
> +bpf_map_update_elem()
> +^^^^^^^^^^^^^^^^^^^^^
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
> +bpf_map_lookup_elem()
> +^^^^^^^^^^^^^^^^^^^^^
> +.. code-block:: c
> +
> +    int bpf_map_lookup_elem(int fd, const void *key, void *value)
> +
> +Returns ``struct xdp_sock *`` or negative error in case of failure.
> +
> +bpf_map_delete_elem()
> +^^^^^^^^^^^^^^^^^^^^^
> +.. code-block:: c
> +
> +    int bpf_map_delete_elem(int fd, const void *key)
> +
> +XSK entries can be deleted using the ``bpf_map_delete_elem()``
> +helper. This helper will return 0 on success, or negative error in case of
> +failure.
> +
> +.. note::
> +    When `libxdp`_ deletes an XSK it also removes the associated socket
> +    entry from the XSKMAP.
> +
> +Examples
> +========
> +Kernel
> +------
> +
> +The following code snippet shows how to declare a ``BPF_MAP_TYPE_XSKMAP`` called
> +``xsks_map`` and how to redirect packets to an XSK.
> +
> +.. code-block:: c
> +
> +	struct {
> +		__uint(type, BPF_MAP_TYPE_XSKMAP);
> +		__type(key, __u32);
> +		__type(value, __u32);
> +		__uint(max_entries, 64);
> +	} xsks_map SEC(".maps");
> +
> +
> +	SEC("xdp")
> +	int xsk_redir_prog(struct xdp_md *ctx)
> +	{
> +		__u32 index = ctx->rx_queue_index;
> +
> +		if (bpf_map_lookup_elem(&xsks_map, &index))
> +			return bpf_redirect_map(&xsks_map, index, 0);
> +		return XDP_PASS;
> +	}
> +
> +Userspace
> +---------

s/Userspace/User space

> +
> +The following code snippet shows how to update an XSKMAP with an XSK entry.
> +
> +.. code-block:: c
> +
> +	int update_xsks_map(struct bpf_map *xsks_map, int queue_id, int xsk_fd)
> +	{
> +		int ret;
> +
> +		ret = bpf_map_update_elem(bpf_map__fd(xsks_map), &queue_id, &xsk_fd, 0);
> +		if (ret < 0)
> +			fprintf(stderr, "Failed to update xsks_map: %s\n", strerror(errno));
> +
> +		return ret;
> +	}
> +
> +For an example on how create AF_XDP sockets, please see the AF_XDP-example and
> +AF_XDP-forwarding programs in the `bpf-examples`_ directory in the `libxdp`_ repository.
> +For a detailed explaination of the AF_XDP interface please see:
> +
> +- `libxdp-readme`_.
> +- `AF_XDP`_ Kernel documentation.
> +
> +.. note::
> +    The most comprehensive resource for using XSKMAPs and AF_XDP is `libxdp`_.
> +
> +.. _libxdp: https://github.com/xdp-project/xdp-tools/tree/master/lib/libxdp
> +.. _AF_XDP: https://www.kernel.org/doc/html/latest/networking/af_xdp.html
> +.. _bpf-examples: https://github.com/xdp-project/bpf-examples
> +.. _libxdp-readme: https://github.com/xdp-project/xdp-tools/tree/master/lib/libxdp#using-af_xdp-sockets
> -- 
> 2.34.1
> 
