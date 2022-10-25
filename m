Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B495B60C818
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 11:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbiJYJaj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 05:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiJYJaU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 05:30:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328712FA
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 02:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666690137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RfursnoLlBGyOEdmtPqPd9mzklp5b9T9ByTfP93r6Nw=;
        b=hascfeR6jO3jIlFbywW7pEQwafCgsnaOHzAX/P+V9VOSaf5PLxDCDPk5k365MPiN+Wy2RI
        qpCKZ0uPvlMUi5q8negqSfZun80DMIsumszYd4Nq6REbc1skDnZfmisye8O2tDRXokoM0k
        MMt3nvcyUUpWk90h/WLkpmMEvzj13LI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-100-ZXEJwyuePsieA24uspa9yw-1; Tue, 25 Oct 2022 05:28:52 -0400
X-MC-Unique: ZXEJwyuePsieA24uspa9yw-1
Received: by mail-lf1-f69.google.com with SMTP id i5-20020a0565123e0500b004a26e99bcd5so3546687lfv.1
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 02:28:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RfursnoLlBGyOEdmtPqPd9mzklp5b9T9ByTfP93r6Nw=;
        b=MKEgllcTPRU6ElRYw2Wd8UluE1aNu1U1IjznJ8e/q3z9D96uMHAZzOU6x+u+7diIpT
         QHipX6Eo+hMP1lWAmLOqd3ltNxX2hdfWybfuxF9NlEJ2gtXQcFabibdXbncv3FrkpVYA
         gKrJx8WIPhzm0yxUNflQGdJueVLpo2c9YM6qG2avRWDIneNoekT2M7hRfMttbnYnZpVF
         oMoQ1aSNuNy5kUyfFjG8Bvbj8N+L88VObZDYSuwJAWqoK6M/DdzhUQCUOVNcwurOSorw
         npZjYD+WwAo5/5po7LqASgtn1ZYyKSLybOMdhTuG6wHiTK7J1SqNONTFImA/lC/bwd1W
         ZO1Q==
X-Gm-Message-State: ACrzQf0pVk6eBUDpaRx3iB36wPj2iBkd1ILtJBLgMQ46L0f5tnKYO5t7
        lbUmBV4b8V7ysdK1ewjcNx5iXfnZ5YFUxniafgFst4p0TgDVpGKxr23ec+88haKG2U66MoICBqy
        q6TAtXUf2v6dF
X-Received: by 2002:a05:651c:1a0a:b0:26f:ef12:9a42 with SMTP id by10-20020a05651c1a0a00b0026fef129a42mr15111473ljb.457.1666690129919;
        Tue, 25 Oct 2022 02:28:49 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5VBLamY2OwDe6W9C8WKx39cpfmQP6ofe7VoJTSG7D3AZ9VEp2B50uLZMY0/fd6+Dd96ySEig==
X-Received: by 2002:a17:906:7308:b0:78e:191e:8389 with SMTP id di8-20020a170906730800b0078e191e8389mr31715881ejc.170.1666690119238;
        Tue, 25 Oct 2022 02:28:39 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id n20-20020a5099d4000000b0045ce419ecffsm1275506edb.58.2022.10.25.02.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 02:28:38 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 83AA46EEC65; Tue, 25 Oct 2022 11:28:38 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     mtahhan@redhat.com, bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Maryam Tahhan <mtahhan@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH bpf-next v1 1/1] docs: BPF_MAP_TYPE_CPUMAP
In-Reply-To: <20221021093050.2711300-1-mtahhan@redhat.com>
References: <20221021093050.2711300-1-mtahhan@redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 25 Oct 2022 11:28:38 +0200
Message-ID: <87a65kgsl5.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

mtahhan@redhat.com writes:

> From: Maryam Tahhan <mtahhan@redhat.com>
>
> Add documentation for BPF_MAP_TYPE_CPUMAP including
> kernel version introduced, usage and examples.
>
> Signed-off-by: Maryam Tahhan <mtahhan@redhat.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  Documentation/bpf/map_cpumap.rst | 166 +++++++++++++++++++++++++++++++
>  1 file changed, 166 insertions(+)
>  create mode 100644 Documentation/bpf/map_cpumap.rst
>
> diff --git a/Documentation/bpf/map_cpumap.rst b/Documentation/bpf/map_cpumap.rst
> new file mode 100644
> index 000000000000..63e203f5a5da
> --- /dev/null
> +++ b/Documentation/bpf/map_cpumap.rst
> @@ -0,0 +1,166 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +.. Copyright (C) 2022 Red Hat, Inc.
> +
> +===================
> +BPF_MAP_TYPE_CPUMAP
> +===================
> +
> +.. note::
> +   - ``BPF_MAP_TYPE_CPUMAP`` was introduced in kernel version 4.15
> +
> +``BPF_MAP_TYPE_CPUMAP`` is primarily used as a backend map for the XDP BPF helpers
> +``bpf_redirect_map()`` and ``XDP_REDIRECT`` action. This map type redirects raw
> +XDP frames to another CPU.
> +
> +A CPUMAP is a scalability and isolation mechanism, that allows separating the driver
> +network XDP layer, from the rest of the network stack, and assigning dedicated
> +CPUs for this stage. An example use case for this map type is software based Receive
> +Side Scaling (RSS) at the XDP layer.

With the addition of the ability to run another XDP program on the
target CPU, this is not quite accurate anymore. I.e., it's not about
"separating the driver network XDP layer [sic]", it's about steering
packets to a particular CPU and processing it there, whether by XDP or
by the networking stack.

> +The CPUMAP represents the CPUs in the system indexed as the map-key, and the
> +map-value is the config setting (per CPUMAP entry). Each CPUMAP entry has a dedicated
> +kernel thread bound to the given CPU to represent the remote CPU execution unit.
> +
> +The CPUMAP entry represents a multi-producer single-consumer (MPSC) queue
> +(implemented via ``ptr_ring`` in the kernel). The single consumer is the CPUMAP
> +``kthread`` that can access the ``ptr_ring`` queue without taking any lock. It also
> +tries to bulk dequeue eight xdp_frame objects, as they represent one cache line.
> +The multi-producers can be RX IRQ line CPUs queuing up packets simultaneously for
> +the remote CPU. To avoid queue lock contention for each producer CPU, there is a
> +small eight-object queue to generate bulk enqueueing into the cross-CPU queue.
> +This careful queue usage means that each cache line transfers eight frames across
> +the CPUs.

Cache line usage and ptr_ring details seems like a bit much detail for
user-facing documentation. Keeping the mention of the bulking is
probably a good idea as that is user-visible, but I'd just get rid of
the rest...

> +.. note::
> +
> +    XDP packets getting XDP redirected to another CPU, will maximum be stored/queued
> +    for one ``driver ->poll()`` call. Queueing the frame and the flush operation
> +    are guaranteed to happen on same CPU. Thus, ``cpu_map_flush`` operation can deduce
> +    via ``this_cpu_ptr()`` which queue in bpf_cpu_map_entry contains packets.

Again, implementation detail that's not really relevant to users...

> +Usage
> +=====
> +
> +.. c:function::
> +   long bpf_map_update_elem(struct bpf_map *map, const void *key, const void *value, u64 flags)
> +
> + CPU entries can be added or updated using the ``bpf_map_update_elem()``
> + helper. This helper replaces existing elements atomically. The ``value`` parameter
> + can be ``struct bpf_cpumap_val``.
> +
> + .. note::
> +    The maps can only be updated from user space and not from a BPF program.
> +
> + .. code-block:: c
> +
> +    struct bpf_cpumap_val {
> +        __u32 qsize;  /* queue size to remote target CPU */
> +        union {
> +            int   fd; /* prog fd on map write */
> +            __u32 id; /* prog id on map read */
> +        } bpf_prog;
> +    };
> +
> + Starting from Linux kernel version 5.9 the CPUMAP can run a second XDP program
> + on the remote CPU. This helps with scalability as the receive CPU should spend
> + as few cycles as possible processing packets. The remote CPU (to which the packet is
> + directed) can afford to spend more cycles processing the frame. For example, packets
> + are received on a CPU to which the IRQ of the NIC RX queue is steered. This CPU
> + is the one that initially sees the packets. This is where the XDP redirect program
> + is executed. Because the objective is to scale the CPU usage across multiple CPUs,
> + the eBPF program should use as few cycles as possible on this initial CPU; just
> + enough to determine which remote CPU to send the packet to, and then move the
> + packet to a remote CPU for continued processing. The remote CPUMAP ``kthread``
> + receives raw XDP frame (``xdp_frame``) objects. If the frames are to be passed
> + to the networking stack, the SKB objects are allocated by the remote CPU, and
> + the SKBs are passed to the networking stack.

I'd move this paragraph up to the description of the CPUMAP at the top.
I think the "should" language is maybe a bit strong, users can have
different use cases. Maybe reword to something like "using this
functionality, an XDP program can split it's processing across multiple
CPUs, for example by only doing minimal processing on the receiving CPU
and deferring the rest to a different CPU".

> +.. c:function::
> +   void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)
> +
> + CPU entries can be retrieved using the ``bpf_map_lookup_elem()``
> + helper.
> +
> +.. c:function::
> +   long bpf_map_delete_elem(struct bpf_map *map, const void *key)
> +
> + CPU entries can be deleted using the ``bpf_map_delete_elem()``
> + helper. This helper will return 0 on success, or negative error in case of
> + failure.
> +
> +.. c:function::
> +     long bpf_redirect_map(struct bpf_map *map, u32 key, u64 flags)
> +
> + Redirect the packet to the endpoint referenced by ``map`` at index ``key``.
> + For ``BPF_MAP_TYPE_CPUMAP`` this map contains references to CPUs.
> +
> + The lower two bits of *flags* are used as the return code if the map lookup
> + fails. This is so that the return value can be one of the XDP program return
> + codes up to ``XDP_TX``, as chosen by the caller.
> +
> +Examples
> +========
> +Kernel
> +------
> +
> +The following code snippet shows how to declare a BPF_MAP_TYPE_CPUMAP called cpu_map.
> +
> +.. code-block:: c
> +
> +   struct {
> +        __uint(type, BPF_MAP_TYPE_CPUMAP);
> +        __type(key, u32);
> +        __type(value, struct bpf_cpumap_val);
> +    } cpu_map SEC(".maps");

Does this work without a max_entries member?

> +The following code snippet shows how to redirect packets to a remote CPU.
> +
> +.. code-block:: c
> +
> +    struct {
> +        __uint(type, BPF_MAP_TYPE_ARRAY);
> +        __type(key, u32);
> +        __type(value, u32);
> +    } cpus_available SEC(".maps"); /* Map populated by user space program as selectable redirect CPUs*/
> +
> +    SEC("xdp")
> +    int  xdp_redir_cpu(struct xdp_md *ctx)
> +    {
> +        u32 key = bpf_get_smp_processor_id();
> +        u32 *cpu_selected;
> +        u32 cpu_dest = 0;
> +
> +        cpu_selected = bpf_map_lookup_elem(&cpus_available, &key);
> +        if (!cpu_selected)
> +            return XDP_ABORTED;
> +        cpu_dest = *cpu_selected;
> +
> +        if (cpu_dest >= bpf_num_possible_cpus()) {
> +            return XDP_ABORTED;
> +        }
> +        return bpf_redirect_map(&cpu_map, cpu_dest, 0);
> +    }

This is a bit of a weird example. It uses the current CPU index to find
the destination CPU? So it becomes a one-to-one mapping for CPUs?
Wouldn't a useful example generally divide out packets based on some
property of the packet data itself?

> +User Space
> +----------
> +
> +The following code snippet shows how to update a CPUMAP called cpumap.
> +
> +.. code-block:: c
> +
> +    static int create_cpu_entry(__u32 cpu, struct bpf_cpumap_val *value)
> +    {
> +        int ret;
> +
> +        ret = bpf_map_update_elem(bpf_map__fd(cpu_map), &cpu, value, 0);
> +        if (ret < 0)
> +            fprintf(stderr, "Create CPU entry failed: %s\n", strerror(errno));
> +
> +        return ret;
> +    }

Is this necessary? It just shows how to call bpf_map_update_elem();
that's pretty generic, so why not just drop it from this example?

-Toke

