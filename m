Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281AC617AC6
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 11:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbiKCKZH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 06:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbiKCKZG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 06:25:06 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187AEDE87;
        Thu,  3 Nov 2022 03:25:05 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id bs21so2063520wrb.4;
        Thu, 03 Nov 2022 03:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wcw3vDILN+VEHTzCfmu4v27x19X3i1q7FXp645flK6U=;
        b=UL7CofUqPSXbNsY8WOzUTJyCfMZCfHpLZ2ItSBRonkS21jz3vK8nnIgMU/daI0+ydr
         AQ12sIHRu1lgI3We49QIvGiLBkdtB+QevOLm/yaPAoXFrqta1r1GyW9LVYqbv5jZLuER
         hHAaEL6e0PWdpiQWOLDmoHCLK9KWvh42pvqHnUzZrjC+08kHySZ6rq0lvAIWBoScDfla
         VoaR7inIvA4F0HQV0+hMAbc1+Hsw4NY7w9FF5sKVBLn0wv2CHPbAGjncXw/AQLZu1rLt
         Poe6JAfeZ7cwRTGeSOCMUBPaUfWLhqnU4KRG6Mxq8XhzLeaHV3Ng/OcpLjxM6d+UcWwZ
         IpoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcw3vDILN+VEHTzCfmu4v27x19X3i1q7FXp645flK6U=;
        b=nUwGjrO0pXdtE6YYjwrpndbpRm0Yt2XqHK06h7UpU38kHkau1Wy4UrY8n3EfDD4kIM
         juPWS6kDewoAOjnojpRMDnLfRKUbXWt1cUGNhSKah7e1DlRwsaYIxPpR8V94eKiZ51WS
         /p8MfMBEaJxEmsVLcB3xUvgD57Rr3eEFCtOD3jL9YlG+S1/9726XbV74H/jilehFaQVe
         7uedgqmfUmDU7nDY8epulgZKZKppJ5YQGldkrmRceun1CY3Nd/0i3W6+UxJzcl0TZLHa
         /Zry85nNRz9RFpSkhf2ZSplSvSpsw1P6AXjnEa9SLgQbyivBaqW1SRrp9dv5fwsWW+Qr
         cz5A==
X-Gm-Message-State: ACrzQf3cxjZ0JZroLSPNQbi7X2wT+EgHR/fND7ziV5TV+a3ofPDGYdNq
        8piw9zmkVqTPwjApAZ8IkVc=
X-Google-Smtp-Source: AMsMyM7xwdlAqiDVEIAz8d1gSI7tOaoJiw80uyoGhG74NvLVcPUes2rguRn3h1zztYX2AHC6tMfMkg==
X-Received: by 2002:a5d:4846:0:b0:236:64b1:50fe with SMTP id n6-20020a5d4846000000b0023664b150femr18498398wrs.672.1667471103322;
        Thu, 03 Nov 2022 03:25:03 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:b0e4:331f:74b1:5cc8])
        by smtp.gmail.com with ESMTPSA id l2-20020a05600c1d0200b003cf878c4468sm5829695wms.5.2022.11.03.03.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 03:25:02 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     mtahhan@redhat.com
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org, jbrouer@redhat.com,
        thoiland@redhat.com, Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH bpf-next v2 1/1] docs: BPF_MAP_TYPE_CPUMAP
In-Reply-To: <20221102124416.2820268-2-mtahhan@redhat.com>
        (mtahhan@redhat.com's message of "Wed, 2 Nov 2022 08:44:16 -0400")
Date:   Thu, 03 Nov 2022 10:24:49 +0000
Message-ID: <m2mt98tjwu.fsf@gmail.com>
References: <20221102124416.2820268-1-mtahhan@redhat.com>
        <20221102124416.2820268-2-mtahhan@redhat.com>
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
> Add documentation for BPF_MAP_TYPE_CPUMAP including
> kernel version introduced, usage and examples.
>
> Signed-off-by: Maryam Tahhan <mtahhan@redhat.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  Documentation/bpf/map_cpumap.rst | 140 +++++++++++++++++++++++++++++++
>  1 file changed, 140 insertions(+)
>  create mode 100644 Documentation/bpf/map_cpumap.rst
>
> diff --git a/Documentation/bpf/map_cpumap.rst b/Documentation/bpf/map_cpumap.rst
> new file mode 100644
> index 000000000000..23320fb61bf7
> --- /dev/null
> +++ b/Documentation/bpf/map_cpumap.rst
> @@ -0,0 +1,140 @@
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
> +``BPF_MAP_TYPE_CPUMAP`` is primarily used as a backend map for the XDP BPF
> +helpers ``bpf_redirect_map()`` and ``XDP_REDIRECT`` action. This map type redirects raw
> +XDP frames to another CPU.
> +
> +A CPUMAP is a scalability and isolation mechanism that allows the steering of packets
> +to dedicated CPUs for processing. An example use-case for this map type is software
> +based Receive Side Scaling (RSS).
> +
> +The CPUMAP represents the CPUs in the system indexed as the map-key, and the
> +map-value is the config setting (per CPUMAP entry). Each CPUMAP entry has a dedicated
> +kernel thread bound to the given CPU to represent the remote CPU execution unit.
> +
> +Starting from Linux kernel version 5.9 the CPUMAP can run a second XDP program
> +on the remote CPU. This allows an XDP program to split its processing across
> +multiple CPUs. For example, a scenario where the initial CPU (that sees/receives
> +the packets) needs to do minimal packet processing and the remote CPU (to which
> +the packet is directed) can afford to spend more cycles processing the frame. The
> +initial CPU is where the XDP redirect program is executed. The remote CPU
> +receives raw``xdp_frame`` objects.

Nit - missing space between raw and ``xdp_frame`` is breaking formatting.

> +
> +Usage
> +=====

Can you add subheadings for "Kernel BPF" and "Userspace" and move
update, lookup, delete under "Userspace".

> +.. c:function::
> +   long bpf_map_update_elem(struct bpf_map *map, const void *key, const void *value, u64 flags)

This function signature is for the BPF helper. If it can only be used
from userspace then this should be the libbpf function signature.

> +
> + CPU entries can be added or updated using the ``bpf_map_update_elem()``
> + helper. This helper replaces existing elements atomically. The ``value`` parameter
> + can be ``struct bpf_cpumap_val``.

I think this needs to be a stronger statement that says the value must
either be a __u32 or a struct bpf_cpumap_val.

> + .. note::
> +    The maps can only be updated from user space and not from a BPF program.

Suggest moving this note to the start of the usage section.

> + .. code-block:: c
> +
> +    struct bpf_cpumap_val {
> +        __u32 qsize;  /* queue size to remote target CPU */
> +        union {
> +            int   fd; /* prog fd on map write */
> +            __u32 id; /* prog id on map read */
> +        } bpf_prog;
> +    };

Should also state the valid use of flags, which I think is BPF_ANY or
BPF_EXIST due to the array semantics.

> +.. c:function::
> +   void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)

This needs to be the libbpf function signature.

> + CPU entries can be retrieved using the ``bpf_map_lookup_elem()``
> + helper.
> +
> +.. c:function::
> +   long bpf_map_delete_elem(struct bpf_map *map, const void *key)

This needs to be the libbpf function signature.

> + CPU entries can be deleted using the ``bpf_map_delete_elem()``
> + helper. This helper will return 0 on success, or negative error in case of
> + failure.
> +
> +.. c:function::
> +     long bpf_redirect_map(struct bpf_map *map, u32 key, u64 flags)

Can you put this under a "Kernel BPF" subheading.

> + Redirect the packet to the endpoint referenced by ``map`` at index ``key``.
> + For ``BPF_MAP_TYPE_CPUMAP`` this map contains references to CPUs.
> +
> + The lower two bits of *flags* are used as the return code if the map lookup

Nit - should that be ``flags``

> + fails. This is so that the return value can be one of the XDP program return
> + codes up to ``XDP_TX``, as chosen by the caller.
> +
> +Examples
> +========
> +Kernel
> +------
> +
> +The following code snippet shows how to declare a BPF_MAP_TYPE_CPUMAP called
> +cpu_map and how to redirect packets to a remote CPU using a round robin scheme.

Nit - ``BPF_MAP_TYPE_CPUMAP`` called ``cpu_map``

> +.. code-block:: c
> +
> +   struct {
> +        __uint(type, BPF_MAP_TYPE_CPUMAP);
> +        __type(key, u32);
> +        __type(value, struct bpf_cpumap_val);
> +        __uint(max_entries, 12);
> +    } cpu_map SEC(".maps");
> +
> +    struct {
> +        __uint(type, BPF_MAP_TYPE_ARRAY);
> +        __type(key, u32);
> +        __type(value, u32);
> +        __uint(max_entries, 12);
> +    } cpus_available SEC(".maps");
> +
> +    struct {
> +        __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> +        __type(key, u32);
> +        __type(value, u32);
> +        __uint(max_entries, 1);
> +       } cpus_iterator SEC(".maps");

Nit - closing brace indentation.

> +    SEC("xdp")
> +    int  xdp_redir_cpu_round_robin(struct xdp_md *ctx)
> +    {
> +        u32 key = 0;
> +        u32 cpu_dest = 0;
> +        u32 *cpu_selected, *cpu_iterator;
> +        u32 cpu_idx;
> +
> +        cpu_iterator = bpf_map_lookup_elem(&cpus_iterator, &key);
> +        if (!cpu_iterator)
> +            return XDP_ABORTED;
> +        cpu_idx = *cpu_iterator;
> +
> +        *cpu_iterator += 1;
> +        if (*cpu_iterator == bpf_num_possible_cpus())
> +            *cpu_iterator = 0;
> +
> +        cpu_selected = bpf_map_lookup_elem(&cpus_available, &cpu_idx);
> +        if (!cpu_selected)
> +            return XDP_ABORTED;
> +        cpu_dest = *cpu_selected;
> +
> +        if (cpu_dest >= bpf_num_possible_cpus())
> +            return XDP_ABORTED;
> +
> +        return bpf_redirect_map(&cpu_map, cpu_dest, 0);
> +    }

I think the above example should use __u32 instead of u32 because it
should use UAPI definitions, but we should verify this.

> +References
> +===========
> +
> +- https://elixir.bootlin.com/linux/v6.0.1/source/kernel/bpf/cpumap.c
> +- https://developers.redhat.com/blog/2021/05/13/receive-side-scaling-rss-with-ebpf-and-cpumap#redirecting_into_a_cpumap
