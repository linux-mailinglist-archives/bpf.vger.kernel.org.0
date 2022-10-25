Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D49060D10B
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 17:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbiJYPyw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 11:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbiJYPyv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 11:54:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6C2474C7
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 08:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666713288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sh73iIjXnQemIscr00dFPxF/F3ceA44MvSFM2YQRfI8=;
        b=WTo4Aujs0Nu0JED8XbunRT/r9vyQ83LDe9+4gakahxo9pFbQggFvkRv+twMf8ThnuGG6b1
        50w7uFKVo1RhnZZ8YOcByOJqd/Phz/U4Cs3kcnLGt53/saXRVV5hFfPd+MCLcYjBZ/Kmmg
        XKHrkyfZeA8pPkAI5vFBOf/ALDQZ7g4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-627-gHXrwB3oPgauy7p-rn2_jQ-1; Tue, 25 Oct 2022 11:54:47 -0400
X-MC-Unique: gHXrwB3oPgauy7p-rn2_jQ-1
Received: by mail-ej1-f69.google.com with SMTP id jg38-20020a170907972600b007919b3ad75aso2998109ejc.10
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 08:54:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sh73iIjXnQemIscr00dFPxF/F3ceA44MvSFM2YQRfI8=;
        b=Og0aAzmmnZ/M+i2mPvldNdZDnAlG2/b0HFmCgR12PCcHdppuQ45NiHon5P8IwyalR8
         XpwKF3vygJQKpws66GeIuuVF9oTPFSOsIPHFs+23lMPbtMzTT0tpVfC1CM/9QoaEqxCz
         hi6G6mNh5lnDtaLKZlLtvindjFrd3rmZ0Ygh5wloeONhYUnb7an2CcWD28sLhBXJgZME
         dHIBdW9JuQ/b/CUg0swAGXkWSV00KyMVyjVOHBa5t1MM9MQlPVPaO2ORBdVAMd8atURJ
         0GnQOfS89okojZHeZ13ygs0m1dEVtHZs5cwThoiVOIZVvgCKuDdtpgelTmyOwyI7N41U
         dM8g==
X-Gm-Message-State: ACrzQf1NBARQ4dO7fMrPNZvCZ9khGOJsSYrnpiZQ6qepcNjsnWDmQ5y1
        +HgMoNQRQOnas3SSuS81FEhA2B07i0aTXaNSOCfNOwfg7GPUQfbAM3nxlb0HuehNz2Emjc1hWZa
        DyfoMRaQkiViz
X-Received: by 2002:a17:907:60c7:b0:78e:1cc:57de with SMTP id hv7-20020a17090760c700b0078e01cc57demr33369881ejc.33.1666713285834;
        Tue, 25 Oct 2022 08:54:45 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4ygIxsWrEQ0mlwlF0eweaLRyaHmsZWKINCGfvLKssazUXwuU7EZKkh9U55gC7bPImPHvCo0Q==
X-Received: by 2002:a17:907:60c7:b0:78e:1cc:57de with SMTP id hv7-20020a17090760c700b0078e01cc57demr33369863ejc.33.1666713285555;
        Tue, 25 Oct 2022 08:54:45 -0700 (PDT)
Received: from [192.168.41.200] (83-90-141-187-cable.dk.customer.tdc.net. [83.90.141.187])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906200100b00780f6071b5dsm1571716ejo.188.2022.10.25.08.54.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 08:54:44 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <82a712d1-e83e-b9ac-4c93-d5979a3b93db@redhat.com>
Date:   Tue, 25 Oct 2022 17:54:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Cc:     brouer@redhat.com,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Donald Hunter <donald.hunter@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH bpf-next v5 1/1] doc: DEVMAPs and XDP_REDIRECT
Content-Language: en-US
To:     mtahhan@redhat.com, bpf@vger.kernel.org, linux-doc@vger.kernel.org
References: <20221024124341.2157865-1-mtahhan@redhat.com>
 <20221024124341.2157865-2-mtahhan@redhat.com>
In-Reply-To: <20221024124341.2157865-2-mtahhan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 24/10/2022 14.43, mtahhan@redhat.com wrote:
> From: Maryam Tahhan <mtahhan@redhat.com>
> 
> Add documentation for BPF_MAP_TYPE_DEVMAP and
> BPF_MAP_TYPE_DEVMAP_HASH including kernel version
> introduced, usage and examples.
> 
> Add documentation that describes XDP_REDIRECT.
> 
> Signed-off-by: Maryam Tahhan <mtahhan@redhat.com>
> Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
> Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
> ---
>   Documentation/bpf/index.rst      |   1 +
>   Documentation/bpf/map_devmap.rst | 203 +++++++++++++++++++++++++++++++
>   Documentation/bpf/redirect.rst   |  45 +++++++
>   3 files changed, 249 insertions(+)
>   create mode 100644 Documentation/bpf/map_devmap.rst
>   create mode 100644 Documentation/bpf/redirect.rst
> 
> diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
> index 1b50de1983ee..1088d44634d6 100644
> --- a/Documentation/bpf/index.rst
> +++ b/Documentation/bpf/index.rst
> @@ -29,6 +29,7 @@ that goes into great technical depth about the BPF Architecture.
>      clang-notes
>      linux-notes
>      other
> +   redirect
>   
>   .. only::  subproject and html
>   
> diff --git a/Documentation/bpf/map_devmap.rst b/Documentation/bpf/map_devmap.rst
> new file mode 100644
> index 000000000000..1c6025ea5fdc
> --- /dev/null
> +++ b/Documentation/bpf/map_devmap.rst
> @@ -0,0 +1,203 @@
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

Again is this usage section describing BPF-prog kernel-side API or 
userspace syscall API ?

> +
> +.. c:function::
> +   long bpf_map_update_elem(struct bpf_map *map, const void *key, const void *value, u64 flags)
> +
> + Net device entries can be added or updated using the ``bpf_map_update_elem()``
> + helper. This helper replaces existing elements atomically. The ``value`` parameter

IMHO if we consistently call "helper" for "BPF-helper" the reader will
know this is BPF-prog code.  (Feel free to disagree with me on this)

> + can be ``struct bpf_devmap_val`` or a simple ``int ifindex`` for backwards
> + compatibility.
> +
> +.. note::
> +    The maps can only be updated from user space and not from a BPF program.

So, we cannot update this from a BPF-prog, but above API doesn't take a
file-descriptor so it must be the BPF-prog API being describe.  That
seems strange, as note says we cannot use this from a BPF-prog...


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

This must be BPF-prog code as userspace bpf_map_lookup_elem() have other
parameters.  IIRC we did open up for BPF-prog being able to do this
lookup from BPF-prog code, but it doesn't make much sense to do the
lookup (from a performance perspective).
For these map types the bpf_redirect_map() BPF-helper call will (in
recent kernels) do the lookup in the context of the BPF-prog and return
code from bpf_redirect_map() indicate if the element in the map was
available and redirect possible.  This API detail should likely also be
documented here (note it is documented in man bpf-helpers(7)).


> +net device entries can be retrieved using the ``bpf_map_lookup_elem()``
> +helper.
> +
> +.. c:function::
> +   long bpf_map_delete_elem(struct bpf_map *map, const void *key)
> +
> +net device entries can be deleted using the ``bpf_map_delete_elem()``
> +helper. This helper will return 0 on success, or negative error in case of
> +failure.

Hmm... again this must be BPF-prog code given that API have a map
pointer.  I would recommend against changing these maps types from the
packet data-plane code, IMHO this should be left up to the userspace
control-plane.

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

Sorry, I see that you already *have* documented the "hidden" lookup in
the bpf_redirect_map() call.

> +
> +With ``BPF_F_BROADCAST`` the packet will be broadcast to all the interfaces
> +in the map, with ``BPF_F_EXCLUDE_INGRESS`` the ingress interface will be excluded
> +from the broadcast.
> +

Nice that we get documented that XDP can do broadcasting, and via 
multiple devmap's also multicast.

> +.. note::
> +    The key is ignored if BPF_F_BROADCAST is set.
> +
> +This helper will return ``XDP_REDIRECT`` on success, or the value of the two
> +lower bits of the *flags* argument if the map lookup fails.

The "lower two bits" is kind of an implementation detail (which is kind 
of a co-incidence as the xdp_action's are not bit fields.)
I made sure that BPF_F_BROADCAST uses value 8, which would allow us to 
add more xdp_action's later

$ pahole xdp_action
enum xdp_action {
	XDP_ABORTED  = 0,
	XDP_DROP     = 1,
	XDP_PASS     = 2,
	XDP_TX       = 3,
	XDP_REDIRECT = 4,
};


> +More information about redirection can be found :doc:`redirect`

I cannot remember the effect of this :doc:`redirect`, does it link to 
redirect.rst file?

--Jesper

