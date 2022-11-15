Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0431962AE60
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 23:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiKOWb1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 17:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiKOWb0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 17:31:26 -0500
Received: from mail-oi1-x263.google.com (mail-oi1-x263.google.com [IPv6:2607:f8b0:4864:20::263])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D46180
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 14:31:25 -0800 (PST)
Received: by mail-oi1-x263.google.com with SMTP id l127so16493777oia.8
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 14:31:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wrx+My2LzWpvTJDHOPPdJYSCZQMa7hrsohTqH3ScK6w=;
        b=nYBxUd6lgIJpuuq1wST3djQ3QNfFiL139B6oCaGrU3T0ahCcMp6nVhWQ2NJFm5t+FZ
         I5Qe+sTBLLCepfeIrfELuCLBvV21VeL95VJQI197gY7/9VjARSyjz42u6gbD02a29ZAz
         2ETuJTYF09xOA/51SEXZHd2GpOH3WOYBsC61ZJh0JxJFKMJmW0EdmZs3AVTVyQeSQBWW
         TeS+y0TzAwfDQsm7h1tbzNuahkC6NqakjPWs/rpdShCswIFNs5oNg83loBaNajLXDN0d
         HG6zU6nLEKsmhqA6gsumUvl0AbWmYjH/E7rVMFXN5AWq+Hi3IOmU+QegLh3PgsWOHiCb
         yitA==
X-Gm-Message-State: ANoB5pkonBCtjVQCBGXYqCp6FIYwI4b7L4mODphzdReBZ2F2xQ4ywQEo
        JOc+7lLYRMsdTnBLNA8RyevGiO4NyFE7B0sv8g3WI3fA9B7uNg==
X-Google-Smtp-Source: AA0mqf6/IdkZu5kadF32088JqVuHk6Ynk0rJMD5lJFO0Vy8e2sPaYElEELz3Sfx35JYdgQFt34agXLZBaDUu
X-Received: by 2002:a05:6808:f0f:b0:359:ad61:a76f with SMTP id m15-20020a0568080f0f00b00359ad61a76fmr232798oiw.165.1668551480937;
        Tue, 15 Nov 2022 14:31:20 -0800 (PST)
Received: from riotgames.com ([163.116.131.244])
        by smtp-relay.gmail.com with ESMTPS id em39-20020a0568705ba700b0013c12e373edsm900328oab.49.2022.11.15.14.31.20
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 14:31:20 -0800 (PST)
X-Relaying-Domain: riotgames.com
Received: by mail-io1-f69.google.com with SMTP id n8-20020a6b4108000000b006de520dc5c9so895357ioa.19
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 14:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wrx+My2LzWpvTJDHOPPdJYSCZQMa7hrsohTqH3ScK6w=;
        b=aXs36LiLuuacmYMUv4LxUJexdeTSmhfvbk9wVDlu4l5P2d0M2O4h+J0M2xx3neZtUE
         7LDqmQybjLZnQEnvIxtF7tW19gNJw8ixlQeFv97RLTXD1CdK+5WFHAZ4TpEJlVgz3Va6
         PNFNlzq2X81SSjQDFKJQ/Q5yv7aKnpvTMAwcw=
X-Received: by 2002:a02:734a:0:b0:375:7ab5:7158 with SMTP id a10-20020a02734a000000b003757ab57158mr8985235jae.160.1668551479478;
        Tue, 15 Nov 2022 14:31:19 -0800 (PST)
X-Received: by 2002:a02:734a:0:b0:375:7ab5:7158 with SMTP id
 a10-20020a02734a000000b003757ab57158mr8985216jae.160.1668551479143; Tue, 15
 Nov 2022 14:31:19 -0800 (PST)
MIME-Version: 1.0
References: <20221115030210.3159213-1-sdf@google.com> <20221115030210.3159213-2-sdf@google.com>
In-Reply-To: <20221115030210.3159213-2-sdf@google.com>
From:   Zvi Effron <zeffron@riotgames.com>
Date:   Tue, 15 Nov 2022 14:31:07 -0800
Message-ID: <CAC1LvL2Qg3jYAUPJ4GofJPBnk4HKYOuqyH_P_ZOcN45TZUzrHQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 01/11] bpf: Document XDP RX metadata
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
x-netskope-inspected: true
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 14, 2022 at 7:04 PM Stanislav Fomichev <sdf@google.com> wrote:
>
> Document all current use-cases and assumptions.
>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>  Documentation/bpf/xdp-rx-metadata.rst | 109 ++++++++++++++++++++++++++
>  1 file changed, 109 insertions(+)
>  create mode 100644 Documentation/bpf/xdp-rx-metadata.rst
>
> diff --git a/Documentation/bpf/xdp-rx-metadata.rst b/Documentation/bpf/xdp-rx-metadata.rst
> new file mode 100644
> index 000000000000..5ddaaab8de31
> --- /dev/null
> +++ b/Documentation/bpf/xdp-rx-metadata.rst
> @@ -0,0 +1,109 @@
> +===============
> +XDP RX Metadata
> +===============
> +
> +XDP programs support creating and passing custom metadata via
> +``bpf_xdp_adjust_meta``. This metadata can be consumed by the following
> +entities:
> +
> +1. ``AF_XDP`` consumer.
> +2. Kernel core stack via ``XDP_PASS``.
> +3. Another device via ``bpf_redirect_map``.

4. Other eBPF programs via eBPF tail calls.

> +
> +General Design
> +==============
> +
> +XDP has access to a set of kfuncs to manipulate the metadata. Every
> +device driver implements these kfuncs by generating BPF bytecode
> +to parse it out from the hardware descriptors. The set of kfuncs is
> +declared in ``include/net/xdp.h`` via ``XDP_METADATA_KFUNC_xxx``.
> +
> +Currently, the following kfuncs are supported. In the future, as more
> +metadata is supported, this set will grow:
> +
> +- ``bpf_xdp_metadata_rx_timestamp_supported`` returns true/false to
> +  indicate whether the device supports RX timestamps in general
> +- ``bpf_xdp_metadata_rx_timestamp`` returns packet RX timestamp or 0
> +- ``bpf_xdp_metadata_export_to_skb`` prepares metadata layout that
> +  the kernel will be able to consume. See ``bpf_redirect_map`` section
> +  below for more details.
> +
> +Within the XDP frame, the metadata layout is as follows::
> +
> +  +----------+------------------+-----------------+------+
> +  | headroom | xdp_skb_metadata | custom metadata | data |
> +  +----------+------------------+-----------------+------+
> +                                ^                 ^
> +                                |                 |
> +                      xdp_buff->data_meta   xdp_buff->data
> +
> +Where ``xdp_skb_metadata`` is the metadata prepared by
> +``bpf_xdp_metadata_export_to_skb``. And ``custom metadata``
> +is prepared by the BPF program via calls to ``bpf_xdp_adjust_meta``.
> +
> +Note that ``bpf_xdp_metadata_export_to_skb`` doesn't adjust
> +``xdp->data_meta`` pointer. To access the metadata generated
> +by ``bpf_xdp_metadata_export_to_skb`` use ``xdp_buf->skb_metadata``.
> +
> +AF_XDP
> +======
> +
> +``AF_XDP`` use-case implies that there is a contract between the BPF program
> +that redirects XDP frames into the ``XSK`` and the final consumer.
> +Thus the BPF program manually allocates a fixed number of
> +bytes out of metadata via ``bpf_xdp_adjust_meta`` and calls a subset
> +of kfuncs to populate it. User-space ``XSK`` consumer, looks
> +at ``xsk_umem__get_data() - METADATA_SIZE`` to locate its metadata.
> +
> +Here is the ``AF_XDP`` consumer layout (note missing ``data_meta`` pointer)::
> +
> +  +----------+------------------+-----------------+------+
> +  | headroom | xdp_skb_metadata | custom metadata | data |
> +  +----------+------------------+-----------------+------+
> +                                                  ^
> +                                                  |
> +                                           rx_desc->address
> +
> +XDP_PASS
> +========
> +
> +This is the path where the packets processed by the XDP program are passed
> +into the kernel. The kernel creates ``skb`` out of the ``xdp_buff`` contents.
> +Currently, every driver has a custom kernel code to parse the descriptors and
> +populate ``skb`` metadata when doing this ``xdp_buff->skb`` conversion.
> +In the future, we'd like to support a case where XDP program can override
> +some of that metadata.
> +
> +The plan of record is to make this path similar to ``bpf_redirect_map``
> +below where the program would call ``bpf_xdp_metadata_export_to_skb``,
> +override the metadata and return ``XDP_PASS``. Additional work in
> +the drivers will be required to enable this (for example, to skip
> +populating ``skb`` metadata from the descriptors when
> +``bpf_xdp_metadata_export_to_skb`` has been called).
> +
> +bpf_redirect_map
> +================
> +
> +``bpf_redirect_map`` can redirect the frame to a different device.
> +In this case we don't know ahead of time whether that final consumer
> +will further redirect to an ``XSK`` or pass it to the kernel via ``XDP_PASS``.
> +Additionally, the final consumer doesn't have access to the original
> +hardware descriptor and can't access any of the original metadata.
> +
> +To support passing metadata via ``bpf_redirect_map``, there is a
> +``bpf_xdp_metadata_export_to_skb`` kfunc that populates a subset
> +of metadata into ``xdp_buff``. The layout is defined in
> +``struct xdp_skb_metadata``.
> +
> +Mixing custom metadata and xdp_skb_metadata
> +===========================================
> +
> +For the cases of ``bpf_redirect_map``, where the final consumer isn't
> +known ahead of time, the program can store both, custom metadata
> +and ``xdp_skb_metadata`` for the kernel consumption.
> +
> +Current limitation is that the program cannot adjust ``data_meta`` (via
> +``bpf_xdp_adjust_meta``) after a call to ``bpf_xdp_metadata_export_to_skb``.
> +So it has to, first, prepare its custom metadata layout and only then,
> +optionally, store ``xdp_skb_metadata`` via a call to
> +``bpf_xdp_metadata_export_to_skb``.
> --
> 2.38.1.431.g37b22c650d-goog
>
